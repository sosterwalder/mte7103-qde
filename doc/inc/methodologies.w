% -*- mode: latex; coding: utf-8; outline-minor-mode: t -*-

\chapter{Methodologies}
\label{chap:methodologies}

% Das Kapitel der Methoden erklärt, was (Material) untersucht wurde und wie
% (Methode) ersteres untersucht wurde. Aufgrund der Beschreibung der Methoden muss
% es möglich sein, den Versuch oder die Studie zu wiederholen. Ist die
% Beschreibung der Versuchsanordnung oder des Vorgehens von sehr geringem Umfang,
% können diese nach Rücksprache mit der Betreuungsperson auch als Absatz in der
% Einleitung oder als Unterkapitel zum Kapitel der Einleitung verfasst werden.

% Link to previous
% Make a connection to what has immediately gone before. Recap the last chapter.
% In the last chapter I showed that… Having argued in the previous chapter that…
% As a result of x, which I established in the last chapter….. It is also possible
% to make a link between this chapter and the whole argument… The first step in
% answering my research question (repeat question) .. was to.. . In the last
% chapter I …
\newthought{The previous chapter} provided the fundamentals that are required for
understanding the results of this thesis.

% Focus: What does this chapter specifically do?
% Now focus the reader’s attention on what this chapter is specifically going to
% do and why it is important. In this chapter I will examine.. I will present… I
% will report … This is crucial in (aim of thesis/research question) in order to….
\newthought{This chapter} presents the methodologies that are used to implement
this thesis.

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
\newthought{The first section of this chapter} shows a principle called literate
programming, which is used to generate this documentation and the practical
implementation in terms of a software. The second section describes the agile
methodologies, that are used to implement this thesis.

\section{Literate programming}
\label{sec:literate-programming}

\newthought{Software may be documented in different ways.} It may be in terms of
a documentation, e.g.\ in the form of a software architecture which
describes the software conceptually and hints at its implementation. Or it may
be in terms of documenting within the software itself through inline comments.
Frequently both methodologies are used. However, all too
frequently the documentation is not done properly, and even neglected as it can
be quite costly with seemingly little benefit.

\newthought{Documenting software is critical.} Whenever software is written,
decisions are made. In the moment a decision is made, it may seem intuitively
clear, as it has evolved through creative thought processes. The seeming clarity
of the decision is most of the time deceptive. Is a decision still clear when
some time has passed since making that decision? What were the considerations
that led to it? Is the decision also clear for other, may be less-involved
persons? All these concerns show that documenting software is critical. No
documentation at all, or outdated or irrelevant documentation, can lead to
unforeseen and costly efforts concerning work and time.

\newthought{\citeauthorfin{hoare-hpl-1973} states~\citeyear{hoare-hpl-1973}} in his
work~\citetitle{hoare-hpl-1973} that~\enquote{documentation must be regarded as
an integral part of the process of design and coding}~\cite[p.
195]{hoare-hpl-1973}:~\enquote{The purpose of program documentation is to
explain to a human reader the way in which a program works so that it can be
successfully adapted after it goes into service, to meet the changing
requirements of its users, or to improve it in the light of increased knowledge,
or just to remove latent errors and oversights. The view that documentation is
something that is added to a program after it has been commissioned seems to be
wrong in principle and counter-productive in practice. Instead, documentation
must be regarded as an integral part of the process of design and coding. A good
programming language will encourage and assist the programmer to write clear
self-documenting code, and even perhaps to develop and display a pleasant style
of writing. The readability of programs is immeasurably more important than
their writeability.}~\cite[p. 195]{hoare-hpl-1973}

\newthought{Literate programming}, a paradigm proposed
in~\citeyear{knuth-lp-1984} by~\citeauthorfin{knuth-lp-1984}, goes even further.
\citeauthorfin{knuth-lp-1984} believes that \enquote{significantly better
documentation of programs} can be best achieved~\enquote{by considering programs
to be works of literature}~\cite[p.
1]{knuth-lp-1984}.~\citeauthorfin{knuth-lp-1984} proposes to change
the~\enquote{traditional attitude to the construction of programs}~\cite[p.
1]{knuth-lp-1984}. Instead of imagining that the main task is to instruct a
computer what to do, one should concentrate on explaining to human beings what
the computer shall do.~\cite[p. 1]{knuth-lp-1984}

