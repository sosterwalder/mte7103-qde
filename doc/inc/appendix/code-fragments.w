% -*- mode: latex; coding: utf-8 -*-

\section{Code fragments}
\label{sec:code-fragments}

@o ../src/editor.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Main entry point for the QDE editor application. """

# System imports
import sys

# Project imports
from qde.editor.application import application

@<Main entry point@>
@}

@o ../src/qde/editor/application/application.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Main application module for the QDE editor."""

# System imports
import logging
import logging.config
import os
import json
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.application import node
from qde.editor.application import scene
from qde.editor.gui import main_window as qde_main_window


@<Main application declarations@>
@}

@o ../src/qde/editor/gui/main_window.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding the main application window. """

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.gui import scene as guiscene


@<Main window declarations@>
@}

@o ../src/qde/editor/domain/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the domain layer. """

# System imports
import uuid
from PyQt5 import Qt
from PyQt5 import QtCore

# Project imports


@<Scene model declarations@>
@}

@o ../src/qde/editor/gui_domain/scene.py
@{
#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the gui_domain layer. """

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore

# Project imports
from qde.editor.foundation import common

@<Scene graph view model declarations@>
@<Scene view model declarations@>
@}

@d Scene graph view model methods
@{
def __str__(self):
    """Return the string representation of the current object."""

    return str(self.id_)[0:8]
@}

@d Scene view model methods
@{
def __str__(self):
    """Return the string representation of the current object."""

    return str(self.id_)[0:8]
@}

@o ../src/qde/editor/application/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the application layer.
"""

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore

# Project imports
from qde.editor.foundation import common
from qde.editor.domain     import scene as domain_scene
from qde.editor.gui_domain import scene as guidomain_scene

@<Scene graph controller declarations@>
@<Scene controller declarations@>
@}

@o ../src/qde/editor/gui/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the graphical user interface layer.
"""

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.gui_domain import scene

@<Scene graph view declarations@>
@<Scene view declarations@>
@}

@o ../logging.json
@{{
    "version": 1,
    "disable_existing_loggers": false,
    "formatters": {
        "simple": {
            "format": "%(asctime)s - %(levelname)-7s - %(name)s.%(funcName)s::%(lineno)s: %(message)s"
        }
    },

    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "level": "DEBUG",
            "formatter": "simple",
            "stream": "ext://sys.stdout"
        },

        "info_file_handler": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "INFO",
            "formatter": "simple",
            "filename": "info.log",
            "maxBytes": 10485760,
            "backupCount": 20,
            "encoding": "utf8"
        },

        "error_file_handler": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "ERROR",
            "formatter": "simple",
            "filename": "errors.log",
            "maxBytes": 10485760,
            "backupCount": 20,
            "encoding": "utf8"
        }
    },

    "root": {
        "level": "DEBUG",
        "handlers": ["console", "info_file_handler", "error_file_handler"],
        "propagate": "no"
    }
}@}

