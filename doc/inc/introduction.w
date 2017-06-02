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

\newthought{The subject of computer graphics} exists since the beginning of
modern computing. Ever since the subject of computer graphics has strived to
create realistic depictions of the observable reality. Over time various
approaches for creating artificial images (the so called rendering) evolved.
One of those approaches is ray tracing.
It was introduced in~\citeyear{appel_techniques_1968}
by~\citeauthor{appel_techniques_1968} in the
work~\citetitle{appel_techniques_1968}~\cite{appel_techniques_1968}. In
\citeyear{whitted_improved_1980} it was improved
by~\citeauthor{whitted_improved_1980} in his work
\citetitle{whitted_improved_1980}~\cite{whitted_improved_1980}.

\newthought{Ray tracing captivates} through simplicity while providing a very
high image quality including perfect refractions and reflections. For a long
time although, the approach was not performant enough to deliver images in real
time. Real time means being able to render at least 25 rendered images (frames)
within a second. Otherwise, due to the human anatomy, the output is perceived as
either still images or as a too slow animation.

\newthought{Sphere tracing} is a ray tracing approach introduced
in~\citeyear{hart_sphere_1994} by~\citeauthor{hart_sphere_1994} in his
work~\citetitle{hart_sphere_1994}~\cite{hart_sphere_1994}. This approach is
faster than the classical ray tracing approaches in finding intersections
between rays and objects. The speed up is achieved by using signed distance
functions for modeling the objects to be rendered and by expanding volumes for
finding intersections.

\newthought{Graphics processing units (GPUs)} have evolved over time and have
gotten more powerful in processing power. Since around 2009 GPUs are able to
produce real time computer graphics using sphere tracing. While allowing ray
tracing in real time on modern GPUs, sphere tracing has also a clear
disadvantage. The de facto way of representing objects, using triangle based
meshes, cannot be used directly. Instead distance fields defined by implicit functions build the basis for sphere tracing.

\section{Purpose and situation}
\label{sec:purpose}

\subsection{Motivation}
\label{subsec:motivation}

\newthought{To this point in time} there are no solutions (at least none are
known to the author), that provide a convenient way for modeling, animating and
rendering objects and scenes using signed distance functions for modeling and
sphere tracing for rendering.
Most of the solutions using sphere tracing implement it by having one or
multiple big fragment shaders containing everything from modeling to lighting.
Other solutions provide node based approaches, but they allow either no sphere
tracing at all, meaning they use rasterization, or they provide nodes containing
(fragment-) shader code, which leads again to a single big fragment shader.

\newthought{This thesis} aims at designing and developing a software which
provides both: a node based approach for modeling and animating objects using
signed distance functions as well as allowing the composition of scenes while
rendering objects, or scenes respectively, in real time on the GPU using sphere
tracing.

\subsection{Objectives and limitations}
\label{subsec:objectives}

\newthought{The objective of this thesis} is the design and development of a
software for \textit{modeling}, \textit{composing} and \textit{rendering} real
time computer graphics through a graphical user interface.

\newthought{Modeling} is done by composing single nodes to objects using a
node based graph structure.

\newthought{Compositing} includes two aspects: the composition of objects into
scenes and the composition of an animation which is defined by multiple scenes
which follow a chronological order. The first aspect is realized by a scene
graph structure, which contains at least a root scene. Each scene may contain
nodes. The second aspect is realized by a time line, which allows a
chronological organization of scenes.

\newthought{For rendering} a highly optimized algorithm based on ray tracing is
used. The algorithm is called sphere tracing and allows the rendering of ray
traced scenes in real time on the GPU. Contingent upon the used rendering
algorithm all models are modeled using implicit surfaces. In addition
mesh-based models and corresponding rendering algorithms may be implemented.

\newthought{Required objectives} are the following:
\begin{itemize}
  \item Development of an editor for creating and editing real time rendered
    scenes, containing the following features.
    \begin{itemize}
      \item A scene graph, allowing management (creation and deletion) of
        scenes. The scene graph has at least a root scene.
    \item A node-based graph structure, allowing the composition of scenes using
      nodes and connections between the nodes.
    \item Nodes for the node-based graph structure.
      \begin{itemize}
        \item Simple objects defined by signed distance functions: Cube and
          sphere
        \item Simple operations: Merge/Union, Intersection, Difference
        \item Transformations: Rotate, Translate and Scale
        \item Camera
        \item Renderer (ray traced rendering using sphere tracing)
        \item Lights
      \end{itemize}
    \end{itemize}
\end{itemize}

\newthought{Optional objectives} are the following:
\begin{itemize}
  \item Additional features for the editor, as follows.
  \begin{itemize}
    \item A sequencer, allowing a time-based scheduling of defined scenes.
    \item Additional nodes, such as operations (e.g. replication of objects)
      or post-processing effects (glow/glare, color grading and so on).
  \end{itemize}
  \item Development of a standalone player application. The player allows the
    playback of animations (time-based, compounded scenes in sequential order)
    created with the editor.
\end{itemize}

\section{Related works}
\label{sec:related-works}

\newthought{Preliminary} to this thesis two project works were done:
\enquote{Volume ray casting --- basics \&
principles}~\cite{osterwalder_volume_2016}, which describes the basics and
principles of sphere tracing, a special form of ray tracing, and \enquote{QDE
--- a visual animation system, architecture}~\cite{osterwalder_qde_2016}, which
established the ideas and notions of an editor and a player component as well as
the basis for a possible software architecture for these components. The latter
project work is presented in detail in the chapter about the procedure, the
former project work is presented in the chapter about the implementation.

\section{Document structure}
\label{sec:document-structure}

This document is divided into six chapters, the first being this \textit{introduction}. The
second chapter on \textit{administrative aspects} shows the planning of the
project, including the involved persons, deliverables and the phases and
milestones.

The administrative aspects are followed by a chapter on the
\textit{fundamentals}. The purpose of that chapter is to present the
fundamentals, that this thesis is built upon. One aspect is a framework for the
implementation of the intended software, which is heavily based on the previous
project work, \enquote{QDE --- a visual animation system, architecture}~\cite{osterwalder_qde_2016}. Another aspect is the rendering,
which is using a special form of ray tracing as described in ``Volume ray
casting --- basics \& principles''~\cite{osterwalder_volume_2016}.

The next chapter on the \textit{methodologies} introduces a concept called
literate programming and elaborates some details of the implementation using
literate programming. Additionally it introduces standards and principles
concerning the implementation of the intended software.

The following chapter on the \textit{results} concludes on the implementation
of the editor and the player components.
% TODO: Elaborate more? OK like this.

% TODO: Move this to a more fitting place
% ray casting --- basics \& principles''~\cite{osterwalder_volume_2016}. As the
% editor component defines the whole data structure it builds the basis of the
% thesis and can be seen as main part of the thesis. The player component re-uses
% concepts established within the editor.
% Given that literate programming is very complete and elaborated, as components
% being developed using this procedure are completely derived from the
% documentation, the actual implementation is found in the appendix as otherwise
% this thesis would be simply too extensive.

The last chapter is \textit{discussion and conclusion} and discusses the
methodologies as well as the results. Some further work on the editor and the
player components is proposed as well.

After the regular content follows the \textit{appendix}, containing the
requirements for building the before mentioned components, the actual source
code in form of literal programming as well as test cases for the components.
% TODO: Add missing content, if content _is_ missing.
