% -*- mode: latex; coding: utf-8 -*-

\chapter{Node graph}
\label{appendix:chap:node-graph}

\newthought{The functionality of the node graph} is, as its name states, to
represent a data structure composed of nodes and edges. Each scene from the
scene graph is represented within the node graph as such a data structure.

\newthought{The nodes are the building blocks} of a real time animation. They
represent different aspects, such as scenes themselves, time line clips, models,
cameras, lights, materials, generic operators and effects. These aspects are
only examples (coming from~\citetitle[p. 30 and 31]{osterwalder-qde-2016}) as
the node structure will be expandable for allowing the addition of new nodes.

The implementation of the scene graph component was relatively straightforward
partly due to its structure and partly due to the used data model and
representation. The node graph component however, seems to be a bit more complex.

\newthought{To get a first overview and to manage its complexity}, it might be
good to identify its sub components first before implementing them. When
thinking about the implementation of the node graph, one may identify the
following sub components:

\begin{description}
\item[Nodes] Building blocks of a real time animation.
  \begin{description}
    \item[Domain model] Holds data of a node, like its definition, its inputs
                        and so on.
    \item[Definitions]  Represents a domain model as JSON data structure.
    \item[Controller]   Handles the loading of node definitions as well as the
                        creation of node instances.
    \item[View model]   Represents a node within the graphical user interface.
  \end{description}
\end{description}

\begin{description}
\item[Scenes] A composition of nodes, connected by edges.
  \begin{description}
    \item[Domain model] Holds the data of a scene, e.g.\ its nodes.
    \item[Controller]   Handles scene related actions, like when a node is added
                        to a scene, when the scene was changed or when a node
                        within a scene was selected.
    \item[View model]   Defines the graphical representation of scene which can
                        be represented by the corresponding view. Basically the
                        scene view model is a canvas consisting of nodes.
    \item[View]         Represents scenes in terms of scene view models within the
                        graphical user interface.
  \end{description}
\end{description}

\section{Nodes}
\label{appendix:sec:node-grahp:nodes}

\newthought{What are nodes and node definitions?} As mentioned before, they are
the building blocks of a real time animation. But what are those definitions
actually? What do they actually define? There is not only one answer to this
question, it is simply a matter of how the implementation is being done and
therefore a set of decisions.

\newthought{The whole (rendering) system} shall not be bound to only one
representation of nodes, e.g.\ triangle based meshes. Instead it shall let the
user decide, what representation is the most fitting for the goal he wants to
achieve.

\newthought{Multiple kinds of node representations} shall be supported by the
system: images, triangle based meshes and solid modeling through function
modeling (using signed distance functions for modeling implicit surfaces).
Whereas triangle based meshes may either be loaded from externally defined files
(e.g.\ in the Filmbox (FBX), the Alembic (ABC) or the Object file format (OBJ))
or directly be generated using procedural mesh generation.

\newthought{Nodes are always part of a graph}, hence the name node graph, and
are therefore typically connected by edges. This means that the graph gets
evaluated recursively by its nodes, starting with the root node within the root
scene. However, the goal is to have OpenGL shading language (GLSL) code at the
end, independent of the node types.

\newthought{From this point of view} it would make sense to let the user define
shader code directly within a node (definition) and to simply evaluate this
code, which adds a lot of (creative) freedom. The problem with this approach is
though, that image and triangle based mesh nodes are not fully implementable by
using shader code only. Instead they have specific requirements, which are only
perform-able on the CPU (e.g.\ allocating buffer objects).

\newthought{When thinking of nodes used for solid modeling} however, it may
appear, that they may be evaluated directly, without the need for
pre-processing, as they are fully implementable using shader code only. This is
kind of misleading however, as each node has its own definition which has to be
added to shader and this definition is then used in a mapping function to
compose the scene. This would mean to add a definition of a node over and over
again, when spawning multiple instances of the same node type, which results in
overhead bloating the shader. It is therefore necessary to pre-process solid
modeling nodes too, exactly as triangle mesh based and image nodes, for being
able to use multiple instances of the same node type within a scene while having
the definition added only once.

\newthought{All of these thoughts sum up} in one central question for the
implementation: Shall objects be predefined within the code (and therefore only
nodes accepted whose type and sub type match those of predefined nodes) or shall
all objects be defined externally using files?

This is a question which is not that easy to answer. Both methods have their
advantages and disadvantages. Pre-defining nodes within the code minimizes
unexpected behavior of the application. Only known and well-defined nodes are
processed.

