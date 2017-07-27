% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/foundation/type.py
@{# -*- coding: utf-8 -*-
"""Module for type-specific aspects."""

# System imports
import enum

# Project imports


@<Node type declarations@>
@<Node part state changed declarations@>


class Vertex(enum.Enum):
    """Possible types of vertices."""

    FULL     = 0
    SIMPLE   = 1
    PARTICLE = 2
    INSTANCE = 3


class GeometryPrimitive(enum.Enum):
    """Possible types of geometrical primitives."""

    TRIANGLE_LIST   = 0
    QUAD_LIST       = 1
    LINE_LIST       = 2
    SPRITE_LIST     = 3
    TRIANGLE_STRIPS = 4
    LINE_STRIPS     = 5
@}
