% -*- mode: latex; coding: utf-8 -*-

\chapter{Implementation}
\label{appendix:chap:implementation}

\newthought{To begin with the implementation} of a project, it is necessary to
first think about the goal that one wants to reach and about some basic
structures and guidelines which lead to the fulfillment of that goal.

\newthought{The main goal is} to have a visual animation system, which allows
the creation and rendering of visually appealing scenes, using a graphical user
interface for creation, and a ray tracing based algorithm for
rendering.~\todo{Adapt goal to current state.}

\newthought{The thoughts to reach this goal} were already developed
in~\nameref{chap:fundamentals} and~\nameref{chap:methodologies} and will
therefore not be repeated again.

\newthought{As stated in~\nameref{chap:methodologies}}, the literate programming
paradigm is used to implement the components. To maintain readability only
relevant code fragments are shown in place. The whole code fragments, which are
needed for tangling, are found at~\nameref{chap:code-fragments}.

\newthought{The editor component is described first} as it is the basis for the
whole project and also contains many concepts, that are re-used by the player
component. Before starting with the implementation it is necessary to define
requirements and some kind of framework for the implementation.

@i inc/appendix/requirements.w
@i inc/appendix/project-structure.w

