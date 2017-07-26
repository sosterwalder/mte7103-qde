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
from PyQt5 import Qt
from PyQt5 import QtCore
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
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.gui_domain import node as node_gui_domain

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
from qde.editor.domain     import node  as node_domain
from qde.editor.gui_domain import node  as node_gui_domain
from qde.editor.domain     import scene as scene_domain
from qde.editor.gui_domain import scene as scene_gui_domain

@<Scene graph controller declarations@>
@<Scene controller declarations@>
@}

@o ../src/qde/editor/gui/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the graphical user interface layer.
"""

# System imports
import uuid
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.gui_domain import node as node_gui_domain
from qde.editor.gui_domain import scene
from qde.editor.gui import node

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
from PyQt5 import QtGui
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

@<Common methods@>
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
@<Node part state changed declarations@>
@}

@o ../src/qde/editor/domain/parameter.py
@{# -*- coding: utf-8 -*-

"""Module for parameter-specific aspects."""

# System imports

# Project imports
from qde.editor.foundation import type as types
from qde.editor.domain import node

@<Parameter declarations@>
@<Paramater domain model value generic interface@>
@<Paramater domain model value interface@>
@<Paramater domain model float value@>
@<Paramater domain model text value@>
@<Paramater domain model scene value@>
@<Paramater domain model implicit value@>
@<Parameter domain module methods@>
@}

@d Parameter declarations
@{
    FloatValue = create_node_definition_part.__func__(
        id_="468aea9e-0a03-4e63-b6b4-8a7a76775a1a",
        type_=types.NodeType.FLOAT
    )
    Text = create_node_definition_part.__func__(
        id_="e43bdd1b-a895-4bd8-8d5a-b401a63f7a6f",
        type_=types.NodeType.TEXT
    )
    Scene = create_node_definition_part.__func__(
        id_="bfb47e7text7-1b05-4864-8397-de30bf005ff8",
        type_=types.NodeType.SCENE
    )
    Image = create_node_definition_part.__func__(
        id_="21fd1960-1307-4b53-b7bf-d08f02757335",
        type_=types.NodeType.IMAGE
    )
    DynamicValue = create_node_definition_part.__func__(
        id_="68720ae3-8068-43ce-94d8-8705dc3b8bfe",
        type_=types.NodeType.DYNAMIC
    )
    Mesh = create_node_definition_part.__func__(
        id_="9791d341-b92c-43dd-954a-9d83b9020e43",
        type_=types.NodeType.MESH
    )
    Implicit = create_node_definition_part.__func__(
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

@d Paramater domain model text value
@{
class TextValue(Value):
    """A class holding values for text/string nodes."""

    def __init__(self, string_value):
        """Constructor.

        :param string_value: the string value that shall be held
        :type  string_value: str
        """

        super(TextValue, self).__init__(string_value)
        self.function_type = types.NodeType.TEXT

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return TextValue(self.value)@}

@d Paramater domain model image value
@{
class ImageValue(ValueInterface):
    """A class holding values for image nodes."""

    def __init__(self):
        """Constructor."""

        super(ImageValue, self).__init__()
        self.function_type = types.NodeType.IMAGE

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return ImageValue()@}

@d Paramater domain model generic value
@{
class GenericValue(ValueInterface):
    """A class holding values for generic nodes."""

    def __init__(self):
        """Constructor."""

        super(GenericValue, self).__init__()
        self.function_type = types.NodeType.GENERIC

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return GenericValue()@}

@d Paramater domain model dynamic value
@{
class DynamicValue(ValueInterface):
    """A class holding values for dynamic nodes."""

    def __init__(self):
        """Constructor."""

        super(DynamicValue, self).__init__()
        self.function_type = types.NodeType.DYNAMIC

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return DynamicValue()@}

@d Paramater domain model mesh value
@{
class MeshValue(ValueInterface):
    """A class holding values for mesh nodes."""

    def __init__(self):
        """Constructor."""

        super(MeshValue, self).__init__()
        self.function_type = types.NodeType.MESH

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return MeshValue()@}

@d Paramater domain model implicit value
@{
class ImplicitValue(ValueInterface):
    """A class holding values for implicit surface nodes."""

    def __init__(self):
        """Constructor."""

        super(ImplicitValue, self).__init__()
        self.function_type = types.NodeType.IMPLICIT

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return ImplicitValue()@}


@o ../src/qde/editor/domain/node.py
@{# -*- coding: utf-8 -*-

"""Module for node-specific aspects."""

# System imports

# Project imports
from qde.editor.foundation import type as types
from qde.editor.foundation import flag

@<Node domain model declarations@>
@<Node part domain model declarations@>
@<Node definition domain model declarations@>
@<Node definition part domain model declarations@>
@<Node definition input domain model declarations@>
@<Node definition output domain model declarations@>
@<Node definition connection domain model declarations@>
@<Node definition definition domain model declarations@>
@<Node definition invocation domain model declarations@>
@<Node domain module methods@>
@}

@o ../src/qde/editor/gui_domain/node.py
@{# -*- coding: utf-8 -*-

""" Module holding node related aspects concerning the gui_domain layer. """

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import flag

@@common.with_logger
@<Node view model declarations@>
@}

@d Node view model constructor
@{
    self.setPos(self.position)
    self.setAcceptHoverEvents(True)
    self.setFlag(Qt.QGraphicsObject.ItemIsFocusable)
    self.setFlag(Qt.QGraphicsObject.ItemIsMovable)
    self.setFlag(Qt.QGraphicsObject.ItemIsSelectable)
    self.setFlag(Qt.QGraphicsObject.ItemClipsToShape)@}

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
        0, 0, self.width, self.height
    )

def create_pixmap(self):
    """"Creation of the pixmap (=bitmap, the actual 'image')"""

    image = QtGui.QImage(self.boundingRect().size().toSize(),
                         QtGui.QImage.Format_ARGB32_Premultiplied)
    pixmap = QtGui.QPixmap.fromImage(image)
    pixmap.fill(QtCore.Qt.transparent)

    rect = self.boundingRect()

    painter = QtGui.QPainter()
    painter.begin(pixmap)
    painter.setRenderHint(QtGui.QPainter.Antialiasing)

    # Shape
    path = QtGui.QPainterPath()
    path.addRect(rect)
    # path.addRoundedRect(rect, 5, 5)
    painter.drawPath(path)

    # Color / gradient
    color = QtGui.QColor(255, 0, 0, 128)
    color.setHsv(color.hsvHue(), 160, 255)
    color_desaturated = color
    color_desaturated.setHsv(color.hsvHue(), 40, 255)
    top_color = QtGui.QColor(60, 70, 80)
    if self.status is not flag.NodeStatus.OK:
        top_color = QtGui.QColor(255, 0, 0)
    gradient_top_color = common.multiply_colors(
        top_color, color_desaturated
    )
    gradient_bottom_color = common.multiply_colors(
        QtGui.QColor(110, 120, 130), color_desaturated
    )
    rect_gradient = QtGui.QLinearGradient(
        QtCore.QPoint(0.0, 0.0), QtCore.QPoint(0.0, rect.height())
    )
    rect_gradient.setColorAt(0.0, gradient_top_color)
    rect_gradient.setColorAt(1.0, gradient_bottom_color)

    brush = QtGui.QBrush(rect_gradient)

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
import inspect
import os
import time
import uuid
from PyQt5 import Qt
from PyQt5 import QtCore

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import type as types
from qde.editor.technical  import json
from qde.editor.domain     import parameter
from qde.editor.domain     import node as node_domain
from qde.editor.gui_domain import node as node_gui_domain


