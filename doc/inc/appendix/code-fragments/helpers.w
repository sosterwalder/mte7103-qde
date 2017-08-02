% -*- mode: poly-latex+python; coding: utf-8 -*-

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

    @<Mouse press event of clickable label@>
@}

@d Mouse press event of clickable label
@{
def mousePressEvent(self, event):
    """Event handler when a mouse button was pressed on this label. Emits a
    signal called 'do_add_node'.

    :param event: the event which occurred.
    :type event: Qt.QMouseEvent
    """

    self.do_add_node.emit()
    super(ClickableLabel, self).mousePressEvent(event)
@}

