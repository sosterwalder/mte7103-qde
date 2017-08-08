% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/application/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the application layer.
"""

# System imports
import uuid
from PyQt5 import Qt
from PyQt5 import QtCore

# Project imports
from qde.editor.foundation import common
from qde.editor.foundation import type as types
from qde.editor.domain     import node  as node_domain
from qde.editor.domain     import parameter as parameter_domain
from qde.editor.domain     import scene as scene_domain
from qde.editor.gui_domain import node  as node_gui_domain
from qde.editor.gui_domain import scene as scene_gui_domain

@<Scene graph controller declarations@>
@<Scene controller declarations@>
@}

@d Scene graph controller methods
@{
@<Scene graph controller add root node@>
@}

@d Scene controller slots
@{
@@QtCore.pyqtSlot(node_domain.NodeModel)
def on_node_model_added(self, node_domain_model):
    self.logger.debug("Shall add node domain model: %s", node_domain_model)

    # Add node domain model to scene domain model
    assert self.current_scene is not None
    self.current_scene.nodes[node_domain_model.id_] = node_domain_model
@}