@<Node controller declarations@>
@}

@o ../src/qde/editor/technical/json.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding JSON related aspects.
"""

# System imports
import json
import uuid

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import type as types
from qde.editor.domain import node
from qde.editor.domain import parameter


@<JSON module declarations@>
@}

@d JSON module declarations
@{
@@common.with_logger
class Json(object):
    """Class handling JSON relevant tasks.
    """

    @<JSON methods@>
@}

@d Node definition connection domain model declarations
@{
class NodeDefinitionConnection(object):
    """Represents a connection of a definition of a node."""

    # Signals
    @<Node definition connection domain model signals@>

    def __init__(self,
                 source_node_id, source_part_id,
                 target_node_id, target_part_id):
        """Constructor.

        :param source_node_id: the identifier of the source node.
        :type  source_node_id: uuid.uuid4
        :param source_part_id: the identifier of the part of the source node.
        :type  source_part_id: uuid.uuid4
        :param target_node_id: the identifier of the target node.
        :type  target_node_id: uuid.uuid4
        :param target_part_id: the identifier of the part of the target node.
        :type  target_part_id: uuid.uuid4
        """

        self.source_node_id = source_node_id
        self.source_part_id = source_part_id
        self.target_node_id = target_node_id
        self.target_part_id = target_part_id@}

@d JSON methods
@{
@@classmethod
def build_node_definition_connection(cls, json_input):
    """Builds and returns a connection for a node definition from the given
    JSON input data.

    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: the connection of a node definition.
    :rtype:  qde.editor.domain.node.NodeDefinitionConnection
    """

    source_node_id = uuid.UUID(json_input['source_node'])
    source_part_id = uuid.UUID(json_input['source_part'])
    target_node_id = uuid.UUID(json_input['target_node'])
    target_part_id = uuid.UUID(json_input['target_part'])

    node_definition_connection = node.NodeDefinitionConnection(
        source_node_id,
        source_part_id,
        target_node_id,
        target_part_id
    )

    cls.logger.debug("Built node definition connection")
    return node_definition_connection
@}

@d Node definition definition domain model declarations
@{
class NodeDefinitionDefinition(object):
    """Represents a definition part of a definition of a node."""

    def __init__(self, id_, script):
        """Constructor.

        :param id_: the globally unique identifier of the definition.
        :type  id_: uuid.uuid4
        :param script: the script part of the definition.
        :param script: str
        """

        self.id_ = id_
        self.script = script@}

@d JSON methods
@{
@@classmethod
def build_node_definition_definition(cls, json_input):
    """Builds and returns a definition for a node definition from the given
    JSON input data.

    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: the definition of a node definition.
    :rtype:  qde.editor.domain.node.NodeDefinitionDefinition
    """

    definition_id = uuid.UUID(json_input['id_'])
    script        = str(json_input['script'])

    node_definition_definition = node.NodeDefinitionDefinition(
        definition_id,
        script
    )

    cls.logger.debug("Built node definition definition")
    return node_definition_definition
@}

@d Node definition invocation domain model declarations
@{
class NodeDefinitionInvocation(object):
    """Represents an invocation of a definition of a node."""

    def __init__(self, id_, script):
        """Constructor.

        :param id_: the globally unique identifier of the definition.
        :type  id_: uuid.uuid4
        :param script: the script part of the invocation.
        :param script: str
        """

        self.id_ = id_
        self.script = script@}

@d JSON methods
@{
@@classmethod
def build_node_definition_invocation(cls, json_input):
    """Builds and returns a invocation for a node definition from the given
    JSON input data.

    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: the invocation of a node definition.
    :rtype:  qde.editor.domain.node.NodeDefinitionInvocation
    """

    invocation_id = uuid.UUID(json_input['id_'])
    script        = str(json_input['script'])

    node_definition_invocation = node.NodeDefinitionInvocation(
        invocation_id,
        script
    )

    cls.logger.debug("Built node definition invocation")
    return node_definition_invocation
@}

@o ../src/qde/editor/gui/node.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Module holding node related aspects."""

