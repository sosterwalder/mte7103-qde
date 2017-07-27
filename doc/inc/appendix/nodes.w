%-*- mode: latex; coding: utf-8 -*-

\chapter{Nodes}
\label{appendix:chap:nodes}

\newthought{Thinking of the definition of what shall be achieved}, as defined
at~\autoref{appendix:chap:editor}, a node defining a sphere is implemented.

\begin{figure}
@d Implicit sphere node
@{
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
    "invocations": [
        @<Implicit sphere node invocations@>
    ],
    "parts": [
        @<Implicit sphere node parts@>
    ],
    "nodes": [
        @<Implicit sphere node nodes@>
    ],
    "connections": [
        @<Implicit sphere node connections@>
    ]
}@}
\caption{Definition of a node for an implicitly defined sphere.
  \newline{}\newline{}Implicit sphere node}
\label{editor:lst:nodes:sphere-node}
\end{figure}

At the current point the sphere node will only have one input: the radius of
the sphere. The positition of the sphere will be at the center (meaning the
X-, the Y- and the Z-position are all 0).

\newthought{For being able to change the position}, another node will be
introduced.

\begin{figure}
@d Implicit sphere node inputs
@{
{
    "name": "radius",
    "atomic_id": "468aea9e-0a03-4e63-b6b4-8a7a76775a1a",
    "default_value": {
        "type_": "float",
        "value": "1"
    },
    "id_": "f5c6a538-1dbc-4add-a15d-ddc4a5e553da",
    "description": "The radius of the sphere",
    "min_value": "-1000",
    "max_value": "1000"
}@}
\caption{Radius of the implicit sphere node as input.
  \newline{}\newline{}Implicit sphere node $\rightarrow$ Inputs}
\label{editor:lst:nodes:sphere-node:inputs:radius}
\end{figure}

\newthought{The output of the sphere node} is of type implicit as the node
represents an implicit surface.

\begin{figure}
@d Implicit sphere node outputs
@{
{
    "name": "output",
    "id_": "a3ac68e5-5afe-4779-9e9f-5b619e041ae6",
    "atomic_id": "c019271c-35b6-425c-9ff2-a1d893111adb"
}@}
\caption{The output of the implicit sphere node, which is of the atomic type
  implicit.
  \newline{}\newline{}Implicit sphere node $\rightarrow$ Outputs}
\label{editor:lst:nodes:sphere-node:outputs:implicit}
\end{figure}

\newthought{The definition of the node is the actual implementation} of a sphere
as a implicit surface.

\begin{figure}
@d Implicit sphere node definitions
@{
{
    "id_": "99d20a26-f233-4310-adb2-5e540726d079",
    "script": [
        "// Returns the signed distance to a sphere with given radius for the",
        "// given position.",
        "float sphere(vec3 position, float radius)",
        "{",
        "    return length(position) - radius;",
        "}"
    ]
}@}
\caption{Implementation of the sphere in the OpenGL Shading Language (GLSL).
  \newline{}\newline{}Implicit sphere node $\rightarrow$ Definitions}
\label{editor:lst:nodes:sphere-node:definition}
\end{figure}

\newthought{The invocation of the node} is simply calling the above definition
using the parameters of the node, which is in this case the radius.

\newthought{The parameters are in case of implicit surfaces} uniform variables
of the type of the parameter, as implicit surfaces are rendered by the fragment
shader. The uniform variables are defined by a type and an identifier, whereas
in the case of paramaters their identifier is used.

The position of the node is an indirect parameter, which is not defined by the
node's inputs. It will be setup by the node's parts.

\begin{figure}
@d Implicit sphere node invocations
@{
{
    "id_": "4cd369d2-c245-49d8-9388-6b9387af8376",
    "type": "implicit",
    "script": [
        "float s = sphere(",
        "    16d90b34-a728-4caa-b07d-a3244ecc87e3-position,",
        "    5c6a538-1dbc-4add-a15d-ddc4a5e553da",
        ");"
    ]
}@}
\caption{The position of the implicit sphere node as invocation.
  \newline{}\newline{}Implicit sphere node $\rightarrow$ Invocations}
\label{editor:lst:nodes:sphere-node:invocations:position}
\end{figure}

\newthought{The parts of the node}, in this case it is only one part, contain
the body of the node. The body is about evaluating the inputs and passing them
on to a shader.

\todo[inline]{Change this to C and use CFFI.}

\begin{figure}
@d Implicit sphere node parts
@{
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
        "        shader = context.current_shader.program",
        "        ",
        "        radius = inputs[0].process(context).value",
        "        shader_radius_location = shader.uniformLocation(\"f5c6a538-1dbc-4add-a15d-ddc4a5e553da\")",
        "        shader.setUniformValue(shader_radius_location, radius)",
        "        ",
        "        position = self.position",
        "        shader_position_location = shader.uniformLocation(",
        "            \"16d90b34-a728-4caa-b07d-a3244ecc87e3-position\"",
        "        )",
        "        shader.setUniformValue(shader_position_location, position)",
        "        ",
        "        return context"
    ]
}@}
\caption{The~\enquote{body} of the implicit sphere node as node part.
  \newline{}\newline{}Implicit sphere node $\rightarrow$ Parts}
\label{editor:lst:nodes:sphere-node:parts:body}
\end{figure}

\newthought{Connections are composed of an input and an output} plus a reference
to a part, as stated in \todo{Add reference}. In this case there is exactly one
input, the radius, and one output, an object defined by implicit functions.

The radius is being defined by an input, which is therefore being referenced as
source. There is although no external node being referenced, as the radius is
of the atomic type float. Therefore the source node is 0, meaning it is an
internal reference. The input itself is used as part for the input.

The very same applies for the output of that connection. The radius is being
consumed by the first part of the node's part (which has only this part). As
this definition is within the same node, the target node is also 0. The part is
then being referenced by its identifier.

\begin{figure}
@d Implicit sphere node connections
@{
{
    "source_node": "00000000-0000-0000-0000-000000000000",
    "source_part": "f5c6a538-1dbc-4add-a15d-ddc4a5e553da",
    "target_node": "00000000-0000-0000-0000-000000000000",
    "target_part": "74b73ce7-8c9d-4202-a533-c77aba9035a6"
}@}
\caption{Mapping of the connections of the implicit sphere node. Note that the
  inputs and outputs are internal, therefore the node references are 0.
  \newline{}\newline{}Implicit sphere node $\rightarrow$ Connections}
\label{editor:lst:nodes:sphere-node:connections}
\end{figure}

\newthought{Now a very basic node is avaialble}, but the node does not get
recognized by the application yet. As nodes are defined by external files, they
need to be searched, loaded and registered to make them available to the
application.

\newthought{Therefore the node controller is introduced}, which will manage the
node definitions.

\begin{figure}
@d Node controller declarations
@{
@@common.with_logger
class NodeController(QtCore.QObject):
    """The node controller.

    A controller managing nodes.
    """

    # Constants
    NODES_PATH = "nodes"
    NODES_EXTENSION = "node"
    ROOT_NODE_ID = uuid.UUID("026c04d0-36d2-49d5-ad15-f4fb87fe8eeb")
    ROOT_NODE_OUTPUT_ID = uuid.UUID("a8fadcfc-4e19-4862-90cf-a262eef2219b")

    # Signals
    @<Node controller signals@>

    @<Node controller constructor@>
    @<Node controller methods@>

    @<Node controller slots@>
@}
\caption{Definition of the node controller.
  \newline{}\newline{}Editor $\rightarrow$ Node controller}
