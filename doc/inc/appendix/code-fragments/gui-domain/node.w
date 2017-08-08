@o ../src/qde/editor/gui_domain/node.py
@{# -*- coding: utf-8 -*-

""" Module holding node related aspects concerning the gui_domain layer. """

# System imports
import math
import uuid
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import flag

@@common.with_logger
@<Node view model declarations@>
@<Node connector view model declarations@>
@<Node input view model declarations@>
@<Node output view model declarations@>
@<Node connection view model declarations@>
@}

@d Node view model signals
@{
do_select_node = QtCore.pyqtSignal(uuid.UUID)
do_deselect_node = QtCore.pyqtSignal(uuid.UUID)
do_start_connection = QtCore.pyqtSignal(uuid.UUID, uuid.UUID)
do_update_connection = QtCore.pyqtSignal()
do_end_connection = QtCore.pyqtSignal(uuid.UUID, uuid.UUID)
@}

@d Node view model constructor
@{
    self.setPos(self.position)
    self.setAcceptHoverEvents(True)
    self.setFlag(Qt.QGraphicsObject.ItemIsFocusable)
    self.setFlag(Qt.QGraphicsObject.ItemIsMovable)
    self.setFlag(Qt.QGraphicsObject.ItemIsSelectable)
    self.setFlag(Qt.QGraphicsObject.ItemClipsToShape)
@}

@d Node view model methods
@{
def __str__(self):
    """Returns the string representation of this node.

    :return: string representation of this node
    :rtype:  str
    """

    return "({0:.8})".format(
        str(self.id_)
    )
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
@}