# System imports
import functools
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.gui_domain import node   as node_gui_domain
from qde.editor.gui_domain import helper as gui_helper


@<Add node dialog declarations@>
@}

@o ../src/qde/editor/gui_domain/helper.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Module holding graphical user interface related helper classes and
methods."""

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project importss
from qde.editor.foundation import common
from qde.editor.gui_domain import node


@@common.with_logger
class ClickableLabel(QtWidgets.QLabel):
    """Class providing a label object which emits a signal called 'clicked'
    when receiving a mouse press event."""

    # Signals
    do_add_node = QtCore.pyqtSignal()

    def __init__(self, text, parent):
        """Constructor.

        :param text: the text, that the label will show.
        :type text: str
        :param parent: the parent object of this label.
        :type parent: Qt.QObject
        """

        super(ClickableLabel, self).__init__(text, parent)
        parent.installEventFilter(self)
        label_font = QtGui.QFont()
        label_font.setFamily(label_font.defaultFamily())
        self.setFont(label_font)
        self.logger.debug(self.font())

    def eventFilter(self, object, event):
        if event.type() == QtCore.QEvent.Enter:
            font = self.font()
            font.setUnderline(True)
            self.setFont(font)
            return True
        elif event.type() == QtCore.QEvent.Leave:
            font = self.font()
            font.setUnderline(False)
            self.setFont(font)
            return True

        return False

    def mousePressEvent(self, event):
        """Event handler when a mouse button was pressed on this label. Emits a
        signal called 'do_add_node'.

        :param event: the event which occurred.
        :type event: Qt.QMouseEvent
        """

        self.do_add_node.emit()
        super(ClickableLabel, self).mousePressEvent(event)
@}

@d Scene view signals
@{
do_add_node = QtCore.pyqtSignal(uuid.UUID)@}

% Coming from: Scene view methods
@d Handle node definition chosen
@{
node_definition_vm = self.add_node_dialog.chosen_node_definition
self.logger.debug(
    "Node instance shall be added: %s",
    node_definition_vm
)
self.do_add_node.emit(node_definition_vm.id_)@}

@d Node controller signals
@{
do_add_node_model = QtCore.pyqtSignal(node_domain.NodeModel, node_gui_domain.NodeViewModel)@}

@d Node controller slots
@{
@@QtCore.pyqtSlot(uuid.UUID)
def on_node_added(self, id):
    if id in self.node_definitions:
        node_definitions = self.node_definitions[id]

        domain_model = node_definitions[0]
        view_model   = node_definitions[1]

        # Create node domain model
        node_domain_model = node_domain.NodeModel(
            id_=domain_model.id_,
            name=domain_model.name
        )

        inputs = []
        for input in domain_model.inputs:
            self.logger.debug("Creating input %s", input.id_)
            input = node_domain.NodePart(input.id_, input.default_function)
            inputs.append(input)
        node_domain_model.inputs = inputs

        outputs = []
        for output in domain_model.outputs:
            self.logger.debug("Creating output %s of type %s", output.id_, output.type_)
            value = parameter.create_value(
                output.type_.name, ""
            )
            value_function = node_domain.create_value_function(value)
            output = node_domain.NodePart(output.id_, value_function, output.type_)
            outputs.append(output)
        node_domain_model.outputs = outputs

        # Create node view model
        node_view_model = node_gui_domain.NodeViewModel(
            id_=node_domain_model.id_,
            domain_object=node_domain_model
        )

        # Inform other components about creation
        self.do_add_node_model.emit(node_domain_model, node_view_model)
        self.logger.debug("Added new node %s" % (node_domain_model))
    else:
        self.logger.warn("%s: Node definition %s not found!" % (__name__, id))@}

@d Connect main window components
@{
self.main_window.scene_view.do_add_node.connect(
    self.node_controller.on_node_added
)
self.node_controller.do_add_node_model.connect(
    self.scene_controller.on_node_model_added
)@}

@d Scene controller slots
@{
@@QtCore.pyqtSlot(node_domain.NodeModel, node_gui_domain.NodeViewModel)
def on_node_model_added(self, node_domain_model, node_view_model):
    self.logger.debug("Shall add node domain model: %s", node_domain_model)

    assert self.current_scene is not None

    # Add node view model to scene view model
    self.current_scene.addItem(node_view_model)
    insert_pos_x = self.current_scene.insert_at.x() * node_gui_domain.NodeViewModel.WIDTH
    insert_pos_y = self.current_scene.insert_at.y() * node_gui_domain.NodeViewModel.HEIGHT
    node_view_model.setPos(insert_pos_x, insert_pos_y)

    # Add node domain model to scene domain model
    self.current_scene.nodes.append(node_domain_model)

    self.logger.debug(
        "Node instance '%s' was added to current scene (%s) at %s",
        node_view_model,
        self.current_scene,
        node_view_model.pos()
    )
    # TODO
    # self.node_added.emit(self.current_scene)@}

@d Common methods
@{
def multiply_colors(color1, color2):
    red   = (color1.redF()   * color2.redF()  ) * 255
    blue  = (color1.blueF()  * color2.blueF() ) * 255
    green = (color1.greenF() * color2.greenF()) * 255

    return QtGui.QColor(red, blue, green)
@}

@d Node view model methods paint
@{
painter.setClipRect(option.exposedRect)
painter.drawPixmap(0, 0, pixmap)

if self.isSelected():
    color = QtGui.QColor(23, 135, 84)
    painter.setPen(color)
    painter.setBrush(QtGui.QBrush(color, QtCore.Qt.SolidPattern))
    painter.drawRect(0, 0, 2, self.boundingRect().height())

# TODO: Use another color if bypassed or hidden
painter.setPen(QtCore.Qt.white)

# Label
painter.drawText(self.boundingRect().adjusted(1, -9, -9, -1), QtCore.Qt.AlignCenter, self.name)
painter.drawText(self.boundingRect().adjusted(1, 20, -9, -1), QtCore.Qt.AlignCenter, self.type_.name)@}

@d Scene view model methods
@{
def mouseReleaseEvent(self, event):
    super(SceneViewModel, self).mouseReleaseEvent(event)

    # TODO: Check boundary conditions
    # * Boundaries of scene
    # * Other nodes

    if (
            event.button() & QtCore.Qt.LeftButton
    ):
        new_x = event.scenePos().x() / node_gui_domain.NodeViewModel.WIDTH
        new_y = event.scenePos().y() / node_gui_domain.NodeViewModel.HEIGHT
        self.insert_at.setX(new_x)
        self.insert_at.setY(new_y)
        self.logger.debug(
            "Set insert at to %s, %s",
            new_x, new_y
        )
        self.invalidate()@}

@d Paramater domain model implicit value
@{
class ImplicitValue(ValueInterface):
    """A class holding values for implicit types."""

    def __init__(self):
        """Constructor."""

        super(ImplicitValue, self).__init__()
        self.function_type = types.NodeType.IMPLICIT

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return ImplicitValue()@}

@d Node definition output domain model methods
@{
@@property
def type_(self):
    """Returns the type of the node definition output.

    :return: the type of the output given by the node definition part
    :rtype:  qde.editor.foundation.types.NodeType
    """

    return self.node_definition_part.type_
@}