\label{editor:lst:node-controller}
\end{figure}

\newthought{The node controller assumes}, that all node definitions are placed
within the~\verb=nodes= subdirectory of the application's working directory.
Further it assumes, that node definition files use the~\verb=node= extension.

\begin{figure}
@d Node controller constructor
@{
def __init__(self, parent=None):
    """ Constructor. 

    :param parent: the parent of this node controller.
    :type  parent: QtCore.QObject
    """

    super(NodeController, self).__init__(parent)

    self.nodes_path = "{current_dir}{sep}{nodes_path}".format(
        current_dir=os.getcwd(),
        sep=os.sep,
        nodes_path=NodeController.NODES_PATH
    )
    self.nodes_extension = NodeController.NODES_EXTENSION@}
\caption{Constructor of the node controller.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Constructor}
\label{editor:lst:node-controller:constructor}
\end{figure}

\newthought{The node controller will then scan} that directory containing the
node definitions and load each one.

\begin{figure}
@d Node controller methods
@{
def load_nodes(self):
    """Loads all files with the ending NodeController.NODES_EXTENSION
    within the NodeController.NODES_PATH directory, relative to the current
    working directory.
    """

    @<Node controller load nodes method@>@}
\caption{A method that loads node definitions from external files from within
  the node controller.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Methods}
\label{editor:lst:node-controller:methods:load-nodes}
\end{figure}

\newthought{Node definitons will contain parts.} The parts within a node
definition are used to create corresponding parts within instances of
themselves. The parts are able to create values based on the atomic types
through functions.

\begin{figure}
@d Node definition part domain model declarations
@{
class NodeDefinitionPart(object):
    """Represents a part of the definition of a node."""

    # Signals
    @<Node definition part domain model signals@>

    @<Node definition part domain model constructor@>
    @<Node definition part domain model methods@>@}
\caption{Definition of a part of a node definition.
  \newline{}\newline{}Editor $\rightarrow$ Node definition part}
\label{editor:lst:node-definition-part}
\end{figure}

\newthought{The part of a node definition} holds an identifier as well as an
expression to create a function for creating and handling values which will be
used when evaluating a node. Further it provides a function which allows to
instantiate itself as part of a node (instance).

\begin{figure}
@d Node definition part domain model constructor
@{
def __init__(self, id_):
    """Constructor.

    :param id_: the globally unique identifier of the part of the node
                definition.
    :type  id_: uuid.uuid4
    """

    self.id_    = id_
    self.type_  = None
    self.name   = None
    self.script = None
    self.parent = None

    # This property is used when evaluating node instances using this node
    # definition
    self.function_creator = lambda: create_value_function(
        parameter.FloatValue(0)
    )

    # This property will be used to create/instantiate a part of a node
    # instance
    self.creator_function = None
    @}
\caption{Constructor of the node definition part.
  \newline{}\newline{}Editor $\rightarrow$ Node definition part}
\label{editor:lst:node-definition-part:constructor}
\end{figure}

\newthought{The node controller needs to keep track} of node definition parts, as
they are a central aspect and may be reused.

\begin{figure}
@d Node controller constructor
@{
    self.node_definition_parts = {}
@}
\caption{The node controller keeps track of node definition parts.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Constructor}
\label{editor:lst:node-controller:constructor:node-definition-parts}
\end{figure}

The code snippet defining the constructor of a node definition
part,~\autoref{editor:lst:node-definition-part:constructor}, uses a function
called~\verb=create_value_function= of the~\verb=functions= module.

\begin{figure}
@d Node domain module methods
@{
def create_value_function(value):
    """Creates a new value function using the provided value.

    :param value: the value which the function shall have.
    :type  value: qde.editor.domain.parameter.Value
    """

    value_function = NodePart.ValueFunction()
    value_function.value = value.clone()

    return value_function
@}
\caption{Helper function which creates a value function from the given value.
  \newline{}\newline{}Editor $\rightarrow$ Node domain model $\rightarrow$
  Module methods}
\label{editor:lst:node-domain-model:module-methods:create-value-function}
\end{figure}

\newthought{That brings up the concept of value functions.} Value functions are
one of the building blocks of a node. They are used to evaluate a node
value-wise through its inputs.

\begin{figure}
@d Node part domain model value function declarations
@{
class ValueFunction(Function):
    """Class representing a value function for nodes."""

    def __init__(self):
        """Constructor."""

        super(NodePart.ValueFunction, self).__init__()
        self.value = None

    def clone(self):
        """Clones the currently set value function.

        :return: a clone of the currently set value function.
        :rtype: qde.editor.domain.node.NodePart.Function
        """

        new_function = create_value_function(self.value)
        new_function.node_part = self.node_part

        return new_function

    def process(self, context, inputs, output_index):
        """Processes the value function for the given context, the given inputs
        and the given index of the output.

        :param context: the context of the processing
        :type  context: qde.editor.domain.node.NodePartContext
        :param inputs: a list of inputs to process
        :type inputs: list
        :param output_index: the index of the output which shall be used
        :type output_index: int

        :return: the context
        :rtype:  qde.editor.domain.node.NodePartContext
        """

        if not self.value.is_cachable or self.has_changed:
            if len(inputs) > 0:
                inputs[0].process(context, self.processing_index)
                value.set_value_from_context(context)
            else:
                self.value.set_value_in_context(context)

            self.has_changed = False
        else:
            self.value.set_value_in_context(context)

        # TODO: Handle events

        return context@}
\caption{Definition of the value function class which is used within nodes.
  \newline{}\newline{}Editor $\rightarrow$ Value function}
\label{editor:lst:value-function}
\end{figure}

\newthought{The value function of a node} may not be clear during the
initialization of the node or it may be simply be subject to change.
Therefore it makes sense to provide a default value function which gets used by
default.

\begin{figure}
@d Node part domain model default value function declarations
@{
class DefaultValueFunction(ValueFunction):
    """The default value function of a node part."""

    def __init__(self):
        """Constructor."""

        super(NodePart.DefaultValueFunction, self).__init__()

    def clone(self):
        """Returns itself as a default value function may not be cloned.

        :return: a self-reference.
        :rtype: DefaultValueFunction
        """

        return self

    def process(self, context, inputs, output_index):
        """Processes the default value function for the given context, the given inputs
        and the given index of the output.

        :param context: the context of the processing
        :type  context: qde.editor.domain.node.NodePartContext
        :param inputs: a list of inputs to process
        :type inputs: list
        :param output_index: the index of the output which shall be used
        :type output_index: int

        :return: the context
        :rtype:  qde.editor.domain.node.NodePartContext
        """

        self.value.set_value_in_context(context)
        self.has_changed = False

        return context@}
\caption{Definition of the default value function class, which is derived from
  the value function class.
  \newline{}\newline{}Editor $\rightarrow$ Default value function}
\label{editor:lst:default-value-function}
\end{figure}

\newthought{The value function relies strongly on the conecpt of node parts},
which is not defined yet. A part of a node is actually an instance of an atomic
type (which is usually an input) within an instance of a node definition.

\begin{figure}
@d Node part domain model declarations
@{
class NodePart(object):
    """Represents a part of a node."""

    @<Node part domain model function declarations@>
    @<Node part domain model value function declarations@>
    @<Node part domain model default value function declarations@>

    # Signals
    @<Node part domain model signals@>

    @<Node part domain model constructor@>
    @<Node part domain model methods@>
@}
\caption{The node part class.
  \newline{}\newline{}Editor $\rightarrow$ Node part}
