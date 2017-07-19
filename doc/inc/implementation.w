% -*- mode: latex; coding: utf-8 -*-

\chapter{Implementation}
\label{chap:implementation}

% Gestützt auf Quellen, Messungen und Datenerhebungen werden die anhand der
% Fragestellung gewon- nenen Ergebnisse präsentiert [3, p. 116]. Während das
% Kapitel zu Material und Methoden ( 3.2.3) oder das entsprechende Unterkapitel
% der Einleitung die Versuchsanordnung beschreibt, werden im Kapitel Ergebnisse
% der Versuchsablauf mit den Resultaten objektiv wiedergegeben. Alle Überlegungen,
% Berechnungen oder Experimente des Berichts müssen vollständig nachvollziehbar
% sein [3, p. 26]. Zusammen mit der Diskussion und den Folgerungen machen die
% Ergebnisse qualitativ und quantitativ den Hauptteil des Berichts aus [3, p. 26].

% Link to previous
% Make a connection to what has immediately gone before. Recap the last chapter.
% In the last chapter I showed that… Having argued in the previous chapter that…
% As a result of x, which I established in the last chapter….. It is also possible
% to make a link between this chapter and the whole argument… The first step in
% answering my research question (repeat question) .. was to.. . In the last
% chapter I …
\newthought{The previous chapter} introduced the methodologies that are required
for understanding the following implementation of this thesis.

% Focus: What does this chapter specifically do?
% Now focus the reader’s attention on what this chapter is specifically going to
% do and why it is important. In this chapter I will examine.. I will present… I
% will report … This is crucial in (aim of thesis/research question) in order to….
\newthought{This chapter} presents the achieved results by means of three
sections. The first section shows the software architecture that was developed
and that is used for the program implemented. Aspects of the developed literate
program are shown in the second section. The main concepts and the components of
the implemented program are shown in the third section.

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
% * Software architecture
% ** Reference to actual chapter
% ** Layers
% ** Signals
%
% * Literate programming
% ** Just mention, reference to actual chapter
%
% * Software
% ** Editor
% ** Player
% ** Components
%
% Nope, merged this already with focus.

% Input CF
% Resultate weniger kritisch, erst in Diskussion, überlappt sich aber.

\section{Software architecture}
\label{results:sec:software-architecture}

\newthought{The software architecture} holds the significant decisions of the
envisaged software, the selection of structural elements, their behavior and
their interfaces.~\cite{kruchten_rup_2003} It is derived from the experiences
based on the former project works,~\citetitle{osterwalder-volume-2016}
and~\citetitle{osterwalder-qde-2016}, which are condensed to build the
fundamentals, see~\ref{chap:fundamentals}.

\newthought{Three aspects} define the software architecture:
\begin{enumerate*}
  \item an architectural software design pattern,
  \item layers and
  \item signals, allowing communication between components.
\end{enumerate*}

\subsection{Software design}
\label{results:subsec:software-design}

\newthought{A [software] design pattern}~\enquote{names, abstracts, and
identifies the key aspects of a common design structure that make it useful for
creating a reusable object-oriented design. The design pattern identifies the
participating classes and instances, their roles and collaborations, and the
distribution of responsibilities. Each design pattern focuses on a particular
object-oriented design problem or issue. It describes when it applies, whether
it can be applied in view of other design constraints, and the consequences and
trade-offs of its use.}~\cite[p. 16]{gamma-dpe-1995}

\newthought{To separate data from its representation} and to ensure a coherent
design, a combination of the model-view-controller (MVC) and the model-view-view
model pattern (MVVM) is used as architectural software design
pattern.~\cite{fowler-presentation-2004, gossman-mvvm-2005} This decision is
based on experiences from the previous project works and allows to modify and
reuse individual parts. This is especially necessary as the data created in the
editor component will be reused by the player component.

