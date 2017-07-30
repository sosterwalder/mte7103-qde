% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/technical/geometry.py
@{# -*- coding: utf-8 -*-

"""Module holding geometrical definitions."""

# System imports
from PyQt5 import QtGui

# Project imports
from qde.editor.foundation import type as types


@<Geometrical object class@>
@<Vertex class@>
@<Geometry class@>
@<Simple vertex class@>
@}

@d Geometrical object class
@{
class GeometricalObject(object):
    """Class providing a basis for any geometrical object, containing a
    teporary value and a tag, acting as counters."""

    def __init__(self):
        self.temp = 0
        self.tag  = 0
@}

@d Vertex class
@{
class Vertex(GeometricalObject):
    """Class providing an abstraction to vertices."""

    def __init__(self):
        self.position = QtGui.QVector3D()
        self.normal   = None
        self.uv       = None
        self.color    = QtGui.QColor()
@}

@d Geometry class
@{
class Geometry(GeometricalObject):
    """Class providing an abstraction to geometrical objects."""

    def __init__(self):
        """Constructor."""
        self._type                   = types.GeometryPrimitive.TRIANGLE_LIST
        self.colour_buffer           = None
        self.face_culling_parameters = None
        self.fill_callback           = None
        self.fill_callback_params    = None
        self.index_buffer            = None
        self.index_size              = 0
        self.indices                 = []
        self.is_loading              = False
        self.is_indexed              = False
        self.is_dynamic              = False
        self.max_vertices            = 0
        self.max_indices             = 0
        self.texture                 = None
        self.used_colors             = 0
        self.used_indices            = 0
        self.used_vertices           = 0
        self.vertex_array_object     = None
        self.vertex_buffer           = None
        self.vertex_size             = 0
        self.vertex_type             = types.Vertex.FULL
        self.vertices                = []

    @@property
    def has_texture(self):
        return self.texture is not None
@}

@d Simple vertex class
@{
class SimpleVertex(GeometricalObject):
    """Class representing a simplified vertex, containing only its position and
    texture coordinates (UV)."""

    def __init__(self):
        """Constructor."""

        self.position = QtGui.QVector3D()
        self.uv       = QtGui.QVector2D()
@}

