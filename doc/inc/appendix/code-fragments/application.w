% -*- mode: poly-latex+python; coding: utf-8 -*-

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

@d Connect main window components
@{
self.main_window.scene_view.do_add_node.connect(
    self.node_controller.on_node_added
)
self.node_controller.do_add_node_model.connect(
    self.scene_controller.on_node_model_added
)
self.scene_controller.do_select_node.connect(
    self.main_window.render_view.on_node_selected
)
self.scene_controller.do_deselect_node.connect(
    self.main_window.render_view.on_node_deselected
)
@}
