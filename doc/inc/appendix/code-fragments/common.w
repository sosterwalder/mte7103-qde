% -*- mode: poly-latex+python; coding: utf-8 -*-

@o ../src/qde/editor/foundation/common.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Module holding common helper methods."""

# System imports
import logging
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports


def with_logger(cls):
    """Add a logger instance (using a stream handler) to the given class.

    :param cls: the class which the logger shall be added to.
    :type  cls: a class of type cls.

    :return: the class with the logger instance added.
    :rtype:  a class of type cls.
    """

    @<Set logger name@>
    @<Logger interface@>

@<Common methods@>
@}

@d Common methods
@{
def multiply_colors(color1, color2):
    red   = (color1.redF()   * color2.redF()  ) * 255
    blue  = (color1.blueF()  * color2.blueF() ) * 255
    green = (color1.greenF() * color2.greenF()) * 255

    return QtGui.QColor(red, blue, green)
@}
