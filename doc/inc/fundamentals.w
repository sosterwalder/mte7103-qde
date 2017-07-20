% -*- mode: latex; coding: utf-8 -*-

\chapter{Fundamentals}
\label{chap:fundamentals}

% Der aktuelle Wissensstand zum behandelten Thema oder zur Fragestellung muss zu
% Beginn der Arbeit beschrieben werden. Die Vorarbeiten und Publikationen, auf die
% sich der Bericht stützt, werden genannt [3, p. 26]. Je nach Arbeit und
% Zielpublikum werden die Grundlagen kurz zusammengefasst und einander
% gegenübergestellt. Der theoretische Hintergrund oder Normen, die für die
% Untersuchung eine Rolle spielen, werden objektiv dargestellt. Gibt es nur sehr
% wenige Grundlagen, die eingangs der Arbeit erläutert werden müssen, können diese
% Informationen auch als Absatz in der Einleitung oder als Unterkapitel zum
% Kapitel der Einleitung verfasst werden.

% Link to previous
% Make a connection to what has immediately gone before. Recap the last chapter.
% In the last chapter I showed that… Having argued in the previous chapter that…
% As a result of x, which I established in the last chapter….. It is also possible
% to make a link between this chapter and the whole argument… The first step in
% answering my research question (repeat question) .. was to.. . In the last
% chapter I …
\newthought{The previous chapter} covered administrative aspects including the
persons involved, phases and the schedule, and milestones of the project work.

% Focus: What does this chapter specifically do?
% Now focus the reader’s attention on what this chapter is specifically going to
% do and why it is important. In this chapter I will examine.. I will present… I
% will report … This is crucial in (aim of thesis/research question) in order to….
\newthought{This chapter} presents the fundamentals which are required for
an understanding of this thesis.

% Overview: How is it done?
% The third paragraph simply outlines the way that you are going to achieve the
% aim spelled out in the previous paragraph. It’s really just a statement of the
% contents in the order that the reader will encounter them. It is important to
% state these not simply as topics, but actually how they build up the internal
% chapter argument… I will begin by examining the definitions of, then move to
% seeing how these were applied… I first of all explain my orientation to the
% research process, positioning myself as a critical scholar.. I then explain the
% methodology that I used in the research, arguing that ethnography was the most
% suitable approach to provide answers to the question of…
\newthought{The first section of this chapter} defines the software architecture
that would be used for the implementation of the program implemented. It is
mainly a summary of the previous project work,~\enquote{QDE --- a visual
animation system, architecture}~\cite{osterwalder-qde-2016}. The second section
shows the algorithm which is used for rendering. It is a summary of a previous
project work,~\enquote{Volume ray casting --- basics \&
principles}~\cite{osterwalder-volume-2016}.

\section{Software architecture}
\label{soarch}
% \label{fundamentals:sec:software-architecture}

\newthought{This section} is a summary of the previous project work of the
author,~\enquote{QDE --- a visual animation system,
architecture}~\cite{osterwalder-qde-2016}. It describes the fundamentals for the
architecture for the program implemented for this thesis.

\newthought{Software architecture} is inherent to software engineering and
software development. It may be implicit, for example when developing a smaller
program where the concepts are intuitively clear and the design decisions are
self-explanatory. Unfortunately, sometimes momentary~\enquote{self-explanatory}
decisions are in retrospect deceptive, so that some documentation may be
necessary. But the architecture may also be developed as an initial conceptual
process, for instance when developing large and complex programs.

\newthought{But what is software
architecture?}~\citeauthor{kruchten_rup_2003}~\cite{kruchten_rup_2003} defines
software architecture as follows:~\enquote{An architecture is the \textit{set of
significant decisions} about the organization of a software system, the
selection of \textit{structural elements} and their interfaces by which the
system is composed, together with their \textit{behavior} as specified in the
collaborations among those elements, the \textit{composition} of these elements
into progressively larger subsystems, and the \textit{architectural style} that
guides this organization -- these elements and their interfaces, their
collaborations, and their composition.}

Or as~\citeauthor{fowler_architect_2003}~\cite{folwer_architect_2003} puts
it:~\enquote{Whether something is part of the architecture is entirely based on
whether the developers think it is important. [...] So, this makes it hard to
tell people how to describe their architecture.~\enquote{Tell us what is
important.} Architecture is about the important stuff. Whatever that
is.}

\newthought{The idea envisaged for this thesis} of using a node based graph for
modeling objects and scenes and rendering them using sphere tracing, was
developed in advance of this thesis. To ensure that this technical
implementation was really feasible, a prototype was developed during the
previous project
work~\enquote{\citetitle{osterwalder-volume-2016}}~\cite{osterwalder-volume-2016}.

