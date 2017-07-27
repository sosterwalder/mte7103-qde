% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/foundation/flag.py
@{# -*- coding: utf-8 -*-

"""Module for flag-specific aspects."""

# System imports
import enum

# Project imports


class NodeStatus(enum.Enum):
    """Statues which a node can have."""

    OK              = 0
    NO_INPUTS       = 1
    WRONG_INPUT     = 2
    INPUT_ERRONEOUS = 3
    INPUT_CYCLIC    = 4
    LINK_MISSING    = 5
    TOO_MANY_INPUTS = 6


class Geometry(enum.Enum):
    """Flags denoting the type of geometric buffer."""

    STATIC          = 1
    DYNAMIC         = 2
    INDEX_BUFFER_16 = 4
    INDEX_BUFFER_32 = 8


class BlendMode(enum.Enum):
    """Flags denoting the available blend modes."""

    ZERO        = 1
    ONE         = 2
    SRCCOLOR    = 3
    INVSRCCOLOR = 4
    SRCALPHA    = 5
    INVSRCALPHA = 6
    DSTALPHA    = 7
    INVDSTALPHA = 8
    DSTCOLOR    = 9
    INVDSTCOLOR = 10


class BlendOperations(enum.Enum):
    """Flags denoting the available blend operations."""
    
    ADD    = 1
    SUB    = 2
    INVSUB = 3
    MIN    = 4
    MAX    = 5


class Culling(enum.Enum):
    """Flags denoting the available modes for culling."""

    NONE  = 1
    FRONT = 2
    BACK  = 3

class Depth(enum.Enum):
    """Flags denoting the available depth modes."""

    LESS          = 1
    EQUAL         = 2
    LESS_EQUAL    = 3
    GREATER       = 4
    NOT_EQUAL     = 5
    GREATER_EQUAL = 6
    ALWAYS        = 7


class TextureMaterial(enum.Enum):
    """Flags denoting the possible filtering modes for textures."""

    NEAREST   = 1
    BILINEAR  = 2
    TRILINEAR = 4
    PCF       = 8
    WRAPX     = 16
    WRAPY     = 32
    CLAMPX    = 64
    CLAMPY    = 128
    MIRRORX   = 256
    MIRRORY   = 512
    WRAP      = WRAPX   or WRAPY
    CLAMP     = CLAMPX  or CLAMPY
    MIRROR    = MIRRORX or MIRRORY
@}

