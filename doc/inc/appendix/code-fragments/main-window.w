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

@d Set up parameter view in main window
@{
self.render_view = gui_render.RenderView(self)
self.render_view.setObjectName('render_view')
self.render_view.setMinimumSize(300, 300)@}

@d Add render view to horizontal splitter in main window
@{
horizontal_splitter.addWidget(self.render_view)@}