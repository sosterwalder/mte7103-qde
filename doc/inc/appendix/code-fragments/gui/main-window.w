% -*- mode: poly-latex+python; coding: utf-8 -*-

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
from qde.editor.gui import render as gui_render
from qde.editor.gui import scene as gui_scene


@<Main window declarations@>
@}

@d Set up render view in main window
@{
self.render_view = gui_render.RenderView(self)
self.render_view.setObjectName('render_view')
self.render_view.setMinimumSize(300, 300)
@}

@d Add render view to horizontal splitter in main window
@{
horizontal_splitter.addWidget(self.render_view)
@}

@d Connect main window components
@{
self.main_window.scene_view.do_add_node.connect(
    self.node_controller.on_node_added
)
self.node_controller.do_add_node_model.connect(
    self.scene_controller.on_node_model_added
)
self.node_controller.do_add_node_view_model.connect(
    self.main_window.scene_view.on_node_view_model_added
)
self.main_window.scene_view.do_select_node.connect(
    self.main_window.render_view.on_node_selected
)
self.main_window.scene_view.do_deselect_node.connect(
    self.main_window.render_view.on_node_deselected
)
@}
