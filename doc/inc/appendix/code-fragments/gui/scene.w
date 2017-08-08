% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/gui/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the graphical user interface layer.
"""

# System imports
import uuid
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.gui_domain import node as node_gui_domain
from qde.editor.gui_domain import scene
from qde.editor.gui import node

@<Scene graph view declarations@>
@<Scene view declarations@>
@}

@d Scene graph view decorators
@{
@@common.with_logger
@}

@d Scene view signals
@{
do_add_node = QtCore.pyqtSignal(uuid.UUID)
do_select_node = QtCore.pyqtSignal(node_gui_domain.NodeViewModel)
# TODO: Send deselected node as well?
do_deselect_node = QtCore.pyqtSignal()
@}

% Coming from: Scene view methods
@d Handle node definition chosen
@{
node_definition_vm = self.add_node_dialog.chosen_node_definition
self.logger.debug(
    "Node instance shall be added: %s",
    node_definition_vm
)
self.do_add_node.emit(node_definition_vm.id_)
@}

@d Scene view slots
@{
@@QtCore.pyqtSlot(uuid.UUID)
def on_node_selected(self, node_view_model_id):
    """Gets triggered whenever a node was selected within the node graph
    view."""

    current_scene = self.scene()
    node_view_model = current_scene.nodes[node_view_model_id]
    self.logger.debug("Node instance was selected: %s" % type(node_view_model))
    self.do_select_node.emit(node_view_model)
@}

@d Scene view slots
@{
@@QtCore.pyqtSlot(uuid.UUID)
def on_node_deselected(self, node_view_model_id):
    """Gets triggered whenever a node was deselected within the node graph
    view."""

    self.logger.debug("Currently selected node instance was deselected")
    self.do_deselect_node.emit()
@}

@d Scene view slots
@{
@@QtCore.pyqtSlot(node_gui_domain.NodeViewModel)
def on_node_view_model_added(self, node_view_model):
    """Slot that gets triggered when a node instance was added.
    Adds the given view model of the node to the currently active scene.

    :param node_view_model: The view model of the added node instance.
    :type  node_view_model: qde.editor.gui_domain.node.NodeViewModel
    """

    current_scene = self.scene()
    assert current_scene is not None

    # Add node view model to scene
    current_scene.addItem(node_view_model)
    current_scene.nodes[node_view_model.id_] = node_view_model
    insert_pos_x = current_scene.insert_at.x() * node_gui_domain.NodeViewModel.WIDTH
    insert_pos_y = current_scene.insert_at.y() * node_gui_domain.NodeViewModel.HEIGHT
    node_view_model.setPos(insert_pos_x, insert_pos_y)

    # Handle (de-)selection of the node view model
    node_view_model.do_select_node.connect(self.on_node_selected)
    node_view_model.do_deselect_node.connect(self.on_node_deselected)

    # Handle node connections
    # Start connection
    node_view_model.do_start_connection.connect(
        current_scene.on_start_connection
    )

    # Update connection
    # node_view_model.do_update_connection.connect(
    #     self.on_update_connection
    # )

    # End connection
    node_view_model.do_end_connection.connect(
        current_scene.on_end_connection
    )
    self.logger.debug(
        "Registered for node %s (%s)",
        node_view_model, type(node_view_model)
    )

    # Abort connection
    current_scene.do_abort_connection.connect(
        self.on_abort_connection
    )

    self.logger.debug(
        "Node instance '%s' was added to current scene (%s) at %s",
        node_view_model,
        current_scene,
        node_view_model.pos()
    )
@}

@d Scene view slots
@{
@@QtCore.pyqtSlot(uuid.UUID, uuid.UUID)
def on_start_connection(self, node_view_model_id, node_connector_vm_id):
    """Gets triggered whenever a connector of a node is being dragged."""

    current_scene = self.scene()
    assert current_scene is not None

    self.logger.debug(
        "Connecting nodes started. Source: (%s)-(%s)",
        node_view_model_id,
        node_connector_vm_id
    )

    source_node = current_scene.nodes[node_view_model_id]
    assert source_node is not None

    self.logger.debug("Connection start: node %s", source_node)
    self.current_source = source_node

    cursor_pos = self.mapFromGlobal(QtGui.QCursor.pos())
    current_scene.temp_connection = node_gui_domain.NodeConnectionViewModel(cursor_pos)
    current_scene.temp_connection.target = cursor_pos
    current_scene.addItem(current_scene.temp_connection)

    # self.current_source = (source_node, source_connector)
@}

@d Scene view slots
@{
@@QtCore.pyqtSlot()
def on_update_connection(self):

    current_scene = self.scene()
    assert current_scene is not None

    self.logger.debug("Updating connection for current scene %s", current_scene)

    cursor_pos = self.mapFromGlobal(QtGui.QCursor.pos())
    current_scene.temp_connection.target = cursor_pos
    current_scene.invalidate()
@}

@d Scene view slots
@{
@@QtCore.pyqtSlot(uuid.UUID, uuid.UUID)
def on_end_connection(self, node_view_model_id, node_connector_vm_id):
    """Gets triggered whenever a dragged connector of a node is being
    released."""

    self.logger.debug("End connection for scene view")

    current_scene = self.scene()
    assert current_scene is not None

    cursor_pos = self.mapFromGlobal(QtGui.QCursor.pos())
    intersected_items = current_scene.items(cursor_pos)
    self.logger.debug("Connecting nodes ended. Items below: %s", intersected_items)

    for item in intersected_items:
        if (
                isinstance(item, node_gui_domain.NodeConnectorViewModel) and
                item.id_ == node_connector_vm_id
        ):
            self.logger.debug("We have a connection, Jim!")
            # TODO: Process node connection recursively here
@}

@d Scene view slots
@{
@@QtCore.pyqtSlot()
def on_abort_connection(self):
    """Gets triggered when the target of a connection with a valid source gets
    dropped over an invalid target (blank, wrong type)."""

    current_scene = self.scene()
    assert current_scene is not None

    self.logger.debug("Aborting connection")

    current_scene.removeItem(current_scene.temp_connection)
    current_scene.temp_connection.setParent(None)
    current_scene.invalidate()
@}

