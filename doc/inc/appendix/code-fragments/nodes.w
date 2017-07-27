% -*- mode: poly-latex+python; coding: utf-8 -*-

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

        definitions = []
        for definition in domain_model.definitions:
            self.logger.debug("Creating definition %s", definition.id_)
            value = parameter.create_value(
                types.NodeType.FLOAT.name, 0.0
            )
            value_function = node_domain.create_value_function(value)
            definition = node_domain.NodePart(definition.id_, value_function, types.NodeType.FLOAT, definition.script)
            definitions.append(definition)
        node_domain_model.definitions = definition

        invocations = []
        for invocation in domain_model.invocations:
            self.logger.debug("Creating invocation %s", invocation.id_)
            value = parameter.create_value(
                types.NodeType.FLOAT.name, 0.0
            )
            value_function = node_domain.create_value_function(value)
            invocation = node_domain.NodePart(invocation.id_, value_function, types.NodeType.FLOAT, invocation.script)
            invocations.append(invocation)
        node_domain_model.invocations = invocations

        parts = []
        for part in domain_model.parts:
            self.logger.debug("Creating part %s", part.id_)
            value = parameter.create_value(
                output.type_.name, ""
            )
            value_function = node_domain.create_value_function(value)
            part = node_domain.NodePart(part.id_, value_function, part.type_)
            parts.append(output)
        node_domain_model.parts = parts

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

@d Node view model methods paint
@{
painter.setClipRect(option.exposedRect)
painter.drawPixmap(0, 0, pixmap)

if self.isSelected():
    color = QtGui.QColor(23, 135, 84)
    painter.setPen(color)
    painter.setBrush(QtGui.QBrush(color, QtCore.Qt.SolidPattern))
    painter.drawRect(0, self.boundingRect().height() - 2, self.boundingRect().width(), self.boundingRect().height())

# TODO: Use another color if bypassed or hidden
painter.setPen(QtCore.Qt.white)

# Label
painter.drawText(self.boundingRect().adjusted(1, -9, -9, -1), QtCore.Qt.AlignCenter, self.name)
painter.drawText(self.boundingRect().adjusted(1, 20, -9, -1), QtCore.Qt.AlignCenter, self.type_.name)@}

@d Node definition output domain model methods
@{
@@property
def type_(self):
    """returns the type of the node definition output.

    :return: the type of the output given by the node definition part
    :rtype:  qde.editor.foundation.types.nodetype
    """

    return self.node_definition_part.type_
@}

@d Node view model signals
@{do_select_node = QtCore.pyqtSignal()
do_deselect_node = QtCore.pyqtSignal()@}

@d Node view model methods
@{
def mouseReleaseEvent(self, event):
    """Event that gets triggered when the mouse was released over the current
    node.

    :param event: the event.
    :type  event: PyQt5.QtGui.QMouseEvent
    """

    self.setSelected(self.isSelected())
    if self.isSelected():
        self.logger.debug("Node %s was selected", self.id_)
        self.do_select_node.emit()
    super(NodeViewModel, self).mouseReleaseEvent(event)

def itemChange(self, change, value):
    if (change == Qt.QGraphicsItem.ItemSelectedHasChanged):
        self.logger.debug("Node %s was deselected", self.id_)
        self.do_deselect_node.emit()

    return super(NodeViewModel, self).itemChange(change, value)
@}