% -*- mode: latex; coding: utf-8 -*-

\subsection{Editor}
\label{subsec:editor}

Each application needs an entry point, a point where an application starts.
Python does this by evaluating a special variable called~\verb+__name__+. This
value is set to \verb+'__main__'+ if the module is~\enquote{read from standard
input, a script, or from an interactive
prompt.}~\footnote{\url{https://docs.python.org/3/library/__main__.html}}

So, when thinking about the main entry point for the editor, the module holding
this main entry point could easily be extended to hold a whole class
representing the actual editor application. Instead it is more intuitive to have
only a minimal entry point. All that entry point needs to do, is spawning the
editor application, execute it and exit again.

@d Main entry point
@{#!/usr/bin/python
# -*- coding: utf-8 -*-

""" Main entry point for the QDE editor application. """

# System imports
import sys

# Project imports
from qde.editor.application import application


if __name__ == "__main__":
    app = application.Application(sys.argv)
    status = app.exec()
    sys.exit(status)
}@}

@o ../src/editor.py
@{@<Main entry point@>@}