\newthought{Four kinds of components} build the basis of the used
pattern.~\cref{table:software-design-pattern-components} provides a description
of the components.~\cref{fig:software-design-pattern-components} shows an
overview of the components (the colored items) including their communication.
Additionally the user as well as the display is shown (in gray color).

\begin{table*}[h]
  \begin{tabularx}{\textwidth}{llX}
    \toprule
    \textbf{Component} & \textbf{Description} & \textbf{Examples} \\
    \midrule
    Model      & Represents the data or the business logic, & Scene, Node
                                                              Parameter\\
               & completely independent from the user       & \\
               & interface. It stores the state and does    & \\
               & the processing of the problem domain.      & \\
    \midrule
    View       & Consists of the visual elements.           & Scene graph view,
                                                              Scene view\\
    \midrule
    View model & \enquote{Model of a view}, abstraction of  & Scene graph view
                                                              model, Scene\\
               & the view, provides a specialization of the & view model, Node
                                                              view model\\
               & model that the view can use for            & \\
               & data-binding, stores the state and may     & \\
               & provide complex operations.                & \\
    \midrule
    Controller & Holds the data in terms of models.         & Scene graph
                                                              controller, scene
                                                              controller,\\
               & models. Acts as an interface between the   & node controller\\
               & components.                                & \\
    \bottomrule
  \end{tabularx}
  \caption{Description of the components of the used software design
    pattern.~\cite{fowler-presentation-2004, gossman-mvvm-2005}}
  \label{table:software-design-pattern-components}
\end{table*}

\begin{figure*}[ht]
  \includegraphics[width=0.8\linewidth]{images/mvvmc}
  \caption{Components of the used pattern and their communication.}
  \label{fig:software-design-pattern-components}
\end{figure*}

% Reference Qt's view model and explain why it was not used.
\newthought{The used Qt framework} provides a very similar pattern respectively
concept called~\enquote{model/view pattern}. It combines the view and the
controller into a single object. The pattern introduces a delegate between view
and model, similar to a view model. The delegate allows editing the model and
communicates with the view. The communication is done by so called model indices
coming from the model. Model indices are references to items of
data.~\cite{qt-mvp-2017}~\enquote{By supplying model indexes to the model, the
view can retrieve items of data from the data source. In standard views, a
delegate renders the items of data. When an item is edited, the delegate
communicates with the model directly using model indexes.}~\cite{qt-mvp-2017}
\cref{fig:software-design-pattern-qt-mvp} shows the model/view pattern.

