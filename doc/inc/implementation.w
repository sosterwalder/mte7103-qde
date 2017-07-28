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
for understanding the results of this thesis.

% Focus: What does this chapter specifically do?
% Now focus the reader’s attention on what this chapter is specifically going to
% do and why it is important. In this chapter I will examine.. I will present… I
% will report … This is crucial in (aim of thesis/research question) in order to….
\newthought{This chapter} contours three sections. The first section shows the
software architecture that was developed and that is used for the program
implemented. Aspects of the literate form of this program implemented are shown
in the second section. The main concepts and the components of the program are
shown in the third section.

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

\newthought{The software architecture} defines the significant decisions of the
program implemented, such as the selection of structural elements, their
behavior and their interfaces.~\cite{kruchten_rup_2003} The architecture is
derived from the experiences based on the former projects,~\enquote{Volume ray
casting --- basics \& principles}~\cite{osterwalder-volume-2016}
and~\enquote{QDE --- a visual animation system,
architecture}~\cite{osterwalder-qde-2016}, which build the fundamentals of this
thesis, see~\autoref{chap:fundamentals}~\enquote{\nameref{chap:fundamentals}}.

\newthought{Three aspects} define the software architecture:
\begin{enumerate}
  \item an architectural software design pattern,
  \item layers and
  \item signals and slots, which allow communication between components.
\end{enumerate}

\subsection{Software design}
\label{results:subsec:software-design}

\newthought{A [software] design pattern}~\enquote{names, abstracts, and
identifies the key aspects of a common design structure that make it useful for
creating a reusable object-oriented design. The design pattern identifies the
participating classes and instances, their roles and collaborations, and the
distribution of responsibilities. Each design pattern focuses on a particular
object-oriented design problem or issue.}~\cite[p. 16]{gamma-dpe-1995}

\newthought{To separate data from its representation} and to ensure a coherent
design, a combination of the model-view-controller (MVC)~\cite{krasner-mvc-1988}
and the model-view-view model pattern (MVVM)~\cite{fowler-presentation-2004,
gossman-mvvm-2005} is used as architectural software design pattern. This
decision is based on experiences from the previous projects and allows
individual parts to be modified and reused. This is especially necessary as the
data created in the editor component will be reused by the player component.

\newthought{Four kinds of components} build the basis of the pattern
used.~\Cref{table:software-design-pattern-components} provides a description of
the components.~\Cref{fig:software-design-pattern-components-editor} shows an
overview of the components of the editor (the colored items) including their
communication in an informal way. Additionally the user as well as the display
is shown (in gray color). As the player component only plays animations, no view
models are needed and therefore only the MVC pattern is used, which is shown
in~\cref{fig:software-design-pattern-components-player}.

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
    View       & Consists of the visual elements.           & Scene tree view,
                                                              Scene view\\
    \midrule
    View model & \enquote{Model of a view}, the abstraction & Scene tree view
                                                              model, Scene\\
               & of the view, provides a specialization of  & view model, Node
                                                              view model\\
               & the model which the view can use for       & \\
               & data-binding. It also stores the state and & \\
               & may provide complex operations.            & \\
    \midrule
    Controller & Holds the data in terms of models.         & Scene tree
                                                              controller, scene
                                                              controller,\\
               & models. Acts as an interface between the   & node controller\\
               & components.                                & \\
    \bottomrule
  \end{tabularx}
  \caption{Description of the types of components of the software design
    pattern used.~\cite{fowler-presentation-2004, gossman-mvvm-2005}}
\label{table:software-design-pattern-components}
\end{table*}

\vspace{5mm}
  
\begin{figure*}[!htbp]
  \includegraphics[width=0.8\linewidth]{images/mvvmc}
  \caption{Components of the used pattern for the editor and their
    communication.}
\label{fig:software-design-pattern-components-editor}
\end{figure*}

\begin{figure*}[!htbp]
  \includegraphics[width=0.8\linewidth]{images/mvvmc-player}
  \caption{Components of the used pattern for the player and their
    communication.}
\label{fig:software-design-pattern-components-player}
\end{figure*}

