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
\newthought{The last chapter} covered some administrative aspects including the
involved persons, the phases and milestones of the thesis as well as its
schedule.

% Focus: What does this chapter specifically do?
% Now focus the reader’s attention on what this chapter is specifically going to
% do and why it is important. In this chapter I will examine.. I will present… I
% will report … This is crucial in (aim of thesis/research question) in order to….
\newthought{This chapter} presents the fundamentals which are required for
understanding of the result of this thesis.

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
that is used for the implementation of the intended software. It is mainly a
summary of the previous project work,~\enquote{QDE --- a visual animation
system, architecture}~\cite{osterwalder_qde_2016}. The second section shows the
algorithm which is used for rendering. It is a summary of a previous project
work,~\enquote{Volume ray casting --- basics \&
principles}~\cite{osterwalder_volume_2016}.

\section{Software architecture}
\label{sec:architecture}

\newthought{``An architecture is the \textit{set of significant
decisions}} about the organization of a software system, the selection of
\textit{structural elements} and their interfaces by which the system is
composed, together with their \textit{behavior} as specified in the
collaborations among those elements, the \textit{composition} of these elements
into progressively larger subsystems, and the \textit{architectural style} that
guides this organization -- these elements and their interfaces, their
collaborations, and their composition.''~\cite{kruchten_rup_2003}

Or as~\citeauthor{fowler_architect_2003} puts it:~\enquote{Whether something
is part of the architecture is entirely based on whether the developers think it
is important. [...] So, this makes it hard to tell people how to describe their
architecture.~\enquote{Tell us what is important.} Architecture is about the
important stuff. Whatever that is.}~\cite{fowler_architect_2003}

\newthought{This~\autoref{sec:architecture}} is a summary of the previous
project work of the author,~\enquote{QDE --- a visual animation system,
architecture}~\cite{osterwalder_qde_2016}. It describes the fundamentals for the
architecture for the intended software of this thesis.

\section{Rendering}
\label{sec:rendering}

\newthought{This~\autoref{sec:rendering}} is a summary of a previous project
work of the author,~\enquote{Volume ray casting --- basics \&
principles}~\cite{osterwalder_volume_2016}. It describes the fundamentals for
the rendering algorithm that is used for the intended software of this thesis.

\newthought{Rendering} is one of the main aspects of this thesis, as the main
objective of the thesis is the design and development of a software for
modeling, composing and \textit{rendering} real time computer graphics through a
graphical user interface. \citeauthor{foley_computer_1996} describes rendering
as a~\enquote{process of creating images from
models}~\cite{foley_computer_1996}. The basic idea of rendering is to determine
the color of a surface at a certain point. For this task two concepts have
evolved: \textit{illumination models} and \textit{shading models}.
\newthought{Shading models} define when to use which illumination model and the
parameters for the illumination model.

\newthought{Illumination models} describe the amount of light that is
transmitted from a point on a surface to a viewer. There exist two kinds of
illumination models: local illumination models and global illumination models.
Whereas local illumination models aggregate local data from adjacent surfaces
and directly incoming light, global illumination models consider also indirect
light. The algorithm used for rendering in the intended software is an
algorithm using a \textit{global illumination model}.

\newthought{Global illumination models}~\enquote{express the light being
transferred from one point to another in terms of the intensity of the light
emitted from the first point to the second}~\cite[pp. 775 and
776]{foley_computer_1996}. Additionally to this direct intensity the indirect
intensity is considered, therefore ~\enquote{the intensity of light emitted from
all other points that reaches the first and is reflected from the first to the
second}~\cite[pp. 775 and 776]{foley_computer_1996} point is added.

\newthought{In 1986 James~\enquote{Jim}~Kajiya} set up the so called rendering
equation, which expresses this behavior.~\parencites{kajiya_rendering_1986}[p.
776]{foley_computer_1996}

