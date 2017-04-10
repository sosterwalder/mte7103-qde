% -*- mode: latex; coding: utf-8 -*-

\chapter{Appendix}
\label{chap:appendix}

@i inc/appendix/implementation.w
@i inc/appendix/work-log.w

\section{Test cases}
\label{sec:test-cases}

\blindtext{}

\section{Requirements}
\label{sec:requirements}
% 
% This chapter describes the requirements to extract the source code out of this
% documentation using /tangling/.
% 
% At the current point of time, the requirements are the following:
% 
% - A Unix derivative as operating system (Linux, macOS).
% - Python version 3.5.x or up[fn:3:https://www.python.org].
% - Pyenv[fn:4:https://github.com/yyuu/pyenv].
% - Pyenv-virtualenv[fn:5:https://github.com/yyuu/pyenv-virtualenv].
% 
% The first step is to install a matching version of python for the usage within
% the virtual environment. The available Python versions may be listed as follows.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Listing all available versions of Python for use in Pyenv.
% #+NAME:       fig:impl-pyenv-list
% #+BEGIN_SRC bash
% pyenv install --list
% #+END_SRC
% 
% The desired version may be installed as follows. This example shows the
% installation of version 3.6.0.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Installation of Python version 3.6.0 for the usage with Pyenv.
% #+NAME:       fig:impl-pyenv-install
% #+BEGIN_SRC bash
% install 3.6.0
% #+END_SRC
% 
% It is highly recommended to create and use a project-specific virtual Python
% environment. All packages, that are required for this project are installed
% within this virtual environment protecting the operating systems' Python
% packages.
% First the desired version of Python has to be specified, then the desired name
% of the virtual environment.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Creation of the virtual environment =qde= for Python using version 3.6.0 of Python.
% #+NAME:       fig:impl-pyenv-venv
% #+BEGIN_SRC bash
% pyenv virtualenv 3.6.0 qde
% #+END_SRC
% 
% All required dependencies for the project may now safely be installed. Those are
% listed in the file =python_requirements.txt= and are installed using =pip=.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Installation of the projects' required dependencies.
% #+NAME:       fig:impl-pip-install
% #+BEGIN_SRC bash
% pip install -r python_requirements.txt
% #+END_SRC
% 
% All requirements and dependencies are now met and the actual implementation of
% the project may begin now.

\section{Directory structure and name-spaces}
\label{sec:directory-structure}

This chapter describes the planned directory structure as well as how the usage
of name-spaces is intended.

% The whole source code shall be placed in the =src= directory underneath the main
% directory. The creation of the single directories is not explicitly shown
% respectively done, instead the =:mkdirp= option provided by the source code
% block structure is used[fn:11:http://orgmode.org/manual/mkdirp.html#mkdirp]. The
% option has the same effect as would have =mkdir -p [directory/subdirectory]=: It
% creates all needed (sub-) directories, even when tangling a file. This prevents
% the tedious and non-interesting creation of directories within this document.
% 
% When dealing with directories and files, Python uses the term /package/ for a
% (sub-) directories and /module/ for files within directories, that is
% modules.[fn:13:https://docs.python.org/3/reference/import.html#packages]
% 
% To prevent having multiple modules having the same name, name-spaces are
% used[fn:6:https://docs.python.org/3/tutorial/classes.html#python-scopes-and-namespaces].
% The main name-space shall be analogous to the projects' name: =qde=. Underneath
% the source code folder =src=, each sub-folder represents a package and acts
% therefore also as a name-space.
% 
% To actually allow a whole package and its modules being imported /as modules/,
% it needs to have at least a file inside called =__init__.py=. Those files may be
% empty or they may contain regular source code such as classes or methods.
% 
% The first stage of the project shows the creation of the /editor/ component, as
% it provides the possibility of creating and editing real-time animations which
% may then be played back by the /player/ component\cite[p. 29]{osterwalder_qde_2016}.

\section{Code fragments}
\label{sec:code-fragments}

@o ../src/editor.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Main entry point for the QDE editor application. """

# System imports
import sys

# Project imports
from qde.editor.application import application

@<Main entry point@>
@}

@o ../src/qde/editor/application/application.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Main application module for the QDE editor."""

# System imports
import logging
import logging.config
import os
import json
from PyQt5 import QtGui
from PyQt5 import QtWidgets

# Project imports
from qde.editor.gui import main_window as qde_main_window
from qde.editor.application import scene_graph


@<Main application declarations@>
@}

@o ../src/qde/editor/gui/main_window.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding the main application window. """

# System imports
from PyQt5 import QtCore
from PyQt5 import QtWidgets

# Project imports
from qde.editor.gui import scene as guiscene


@<Main window declarations@>
@}

@o ../src/qde/editor/domain/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the domain layer. """

# System imports
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

# Project imports

@<Scene view model declarations@>
@<Scene graph view model declarations@>
@}

@o ../src/qde/editor/application/scene_graph.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene graph related aspects concerning the application layer.
"""

# System imports
from PyQt5 import QtCore

# Project imports
from qde.editor.domain     import scene as domain_scene
from qde.editor.gui_domain import scene as guidomain_scene

@<Scene graph controller declarations@>
@}

@o ../src/qde/editor/gui/scene.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Module holding scene related aspects concerning the graphical user interface layer.
"""

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtWidgets

# Project imports
from qde.editor.foundation import common
from qde.editor.gui_domain import scene

@<Scene graph view declarations@>
@}

@o ../logging.json
@{{
    "version": 1,
    "disable_existing_loggers": false,
    "formatters": {
        "simple": {
            "format": "%(asctime)s - %(levelname)-7s - %(name)s.%(funcName)s::%(lineno)s: %(message)s"
        }
    },

    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "level": "DEBUG",
            "formatter": "simple",
            "stream": "ext://sys.stdout"
        },

        "info_file_handler": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "INFO",
            "formatter": "simple",
            "filename": "info.log",
            "maxBytes": 10485760,
            "backupCount": 20,
            "encoding": "utf8"
        },

        "error_file_handler": {
            "class": "logging.handlers.RotatingFileHandler",
            "level": "ERROR",
            "formatter": "simple",
            "filename": "errors.log",
            "maxBytes": 10485760,
            "backupCount": 20,
            "encoding": "utf8"
        }
    },

    "root": {
        "level": "DEBUG",
        "handlers": ["console", "info_file_handler", "error_file_handler"],
        "propagate": "no"
    }
}@}

@o ../src/qde/editor/foundation/common.py
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Module holding common helper methods."""

# System imports
from PyQt5 import Qt
from PyQt5 import QtCore
from PyQt5 import QtWidgets

# Project imports
from qde.editor.gui_domain import scene


def with_logger(cls):
    """Add a logger instance (using a stream handler) to the given class.

    :param cls: the class which the logger shall be added to.
    :type  cls: a class of type cls.

    :return: the class with the logger instance added.
    :rtype:  a class of type cls.
    """

    @<Set logger name@>
    @<Logger interface@>
@}

@d Scene graph view decorators
@{
@@common.with_logger
@}

@o ../src/qde/editor/foundation/type.py
@{# -*- coding: utf-8 -*-
"""Module for type-specific aspects."""

# System imports
import enum

# Project imports


@<Node type declarations@>
@}