\newthought{The ideas of literate programming} have been embodied in several
software systems, the first being~\emph{WEB}, introduced
by~\citeauthorfin{knuth-lp-1984} himself. These systems are a combination of two
languages:
\begin{enumerate*}
  \item a document formatting language and
  \item a programming language
\end{enumerate*}.
Such a software system uses a single document as input (which can be split up in
multiple parts) and generates two outputs:
\begin{enumerate*}
  \item a document in a formatting language, such as
    Knuth's~\LaTeX{}~\cite{knuth-tex-1987} (which may then be converted in a
    printable and viewable form, such as PDF) and
  \item a compilable program in a programming language, such as Python or C
    (which may then be converted into an executable program).
\end{enumerate*}~\cite{knuth-lp-1984}
The first process is called~\emph{weaving} and the second~\emph{tangling}. This
process is illustrated in~\cref{fig:weave-and-tangle}.

\begin{figure}
  \begin{tikzpicture}
    \begin{scope}[every node/.style={minimum size=4em,circle,thick,draw}]
      \node (input) at (0,  0) {Input};
      \node (tex)   at (3,  2) {file.tex};
      \node (c)     at (3, -2) {file.c};
      \node (pdf)   at (8,  2) {file.pdf};
      \node (bin)   at (8, -2) {binary};
    \end{scope}
    \begin{scope}[>={Stealth[black]},
      every node/.style={fill=white,circle},
      every edge/.style={draw=black,thick}]
      \path [->] (input) edge[bend left=30] node {weave} (tex);
      \path [->] (input) edge[bend right=30] node {tangle} (c); 
      \path [->] (tex) edge node {convert} (pdf); 
      \path [->] (c) edge node {compile} (bin); 
    \end{scope}
  \end{tikzpicture}
  \caption{Illustration showing the processes of~\emph{weaving}
    and~\emph{tangling} documents from an input document.~\cite{knuth-lp-1984}}
\label{fig:weave-and-tangle}
\end{figure}

