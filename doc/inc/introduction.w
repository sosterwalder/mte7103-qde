% -*- mode: latex; coding: utf-8 -*-

\chapter{Introduction}
\label{chap:introduction}

% Die Einleitung gibt Antwort auf die Frage, weshalb es den Bericht gibt und wie
% er zustande gekommen ist [3, p. 25]. Im ersten Teil wird das Thema der Arbeit
% eingeführt. Die Relevanz und Aktualität des Themas oder der fachliche Kontext
% der Untersuchung werden dazu kurz umschrieben. Die Einleitung hält explizit
% fest, welchen Auftrag der Bericht erfüllt [3, p. 25]. Der Auftrag muss so klar
% und präzise wie möglich formuliert werden. Auftraggeber und Auftragnehmer werden
% festgehalten. Der zweite Teil der Einleitung stellt den Ist-Zustand oder den
% bisherigen Wissensstand knapp dar. Darauf aufbauend wird das eigene Thema
% eingegrenzt. Es gibt Untersuchungen, bei denen es für das Verständnis wichtig
% ist, den genauen Ist-Zustand zu kennen. Wenn es für ein Projekt bereits ein
% Vorprojekt gibt, auf dessen Resultate der Bericht aufbaut, oder in Bauprojekten
% ist es üblich, die Ausgangslage in einem gesonderten Kapitel zu beschreiben. Im
% dritten Teil wird die präzise Fragestellung formuliert. Das Ziel des Berichts
% wird genannt und es wird erläutert, welchen Nutzen die Untersuchung haben soll.

\newthought{The application area of computer graphics} exists since the
beginning of modern computing. Computer scientists have always strived to create
realistic depictions of the observable reality.

\newthought{Over time various approaches} for creating artificial images (the so
called rendering) have evolved. One of these approaches is ray tracing. This was
introduced in~\citeyear{appel_techniques_1968}
by~\citeauthorfin{appel_techniques_1968} in the
article~\citetitle{appel_techniques_1968}~\cite{appel_techniques_1968}. In
\citeyear{whitted_improved_1980} this methods were improved
by~\citeauthorfin{whitted_improved_1980} in his work
\citetitle{whitted_improved_1980}~\cite{whitted_improved_1980}.

\newthought{Ray tracing captivates} through simplicity while providing a very
high image quality, including perfect refractions and reflections of light. For
a long time although, the approach was not efficient enough to deliver images in
real time, which requires creating at least 25 rendered images (frames) per
second. Otherwise, due to the human anatomy, the output is perceived as either
still and jerky images or as a too slow animation.

\newthought{Sphere tracing} is a ray tracing approach introduced
in~\citeyear{hart_sphere_1994} by~\citeauthorfin{hart_sphere_1994} in his
work~\citetitle{hart_sphere_1994}~\cite{hart_sphere_1994}. This approach is
faster than the classical ray tracing approaches in its method of finding
intersections between rays and objects.

\newthought{Graphics processing units (GPUs)} have evolved over time and have
become exponentially more powerful in processing power. Since around 2009, GPUs are able to
produce real time computer graphics using sphere tracing. While allowing ray
tracing in real time on modern GPUs, sphere tracing has, however, a clear
disadvantage. The de facto way of representing the surface of objects using triangle based
meshes cannot be used directly. Instead, distance functions are used for
modeling the surfaces as seen from any view point.

\section{Purpose and conditions}
\label{sec:purpose}

\subsection{Motivation}
\label{subsec:motivation}

\newthought{Up to this point in time} there are no solutions (at least none are
known to the author) that provide a convenient way for modeling, animating and
rendering objects and scenes using signed distance functions for modeling and
sphere tracing for rendering.
Most of the solutions using sphere tracing implement it by having one or
multiple big fragment shaders containing everything from modeling to lighting.
Other solutions provide node based approaches, but they allow either no sphere
tracing at all, meaning they use rasterization, or they provide nodes containing
(fragment-) shader code, which leads again to a single big fragment shader.