\begin{figure}
  \label{eq:rendering-equation}
  \caption[][-120pt]{The rendering equation as defined by James Kajiya.}
  \begin{equation}
    I(x, x') = g(x, x')[\varepsilon(x, x') + \int\limits_{S}\rho(x, x', x'')I(x', x'')dx'']
  \end{equation}
\end{figure}

\marginnote[-130pt]{%
  \begin{description}
    \item[$x, x' \text{and } x''$] Points in space.
    \item[$I(x, x')$] Intensity of the light going from point $x'$ to point $x$.
    \item[$g(x, x')$] A geometrical term.
      \begin{description}
        \item[$0$] $x$ and $x'$ are occluded by each other.
        \item[$1\over{r^2}$] $x$ and $x'$ are visible to one other, $r$ being
          the distance between the two points.
      \end{description}
    \item[$\varepsilon(x, x')$] Intensity of the light being emitted from point
      $x'$ to point $x$.
    \item[$\rho(x, x', x'')$] Intensity of the light going from $x''$ to $x$, being
      scattered on the surface of point $x'$.
    \item[$\int\limits_{S}$] Integral over the union of all surfaces, hence $S =
      \bigcup\limits_{i=0}^{n} S_{i}$, $n$ being the number of surfaces.
      All points $x$, $x'$ and $x''$ brush all surfaces of all objects within
      the scene. $S_{0}$ being an additional surface in form of a hemisphere
      which spans the whole scene and acts as background.
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
directly for rendering images in viable or even real time is not really
feasible, even on modern hardware. The procedure is computationally complex and
very time demanding.

\newthought{A simplified approach} to implement global illumination models (or
the rendering equation) is ray tracing. Ray tracing is able to produce high
quality, realistic looking images. Although it is still demanding in terms of
time and computations, the time complexity is reasonable for producing still
images. For producing images in real time however, the procedure is still too
demanding. This is where a special form of ray tracing comes in.

\newthought{Sphere tracing} is a ray tracing approach for implicit surfaces
introduced in~\citeyear{hart_sphere_1994} by~\citeauthor{hart_sphere_1994} in
his work~\citetitle{hart_sphere_1994}~\cite{hart_sphere_1994}. 
Sphere tracing is faster than the classical ray tracing approaches in finding
intersections between rays and objects. In contrast to the classical ray tracing
approaches, the marching distance on rays is not defined by an absolute or a
relative distance, instead distance functions are used. The distance functions
are used to expand unbounding volumes (in this concrete case spheres, hence the
name) along rays.~\autoref{fig:} illustrates this procedure.

\begin{figure}[h]
    \caption{Illustration of the sphere tracing
      algorithm.
      Ray~\textit{e} hits no objects until reaching the horizon at
      $d_{max}$. Rays~\textit{f},~\textit{g} and~\textit{h} hit
      polygon~\textit{poly1}.
      \protect\footnotemark}\label{fig:sphere_tracing_1}
    \centering
    \includegraphics{images/sphere_tracing_principle}
\end{figure}
\footnotetext{Own illustration using Inkscape.}

\newthought{Unbounding volumes} contrast with bounding volumes, which enclose a
solid. Unbounding volumes enclose a part of space without including certain
objects (whereas including means touching). For calculating a unbounding volume,
the distance between an object and the origin is being searched. Is this
distance known, it can be taken as a radius of a sphere. Sphere tracing defines
objects as implicit surfaces using distance functions. Therefore the distance
from every point in space to every other point in space and to every surface of
every object is known. These distances build a so called distance field.

\newthought{The sphere tracing algorithm} is as follows. A ray is being shot
from a viewer (an eye or a pinhole camera) through the image plane into a scene.
The radius of an unbounding volume in form of a sphere is being calculated at
the origin, as described above. This radius builds an intersection with the ray
and represents the distance, that the ray will travel in a first step. From this
intersection the next unbounding volume is being expanded and its radius is
being calculated, which gives the next intersection with the ray. This procedure
continues until an object is being hit or until a predefined maximum distance of
the ray $d_{max}$ is being reached. An object is being hit, whenever the
returned radius of the distance function is below a predefined constant
$\epsilon$. A possible implementation of the sphere tracing algorithm is shown
in~\autoref{alg:sphere_tracing}.

 \begin{figure}
   \caption{An abstract implementation of the sphere tracing algorithm\protect\footnotemark.}
   \begin{minted}{python}
def sphere_trace():
    ray_distance          = 0
    estimated_distance    = 0
    max_distance          = 9001
    convergence_precision = 0.000001

    while ray_distance < max_distance:
        # sd_sphere is a signed distance function defining the implicit surface
        # cast_ray defines the ray equation given the current traveled /
        # marched distance of the ray
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
   \end{minted}
\end{figure}
\footnotetext{Algorithm in pseudo code, after~\cite{hart_sphere_1994}[S. 531, Fig. 1]}