\newthought{The architecture of this prototype} had however evolved implicitly,
and showed itself as hard to maintain and extend by providing no clear
segregation between the data model and its representation.

\newthought{With the next project
work},~\enquote{\citetitle{osterwalder-qde-2016}}, a software architecture was
developed to prevent the occurrence of such problems. The software architecture
is based on the rational unified process (RUP)~\cite{kruchten_rup_2003} what
leads to an iterative approach.

\newthought{Based on the vision} of this thesis and using the methodologies of
RUP, actors are defined. The actors in turn are participants in use cases that
define functional requirements for the behavior of a system. The definition of
use cases shows the limitations of the program and define its functionality and
therefore the requirements.

\newthought{The components}, shown in~\autoref{table:software-components}
and~\autoref{fig:editor-components}, are established based on these
requirements.

\begin{table}[h]
  \begin{tabularx}{\textwidth}{lX}
    \toprule
    \textbf{Component} & \textbf{Description} \\
    \midrule
    Player & Reads objects and scenes defined by the editor component and plays
    them back in the defined chronological order.\\
    Editor & Allows modeling and composing of objects and
    scenes using a node based graphical user interface. Renders objects
    and scenes in real time using sphere tracing. \\
    \bottomrule
  \end{tabularx}
  \caption{Description of the components of the program implemented.}
  \label{table:software-components}
\end{table}

\begin{table}[h]
  \begin{tabularx}{\textwidth}{lX}
    \toprule
    \textbf{Sub component} & \textbf{Description} \\
    Scene tree & Holds scenes in a tree like structure. A scene is a directed
    graph holding nodes.                                           \\
    Node graph & Contains all nodes which define a single scene.   \\
    Parameter  & Holds the parameters of a node of the node graph. \\
    Rendering  & Renders a node, presenting it for a viewer.       \\
    Time line  & Depicts temporal events in terms of scenes which follow a
    chronological order.                                           \\
    \bottomrule
  \end{tabularx}
  \caption{Description of the sub components of the editor component.}
  \label{table:editor:sub-components}
\end{table}

\begin{figure}[ht]
  \caption{%
    A mock up of the editor application showing its components.\newline{}
    1: Scene tree.\newline{}
    2: Node graph.\newline{}
    3: Parameter view.\newline{}
    4: Rendering view.\newline{}
    5: Time line.
  }
  \label{fig:editor-components}
  \includegraphics[width=0.95\linewidth]{images/editor-components}
\end{figure}

\newthought{Identifying the components} helps finding the important conceptual items.
Decomposing a domain into noteworthy concepts is~\enquote{the quintessential object-oriented analysis
step}~\cite{larman-applying-2004}.~\enquote{The domain model is a visual
representation of conceptual classes or real-situation objects in a
domain.}~\cite{larman-applying-2004}

\newthought{The editor and player components} are shown
in~\autoref{fig:editor-domain-model} and in~\autoref{fig:player-domain-model}
respectively in the form of a domain model. Each domain model is composed of
components which build the sub components of the parent component, in this case
the editor and player. These sub components represent the objects of the
respective domain.

\begin{figure*}[h]
  \caption{Domain model of the editor component.}
  \label{fig:editor-domain-model}
  \includegraphics[width=0.95\linewidth]{images/editor-domain-model}
\end{figure*}

\begin{figure*}[ht]
  \caption{Domain model of the player component.}
  \label{fig:player-domain-model}
  \includegraphics[width=0.95\linewidth]{images/player-domain-model}
\end{figure*}

% TODO: Add may be a reference to the documentation? The image of the editor
% domain model is too small to be read. --> Bigger, scaled and rotated. One
% figure per page.

\newthought{Identifying the important concepts} allows the
definition of the logical architecture and shows the overall image of
(software) classes in form of packets, subsystems and layers. For a detailed
definition of these items the reader is referred to the previous project
work~\cite[pp. 37 ff.]{osterwalder-volume-2016}.

\newthought{To reduce dependencies and the coupling} of components
a~\enquote{relaxed layered} architecture is used. In contrast to a strict
layered architecture, which allows any layer to call services or interfaces only
from the layer below, a relaxed layered architecture allows higher layers to
communicate with any lower layer. The architecture defines five layers, as shown
in~\autoref{table:layers}.

\newthought{To ensure low coupling and dependencies} also for the graphical user
interface, the models and their views are segregated using the principle of
model-view separation which states that domain objects, which are data models,
should have no direct knowledge about their corresponding objects of the
graphical user interface.