But what if someone would like to have a new node type which is not yet defined?
The node type has to be implemented first. As Python is used for the editor
application, this is not really a problem as the code is interpreted each time
and is therefore not being compiled. Nevertheless such changes follow a certain
process, such as making the actual changes within the code, reviewing and
checking-in the code and so on, which the user normally does not want to be
bothered with. Furthermore, when thinking about the player application, the
problem of the necessity to recompile the code is definitively given. The player
will be implemented in C, as there is the need for performance, which Python may
not fulfill satisfactorily.

\newthought{The external definition of nodes is chosen} considering these
aspects. This may result in nodes which cannot be evaluated or which have
unwanted effects. As it is (most likely) in the users best interest to create
(for his taste) appealing real time animations, it can be assumed, that the user
will try avoiding to create such nodes or quickly correct faulty nodes or simply
does not use such nodes.

Now, having chosen how to implement nodes, it is important to define what a node
actually is. As a node may be referenced by other nodes, it must be uniquely
identifiable and must therefore have a globally unique identifier. Concerning
the visual representation, a node shall have a name as well as a description.

\newthought{Each node can have multiple inputs and at least one output.} The
inputs may be either be atomic types (which have to be defined) or references to
other nodes. The same applies to the outputs.

\newthought{A node consists also of a definition.} In terms of implicit surfaces
this section contains the actual definition of a node in terms of the implicit
function. In terms of triangle based meshes this is the part where the mesh and
all its prerequisites as vertex array buffers and vertex array objects are set
up or used from a given context.

In addition to a definition, a node contains an invocation part, which is the
call of its defining function (coming from the definition mentioned just
before) while respecting the parameters.

\newthought{A node shall be able to have one or more parts.} A part typically
contains the \enquote{body} of the node in terms of code and represents
therefore the code-wise implementation of the node. A part can be processed when
evaluating the node. This part of the node is mainly about evaluating inputs and
passing them on to a shader.

Furthermore a node may contain children (child-nodes) which are actually
references to other nodes combined with properties such as a name, states and so
on.

\newthought{Each node can have multiple connections.} A connection is composed
of an input and an output plus a reference to a part. The input respectively the
output may be zero, what means that the part of the input or output is internal.

Or, a bit more formal:

\begin{figure}[!htbp]
@d Connections between nodes in EBNF notation
@{
input = internal input | external input
internal input = zero reference, part reference
external input = node reference, part reference
zero reference = "0"
node reference = "uuid4"
part reference = "uuid4"
@}
\caption{Connections between nodes in EBNF notation.}
% \label{node-graph:lst:node-connections-ebnf}
\end{figure}

% Reference to a node X + Reference to /output/ A of node X.
% or
% No reference to another node + Reference to an /input/ of the current node.
%
% Output:
% Reference to a node Y + Reference to /input/ B of node Y.
% or
% No reference to another node + Reference to an /output/ or to /part/ of the
% current node.

\newthought{Recapitulating the above made thoughts} a node is essentially
composed by the following elements:

\begin{table*}\centering
  \ra{1.3}
  \begin{tabularx}{\textwidth}{@@{}lX@@{}}
    \toprule
    \textbf{Component} & \textbf{Description}\\
    \hline
    \textit{ID} & A global unique identifier (UUID\protect\footnotemark[1]{})\\
    \textit{Name} & The name of the node, e.g. "Cube".\\
    \textit{Description} & A description of the node's purpose.\\
    \textit{Inputs} & A list of the node's inputs. The inputs may either be
    parameters (which are atomic types such as float values or text input) or
    references to other nodes.\\
    \textit{Outputs} & A list of the node's outputs. The outputs may also either
    be parameters or references to other nodes.\\
    \textit{Definitions} & A list of the node's definitions. This may be an
    actual definition by a (shader-) function in terms of an implicit surface or
    prerequisites as vertex array buffers in terms of a triangle based mesh.\\
    \textit{Invocation} & A list of the node's invocations or calls
    respectively.\\
    \textit{Parts} & Defines parts that may be processed when evaluating the
    node. Contains code which can be interpreted directly.\\
    \textit{Nodes} & The children a node has (child nodes). These entries are
    references to other nodes only.\\
    \textit{Connections} & A list of connections of the node's inputs and
    outputs.

    Each connection is composed by two parts: A reference to another node
    and a reference to an input or an output of that node. Is the reference not set,
    that is, its value is zero, this means that the connection is internal.\\
    \bottomrule
  \end{tabularx}
  \caption{Components a node is composed of.}
