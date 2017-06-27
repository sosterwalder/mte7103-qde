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
a preceding documentation, e.g. in form of a software architecture, which
describes the software conceptually and hints at its implementation. It may be
in terms of documenting the software inline through inline comments. Frequently
both methodologies are used, in independent order. However, all too frequently
the documentation is not done properly and is even neglected as it can be quite
costly with seemingly little benefit.

\newthought{Documenting software is crucial.} Whenever software is written,
decisions are made. In the moment a decision is made, it may seem intuitively
clear as it evolved by thought. This seemingly clearness of the decision is most
of the time deceptive. Is a decision still clear when some time has passed by
since making that decision? What were the facts that led to it? Is the decision
also clear for other, may be less involved persons? All these concerns show that
documenting software is crucial. No documentation at all, outdated or irrelevant
documentation can lead to unforeseen efforts concerning time and costs.

\newthought{\citeauthor{hoare-hpl-1973} states~\citeyear{hoare-hpl-1973}} in his
work~\citetitle{hoare-hpl-1973} that~\enquote{documentation must be regarded as
an integral part of the process of design and coding}~\cite[p.
195]{hoare-hpl-1973}: ~\enquote{The purpose of program documentation is to
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
in~\citeyear{knuth-lp-1984} by~\citeauthor{knuth-lp-1984}, goes even further.
\citeauthor{knuth-lp-1984} believes that \enquote{significantly better
documentation of programs} can be best achieved~\enquote{by considering programs
to be works of literature}~\cite[p.
1]{knuth-lp-1984}.~\citeauthor{knuth-lp-1984} proposes to change
the~\enquote{traditional attitude to the construction of programs}~\cite[p.
1]{knuth-lp-1984}. Instead of imagining that the main task is to instruct a
computer what to do, one shall concentrate on explaining to human beings what
the computer shall do.~\cite[p. 1]{knuth-lp-1984}

\newthought{The ideas of literate programming} have been embodied in several
software systems, the first being~\emph{WEB}, introduced
by~\citeauthor{knuth-lp-1984} himself. These systems are a combination of two
languages:
\begin{enumerate*}
  \item a document formatting language and
  \item a programming language
\end{enumerate*}.
Such a software system uses a single document as input (which can be split up in
multiple files) and generates two outputs:
\begin{enumerate*}
\item a document in a document formatting language, such as~\LaTeX{} which, may
    then be converted in a platform independent binary description, such as
    PDF.
  \item a compilable program in a programming language, such as Python or C
    which may then be compiled into an executable program.
\end{enumerate*}~\cite{knuth-lp-1984}
The first is called~\emph{weaving} and the latter~\emph{tangling}. This process
is illustrated in~\autoref{fig:weave-and-tangle}.

\begin{figure}
  \label{fig:weave-and-tangle}
  \caption{Illustration showing the processes of~\emph{weaving}
    and~\emph{tangling} documents from a input document.~\cite{knuth-lp-1984}}
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
\end{figure}

\newthought{Several literate programming systems were evaluated} during the
first phases of this thesis:
CWEB~\sidenote{\url{http://www-cs-faculty.stanford.edu/~uno/cweb.html}},
Noweb~\sidenote{\url{https://www.cs.tufts.edu/~nr/noweb/}},
lit~\sidenote{\url{http://cdosborn.github.io/lit/lit/root.html}},
PyLiterate~\sidenote{\url{https://github.com/bslatkin/pyliterate}},
pyWeb~\sidenote{\url{http://pywebtool.sourceforge.net/}} and
Babel~\sidenote{\url{http://orgmode.org/worg/org-contrib/babel/}} (which is part
of org mode of Emacs). All of these tools have their strengths and weaknesses.
However, none of these systems fulfill all the needed requirements:
\begin{enumerate*}
  \item Provide pretty printing of the program parts.
  \item Provide automatic references between the definition of program parts and
    their usage.
  \item Expand program parts having the same name instead of redefining them.
  \item Support Python as programming language.
  \item Allow the inclusion of files for both parts, the document formatting
    language and the programming language.
\end{enumerate*}

\newthought{Ultimately nuweb~\footnote{\url{http://nuweb.sourceforge.net/}} was
chosen} as it fulfills all these requirements. It has adapted and simplified the
ideas FunnelWeb~\footnote{\url{http://www.ross.net/funnelweb/}}. It is
independent of the programming language for the source code. As document
formatting language it uses~\LaTeX{}. Although the documentation of nuweb
states, that it has no pretty printing of source code, it provides an option to
display source code as listings. This method was modified to support visualizing
the expansion of parts as well as to use specific syntax highlighting and code
output within~\LaTeX{}.

\newthought{nuweb provides several commands to process files.} All commands
begin with an at sign (@@). Whenever a file does not contain any commands the
file is copied unprocessed. The same applies for parts of files which contain no
commands. nuweb provides a single binary, which processes the
input files and generates the output files (in document formatting language and
as source code respectively). The commands are used to~\emph{specify output
files},~\emph{define fragments }and to~\emph{delimit scraps}.

\begin{table}[h]
  \caption{The major commands of nuweb.~\cite[p. 3]{briggs-nuweb-93}}
  \label{table:nuweb-commands}
  \begin{tabularx}{\textwidth}{lX}
    \toprule
    \textbf{Command} & \textbf{Description}\\
    \midrule
    \verb|@@o file-name flags scrap| & \emph{Outputs} the given scrap to the
                                       defined \emph{file} using the provided
                                       flags.\\
    \verb|@@d fragment-name scrap|   & Defines a~\emph{fragment} which refers to
                                       / holds the given scrap.\\
    \verb|@@q fragment-name scrap|   & Defines a~\emph{quoted fragment} which refers to
                                       / holds the given scrap. Inside a quoted
                                       fragment referred fragments are not expanded.\\
    \bottomrule
  \end{tabularx}
\end{table}
\marginnote[-70pt]{Note that fragment names may be abbreviated, either during
invocation or definition. nuweb simply preserves the longest version of a
fragment name.~\cite[p. 4]{briggs-nuweb-93}}

\newthought{Scraps define content} in form of source code. They~\enquote{have
specific markers to allow precise control over the contents and
layout.}~\cite{briggs-nuweb-93} There are three ways of defining scraps, which
can be seen in~\autoref{table:nuweb-scraps}. They all include everything between
the specific markers but they differ when being typeset.
\begin{table}[h]
  \caption{Ways of defining scraps in nuweb.~\cite[p. 3]{briggs-nuweb-93}}
  \label{table:nuweb-scraps}
  \begin{tabularx}{\textwidth}{lX}
    \toprule
    \textbf{Scrap} & \textbf{Typesetting}\\
    \midrule
    \verb|@@{ Content of scrap here @@}| & Verbatim mode.\\
    \verb|@@[ Content of scrap here @@]| & Paragraph mode.\\
    \verb|@@( Content of scrap here @@)| & Math mode.\\
    \bottomrule
  \end{tabularx}
\end{table}

\newthought{A fragment is being invoked} by
using~\verb|@@<fragment-name@@>|.~\enquote{It causes the fragment fragment-name
to be expanded inline as the code is written out to a file. It is an error to
specify recursive fragment invocations.}~\cite[p. 3]{briggs-nuweb-93} There are
various other commands and details, but mentioning them would go beyond the
scope of this thesis. They can be found at~\cite{briggs-nuweb-93}.

\newthought{Literate programming can be very expressive} as all thoughts are
laid down before implementing something.~\citeauthor{knuth-lp-1984} sees this
expressiveness an advantage as one is forced to clarify his thoughts before
programming~\cite[p. 13]{knuth-lp-1984}. This is surely very true for rather
small software and partly also for larger software. The problem with larger
software is, that using literate programming, the documentation tends to be
rather large too. \emph{To overcome this aspect} the actual implementation of
the intended software is moved to the appendix~\todo{insert reference to
appendix here}.

\newthought{Another problematic aspect is the implementation of technical
details} such as imports for example or plain getter and setter methods, which
may recur and may often be very similar. While this might be interesting for
software developers or technically oriented readers, who want to grasp all the
details, this might not be interesting for other readers.~\emph{This aspect can
be overcome}, by moving recurring or seemingly uninteresting parts to a separate
file, see~\todo{add reference to code fragments}, which holds these code
fragments.

\newthought{To show the principles of literate programming} nevertheless,
without annoying the reader, only an excerpt of some details is given at this
place. One of the more interesting things of the intended software might
be the definition of a node~\todo{add reference to the node concept within
appendix} and the loading of node definitions from external files. These two
aspects are shown below. However, not all of the details are shown as this would
go beyond the scope.

\newthought{Some essential thoughts about classes and objects} may help to stay
consistent when developing the software, before implementing the node class.
Each class should at least have
\begin{enumerate}
  \item Signals --- to inform other components about events.
  \item A constructor.
  \item Various methods.
  \item Slots --- to get informed about events from other components.
\end{enumerate}
This pattern is applied to the declaration of the node class.

\newpage{}

\newthought{Implementing the node class} means simply defining a~\emph{scrap}
called~\enquote{\emph{Node definition declaration}} using the above pattern.
The~\emph{scrap} does not have any content at the moment, except references to
other scraps, which build the body of the scrap and which will be defined later
on.

\begin{figure}[h]
  @d Node definition declaration
  @{
class NodeDefinition(object):
    """Represents a definition of a node."""

    # Signals
    @<Node definition signals@>
    @<Node definition constructor@>
    @<Node definition methods@>

    # Slots
    @<Node definition methods@>@}
  \caption{Declaration of the node definition class.}
  \label{lst:node-def-class-decl}
\end{figure}

\vspace*{-2\baselineskip}
\newthought{The constructor} might be the first thing to implement, following
the developed pattern. In Python the constructor defines the properties of a
class~\sidenote[][-10pt]{Properties do not need to be defined in the constructor,
they may be defined anywhere within the class. However, this can lead to
confusion and it is therefore considered as good practice to define the
properties of a class in its constructor.}, therefore it defines what a class
actually is or represents --- the concept. After some thinking, and in context
of the intended software, one might come up with the properties
in~\autoref{table:node-properties} defining a node definition.

\begin{table*}[!htp]
  \begin{tabularx}{\linewidth}{lX}
    \toprule
    \textbf{Property} & \textbf{Description}\\
    \midrule
    ID          & A globally unique identifier for the node definition.          \\
    Name        & The name of the definition.                                    \\
    Description & The description of the definition. What does that definition
                  provide?                                                       \\
    Parent      & The parent object of the current node definition.              \\
    Inputs      & Inputs of the node definition. This may be distinct types or
                  references to other nodes.                                     \\
    Outputs     & The same as for inputs.                                        \\
    Invocation  & A list of the node's invocations or calls respectively.        \\
    Parts       & Defines parts that may be processed when evaluating the node.
                  Contains code which can be interpreted directly.               \\
    Connections & A list of connections of the node's inputs and outputs. Each
                  connection is composed by two parts:
                  \begin{enumerate*}
                    \item a reference to another node and
                    \item a reference to an input or an output of that node.
                  \end{enumerate*}
                  Is the reference not set, that is, its value is zero, this
                  means that the connection is internal.                         \\
    Instances   & A list of node instances from a certain node definition.       \\
    Was changed & Flag, which indicates whether a definition was changed or not. \\
    \bottomrule
  \vspace*{\baselineskip}
  \caption{Properties/attributes of the node class.}
  \label{table:node-properties}
  \end{tabularx}
\end{table*}

\newthought{Implementing the constructor} of the node definition may now follow
from the properties defined in~\autoref{table:node-properties}. As the name of
the constructor definition was already given, by using it
within~\autoref{lst:node-def-class-decl}
(\verb|@@<Node definition constructor@@>|), the very same name will be used for
actually defining the scrap itself.

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
  \label{lst:node-def-constructor}
\end{figure}

\newthought{One of the problems mentioned before} can be seen
in~\cref{lst:node-def-constructor}: it shows a rather dull constructor without
any logic which is not interesting. Additionally importing of modules would be
needed, e.g. PyQt or system modules. This was left out deliberately. At this
point the implementation of node definitions will not be shown further, as this
is beyond scope. Further implementation can be seen at~\todo{insert
reference(s) to node domain model here}.

\newthought{Node definitions will be loaded from external files} in JSON format.
This happens within the node controller component, which will not be shown here
as this would go beyond the scope. Required attributes will be mentioned
explicitly although. The method for loading the nodes,
\mintinline{python}{load_node_definitions}, defined
in~\cref{lst:load-node-definitions}, does not have any arguments. Everything
needed for loading nodes is encapsulated in the node controller.

\begin{figure}[h]
  @d Load node definitions
  @{
def load_node_definitions(self):
    """Loads all files with the ending NODES_EXTENSION
    within the NODES_PATH directory, relative to
    the current working directory.
    """
@}
  \caption{Head of the method that loads node definitions from external JSON
    files.}
  \label{lst:load-node-definitions}
\end{figure}

\vspace*{-2\baselineskip}
\newthought{When loading the node definitions}, there are two cases (and
consequences) at the first instance:
\begin{enumerate*}
  \item the directory containing the node definitions exists, the load
    definitions may be loaded or
  \item the directory does not exit.
\end{enumerate*}
In the first case the directory possibly containing node definitions is being
searched for such files, in the second case a warning message is logged.

\begin{figure}[!h]
  @d Load node definitions
  @{
if os.path.exists(self.nodes_path):
    @<Find and load node definition files@>
else:
    @<Output warning when directory with node definitions does not exist@>@}
  \caption{Check whether the path containing the node definition files exist or
    not.}
  \label{lst:nodes-controller-load-nodes-2}
\end{figure}

\vspace*{-2\baselineskip}
\newthought{In the first case}, when the directory containing the node
definitions exists, files containing node definitions are searched. The files
are searched by wildcard pattern matching the extension:~\verb|*.node|.

\begin{figure}[!h]
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
  \label{lst:nodes-controller-find-node-def-files}
\end{figure}

\vspace*{-2\baselineskip}
\newthought{Having searched for node definition files}, there are again two
cases, similar as before:
\begin{enumerate*}
  \item files (possibly) containing node definitions exist or
  \item no files with the ending \verb|.node| exist within the source directory.
\end{enumerate*}
Again, as before, in the first case the node definitions will be loaded, in the
second case a warning message will be logged.

\begin{figure}[!h]
  @d Find and load node definition files
  @{
if num_node_definitions > 0:
    @<Load found node definitions@>
else:
    @<Output warning when no node definitions are found@>@}
  \caption{When files (possibly) containing node definition files are found,
    they are tried being loaded. When no such files are found, a warning message
    is being logged.}
  \label{lst:nodes-controller-find-node-def-files-2}
\end{figure}

\newthought{Given that node definitions are present}, they are loaded from the
file system, parsed and then stored internally as domain model. To maintain
readability, all this is encapsulated in a
method,\\
\mintinline{python}{load_node_definition_from_file_name}, which is
deliberately not\\
shown here as this would go beyond scope. If the node
definition cannot be loaded or parsed~\mintinline{python}{None} is being
returned.

\begin{figure}[!h]
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
    containing (possibly) node definition files. If a node definition cannot be
    loaded or parsed,~\textit{None} is being returned.}
  \label{lst:nodes-controller-load-node-defs}
\end{figure}

\newpage{}

\newthought{When a node definition could be loaded}, a view model based on the
domain model is being created. Both models are then stored internally and a
signal about the loaded node definition is being emitted, to inform other
components which are interested in this event.

\begin{figure}[!h]
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
  \label{lst:nodes-controller-load-node-defs-2}
\end{figure}

\newpage{}

\newthought{The implementation of the edge cases} is still remaining at this
point. When such an edge case happens, a corresponding message is logged. The
edge cases are:

\begin{enumerate}
  \item the directory holding the node definitions does not exist
\end{enumerate}

\begin{figure}[!h]
  @d Output warning when directory with node definitions does not exist
  @{
    message = QtCore.QCoreApplication.translate(
        __class__.__name__,
        "The directory holding the node definitions, %s, does not exist." % self.nodes_path
    )
    self.logger.fatal(message)@}
  \caption{Output a warning when the path containing the node definition files
    does not exist.}
  \label{lst:nodes-controller-load-node-defs-warning}
\end{figure}

\tuftebreak{}or

\begin{enumerate}[resume]
  \item no files containing node definitions are found.
\end{enumerate}
  
\begin{figure}[!h]
  @d Output warning when no node definitions are found
  @{
    message = QtCore.QCoreApplication.translate(
        __class__.__name__,
        "No files with node definitions found at %s." % self.nodes_path
    )
    self.logger.fatal(message)@}
  \caption{Output a warning when no node definitions are being found.}
  \label{lst:nodes-controller-load-node-defs-warning-2}
\end{figure}

\section{Agile software development}
\label{sec:agile-software-development}

\newthought{Software engineering invokes always a methodology,} be it wittingly
or unwittingly. For a (very) small project the methodology may follow intuitively,
by experience and it may be a mixture of methodologies. For medium to large
projects however, using certain methodologies or principles becomes inevitable
for being able to evaluate (the success of) a project.

\newthought{Every commonly used software engineering methodology} has advantages
but buries also certain risks. Be it a traditional method like the waterfall
model, incremental development, the v-model, the spiral model or a more recent
method like agile development. It depends largely on the project what
methodology fits best and buries the least risks.~\cite{haneen-risk-2012,
mens-se-2008}

\newthought{Risk is the basic problem of software
development.}~\cite{beck-xp-2004} Examples of risks are: schedule slips,
canceled projects, increased defect rates, misunderstood domain/business,
changes, false feature rich.~\cite{beck-xp-2004}

\newthought{Traditional software engineering methodologies}, such as the
waterfall model or incremental development, struggle with change. In case of the
waterfall model they embrace change not at all or, in the case of incremental
development, the phases are rather long what allows only slow reaction.

\begin{figure*}[ht]
  \includegraphics[width=0.95\linewidth]{images/waterfall}
  \caption{Phases of the water fall methodology.~\cite[p. 16]{shore-aad-2007}}
  \label{fig:waterfall}
\end{figure*}

\begin{figure*}[ht]
  \includegraphics[width=0.95\linewidth]{images/iterative-dev}
  \caption{Phases of iterative development.~\cite[p. 16]{shore-aad-2007}}
  \label{fig:iterative-dev}
\end{figure*}

\newthought{By applying basic principles}, agile development methodologies try
to overcome this problem. These principles may vary depending on the used
methodology, but the fundamental principles are:
\begin{enumerate*}
  \item rapid feedback,
  \item assume simplicity,
  \item incremental change,
  \item embracing change and
  \item quality work.
\end{enumerate*}~\cite{beck-xp-2004}
Further details can be found at~\cite{beck-xp-2004, shore-aad-2007}.

\newthought{An adapted version of extreme programming} is used for this thesis.
This methodology was chosen as after the preceding project
work,~\citetitle{osterwalder-qde-2016}, several things were still subject to
change and therefore an exact planning, analysis and design, as traditional
methodologies require it, would not be very practical.
% TODO: Mention what exactly was modified.

\begin{figure*}[ht]
  \includegraphics[width=0.95\linewidth]{images/xp}
  \caption{Iterations in the extreme programming methodology and phases of an
    interation.~\cite[p. 18]{shore-aad-2007}}
  \label{fig:xp}
\end{figure*}

% TODO: Check if this is enough or elaborate more otherwise.
