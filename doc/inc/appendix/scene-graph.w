% -*- mode: latex; coding: utf-8 -*-

\chapter{Scene graph}
\label{appendix:chap:scene-graph}

\newthought{The scene graph component} has two aspects to consider, as mentioned
in chapter~\enquote{\nameref{appendix:chap:editor}}:
\begin{enumerate*}
  \item a graphical aspect as well as
  \item its data structure.
\end{enumerate*}

\todo[inline]{Define what a scene is by prose and code.}

As described in subsection~\enquote{\nameref{results:subsec:software-design}},
two kinds of models are used. A domain model, containing the actual data and a
view model, which holds a reference to its corresponding domain model.

% \todo[inline]{Check whether to move into procedure.}
% Both models are managed by the same controller. View models are displayed by views,
% e.g. node view models in the node graph view.
%
% Therefore the controller of the scene graph will manage instances of scene
% domain models whereas the view of the scene graph will display a tree of scene
% view models.

As the domain model builds the basis for the whole (data-) structure, it is
implemented first.

\begin{figure}
@d Scene model declarations
@{
class SceneModel(object):
    """The scene model.
    It is used as a base class for scene instances within the
    whole system.
    """

    @<Scene model signals@>
    @<Scene model methods@>
    @<Scene model slots@>@}
\caption{Definition of the scene model class, which acts as a base class for
scene instances within the whole application.
  \newline{}\newline{}Editor $\rightarrow$ Scene model}
\label{editor:lst:scene-model}
\end{figure}

\newthought{The only known fact} at this point is, that a scene is a composition
of nodes and therefore holds its nodes as a list. Additionally it holds a
reference to its parent.

\begin{figure}
@d Scene model methods
@{
def __init__(self, parent=None):
    """Constructor.

    :param parent: the parent scene of this scene. The parent is
                   None if the current scene is the root scene.
    :type parent:  SceneModel
    """

    self.id_ = uuid.uuid4()
    self.nodes = []
    self.parent = parent@}
\caption{The constructor of the scene model.
  \newline{}\newline{}Editor $\rightarrow$ Scene model $\rightarrow$ Constructor}
\label{editor:lst:scene-model:constructor}
\end{figure}

\newthought{The counter part of the domain model} is the view model. View models
are used to visually represent something within the graphical user interface and
they provide an interface to the~\verb=domain= layer. To this point, a simple
reference in terms of an attribute is used as interface, which may be changed
later on.

Concerning the user interface, a view model must fulfill the requirements posed
by the user interface's corresponding component. In this case this are actually
two components: the scene graph view as well as the scene view.

It would therefore make sense the use one view model for both components, but
this is not possible as the view model of the scene view,~\verb=QGraphicsScene=,
uses its own data model.

Therefore~\verb=QObject= will be used for the scene graph view model
and~\verb=QGraphicsScene= will be used for the scene view model.

\begin{figure}
@d Scene graph view model declarations
@{
class SceneGraphViewModel(Qt.QObject):
    """View model representing scene graph items.

    The SceneGraphViewModel corresponds to an entry within the
    scene graph. It is used by the QAbstractItemModel class and
    must therefore at least provide a name and a row.
    """

    @<Scene graph view model signals@>
    @<Scene graph view model constructor@>
    @<Scene graph view model methods@>
    @<Scene graph view model slots@>
@}
\caption{Definition of the scene graph view model class, which corresponds to an
  entry within the scene graph.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view model}
\label{editor:lst:scene-graph-view-model}
\end{figure}

In terms of the scene graph, the view model must provide at least a name and a
row. In addition, as written above, it holds a reference to the domain model.

\begin{figure}
@d Scene graph view model constructor
@{
def __init__(
        self,
        row,
        domain_object,
        name=QtCore.QCoreApplication.translate(
            'SceneGraphViewModel', 'New scene'
        ),
        parent=None
):
    """Constructor.

    :param row:           The row the view model is in.
    :type  row:           int
    :param domain_object: Reference to a scene model.
    :type  domain_object: qde.editor.domain.scene.SceneModel
    :param name:          The name of the view model, which will
                          be displayed in the scene graph.
    :type  name:          str
    :param parent:        The parent of the current view model
                          within the scene graph.
    :type parent:         qde.editor.gui_domain.scene.
                          SceneGraphViewModel
    """

    super(SceneGraphViewModel, self).__init__(parent)

    self.id_ = domain_object.id_
    self.row  = row
    self.domain_object = domain_object
    self.name = name
@}
\caption{The constructor of the scene graph view model.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view model $\rightarrow$
  Constructor}
