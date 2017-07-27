% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/technical/graphics.py
@{# -*- coding: utf-8 -*-

"""Module providing an abstraction layer for graphics."""

# System imports
import jinja2
import numpy as np
import os
import sys
from PyQt5 import QtCore
from PyQt5 import QtGui

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import constant
from qde.editor.foundation import flag
from qde.editor.technical import geometry


@@common.with_logger
class Graphics(object):
    """A class providing an abstraction layer for the graphical processing
    unit."""

    __singleton_instance = None

    def __init__(self, opengl_context, size, path="data"):
        """Constructor."""

        self.ctx    = opengl_context
        self.size   = size
        self.path   = path

        self.gl     = self.ctx.version_functions
        self.width  = size.width()
        self.height = size.height()

        self.render_state   = RenderState()

        self.geometries     = []
        self.shader_objects = []

    def activate_render_state(self):
        """Clears the buffer bits and activates the render targets of the
        current rendering state."""

        self.clear()
        self.activate_render_targets()

    def activate_render_target(self, rt):
        """Activates (binds) the given render target.

        :param rt: the render target to activate/bind.
        :type rt:  TODO
        """

        if rt is not None:
            if rt.isValid() and not rt.isBound():
                rt.bind()
                self.clear()
            else:
                self.logger.warn(
                    "Render target (id=%s) is fishy, cannot bind. Valid: %s",
                    rt.handle(), rt.isValid()
                )

    def activate_render_targets(self):
        """Activates (binds) all available render targets."""

        rt = self.render_state.render_target
        self.activate_render_target(rt)

    def add_geometry(self, flags, vertex_type, primitive_type,
                     fill_callback=None, fill_callback_params=None):
        """TODO: Describe method."""

        new_geometry = geometry.Geometry()
        # TODO: Fix this!
        # new_geometry.is_dynamic = (flags & qflags.Geometry.dynamic.value)
        new_geometry.is_dynamic = True
        new_geometry.vertex_type = vertex_type
        new_geometry.primitive_type = primitive_type
        new_geometry.fill_callback = fill_callback
        new_geometry.fill_callback_params = fill_callback_params
        # TODO: Fix this!
        # geometry.is_indexed = ((flags & qflags.Geometry.index_buffer_16.value) or
        #                        (flags & qflags.Geometry.index_buffer_32.value))
        new_geometry.is_indexed = True

        # TODO: Do this dynamically!
        new_geometry.vertex_size = sys.getsizeof(geometry.SimpleVertex)
        # TODO: geometry.index_size  = ?
        new_geometry.is_loading = False
        new_geometry.used_indices = 0
        new_geometry.used_vertices = 0
        new_geometry.max_indices = 0
        new_geometry.max_vertices = 0
        new_geometry.ibo = None
        new_geometry.vbo = None

        self.geometries.append(new_geometry)

        return new_geometry

    def add_shader(self, name):
        """Creates and returns a OpenGL Shader Language (GLSL) object based on
        given files. Searches for a vertex and fragment shader templates
        matching the pattern 'given_name.vs.tpl'' and 'given_name.fs.tpl'
        respectively.

        :param name: the name of the shader and the shader template files.
        :type  name: str

        :return: a linked shader as a shader object
        :rtype:  qde.editor.technical.graphics.ShaderObject
        """

        shader_object = ShaderObject()
        path   = "{0}{1}{2}".format(
            self.path, os.path.sep, "shaders"
        )
        vertex_shader   = QtGui.QOpenGLShader(QtGui.QOpenGLShader.Vertex)
        fragment_shader = QtGui.QOpenGLShader(QtGui.QOpenGLShader.Fragment)
        program         = QtGui.QOpenGLShaderProgram(self.ctx)

        vs_tpl_name = "{0}.vs.tpl".format(name)
        vertex_shader.setObjectName(vs_tpl_name)
        fs_tpl_name = "{0}.fs.tpl".format(name)
        fragment_shader.setObjectName(fs_tpl_name)

        vs_tpl = self.load_shader_template(path, vs_tpl_name)
        fs_tpl = self.load_shader_template(path, fs_tpl_name)

        assert vertex_shader.compileSourceCode(vs_tpl.render()), \
            "Could not compile vertex shader for '%s' at '%s'" % (name, path)
        assert fragment_shader.compileSourceCode(fs_tpl.render()), \
            "Could not compile fragment shader for '%s' at '%s'" % (name, path)

        program.addShader(vertex_shader)
        program.addShader(fragment_shader)
        program.link()
        program.setObjectName(name)

        shader_object.vertex_shader = vertex_shader
        shader_object.fragment_shader = fragment_shader
        shader_object.program = program

        self.shader_objects.append(shader_object)

        return shader_object

    def clear(self):
        """Clears the color and depth buffer bits."""

        # TODO: Move this to render_state
        self.logger.debug("Clearing")
        self.gl.glClear(
            self.gl.GL_COLOR_BUFFER_BIT |
            self.gl.GL_DEPTH_BUFFER_BIT
        )

    def clear_render_state(self):
        """Clears the current render state. """

        self.render_state.depth_test = True
        self.render_state.depth_write = True
        self.render_state.depth_func = qflags.Depth.less

        self.render_state.cull_mode = qflags.Culling.back

        self.render_state.blend_source      = qflags.BlendMode.one
        self.render_state.blend_destination = qflags.BlendMode.zero
        self.render_state.blend_operation   = qflags.BlendOperations.add
        self.render_state.write_colors      = True

        tm = qflags.TextureMaterial
        flags = tm.clamp or tm.bilinear
        for i in range(qcns.Graphics.MAXIMUM_TEXTURES):
            self.render_state.texture_flags[i] = flags

        self.render_state.viewport.setWidth(self.width)
        self.render_state.viewport.setHeight(self.height)

    def create_buffer(self, buffer_type):
        """Creates a buffer object of given type.

        :param buffer_type: type of the buffer to create.
        :type  buffer_type: TODO

        :return: the created buffer object.
        :rtype:  TODO
        """

        buffer = QtGui.QOpenGLBuffer(buffer_type)
        buffer.create()

        return buffer

    def create_fbo(self, size):
        """Creates a framebuffer object with the provided size.

        :param size: size of the render target.
        :type  size: PyQt5.QtCore.QSize

        :return: the created framebuffer object.
        :rtype:  PyQt5.QtGui.QOpenGLFramebufferObject
        """

        assert(self.ctx is not None)
        assert(self.ctx.isValid())
        surface = self.ctx.surface()
        if not self.ctx.makeCurrent(surface):
            message = "Could not make surface current, no FBO created!"
            self.logger.fatal(message)
            raise Exception(message)

        format = QtGui.QOpenGLFramebufferObjectFormat()
        format.setAttachment(QtGui.QOpenGLFramebufferObject.CombinedDepthStencil)
        # TODO: Use parameter for samples
        # TODO: Use samples
        format.setSamples(0)
        width = size.width()
        height = size.height()
        buffer = QtGui.QOpenGLFramebufferObject(width, height, format)

        return buffer

    def create_ibo(self):
        """Creates a index buffer object (IBO).

        :return: the created index buffer object.
        :rtype:  TODO
        """

        ibo = self.create_buffer(QtGui.QOpenGLBuffer.IndexBuffer)

        return ibo

    def create_vao(self):
        """Creates a vertex array object (VAO).

        :return: the created vertex array object.
        :rtype:  TODO
        """

        vao = QtGui.QOpenGLVertexArrayObject()
        vao.create()

        return vao

    def create_vbo(self):
        """Creates a vertex buffer object (VBO).

        :return: the created vertex buffer object.
        :rtype:  TODO
        """

        vbo = self.create_buffer(QtGui.QOpenGLBuffer.VertexBuffer)

        return vbo


    def deactivate_render_state(self):
        """Deactivates the current render state."""

        self.deactivate_render_targets()

    def deactivate_render_target(self, rt):
        """Deactivates the given render target.

        :param rt: the render target to deactivate.
        :type  rt: TODO
        """

        if rt is not None:
            if rt.isValid() and rt.isBound():
                rt.release()
            else:
                self.logger.warn(
                    "Render target (%s) is fishy, cannot release. Valid: %s",
                    rt.handle(), rt.isValid()
                )

    def deactivate_render_targets(self):
        """Deactivates all render targets."""

        rt = self.render_state.render_target
        self.deactivate_render_target(rt)

    def load_geometry(self, geometry, vertices, indices=None, colors=None):
        """Loads the given geometry by adding vertices (optionally using
        indices) and colors.

        :param geometry: TODO
        :type geometry: TODO
        :param vertices: TODO
        :type vertices: TODO
        :param indices: TODO
        :type indices: TODO
        :param colors: TODO
        :type colors: TODO
        """

        assert(vertices is not None)
        assert(geometry.is_loading == False)

        program = self.render_state.shader_object.program

        vertex_location  = program.attributeLocation("a_position")
        if geometry.has_texture:
            texture_location = self.get_attribute_location(program,
                                                           "a_texCoords")

        geometry.is_loading    = True
        geometry.used_colors  = 0
        geometry.used_indices  = 0
        geometry.used_vertices = 0

        if indices is not None:
            geometry.is_indexed = True
        else:
            geometry.is_indexed = False
        self.logger.debug("Using indices: %s", geometry.is_indexed)
        self.logger.debug("Using texture: %s", geometry.has_texture)

        if geometry.is_dynamic:
            vertex_array = self.vertices_to_array(geometry, *vertices)
            self.logger.debug("Vertices: %s", vertex_array)
            vao = self.setup_vao(geometry)
            vbo = self.setup_vbo(geometry, vertex_array)

            program.enableAttributeArray(vertex_location)
            program.setAttributeBuffer(
                vertex_location,
                self.gl.GL_FLOAT,  # Type
                0,                 # Offset
                3,                 # Tuple size
                0                  # Stride
            )
            if geometry.is_indexed:
                self.logger.debug("Setting up IBO")
                ibo = self.setup_ibo(geometry, indices)
            if colors not in [None, []]:
                self.logger.debug("Setting up CBO")
                colors_array = self.colors_to_array(colors)
                cbo = self.setup_cbo(geometry, colors_array)
                colors_location = self.get_attribute_location(program, "a_colors")
                program.enableAttributeArray(colors_location)
                program.setAttributeBuffer(
                    colors_location,
                    self.gl.GL_FLOAT,  # Type
                    0,                 # Offset
                    4,                 # Tuple size
                    0,                 # Stride
                )
            if geometry.has_texture:
                self.logger.debug("Setting up texture buffer")
                texture_coord_location = self.get_attribute_location(program, "a_texCoords")
                program.enableAttributeArray(texture_coord_location)
                program.setAttributeBuffer(
                    texture_location,
                    self.gl.GL_FLOAT,                 # Type
                    3 * vertex_array.dtype.itemsize,  # Offset
                    2,                                # Tuple size
                    5 * vertex_array.dtype.itemsize,  # Stride
                )
            if colors not in [None, []]:
                cbo.release()
            if geometry.is_indexed:
                ibo.release()
            vbo.release()
            vao.release()

        else:
            # TODO: Handle static geometries
            self.logger.warn("Static rendering not yet implemented")

        geometry.is_loading = False

    def get_attribute_location(self, program, location):
        """Returns the location of the given attribute within the given shader
        program.


        :param program: TODO
        :type  program: TODO
        :param location: TODO
        :param location: TODO
        """

        program_location = program.attributeLocation(location)
        assert program_location > -1, \
            "Attribute '%s' not found in program '%s'" % (
                location,
                program.objectName()
            )

        return program_location

    def get_uniform_location(self, program, location):
        """Returns the location of the given uniform within the given shader
        program.


        :param program: TODO
        :type  program: TODO
        :param location: TODO
        :param location: TODO
        """

        program_location = program.uniformLocation(location)
        if program_location < 0:
            self.logger.warn("Uniform '%s' not found in program '%s'" %
                             (location, program.objectName()))

        return program_location


    def load_shader_template(self, path, tpl_name):
        """Loads a shader template by the given name from the given path in the
        Jinja2 format.

        :param path: the path of the template to load.
        :type  path: str
        :param tpl_name: the name of the template to load.
        :type  tpl_name: str

        :return: the loaded template
        :rtype:  jinja2.Template
        """

        env = jinja2.Environment(
            loader=jinja2.FileSystemLoader(path)
        )
        return env.get_template(tpl_name)

    def render_geometry(self, geometry):
        """Renders the given geometry.

        :param geometry: the geometry to render.
        :type geometry:  qde.editor.technical.geometry.Geometry
        """

        assert(geometry is not None)
        assert(not geometry.is_loading)

        if geometry.is_dynamic and geometry.fill_callback is not None:
            geometry.fill_callback(geometry, geometry.fill_callback_params)

        if not geometry.used_vertices:
            self.logger.warn("No used vertices for current geometry")
            return

        # TODO: Do this properly
        # self.gl.glMatrixMode(self.gl.GL_PROJECTION)

        self.activate_render_state()
        program = self.render_state.shader_object.program
        program.bind()
        self.logger.debug("Rendering using shader %s", program.objectName())
        vao = geometry.vertex_array_object
        vao.bind()
        vertex_location = self.get_attribute_location(program, "a_position")
        assert(vertex_location > -1)
        program.enableAttributeArray(vertex_location)

        # TODO: Do this dynamically

        resolution_location = self.get_uniform_location(program, "u_globalResolution")
        resolution = QtGui.QVector2D(self.size.width(), self.size.height())
        self.set_uniform_value(program, resolution_location, resolution)

        if geometry.colour_buffer is None:
            color_location = self.get_uniform_location(program, "u_color")
            color = QtGui.QColor(100, 80, 150, 255)
            self.set_uniform_value(program, color_location, color)

        # TODO: Set this using a camera class
        mvp_matrix_location = self.get_uniform_location(program, "u_mvpMatrix")
        # TODO: mvp_matrix = self.render_state.shader_object.shader_data.data.mvp_matrix
        mvp_matrix = QtGui.QMatrix4x4()
        mvp_matrix.setToIdentity()
        self.set_uniform_value(program, mvp_matrix_location, mvp_matrix)

        # TODO: Read from render_state / geometry
        if geometry.is_indexed:
            vao = geometry.vertex_array_object
            vao.bind()

            if geometry.has_texture:
                texture_coord_location = self.get_attribute_location(program, "a_texCoords")
                program.enableAttributeArray(texture_coord_location)
                self.gl.glActiveTexture(self.gl.GL_TEXTURE0)
                self.gl.glBindTexture(self.gl.GL_TEXTURE_2D, geometry.texture)
                texture_location = self.get_uniform_location(program, "u_texture")
                # TODO: Fix this!
                self.set_uniform_value(program, texture_location, 0)  # self.gl.GL_TEXTURE0)

            if geometry.colour_buffer is not None:
                cbo = geometry.colour_buffer
                cbo.bind()

            self.logger.debug("Rendering indexed using %d indices", geometry.used_indices)
            # self.gl.glDrawArrays(self.gl.GL_TRIANGLES, 0, geometry.used_indices)
            # self.gl.glDrawArrays(self.gl.GL_TRIANGLE_STRIP, 0, geometry.used_indices)
            self.gl.glDrawElements(
                self.gl.GL_TRIANGLES,
                geometry.used_indices,
                self.gl.GL_UNSIGNED_INT,
                geometry.indices
            )
            if geometry.has_texture:
                program.disableAttributeArray(texture_coord_location)

        else:
            self.logger.debug("Rendering non-indexed using %d vertices", geometry.used_vertices)
            self.gl.glDrawArrays(self.gl.GL_TRIANGLES, 0, geometry.used_vertices)

        vao.release()
        program.disableAttributeArray(vertex_location)
        program.release()
        self.deactivate_render_state()

    def render_implicit(self):
        """Renders implicit scenes."""

        self.activate_render_state()
        program = self.render_state.shader_object.program
        program.bind()

    def set_clear_color(self, c):
        """Sets the clear color of OpenGL to the given color.

        :param c: the color to set the clear color to.
        :type  c: PyQt5.QtGui.QColor
        """

        self.clear_color = c
        self.gl.glClearColor(c.redF(), c.greenF(), c.blueF(), c.alphaF())
        self.clear()

    def setup_ibo(self, geometry, indices):
        """Sets up a index buffer object (IBO) and assigns it to the given
        geometry.

        :param geometry: the geometry which the generated IBO will be assigned
                         to.
        :type geometry:  qde.editor.technical.geometry.Geometry
        :param indices:  a numpy float32 array holding the ordered indices.
        :type indices:   numpy.array
        :return:         the generated IBO.
        :rtype:          TODO
        """

        indices_array = np.asarray(indices, dtype=np.int16)
        assert len(indices) == np.size(indices_array)

        required_ib_size      = np.size(indices_array) * indices_array.dtype.itemsize
        geometry.index_size   = required_ib_size
        geometry.max_indices  = np.size(indices_array)
        geometry.used_indices = np.size(indices_array)
        assert geometry.used_indices == len(indices)

        if geometry.index_buffer is None:
            ibo = self.create_ibo()
            geometry.index_buffer = ibo
        else:
            ibo = geometry.index_buffer
        assert(ibo.isCreated())
        assert(ibo.bind())

        ibo.allocate(indices_array.tostring(), required_ib_size)
        assert required_ib_size == ibo.size(), \
            "Required: %s, allocated: %s"  % (required_ib_size, ibo.size())

        geometry.indices = indices

        return ibo

    def setup_vao(self, geometry):
        """Sets up a vertex array object (VAO) and assigns it to the given
        geometry.

        :param geometry: the geometry which the generated VAO will be assigned
                         to.
        :type geometry:  qde.editor.technical.geometry.Geometry
        :param vertices: a numpy float32 array holding the ordered vertices.
        :type vertices:  numpy.array

        :return:         the generated VAO.
        :rtype:          TODO
        """

        if geometry.vertex_array_object is None:
            vao = self.create_vao()
            geometry.vertex_array_object = vao
        else:
            vao = geometry.vertex_array_object
        assert(vao.isCreated())
        vao.bind()

        return vao

    def setup_vbo(self, geometry, vertices):
        """Sets up a vertex buffer object (VBO) and assigns it to the given
        geometry.

        :param geometry: the geometry which the generated VBO will be assigned
                         to.
        :type geometry:  qgeom.Geometry
        :param vertices: an numpy float32 array holding the ordered vertices.
        :type vertices:  numpy.array
        :return:         the generated VBO.
        :rtype:          QOpenGLBuffer of type QOpenGLBuffer.VertexBuffer
        """

        if geometry.has_texture:
            required_vb_size   = np.size(vertices) * 5 * vertices.dtype.itemsize
        else:
            required_vb_size   = np.size(vertices) * 3 * vertices.dtype.itemsize
        geometry.vertex_size   = required_vb_size
        geometry.max_vertices  = np.size(vertices) / 3
        geometry.used_vertices = np.size(vertices) / 3

        if geometry.vertex_buffer is None:
            vbo = self.create_vbo()
            geometry.vertex_buffer = vbo
        else:
            vbo = geometry.vertex_buffer
        assert(vbo.isCreated())
        assert(vbo.bind())

        vbo.allocate(required_vb_size)
        assert required_vb_size == vbo.size(), \
            "Required: %s, allocated: %s"  % (required_vb_size, vbo.size())
        vbo.setUsagePattern(QtGui.QOpenGLBuffer.StaticDraw)
        vbo.write(0, vertices.tostring(), len(vertices.tostring()))
        geometry.vertices = vertices

        return vbo

    def set_uniform_value(self, program, location, value):
        """Sets the given value for the given location within the provided
        shader program.

        :param program: TODO
        :type program: TODO
        :param location: TODO
        :type location: TODO
        :param value: the value to set.
        :type value: TODO
        """

        assert(program is not None)
        assert(program.isLinked())
        assert(location is not None)
        assert(value is not None)

        if location >= 0:
            program.setUniformValue(location, value)
        else:
            self.logger.warn(
                "Could not set %s at %s within %s",
                value,
                location,
                program
            )


    def vertices_to_array(self, geometry, *vertices):
        """Returns the given vertices as array.

        :param geometry: TODO
        :type geometry: TODO
        :param vertices: TODO
        :type vertices: TODO

        :return: an array containing the given vertices.
        :rtype:  np.array
        """

        temp = []

        for v in vertices:
            pos = v.position
            temp.append(pos.x())
            temp.append(pos.y())
            temp.append(pos.z())

            if geometry.has_texture and v.uv is not None:
                temp.append(v.uv.x())
                temp.append(v.uv.y())

        return np.array(temp, dtype=np.float32)

    # Slots

    # Classmethods

    @@classmethod
    def create(cls, opengl_context, path="data"):
        """Creates an instance of the graphics interface."""

        if cls.__singleton_instance is not None:
            raise Exception("Graphics was already created")

        cls.__singleton_instance = cls(opengl_context, path)
        return cls.__singleton_instance

    @@classmethod
    def instance(cls):
        """Returns the initialized singleton instance.

        :return: the singleton instance of the initialized graphics abstraction
                 object.
        :rtype:  qde.editor.technical.graphics.Graphics
        """
        assert cls.__singleton_instance is not None, \
            "Graphics were not initialized yet"
        return cls.__singleton_instance


@@common.with_logger
class RenderState(object):
    """A class representing the state of rendering."""

    def __init__(self):
        self.blend_source      = flag.BlendMode.ONE
        self.blend_destination = flag.BlendMode.ZERO
        self.blend_operation   = flag.BlendOperations.ADD
        self.cull_mode         = flag.Culling.NONE
        self.depth_func        = flag.Depth.LESS
        self.depth_test        = True
        self.depth_write       = True
        self.render_target     = None
        self.shader_object     = None
        self.textures          = []
        self.texture_flags     = {}
        self.viewport          = QtCore.QRect()
        self.write_colors      = True

        tm = flag.TextureMaterial
        flags = tm.CLAMP or tm.BILINEAR
        for i in range(constant.Graphics.MAXIMUM_TEXTURES):
            self.texture_flags[i] = flags


@@common.with_logger
class ShaderData(object):
    """A class holding GLSL shader related data."""


    class Data(object):
        """"A class for holding arbitrary structures."""

        pass

    def __init__(self, type):
        """Constructor."""

        self._type = type
        self.data  = self.Data()


@@common.with_logger
class ShaderObject(object):
    """A class representing an OpenGL Shading Language (GLSL) shader object
    containing a compute, a fragment and a vertex shader, as well as the
    shader's data an program."""

    def __init__(self):
        """Constructor."""

        self.compute_shader  = None
        self.fragment_shader = None
        self.program         = None
        self.shader_data     = None
        self.vertex_shader   = None
@}