\label{editor:lst:node-part}
\end{figure}

\begin{figure}
@d Node part domain model constructor
@{
def __init__(self, id_, default_function, type_=types.NodeType.GENERIC, script=None):
    """constructor.

    :param id_: the identifier of the node part.
    :type  id_: uuid.uuid4
    :param default_function: the default function of the part.
    :type default_function: function
    :param type_: the type of the node part.
    :type type_: qde.editor.foundation.types.NodeType
    :param script: the script of the part.
    :type script: str
    """

    self.id_              = id_
    self.function_        = default_function
    self.default_function = default_function
    self.script           = script
    self.type_            = type_@}
\caption{Constructor of the node part class.
  \newline{}\newline{}Editor $\rightarrow$ Node part}
\label{editor:lst:node-part:constructor}
\end{figure}

\newthought{A part of a node has a function}, which gets called whenever a part
of a node is being processed.

\begin{figure}
@d Node part domain model function declarations
@{
class Function(object):
    """Represents the function of a part of a node."""

    def __init__(self):
        """Constructor."""

        self.has_changed = True
        self.evaluation_index = 0
        self.changed_state = types.StateChange.VALUE.value | types.StateChange.SUBTREE.value

    def clone(self):
        """Clones the currently set function."""

        message = QtCore.QCoreApplication.translate(
            __class__.__name__,
            "This method must be implemented in a child class"
        )
        raise NotImplementedError(message)

    def process(self, context, inputs, output_index):
        """Processes the value function for the given context, the given
        inputs."""

        message = QtCore.QCoreApplication.translate(
            __class__.__name__,
            "This method must be implemented in a child class"
        )
        raise NotImplementedError(message)
@}
\caption{Definition of the function class which is used in parts of nodes.
  \newline{}\newline{}Editor $\rightarrow$ Function}
\label{editor:lst:function}
\end{figure}

\newthought{When a part of a node is being processed}, also its inputs are
processed. Whenever an input (value) changes, the node part needs to handle the
changes. There are three possible types of changes: nothing has changed, the
value (of the function) has changed or the subtree (inputs) has changed.

\begin{figure}
@d Node part state changed declarations
@{
class StateChange(enum.Enum):
    """Possible changes of state."""

    NOTHING  = 0
    VALUE    = 1
    SUBTREE  = 2@}
\caption{A class which holds the possible values of a state change of a node
  part.
  \newline{}\newline{}Editor $\rightarrow$ State change}
\label{editor:lst:state-change}
\end{figure}

\newthought{Finally all nodes will be composed of atomic types.} When building
the node definition from the JSON input, the (atomic) part of the node
definition is fetched from the node controller. Therefore it is necessary to
provide parts for the atomic types before loading all the node definitions.

\begin{figure}
@d Node controller load nodes method
@{
for atomic_type in parameter.AtomicTypes.atomic_types:
    if atomic_type.id_ not in self.node_definition_parts:
        self.node_definition_parts[atomic_type.id_] = atomic_type
        self.logger.info(
            "Added atomic type %s: %s",
            atomic_type.type_, atomic_type.id_
        )
    else:
        self.logger.warn((
            "Already knowing node part for atomic type %s. This should not"
            "happen"
        ), atomic_type.type_)@}
\caption{The node controller provides the atomic types which build the basis of
  the part of a node.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$ Methods
  $\rightarrow$ Load nodes}
\label{editor:lst:node-controller:methods:load-nodes:atomic-types}
\end{figure}

\newthought{Having the atomic types available as parts}, the node definitions
themselves may be loaded. There is only one problem to that: there is nothing to
hold the node defintions. Therefore the node definition domain model is
introduced.

\begin{figure}
@d Node definition domain model declarations
@{
class NodeDefinition(object):
    """Represents the definition of a node."""

    # Signals
    @<Node definition domain model signals@>

    @<Node definition domain model constructor@>
    @<Node definition domain model methods@>@}
\caption{Definition of the node definition class, which represents the definition
  of a node.
  \newline{}\newline{}Editor $\rightarrow$ Node definition}
\label{editor:lst:node-definition}
\end{figure}

\newthought{The definition of a node} is quite similar to a node itself. As the
definition of a node may be changed, the flag~\verb=was_changed= is added.
Further a node definition holds all instances of itself, meaning nodes.

\begin{figure}
@d Node definition domain model constructor
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
    self.definitions = []
    self.invocations = []
    self.parts       = []
    self.nodes       = []
    self.connections = []
    self.instances   = []
    self.was_changed = False@}
\caption{Constructor of the node definition class.
  \newline{}\newline{}Editor $\rightarrow$ Node definition $\rightarrow$
  Constructor}
\label{editor:lst:node-definition:constructor}
\end{figure}

\newthought{The node controller is now able} to instantiate nodes definitions
and keep them in a list. The controller manages both, the domain and the view
models. As they both share the same ID, as the view model is being created from
the data of the domain model, only one entry is necessary. The entry in the
dictionary will therefore hold a tuple, containing the domain and the view
model, identified by their common identifier.

\begin{figure}
@d Node controller constructor
@{
    self.node_definitions = {}
@}
\caption{The node controller holds a dictionary containing node definitions.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Constructor}
\label{editor:lst:node-controller:constructor:node-definitions}
\end{figure}

\newthought{The node controller scans} the~\verb=node= subdirectory, containing
the node definitions, for files ending in~\verb=node=.

\begin{figure}
@d Node controller load nodes method
@{

if os.path.exists(self.nodes_path):
    node_definition_files = glob.glob("{path}{sep}*.{ext}".format(
        path=self.nodes_path,
        sep=os.sep,
        ext=self.nodes_extension
    ))
    num_node_definitions = len(node_definition_files)
    if num_node_definitions > 0:
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
            node_definition = self.load_node_definition_from_file_name(file_name)
            if node_definition is not None:
                node_definition_view_model = node_gui_domain.NodeViewModel(
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
        )
    else:
        message = QtCore.QCoreApplication.translate(
            __class__.__name__, "No node definitions found."
        )
        self.logger.warn(message)
else:
    message = QtCore.QCoreApplication.translate(
        __class__.__name__, "No node definitions found."
    )
    self.logger.warn(message)
@}
\caption{The node controller loads and parses node definition files from the
  file system.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Methods $\rightarrow$ Load nodes}
\label{editor:lst:node-controller:methods:load-nodes:laod}
\end{figure}

\newthought{If a file containing a node definition is found}, its identifier is
extracted from the file name. If the node definition is not known yet, it gets
loaded and added to the list of known node definitions.

\begin{figure}
@d Node controller methods
@{
def load_node_definition_from_file_name(self, file_name):
    """Loads a node definition from the given file name.
    If no such file exists, None is returned.

    :param file_name: the file name to load.
    :type  file_name: str

    :return: the loaded node definition and its identifier or None
    :rtype:  qde.editor.domain.node.NodeDefinition or None
    """

    if not os.path.exists(file_name):
        self.logger.warn((
            "Tried to load node definition from file %s, "
            "but the file does not exist"
        ), file_name)
        return None

    # Extract the definition identifier from the file name, which is
    # "uuid4.node".
    definition_id = os.path.splitext(os.path.basename(file_name))[0]

    if definition_id in self.node_definitions:
        self.logger.warn(
            "Should load node definition from file %s, but is already loaded",
            file_name
        )
        return self.node_definitions[definition_id]

    try:
        with open(file_name) as definition_fh:
            node_definition = json.Json.load_node_definition(
                self, definition_fh
            )
            self.logger.debug(
                "Loaded node definition %s from file %s",
                definition_id, file_name
            )
            # TODO: Trigger (loading) callback
            @<Node controller load node definition trigger callback@>
            return node_definition
    except json.json.decoder.JSONDecodeError as exc:
        self.logger.warn(
            "There was an error loading the node definition %s: %s",
            definition_id, exc
        )
        return None@}