@o ../src/qde/editor/foundation/common.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Module holding common helper methods."""

# System imports
import logging
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtWidgets

# Project imports


def with_logger(cls):
    """Add a logger instance (using a stream handler) to the given class.

    :param cls: the class which the logger shall be added to.
    :type  cls: a class of type cls.

    :return: the class with the logger instance added.
    :rtype:  a class of type cls.
    """

    @<Set logger name@>
    @<Logger interface@>
@}

@d Scene graph view decorators
@{
@@common.with_logger
@}

@o ../src/qde/editor/foundation/type.py
@{# -*- coding: utf-8 -*-
"""Module for type-specific aspects."""

# System imports
import enum

# Project imports


@<Node type declarations@>
@}

@o ../src/qde/editor/domain/parameter.py
@{# -*- coding: utf-8 -*-

"""Module for parameter-specific aspects."""

# System imports

# Project imports
from qde.editor.foundation import type as types

@<Parameter declarations@>
@}

@d Parameter declarations
@{
    FloatValue = AtomicType(
        id_="468aea9e-0a03-4e63-b6b4-8a7a76775a1a",
        type_=types.NodeType.FLOAT
    )
    Text = AtomicType(
        id_="e43bdd1b-a895-4bd8-8d5a-b401a63f7a6f",
        type_=types.NodeType.TEXT
    )
    Scene = AtomicType(
        id_="bfb47e7text7-1b05-4864-8397-de30bf005ff8",
        type_=types.NodeType.SCENE
    )
    Image = AtomicType(
        id_="21fd1960-1307-4b53-b7bf-d08f02757335",
        type_=types.NodeType.IMAGE
    )
    DynamicValue = AtomicType(
        id_="68720ae3-8068-43ce-94d8-8705dc3b8bfe",
        type_=types.NodeType.DYNAMIC
    )
    Mesh = AtomicType(
        id_="9791d341-b92c-43dd-954a-9d83b9020e43",
        type_=types.NodeType.MESH
    )
    Implicit = AtomicType(
        id_="c019271c-35b6-425c-9ff2-a1d893111adb",
        type_=types.NodeType.IMPLICIT
    )

    atomic_types = [
        FloatValue,
        Text,
        Scene,
        Image,
        DynamicValue,
        Mesh,
        Implicit,
    ]
@}



@o ../src/qde/editor/domain/node.py
@{# -*- coding: utf-8 -*-

"""Module for node-specific aspects."""

# System imports

# Project imports
from qde.editor.foundation import type as types
from qde.editor.foundation import flag

@<Node domain model declarations@>
@<Node definition domain model declarations@>
@}

@o ../src/qde/editor/gui_domain/node.py
@{# -*- coding: utf-8 -*-

""" Module holding node related aspects concerning the gui_domain layer. """

# System imports
from PyQt5 import Qt

# Project imports
from qde.editor.foundation import common

@@common.with_logger
@<Node view model declarations@>
@}

@d Node view model constructor
@{
    self.setPos(self.position)
    self.setAcceptHoverEvents(True)
    self.setFlag(QGraphicsObject.ItemIsFocusable)
    self.setFlag(QGraphicsObject.ItemIsMovable)
    self.setFlag(QGraphicsObject.ItemIsSelectable)
    self.setFlag(QGraphicsObject.ItemClipsToShape)
@}

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
@}

@d Node view model methods
@{
def boundingRect(self):
    """Return the bounding rectangle of the node.

    :return: the bounding rectangle of the node.
    :rtype: Qt.QRectF
    """

    return Qt.QRectF(
        0, 0, self.width * NodeViewModel.WIDTH, NodeViewModel.HEIGHT
    )

def create_pixmap(self):
    """Creation of the pixmap (=bitmap, the actual 'image')"""

    image = QImage(self.boundingRect().size().toSize(),
                    QImage.Format_ARGB32_Premultiplied)
    pixmap = QPixmap.fromImage(image)
    pixmap.fill(Qt.transparent)

    rect = self.boundingRect()

    painter = QPainter()
    painter.begin(pixmap)
    painter.setRenderHint(QPainter.Antialiasing)

    # Shape
    path = QPainterPath()
    path.addRect(rect)
    # path.addRoundedRect(rect, 5, 5)
    painter.drawPath(path)

    # Color / gradient
    color = QColor(255, 0, 0, 128)
    color.setHsv(color.hsvHue(), 160, 255)
    color_desaturated = color
    color_desaturated.setHsv(color.hsvHue(), 40, 255)
    top_color = QColor(60, 70, 80)
    if self.status is not flag.NodeStatus.OK:
        top_color = QColor(255, 0, 0)
    gradient_top_color = cmn.multiply_colors(
        top_color, color_desaturated
    )
    gradient_bottom_color = cmn.multiply_colors(
        QColor(110, 120, 130), color_desaturated
    )
    rect_gradient = QLinearGradient(
        QPoint(0.0, 0.0), QPoint(0.0, rect.height())
    )
    rect_gradient.setColorAt(0.0, gradient_top_color)
    rect_gradient.setColorAt(1.0, gradient_bottom_color)

    brush = QBrush(rect_gradient)

    painter.fillPath(path, brush)
    painter.end()

    return pixmap
@}

@o ../nodes/16d90b34-a728-4caa-b07d-a3244ecc87e3.node
@{@<Implicit sphere node@>@}

@o ../src/qde/editor/application/node.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding node related aspects concerning the application layer.
"""

# System imports
import glob
import os
from PyQt5 import Qt

# Project imports
from qde.editor.foundation import common
from qde.editor.domain import parameter


@<Node controller declarations@>
@}
