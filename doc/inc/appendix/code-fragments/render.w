% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/gui/render.py
@{# -*- coding: utf-8 -*-

"""Module holding renderering related aspects concerning the graphical user
interface layer."""

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets


# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import type as node_types
from qde.editor.technical  import graphics
from qde.editor.technical  import render
from qde.editor.gui_domain import node as node_gui_domain


@@common.with_logger
class RenderView(QtWidgets.QOpenGLWidget):
    """The render view widget. A widget for rendering nodes."""

    OPENGL_MAJOR        = 4
    OPENGL_MINOR        = 1


    @<Render view constructor@>
    @<Render view initialize OpenGL@>
    @<Render view check for valid render target@>

    def paintGL(self):
        """Renders the currently set content."""

        self.render_current_node()

    @<Render view render current node@>

    def render_none(self):
        """Renders nothing except a solid background color."""

        color = QtGui.QColor(QtCore.Qt.cyan)
        self.gfx.set_clear_color(color)

    def render_implicit(self, node):
        """Renders the given node of type implicit."""

        self.logger.debug("Rendering implicit")
        self.render_scene(scene=None, camera=None, time=0.0)

    @<Render view render scene@>

    def resizeGL(self, w, h):
        """Gets triggered whenever the widget's view port is resized."""

        size = QtCore.QSize(w, h)
        self.gfx.size = size
        self.has_view_changed = True
        # self.update()

    def setup_render_target(self):
        """Sets up a render target."""

        # TODO: Remove current fbo?
        if not self.has_valid_render_target():
            self.render_target = self.gfx.create_fbo(self.size())

    # Slots

    @<Render view handle node selection@>
    @<Render view handle node deselection@>
@}

@d Render view constructor
@{
def __init__(self, parent=None):
    """Constructor."""

    super(RenderView, self).__init__(parent)

    self.current_node  = None
    self.render_target = None
    self.renderer      = None

    self.has_view_changed = False

    self.surface_format = QtGui.QSurfaceFormat()
    self.surface_format.setProfile(QtGui.QSurfaceFormat.CoreProfile)
    self.surface_format.setVersion(self.OPENGL_MAJOR, self.OPENGL_MINOR)

    self.version_profile = QtGui.QOpenGLVersionProfile(self.surface_format)
    self.version_profile.setProfile(QtGui.QSurfaceFormat.CoreProfile)
    self.version_profile.setVersion(self.OPENGL_MAJOR, self.OPENGL_MINOR)

    self.setFocusPolicy(QtCore.Qt.StrongFocus)
    self.setFormat(self.surface_format)
@}

@d Render view initialize OpenGL
@{
def initializeGL(self):
    """Initializes OpenGL."""

    try:
        version_functions = self.context().versionFunctions(
            self.version_profile
        )
        if version_functions is None:
            message = (
                'Could not initialize OpenGL with profile {0}'
            ).format(
                self.surface_format.version()
            )
            self.logger.fatal(message)
            raise Exception(message)

    except Exception as e:
            message = (
                'Could not initialize OpenGL with profile {0} ({1})'
            ).format(
                self.surface_format.version(),
                e
            )
            self.logger.fatal(message)
            raise Exception(message)

    self.ctx = self.context()
    self.ctx.version_functions = version_functions
    self.ctx.size = self.frameSize()
    self.gfx = graphics.Graphics.create(self.ctx, self.size())
    self.renderer = render.RayMarchingRenderer(self.ctx)

    # Seems to happen under OS X (10.11) using PyQt5.7 on an Intel
    # Iris 6100 only.
    # The main render target seem to need the ID 1, as otherwise
    # the render target is empty. Well, there _is_ data, but somehow
    # it is not usable, although it has the same properties as when
    # the render target is set up first.
    self.setup_render_target()

    color = QtGui.QColor(QtCore.Qt.black)
    self.gfx.set_clear_color(color)

    self.logger.info('Initialized OpenGL with profile {0} at ({1})'.format(
        self.surface_format.version(),
        self.size()
    ))
    self.logger.info("Size: %s", self.frameSize())

@}

@d Render view check for valid render target
@{
def has_valid_render_target(self):
    """Returns wether the render target is valid or not.

    :return: the validity of the render target.
    :rtype:  bool
    """

    if self.render_target is None:
        return False

    if self.render_target.size() != self.size():
        return False

    return True
@}

@d Render view render current node
@{
def render_current_node(self):
    """Renders the currently selected node."""

    # TODO: Process node (time-wise)
    # TODO: Set view changed to True if node has been processed/

    if self.has_view_changed:
        if self.current_node is None:
            self.render_none()
            self.logger.warn("No node set for rendering")
        elif self.current_node.type_ == node_types.NodeType.IMPLICIT:
            self.render_implicit(self.current_node)
        else:
            self.render_none()
            self.logger.warn("Rendered unknown node")

        self.has_view_changed = False
    else:
        self.logger.debug("No change, not rendering")
@}