@d Node view model methods
@{
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

@d Node view model methods
@{
def itemChange(self, change, value):
    if (change == Qt.QGraphicsItem.ItemSelectedHasChanged):
        if (value == 1):
            self.logger.debug("Node %s was selected", self)
            self.do_select_node.emit(self.id_)
        elif (value == 0):
            self.logger.debug("Node %s was deselected", self)
            self.do_deselect_node.emit(self.id_)
        else:
            self.logger.warn("Received strange value for item change")

    return super(NodeViewModel, self).itemChange(change, value)
@}

@d Node view model methods paint
@{
painter.setClipRect(option.exposedRect)
painter.drawPixmap(0, 0, pixmap)

if self.isSelected():
    color = QtGui.QColor(23, 135, 84)
    painter.setPen(color)
    painter.setBrush(QtGui.QBrush(color, QtCore.Qt.SolidPattern))
    painter.drawRect(
        0,
        self.boundingRect().height() - 2,
        self.boundingRect().width(),
        self.boundingRect().height()
    )

# TODO: Use another color if bypassed or hidden
painter.setPen(QtCore.Qt.white)

# Label
painter.drawText(self.boundingRect().adjusted(1, -9, -9, -1), QtCore.Qt.AlignCenter, self.name)
painter.drawText(self.boundingRect().adjusted(1, 20, -9, -1), QtCore.Qt.AlignCenter, self.type_.name)
@}

@d Node view model slots
@{
@@QtCore.pyqtSlot(uuid.UUID)
def on_select_connector(self, connector_vm_id):
    """Slot that gets triggered when a connector of the node gets selected.
    """

    self.logger.debug("Connector of node %s got selected", self)
    self.do_start_connection.emit(self.id_, connector_vm_id)
@}

@d Node view model slots
@{
@@QtCore.pyqtSlot()
def on_update_connector(self):
    """Slot that gets triggered when a connector of the node gets updated
    (=dragged).
    """

    self.logger.debug("Connector of node %s got updated", self)
    self.do_update_connection.emit()
@}

@d Node view model slots
@{
@@QtCore.pyqtSlot(uuid.UUID)
def on_deselect_connector(self, connector_vm_id):
    """Slot that gets triggered when a connector of the node gets deselected.
    """

    self.logger.debug("Connector of node %s got deselected", self)
    self.do_end_connection.emit(self.id_, connector_vm_id)
    self.logger.debug("Node %s (%s) emitted do_end_connection", self, type(self))
@}

@d Node connector view model declarations
@{
@@common.with_logger
class NodeConnectorViewModel(Qt.QGraphicsObject):
    """Class representing a connector of a node within GUI."""

    # Constants
    WIDTH  = 15
    HEIGHT = 15
    OFFSET = 4

    # Signals
    @<Node connector view model signals@>

    @<Node connector view model constructor@>

    @<Node connector view model methods@>

    # Slots
    @<Node connector view model slots@>
@}

@d Node connector view model signals
@{
do_select_connector   = QtCore.pyqtSignal(uuid.UUID)
do_update_connector   = QtCore.pyqtSignal()
do_deselect_connector = QtCore.pyqtSignal(uuid.UUID)
@}

@d Node connector view model constructor
@{
def __init__(self, name, parent):
    """Constructor.

    :param name: the name of the node connector.
    :type  name: str
    :param parent: the parent of the node connector.
    :type  parent: qde.editor.gui_domain.node.NodeViewModel
    """

    super(NodeConnectorViewModel, self).__init__(parent)

    self.id_ = uuid.uuid4()

    self.setAcceptHoverEvents(True)
    self.setAcceptDrops(True)

    self.setFlag(Qt.QGraphicsObject.ItemIsFocusable)
    self.setFlag(Qt.QGraphicsObject.ItemIsSelectable)

    self.setToolTip(name)

    self.do_select_connector.connect(
        parent.on_select_connector
    )
    self.do_update_connector.connect(
        parent.on_update_connector
    )
    self.do_deselect_connector.connect(
        parent.on_deselect_connector
    )
@}

@d Node connector view model methods
@{
def __str__(self):
    """Returns the string representation of this connector.

    :return: string representation of this connector
    :rtype:  str
    """

    return "({0:.8})".format(
        str(self.id_)
    )
@}

@d Node connector view model methods
@{
def boundingRect(self):
    """Return the bounding rectangle of the connector.

    :return: the bounding rectangle of the connector.
    :rtype: Qt.QRectF
    """

    rect = Qt.QRectF(
        0, 0,
        self.WIDTH, self.HEIGHT
    )
    return rect
@}

@d Node connector view model methods
@{
def paint(self, painter, option, widget):
    """Paint the connector.
    """


    painter.setPen(QtCore.Qt.NoPen)
    painter.setBrush(QtCore.Qt.darkGray)
    painter.drawEllipse(self.boundingRect())

    is_sunken = option.state & QtWidgets.QStyle.State_Sunken
    gradient = QtGui.QRadialGradient(self.WIDTH / 2, self.HEIGHT / 2, self.WIDTH / 2)
    if is_sunken:
        gradient.setCenter(self.WIDTH / 2, self.HEIGHT / 2)
        gradient.setFocalPoint(self.WIDTH / 2, self.HEIGHT / 2)
        color_light = QtGui.QColor(QtCore.Qt.darkGray).lighter(120)
        gradient.setColorAt(1, color_light)
        color_dark = QtGui.QColor(QtCore.Qt.gray).lighter(120)
        gradient.setColorAt(0, color_dark)
        painter.setBrush(gradient)
    else:
        gradient.setColorAt(0, QtCore.Qt.darkGray)
        gradient.setColorAt(1, QtCore.Qt.gray)
        painter.setBrush(gradient)

    painter.setPen(QtGui.QPen(QtCore.Qt.black, 0))
    painter.drawEllipse(self.boundingRect())
@}

@d Node connector view model methods
@{
def shape(self):
    """Defines the shape of the connector."""

    path = QtGui.QPainterPath()
    path.addEllipse(self.boundingRect())

    return path
@}

@d Node connector view model methods
@{
def mousePressEvent(self, event):
    self.logger.debug("Mouse press event over connector %s (%s)", self, event.isAccepted())
    super(NodeConnectorViewModel, self).mousePressEvent(event)
    self.do_select_connector.emit(self.id_)
    self.update()
@}

@d Node connector view model methods
@{
def mouseMoveEvent(self, event):
    self.logger.debug("Mouse move event for connector %s", self)

    super(NodeConnectorViewModel, self).mouseMoveEvent(event)

    drag = QtGui.QDrag(event.widget())
    mime = QtCore.QMimeData()
    drag.setMimeData(mime)
    drag.exec()
@}

@d Node connector view model methods
@{
def mouseReleaseEvent(self, event):
    self.logger.debug("Mouse release event for connector %s", self)
    self.do_deselect_connector.emit(self.id_)
    self.update()
    super(NodeConnectorViewModel, self).mouseReleaseEvent(event)
@}

@d Node connector view model methods
@{
def dragEnterEvent(self, event):
    self.logger.debug("Mouse drag enter event for connector %s", self)
    super(NodeConnectorViewModel, self).dragEnterEvent(event)
@}

@d Node connector view model methods
@{
def dragMoveEvent(self, event):
    self.do_update_connector.emit()
    self.logger.debug("Mouse drag move event for connector %s", self)
    event.setAccepted(True)
    super(NodeConnectorViewModel, self).dragMoveEvent(event)
@}

@d Node connector view model methods
@{
def dragLeaveEvent(self, event):
    self.logger.debug("Mouse drag leave event for connector %s", self)
    super(NodeConnectorViewModel, self).dragLeaveEvent(event)
@}

@d Node connector view model methods
@{
def dropEvent(self, event):
    self.logger.debug("Mouse drop event for connector %s", self)
    self.do_deselect_connector.emit(self.id_)
    event.setAccepted(True)
    super(NodeConnectorViewModel, self).dropEvent(event)
@}

%--------- Node input view model

@d Node input view model declarations
@{
class NodeInputViewModel(NodeConnectorViewModel):
    """Class representing the input connector of a node within GUI."""

    # Constants

    # Signals
    @<Node input view model signals@>

    @<Node input view model constructor@>

    @<Node input view model methods@>

    # Slots
    @<Node input view model slots@>
@}

@d Node input view model constructor
@{
def __init__(self, name, parent):
    """
    Constructor.

    :param name: the name of the node input.
    :type  name: str
    :param parent: the parent of the node input.
    :type  parent: qde.editor.gui_domain.node.NodeViewModel
    """

    super(NodeInputViewModel, self).__init__(name, parent)
    self.setPos(self.OFFSET, self.OFFSET)
@}

%--------- Node output view model

@d Node output view model declarations
@{
class NodeOutputViewModel(NodeConnectorViewModel):
    """Class representing the output connector of a node within GUI."""

    # Constants

    # Signals
    @<Node output view model signals@>

    @<Node output view model constructor@>

    @<Node output view model methods@>

    # Slots
    @<Node output view model slots@>
@}

@d Node output view model constructor
@{
def __init__(self, name, parent):
    """
    Constructor.
    """

    super(NodeOutputViewModel, self).__init__(name, parent)

    self.setPos(
        parent.width - self.WIDTH - self.OFFSET,
        0 + self.OFFSET
    )
@}

%--------- Node connection view model

@d Node connection view model declarations
@{
@@common.with_logger
class NodeConnectionViewModel(Qt.QGraphicsObject):
    """Class representing the output connector of a node within GUI."""

    # Constants

    # Signals
    @<Node connection view model signals@>

    @<Node connection view model constructor@>

    @<Node connection view model methods@>

    # Slots
    @<Node connection view model slots@>
@}

@d Node connection view model constructor
@{
def __init__(self, source, parent=None):
    """
    Constructor.
    """

    super(NodeConnectionViewModel, self).__init__(parent)

    self.source = source
    self.target = QtCore.QPoint()
@}

@d Node connection view model methods
@{
def boundingRect(self):
    """Return the bounding rectangle of the connection.

    :return: the bounding rectangle of the connection.
    :rtype: Qt.QRectF
    """

    delta = self.target - self.source

    return Qt.QRectF(
        0, 0,
        math.fabs(delta.x()), math.fabs(delta.y())
    )
@}

@d Node connection view model methods
@{
def paint(self, painter, option, widget):
    """Paint the connection.
    """

    # self.logger.debug("Drawing path from %s to %s", self.source, self.target)
    path = QtGui.QPainterPath()
    path.moveTo(self.source)
    c1 = self.source - QtCore.QPoint(5, 5)
    c2 = self.target + QtCore.QPoint(5, 5)
    path.cubicTo(c1, c2, self.target)
    painter.drawPath(path)
@}