\newthought{Workflow objects} control the user interaction with the visual
objects by keeping track of the data models. Such~\textit{controllers} support the
model-view separation principle and exist in the application layer.

\begin{table}[h]
  \caption{Layers as envisaged during the conceptual phase and used for
    the program implemented.}
  \label{table:layers}
  \begin{tabularx}{\textwidth}{lX}
    \toprule
    \textbf{Layer} & \textbf{Description}\\
    \midrule
    UI                 & All elements of the graphical user interface.                                       \\
    Application        & Controllers (workflow objects).                                                     \\
    Domain             & Data models according to the logic of the application.                              \\
    Technical services & Technical infrastructure, such as graphics, window creation and so on.              \\
    Foundation         & Basic elements and low level services, such as timer, arrays or other data classes. \\
    \bottomrule
  \end{tabularx}
\end{table}

\newthought{Class diagrams are used to provide a software point of view},
whereas domain models provide rather a conceptual point of view. A class
diagram~\footnote{The concepts of RUP and OOP are as used in the previous
project (QDE) and therefore will not be detailed here.} shows classes,
interfaces and their relationships.~\autoref{fig:editor-class-diagram} shows the
class diagram of the editor component and~\autoref{fig:player-class-diagram}
shows the class diagram for the player component.

\begin{figure*}[ht]
  \caption{Class diagram of the editor component.}
  \label{fig:editor-class-diagram}
  \includegraphics[width=0.95\linewidth]{images/editor-class-diagram}
\end{figure*}

\begin{figure*}[ht]
  \caption{Class diagram of the player component.}
  \label{fig:player-class-diagram}
  \includegraphics[width=0.95\linewidth]{images/player-class-diagram}
\end{figure*}

% TODO: Add may be a reference to the documentation? The images of the class
% diagrams are too small to be read. --> Bigger, scaled and rotated. One figure
% per page.

\section{Rendering}
\label{sec:rendering}

\newthought{This~\autoref{sec:rendering}} is a summary of the previous project
work of the author,~\enquote{Volume ray casting --- basics \&
principles}~\cite{osterwalder-volume-2016}. It describes the fundamentals for
the rendering algorithm that is used for the program implemented in this thesis.

\newthought{Rendering} is the second main aspect of this thesis, as the
objective is the design and development of a program for modeling, composing and
\textit{rendering} real time computer graphics by providing a graphical toolbox.

\newthought{\citeauthor{foley_computer_1996} describes rendering}
as a~\enquote{process of creating images from
models}~\cite{foley_computer_1996}. The basic idea of rendering is to determine
the color of a surface at each point. For this task two concepts have
evolved: \textit{illumination models} and \textit{shading models}.

\newthought{Illumination models} describe the amount of light that is
transmitted from a point on a surface to a viewer. There exist two kinds of
illumination models: local illumination models and global illumination models.
Whereas local illumination models aggregate local data from adjacent surfaces
and directly incoming light from light sources, global illumination models
consider also indirect light from reflections and refractions. The algorithm
used for rendering in the implemented program uses a \textit{global illumination
model}.

\newthought{Shading models} define when and how to use which illumination model.

\newthought{Global illumination models}~\enquote{express the light being
transferred from one point to another in terms of the intensity of the light
emitted}~\cite[pp. 775 and 776]{foley_computer_1996}. Additionally to this
direct intensity, the indirect intensity is considered, meaning~\enquote{the
intensity of light emitted from all other points that reaches the first and is
reflected from the first to the second}~\cite[pp. 775 and
776]{foley_computer_1996} point is added.

\newpage{}

\newthought{In 1986 James Kajiya} set up the so called rendering equation, which
expresses this behavior.~\parencites{kajiya_rendering_1986}[p.
776]{foley_computer_1996}