\caption{A method which tries to load a node definition from the
  file system using the provided file name.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Methods $\rightarrow$ Load node definition from file name}
\label{editor:lst:node-controller:methods:load-node-definition-from-file-name}
\end{figure}

\newthought{Whenever a new node definition gets loaded}, other components need
to be informed about the fact, that a new node definition is available. However,
as the signal emits a view model, the laoded node definition cannot be emitted
directly. Instead a view model needs to be created, which will then be emitted.

\begin{figure}
@d Node controller load node definition emit
@{
self.do_add_node_view_definition.emit(node_definition_view_model)
@}
\caption{Whenever a new node definition gets loaded, the node controller emits a
  corresponding signal containing the node view model for the loaded node definition.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Methods $\rightarrow$ Load node definitions}
\label{editor:lst:node-controller:methods:load-node-definitions:do-add-node-view-definition}
\end{figure}

\newthought{The loading of the node definition itself} is simply about parsing the various
sections and handling them correspondingly. To prevent the node controller from
being bloated, the parsing is done in a separate module responsible for JSON
specific tasks.

\begin{figure}
@d JSON methods
@{
@@classmethod
def load_node_definition(cls, node_controller, json_file_handle):
    """Loads a node definition from given JSON input.

    :param node_controller: reference to the node controller
    :type node_controller: qde.editor.application.node.NodeController
    :param json_file_handle: an open file handle containing JSON data
    :type json_file_handle: file

    :return: a node definition
    :rtype: qde.editor.domain.node.NodeDefinition
    """

    o = json.load(json_file_handle)

    name        = str(o['name'])
    id_         = uuid.UUID(o['id_'])
    description = str(o['description'])

    inputs = []
    for input in o['inputs']:
        node_definition_input = cls.build_node_definition_input(
            node_controller, input
        )
        inputs.append(node_definition_input)

    outputs = []
    for output in o['outputs']:
        node_definition_output = cls.build_node_definition_output(
            node_controller, output
        )
        outputs.append(node_definition_output)

    node_definitions = {}
    for node_def in o['nodes']:
        definition_id, node_definition = cls.build_node_definition(node_def)
        node_definitions[definition_id] = node_definition

    connections = []
    for conn in o['connections']:
        connection = cls.build_node_definition_connection(conn)
        connections.append(connection)

    definitions = []
    for d in o['definitions']:
        definition = cls.build_node_definition_definition(d)
        definitions.append(definition)

    invocations = []
    for i in o['invocations']:
        invocation = cls.build_node_definition_invocation(i)
        invocations.append(invocation)

    node_definition             = node.NodeDefinition(id_)
    node_definition.name        = name
    node_definition.description = description
    node_definition.inputs      = inputs
    node_definition.outputs     = outputs
    node_definition.nodes       = node_definitions
    node_definition.connections = connections
    node_definition.definitions = definitions
    node_definition.invocations = invocations

    # TODO: Check if this part can be abve the def. instance
    parts = []
    for p in o['parts']:
        part = cls.build_node_definition_part(node_controller, node_definition, p)
        parts.append(part)
    node_definition.parts = parts

    # TODO: Do a consistency check
    node_definition.was_changed = False

    return node_definition@}
\caption{A class method of the JSON module, which loads a node definition from a
  file handle (pointing to a JSON file containing a node definition).
  \newline{}\newline{}Editor $\rightarrow$ JSON $\rightarrow$
  Methods $\rightarrow$ Load node definition}
\label{editor:lst:json:methods:load-node-definition}
\end{figure}

\newthought{Not all parts of node definitions are defined yet}: inputs, outputs,
other node definitions, connections, definitions, invocations and parts.First
the building of the node definition inputs is defined.

\begin{figure}
@d JSON methods
@{
@@classmethod
def build_node_definition_input(cls, node_controller, json_input):
    """Builds and returns a node definition input from the given JSON input
    data.

    :param node_controller: a reference to the node controller
    :type  node_controller: qde.editor.application.node.NodeController
    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: a node definition input
    :rtype:  qde.editor.domain.node.NodeDefinitionInput
    """

    input_id             = uuid.UUID(json_input['id_'])
    name                 = str(json_input['name'])
    atomic_id            = uuid.UUID(json_input['atomic_id'])
    description          = str(json_input['description'])
    node_definition_part = node_controller.get_node_definition_part(atomic_id)

    default_value_str = ""
    default_value_entry = json_input['default_value']
    default_value = parameter.create_value(
        default_value_entry['type_'],
        default_value_entry['value']
    )

    min_value = float(json_input['min_value'])
    max_value = float(json_input['max_value'])

    node_definition_input = node.NodeDefinitionInput(
        input_id,
        name,
        node_definition_part,
        default_value
    )
    node_definition_input.description = description
    node_definition_input.min_value = min_value
    node_definition_input.max_value = max_value

    cls.logger.debug(
        "Built node definition input for node definition %s",
        atomic_id
    )
    return node_definition_input
@}
\caption{A class method of the JSON module, which builds the input of a node
  definition from a file handle (pointing to a JSON file containing a node
  definition).
  \newline{}\newline{}Editor $\rightarrow$ JSON $\rightarrow$
  Methods $\rightarrow$ Build node definition input}
\label{editor:lst:json:methods:build-node-definition-input}
\end{figure}

\newthought{There are a few things missing}, which are used in the above code
fragment: the possibility to create values from given parameters, the actual
node definition input as domain model and getting the node definition part
identified by the given atomic identifier.

\begin{figure}
@d Node controller methods
@{
def get_node_definition_part(self, id_):
    """Returns the node definition part identified by the given identifier.

    If no such part is available, a generic part with that identifier is being
    created.

    :param id_: the identifier of the part of the node definition to get.
    :type  id_: uuid.uuid4

    :return: the node definition part identified by the given identifier.
    :rtype: qde.editor.domain.node.NodeDefinitionPart
    """

    if str(id_) not in self.node_definition_parts:
        self.logger.warn((
            "Part %s of the node definition was not found. Creating a"
            "generic one."
        ), id_)

        type_ = types.NodeType.GENERIC
        def create_func(id_, default_function, name, type_):
            node_part = node.NodePart(id_, None)
            node_part.type_ = type_
            node_part.name = name
            return node_part
        node_definition_part = node.NodeDefinitionPart(id_)
        node_definition_part.type_ = type_
        node_definition_part.creator_function = create_func
        self.node_definition_parts[id_] = node_definition_part
        return node_definition_part
    else:
        return self.node_definition_parts[str(id_)]
@}
\caption{A method of the node controller, which returns a node definition part
  by a provided identifier. If no node definition part is found for the given
  identifier, a new node definition part is created.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Methods $\rightarrow$ Get node definition part}
\label{editor:lst:node-controller:methods:get-node-definition-part}
\end{figure}

\newthought{The creation of values from given parameters} is done within the
parameter module, as this is something very parameter specific. Therefore a
static method is defined, which returns an instance of an atomic type, e.g. a
float value or a scene. \todo{instance of atomic type, ok?}