\newthought{Several literate programming (LP) systems were evaluated} during the
first phase of this thesis:
CWEB~\sidenote{\url{http://www-cs-faculty.stanford.edu/~uno/cweb.html}},
Noweb~\sidenote{\url{https://www.cs.tufts.edu/~nr/noweb/}},
lit~\sidenote{\url{http://cdosborn.github.io/lit/lit/root.html}},
PyLiterate~\sidenote{\url{https://github.com/bslatkin/pyliterate}},
pyWeb~\sidenote{\url{http://pywebtool.sourceforge.net/}} and
Babel~\sidenote{\url{http://orgmode.org/worg/org-contrib/babel/}}. All of these
tools have their strengths and weaknesses.
However, none of these systems fulfill all the needed requirements of this
project:
\begin{enumerate*}
  \item Provide~\enquote{pretty printing}~\footnotemark[8]{} of the program parts.
  \item Provide automatic references between the definition of program parts and
    their usage.
  \item Expand program parts having the same name instead of redefining them.
  \item Support Python as programming language.
  \item Allow the inclusion of files for both parts, the document formatting
    language and the programming language.
\end{enumerate*}
\footnote{pretty printing refers to content-based formatting (e.g.\ line color
  and indentation to improve readability).}

\newthought{Ultimately a further literate programming system},
nuweb~\footnote{\url{http://nuweb.sourceforge.net/}}, was chosen as it fulfills
all these requirements. It has adapted and simplified the ideas of
FunnelWeb~\footnote{\url{http://www.ross.net/funnelweb/}}. It is independent of
the programming language for the source code. As document formatting language it
uses~\LaTeX{}. Although the documentation of nuweb states that it is not
designed for the pretty printing of source code, it does provide an option to
display source code as listings. This facility has been modified to support
visualizing the expansion of parts as well as to use syntax highlighting of the
code within~\LaTeX{}.

\newthought{The nuweb system provides several commands to process files.} All
commands begin with an at sign (@@). Whenever a file or part does not contain
any commands the file is copied unprocessed.\ nuweb provides a single executable
program, which processes the input files and generates the output files (weaving
and tangling, in document formatting language and as source code respectively).

\newthought{A fragment consists of scraps} which in this project contain the
source code. They may also contain for instance paragraphs for formatted text or
mathematical equations.

\newthought{Literate programming can be very expressive} when all concepts are
explicitly defined before implementation.~\citeauthorfin{knuth-lp-1984} sees
this expressiveness an advantage as one is forced to clarify thoughts before
programming~\cite[p. 13]{knuth-lp-1984}. This is surely very true for small
software but only partly true for larger software. The problem with larger
software is, that when using literate programming, the documentation tends to be
correspondingly large. \emph{To overcome this problem} in this project, the
actual implementation of the software is placed into to the appendix,
see appendix~\enquote{\nameref{chap:code-fragments}}.

\newthought{Another problematic aspect} is the implementation of repeating
fragments or parts with similar but not identical technical details (such as imports
or getter and setter methods). This might be interesting only for
software developers or technically oriented readers who want to grasp all the
details.~\emph{This aspect can
be overcome} by moving recurring or uninteresting fragments to a separate
file (see appendix~\enquote{\nameref{chap:code-fragments}}).

\newthought{To show the principles of literate programming}, without annoying
the reader, only an excerpt of some details is given here.

\newthought{One of the more interesting things} of the software might be the
definition of a node and its loading from external files. These two aspects are
shown below. More details of this example would go beyond the scope of this
thesis.

\newthought{Some essential thoughts about classes and objects} may help to stay
consistent when developing the software, before implementing the node class.
Each class should at least have four parts:
\begin{enumerate}
  \item Signals --- to inform other objects about events.
  \item A constructor --- creator of an initial instance of a class.
  \item Various methods --- actions which can be executed by the object.
  \item Slots --- receive signals from other objects.
\end{enumerate}
This structure is applied to the declaration of the node class.

\newpage{}

\newthought{Implementing the class called~\enquote{NodeDefinition}} means simply
defining a scrap called~\enquote{\emph{Node definition declaration}}
using the above structure. The scrap does not have any content at the
moment, except references to other scraps, that build the body of the scrap.
These will be defined later on.~\Cref{scrap1} shows the
scrap.

\begin{figure}[h]
  @d Node definition declaration
  @{
class NodeDefinition(object):
    """Represents a definition of a node.
    """

    # Signals

    @<Node definition constructor@>

    # Methods

    # Slots
@}
  \caption{Declaration of the node definition class.}
% \label{lst:node-def-class-decl}
\end{figure}
\phantomsection{}

\newthought{The constructor} might be the first thing to implement. In Python
the constructor defines properties of a class~\sidenote[][-20pt]{Properties do
not need to be defined in the constructor, they may be defined anywhere within
the class. However, this can lead to confusion and it is therefore considered as
good practice to define the properties of a class in its constructor.}. In
context of the program, one might come up with the properties
in~\autoref{table:node-properties} defining a node definition.

\begin{table*}[!htp]\centering
%\begin{table}\centering
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
\label{table:node-properties}
\end{table*}

\newthought{Implementing the constructor} of the node definition may now follow
from the properties defined
in~\autoref{table:node-properties}.~\Cref{scrap2} shows the
scrap containing the definition of the constructor.

\begin{figure}[!htbp]
  @d Node definition constructor
  @{
def __init__(self, id_):
    """Constructor.

    :param id_: the globally unique identifier of the node.
    :type  id_: uuid.uuid4
    """

    self.id_         = id_

    self.name        = ""
    self.description = ""
    self.parent      = None
    self.inputs      = []
    self.outputs     = []
    self.invocations = []
    self.parts       = []
    self.nodes       = []
    self.connections = []
    self.instances   = []
    self.was_changed = False@}
  \caption{Constructor of the node definition class. Note that the
    identifier is given by a corresponding parameter. Identifiers have to be
    generated when defining a node using an external file.}
% \label{lst:node-def-constructor}
\end{figure}

\newthought{One of the problems mentioned before} can be seen
in~\cref{scrap2}: it shows a rather simple constructor without
any useful logic. Additional modules would be needed, e.g.\ Qt bindings for
Python or system modules. At this point the implementation of node definitions
will not be detailed further, as this is beyond the scope of this thesis.

\newthought{The following pages} demonstrate the use of literate programming to
document and manage the code of the loading of node definitions.

\newthought{Node definitions will be loaded from external files} in JSON format.
This happens within the node controller component (not shown here).
The method for loading the nodes,
\mintinline{python}{load_node_definitions}, defined
in~\cref{scrap3}, does not have any arguments. Everything
needed for loading nodes is encapsulated in the node controller.

\begin{figure}[!htbp]
  @d Load node definitions
  @{
def load_node_definitions(self):
    """Loads all files with the ending NODES_EXTENSION
    within the NODES_PATH directory, relative to
    the current working directory.
    """
@}
  \caption{Head of the method that loads node definitions from external JSON
    files. Words written in uppercase are class constants.}
% \label{lst:load-node-definitions}
\end{figure}

\newthought{When loading node definitions}, there are two cases (and
consequences) at the first instance:
\begin{enumerate*}
  \item the directory containing the node definitions exists, so the node
    definitions may be loaded or
  \item the directory does not exit.
\end{enumerate*}
In the first case the directory possibly containing node definitions is being
searched for such files, in the second case a warning message is logged. This is
shown in~\cref{scrap4}.

\begin{figure*}[!htbp]
  @d Load node definitions
  @{
if os.path.exists(self.nodes_path):
    @<Find and load node definition files@>
else:
    @<Output warning when directory with node definitions does not exist@>@}
  \caption{Check whether the path containing the node definition files exist or
    not.}
% \label{lst:nodes-controller-load-nodes-2}
\end{figure*}

\newthought{In the first case}, when the directory containing the node
definitions exists, files containing node definitions are searched. The files
are searched by wildcard pattern matching the extension:~\verb|*.node|. This can
be seen in~\cref{scrap5}.

\newthought{In the second case}, a warning or error message must be generated.
This is detailed at the end of this section.

\begin{figure}[!htbp]
  @d Find and load node definition files
  @{
node_definition_files = glob.glob("{path}{sep}*.{ext}".format(
    path=self.nodes_path,
    sep=os.sep,
    ext=self.nodes_extension
))
num_node_definitions = len(node_definition_files)@}
  \caption{When the directory containing the node definitions exists, files
    matching the pattern~\emph{*.node} are searched.}
% \label{lst:nodes-controller-find-node-def-files}
\end{figure}

\newthought{Having searched for node definition files}, there are again two
cases, similar as before:
\begin{enumerate*}
  \item files (possibly) containing node definitions exist within the source
    directory, or
  \item no files with the ending \verb|.node| exist.
\end{enumerate*}
Again, as before, in the first case the node definitions will be loaded, in the
second case a warning message will be logged, which is shown in~\cref{scrap6}.

\begin{figure}[!htbp]
  @d Find and load node definition files
  @{
if num_node_definitions > 0:
    @<Load found node definitions@>
else:
    @<Output warning when no node definitions are found@>@}
  \caption{When files containing node definition files are found, they are
    loaded (if possible). When no such files are found, a warning message is
    logged.}
% \label{lst:nodes-controller-find-node-def-files-2}
\end{figure}

\newthought{In the case (1) when node definitions are present}, they are loaded
from the file system, parsed and then stored in an object in memory. To maintain
readability, these text parts (fragments or scraps) are is encapsulated in a
method,~\mintinline{python}{load_node_definition_from_file_name}, which is not
shown here. If the node definition cannot be loaded or parsed a null object
(Python~\mintinline{python}{None}) is being returned. This can be seen
in~\cref{scrap7}.

\begin{figure}[!htbp]
  @d Load found node definitions
  @{
self.logger.info(
    "Found %d node definition(s), loading.",
    num_node_definitions
)
t0 = time.perf_counter()
for file_name in node_definition_files:
    self.logger.debug(
        "Found node definition %s, trying to load",
        file_name
    )
    node_definition = self.load_node_definition_from_file_name(
        file_name
    )@}
  \caption{Loading and parsing of the node definitions found within the folder
    containing (possibly) node definition files.}
% \label{lst:nodes-controller-load-node-defs}
\end{figure}

\newpage{}

\newthought{When a node definition could be loaded}, a view model based on the
domain model is being created. Both models are then stored internally and a
signal about the loaded node definition is being emitted, to inform other
components which are interested in this event. This process is explained in
detail in the next chapter.

\begin{figure*}[!htbp]
  @d Load found node definitions
  @{
    if node_definition is not None:
        node_definition_view_model = node_view_model.NodeViewModel(
            id_=node_definition.id_,
            domain_object=node_definition
        )
        self.node_definitions[node_definition.id_] = (
            node_definition,
            node_definition_view_model
        )
        @<Node controller load node definition emit@>

t1 = time.perf_counter()
self.logger.info(
    "Loading node definitions took %.10f seconds",
    (t1 - t0)
)@}
  \caption{A view model, based on the domain model, for the node definition is
    being created. Both models are then stored internally and the signal, that a
    node definition was loaded is being emitted.}
% \label{lst:nodes-controller-load-node-defs-2}
\end{figure*}

\newpage{}

\newthought{The implementation of the warnings} is still remaining at this
point. When such an event happens, a corresponding message is logged. The
warnings are:

\begin{enumerate}
  \item the directory holding the node definitions does not exist
\end{enumerate}

\begin{figure*}[!htbp]
  @d Output warning when directory with node definitions does not exist
  @{
    message = QtCore.QCoreApplication.translate(
        __class__.__name__,
        "The directory holding the node definitions, %s, does not exist." % self.nodes_path
    )
    self.logger.fatal(message)@}
  \caption{Output a warning when the path containing the node definition files
    does not exist.}
% \label{lst:nodes-controller-load-node-defs-warning}
\end{figure*}

\tuftebreak{}or

\begin{enumerate}[resume]
  \item no files containing node definitions are found.
\end{enumerate}

\begin{figure*}[!htbp]
  @d Output warning when no node definitions are found
  @{
    message = QtCore.QCoreApplication.translate(
        __class__.__name__,
        "No files with node definitions found at %s." % self.nodes_path
    )
    self.logger.fatal(message)@}
  \caption{Output a warning when no node definitions are being found.}
% \label{lst:nodes-controller-load-node-defs-warning-2}
\end{figure*}

\section{Agile software development}
\label{sec:agile-software-development}

\newthought{Software engineering always invokes a methodology,} be it wittingly
or unwittingly. For a (very) small project the methodology may follow intuitively,
by experience and it may be a mixture of methodologies. For medium to large
projects however, using certain methodologies or principles is necessary to
ensure (the success of) a project.

\newthought{Every commonly used software engineering methodology} has advantages
but buries also certain risks. Be it a traditional method like the waterfall
model, incremental development, the v-model, the spiral model or a more recent
method like agile development. It depends largely on the project what
methodology fits best and buries the least risks.~\cite{haneen-risk-2012,
mens-se-2008}

\newthought{Examples of risks of software development}~\cite{beck-xp-2004} are:
incomplete and misunderstood needs, delays and schedule slippage, increased
error rate, new changes requested, superfluity of features,
etc.~\cite{beck-xp-2004}

\newthought{Traditional software engineering methodologies}, such as the
waterfall model or incremental development, struggle with the management of change. In case of the
waterfall model changes are deprecated or lead to followup projects. In the case of incremental
development, the phases can be very long, which allows only slow reaction to
change requests.~\autoref{fig:waterfall} and~\autoref{fig:iterative-dev}
illustrate these methodologies.

\begin{figure*}[!htbp]
  \includegraphics[width=0.95\linewidth]{images/waterfall}
  \caption{Phases of the water fall methodology.~\cite[p. 16]{shore-aad-2007}}
\label{fig:waterfall}
\end{figure*}

\begin{figure*}[ht]
  \includegraphics[width=0.95\linewidth]{images/iterative-dev}
  \caption{Phases of iterative development.~\cite[p. 16]{shore-aad-2007}}
\label{fig:iterative-dev}
\end{figure*}

\newthought{By applying some alternative basic principles}, agile development
methodologies try
to overcome these problems. These principles may vary depending on the used
methodology, but the fundamental ones are:
\begin{enumerate*}
  \item rapid feedback,
  \item minimize complexity,
  \item incremental change,
  \item no fear of changes and
  \item high quality work.
\end{enumerate*}~\cite{beck-xp-2004}
Further details can be found at~\cite{beck-xp-2004, shore-aad-2007}.

\newthought{An adapted version of extreme programming} is used for this thesis.
This methodology was chosen as at the end of the work of the previous project
(\enquote{QDE --- a visual animation system,
architecture}~\cite{osterwalder-qde-2016}), some needs were still continuously
changing or even not yet well-defined. An exact planning, analysis and design,
as traditional methodologies require it, would not be very practical. The
following~\autoref{fig:xp} illustrates the use of an agile methodology.

\begin{figure*}[!htbp]
  \includegraphics[width=0.95\linewidth]{images/xp}
  \caption{Iterations in the extreme programming methodology and phases of an
    interation.~\cite[p. 18]{shore-aad-2007}}
\label{fig:xp}
\end{figure*}
