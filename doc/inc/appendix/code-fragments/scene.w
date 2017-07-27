% -*- mode: poly-latex+python; coding: utf-8 -*-

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

@d Scene graph view decorators
@{
@@common.with_logger
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

@d Scene controller signals
@{do_select_node = QtCore.pyqtSignal(node_gui_domain.NodeViewModel)
do_deselect_node = QtCore.pyqtSignal()  # TODO: Send deselected node as well?@}

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

    # Handle (de-)selection of the node view model
    node_view_model.do_select_node.connect(self.on_node_selected)
    node_view_model.do_deselect_node.connect(self.on_node_deselected)

    # Add node domain model to scene domain model
    self.current_scene.nodes.append(node_domain_model)

    self.logger.debug(
        "Node instance '%s' was added to current scene (%s) at %s",
        node_view_model,
        self.current_scene,
        node_view_model.pos()
    )
    # TODO: Check if still necessary
    # self.node_added.emit(self.current_scene)

@@QtCore.pyqtSlot()
def on_node_selected(self):
    """Gets triggered whenever a node was selected within the node graph
    view."""

    node_view_model = self.current_scene.selectedItems()[0]
    self.logger.debug("Node instance was selected: %s" % type(node_view_model))
    self.do_select_node.emit(node_view_model)

@@QtCore.pyqtSlot()
def on_node_deselected(self):
    """Gets triggered whenever a node was deselected within the node graph
    view."""

    self.logger.debug("Currently selected node instance was deselected")
    self.do_deselect_node.emit()
@}

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