\begin{figure}
@d Parameter domain module methods
@{
def create_value(type_, value_string):
    """Creates an object of the given type with the given value.

    :param type_: the type of the value to create.
    :type  type_: str
    :param value_string: the value that the value shall have.
    "type  value_string: str

    :return: a value-type of the given type with the given value.
    :rtype: qde.editor.domain.parameter.Value
    """

    if type_.lower() == "float":
        float_value = float(value_string)
        return FloatValue(float_value)
    elif type_.lower() == "text":
        return TextValue(value_string)
    elif type_.lower() == "image":
        return ImageValue()
    elif type_.lower() == "scene":
        return SceneValue()
    elif type_.lower() == "generic":
        return GenericValue()
    elif type_.lower() == "dynamic":
        return DynamicValue()
    elif type_.lower() == "mesh":
        return MeshValue()
    elif type_.lower() == "implicit":
        return ImplicitValue()
    else:
        message = QtCore.QCoreApplication.translate(
            __module__.__name__, "Unknown type for value provided"
        )
        raise Exception(message)@}
\caption{Method of the parameter module, which creates an object of a specific
  value instance based on the provided type of the value.
  \newline{}\newline{}Editor $\rightarrow$ Parameter $\rightarrow$
  Create value}
\label{editor:lst:parameter:create-value}
\end{figure}

\newthought{For the specific value instances} a generic value interface is
defined. This interface holds a reference to the atomic type of the value and
defines what type the function of a value is.

\begin{figure}
@d Paramater domain model value generic interface
@{
class ValueInterface(object):
    """Generic value interface."""

    def __init__(self):
        """Constructor."""

        self.function_type = None

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        message = QtCore.QCoreApplication.translate(
            __module__.__name__,
            "This method must be implemented in a child class"
        )
        raise NotImplementedError(message)@}
\caption{Interface as basis for the value specific instances.
  \newline{}\newline{}Editor $\rightarrow$ Parameter $\rightarrow$
  Value interface}
\label{editor:lst:parameter:value-interface}
\end{figure}

Then an interface for setting and getting values is defined.

\begin{figure}
@d Paramater domain model value interface
@{
class Value(ValueInterface):
    """Value interface for setting and getting values."""

    def __init__(self, value):
        """Constructor.

        :param value: the value that shall be held
        :type  value: object
        """

        super(Value, self).__init__()
        self.value = value@}
\caption{Class which provides an interface to the value of the value specific
  instances.
  \newline{}\newline{}Editor $\rightarrow$ Parameter $\rightarrow$
  Value}
\label{editor:lst:parameter:value}
\end{figure}

\newthought{Now the specific value types are implemented}, based either on the
generic or the concrete value interface, depending on the type. Here just two
implementations are given as an example. The other implementations can be found
at~\todo{link to fragments}.

\begin{figure}
@d Paramater domain model float value
@{
class FloatValue(Value):
    """A class holding float values."""

    def __init__(self, float_value):
        """Constructor.

        :param float_value: the float value that shall be held
        :type  float_value: float
        """

        super(FloatValue, self).__init__(float_value)
        self.function_type = types.NodeType.FLOAT

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return FloatValue(self.value)@}
\caption{Implementation of the float value type.
  \newline{}\newline{}Editor $\rightarrow$ Parameter $\rightarrow$
  FloatValue}
\label{editor:lst:parameter:float-value}
\end{figure}

\begin{figure}
@d Paramater domain model scene value
@{
class SceneValue(ValueInterface):
    """A class holding scene values."""

    def __init__(self):
        """Constructor."""

        super(SceneValue, self).__init__()
        self.function_type = types.NodeType.SCENE

    def clone(self):
        """Clones the currently set value.

        :return: a clone of the currently set value
        :rtype:  qde.editor.domain.parameter.ValueInterface
        """

        return SceneValue()@}
\caption{Implementation of the scene value type.
  \newline{}\newline{}Editor $\rightarrow$ Parameter $\rightarrow$
  SceneValue}
\label{editor:lst:parameter:scene-value}
\end{figure}

\newthought{The definition of the input of a node definition} is still missing
however.

\begin{figure}
@d Node definition input domain model declarations
@{
class NodeDefinitionInput(object):
    """Represents an input of a definition of a node."""

    # Signals
    @<Node definition input domain model signals@>

    @<Node definition input domain model constructor@>
    @<Node definition input domain model methods@>@}
\caption{Implementation of the input of the definition of a node.
  \newline{}\newline{}Editor $\rightarrow$ Node definition input}
\label{editor:lst:node-definition-input}
\end{figure}

\begin{figure}
@d Node definition input domain model constructor
@{
def __init__(self, id_, name, node_definition_part, default_value):
    """Constructor.

    :param id_: the identifier of the definition
    :type  id_: uuid.uuid4
    :param name: the name of the definition
    :type  name: str
    :param node_definition_part: the atomic part of the node definition
    :type node_definition_part: TODO
    :param default_value: the default value of the input
    :type default_value: qde.editor.domain.parameter.Value
    """

    self.id_                  = id_
    self.name                 = name
    self.node_definition_part = node_definition_part
    self.description          = ""
    self.min_value            = -100000
    self.max_value            = 100000

    self.default_function = create_default_value_function(
        default_value
    )@}
\caption{Constructor of the input of the definition of a node.
  \newline{}\newline{}Editor $\rightarrow$ Node definition input $\rightarrow$
  Constructor}
\label{editor:lst:node-definition-input:constructor}
\end{figure}

\newthought{The code snippet defining the constructor of a node definition
input} uses a function called~\verb=create_default_value_function= of
the~\verb=functions= module. This function creates a default value function
based on the given default value.

\begin{figure}
@d Node domain module methods
@{
def create_default_value_function(value):
    """Creates a new default value function using the provided value.

    :param value: the value which the function shall have.
    :type  value: qde.editor.domain.parameter.Value
    """

    value_function = NodePart.DefaultValueFunction()
    value_function.value = value.clone()

    return value_function@}
\caption{Function that creates a default value function based on a provided
  value.
  \newline{}\newline{}Editor $\rightarrow$ Node $\rightarrow$
  Methods $\rightarrow$ Create default value function}
\label{editor:lst:node:create-default-value-function}
\end{figure}

\newthought{With this last implementation} all the parts needed for creating and
handling node definition inputs are defined, which leads to the next
implementation. The outputs of a node definition. The outputs are in the same
way implemented as the inputs of a node definition.

\begin{figure}
@d JSON methods
@{
@@classmethod
def build_node_definition_output(cls, node_controller, json_input):
    """Builds and returns a node definition output from the given JSON input
    data.

    :param node_controller: a reference to the node controller
    :type  node_controller: qde.editor.application.node.NodeController
    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: a node definition output
    :rtype:  qde.editor.domain.node.NodeDefinitionOutput
    """

    output_id             = uuid.UUID(json_input['id_'])
    name                 = str(json_input['name'])
    atomic_id            = uuid.UUID(json_input['atomic_id'])
    node_definition_part = node_controller.get_node_definition_part(atomic_id)

    node_definition_output = node.NodeDefinitionOutput(
        output_id,
        name,
        node_definition_part
    )

    cls.logger.debug(
        "Built node definition output for node definition %s",
        atomic_id
    )
    return node_definition_output
@}
\caption{A class method of the JSON module, which builds the output of a node
  definition from a file handle (pointing to a JSON file containing a node
  definition).
  \newline{}\newline{}Editor $\rightarrow$ JSON $\rightarrow$
  Methods $\rightarrow$ Build node definition output}
