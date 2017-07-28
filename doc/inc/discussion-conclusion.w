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

\newthought{The developed editor component} allows currently one animation to be
managed. The animation may have one or more scenes which can be added or removed
using a tree like structure.

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

% \newthought{Optional objectives} are the following:
% \begin{itemize}
%   \item Additional features for the editor, as follows.
%   \begin{itemize}
%     \item A sequencer, allowing a time-based scheduling of defined scenes.
%     \item Additional nodes, such as operations (e.g. replication of objects)
%       or post-processing effects (glow/glare, color grading and so on).
%   \end{itemize}
%   \item Development of a standalone player application. The player allows the
%     playback of animations (time-based, compounded scenes in sequential order)
%     created with the editor.
% \end{itemize}