@d Render view render scene
@{
def render_scene(self, scene, camera, time):
    """Renders the given scene using the given camera at the given time.

    :param scene: TODO
    :type scene: TODO
    :param camera: TODO
    :type camera: TODO
    :param time: TODO
    :type time: TODO
    """

    assert(time >= 0.0)

    self.renderer.render_scene(scene, camera, None, time)
    # self.renderer.render_scene(scene, camera, self.render_target, time)
    # self.copy_render_target_to_screen()
@}

@d Render view handle node selection
@{
@@QtCore.pyqtSlot(node_gui_domain.NodeViewModel)
def on_node_selected(self, node_view_model):
    """Slot that gets triggered whenever a node gets selected within the
    node graph view.

    :param node_view_model: view model of the selected node
    :type  node_view_model: qde.editor.gui_domain.node.NodeViewModel
    """

    self.logger.debug("Set selected node for rendering: %s" % node_view_model)

    # TODO: Check if node is valid
    self.current_node = node_view_model

    # TODO: Remove this and process time wise
    # This must get done in render_current_node
    self.has_view_changed = True
    self.update()
@}

@d Render view handle node deselection
@{
@@QtCore.pyqtSlot()
def on_node_deselected(self):
    """Slot that gets triggered whenever a node gets deselected within the
    node graph view.
    """

    self.current_node = None

    # TODO: Remove this and process time wise
    # This must get done in render_current_node
    self.has_view_changed = True
    self.update()
@}

@o ../src/qde/editor/technical/render.py
@{# -*- coding: utf-8 -*-

"""Module providing an abstraction layer for rendering."""

# System imports
from PyQt5 import QtCore
from PyQt5 import QtGui

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import flag
from qde.editor.foundation import type as types
from qde.editor.technical  import geometry
from qde.editor.technical  import graphics


@<Renderer class@>
@<Ray marching renderer class@>
@}

@d Renderer class
@{
@@common.with_logger
class Renderer(object):
    """Renderer base class."""

    def __init__(self, default_shader_name="default"):
        """Constructor.

        :param default_shader_name: name of the shader that gets used by default.
        :type  default_shader_name: str
        """

        gfx = graphics.Graphics.instance()
        flags = (flag.Geometry.DYNAMIC.value &
                 flag.Geometry.INDEX_BUFFER_32.value)
        self.default_geometry = gfx.add_geometry(flags, types.Vertex.SIMPLE,
                                                 types.GeometryPrimitive.QUAD_LIST)
        self.quad_geometry = gfx.add_geometry(flags, types.Vertex.SIMPLE,
                                              types.GeometryPrimitive.QUAD_LIST)

        # Set up shader(s)
        self.default_shader = gfx.add_shader(default_shader_name)
        color = QtGui.QColor(QtCore.Qt.black)
        gfx.set_clear_color(color)

    def render_scene(self, scene, camera, render_target, time):
        raise NotImplemented(
            "%s must be implemented in child class." % __name__
        )
@}

@d Ray marching renderer class
@{
class RayMarchingRenderer(Renderer):
    """Provides a ray marching renderer using sphere tracing."""

    def __init__(self, opengl_context):
        """Constructor.

        :param opengl_context: a valid OpenGL context.
        :type  opengl_context: PyQt5.QtGui.QOpenGLContext
        """

        super(RayMarchingRenderer, self).__init__(
            "sphere_tracer"
        )
        self.ctx = opengl_context

    def render_scene(self, scene, camera, render_target, time):
        """Renders the given scene using the given camera for the given render
        target.

        :param scene: TODO
        :type  scene: TODO
        :param camera: TODO
        :type  camera: TODO
        :param render_target: TODO
        :type  render_target: TODO
        :param time: TODO
        :type  time: TODO
        """

        gfx = graphics.Graphics.instance()
        gfx.render_state.shader_object = self.default_shader

        v1 = geometry.Vertex()
        v1.position = QtGui.QVector3D(-1.0, -1.0,  0.0)
        v2 = geometry.Vertex()
        v2.position = QtGui.QVector3D( 1.0, -1.0,  0.0)
        v3 = geometry.Vertex()
        v3.position = QtGui.QVector3D(-1.0,  1.0,  0.0)
        v4 = geometry.Vertex()
        v4.position = QtGui.QVector3D( 1.0,  1.0,  0.0)
        # vertices = cluster.vertices
        # indices  = cluster.indices
        vertices = [v1, v2, v3, v4]
        indices = [0, 1, 2, 2, 1, 3]
        gfx.load_geometry(self.default_geometry, vertices, indices)
        gfx.render_geometry(self.default_geometry)
@}