\label{editor:lst:json:methods:build-node-definition-output}
\end{figure}

\newthought{The domain model of the node definition output} is very similar to
the input, has less attributes although.

\begin{figure}
@d Node definition output domain model declarations
@{
class NodeDefinitionOutput(object):
    """Represents an output of a definition of a node."""

    # Signals
    @<Node definition output domain model signals@>

    @<Node definition output domain model constructor@>
    @<Node definition output domain model methods@>@}
\caption{Implementation of the output of the definition of a node.
  \newline{}\newline{}Editor $\rightarrow$ Node definition output}
\label{editor:lst:node-definition-output}
\end{figure}

\begin{figure}
@d Node definition output domain model constructor
@{
def __init__(self, id_, name, node_definition_part):
    """Constructor.

    :param id_: the identifier of the definition
    :type  id_: uuid.uuid4
    :param name: the name of the definition
    :type  name: str
    :param node_definition_part: the atomic part of the node definition
    :type node_definition_part: qde.editor.domain.node.NodeDefinitionPart
    """

    self.id_                  = id_
    self.name                 = name
    self.node_definition_part = node_definition_part@}
\caption{Constructor of the output of the definition of a node.
  \newline{}\newline{}Editor $\rightarrow$ Node definition input $\rightarrow$
  Constructor}
\label{editor:lst:node-definition-input:constructor}
\end{figure}

\newthought{A node definition may contain references} to other node defintions,
therefore it is necessary to parse them. The parsing is similar to that of the
inputs and outputs.

\begin{figure}
@d JSON methods
@{
@@classmethod
def build_node_definition(cls, node_controller, json_input):
    """Builds and returns a node definition from the given JSON input data.

    :param node_controller: a reference to the node controller
    :type  node_controller: qde.editor.application.node.NodeController
    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: a dictionary containg the node definition at the index of the
             definition identifier.
    :rtype:  dict
    """

    definition_id   = uuid.UUID(json_input['id_'])
    atomic_id       = uuid.UUID(json_input['atomic_id'])

    node_definition, node_view_model = node_controller.get_node_definition(
        atomic_id
    )

    cls.logger.debug(
        "Built node definition for node definition %s",
        atomic_id
    )
    return (definition_id, node_definition)
@}
\caption{A class method of the JSON module, which builds the definition of a node
  from a file handle (pointing to a JSON file containing a node
  definition).
  \newline{}\newline{}Editor $\rightarrow$ JSON $\rightarrow$
  Methods $\rightarrow$ Build node definition}
\label{editor:lst:json:methods:build-node-definition}
\end{figure}

As can be seen in the above code fragment, the node definition is returned by
the node controller. This is very similar to getting the node definition part
from the node controller.

\begin{figure}
@d Node controller methods
@{
def get_node_definition(self, id_):
    """Returns the node definition identified by the given identifier.

    If no such definition is available, it will be tried to load the
    definition. If this is not possible as well, None will be returned.

    :param id_: the identifier of the node definition to get.
    :type  id_: uuid.uuid4

    :return: the node definition identified by the given identifier or None.
    :rtype:  qde.editor.domain.node.NodeDefinition or None
    """

    self.logger.debug(
        "Getting node definition %s",
        id_
    )

    if str(id_) in self.node_definitions:
        return self.node_definitions[str(id_)]
    elif self.root_node is not None and id_ == self.root_node.id_:
        return self.root_node
    else:
        # The node definition was not found, try to load it from node
        # definition files.
        file_name = os.path.join(
            self.nodes_path,
            id_,
            self.nodes_extension
        )
        node_definition = self.load_node_definition_from_file_name(
            file_name
        )
        if node_definition is not None:
            node_definition_view_model = node_gui_domain.NodeViewModel(
                id_=node_definition.id_,
                domain_object=node_definition
            )
            self.node_definitions[node_definition.id_] = (
                node_definition,
                node_view_model
            )
            return (node_definition, node_view_model)
        else:
            return None@}
\caption{A method of the node controller, which returns a node definition
  by a provided identifier. If no node definition is found for the given
  identifier, a new node definition is created by loading the definition from
  the file system.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Methods $\rightarrow$ Get node definition}
\label{editor:lst:node-controller:methods:get-node-definition}
\end{figure}

\newthought{The node controller holds a reference to the root node} of the root
scene of the system. This scene acts as an entry point when evaluating the scene
graph.

\begin{figure}
@d Node controller constructor
@{
    # TODO: Load from coonfiguration?
    self.root_node = node_domain.NodeDefinition(NodeController.ROOT_NODE_ID)
    self.root_node.name = QtCore.QCoreApplication.translate(
        __class__.__name__,
        'Root'
    )
    root_node_output = node_domain.NodeDefinitionOutput(
        NodeController.ROOT_NODE_OUTPUT_ID,
        QtCore.QCoreApplication.translate(
            __class__.__name__,
            'Output'
        ),
        parameter.AtomicTypes.Generic
    )
    self.root_node.add_output(root_node_output)
    self.logger.debug("Created root node %s", NodeController.ROOT_NODE_ID)@}
\caption{The root node of the system is manually created by the node controller
  and is also a node definition.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$
  Constructor}
\label{editor:lst:node-controller:constructor:add-root-node}
\end{figure}

\newthought{Currently there is no possibility to add outputs} to a node
definition. Adding an output simply adds that output to the list of outputs the
node definition has. Furthermore that output needs to added for each instance of
that node definition as well. \todo{Add inputs as well?}

\begin{figure}
@d Node definition domain model methods
@{
def add_output(self, node_definition_output):
    """Adds the given output to the beginning of the list of outputs and
    also to all instances of this node definition.

    :param node_definition_output: the output to add.
    :type  node_definition_output: qde.editor.domain.node.NodeDefinitionOutput
    """

    self.add_output_at(len(self.outputs), node_definition_output)

def add_output_at(self, index, node_definition_output):
    """Adds the given output to the list of outputs at the given index
    position and also to all instances of this node definition.

    :param index: the position in the list of outputs where the new output
                  shall be added at.
    :type  index: int
    :param node_definition_output: the output to add.
    :type  node_definition_output: qde.editor.domain.node.NodeDefinitionOutput

    :raise: an index error when the given index is not valid.
    :raises: IndexError
    """

    if index < 0 or index > len(self.outputs):
        raise IndexError()

    self.outputs.insert(index, node_definition_output)

    for instance in self.instances:
        instance.add_output_at(
            index,
            node_definition_output.create_instance()
        )

    # TODO: Insert connection if output is atomic

    self.was_changed = True@}
\caption{Methods which add a given output of a node definition to a node
  definition. The first method adds the output at the end of the list of
  outputs, the second adds the output at the given index.
  \newline{}\newline{}Editor $\rightarrow$ Node definition $\rightarrow$
  Methods}
\label{editor:lst:node-definition:methods:add-output}
\end{figure}

\begin{figure}
@d Node definition domain model methods
@{
# TODO: Describe this properly
@@property
def type_(self):
    """Return the type of the node, determined by its primary output.
    If no primary output is given, it is assumed that the node is of
    generic type."""

    type_ = types.NodeType.GENERIC

    if len(self.outputs) > 0:
        type_ = self.outputs[0].node_definition_part.type_

    return type_@}
