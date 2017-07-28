% -*- coding: utf-8; mode: latex; -*-

\chapter*{Abstract}
\label{chap:abstract}

% Richtet sich der Bericht an eine breitere Öffentlichkeit oder an technische Laien, die aufgrund fehlender
% Sachkenntnis nicht den ganzen Bericht lesen wollen, dann kann die Zusammenfassung zum
% wichtigsten Teil eines Berichts werden [3, p. 24]. Die Zusammenfassung ist der meistgelesene Teil
% einer Publikation. Sie gibt einen Überblick zur Problemstellung, zum Inhalt und zu den Resultaten des
% Berichts. Eine gute Zusammenfassung kann die Leserin, den Leser ermutigen, ausgewählte Teile der
% Arbeit oder den gesamten Bericht zu studieren.
% Die Zusammenfassung muss unabhängig vom Rest der Arbeit verständlich sein und besonders
% schlüssig formuliert werden. Literaturangaben werden in der Zusammenfassung keine gemacht.
% Die Zusammenfassung gehört an den Anfang eines Berichts. Oft wird sie auch mit Abstract oder
% Summary bezeichnet.
% Je nach Länge der Arbeit werden der Auftrag, die Ausgangslage, das Vorgehen und die wesentlichen
% Ergebnisse und Schlussfolgerungen des Berichts im Umfang zwischen einer halben und maximal einer
% ganzen A4-Seite dargelegt. Die eigenen Resultate bilden den inhaltlichen Schwerpunkt der
% Zusammenfassung.
% Die Zusammenfassung wird erst am Ende des Arbeitsprozesses verfasst.

\newthought{Computer science has always strived} to create representations of
scenes and models as near to human reality as possible. One such representation
is~\emph{ray tracing}, based on the physics of light as well as the properties
of surface materials. In contrast to ray tracing,~\emph{sphere tracing} allows
the rendering of ray traced images in real-time.

\newthought{The de facto way of representing objects} however, using triangle
based meshes, cannot be used directly with this method. Instead, an alternative
basis uses distance fields defined by implicit functions. At present there are
no solutions known to the author that provide a convenient way to use implicit
functions for modeling and sphere tracing for rendering.

\newthought{This thesis presents the design and development} of a program which
provides both a modular, node based approach for modeling and animating objects
using implicit functions, and allows rendering in real-time using sphere
tracing.

\newthought{To reach the intended goal}, the approach was to develop a software
architecture and to use literate programming and the agile methodology of
extreme programming for development.~\emph{Literate programming} considers
programs as works of literature. A literate program includes documentation which
explains in human terms what the computer must do.
% To overcome one of the main
% challenges when developing the software --- continual change --- an adapted
% version of extreme programming was used. This methodology was selected because
% of experiences with projects involving continual adaption in which exact
% planning, analysis and design (as traditional methodologies require) would not
% have been very practical.

\newthought{The results of this thesis} are an architecture for a software
program, and the program itself, written using the literate programming
paradigm.
\newthought{Three aspects define the software architecture}:
\begin{enumerate*}
  \item the model-view-view model software design pattern using controllers in
    addition,
  \item the layered software architectural pattern and
  \item the observer software design pattern, allowing communication between
    components of the software.
\end{enumerate*}

\newthought{The software itself} is an editor which allows modeling objects,
composing objects to scenes and rendering scenes in real-time. Scenes are stored
in a scene graph structure and are represented by a tree view. Each scene can
contain one or more objects, defined by external files and represented as nodes
in the graph structure. The parameters of objects are used for interconnections
between nodes. For rendering, the sphere tracing algorithm established in the
preceding project work was used.

\newthought{Literate programming takes some accustomization} as it requires a
different way of thinking to that of conventional software development. Despite
this, the basic goals could be reached. Sphere tracing is a very interesting and
promising approach to rendering which is coming into use in the industry, for
example for calculating ambient occlusion or soft shadows. Time will tell if the
method will establish itself further and become practicable for rendering
conventional meshes.