% -*- mode: latex; coding: utf-8 -*-

\section{Name spaces and project structure}
\label{appendix:sec:name-spaces}

\newthought{To provide a structure for the whole project} and for being able to
stick to the thoughts established in~\nameref{chap:fundamentals}
and~\nameref{chap:methodologies}, it may be wise to structure the project a
certain way.

\newthought{The source code shall be placed} in the~\verb+src+ directory
underneath the main directory. The creation of the single directories is not
explicitly shown, it is done by parts of this documentation which are tangled
but not exported.

\newthought{When dealing with directories and files}, Python uses the
term~\emph{package} for (sub-) directories and~\emph{module} for files within
directories.\footnote{https://docs.python.org/3/reference/import.html\#packages}

\newthought{To prevent having multiple modules having the same name,} name
spaces are
used.\footnote{https://docs.python.org/3/tutorial/classes.html\#python-scopes-and-namespaces}
The main name space shall be analogous to the project's name:~\verb+qde+.
Underneath the source code folder~\verb+src+, each sub-folder represents a
package and acts therefore also as a name space.

\newthought{To allow a whole package and its modules} being
imported~\emph{as modules}, it needs to have at least a file inside,
called~\verb+__init__.py+. Those files may be empty or they may contain
regular source code such as classes or methods.

\section{Coding style}
\label{appendix:sec:coding-style}

\newthought{To stay consistent throughout implementation} of components, a
coding style is applied which is defined as follows.

\begin{itemize}
  \item Classes use camel case, e.g. \verb+class SomeClassName+.
  \item Folders respectively name spaces use only small letters, e.g.
    \verb+foo.bar.baz+.
  \item Methods are all small caps and use underscores as spaces, e.g.
    \verb+some_method_name+.
  \item Signals are methods, which are prefixed by the word~\enquote{do}, e.g.
    \verb+do_something+.
  \item Slots are methods, which are prefixed by the word~\enquote{on}, e.g.
    \verb+on_something+.
  \item Importing is done by the \verb+from Foo import Bar+ syntax, whereas
    \verb+Foo+ is a module and \verb+Bar+ is either a module, a class or a
    method.
\end{itemize}

\subsection{Importing of modules}
\label{appendix:subsec:imports}

\newthought{For the implementation python is used}, as mentioned
in section~\enquote{\nameref{appendix:sec:requirements}}.
Python has~\enquote{batteries included}, which means that it offers a lot of
functionality through various modules, which have to be imported first before
using them. The same applies of course for self written modules. Python offers
multiple possibilities concerning imports, for details
see~\url{https://docs.python.org/3/tutorial/modules.html}. \todo[inline]{Is
direct url reference ok or does this need to be citation?}

However, PEP number 8 recommends to either import modules directly or to import
the needed functionality
directly.~\footnote{\url{https://www.python.org/dev/peps/pep-0020/}}. As defined
by the coding style,~\autoref{subsec:appendix-implementation-coding-style},
imports are done by the \verb+from Foo import Bar+ syntax.

\newthought{The imported modules are always split up:} first the system modules
are imported, modules which are provided by Python itself or by external
libraries, then project-related modules are imported.

\subsection{Framework for implementation}
\label{appendix:subsec:framework}

\newthought{To stay consistent when implementing} classes an methods, it makes
sense to define a rough framework for their implementation, which is as follows:
\begin{enumerate*}
  \item Define necessary signals,
  \item define the constructor and
  \item implement the remaining functionality in terms of methods and slots.
\end{enumerate*}
Concerning the constructor, the following pattern may be applied:
\begin{enumerate*}
  \item Set up the user interface when it is a class concerning the graphical
    user interface,
  \item set up class-specific aspects, such as the name, the tile or an icon,
  \item set up other components used by that class and
  \item initialize the connections, meaning hooking up the defined signals
    with corresponding methods.
\end{enumerate*}

Now, having defined the~\emph{requirements}, a~\emph{project structure},
a~\emph{coding style} and a~\emph{framework for} the
actual~\emph{implementation}, the implementation of the editor may be
approached.