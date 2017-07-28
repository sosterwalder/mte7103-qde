% -*- mode: latex; coding: utf-8 -*-

\chapter{Discussion and conclusion}
\label{chap:discussion-conclusion}

\newthought{The previous chapter} showed the results of this thesis.

\newthought{This chapter} offers a discussion of the results and a conclusion.

\newthought{In the first section} the results of this thesis are interpreted.
The first section builds the basis for the second section, the conclusion. The
second section summarizes the most important results relating to the
objectives and provides an outlook what might follow up this thesis.


\section{Discussion}
\label{sec:discussion-conclusion:discussion}

% Im Kapitel Diskussion setzt sich die Autorin, der Autor mit den erzielten
% Ergebnissen auseinander. Diese werden interpretiert und mit Erkenntnissen aus
% anderen Studien zur gleichen Fragestellung beurteilt. Die Diskussion schafft die
% nötigen Grundlagen, damit die in der Einleitung formulierte Fragestellung
% möglichst gut und sachlich richtig beantwortet werden kann.

\newthought{The results of this thesis} are a software architecture, a literate
program and an implement program. The software architecture builds the basis for
the program implemented. The literate program documents the program implemented
while at the same time providing the actual implementation.

\subsection{Software architecture}
\label{subsec:discussion-conclusion:discussion:software-architecture}

\newthought{The software architecture} is defined by three aspects: an
architectural software design pattern, layers and signals and slots.

\newthought{The used architectural software design pattern} is a combination of
the model-view-view model and the model-view-controller software design
patterns. The pattern separates data from its representation and ensures a
coherent design.

\newthought{A relaxed layered architecture} is used to reduce coupling and
dependencies. The architecture allows higher layers to communicate with any
lower layer.

\newthought{Signals and slots}, which are a generalized implementation of the
observer pattern, are used to allow communication between components. This
prevents high coupling and low cohesion.

\subsection{Literate program}
\label{subsec:discussion-conclusion:discussion:literate-program}

\newthought{The developed literate program} explains how a program for modeling,
composing and rendering real time computer graphics using sphere tracing is
developed. The used literate programming paradigm allows to explain to human
beings what the computer shall do instead of focusing on instructing the
computer what to do by writing program code and forcing readers to read the
program code.

\newthought{The literate program starts} with a description of what will be
achieved. From this description the main components are derived and then
subsequently implemented. This shows also the overall structure of the literate
program: a certain concept is first introduced by describing it and then
implemented.

\subsection{Program}
\label{subsec:discussion-conclusion:discussion:program}

\newthought{Using the introduced methodologies} and the developed software
architecture the editor component of the program was implemented.

\newthought{Animations are the building blocks} of the editor component and
contain scenes, which contain nodes. Currently the developed editor component
allows one animation to be managed.

\newthought{Scenes build the basis} of an animation. They can be managed using a
tree like structure. Each scene holds nodes in a graph structure.

\newthought{Nodes represent the content} of a scene and therefore of an
animation. Nodes are defined by node definitions which are read from the file
system. The program implemented supports currently only nodes which define
implicit objects.

\newthought{Animations are evaluated} for rendering. Evaluating an animation means
evaluating scenes which means evaluating nodes. The result is OpenGL Shading
Language specific code which is executed by the graphical processing unit (GPU)
and seen by the viewer.

\newthought{Rendering is done} using the sphere tracing algorithm. For shading
the Phong shading technique is used.

\section{Conclusion}
\label{sec:conclusion}

% In den Folgerungen können die wichtigsten Ergebnisse in ihrer kritischen
% Würdigung prägnant zusammengefasst werden. Es wird eine Art Schlussbilanz
% gezogen. Aus der detaillierten Darstellung der Ergebnisse und deren Diskussion
% lässt sich in der Regel eine Antwort auf die Ausgangsfrage ableiten [3, p. 26].
% Die Antwort auf die Fragestellung kann zu Empfeh- lungen für die Ausführung in
% der Praxis oder für weitere Studien führen. Die Folgerungen dürfen keine neuen
% Elemente und Aspekte enthalten, welche nicht schon in den Ergebnissen und in der
% Diskussion behandelt wurden. Wenn die Problemstellung der Arbeit nur sehr wenige
% Folgerungen verlangt, können diese auch als Schlussteil in die Diskussion
% integriert werden.

\newthought{The main objective of this thesis} is the design and development of
a program for modeling, composing and rendering real time computer graphics by
providing a graphical toolbox. To reach this main objective additional
objectives were defined, which can be found
at~\autoref{subsec:objectives}~\enquote{\nameref{subsec:objectives}}

\newthought{All of the objectives could be reached}, not all of the objectives
and components are as elaborated as originally intended however. The program
implemented provides at this time no possibility to store and load animations
and supports only nodes which define implicit objects. As the whole node
structure is very generalized (by using definitions for nodes) new node types
can be implemented without much effort. At this time no connections between
nodes are possible, the program implemented only allows the evaluation of a
single node at a time. Point light sources are directly implemented (hard-coded)
within the shader and not as nodes as intended. The same applies for materials
of objects.

\newthought{The use of the literate programming paradigm} was a whole new
experience to the author.

\newthought{Literate programming has a lot of advantages}, such as focusing on
explaining to human beings what the computer shall do in terms of ideas and
concepts instead of instructing the computer what to do by writing only program
code. As combining the documentation with code in a single document builds the
basis of literate programming, the documentation of the program is inherent.
This prevents unforeseen cost and time overruns.

\newthought{Literate programming faces also several problems however}: it
requires a different way of thinking from traditional methodologies, it is very
expressive and verbose, and the documentation can become lengthy and hard to
read, especially when including the full implementation of technical details.
Although these problems were overcome in the writing of this thesis, they led to
significant overhead which affected the whole thesis in terms of less
productivity. When someone is used to the paradigm these problems can be
prevented upfront and the paradigm may be not much more costly than using
traditional methodologies (at least for smaller programs).

\newthought{Sphere tracing}, the algorithm used for rendering, is able to
produce high quality, realistic looking images in real time without being overly
complex. It has however a clear disadvantage: the de facto way of representing
the surface of objects using triangle based meshes cannot be used directly.
Instead, distance functions have to be used for modeling the surfaces as seen
from any view point. This disadvantage may be the reason that sphere tracing
seems not to be used production. However, the algorithm seems to coming into use
in production, for example for calculating ambient
occlusion~\cite{epic-games-ao-2017} or soft
shadows~\cite{epic-games-soft-shadows-2017}. Time will tell if the method will
establish itself further and become practicable for rendering conventional
meshes.

\newthought{As this thesis has a limited time frame} of one semester, not all
desired topics could be treated and not all of the set objectives and
components are as elaborated as originally intended.

\newthought{Further topics} for the continuation of this thesis might be
additional features for the editor component and the development of the player
component, which can be used as standalone program.

\newthought{Additional features for the editor} component could be the
following: a sequencer, allowing a time-based scheduling of defined scenes.
Additional nodes, such as operations (e.g.\ replication of objects) or
post-processing effects (glow/glare, color grading and so on).

\newthought{Additional features for rendering} could be the implementation of
ambient occlusion, the implementation of realistic materials based on the
bidirectional reflectance distribution function and the acceleration of the
sphere tracing algorithm.