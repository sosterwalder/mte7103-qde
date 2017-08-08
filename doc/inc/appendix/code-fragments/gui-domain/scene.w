% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/gui_domain/scene.py
@{
#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the gui_domain layer. """

# System imports
import uuid
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

@d Scene view model signals
@{
do_start_connection = QtCore.pyqtSignal(uuid.UUID, uuid.UUID)
do_update_connection = QtCore.pyqtSignal()
do_end_connection = QtCore.pyqtSignal(uuid.UUID, uuid.UUID)
do_abort_connection = QtCore.pyqtSignal()
@}

@d Scene view model methods
@{
def __str__(self):
    """Return the string representation of the current object."""

    return str(self.id_)[0:8]
@}

@d Scene view model methods
@{
def mouseReleaseEvent(self, event):
    self.logger.debug("Scene %s received mouse release", self)
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
        self.invalidate()
@}

@d Scene view model methods
@{
def dragMoveEvent(self, event):
    self.do_update_connection.emit()
    intersected_items = self.items(event.scenePos())
    if intersected_items:
        self.has_intersections = True
        self.logger.debug("yay!")
        super(SceneViewModel, self).dragMoveEvent(event)
    else:
        self.has_intersections = False
        self.logger.debug("Nope!")
@}

@d Scene view model methods
@{
def dropEvent(self, event):
    if not self.has_intersections:
        self.logger.debug("DROP THAT!")
        self.do_abort_connection.emit()
    super(SceneViewModel, self).dragMoveEvent(event)
@}


@d Scene view model slots
@{
@@QtCore.pyqtSlot(uuid.UUID, uuid.UUID)
def on_start_connection(self, node_view_model_id, node_connector_vm_id):

    if node_view_model_id in self.nodes:
        source_node = self.nodes[node_view_model_id]
        assert source_node is not None
        if node_connector_vm_id in source_node.inputs:
            # source_connector = source_node.inputs[node_connector_vm_id]
            self.do_start_connection.emit(node_view_model_id, node_connector_vm_id)
        elif node_connector_vm_id in source_node.outputs:
            # source_connector = source_node.outputs[node_connector_vm_id]
            self.do_start_connection.emit(node_view_model_id, node_connector_vm_id)
        else:
            self.logger.warn(
                "Given connector %s is not known to node %s!",
                node_connector_vm_id,
                source_node.id_
            )

    else:
        self.logger.warn(
            "Given node %s is not known!",
            node_view_model_id
        )
@}

@d Scene view model slots
@{
@@QtCore.pyqtSlot(uuid.UUID, uuid.UUID)
def on_end_connection(self, node_view_model_id, node_connector_vm_id):
    self.logger.debug("End connection for scene %s", self)
    if node_view_model_id in self.nodes:
        source_node = self.nodes[node_view_model_id]
        assert source_node is not None
        if node_connector_vm_id in source_node.inputs:
            # source_connector = source_node.inputs[node_connector_vm_id]
            self.do_end_connection.emit(node_view_model_id, node_connector_vm_id)
        elif node_connector_vm_id in source_node.outputs:
            # source_connector = source_node.outputs[node_connector_vm_id]
            self.do_end_connection.emit(node_view_model_id, node_connector_vm_id)
        else:
            self.logger.warn(
                "Given connector %s is not known to node %s!",
                node_connector_vm_id,
                source_node.id_
            )

    else:
        self.logger.warn(
            "Given node %s is not known!",
            node_view_model_id
        )
@}