\caption{Type property of a node definition. If the node definition uses
  outputs, the type is derived by its primary output. Otherwise a generic type
  is assumed.
  \newline{}\newline{}Editor $\rightarrow$ Node definition $\rightarrow$
  Methods}
\label{editor:lst:node-definition:methods:type}
\end{figure}

Having the reading and parsing of inputs, outputs and other node definition
implemented, the reading and parsing of connections, definitions, invocations
and parts still remains.

\newthought{The reading and parsing} of connections, definitions and invocation
is very straightforward and very similar to the one of the node definitions.
Therefore it will not be shown in detail. Details are found at~\todo[inline]{Add
reference to code fragments here}.

\newthought{The last part when loading a node definition} is reading and parsing
the code part of the node.

\begin{figure}
@d JSON methods
@{
@@classmethod
def build_node_definition_part(cls, node_controller, parent, json_input):
    """Builds and returns a node definition part from the given JSON input data.

    :param node_controller: a reference to the node controller
    :type  node_controller: qde.editor.application.node.NodeController
    :param parent: the parent of the node definition part
    :type  parent: qde.editor.domain.node.NodeDefinition
    :param json_input: the input in JSON format
    :type  json_input: dict

    :return: the built part of the node definition
    :rtype:  qde.editor.domain.node.NodeDefinitionPart
    """

    part_id         = uuid.UUID(json_input['id_'])
    name            = str(json_input['name'])

    script_lines = []
    for script_line in json_input['script']:
        script_lines.append(str(script_line))
    script = "\n".join(script_lines)

    type_string = json_input['type_']
    type_ = types.NodeType[type_string.upper()]

    node_definition_part = node.NodeDefinitionPart(part_id)
    node_definition_part.name = name
    node_definition_part.type_ = type_
    node_definition_part.script = script
    node_definition_part.parent = parent

    node_controller.node_definition_parts[part_id] = node_definition_part

    cls.logger.debug(
        "Built part for node definition %s",
        part_id
    )
    return node_definition_part
@}
\caption{A class method of the JSON module, which builds a part of the
  definition of a node from a file handle (pointing to a JSON file containing a
  node definition).
  \newline{}\newline{}Editor $\rightarrow$ JSON $\rightarrow$
  Methods $\rightarrow$ Build node definition part}
\label{editor:lst:json:methods:build-node-definition-part}
\end{figure}

\newthought{Finally the node controller needs to be instantiated} by the main
application and the loading of the node definitions needs to be triggered. The
loading may although not be triggered at the same place as the signals for
reacting upon new node definitions need to be in place first.