\newthought{The Qt framework} which is used, offers a very similar pattern
called~\enquote{model/view pattern}. It combines the view and the controller
into a single object. The pattern introduces a delegate between view and model,
similar to a view model. The delegate allows editing the model and communicates
with the view. The communication is done by so called model indexes, which are
references to items of data.~\cite{qt-mvp-2017}~\enquote{By supplying model
indexes to the model, the view can retrieve items of data from the data source.
In standard views, a delegate renders the items of data. When an item is edited,
the delegate communicates with the model directly using model
indexes.}~\cite{qt-mvp-2017} \Cref{fig:software-design-pattern-qt-mvp} shows
this model/view pattern.

\begin{figure}[ht]
  \includegraphics[width=0.6\linewidth]{images/model-view-pattern}
  \caption{Qt's model/view pattern.~\cite{qt-mvp-2017}}
\label{fig:software-design-pattern-qt-mvp}
\end{figure}

\newthought{Although offering advantages}, such as to customize the presentation
of items or the usage of a wide range of data sources, the model/view pattern was
not used in this project. This is mainly due to two reasons:
\begin{enumerate*}
  \item the developed and intended components use no data source other than external
    files and
  \item the concept of using model indexes may add flexibility but also
    introduces overhead.
\end{enumerate*}

\newthought{The scene tree component} of the editor was developed using the Qt
class for the abstract item model, which uses the model/view pattern. This
showed that the usage of this pattern introduces unnecessary overhead and
requires more effort to implement, while not using the advantages of features of
the pattern. Therefore a decision was taken against the usage of the pattern in
this case.

\subsection{Layers}
\label{results:subsec:layers}

\newthought{To reduce coupling and dependencies} a relaxed layered architecture
is used, as written
in~\autoref{results:sec:software-architecture}~\enquote{\nameref{results:sec:software-architecture}}.
In contrast to a strict layered architecture, which allows any layer to call
only services or interfaces from the layer below, the relaxed layered
architecture allows higher layers to communicate with any lower
layer.~\Cref{table:results:layers} provides a graphical overview as well as a
description of the layers. The colors have no significance except to distinguish
the layers visually for the reader.

\begin{table*}[h]
  \begin{tabularx}{\textwidth}{XXX}
    \toprule
    \textbf{Layer} & \textbf{Description} & \textbf{Examples} \\
    \midrule
    \includegraphics[width=1.0\linewidth]{images/layers-gui}         & All elements of the graphical user interface, views.                                & Scene tree view, scene view, render view                                   \\
    \includegraphics[width=1.0\linewidth]{images/layers-gui-domain}  & View models.                                                                        & Scene tree view model, node view model                                     \\
    \includegraphics[width=1.0\linewidth]{images/layers-application} & Controller (workflow objects).                                                      & Main application, scene tree controller, scene controller, node controller \\
    \includegraphics[width=1.0\linewidth]{images/layers-domain}      & Data models according to the logic of the application.                              & Scene model, parameter model, node definition model, node domain model     \\
    \includegraphics[width=1.0\linewidth]{images/layers-technical}   & Technical infrastructure, such as graphics, window creation and so on.              & JSON parser, camera, culling, graphics, renderer                           \\
    \includegraphics[width=1.0\linewidth]{images/layers-foundation}  & Basic elements and low level services, such as timer, arrays or other data classes. & Colors, common, constants, flags                                           \\
    \bottomrule
  \end{tabularx}
  \vspace*{\baselineskip}
  \caption{Layers of the program implemented.}
\label{table:results:layers}
\end{table*}

\subsection{Coupling and cohesion, signals and slots}
\label{results:subsec:signals}

\newthought{Whenever designing and developing} software, coupling and cohesion
can occur and may pose a problem if not considered early and well enough.

\newthought{Coupling} measures how strongly a component is connected to other
components, or has knowledge of them or depends on them. High coupling impedes
the readability and maintainability of software, so programmers should strive
towards low coupling. \citeauthorfin{larman-applying-2004} states that the
principle of low coupling applies to many dimensions of software development and
that it is a major objective in building software.~\cite{larman-applying-2004}

\newthought{Cohesion} is a measurement of~\enquote{how functionally related the
operations of a software element are, and also measures how much work a software
element is doing}.~\cite{larman-applying-2004} Or put otherwise, it
is~\enquote{a measure of the strength of association of the elements within a
module}.~\cite[p. 52]{ieee-swebok-2014} Low (or poor) cohesion does not imply
that a component works only by itself, indeed it probably collaborates with many
other objects. But low cohesion tends to create high (poor) coupling. It is
therefore desirable to keep objects focused, understandable and manageable while
supporting low coupling.~\cite{larman-applying-2004}

\newthought{To overcome the problems} of high coupling and low
cohesion,~\emph{signals and slots} are used. Signals and slots are a generalized
implementation of the observer pattern, which can be seen informally
in~\cref{fig:signals-observer-pattern}
and~\cref{fig:signal-and-slot-relationship}.

\begin{figure}[!htbp]
  \includegraphics[width=0.8\linewidth]{images/observer-pattern}
  \caption{The observer pattern.~\cite{gamma-dpe-1995}}
\label{fig:signals-observer-pattern}
\end{figure}

\newthought{A signal is an observable event.} A slot is a potential observer,
typically a method of an object. An example of an observer is given
in~\cref{lst:signal-slot:observer-slot}.

\begin{figure}[!htbp]
  \begin{pythoncode}
class Observer:

    @@slot(type)
    def on_signal(self, parameter):
        """Listens on the signal 'signal'. Expects the
        signal to send the parameter 'parameter' of
        type 'type'."""

        ...
  \end{pythoncode}
  \caption{An example of a class called~\enquote{Observer} with a slot
    called~\enquote{on\_signal}. The slot expects the signal to send a parameter
    of type~\enquote{type}.
  }
\label{lst:signal-slot:observer-slot}
\end{figure}

\newthought{Slots are registered as observers} to signals as shown
in~\cref{lst:signal-slot:connect}.

\begin{figure}[!htbp]
  \begin{pythoncode}
subject.signal.connect(
    observer.on_signal
)
  \end{pythoncode}
  \caption{The~\enquote{on\_signal} slot (which is a method of the
    object~\enquote{observer}) is registered to the signal~\enquote{signal} of
    the object~\enquote{subject}.}
\label{lst:signal-slot:connect}
\end{figure}

\newthought{Whenever a signal is emitted}, the emitting class must call all the
registered observers for that signal as shown in~\cref{lst:signal-slot:emit}.

\begin{figure}[!htbp]
  \begin{pythoncode}
subject.signal.emit(some_parameter)
  \end{pythoncode}
  \caption{The signal~\enquote{signal} of the object~\enquote{subject} is
    emitted. The signal contains a parameter called~\enquote{some\_parameter}.
    This means that the emitting class,~\enquote{Signal}, will call the
    registered method~\enquote{on\_signal} of the observer
    called~\enquote{observer}.}
\label{lst:signal-slot:emit}
\end{figure}

\newthought{The relationship between signals and slots} is a many-to-many
relationship. One signal may be connected to any number of slots and a slot may
listen to any number of signals. A relationship between a signal and a slot is
shown in~\cref{fig:signal-and-slot-relationship}

\begin{figure}[!htbp]
  \includegraphics[width=0.8\linewidth]{images/signal-and-slot}
  \caption{An observer is listening to a signal sent by a subject. The subject
    emits the signal and calls then the observers that are registered for that
    signal (or the registered slots of the observers respectively).}
\label{fig:signal-and-slot-relationship}
\end{figure}

\newthought{Signals can carry additional information}, such as single values or
even references to objects. A simple example of a signal-slot relationship is
loading node definitions from files. The node controller, when it loads node
definitions, could emit two signals to inform other components. For example,
signal 1
\begin{enumerate*}
  \item gives the number of node definitions to load, and signal
  \item the index of the last loaded node definition and a reference to it.
\end{enumerate*}
This information could for example be used in a dialog showing the progress of
loading from the file system.

\begin{figure}[!htbp]
  \begin{pythoncode}
self.total_node_definitions.emit(num_node_definitions)
  \end{pythoncode}
  \caption{%
    An example of emitting a signal including a value.
  }
\label{lst:signal-slot-example-1}
\end{figure}

\begin{figure*}[!htbp]
  \begin{pythoncode}
for index, definition_file in enumerate(node_definition_files):
    node_definition = self.load_node_definition_from_file(
        definition_file
    )
    self.node_definition_loaded(index, node_definition)
  \end{pythoncode}
  \caption{%
    An example of emitting a signal including a value and a reference to an
    object.
  }
\label{lst:signal-slot-example-2}
\end{figure*}

\section{Literate programming}
\label{results:sec:literate-programming}

\newthought{Documentation is crucial to the maintenance or modification} of any
software project. However, all too frequently the documentation is not done
properly or is even neglected because of seemingly low benefit related to
effort. No documentation at all, outdated or irrelevant documentation can cause
unforeseen cost and time overruns. Using the literate programming paradigm
prevents these problems, as the software as well as the documentation are
derived from a literate program. For this thesis the LP system nuweb was used,
as described
under~\autoref{sec:literate-programming}~\enquote{\nameref{sec:literate-programming}}.

\newthought{Using literate programming to develop software} requires a different
way of thinking from traditional methodologies. The approach is completely
different. Traditional methodologies focus on instructing the computer what to
do by writing program code. Literate programming focuses on explaining to human
beings what the computer shall do by combining the documentation with code in a
single document. From this single document a program which can be compiled or
run directly is extracted. The order of the code fragments matters only
indirectly, they may appear in any order throughout the text. The code fragments
are put into the right order for compilation or running by defining the output
files containing the needed code fragments in the right order.

\newthought{The need to include every detail} makes literate programming very
expressive and verbose. While this expressiveness may be an advantage for small
software and partly also for larger software, it can also be a problem,
especially for larger software: the documentation becomes lengthy and hard to
read, especially when including the full implementation of technical details.

\newthought{These problems} in the writing of this thesis were overcome by
moving the implementation into the appendix,
see~\autoref{part:appendix}~\enquote{\nameref{part:appendix}} and by outsourcing
technical parts into a separate file,
see~\autoref{sec:code-fragments}~\enquote{\nameref{sec:code-fragments}}.

\section{Program}
\label{results:sec:program}

\newthought{To recall}, the objective of this thesis is the design and
development of a program for modeling, composing and rendering real-time
computer graphics by providing a graphical toolbox.

\newthought{Using the introduced methodologies}
(see~\autoref{chap:methodologies}~\enquote{\nameref{chap:methodologies}}) and
the developed software architecture
(see~\autoref{results:sec:software-architecture}~\enquote{\nameref{results:sec:software-architecture}})
a program was implemented.

\newthought{The program implemented} should to have two main components:
the~\textit{editor} and~\textit{player}.

\newthought{The editor component} provides a graphical system for modeling,
composing and rendering of scenes. It allows composing scenes into an animation
and saving the animation in an external file. Rendering is done using the shown
sphere tracing algorithm combined with Phong shading.

\newthought{The player component} simply plays an animation which has been
created with the editor component. This includes loading and rendering of all
scenes.

\newthought{Due to time constraints}, however, only the editor component was
implemented.~\autoref{fig:editor} shows an image of the program implemented.

\newthought{For the implementation} the following tools were used: the Python
programming language~\protect\footnote{version 3.5.2,
\url{http://www.python.org}}, the Qt cross-platform application development
framework~\protect\footnote{version 5.7, \url{https://www.qt.io/}}, the PyQt5
bindings~\protect\footnote{version 5.7,
\url{https://riverbankcomputing.com/software/pyqt/intro}} for Qt and
OpenGL~\protect\footnote{version 3.3, \url{https://www.opengl.org/}}.

\vspace{10mm}

\begin{figure}[!htbp]
  \includegraphics[width=0.95\linewidth]{images/editor}
  \caption{The implemented editor component.}
\label{fig:editor}
\end{figure}

\newthought{The quintessence of both components} is to output respectively to
read a data structure in the JSON~\cite{ecma-json-2013} format which defines an
animation. This data structure provides an animation which contains scenes,
which contain nodes. This data structure is evaluated and the result is
shader-specific code which is executed by the graphical processing unit (GPU)
and seen by the viewer.

\newthought{An animation} is simply a composition of scenes which run in a
sequential order within a defined time span.

\newthought{A scene} is a composition of nodes stored in the form of a directed
graph.

\newthought{Nodes} are instances of node definitions and define the content of a
scene and therefore of an animation.

\newthought{Node definitions} provide content in a specific structure, shown
in~\autoref{table:node-definition-components}.

\begin{table}[!htbp]\centering
  \ra{1.3}
  \begin{tabularx}{\textwidth}{@@{}lX@@{}}
    \toprule
    \textbf{Property}    & \textbf{Description}                                \\
    \hline
    \textit{ID}          & A global unique identifier.                         \\
    \textit{Name}        & The name of the node, e.g. "Sphere".                \\
    \textit{Description} & A description of the node's purpose.                \\
    \textit{Inputs}      & Parameters given to the node. These may have 
    distinct types, e.g. scalars as floating point numbers or character strings
    of type text, references to other nodes.                                   \\
    \textit{Outputs}     & Values delivered by the node.                       \\
    \textit{Definitions} & A list of the node's definitions. This may be an
    actual definition of a (shader-) function in terms of an implicit surface. \\
    \textit{Invocation}  & The format of a call to the node definition, including
    placeholders which will be replaced by parameters.                         \\
    \textit{Parts}       & Defines text that may be processed when calling the node.
    Contains code which can be interpreted directly.                           \\
    \textit{Nodes}       & The children a node has (child nodes). These entries are
    references to other nodes only.                                            \\
    \textit{Parameters}  & A list of the node's inputs and outputs in form of
    tuples.
    Each tuple is composed of two parts:~\begin{enumerate*}
      \item a reference to another node and
      \item a reference to an input parameter or an output value of that node.
    \end{enumerate*} If the first reference is not set, this means that the
    parameter is internal.                                                     \\
    \bottomrule
  \end{tabularx}
  \caption{Properties/attributes of a node definition.}
\label{table:node-definition-components}
\end{table}

\newthought{Content} is whatever a node definition provides in terms of the
definitions but the output has always to be an atomic type as defined
in~\cref{table:node-definition-atomic-types}.

\begin{table}[!htbp]\centering
  \ra{1.3}
  \begin{tabularx}{\textwidth}{@@{}lX@@{}}
    \toprule
    \textbf{Atomic type} & \textbf{Description}                       \\
    \midrule
    \textit{Generic}     & A global unique identifier.                \\
    \textit{Float}       & A floating point value.                    \\
    \textit{Text}        & Characters as text string.                 \\
    \textit{Scene}       & Used for nesting scenes.                   \\
    \textit{Image}       & An image, typically a texture.             \\
    \textit{Dynamic}     & Dynamic values, e.g.\ time or sine values. \\
    \textit{Mesh}        & Triangle based meshes.                     \\
    \textit{Implicit}    & Implicit objects.                          \\
    \bottomrule
  \end{tabularx}
  \caption{Atomic types, that define a node (definition).}
\label{table:node-definition-atomic-types}
\end{table}

\newthought{An example} of an node definition of type~\emph{implicit} for
rendering a sphere is given
in~\autoref{results:subsec:program:node-graph}~\enquote{\nameref{results:subsec:program:node-graph}}.

\newthought{Subsequent each component of the editor} is shown in a component
diagram in adapted form~\cite[pp. 653 -- 654]{larman-applying-2004} and an
entity relationship diagram~\cite[pp. 501 ff.]{larman-applying-2004} (if
appropriate), followed by a description of the component. The component diagram
is used to show the signals that a component emits and receives. The entity
relationship diagram is used to show the relationships between components. Only
the relations immediately related to the presented component are shown, because
the diagrams would otherwise be too crowded and confusing.

\newthought{To preserve clarity} all components are described in discrete
sections of this chapter. Although the implementation of the components is very
specific, in terms of the programming language, their logic may be reused later
for the player component.

\newpage{}

\subsection{Editor}
\label{results:subsec:program:editor}

\begin{figure*}[!htbp]
  \includegraphics[width=0.55\linewidth]{images/editor-component-diagram}
  \caption{Component diagram of the editor component.}
\label{fig:editor-component-diagram}
\end{figure*}

\begin{figure}[!htbp]
  \includegraphics[width=0.75\linewidth]{images/editor-erd}
  \caption{Entity relationship diagram of the editor component.}
\label{fig:editor-erd}
\end{figure}

\newthought{The editor component} is the main component, which acts as entry
point for the application and ties all components together.
The~\verb=Application= class sets up all the controllers and the main window.
The~\verb=MainWindow= class sets up all the view-related components, therefore
the scene tree view, the scene view and the renderer.

\subsection{Scene tree}
\label{results:subsec:program:scene-tree}

\begin{figure*}[!htbp]
  \caption{Component diagram of the scene tree component.}
\label{fig:scene-graph-component-diagram}
  \includegraphics[width=0.5\linewidth]{images/scene-graph-component-diagram}
\end{figure*}

\begin{figure}[!htbp]
  \caption{Entity relationship diagram of the scene tree component.}
\label{fig:scene-graph-erd}
  \includegraphics[width=0.5\linewidth]{images/scene-graph-erd}
\end{figure}

\newthought{The scene tree component} enables the scenes of the animation to be
managed. User interaction is provided through a tree-like view, which lets the
user add, remove and select scenes.

\subsection{Node graph}
\label{results:subsec:program:node-graph}

\begin{figure*}[!htbp]
  \caption{Component diagram of the node graph component.}
\label{fig:node-graph-component-diagram}
  \includegraphics[width=0.5\linewidth]{images/node-graph-component-diagram}
\end{figure*}

\begin{figure}[!htbp]
  \caption{Entity relationship diagram of the node graph component.}
\label{fig:node-graph-erd}
  \includegraphics[width=0.5\linewidth]{images/node-graph-erd}
\end{figure}

\newthought{The node graph component} enables the nodes of a scene to be
managed. The nodes of a scene define its content.

\newthought{Each node has parameters} which define the properties of a node.
Such a parameter is for example the radius of a sphere for a node providing a
sphere of type implicit.

\newthought{Nodes have multiple inputs and one output} where each is of a
specific type, as described in~\cref{table:node-definition-atomic-types}. Inputs
point to parameters of a node whereas outputs provide values. An output of a
node may be connected to the input of another node. Every scene has a fixed
input by default which is currently limited to implicit types (outputs) and acts
as output of the scene.

\newthought{The~\emph{content} of a node} is depending on the type of the
node. The basis of the content is built by three things however:
\begin{enumerate*}
  \item its~\emph{definition},
  \item its~\emph{invocation} and
  \item its so called~\emph{part}.
\end{enumerate*}

\newthought{A definition of a node} is essentially a method written in OpenGL
Shading Language which defines the function of the
node.~\cref{fig:node-definition-example} shows an example of such a definition.
It defines an implicit sphere with a certain radius at a certain position.

\begin{figure}[!htbp]
  \begin{minted}[%
    bgcolor=LightGray,
    escapeinside=||,
    linenos=true,
    mathescape=true,
    tabsize=4]{js}
{
    "id_": "99d20a26-f233-4310-adb2-5e540726d079",
    "script": [
        "// Returns the signed distance to a sphere with",
        "//given radius for the given position.",
        "float sphere(vec3 position, float radius)",
        "{",
        "    return length(position) - radius;",
        "}"
    ]
}
  \end{minted}
\caption{Implementation of an implicit sphere in the OpenGL Shading Language
  (GLSL) as definition in JSON format.}
\label{fig:node-definition-example}
\end{figure}

\newpage{}

\newthought{The~\emph{invocation} of a node} is the call to a method defined by
the definition of a node. Invocations are also written in the OpenGL Shading
Language.~\cref{fig:node-invocation-example} shows an example of a invocation.

\begin{figure}[!htbp]
  \begin{minted}[%
    bgcolor=LightGray,
    escapeinside=||,
    linenos=true,
    mathescape=true,
    tabsize=4]{js}
{
    "id_": "4cd369d2-c245-49d8-9388-6b9387af8376",
    "type": "implicit",
    "script": [
        "float s = sphere(",
        "  16d90b34-a728-4caa-b07d-a3244ecc87e3-position,",
        "  5c6a538-1dbc-4add-a15d-ddc4a5e553da",
        ");"
    ]
}
  \end{minted}
\caption{Calling of the previously defined GLSL function of an implicit sphere
  as invocation in JSON format.}
\label{fig:node-invocation-example}
\end{figure}

\newthought{A~\emph{part} of a node} defines what happens when a node is
evaluated. This means usually evaluating the inputs of the node and use them as
parameters.~\cref{fig:node-invocation-example} shows an example of a part.

\begin{figure*}[!htbp]
  \begin{minted}[%
    bgcolor=LightGray,
    escapeinside=||,
    linenos=true,
    mathescape=true,
    tabsize=4]{js}
{
    "id_": "74b73ce7-8c9d-4202-a533-c77aba9035a6",
    "name": "Implicit sphere node function",
    "type_": "implicit",
    "script": [
      "# -*- coding: utf-8 -*-",
      "",
      "from PyQt5 import QtGui",
      "",
      "",
      "class Class_ImplicitSphere(object):",
      "    def __init__(self):",
      "        self.position = QtGui.QVector3D()",
      "",
      "    def process(self, context, inputs):",
      "      shader = context.current_shader.program",
      "      ",
      "      radius = inputs[0].process(context).value",
      "      shader_radius_location = shader.uniformLocation(",
      "          \"f5c6a538-1dbc-4add-a15d-ddc4a5e553da\"",
      "      )",
      "      shader.setUniformValue(",
      "          shader_radius_location, radius",
      "      )",
      "      ",
      "      position = self.position",
      "      shader_position_location = shader.uniformLocation(",
      "          \"16d90b34-a728-4caa-b07d-a3244ecc87e3-position\"",
      "      )",
      "      shader.setUniformValue(",
      "          shader_position_location,",
      "          position",
      "      )",
      "      ",
      "      return context"
    ]
}
  \end{minted}
\caption{The~\emph{part} of the node providing an implicit sphere in JSON
  format. Here the node node has two parameters: a radius and a position. The
  value for the radius is derived from the first input of the node, the position
  is a fixed vector. As the node is of type implicit it will be executed by a
  shader on the graphics processing unit.}
\label{fig:node-part-example}
\end{figure*}

\newpage{}

\newthought{Evaluation of nodes} is done in two ways, the node is
\begin{enumerate*}
  \item directly selected or
  \item connected to a scene (either through another node or
    through the scene's input) and that scene is evaluated.
\end{enumerate*}

\newthought{Nodes are derived from} node definitions. The workflow object of the
component, the~\verb=NodeController= class, reads node definitions from the file
system. A dialog window allows to add the read node definitions as instances to
a scene. When a node is selected it is rendered by the renderer component.

\subsection{Rendering}
\label{results:subsec:program:rendering}

\begin{figure}[!htbp]
  \caption{Entity relationship diagram of the renderer component.}
\label{fig:renderer-erd}
  \includegraphics[width=0.95\linewidth]{images/renderer-erd}
\end{figure}

\newthought{The rendering component} renders nodes and scenes. Nodes are
rendered according to their type whereby only nodes of type implicit are
currently supported. For rendering scenes the fixed input is evaluated
recursively.

\newthought{OpenGL is used for rendering}. Due to the usage of~\enquote{modern}
OpenGL, everything that is rendered is rendered through a shader defined in the
OpenGL Shading Language (GLSL).

\newthought{As algorithm for rendering} the sphere tracing algorithm is used as
described in~\autoref{sec:rendering}~\enquote{\nameref{sec:rendering}}
and shown in~\cref{fig:sphere-tracing-implementation}.

\begin{figure}[!htbp]
  \begin{minted}[%
    bgcolor=LightGray,
    linenos=true,
    mathescape=true,
    tabsize=4]{glsl}
// Casts a ray from given origin in given direction. Stops
// at given maximal distance and after the given amount of
// steps. Maintains given precision.
vec3 castRay(in vec3 rayOrigin, in vec3 rayDirection,
             in float maxDistance,
             in float precision, in int steps)
{
    float latest          = precision * 2.0;
    float currentDistance = 0.0;
    float result          = -1.0;
    vec3  ray             = vec3(0);

    for(int i = 0; i < steps; i++) {
        if (abs(latest)     < precision ||
            currentDistance > maxDistance) {
                continue;
        }

        ray = rayOrigin + rayDirection * currentDistance;
        latest = scene1(ray);
        currentDistance += latest;
    }

    if (currentDistance < maxDistance) {
        result = currentDistance;
    }

    return result;
}
  \end{minted}
\caption{The sphere tracing algorithm as implemented.}
\label{fig:sphere-tracing-implementation}
\end{figure}

\newpage{}

\newthought{For the shading} of objects Phong shading is used as
described in~\autoref{sec:rendering}~\enquote{\nameref{sec:rendering}}
and shown in~\cref{fig:phong-shading-implementation}.

\begin{figure*}
  \begin{minted}[%
    bgcolor=LightGray,
    linenos=true,
    mathescape=true,
    tabsize=4]{glsl}
// Calculates the lighting for the given position, normal and direction,
// the given light (position and color) respecting the 'material'.
//
// This is mainly applying the phong lighting model.
//
// Returns the calculated color as three-dimensional vector.
vec3 calcLighting(in vec3 position, in vec3 normal, in vec3 rayDirection,
                  in vec3 material, in vec3 lightPosition, in vec3 lightColor,
                  in float currentDistance)
{
    vec3 color             = material;

    vec3 lightDirection    = normalize(lightPosition);
    vec3 reflection        = reflect(rayDirection, normal);

    vec3  directColor      = vec3(1.0, 1.0, 1.0);
    float kDirectLight     = 0.1;
    vec3  direct           = kDirectLight * directColor;

    vec3  ambientColor     = vec3(0.5, 0.7, 1.0);
    float kAmbient         = 1.2;
    float ambientExponent  = clamp(0.5 + 0.5 * normal.y, 0.0, 1.0);
    vec3  ambient          = kAmbient * ambientExponent * ambientColor;

    vec3  diffuseColor     = vec3(1.0, 0.85, 0.55);
    float kDiffuse         = 1.20;
    float expDiffuse       = clamp(dot(lightDirection, normal), 0.0, 1.0);
    vec3  diffuse          = kDiffuse * expDiffuse * diffuseColor;

    vec3  specularColor    = vec3(1.0, 0.85, 0.55);
    float kSpecular        = 1.2;
    float specularFactor   = 160.0;
    float specularExponent = pow(
                                 clamp(dot(reflection, normal), 0.0, 1.0),
                                 specularFactor
                             );
    vec3  specular         = kSpecular * specularExponent * specularColor * expDiffuse;

    vec3 light             = direct + diffuse + specular + ambient;
    color                  = color * light;
    color                  = mix(
                                 color,
                                 vec3(0.8, 0.9, 1.0),
                                 1.0 - exp(-0.002 * currentDistance * currentDistance)
                             );

    return color;
}
  \end{minted}
\caption{Phong shading as implemented.}
\label{fig:phong-shading-implementation}
\end{figure*}

\newthought{Lighting and materials} are currently implemented statically. For
lighting a light source is hard-coded within the
shader.~\Cref{fig:lights-implementation} shows the implementation of the light
source. Concerning materials currently the same material for all objects is
used.~\Cref{fig:material-implementation} shows the implementation of the
material.

\begin{figure}
  \begin{minted}[%
    bgcolor=LightGray,
    linenos=true,
    mathescape=true,
    tabsize=4]{glsl}
vec3 light1Color = vec3(0.9, 0.49, 0.83);
vec3 light1Position = vec3(0.6, 0.7, 1.5);
color = calcLighting(position, normal, rayDirection,
                     material, light1Position,
                     light1Color, currentDistance);
  \end{minted}
\caption{The hard-coded light source as implemented in the shader.}
\label{fig:lights-implementation}
\end{figure}

\begin{figure*}
  \begin{minted}[%
    bgcolor=LightGray,
    linenos=true,
    mathescape=true,
    tabsize=4]{glsl}
// Calculates the material based on a given distance.
vec3 calcMaterial(in float currentDistance)
{
    return 0.45 + 0.3 * sin(vec3(0.05, 0.08, 0.10) * (currentDistance - 10.0));
}
  \end{minted}
\caption{The hard-coded material as implemented in the shader.}
\label{fig:material-implementation}
\end{figure*}