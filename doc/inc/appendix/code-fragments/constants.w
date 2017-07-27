% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/foundation/constant.py
@{# -*- coding: utf-8 -*-

"""Module for constants."""

# System imports
import enum

# Project imports


class Graphics(object):
    """Constants related to graphical things."""

    MAXIMUM_TEXTURES       = 5
    MAXIMUM_RENDER_TARGETS = 5


class Buffer(enum.Enum):
    """Constants for buffers."""

    VERTEX_BUFFER_DYNAMIC = 0
    INDEX_BUFFER_DYNAMIC  = 1
    FRAME_BUFFER_DYNAMIC  = 2


class ShaderData(enum.Enum):
    """Constants for shader data."""

    CAMERA = 1
@}