\newthought{This thesis} aims at designing and developing a program which
provides both, a node based approach for modeling and animating objects using
signed distance functions and allowing the rendering of scenes using sphere
tracing, efficiently enough to be executed in real time on the GPU.

\subsection{Objectives and limitations}
\label{subsec:objectives}

\newthought{The objective of this thesis} is the design and development of a
program for \textit{modeling}, \textit{composing} and \textit{rendering} real
time computer graphics by providing a graphical toolbox.

\newthought{Modeling} is done by composing simple objects into complex objects
and scenes using a node based graph structure of~\enquote{nodes}.

\newthought{Composing} includes two aspects: the combination of objects into
scenes, and the creation of an animation which is defined by multiple scenes
which follow a chronological order. The first aspect is realized by a scene
graph structure. The second aspect is realized by a time line.

\newthought{For rendering}, a highly optimized algorithm based on ray tracing is
used. The algorithm is called sphere tracing and allows the rendering of ray
traced scenes in real time on the GPU. Contingent upon the rendering algorithm
used all objects are modeled using distance functions.

\newthought{Required objectives} are the following:
\begin{itemize}
  \item Development of an editor for creating and editing real time rendered
    scenes, containing the following features.
    \begin{itemize}
      \item A scene tree, allowing management (creation and deletion) of
        scenes.
      \item One node-based graph structure for each scene in the scene tree.
        This allows the composition of scenes using
        nodes and connections between the nodes.
    \item Nodes
      \begin{itemize}
        \item Simple objects defined by signed distance functions: In this
          thesis the objects are limited to cube and sphere (other solids could
          be modeled in the same way).
        \item Simple operations: Union, Intersection, Subtraction.
        \item Transformations: Rotate, Translate and Scale.
        \item Camera.
        \item Renderer (ray traced rendering using sphere tracing)
        \item Point light sources.
      \end{itemize}
    \end{itemize}
\end{itemize}

\section{Related works}
\label{sec:related-works}

\newthought{Preliminary} to this thesis two project works were completed.
The first was \enquote{Volume ray casting --- basics \&
principles}~\cite{osterwalder-volume-2016}, which describes the concepts
of sphere tracing The second was \enquote{QDE
--- a visual animation system, architecture}~\cite{osterwalder-qde-2016}, which
established the concepts of an editor and a player component, as well as
the basis for a possible software architecture for these components.

\newthought{For clarity in the explanation} of this thesis first the
architecture is presented, see section~\enquote{\nameref{soarch}}. Then the rendering is
presented in section~\enquote{\nameref{sec:rendering}}.

\section{Document structure}
\label{sec:document-structure}

\newthought{This document is divided into six chapters}, the first being this
chapter,~\enquote{\nameref{chap:introduction}}. The second
chapter~\enquote{\nameref{chap:administrative-aspects}} shows the planning of
the project, including the persons involved, the deliverables, and phases and
milestones.

\newthought{The administrative aspects are followed by} the
chapter~\enquote{\nameref{chap:fundamentals}}. The purpose of this chapter is to
present the principles, based on the previous project works mentioned above that
this thesis is built upon.

\newthought{The next chapter} on~\enquote{\nameref{chap:methodologies}}
introduces a concept called literate programming and elaborates some details of
the implementation using this. Additionally it introduces standards and
principles for implementation of the developed software.

\newthought{The following chapter} on~\enquote{\nameref{chap:implementation}}
describes the editor component.

\newthought{The last chapter}~\enquote{\nameref{chap:discussion-conclusion}}
considers the methodologies as well as the results. Some further work on the
editor and the player components is proposed as well.

\newthought{After the regular content} follow appendices,
see~\enquote{\nameref{part:appendix}}, detailing the requirements for building
the above-mentioned components, and the actual source code in form of a literal
program.