\end{table*}
\footnotetext[1]{https://docs.python.org/3/library/uuid.html}

\newthought{The inputs and outputs may be parameters of an atomic type}, as
stated above. This seems like a good point to define the atomic types the system
will have:

\begin{itemize}
  \item{Generic}
  \item{Float}
  \item{Text}
  \item{Scene}
  \item{Image}
  \item{Dynamic}
  \item{Mesh}
  \item{Implicit}
\end{itemize}

As these atomic types are the foundation of all other nodes, the system must
ensure, that they are initialized before all other nodes. Before being able to
create instances of atomic types, there must be classes defining them.

\newthought{For identification of the atomic types}, an enumerator is used.
Python provides the~\verb=enum= module, which provides a convenient interface
for using enumerations\footnote{\url{https://docs.python.org/3/library/enum.html}}.

\begin{figure}[!htbp]
@d Node type declarations
@{
class NodeType(enum.Enum):
    """Atomic types which a parameter may be made of."""

    GENERIC  = 0
    FLOAT    = 1
    TEXT     = 2
    SCENE    = 3
    IMAGE    = 4
    DYNAMIC  = 5
    MESH     = 6
    IMPLICIT = 7
@}
\caption{Types of a node wrapped in a class, implemented as an enumerator.
  \newline{}\newline{}Editor $\rightarrow$ Types $\rightarrow$ Node type}
% \label{editor:lst:types:node-type}
\end{figure}

Now, having identifiers for the atomic types available, the atomic types
themselves can be implemented. The atomic types will be used for defining
various properties of a node and are therefore its parameters.

\newthought{Each node may contain one or more parameters} as inputs and at least
one parameter as output. Each parameter will lead back to its atomic type by
referencing the unique identifier of the atomic type. For being able to
distinguish multiple parameters using the same atomic type, it is necessary that
each instance of an atomic type has its own identifier in form of an instance
identifier (instance ID).

\begin{figure}[!htbp]
@d Parameter declarations
@{
class AtomicType(object):
    """Represents an atomic type and is the basis for each
    node."""

    def __init__(self, id_, type_):
        """Constructor.

        :param id_: the globally unique identifier of the
                    atomic type.
        :type  id_: uuid.uuid4
        :param type_: the type of the atomic type, e.g. "float".
        :type  type_: types.NodeType
        """

        self.id_   = id_
        self.type_ = type_
@}
\caption{The atomic type class which builds the basis for node parameters. Note
  that the type of an atomic type is defined by the before implemented node
  type.
  \newline{}\newline{}Editor $\rightarrow$ Parameters $\rightarrow$ Atomic type}
% \label{editor:lst:parameters:atomic-type}
\end{figure}

As the word atomic indicates, these types are atomic, meaning there only exists
one explicit instance per type, which is therefore static. As can be seen in the
code fragment below, the atomic types are parts of node definitions themselves.
Only the creation of the generic atomic type is shown, the rest is omitted and
can be found
at~\autoref{chap:code-fragments}~\enquote{\nameref{chap:code-fragments}}.

\begin{figure}[!htbp]
@d Parameter declarations
@{
class AtomicTypes(object):
    """Creates and holds all atomic types of the system."""

    @@staticmethod
    def create_node_definition_part(id_, type_):
        """Creates a node definition part based on the given
        identifier and type.

        :param id_: the identifier to use for the part.
        :type  id_: uuid.uuid4
        :param type_: the type of the part.
        :type type_: qde.editor.domain.parameter.AtomicType

        :return: a node definition part.
        :rtype: qde.editor.domain.node.NodeDefinitionPart
        """

        def create_func(id_, default_function, name, type_):
            node_part = node.NodePart(id_, default_function)
            node_part.type_ = type_
            node_part.name = name
            return node_part

        node_definition_part = node.NodeDefinitionPart(id_)
        node_definition_part.type_ = type_
        node_definition_part.creator_function = create_func

        return node_definition_part

    Generic = create_node_definition_part.__func__(
        id_="54b20acc-5867-4535-861e-f461bdbf3bf3",
        type_=types.NodeType.GENERIC
    )
@}
\caption{A class which creates and holds all atomic types of the editor. Note
  that at this point only an atomic type for generic nodes is being created.
  \newline{}\newline{}Editor $\rightarrow$ Parameters $\rightarrow$ Atomic types}
% \label{editor:lst:parameters:atomic-types}
\end{figure}

\newthought{Having the atomic types defined}, nodes may now be defined.

\begin{figure}[!htbp]
@d Node domain model declarations
@{
class NodeModel(object):
    """Represents a node."""

    # Signals

    @<Node domain model constructor@>

    @<Node domain model methods@>

    # Slots
@}
\caption{Definition of the node (domain) model.
  \newline{}\newline{}Editor $\rightarrow$ Node model}
% \label{editor:lst:node-domain-model}
\end{figure}

\begin{figure}[!htbp]
@d Node domain model constructor
@{
def __init__(self, id_, name="New node"):
    """Constructor.

    :param id_: the globally unique identifier of the node.
    :type  id_: uuid.uuid4
    :param name: the name of the node.
    :type  name: str
    """

    self.id_   = id_
    self.name = name

    self.definition = None
    self.description = ""
    self.parent = None
    self.inputs = []
    self.outputs = []
    self.parts = []
    self.nodes = []
    self.connections = []
@}
\caption{Constructor of the node (domain) model.
  \newline{}\newline{}Editor $\rightarrow$ Node model $\rightarrow$ Constructor}
% \label{editor:lst:node-domain-model:constructor}
\end{figure}

\newthought{While the details of a node are rather unclear} at the moment, it is
clear that a node needs to have a view model, which renders a node within a
scene of the node graph.

\newthought{Qt does not offer a graph view by default}, therefore it is
necessary to implement such a graph view.

The most obvious choice for this implementation is the ~\verb=QGraphicsView=
component, which displays the contents of a ~\verb=QGraphicsScene=,
whereas~\verb=QGraphicsScene= manages~\verb=QGraphicsObject= components.

It is therefore obvious to use the~\verb=QGraphicsObject= component
for representing graph nodes through a view model.

\begin{figure}[!htbp]
@d Node view model declarations
@{
class NodeViewModel(Qt.QGraphicsObject):
    """Class representing a single node within GUI."""

    # Constants
    WIDTH = 120
    HEIGHT = 40

    # Signals
    @<Node view model signals@>

    @<Node view model constructor@>

    @<Node view model methods@>

    @<Node view model slots@>
@}
\caption{Definition of the node view model.
  \newline{}\newline{}Editor $\rightarrow$ Node view model}
% \label{editor:lst:node-view-model}
\end{figure}

\begin{figure}[!htbp]
@d Node view model constructor
@{
def __init__(self, id_, domain_object, parent=None):
    """Constructor.

    :param id_: the globally unique identifier of the atomic type.
    :type  id_: uuid.uuid4
    :param domain_object: Reference to a scene model.
    :type  domain_object: qde.editor.domain.scene.SceneModel
    :param parent: The parent of the current view widget.
    :type parent:  QtCore.QObject
    """

    super(NodeViewModel, self).__init__(parent)
    self.id_ = id_
    self.domain_object = domain_object

    self.inputs  = {}
    self.outputs = {}

    self.position = QtCore.QPoint(0, 0)

    self.width  = NodeViewModel.WIDTH
    self.height = NodeViewModel.HEIGHT
@}
\caption{Constructor of the node view model.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Constructor}
% \label{editor:lst:node-view-model:constructor}
\end{figure}

\newthought{To distinguish nodes}, the name and the type of a node is used. It
makes sense to access both attributes directly via the domain model instead of
duplicating them.

\begin{figure}[!htbp]
@d Node view model methods
@{
@@property
def type_(self):
    """Return the type of the node, determined by its domain model.

    :return: the type of the node.
    :rtype: types.NodeType
    """

    return self.domain_object.type_
@}
\caption{The type attribute of the node view model as property.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Methods}
% \label{editor:lst:node-view-model:methods:type}
\end{figure}

\begin{figure}[!htbp]
@d Node view model methods
@{
@@property
def name(self):
    """Return the name of the node, determined by its domain model.

    :return: the name of the node.
    :rtype: str
    """

    return self.domain_object.name
@}
\caption{The name attribute of the node view model as property.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Methods}
% \label{editor:lst:node-view-model:methods:name}
\end{figure}

\newthought{The domain model does not provide access} to its type at the moment
however. The type is directly derived from the primary output of a node. If a
node has no outputs at all, its type is assumed to be generic.

\begin{figure}[!htbp]
@d Node domain model methods
@{
@@property
def type_(self):
    """Return the type of the node, determined by its primary
    output. If no primary output is given, it is assumed that
    the node is of generic type."""

    type_ = types.NodeType.GENERIC

    if len(self.outputs) > 0:
        type_ = self.outputs[0].type_

    return type_@}
\caption{The type attributes of the node domain model as property.
  \newline{}\newline{}Editor $\rightarrow$ Node (domain) model $\rightarrow$
  Methods}
% \label{editor:lst:node-domain-model:methods:type}
\end{figure}

\newthought{Concerning the drawing of nodes} (or painting, as Qt calls it) ,
each node type may be used multiple times. But instead of re-creating the same
image representation over and over again, it makes sense to create it only once
per node type. Qt provides~\verb=QPixmap= and~\verb=QPixmapCache= for this use
case.

\begin{figure}[!htbp]
@d Node view model methods
@{
def paint(self, painter, option, widget):
    """Paint the node.

    First a pixmap is loaded from cache if available, otherwise
    a new pixmap gets created. If the current node is selected a
    rectangle gets additionally drawn on it. Finally the name,
    the type as well as the sub type gets written on the node.
    """

    @<Node view model methods paint@>
@}
\caption{The paint method of the node view model. When a pixmap is being
  created, it gets cached immediately, based on its type, status and its
  selection status. If a pixmap already existing for a given tripe, type, status
  and selection, that pixmap is used.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Methods}
% \label{editor:lst:node-view-model:methods:paint}
\end{figure}

\newthought{Each node has a cache key assigned}, which is used to identify that
node.

\begin{figure}[!htbp]
@d Node view model constructor
@{
    self.cache_key = None
@}
\caption{The cache key is being initialized within a node's constructor.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Constructor}
% \label{editor:lst:node-view-model:constructor:cache-key}
\end{figure}

The cache key is composed of the type of the node, its status and whether it is
selected or not.

\begin{figure}[!htbp]
@d Node view model methods
@{
def create_cache_key(self):
    """Create an attribute based cache key for finding and
    creating pixmaps."""

    return "{type_name}{status}{selected}".format(
        type_name=self.type_,
        status=self.status,
        selected=self.isSelected(),
    )
@}
\caption{A method which creates a cache key based on the type, the status and
  the state of selection of a node.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Methods}
% \label{editor:lst:node-view-model:methods:create-cache-key}
\end{figure}

As can be seen in the above code fragment, the status property of the node is
used to create a cache key, but currently nodes do not have a status.

It may make sense although to provide a status for each node, which allows to
output eventual problems like not having required connections and so on.

\newthought{This status is added} to the constructor of the domain model of a node.

\begin{figure}[!htbp]
@d Node domain model constructor
@{
    self.status = flag.NodeStatus.OK
@}
\caption{The status of the node is being initialized within the node's constructor.
  \newline{}\newline{}Editor $\rightarrow$ Node domain model $\rightarrow$
  Constructor}
% \label{editor:lst:node-domain-model:constructor:status}
\end{figure}

\newthought{Concerning the view model}, again the status of the domain model is
used as otherwise different states between user interface and domain model would
be possible in the worst case.

\begin{figure}[!htbp]
@d Node view model methods
@{
@@property
def status(self):
    """Return the current status of the node.

    :return: the current status of the node.
    :rtype: flag.NodeStatus
    """

    return self.domain_object.status
@}
\caption{The status of a node view model is obtained by accessing the domain
  model's status.
  \newline{}\newline{}Editor $\rightarrow$ Node domain model $\rightarrow$
  Methods}
% \label{editor:lst:node-view-model:methods:status}
\end{figure}

Therefore it can now be checked, whether a node has a cache key or not. If it
has no cache key, a new cache key is created.

\begin{figure}[!htbp]
@d Node view model methods paint
@{
if self.cache_key is None:
    self.cache_key = self.create_cache_key()
@}
\caption{A cache key is being created when no cache key for the given attributes
  is found.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Methods $\rightarrow$ Paint}
% \label{editor:lst:node-view-model:methods:paint:create-cache-key}
\end{figure}

The cache key itself is then used to find a corresponding pixmap.

\begin{figure}[!htbp]
@d Node view model methods paint
@{
pixmap = QtGui.QPixmapCache.find(self.cache_key)
@}
\caption{Based on the created or retrieved cache key a pixmap is being searched
  for.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Methods $\rightarrow$ Paint}
% \label{editor:lst:node-view-model:methods:paint:find-pixmap}
\end{figure}

If no pixmap with the given cache key exists, a new pixmap is being created and
added to the cache using the cache key created before.

\begin{figure}[!htbp]
@d Node view model methods paint
@{
if pixmap is None:
    pixmap = self.create_pixmap()
    QtGui.QPixmapCache.insert(self.cache_key, pixmap)
@}
\caption{If no pixmap is found, a new pixmap is being created for the provided
  key and stored.
  \newline{}\newline{}Editor $\rightarrow$ Node view model $\rightarrow$
  Methods $\rightarrow$ Paint}
% \label{editor:lst:node-view-model:methods:paint:create-pixmap}
\end{figure}

\newthought{For actually displaying the nodes}, another component is necessary:
the scene view which is a graph consisting the nodes and edges.