\label{editor:lst:scene-graph-view-model:constructor}
\end{figure}

\newthought{Scenes may now be instantiated,} it is although necessary to manage
scenes in a controlled manner. Therefore the class~\verb=SceneGraphController=
will now be implemented, for being able to manage scenes.

As the scene graph shall be built as a tree structure, an appropriate data
structure is needed. Qt provides the~\verb=QTreeWidget= class, but that
class is in this case not suitable, as it does not separate the data from its
representation, as stated by Qt:~\enquote{Developers who do not need the flexibility of
the Model/View framework can use this class to create simple hierarchical lists
very easily. A more flexible approach involves combining a QTreeView with a
standard item model. This allows the storage of data to be separated from its
representation.}\footnote{http://doc.qt.io/qt-5/qtreewidget.html\#details}

\newthought{Such a standard item model}
is~\verb=QAbstractItemModel=\footnote{\label{footnote:qabstractitemmodel}
http://doc.qt.io/qt-5/qabstractitemmodel.html}, which is used as a base class
for the scene graph controller.

\begin{figure}
@d Scene graph controller declarations
@{
@@common.with_logger
class SceneGraphController(QtCore.QAbstractItemModel):
    """The scene graph controller.
    A controller for managing the scene graph by adding,
    editing and removing scenes.
    """

    @<Scene graph controller signals@>
    @<Scene graph controller constructor@>
    @<Scene graph controller methods@>
    @<Scene graph controller slots@>
@}
\caption{The scene graph controller, inherting from~\texttt{QAbstractItemModel}.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller}
\label{editor:lst:scene-graph-controller}
\end{figure}

\newthought{As at this point the functionality} of the scene graph controller is
not fully known, the constructor simply initializes its parent class and an
empty list of scenes.

\begin{figure}
@d Scene graph controller constructor
@{
def __init__(self, parent=None):
    """Constructor.

    :param parent: The parent of the current view model within
                    the scene graph.
    :type parent:  qde.editor.application.SceneGraphController
    """

    super(SceneGraphController, self).__init__(parent)
@}
\caption{Constructor of the scene graph controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Constructor}
\label{editor:lst:scene-graph-controller:constructor}
\end{figure}

\newthought{The scene graph controller holds and manages scene data.} Therefore
it needs to have at least a root node. As the controller manages both, domain
models and the view models, it needs to create both models.

Due to the dependencies of other components this cannot be done within the
constructor, as components depending on the scene graph controller may not be
listening to its signals at this point. Therefore this is done in a separate
method called~\verb=add_root_node=.

\begin{figure}
@d Scene graph controller add root node
@{
def add_root_node(self):
    """Add a root node to the data structure.
    """

    if self.root_node is None:
        root_node = domain_scene.SceneModel()
        self.view_root_node = guidomain_scene.SceneGraphViewModel(
            row=0,
            domain_object=root_node,
            name=QtCore.QCoreApplication.translate(
                __class__.__name__, 'Root scene'
            )
        )
        self.do_add_scene.emit(root_node)
        self.layoutChanged.emit()
        self.logger.debug("Added root node")
    else:
    self.logger.warn((
        "Not (re-) adding root node, already"
        "present!"
    ))
@}
@d Scene graph controller methods
@{
@<Scene graph controller add root node@>
@}
\caption{A method to add the root node from within the scene graph controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-controller:methods:add-root-node}
\end{figure}

The root scene can now be added by the main application, as all necessary
components are set up.

\begin{figure}
@d Add root node for main application
@{
self.scene_graph_controller.add_root_node()
@}
\caption{The root node of the scene graph being added by the main application.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
\label{editor:lst:main-application:constructor:add-root-node}
\end{figure}

\newthought{The scene graph controller must also provide the header data,} which
is used to display the header within the view (due to the usage of the Qt view
model~\todo{Add reference to Qt's view model}). As header data the name of the
scenes as well as the number of nodes a scene contains shall be displayed.

\begin{figure}
@d Scene graph controller constructor
@{
    self.header_data = [
        QtCore.QCoreApplication.translate(
            __class__.__name__, 'Name'
        ),
        QtCore.QCoreApplication.translate(
            __class__.__name__, '# Nodes'
        )
    ]
    self.root_node = None
    self.view_root_node = None@}
\caption{Initialization of the header data and the root node of the scene graph.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Constructor}
\label{editor:lst:scene-graph-controller:constructor:header-data}
\end{figure}

% TODO: Check if needed
% Before implementing the actual methods, it is important to think about the
% attributes, that the scene graph controller will have, as attributes define and
% influence the methods.

\newthought{As QAbstractItemModel is used as a basis} for the scene graph
controller, some methods must be implemented at very least:~\enquote{When
subclassing QAbstractItemModel, at the very least you must implement index(),
parent(), rowCount(), columnCount(), and data(). These functions are used in all
read-only models, and form the basis of editable
models.}\footref{footnote:qabstractitemmodel}

\newthought{The method index} returns the position of an item in the (data-)
model for a given row and column below a parent item.

\begin{figure}
@d Scene graph controller methods
@{
def index(self, row, column, parent=QtCore.QModelIndex()):
"""Return the index of the item in the model specified by the
    given row, column and parent index.

    :param row: The row for which the index shall be returned.
    :type  row: int
    :param column: The column for which the index shall be
                   returned.
    :type column:  int
    :param parent: The parent index of the item in the model. An
                   invalid model index is given as the default
                   parameter.
    :type parent: QtQore.QModelIndex

    :return: the model index based on the given row, column and
             the parent index.
    :rtype: QtCore.QModelIndex
    """

    if not parent.isValid():
        self.logger.debug((
            "Getting index for row {0}, col {1}, root node"
        ).format(row, column))
        return self.createIndex(row, column, self.view_root_node)

    parent_node = parent.internalPointer()
    self.logger.debug((
        "Getting index for row {0}, col {1}, "
        "parent {2}. Children: {3}"
    ).format(
        row, column, parent_node, len(parent_node.children())
    ))
    child_nodes = parent_node.children()

    # It may happen, that the index is called at the same time as
    # a node is being deleted respectively was deleted. In this
    # case an invalid index is returned.
    try:
        child_node  = child_nodes[row]
        return self.createIndex(row, column, child_node)

    except IndexError:
        return QtCore.QModelIndex()@}
\caption{Implementation of QAbstractItemModel's index method for the scene graph
  controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-controller:methods:index}
\end{figure}

\newthought{The method parent} returns the parent item of an item identified by
a provided index. If that index is invalid, an invalid index is returned as
well.

\begin{figure}
@d Scene graph controller methods
@{
def parent(self, model_index):
    """Return the parent of the model item with the given index.
    If the item has no parent, an invalid QModelIndex is returned.

    :param model_index: The model index which the parent model
                        index shall be derived for.
    :type model_index:  int

    :return: the model index of the parent model item for the
             given model index.
    :rtype:  QtCore.QModelIndex
    """

    # self.logger.debug("Getting parent")

    if not model_index.isValid():
        # self.logger.debug("No valid index for parent")
        return QtCore.QModelIndex()

    # The internal pointer of the the model index returns a
    # scene graph view model.
    node = model_index.internalPointer()
    if node and node.parent() is not None:
        # self.logger.debug("Index for parent")
        return self.createIndex(
            node.parent().row, 0, node.parent()
        )
    else:
        # self.logger.debug("Index for root")
        return QtCore.QModelIndex()
@}
\caption{Implementation of QAbstractItemModel's parent method for the scene graph
  controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-controller:methods:parent}
\end{figure}

\newthought{Implementing the columnCount and rowCount methods} is straight
forward. The former returns simply the number of columns, in this case the
number of headers, therefore 2.

\begin{figure}
@d Scene graph controller methods
@{
def columnCount(self, parent):
    """Return the number of columns for the children of the given
    parent.

    :param parent: The index of the item in the scene graph, which
                   the column count shall be returned for.
    :type  parent: QtCore.QModelIndex

    :return: the number of columns for the children of the given
             parent.
    :rtype:  int
    """

    column_count = len(self.header_data) - 1
    self.logger.debug("Getting column count: %s", column_count)

    return column_count
@}
\caption{Implementation of QAbstractItemModel's columnCount method for the scene
  graph controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-controller:methods:column-count}
\end{figure}

The method~\verb=rowCount= returns the number of nodes for a given parent
item (identified by its index within the data model).

\begin{figure}
@d Scene graph controller methods
@{
def rowCount(self, parent):
    """Return the number of rows for the children of the given
    parent.

    :param parent: The index of the item in the scene graph, which
                   the row count shall be returned for.
    :type  parent: QtCore.QModelIndex

    :return: the number of rows for the children of the given
             parent.
    :rtype:  int
    """

    if not parent.isValid():
        self.logger.debug("Parent is not valid")
        row_count = 1
    else:
        # Get the actual object stored by the parent. In this case
        # it is a SceneGraphViewModel.
        node = parent.internalPointer()

        if node is None:
            self.logger.debug("Parent (node) is not valid")
            row_count = 1
        else:
            row_count = len(node.children())

    self.logger.debug("Getting row count: %s", row_count)
    return row_count
@}
\caption{Implementation of QAbstractItemModel's rowCount method for the scene
  graph controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-controller:methods:row-count}
\end{figure}

\newthought{The last method} that has to be implemented due to the usage of
~\verb=QAbstractItemModel=, is the~\verb=data= method. It returns the data for
an item identified by the given index for the given role.

A role indicates what type of data is provided. Currently the only role
considered is the display of models (further information may be found
at~\url{http://doc.qt.io/qt-5/qt.html#ItemDataRole-enum}).

Depending on the column of the model index, the method returns either the name
of the scene graph node or the number of nodes a scene contains.

\begin{figure}
@d Scene graph controller methods
@{
def data(self, model_index, role=QtCore.Qt.DisplayRole):
    """Return the data stored under the given role for the item
    referred by the index.

    :param model_index: The (data-) model index of the item.
    :type model_index: int
    :param role: The role which shall be used for representing
                 the data. The default (and currently only
                 supported) is displaying the data.
    :type role:  QtCore.Qt.DisplayRole

    :return: the data stored under the given role for the item
             referred by the given index.
    :rtype:  str
    """

    if not model_index.isValid():
        self.logger.debug("Model index is not valid")
        return None

    # The internal pointer of the model index returns a scene
    # graph view model.
    node = model_index.internalPointer()

    if node is None:
        self.logger.debug("Node is not valid")
        return None

    if role == QtCore.Qt.DisplayRole:
        # Return either the name of the scene or its number of
        # nodes.
        column = model_index.column()

        if column == 0:
            return node.name
        elif column == 1:
            return node.node_count
@}
\caption{Implementation of QAbstractItemModel's data method for the scene
  graph controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-controller:methods:data}
\end{figure}

\newthought{In addition to the above mentioned methods,}
the~\verb=QAbstractItemModel= offers the method~\verb=headerData=,
which~\enquote{returns the data for the given role and section in the header
with the specified
orientation.}\footnote{http://doc.qt.io/qt-5/qabstractitemmodel.html\#headerData}

\begin{figure}
@d Scene graph controller methods
@{
def headerData(self, section, orientation=QtCore.Qt.Horizontal,
               role=QtCore.Qt.DisplayRole):
    """Return the data for the given role and section in the
    header with the specified orientation.

    Currently vertical is the only supported orientation. The
    only supported role is DisplayRole. As the sections correspond
    to the header, there are only two supported sections: 0 and 1.
    If one of those parameters is not within the described values,
    None is returned.

    :param section: the section in the header. Currently only 0
                    and 1 are supported.
    :type  section: int
    :param orientation: the orientation of the display. Currently
                        only Horizontal is supported.
    :type orientation:  QtCore.Qt.Orientation
    :param role: The role which shall be used for representing
                 the data. The default (and currently only
                supported) is displaying the data.
    :type role:  QtCore.Qt.DisplayRole

    :return: the header data for the given section using the
             given role and orientation.
    :rtype:  str
    """

    if (
            orientation == QtCore.Qt.Horizontal  and
            role        == QtCore.Qt.DisplayRole and
            section     in [0, 1]
    ):
        return self.header_data[section]
@}
\caption{Implementation of QAbstractItemModel's headerData method for the scene
  graph controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-controller:methods:header-data}
\end{figure}

One thing, that may stand out, is, that the above defined~\verb=data= method
returns the number of graph nodes within a scene by accessing the
~\verb=node_count= property of the~\emph{scene graph view model}.

The~\emph{scene graph view model} does therefore need to keep track of the nodes it
contains, in form of a list, analogous to the domain model.

It does not make sense however to use the list of nodes from the domain model,
as the view model will hold references to graphical objects where as the domain
model holds only pure data objects. Therefore it is necessary, that the scene
view model keeps track of its nodes separately.

\begin{figure}
@d Scene graph view model constructor
@{
    self.nodes = []
@}
\caption{Scene graph view models hold references to the nodes they contain.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view model $\rightarrow$
  Constructor}
\label{editor:lst:scene-graph-view-model:constructor:nodes}
\end{figure}

\newthought{The method node\_count} then simply returns the length of the node
list.

\begin{figure}
@d Scene graph view model methods
@{
@@property
def node_count(self):
    """Return the number of nodes that this scene contains."""

    return len(self.nodes)
@}
\caption{The number of (graphical) nodes which a scene graph view model contains
  implemented as a property.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view model $\rightarrow$
  Methods}
\label{editor:lst:scene-graph-view-model:methods:node-count}
\end{figure}

% The object~\verb=node= is in this case a scene graph view model, which holds a
% reference to scene graph view model. This may be confusing at first, as they seem very
% similar. But as stated before, view models are used to visually represent
% something within the graphical user interface. Therefore the \textit{scene graph
% view model} stands for an entry within the scene graph where as the
% \textit{scene graph view model} represents a

The scene graph controller can now be set up by the main application controller.

\begin{figure}
@d Set up controllers for main application
@{
self.scene_graph_controller = scene.SceneGraphController(self)@}
\caption{The scene graph controller gets initialized within the main application.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
\label{editor:lst:main-application:constructor:scene-graph-controller}
\end{figure}

At this point data structures in terms of a (data-) model and a view model
concerning the scene graph are implemented. Further a controller for handling
the flow of the data for both models is implemented.

\newthought{What is still missing,} is the actual representation of the scene
graph in terms of a view. Qt offers a plethora of widgets for implementing
views. One such widget is ~\verb=QTreeView=, which~\enquote{implements a tree
representation of items from a model. This class is used to provide standard
hierarchical lists that were previously provided by the QListView class, but
using the more flexible approach provided by Qt's model/view
architecture.}~\footnote{fn:f377826acb87691:http://doc.qt.io/qt-5/qtreeview.html\#details}
Therefore~\verb=QTreeView= is used as basis for the scene graph view.

\begin{figure}
@d Scene graph view declarations
@{
@<Scene graph view decorators@>
class SceneGraphView(QtWidgets.QTreeView):
    """The scene graph view widget.
    A widget for displaying and managing the scene graph.
    """

    @<Scene graph view signals@>
    @<Scene graph view constructor@>
    @<Scene graph view methods@>
    @<Scene graph view slots@>
@}
\caption{Scene graph view, based on Qt's QTreeView.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view}
\label{editor:lst:scene-graph-view}
\end{figure}

\newthought{The constructor} simply initializes its parent class, as at this
point the functionality of the scene graph view is not fully known.

\begin{figure}
@d Scene graph view constructor
@{
def __init__(self, parent=None):
    """Constructor.

    :param parent: The parent of the current view widget.
    :type parent:  QtCore.QObject
    """

    super(SceneGraphView, self).__init__(parent)@}
\caption{Constructor of the scene graph view.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Constructor}
\label{editor:lst:scene-graph-view:constructor}
\end{figure}

\newthought{For being able to display something,} the scene graph view needs a
controller to work with. In terms of Qt, the controller is called a model, as
due its model/view architecture. This model may although not be set too early,
as otherwise problems arise. It may only then be added, when the depending
components are properly initialized, e.g. when the root node has been added.

\begin{figure}
@d Set model for scene graph view
@{
self.main_window.scene_graph_view.setModel(
    self.scene_graph_controller
)
@}
\caption{The scene graph controller is being set as the scene graph view's
  model.
  \newline{}\newline{}Editor $\rightarrow$ Main application
  $\rightarrow$ Constructor}
\label{editor:lst:main-application:constructor:set-model}
\end{figure}

\newthought{But scenes shall not only be displayed,} instead it shall be
possible to work with them. What shall be achieved, are three things:
\begin{enumerate*}
  \item Adding and removing scenes,
  \item renaming scenes and
  \item switching between scenes.
\end{enumerate*}

\newthought{To switch between scenes} it is necessary to emit what scene was
selected. This is needed to tell the other components, such as the node graph
for example, that the scene has changed.

Through the~\verb=selectionChanged= signal the scene graph view already provides
a possibility to detect if another scene was selected. This signal emits an item
selection in terms of model indices although.

As this is very view- and model-specific, it would be easier for other
components if the selected scene is emitted directly. To emit the selected index
of the currently selected scene directly, the slot~\verb=on_tree_item_selected=
is introduced.

\begin{figure}
@d Scene graph view slots
@{
@@QtCore.pyqtSlot(QtCore.QItemSelection, QtCore.QItemSelection)
def on_tree_item_selected(self, selected, deselected):
    """Slot which is called when the selection within the scene
    graph view is changed.

    The previous selection (which may be empty) is specified by
    the deselected parameter, the new selection by the selected
    paramater.

    This method emits the selected scene graph item as scene
    graph view model.

    :param selected: The new selection of scenes.
    :type  selected: QtCore.QModelIndex
    :param deselected: The previous selected scenes.
    :type  deselected: QtCore.QModelIndex
    """

    selected_item = selected.first()
    selected_index = selected_item.indexes()[0]
    self.do_select_item.emit(selected_index)
    self.logger.debug(
        "Tree item was selected: %s" % selected_index
    )@}
\caption{Slot which is called when the selection within the scene graph view is
  changed.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Slots}
\label{editor:lst:scene-graph-view:slots:on-tree-item-selected}
\end{figure}

The~\verb=on_tree_item_selected= slot needs to be triggered as soon as the
selection is changed. This is done by connecting the slot with the
\verb=selectionChanged= signal. The~\verb=selectionChanged= signal is however
not directly accessible, it is only accessible through the selection model of
the scene graph view (which is given by the usage of~\verb=QTreeView=). The
selection model can although only be accessed when setting the data model of the
view, which needs therefore to be expanded.

\begin{figure}
@d Scene graph view methods
@{
def setModel(self, model):
    """Set the model for the view to present.

    This method is only used for being able to use the selection
    model's selectionChanged method and setting the current
    selection to the root node.

    :param model: The item model which the view shall present.
    :type  model: QtCore.QAbstractItemModel
    """

    super(SceneGraphView, self).setModel(model)

    # Use a slot to emit the selected scene graph view model upon
    # the selection of a tree item
    selection_model = self.selectionModel()
    selection_model.selectionChanged.connect(
        self.on_tree_item_selected
    )

    # Set the index to the first node of the model
    self.setCurrentIndex(model.index(0, 0))
    self.logger.debug("Root node selected")@}
\caption{The setModel method, provided by QTreeView's interface, which is begin
  overwritten for being able to trigger the on\_tree\_item\_selected slot
  whenever the selection in the scene graph view has changed.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Methods}
\label{editor:lst:scene-graph-view:methods:set-model}
\end{figure}

As stated in the above code fragment,~\verb=on_tree_item_selected= emits another
signal containing a reference to the currently selected scene, which needs to be
implemented as well.

\begin{figure}
@d Scene graph view signals
@{
do_select_item = QtCore.pyqtSignal(QtCore.QModelIndex)
@}
\caption{The signal that is being emitted when a scene within the scene graph
view was selected. Note that the signal includes the model index of the selected
item.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Signals}
\label{editor:lst:scene-graph-view:signals:do-select-item}
\end{figure}

\newthought{Adding and removing of a scene} are implemented in a similar manner
as the selection of an item was implemented. However, the tree widget does not
provide direct signals for those cases as it is the case when selecting a tree
item, instead own signals, slots and actions have to be used.

\begin{figure}
@d Scene graph view signals
@{
do_add_item = QtCore.pyqtSignal(QtCore.QModelIndex)
do_remove_item = QtCore.pyqtSignal(QtCore.QModelIndex)
@}
\caption{Signals that get emitted whenever a scene is added or removed.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Signals}
\label{editor:lst:scene-graph-view:signals:do-add-remove-item}
\end{figure}

An action gets triggered, typically by hovering over some item (in terms of a
context menu for example) or by pressing a defined keyboard shortcut. For the
adding and the removal, a keyboard shortcut will be used.

\newthought{Adding of a scene item} shall happen when pressing the~\verb=a= key
on the keyboard.

\begin{figure}
@d Scene graph view constructor
@{
    new_action_label = QtCore.QCoreApplication.translate(
        __class__.__name__, 'New scene'
    )
    new_action = QtWidgets.QAction(new_action_label, self)
    new_action.setShortcut(Qt.QKeySequence('a'))
    new_action.setShortcutContext(QtCore.Qt.WidgetShortcut)
    new_action.triggered.connect(self.on_new_tree_item)
    self.addAction(new_action)
@}
\caption{Introduction of an action for adding a new scene, which reacts upon
  the~\enquote{A} key being pressed on the keyboard.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Constructor}
\label{editor:lst:scene-graph-view:constructor:new-action}
\end{figure}

\newthought{The removal of a selected node} shall be triggered upon the press of
the ~\verb=delete+ and the~\verb+backspace= key on the keyboard.

\begin{figure}
@d Scene graph view constructor
@{
    remove_action_label = QtCore.QCoreApplication.translate(
        __class__.__name__, 'Remove selected scene(s)'
    )
    remove_action = QtWidgets.QAction(remove_action_label, self)
    remove_action.setShortcut(Qt.QKeySequence('Delete'))
    remove_action.setShortcut(Qt.QKeySequence('Backspace'))
    remove_action.setShortcutContext(QtCore.Qt.WidgetShortcut)
    remove_action.triggered.connect(self.on_tree_item_removed)
    self.addAction(remove_action)
@}
\caption{Introduction of an action for removing a new scene, which reacts upon
  the~\enquote{delete} key being pressed on the keyboard.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Constructor}
\label{editor:lst:scene-graph-view:constructor:remove-action}
\end{figure}

As can be seen in the two above listings, the~\verb=triggered= signals are
connected with a corresponding slot. All these slots do is emitting another
signal, but this time it contains a scene graph view model, which may be used by
other components, instead of a model index.

\begin{figure}
@d Scene graph view slots
@{
@@QtCore.pyqtSlot()
def on_new_tree_item(self):
    """Slot which is called when a new tree item was added by the
    scene graph view.

    This method emits the selected scene graph item as new tree
    item in form of a scene graph view model.
    """

    selected_indexes = self.selectedIndexes()

    # Sanity check: is actually an item selected?
    if len(selected_indexes) > 0:
        selected_item = selected_indexes[0]
        self.do_add_item.emit(selected_item)
        @<Scene graph view log tree item added@>

@@QtCore.pyqtSlot()
def on_tree_item_removed(self):
    """Slot which is called when a one or multiple tree items
    were removed by the scene graph view.

    This method emits the removed scene graph item in form of
    scene graph view models.
    """

    selected_indexes = self.selectedIndexes()

    # Sanity check: is actually an item selected? And has that
    # item a parent?
    # We only allow removal of items with a valid parent, as we
    # do not want to have the root item removed.
    if len(selected_indexes) > 0:
        selected_item = selected_indexes[0]
        if selected_item.parent().isValid():
            self.do_remove_item.emit(selected_item)
            @<Scene graph view log tree item removed@>
        else:
            self.logger.warn("Root scene cannot be deleted")
    else:
        self.logger.warn('No item selected for removal')
@}
\caption{Slots which emit themselves a signal whenever a scene is added from the
  scene graph or removed respectively.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Slots}
\label{editor:lst:scene-graph-view:slots:on-tree-item-added-removed}
\end{figure}

\newthought{One of the mentioned other components}~\todo{which exactly?} is the
scene graph controller. He needs to be informed whenever a scene was added,
removed or selected, so that he is able to manage his data model
correspondingly.

\begin{figure}
@d Scene graph controller slots
@{
@@QtCore.pyqtSlot(QtCore.QModelIndex)
def on_tree_item_added(self, selected_item):
    # TODO: Document method.

    self.insertRows(0, 1, selected_item)
    self.logger.debug("Added new scene")

@@QtCore.pyqtSlot(QtCore.QModelIndex)
def on_tree_item_removed(self, selected_item):
    # TODO: Document method.

    if not selected_item.isValid():
        self.logger.warn(
            "Selected scene is not valid, not removing"
        )
        return False

    row = selected_item.row()
    parent = selected_item.parent()
    self.removeRows(row, 1, parent)

@@QtCore.pyqtSlot(QtCore.QModelIndex)
def on_tree_item_selected(self, selected_item):
    # TODO: Document method.

    if not selected_item.isValid():
        self.logger.warn("Selected scene is not valid")
        return False

    selected_scene_view_model = selected_item.internalPointer()
    selected_scene_domain_model  = selected_scene_view_model.domain_object
    self.do_select_scene.emit(selected_scene_domain_model)@}
\caption{Slots to handle adding, removing and selecting of tree items within the
  scene graph. The slots take a model index as argument (coming from
  QAbstractItemModel). This is analogous to the scene graph view.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller
  $\rightarrow$ Slots}
\label{editor:lst:scene-graph-controller:slots:on-tree-item-added-removed-selected}
\end{figure}

\newthought{Despite having the slots for adding, removing and selecting} scene
graph items implemented, the actual methods for adding and removing scenes,
~\verb=on_tree_item_added+ and~\verb+on_tree_item_removed=, are still missing.

When inserting a new scene graph item, actually a row must be inserted, as the
data model (Qt's) is using rows to represent the data. At the same time the
controller has to keep track of the domain model.

As can be seen in the implementation below, it is not necessary to add the
created model instances to a list of nodes, the usage of
~\verb=QAbstractItemModel= keeps already track of this.

\begin{figure}
@d Scene graph controller methods
@{
def insertRows(self, row, count, parent=QtCore.QModelIndex()):
    # TODO: Document method.

    if not parent.isValid():
        return False

    parent_node = parent.internalPointer()
    self.beginInsertRows(parent, row, row + count - 1)
    domain_model  = domain_scene.SceneModel(parent_node.domain_object)
    view_model = guidomain_scene.SceneGraphViewModel(
        row=row,
        domain_object=domain_model,
        parent=parent_node
    )
    self.endInsertRows()

    self.layoutChanged.emit()
    self.do_add_scene.emit(domain_model)

    return True
@}
\caption{Method for adding new scenes in terms of a domain model as well as a
  scene graph view model.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller
  $\rightarrow$ Methods}
\label{editor:lst:scene-graph-controller:methods:insert-rows}
\end{figure}

The same logic applies when removing a scene.

\begin{figure}
@d Scene graph controller methods
@{
def removeRows(self, row, count, parent=QtCore.QModelIndex()):
    # TODO: Document method.

    if not parent.isValid():
        self.logger.warn("Cannot remove rows, parent is invalid")
        return False

    self.beginRemoveRows(parent, row, row + count - 1)
    parent_node = parent.internalPointer()
    node_index = parent.child(row, parent.column())
    node       = node_index.internalPointer()
    node.setParent(None)
    # TODO: parent_node.child_nodes.remove(node)
    self.endRemoveRows()
    self.logger.debug(
        "Removed {0} rows starting from {1} for parent {2}. Children: {3}".format(
            count, row, parent_node, len(parent_node.children())
        )
    )

    self.layoutChanged.emit()
    self.do_remove_scene.emit(node.domain_object)

    return True
@}
\caption{Method for removing scenes. Note that this is mainly done by getting
  the object related to the given model index and setting the parent of that
  object to a nil object.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller
  $\rightarrow$ Methods}
\label{editor:lst:scene-graph-controller:methods:remove-rows}
\end{figure}

\newthought{As before, the main application needs connect the components,} in
this case the scene graph view with the scene graph controller.

\begin{figure}
@d Connect main window components
@{
self.main_window.scene_graph_view.do_add_item.connect(
    self.scene_graph_controller.on_tree_item_added
)
self.main_window.scene_graph_view.do_remove_item.connect(
    self.scene_graph_controller.on_tree_item_removed
)
self.main_window.scene_graph_view.do_select_item.connect(
    self.scene_graph_controller.on_tree_item_selected
)@}
\caption{The scene graph view's signals for adding, removing and selecting a
  scene are connected to the corresponding slots from the scene graph
  controller. Or, in other words, the controller/data reacts to actions invoked
  by the user interface.
  \newline{}\newline{}Editor $\rightarrow$ Main application
  $\rightarrow$ Constructor}
\label{editor:lst:main-application:constructor:connect-scene-graph-view}
\end{figure}

\newthought{To inform other components about the new models}, such as the node
graph for example, the scene graph controller emits signals when a scene is
being added, removed or selected respectively.

\begin{figure}
@d Scene graph controller signals
@{
do_add_scene    = QtCore.pyqtSignal(domain_scene.SceneModel)
do_remove_scene = QtCore.pyqtSignal(domain_scene.SceneModel)
do_select_scene = QtCore.pyqtSignal(domain_scene.SceneModel)
@}
\caption{Signals emitted by the scene graph controller, in terms of domain
  models, whenever a scene is added, removed or selected.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph controller
  $\rightarrow$ Signals}
\label{editor:lst:scene-graph-controller:signals}
\end{figure}

% TODO: EDIT MODELS
% For being able edit the nodes of the scene graph and to have a custom header
% displayed, further methods have to be implemented: ``To enable editing in your
% model, you must also implement setData(), and reimplement flags() to ensure that
% ItemIsEditable is returned. You can also reimplement headerData() and
% setHeaderData() to control the way the headers for your model are presented.''

\newthought{At this point it is possible to manage scenes} in terms of adding
and removing them. The scenes are added to (or removed from respectively) the
graphical user interface as well as the data structure.

So far the application (or rather the scene graph) seems to be working as
intended. But how does one ensure, that it really does? Without a doubt, unit
and integration tests are one of the best instruments to ensure functionality of
code.

\todo[inline]{Check if the paragraph is still correct.}
As stated before, in~\autoref{subsec:literate-programming}, it was an intention
of this project to develop the application test driven. Due to the required amount
of work when developing test driven, it was abstained from this intention and
regular unit tests are written instead, which can be found in
appendix,~\autoref{sec:test-cases}.

But nevertheless, it would be very handy to have at least some idea what the
code is doing at certain places and at certain times.

One of the simplest approaches to achieve this, is a verbose output at various
places of the application, which may be as simple as using Python's
~\verb=print= function. Using the~\verb=print= function may allow
printing something immediately, but it lacks of flexibility and demands each
time a bit of effort to format the output accordingly (e.g. adding the class and
the function name and so on).

Python's logging facility provides much more functionality while being able to
keep things simple as well --- if needed. The usage of the logging facility to
log messages throughout the application may later even be used to implement a
widget which outputs those messages. So logging using Python's logging facility
will be implemented and applied for being able to have feedback when needed.