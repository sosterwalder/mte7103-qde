% -*- mode: latex; coding: utf-8 -*-

\chapter{Procedure}
\label{chap:procedure}

\subsection{Literate programming}
\label{subsec:literate-programming}

This thesis' implementation is done by a procedure named ``literate
programming'', invented by Donald Knuth. What this means, is that the
documentation as well as the code for the resulting program reside in the same
file. The documentation is then /weaved/ into a separate document, which may be
any by the editor support format. The code of the program is /tangled/ into a
run-able computer program.~\todo[inline]{Provide more information about literate
programming. Citations, explain fragments, explain referencing fragments, code
structure does not have to be ``normal''}

Originally it was planned to develop this thesis' application test driven,
providing (unit-) test-cases first and implementing the functionality
afterwards. Initial trails showed quickly that this method, in company with
literate programming, would exaggerate the effort needed. Therefore conventional
testing is used. Test are developed after implementing functionality and run
separately. A coverage as high as possible is intended. Test cases are /tangled/
too, and may be found in the appendix.\todo[inline]{Insert reference/link to test cases here.}

\section{Standards and principles}
\label{sec:standards-principles}

\subsection{Requirements}
\label{subsec:requirements}

The requirements are defined by the preceding project work,~\enquote{QDE --- a
  visual animation system, software architecture}~\citep[p. 8
ff.]{osterwalder-qde-2016}, and are still valid.

For the editor application however, Python is used as a programming language.
This decision is made as the author of the thesis has several years of
experience concerning Python and as the performance of the editor is not
a critical factor. By performance all aspects are concerned, e.g. the evaluation
of the node graph or rendering itself.

As Python provides no direct bindings to Qt, an additional library is needed,
which provides those bindings. Currently there exist two Python bindings for Qt:
PySide and PyQt. As Qt version 5 is used, the bindings need to provide access to
version 5 too. Currently this is only achieved by PyQt5 in a stable and complete
way. PySide2 supports Qt version 5 too, is although under heavy development and
far from being complete and stable.

Therefore PyQt5 is an additional requirement.

\subsection{Code}
\label{subsec:code}

\begin{itemize}
\item Classes use camel case.
\item Folders / name-spaces use only small letters.
\item Methods are all small caps and use underscores as spaces.
\item Signals: do\_something
\item Slots: on\_something
\item Importing: {{{verb(from Foo import Bar)}}}\\
      As the naming of the PyQt5 modules prefixes them by /Qt/, it is very
      unlikely to have naming conflicts with other modules. Therefore the import
      format {{{verb(from PyQt5 import [QtModuleName])}}} is used. This still
      provides a (relatively) unique naming most probably without any conflicts
      but reduces the effort when writing a bit. The import of system modules is
      therefore as follows.
\end{itemize}

\subsubsection{Layering}
\label{ssubsec:layering}

Concerning the architecture, a layered architecture is foreseen, as stated in
\cite[p. 38 ff.]{osterwalder_qde_2016}. A relaxed layered architecture leads to
low coupling, reduces dependencies and enhances cohesion as well as clarity.

As the architecture's core \todo{Link to components} components are all graphical, a graphical user
interface for those components is developed. As the their data shall be
exportable, it would be relatively tedious if the graphical user interface would
hold and control that data. Instead models and model-view separation are used.
Additionally controllers are introduced which act as workflow objects of the
=application= layer and interfere between the model and its view.

\subsubsection{Model-View-Controller}
\label{ssubsec:mvc}

While models may be instantiated anywhere directly, this would although not
contribute to having clean code and sane data structures. Instead controllers,
lying within the {{{verb(application)}}} layer, will manage instances of models.
The instantiating may either be induced by the graphical user interface
or by the player when loading and playing exported animations.

A view may never contain model-data (coming from the {{{verb(domain)}}} layer)
directly, instead view models are used \cite{martin_fowler_presentation_2004}.

The behavior described above corresponds to the well-known model-view-controller
pattern expanded by view models.

As Qt is used as the core for the editor, it may be quite obvious to use Qt's
model/view programming practices, as described by
[fn:20:http://doc.qt.io/qt-5/model-view-programming.html]. However, Qt combines
the controller and the view, meaning the view acts also as a controller while
still separating the storage of data. The editor application does not actually
store data (in a conventional way, e.g. using a database) but solely exports it.
Due to this circumstance the model-view-controller pattern is explicitly used,
as also stated in \cite[p. 38]{osterwalder-qde-2016}.

\todo[inline]{Describe the exact process of communication between ViewModel,
Controller and Model.}

To avoid coupling and therefore dependencies, signals and
slots[fn:16:http://doc.qt.io/qt-5/signalsandslots.html] are used in terms of the
observer pattern to allow inter-object and inter-layer communication.
