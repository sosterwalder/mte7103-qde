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
derived from the experiences based on the former
projects,~\citetitle{osterwalder-volume-2016}
and~\citetitle{osterwalder-qde-2016}, which build the fundamentals of this
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

\begin{figure*}[ht]
  \includegraphics[width=0.8\linewidth]{images/mvvmc}
  \caption{Components of the used pattern for the editor and their
    communication.}
  \label{fig:software-design-pattern-components-editor}
\end{figure*}

\begin{figure*}[ht]
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
    \includegraphics[width=0.9\linewidth]{images/layers-gui}         & All elements of the graphical user interface, views.                                & Scene tree view, scene view, render view                                   \\
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

% Signals:  Explain what signals are and how they are used, maybe draw an
% illustrative diagram.

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

\begin{figure}[ht]
  \includegraphics[width=0.8\linewidth]{images/observer-pattern}
  \caption{The observer pattern.~\cite{gamma-dpe-1995}}
  \label{fig:signals-observer-pattern}
\end{figure}

\newthought{A signal is an observable event.} A slot is a potential observer,
typically a method of an object.

\begin{figure}
  \begin{pythoncode}
class Observer:

    @@slot(type)
    def on_signal(self, parameter):
        """Listens on the signal 'signal'. Expects the
        signal to send the parameter 'parameter' of
        type 'type'."""
      
        ...
  \end{pythoncode}
  \label{lst:signal-slot:observer-slot}
  \caption{An example of a class called~\enquote{Observer} with a slot
    called~\enquote{on\_signal}. The slot expects the signal to send a parameter
    of type~\enquote{type}.
  }
\end{figure}

\newthought{Slots are registered as observers} to signals.

\begin{figure}
  \begin{pythoncode}
subject.signal.connect(
    observer.on_signal
)
  \end{pythoncode}
  \label{lst:signal-slot:connect}
  \caption{The~\enquote{on\_signal} slot (which is a method of the
    object~\enquote{observer}) is registered to the signal~\enquote{signal} of
    the object~\enquote{subject}.}
\end{figure}

\newthought{Whenever a signal is emitted}, the emitting class must call all the
registered observers for that signal.

\begin{figure}
  \begin{pythoncode}
subject.signal.emit(some_parameter)
  \end{pythoncode}
  \label{lst:signal-slot:emit}
  \caption{The signal~\enquote{signal} of the object~\enquote{subject} is
    emitted. The signal contains a parameter called~\enquote{some\_parameter}.
    This means that the emitting class,~\enquote{Signal}, will call the
    registered method~\enquote{on\_signal} of the observer
    called~\enquote{observer}.}
\end{figure}

\newthought{The relationship between signals and slots} is a many-to-many
relationship. One signal may be connected to any number of slots and a slot may
listen to any number of signals. A relationship between a signal and a slot is
shown in~\cref{fig:signal-and-slot-relationship}

\begin{figure}[ht]
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

\begin{figure}[ht]
  \caption{The implemented editor component.}
  \label{fig:editor}
  \includegraphics[width=0.95\linewidth]{images/editor-components}
\end{figure}
\todo[inline]{Provide real image of the component, but use numbering for the
  components.}

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

\begin{table}\centering
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
in~\autoref{table:node-definition-atomic-types}.

\begin{table}\centering
  \ra{1.3}
  \begin{tabularx}{\textwidth}{@@{}lX@@{}}
    \toprule
    \textbf{Atomic type} & \textbf{Description}                                         \\
    \hline
    \textit{Generic}     & A global unique identifier (UUID\protect\footnotemark[1]{}). \\
    \textit{Float}       & The name of the node, e.g. "Sphere".                         \\
    \textit{Text}        & A description of the node's purpose.                         \\
    \textit{Scene}       & Parameters given to the node as inputs. This may be          \\
    \textit{Image}       & Values delivered by the node as outputs.                     \\
    \textit{Dynamic}     & A list of the node's definitions. This may be an             \\
    \textit{Mesh}        & The format of a call to the node definition, including       \\
    \textit{Implicit}    & Defines text that may be processed when calling the node.    \\
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

\newthought{Subsequent each component of the editor} is shown in a component
diagram in adapted form \cite[pp. 653 -- 654]{larman-applying-2004} and an
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
the scene tree view, the scene view and the renderer.

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

\newthought{The scene tree component} enables the scenes of the animation to be
managed. User interaction is provided through a tree-like view, which lets the
user add, remove and select scenes.

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