\begin{figure}[ht]
  \includegraphics[width=0.6\linewidth]{images/model-view-pattern}
  \caption{Qt's model/view pattern.~\cite{qt-mvp-2017}}
  \label{fig:software-design-pattern-qt-mvp}
\end{figure}

\newthought{Although offering advantages}, such as to customize the presentation
of items or the usage of a wide range of data sources, the model/view pattern was
not used in general. This is mainly due to two reasons:
\begin{enumerate*}
  \item the developed and intended components use no data source except external
    files and
  \item the concept of using model indices may add flexibility but introduces
    also overhead.
\end{enumerate*} The scene graph component of the editor was developed using
Qt's abstract item model class which uses the model/view pattern. This showed,
that the usage of the pattern can introduce unnecessary overhead, in terms of
being more effort to implement, while not using the features of the pattern.
Therefore the decision was taken against the usage of the pattern.

\subsection{Layers}
\label{results:subsec:layers}

\newthought{To reduce coupling and dependencies} a relaxed layered architecture
is used, as written in~\cref{results:sec:software-architecture}. In contrast to a strict
layered architecture, which allows any layer calling only services or interfaces
from the layer below, the relaxed layered architecture allows higher layers to
communicate with any lower layer.~\cref{table:results:layers} provides a
graphical overview as well as a description of the layers. The colors have no
meaning except to distinguish the layers visually.

\begin{table*}[h]
  \begin{tabularx}{\textwidth}{XXX}
    \toprule
    \textbf{Layer} & \textbf{Description} & \textbf{Examples} \\
    \midrule
    \includegraphics[width=1.0\linewidth]{images/layers-gui}         & All elements of the graphical user interface, views.                                  & Scene graph view, scene view, render view                                   \\
    \includegraphics[width=1.0\linewidth]{images/layers-gui-domain}  & View models.                                                                          & Scene graph view model, node view model                                     \\
    \includegraphics[width=1.0\linewidth]{images/layers-application} & Controller/workflow objects.                                                          & Main application, scene graph controller, scene controller, node controller \\
    \includegraphics[width=1.0\linewidth]{images/layers-domain}      & Models respectively logic of the application.                                         & Scene model, parameter model, node definition model, node domain model      \\
    \includegraphics[width=1.0\linewidth]{images/layers-technical}   & Technical infrastructure, such as graphics, window creation and so on.                & JSON parser, camera, culling, graphics, renderer                            \\
    \includegraphics[width=1.0\linewidth]{images/layers-foundation}  & Basic elements and low level services, such as a timer, arrays or other data classes. & Colors, common, constants, flags                                            \\
    \bottomrule
  \end{tabularx}
  \vspace*{\baselineskip}
  \caption{Layers of the developed software.}
  \label{table:results:layers}
\end{table*}

\subsection{Signals and slots}
\label{results:subsec:signals}

% Signals:  Explain what signals are and how they are used, maybe draw an
% illustrative diagram.

\newthought{Whenever designing and developing} software, coupling and cohesion
can occur and may pose a problem if not considered early enough and properly.
\textit{Coupling} measures how strongly a component is connected, has knowledge
of or depends on other components. High coupling impedes the readability and
maintainability of software. Therefore low coupling ought to be strived.
\citeauthor{larman-applying-2004} states, that the principle of low coupling
applies to many dimensions of software development and that it is one of the
cardinal goals in building
software.~\cite{larman-applying-2004}~\textit{Cohesion} is a measurement
of~\enquote{how functionally related the operations of a software element are,
and also measures how much work a software element is
doing}.~\cite{larman-applying-2004} Or put otherwise,~\enquote{a measure of the
strength of association of the elements within a module}.~\cite[p.
52]{ieee-swebok-2014} Low (or bad) cohesion does not imply, that a component
does work only by itself, indeed it probably collaborates with many other
objects. But low cohesion tends to create high (bad) coupling. It is therefore
strived to keep objects focused, understandable and manageable while supporting
low coupling.~\cite{larman-applying-2004}

\newthought{To overcome the problems} of high coupling and low
cohesion~\emph{signals and slots} are used. Signals and slots are a generalized
implementation of the observer pattern, which can be seen
in~\cref{fig:signals-observer-pattern}. 
\begin{figure}[ht]
  \includegraphics[width=0.8\linewidth]{images/observer-pattern}
  \caption{The observer pattern.~\cite{gamma-dpe-1995}}
  \label{fig:signals-observer-pattern}
\end{figure}

\newthought{A signal is an observable event.} A slot is a potential observer, typically a
function. Slots are registered as observers to signals. Whenever a signal is emitted, the
emitting class must call all the registered observers for that signal. Signals
an slots have a many-to-many relationship. One signal may be connected to any
number of slots and a slot may listen to any number of signals.

\begin{figure}
  \begin{pythoncode}
sender     = Sender()
observer_1 = Observer()

sender.emit_some_signal.connect(
    observer_1.some_slot
)
  \end{pythoncode}
  \label{lst:signal-slot}
  \caption{%
    An example of an observer being registered to a signal.
  }
\end{figure}

\newthought{Signals can hold additional information}, such as single values or
even references to objects. A simple example is loading nodes from files
containing node definitions. The node controller, which loads node definitions
from the file system, could emit two signals to inform other components, for
example components of the GUI layer.
\begin{enumerate*}
  \item The total amount of node definitions to load and
  \item the index of the last loaded node definition including a reference to
    the node definition
\end{enumerate*}
This information could for example be used by a dialog showing the progress of
loading node definitions from the file system. 

\begin{figure}
  \begin{pythoncode}
self.total_node_definitions.emit(num_node_definitions)
  \end{pythoncode}
  \label{lst:signal-slot-example-1}
  \caption{%
    An example of emitting a signal including a value.
  }
\end{figure}

\begin{figure*}
  \begin{pythoncode}
for index, definition_file in enumerate(node_definition_files):
    node_definition = self.load_node_definition_from_file(
        definition_file
    )
    self.node_definition_loaded(index, node_definition)
  \end{pythoncode}
  \label{lst:signal-slot-example-2}
  \caption{%
    An example of emitting a signal including a value and a reference to an
    object.
  }
\end{figure*}

\section{Literate programming}
\label{results:sec:literate-programming}

\newthought{Documentation is crucial to any software project.} However, all too
frequently the documentation is not done properly or is even neglected as it can
be quite effortful with seemingly little benefit. No documentation at all,
outdated or irrelevant documentation can cause unforeseen cost- and time-wise
efforts. Using the literate programming paradigm prevents these problems, as the
software emanates from the documentation. For this thesis literate programming
was used as described in~\ref{sec:literate-programming}.

\todo[inline]{Mention usage of nuweb here, again?}

\newthought{Another train of thought} is required when using literate
programming to develop software than when using traditional methodologies. This
is due to the fact, that the approach is completely different. Traditional
methodologies focus on instructing the computer what to do by writing program
code. Literate programming focuses on explaining to human beings what the
computer shall do by combining the documentation with code fragments in a single
document. From this single document a program which can be compiled or run
directly is extracted. The order of the code fragments matters only indirectly.
They may appear in any order throughout the text. The code fragments are put
into the right order for being compiled or run by defining the output files
containing the needed code fragments in the right order.

\newthought{The need to include every detail} makes literate programming very
expressive and verbose. While this expressiveness may be an advantage for small
software and partly also for larger software, it can also be a problem,
especially for larger software: the documentation can get lengthy and hard to
read, especially when including the implementation of technical details.

\newthought{These aspects} were overcome by moving the implementation into the
appendix~\todo{Insert reference to appendix here.} and by outsourcing similar
and very technical parts and output file definitions into a separate
file.~\todo{Insert reference to code fragments here.}

\section{Program}
\label{results:sec:program}

\newthought{To recall}, the objective of this thesis is the design and
development of a program for modeling, composing and rendering real-time
computer graphics by providing a graphical toolbox.

\newthought{Using the introduced methodologies}
(see~\ref{chap:methodologies}) and the developed software architecture
(see~\ref{results:sec:software-architecture}) this intended program was
implemented.

\newthought{The program implemented} is supposed to have two main components:
the~\textit{editor} and~\textit{player}.

\newthought{The editor component} provides a graphical system for modeling,
composing and rendering of scenes. It allows composing scenes to an animation
and to save an animation in an external file as a structure in a specific
format. Rendering is done using the shown sphere tracing algorithm combined with
Phong shading.

\newthought{The player component} simply plays an animation created with the
editor component.

\newthought{Due to time-related reasons} however, only the editor component was
implemented.~\autoref{fig:editor} shows an image of the program implemented.

\begin{figure}[ht]
  \caption{The implemented editor component.}
  \label{fig:editor}
  \includegraphics[width=0.95\linewidth]{images/editor-components}
\end{figure}

\newthought{The quintessence of both components} is to output respectively to
read a data structure in the JSON~\cite{ecma-json-2013} format which defines an
animation. This data structure provides the following elements:
\begin{enumerate*}
  \item an animation which contains
  \item scenes, which contain
  \item nodes.
\end{enumerate*}
This data structure is evaluated and the result at the end of that evaluation
is nothing else than shader-specific code which gets executed on the graphical
processing unit (GPU).

\newthought{An animation} is simply a composition of scenes which run in a
sequential order within a defined time span.

\newthought{A scene} is a composition of nodes in form of a directed graph.

\newthought{Nodes} are instances of node definitions and define the content of a
scene and therefore of an animation.

\newthought{Node definitions} provide content in a specific structure, shown
in~\autoref{table:node-definition-components}.

\begin{table}\centering
  \ra{1.3}
  \begin{tabularx}{\textwidth}{@@{}lX@@{}}
    \toprule
    \textbf{Property}    & \textbf{Description}                                         \\
    \hline
    \textit{ID}          & A global unique identifier (UUID\protect\footnotemark[1]{}). \\
    \textit{Name}        & The name of the node, e.g. "Sphere".                         \\
    \textit{Description} & A description of the node's purpose.                         \\
    \textit{Inputs}      & Parameters given to the node as inputs. This may be
    distinct types, e.g. float values or text input, references to other
    nodes.                                                                              \\
    \textit{Outputs}     & Values delivered by the node as outputs.                     \\
    \textit{Definitions} & A list of the node's definitions. This may be an
    actual definition of a (shader-) function in terms of an implicit surface.          \\
    \textit{Invocation}  & The format of a call to the node definition, including
    placeholders which will be replaced by parameters.                                  \\
    \textit{Parts}       & Defines text that may be processed when calling the node.
    Contains code which can be interpreted directly.                                    \\
    \textit{Nodes}       & The children a node has (child nodes). These entries are
    references to other nodes only.                                                     \\
    \textit{Parameters}  & A list of the node's inputs and outputs in form of
    tuples.
    Each tuple is composed of two parts:~\begin{enumerate*}
      \item a reference to another node and
      \item a reference to an input parameter or an output value of that node.
    \end{enumerate*} If the first reference is not set, this means that the
    parameter is internal.                                                              \\
    \bottomrule
  \end{tabularx}
  \caption{Properties/attributes of a node definition.}
  \label{table:node-definition-components}
\end{table}
\footnotetext[1]{https://docs.python.org/3/library/uuid.html}

\newthought{Content} is whatever a node definition provides in terms of the
definitions but the output has always to be an atomic type as defined
in~\autoref{table:node-definition-atomic-types}.

\begin{table}\centering
  \ra{1.3}
  \begin{tabularx}{\textwidth}{@@{}lX@@{}}
    \toprule
    \textbf{Type}    & \textbf{Description}                                         \\
    \hline
    \textit{Generic}          & A global unique identifier (UUID\protect\footnotemark[1]{}). \\
    \textit{Float}        & The name of the node, e.g. "Sphere".                         \\
    \textit{Text} & A description of the node's purpose.                         \\
    \textit{Scene}      & Parameters given to the node as inputs. This may be \\
    \textit{Image}     & Values delivered by the node as outputs.                     \\
    \textit{Dynamic} & A list of the node's definitions. This may be an \\
    \textit{Mesh}  & The format of a call to the node definition, including \\
    \textit{Implicit}       & Defines text that may be processed when calling the node.\\
    \bottomrule
  \end{tabularx}
  \caption{Atomic types, that define a node (definition).}
  \label{lst:node-definition-atomic-types}
\end{table}

\newthought{An example} of an node definition of type~\emph{implicit} for
rendering a sphere is given in~\autoref{fig:implicit-sphere-node-definition}.
\begin{figure*}
  \begin{minted}[%
    bgcolor=LightGray,
    escapeinside=||,
    linenos=true,
    mathescape=true,
    tabsize=4]{js}
{
    "name": "Implicit sphere",
    "id_": "16d90b34-a728-4caa-b07d-a3244ecc87e3",
    "description": "Definition of a sphere by using implicit surfaces",
    "inputs": [
        @<Implicit sphere node inputs@>
    ],
    "outputs": [
        @<Implicit sphere node outputs@>
    ],
    "definitions": [
        @<Implicit sphere node definitions@>
    ],
  \end{minted}
  \label{fig:node-definition-atomic-type}
  \caption{Teh cap.}
\end{figure*}

\begin{figure*}
  \begin{minted}[%
    bgcolor=LightGray,
    escapeinside=||,
    linenos=true,
    mathescape=true,
    tabsize=4]{js}
    "invocations": [
        @<Implicit sphere node invocations@>
    ],
    "parts": [
        @<Implicit sphere node parts@>
    ],
  \end{minted}
  \label{fig:node-definition-atomic-type-2}
  \caption{Teh cap 2.}
\end{figure*}

\begin{figure*}
  \begin{minted}[%
    bgcolor=LightGray,
    escapeinside=||,
    linenos=true,
    mathescape=true,
    tabsize=4]{js}
    "nodes": [
        @<Implicit sphere node nodes@>
    ],
    "connections": [
        @<Implicit sphere node connections@>
    ]
}
  \end{minted}
  \label{fig:node-definition-atomic-type-3}
  \caption{Teh cap 3.}
\end{figure*}

\newthought{Subsequent each component of the editor} is shown. This is done by
showing an adapted component diagram~\cite[pp. 653 -- 654]{larman-applying-2004}
and an entity relationship diagram~\cite[pp. 501 ff.]{larman-applying-2004}, if
appropriate, followed by a description of the component. The component diagrams
is used to show the signals a component emits and receives. The entity
relationship diagram is used to show the relationships between components. Not
all relationships are shown however, only the relations immediately related to
the presented component are shown as the diagrams would otherwise be too crowded
and confusing.

\newthought{To preserve clarity} all components are described in discrete
sections. Although the implementation of the components is very specific, in
terms of the programming language, their logic may be reused later on when
developing the player component.

\subsection{Editor}
\label{results:subsec:program:editor}

\begin{figure*}[ht]
  \caption{Component diagram of the editor component.}
  \label{fig:editor-component-diagram}
  \includegraphics[width=0.95\linewidth]{images/editor-component-diagram}
\end{figure*}

\begin{figure}[ht]
  \caption{Entity relationship diagram of the editor component.}
  \label{fig:editor-erd}
  \includegraphics[width=0.75\linewidth]{images/editor-erd}
\end{figure}

\newthought{The editor component} is the main component, which acts as entry
point for the application and ties all components together.
The~\verb=Application= class sets up all the controllers and the main window.
The~\verb=MainWindow= class sets up all the view-related components, therefore
the scene graph view, the scene view and the renderer.

\todo[inline]{Elaborate more? Is this really necessary? I think it will be rather boring.}

\subsection{Scene tree}
\label{results:subsec:program:scene-tree}

\begin{figure*}[ht]
  \caption{Component diagram of the scene tree component.}
  \label{fig:scene-graph-component-diagram}
  \includegraphics[width=0.95\linewidth]{images/scene-graph-component-diagram}
\end{figure*}

\begin{figure}[ht]
  \caption{Entity relationship diagram of the scene tree component.}
  \label{fig:scene-graph-erd}
  \includegraphics[width=0.75\linewidth]{images/scene-graph-erd}
\end{figure}

\newthought{The scene tree component} allows to manage the scenes of the system.
User interaction is provided by a tree-like view, which lets the user add,
remove and select scenes.

\todo[inline]{Elaborate more? Is this really necessary? I think it will be rather boring.}

% \subsection{Node graph}
% \label{results:subsec:program:node-graph}
% 
% \begin{figure*}[ht]
%   \caption{Component diagram of the node graph component.}
%   \label{fig:node-graph-component-diagram}
%   \includegraphics[width=0.95\linewidth]{images/node-graph-component-diagram}
% \end{figure*}
% 
% \begin{figure}[ht]
%   \caption{Entity relationship diagram of the node graph component.}
%   \label{fig:node-graph-erd}
%   \includegraphics[width=0.75\linewidth]{images/node-graph-erd}
% \end{figure}