\begin{figure}
  \label{eq:rendering-equation}
  \caption{The rendering equation as defined by James~\enquote{Jim} Kajiya.}
  \begin{equation}
    I(x, x') = g(x, x')\left[\varepsilon(x, x') + \int\limits_{S}\rho(x, x', x'')I(x', x'')dx''\right]
  \end{equation}
\end{figure}

\marginnote{%-130pt
  \begin{description}
    \item[$x, x' \text{and } x''$] Points in space.
    \item[$I(x, x')$] Intensity of the light going from point $x'$ to point $x$.
    \item[$g(x, x')$] A geometrical scaling factor:
      \begin{itemize}
        \item[--] $0$ if $x$ or $x'$ are occluded by each other.
        \item[--] $\frac{1}{r^2}$ if $x$ and $x'$ are visible to one other, $r$ being
          the distance them.
      \end{itemize}
    \item[$\varepsilon(x, x')$] Intensity of the light being emitted from point
      $x'$ to point $x$.
    \item[$\rho(x, x', x'')$] Intensity of the light going from $x''$ to $x$, being
      scattered on the surface near point $x'$.
    \item[$\int\limits_{S}$] Integral over the union of all surfaces, hence $S =
      \bigcup\limits_{i=0}^{n} S_{i}$, $n$ being the number of surfaces.
      All points $x$, $x'$ and $x''$ brush all surfaces of all objects within
      the scene. Where $S_{i}$ is the surface of object $i$, and so $S_{0}$
      being an additional surface in form of a hemisphere which spans the whole
      scene and acts as background.
  \end{description}
}

% \begin{table}[h]
%   \caption{Description of the single aspects of the rendering equation.}
%   \begin{tabularx}{\textwidth}{lX}
%     \toprule
%     \textbf{Part} & \textbf{Description} \\
%     \midrule
%     $x, x' \text{and } x''$ & Points in space. \\
%     \midrule
%     $I(x, x')$ & Intensity of the light going from point $x'$ to point $x$. \\
%     \midrule
%     $g(x, x')$ & A geometrical term. \newline
%         \hspace*{4mm} $0$: \hspace*{2mm} $x$ and $x'$ are occluded by each other.
%         \newline
%         \hspace*{4mm} $1\over{r^2}$: \hspace*{1mm} $x$ and $x'$ are visible to one
%         other, $r$ being the \newline
%         \hspace*{12mm} distance between the two points. \\
%     \midrule
%     $\varepsilon(x, x')$ & Intensity of the light being emitted from point $x'$
%     to point $x$. \\
%     \midrule
%     $\rho(x, x', x'')$ & Intensity of the light going from $x''$ to $x$, being
%     scattered on the surface of point $x'$. \\
%     \midrule
%     $\int\limits_{S}$ & Integral over the union of all surfaces, hence $S =
%     \bigcup\limits_{i=0}^{n} S_{i}$, $n$ being the number of
%     surfaces.
%     All points $x$, $x'$ and $x''$ brush all surfaces of all objects within the
%     scene. $S_{0}$ being an additional surface in form of a hemisphere which
%     spans the whole scene and acts as background.\\
%     \bottomrule
%   \end{tabularx}
% \end{table}

\newthought{Implementing a global illumination model} or the rendering equation
directly for rendering images in viable (computational feasible in a workflow
for instance for the production of animated films) or even real time is not
really feasible, even on the fastest modern hardware (2017). The procedure is
computationally complex and very time demanding.

\newthought{A simplified approach} to implement global illumination models (and
the rendering equation) is ray tracing. Ray tracing is able to produce high
quality, realistic looking images. Although it is still demanding in terms of
time and computations, the time complexity is viable for producing still
images. For producing images in real time however, the algorithm is still too
demanding. This is where a special form of ray tracing comes in.

\newthought{Sphere tracing} is a ray tracing approach for implicit surfaces
introduced in~\citeyear{hart_sphere_1994} by~\citeauthor{hart_sphere_1994} in
his work~\citetitle{hart_sphere_1994}~\cite{hart_sphere_1994}. 
Sphere tracing is faster than the classical ray tracing approaches in its method
of finding
intersections between rays and objects. In contrast to the classical ray tracing
approaches, the~\enquote{marching distance} of rays is not defined by an absolute or a
relative distance, but instead, distance functions are used. The distance functions
are used to expand unbounding volumes (in this concrete case spheres, hence the
name) along rays.~\autoref{fig:sphere-tracing-1} illustrates this procedure.

\begin{figure}[h]
    \centering
    \includegraphics[width=0.75\linewidth]{images/sphere-tracing-principle}
    \caption{Illustration of the sphere tracing
      algorithm.
      Ray~\textit{e} hits no objects until reaching the horizon.
      Rays~\textit{f},~\textit{g} and~\textit{h} hit
      the solid~\textit{poly1}.}
      \label{fig:sphere-tracing-1}
\end{figure}

\newthought{Bounding volumes} are defined as the enclosure of a sold. On the
other hand, unbounding volumes are the space outside of a bounding volume,
including the surface of the solid itself. For calculating a unbounding volume,
the distance between an object and any defined origin point is evaluated. If
this distance is known, it can be taken as the radius of a sphere centered at
the origin point.

\newthought{Sphere tracing} defines objects as implicit surfaces using distance
functions. Therefore the distance from every point in space to every other point
in space and to every surface of every object can be calculated. These distances
build a so called distance field.

\newthought{The sphere tracing algorithm} is as follows. A ray is shot
from an origin point (for example, the viewer such as an eye or a pinhole camera) into a scene.
The radius of an unbounding volume in form of a sphere is calculated from
the origin, as described above. They ray intersects with the sphere, which gives
the distance that the ray will travel in a first step. From this
intersection the next unbounding volume (sphere) is expanded and its radius is
calculated, which gives the next intersection of the ray. This procedure
continues until an object is hit or until a predefined maximum distance of
the ray is being reached, defined as the~\enquote{horizon}. An object is
considered as~\enquote{hit} whenever the
returned radius of the distance function is below a predefined constant
$\epsilon$, the~\enquote{convergence precision}.

\newthought{A possible implementation} of the sphere tracing algorithm is shown
in~\autoref{alg:sphere-tracing}, although this shows only the distance
estimation. Shading is done in another implementation, for example in a
render method which calls the sphere trace method. Shading means in this context
the determination of the color of a surface or pixel.

\begin{figure*}
  \label{alg:sphere-tracing}
  \caption{%
    An abstract implementation of the sphere tracing algorithm. Algorithm in
    pseudo code, after~\cite{hart_sphere_1994}[S. 531, Fig. 1]
  }
  \begin{pythoncode}
def sphere_trace():
    ray_distance          = 0
    estimated_distance    = 0
    max_distance          = 9001
    max_steps             = 100
    convergence_precision = 0.000001

    while ray_distance < max_distance:
        # sd_sphere is a signed distance function defining the implicit surface.
        # cast_ray defines the ray equation given the current traveled /
        # marched distance of the ray.
        estimated_distance = sd_sphere(cast_ray(ray_distance))

        if estimated_distance < convergence_precision:
            # the estimated distance is already smaller than the desired
            # precision of the convergence, so return the distance the ray has
            # travelled as we have an intersection
            return ray_distance

        ray_distance = ray_distance + estimated_distance

    # When we reach this point, there was no intersection between the ray and a
    # implicit surface, so simply return 0
    return 0
  \end{pythoncode}
\end{figure*}

\newthought{Shading} is done as proposed by~\citeauthor{whitted_improved_1980}
in~\citetitle{whitted_improved_1980}~\cite{whitted_improved_1980}. This means,
that the sphere tracing algorithm must return which object was hit and its material.
Depending on the material, four cases can occur. The material may be:
\begin{enumerate*}
  \item reflective and refractive,
  \item reflective only,
  \item diffuse or
  \item emissive.
\end{enumerate*}
For simplicity only the third case is being taken into account. For the actual
shading a local illumination method is used, called~\textit{Phong shading}.

\newthought{The Phong illumination model}~\cite[p. 123]{foley_computer_1996} describes (reflected) light intensity
$I$ as a composition of the ambient, the diffuse and the perfect specular
reflection of a surface.

\begin{figure}
  \label{eq:phong-equation}
  \caption{%
    The Phong illumination model as defined by Phong Bui-Tuong.~\cite[p. 123]{foley_computer_1996} Note that
    the emissive term was left out intentionally as it is mainly used to achieve
    special effects.\newline{}
    \newline{}
    Foo.
  }
  \begin{equation}
    I(\vv{V}) = k_{a} \cdot L_{a} + k_{d} \displaystyle\sum_{i=0}^{n - 1} L_{i} \cdot (\vv{S_{i}} \cdot \vv{N}) + k_{s} \displaystyle\sum_{i=0}^{n - 1} L_{i} \cdot {(\vv{R_{i}} \cdot \vv{V})}^{k_{e}}
  \end{equation}
\end{figure}

% \marginnote[-130pt]{
\marginnote{
  \begin{description}
    \item[$I(x, x')$] Intensity of the light at point $\vv{V}$.
    \item[$k_{a}$] A constant defining the ratio of reflection of the ambient
      term of all points in the scene.
    \item[$L_{a}$] Intensity of the ambient light.
    \item[$k_{d}$] A constant defining the ratio of the diffuse term of incoming
      light.
    \item[$\displaystyle\sum_{i=0}^{n-1}$] Sum over all light sources in the scene.
    \item[$L_{i}$] Intensity of the~\emph{i}-th light source.
    \item[$\vv{S_{i}}$] Direction vector from the point on the surface toward
      light source~\emph{i}.
    \item[$\vv{N}$] Normal vector at the point of the surface.
    \item[$\vv{R_{i}}$] Direction that a perfectly reflected ray of light would
      take from this point on the surface.
    \item[$\vv{V}$] Direction pointing toward the viewer.
    \item[$k_{e}$] Shininess constant for the material.
  \end{description}
}