\begin{figure}
@d Set up controllers for main application
@{
self.node_controller = node.NodeController()@}
\caption{Instantiation of the node controller from within the main application.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
\label{editor:lst:main-application:constructor:setup-node-controller}
\end{figure}

\newthought{Loading of node definitions} is done right before the main window is
shown, as at that point all necessary connections between signals and slots are
in place.

\begin{figure}
@d Load nodes
@{
self.node_controller.load_nodes()@}
\caption{Loading of nodes is triggered by the main application right after
  instantiating the node controller.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
\label{editor:lst:main-application:constructor:load-nodes}
\end{figure}

\newthought{Now node definitions are being loaded and parsed.} Although there is
no possiblity to select and instantiate the node definitons yet. To allow the
instantiation of nodes, a (user interface) component is necessary: A dialog for
adding nodes to the currently active scene. It will access all the loaded nodes
and provide an interface for selecting a node definition which then will be
instantiated.

\begin{figure}
@d Add node dialog declarations
@{
@@common.with_logger
class AddNodeDialog(QtWidgets.QDialog):
    """Class for adding nodes to a scene view."""

    # Signals
    @<Add node dialog signals@>

    @<Add node dialog column declaration@>

    def __init__(self, parent=None):
        """Constructor.

        :param parent: the parent of this dialog.
        :type  parent: QtGui.QWidget
        """

        super(AddNodeDialog, self).__init__(parent)

        self.columns                = {}
        self.node_definitions       = {}
        self.chosen_node_definition = None

        self.setFixedSize(parent.width(), parent.height())
        self.setWindowTitle("Add node")

        layout = QtWidgets.QHBoxLayout(self)
        layout.setContentsMargins(10, 10, 10, 10)
        layout.setSizeConstraint(Qt.QLayout.SetFixedSize)
        self.setLayout(layout)

    @<Add node dialog methods@>

    # Slots
    @<Add node dialog slots@>
@}
\caption{Definition of a dialog to add nodes to the currently active scene. The
  nodes are ordered in columns according to their type.
  \newline{}\newline{}Editor $\rightarrow$ Add node dialog}
\label{editor:lst:add-node-dialog}
\end{figure}

\newthought{The key idea of the add node dialog} is to have multiple columns
where each column defines a specific node type. The node definitions of each
type are then vertically listed per column. As these columns are tightly tied to
the add node dialog, the declaration of the column class is part of the add node
dialog.

\begin{figure}
@d Add node dialog column declaration
@{
class Column(object):
    """Class representing a column within the add node dialog."""

    def __init__(self):
        """Constructor."""

        self.frame         = None
        self.sub_frames    = []
        self.label         = None
        self.v_box_layout  = None
@}
\caption{Class representing column within the dialog to create new node
  instances.
  \newline{}\newline{}Editor $\rightarrow$ Add node dialog $\rightarrow$ Column}
\label{editor:lst:add-node-dialog:column}
\end{figure}

\todo[inline]{Add position correction to add node dialog.}

\newthought{The dialog for adding a node instance} from a node definition shall
only be shown from within a scene, that is from within the scene view. Therefore
the add node dialog is added to the scene view.

\begin{figure}
@d Scene view constructor
@{
    self.add_node_dialog = node.AddNodeDialog(self.parent())
@}
\caption{The dialog for adding new node instances is initialized by the scene
  view.
  \newline{}\newline{}Editor $\rightarrow$ Scene view $\rightarrow$ Constructor}
\label{editor:lst:scene-view:constructor:add-node-dialog}
\end{figure}

\newthought{Whenever the scene view is focussed} and the tabulator key is being
pressed, the dialog for adding a node shall be shown. For achieving this, the
~\verb=event= method of the scene view needs to be overwritten.

\begin{figure}
@d Scene view methods
@{
def event(self, event):
    if (
            event.type() == Qt.QEvent.KeyPress and
            event.key()  == QtCore.Qt.Key_Tab
    ):
        self.logger.debug("Tabulator was pressed")

        # Sanity check: Open the dialog only if it is not opened already.
        if not self.add_node_dialog.isVisible():
            current_scene = self.scene()
            assert current_scene is not None
            insert_at = current_scene.insert_at
            self.logger.debug("Cursor at %s", insert_at)
            insert_position = QtCore.QPoint(
                insert_at.x() * node_gui_domain.NodeViewModel.WIDTH,
                insert_at.y() * node_gui_domain.NodeViewModel.HEIGHT
            )
            insert_position = self.mapToGlobal(self.mapFromScene(insert_position))
            self.add_node_dialog.move(insert_position)
            add_dialog_result = self.add_node_dialog.exec()

            # At this point we are sure, that this dialog instance was handled
            # properly, so accepting the event might be sane here.
            event.accept()

            if add_dialog_result == QtWidgets.QDialog.Accepted:
                @<Handle node definition chosen@>
                return True
            else:
                return False

    return super(SceneView, self).event(event)
@}
\caption{The event method of the scene view is overwritten for being able to
  show the dialog for adding new instances of nodes when the tabulator key is
  pressed.
  \newline{}\newline{}Editor $\rightarrow$ Scene view $\rightarrow$ Methods}
\label{editor:lst:scene-view:methods:event}
\end{figure}

\newthought{Pressing the tabulator key} when the scene view is active, brings up
the dialog to add a node, but the dialog is empty. This is due to the
circumstance, that the node controller is not informing whenever he receives a
new node definition and that no other component is listening.

\newthought{The node controller has to emit} a signal whenever he reads a
new node definition. The signal itself is emitting a view model of the read node
definition.

\begin{figure}
@d Node controller signals
@{
do_add_node_view_definition = QtCore.pyqtSignal(node_gui_domain.NodeViewModel)@}
\caption{The signal of the node controller that is emitted whenever a node
  definition was read.
  \newline{}\newline{}Editor $\rightarrow$ Node controller $\rightarrow$ Signals}
\label{editor:lst:node-controller:signals:do-add-node-view-definition}
\end{figure}

\newthought{Now other components may listen} and receive view models of newly
added node definitions. In this specific case it is is the dialog for adding a
node which needs to listen to the added signal. The listening is done by the
slot~\verb=on_node_definition_added=.

\begin{figure}
@d Add node dialog slots
@{
@@QtCore.pyqtSlot(node_gui_domain.NodeViewModel)
def on_node_definition_added(self, node_view_model):
    """Slot which is called whenever a new node definition is added.

    :param node_view_model: The newly added node definition.
    :type  node_view_model: qde.editor.gui_domain.node.NodeDefinitionViewModel
    """

    self.logger.debug("Got new node definition: %s", node_view_model)

    node_name = node_view_model.domain_object.name
    type_name = node_view_model.domain_object.type_.name
    @<On node definition added implementation@>@}
\caption{The slot of the dialog to add a new node that is called whenever a new
  node definition is added.
  \newline{}\newline{}Editor $\rightarrow$ Add node dialog $\rightarrow$ Slots}
\label{editor:lst:add-node-dialog:slots:on-node-definition-added}
\end{figure}

\newthought{As the idea of the dialog} is to have one column per node type, the
column needs to be fetched first, based on the type name of the given node
definition. Then a sub frame is created which holds a representation of the node
definition. This representation is rendered like an actual instance of a
node.~\todo{it is not, its just a link atm.} Its behaviour is like a button,
meaning it can be clicked. Clicking on a representation of a node definition
adds an instance of the clicked node definition to the currently active scene at
the cursor position where the dialog for adding a node was opened.

@d On node definition added implementation
@{
@<Check if the node definition is already known@>
@<Get or create column by type name@>
@<Create sub frame for given node definition@>
@<Create button for given node definition and add to sub frame@>
@<Add sub frame to column@>
@<Save the node definition to list of known nodes@>@}

\newthought{A node definition may already be present} although. If this is the
case the process will be stopped.

@d Check if the node definition is already known
@{
if node_view_model.id_ not in self.node_definitions:
@}

\newthought{Getting or creating a column} is about calling the corresponding
method, as the task is abstracted into a method to maintain readability.

@d Get or create column by type name
@{
    column = self.get_or_create_column_by_name(type_name)@}

\newthought{The method to get a column},~\verb=get_or_create_column_by_name=,
tries to get a column by the given name and if no column by that name exists, it
creates a new column using the given name.

@d Add node dialog methods
@{
def get_or_create_column_by_name(self, column_name):
    """Gets the column for the given column name.
    If there is no column for the given column name available, a new column
    using the given column name is created.

    :param column_name: the name of the column to get or create.
    :type  column_name: str

    :return: the column for the given column name.
    :rtype:  AddNodeDialog.Column
    """

    @<Get existing column object by name@>
    @<Create new column object based on name@>

    return column@}

\newthought{Therefore, if a column by the given name already exists}, the
reference to the found column is returned.

@d Get existing column object by name
@{
if column_name in self.columns:
    column = self.columns[column_name]@}

\newthought{If no column by the given name exists}, a new column using the given
name is created.

@d Create new column object based on name
@{
else:
    frame = QtWidgets.QFrame(self)
    self.layout().addWidget(frame)
    frame.setContentsMargins(0, 0, 0, 0)

    row = QtWidgets.QVBoxLayout(frame)
    row.setContentsMargins(0, 0, 0, 0)

    caption = "<h2>{0}</h2>".format(column_name)
    label = QtWidgets.QLabel(caption, frame)
    label.setContentsMargins(4, 2, 4, 2)
    label_font = QtGui.QFont()
    label_font.setFamily(label_font.defaultFamily())
    label_font.setBold(True)
    label_font.setUnderline(True)
    label.setFont(label_font)

    row.addWidget(label)
    row.addStretch(1)

    column = AddNodeDialog.Column()
    column.frame = frame
    column.label = column_name
    column.v_box_layout = row
    self.columns[column_name] = column@}

\newthought{For adding the representation} of the node definition to a column,
the creation of a sub frame is necessary.

@d Create sub frame for given node definition
@{
    sub_frame = QtWidgets.QFrame(column.frame)
    sub_frame_column = QtWidgets.QHBoxLayout(sub_frame)
    sub_frame_column.setContentsMargins(0, 0, 0, 0)
    sub_frame_column.setSpacing(0)@}

\newthought{The node representation is then created} and added to the above
created sub frame. At this moment the presentation is simply a label.

@d Create button for given node definition and add to sub frame
@{
    button_label = gui_helper.ClickableLabel(node_name, sub_frame)
    button_label.setContentsMargins(4, 0, 4, 0)
    button_label.setSizePolicy(
        Qt.QSizePolicy.Expanding, Qt.QSizePolicy.Preferred
    )
    sub_frame_column.addWidget(button_label)@}

\newthought{On thing that stands out} in the above code fragment, is the
clickable label class. This label is nothing other than normal label emitting a
signal called ~\verb=clicked= when receiving a mouse press event. Details may be
found at~\todo{add reference here}.

\newthought{For being able to react} whenever such a label is clicked, it is
necessary to handle the~\verb=clicked= signal of the label. Up to now all
signals emitted the necessary objects. As the~\verb=clicked= signal is very
generic, it does not emit an object. It is nevertheless necessary to emit the
chosen node definition.

@d Create button for given node definition and add to sub frame
@{

    def _add_node_button_clicked(node_view_model):
        self.chosen_node_definition = node_view_model
        self.accept()

    button_label.do_add_node.connect(functools.partial(
        _add_node_button_clicked, node_view_model
    ))@}

\newthought{Finally the created sub frame is added} to the found or created
column.

@d Add sub frame to column
@{
    column.v_box_layout.insertWidget(
        column.v_box_layout.count() - 1, sub_frame
    )
    column.sub_frames.append(sub_frame)@}

\newthought{If the node definition is not yet known}, it is saved to the list of
known node definitions. Otherwise a warning is being shown.

@d Save the node definition to list of known nodes
@{
    self.node_definitions[node_view_model.id_] = node_view_model
    self.logger.debug("Added node definition %s", node_view_model)
    # TODO: Handle shortcuts

else:
    self.logger.warn("Node definition %s is already known", node_view_model)
@}

\newthought{The above defined slot} needs to be triggered as soon as a new node
definition is being added. This is done within the main window, by connecting
the slot with the ~\verb=do_add_node_view_definition= signal.

@d Connect main window components
@{
self.node_controller.do_add_node_view_definition.connect(
    self.main_window.scene_view.add_node_dialog.on_node_definition_added
)@}