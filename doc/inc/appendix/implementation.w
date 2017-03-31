% -*- mode: latex; coding: utf-8 -*-

\section{Implementation}
\label{sec:appendix-implementation}

To start the implementation of a project, it is necessary to first think about the
goal that one wants to reach and about some basic structures and guidelines
which lead to the fulfillment of that goal.

The main goal is to have a visual animation system, which allows the creation
and rendering of visually appealing scenes, using a graphical user interface for
creation and a ray tracing based algorithm for rendering.

The thoughts to reach this goal were already developed
in~\autoref{chap:procedure}, \enquote{\nameref{chap:procedure}}, and will
therefore not be repeated again.

First, the implementation of the editor component is described, as it is the
basis for the whole project and also contains many concepts, that are re-used by
the player component. Before starting with the implementation it is necessary to
define requirements and some kind of framework for the implementation.

\subsection{Requirements}
\label{subsec:appendix-requirements}

At the current point of time, the requirements for running the components are
the following:

\begin{itemize}
\item A Unix derivative as operating system (Linux, macOS).
\item Python~\footnote{\url{http://www.python.org}} version 3.5.x or above
\item PyQt5~\footnote{\url{https://riverbankcomputing.com/software/pyqt/intro}}
      version 5.7 or above
\end{itemize}
\todo[inline]{Add more requirements? E.g. OpenGL?}

\subsection{Name spaces and project structure}
\label{subsec:appendix-name-spaces}

To give the whole project a structure and for being able to stick to the
thoughts established in~\autoref{chap:procedure}, it may be wise to structure
the project in analogous way as defined in~\autoref{chap:procedure}.

Therefore the whole source code shall be placed in the \textit{src} directory
underneath the main directory. The creation of the single directories is not
explicitly shown, it is done by parts of this documentation which are tangled
but not exported.

When dealing with directories and files, Python uses the term \textit{package} for
(sub-) directories and \textit{module} for files within
directories.\footnote{https://docs.python.org/3/reference/import.html\#packages}

To prevent having multiple modules having the same name, name spaces are
used.\footnote{https://docs.python.org/3/tutorial/classes.html\#python-scopes-and-namespaces}
The main name space shall be analogous to the project's name: \textit{qde}. Underneath
the source code folder \textit{src}, each sub-folder represents a package and acts
therefore also as a name space.

To actually allow a whole package and its modules being imported \textit{as modules},
it needs to have at least a file inside, called~\textit{\_\_init\_\_.py}. Those files may be
empty or they may contain regular source code such as classes or methods.

\subsection{Coding style}
\label{subsec:appendix-implementation-coding-style}

To stay consistent throughout the implementation of components, a coding style
is applied which is defined as follows.

\begin{itemize}
\item Classes use camel case, e.g. \verb+class SomeClassName+.
\item Folders respectively name-spaces use only small letters, e.g.
  \textit{foo/bar/baz}.
\item Methods are all small caps and use underscores as spaces, e.g. \verb+some_method_name+.
\item Signals are methods, which are prefixed by the word \enquote{do}, e.g. \verb+do_something+.
\item Slots are methods, which are prefixed by the word \enquote{on}, e.g. \verb+on_something+.
\item Importing is done by the \verb+from Foo import Bar+ syntax, whereas
  \verb+Foo+ is a module and \verb+Bar+ is either a module, a class or a method.
\end{itemize}

\subsubsection{Importing of modules}
\label{ssubsec:appendix-implementation-coding-style-imports}

As mentioned at~\autoref{subsec:appendix-requirements}, Python is used. Python
has~\enquote{batteries included}, which means that it offers a lot of
functionality through various modules, which have to be imported first before
using them. The same applies of course for self written modules.

Python offers multiple possibilities concerning imports, for details
see~\url{https://docs.python.org/3/tutorial/modules.html}.
\todo[inline]{Is direct url reference ok or does this need to be citation?}

However, PEP number 8 recommends to either import modules directly or to import
the needed functionality
directly.~\footnote{\url{https://www.python.org/dev/peps/pep-0020/}}. As defined
by the coding style,~\autoref{subsec:appendix-implementation-coding-style},
imports are done by the \verb+from Foo import Bar+ syntax.

\subsection{Framework for implementation}
\label{subsec:appendix-implementation-framework}

For also staying consistent when implementing classes and methods, it make sense
to define a rough framework for implementation, which is as follows:

\begin{itemize}
\item Define necessary signals.
\item Within the constructor,
  \begin{itemize}
    \item Set up the user interface when it is a class concerning the graphical user interface.
    \item Set up class-specific aspects, such as the name, the tile or an icon.
    \item Set up other components, used by that class.
    \item Initialize the connections, meaning hooking up the defined signals with
      corresponding methods.
  \end{itemize}
\item Implement the remaining functionality in terms of methods and slots.
\end{itemize}

Now, having defined the requirements, a project structure, a coding style and a
framework for the actual implementation, the implementation of the editor may
begin.

@i inc/appendix/implementation/editor.w

