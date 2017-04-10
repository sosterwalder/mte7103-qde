% -*- mode: latex; coding: utf-8 -*-

\subsection{Editor}
\label{subsec:editor}

Before diving right into the implementation of the editor, it may be good to
reconsider what shall actually be implemented, therefore what the main
functionality of the editor is and what its components are.

The quintessence of the editor application is to output a structure, be it in
the JSON format or even in bytecode, which defines an animation.

An animation is simply a composition of scenes which run in a sequential order
within a time span. A scene is then a composition of nodes, which are at the end
of their evaluation nothing else as shader specific code which gets executed on
the GPU.

\todo[inline]{Scene: Composition of nodes. Define scene already here.}

To achieve this overall goal while providing the user a user-friendly
experience, several components are needed. These are the following, being
defined in~\citetitle[pp. 29 ff.]{osterwalder_qde_2016}

\begin{itemize}
\item A scene graph, allowing the creation and deletion of scenes. The scene graph
      has at least a root scene.
\item A node-based graph structure, allowing the composition of scenes using nodes
      and connections between the nodes. There exists at least a root node at
      the root scene of the scene graph.
\item A parameter window, showing parameters of the currently selected graph node.
\item A rendering window, rendering the currently selected node or scene.
\item A sequencer, allowing a time-based scheduling of defined scenes.
\end{itemize}

However, the above list is not complete. It is somehow intuitively clear, that
there needs to be some main component, which holds all the mentioned components
and allows a proper handling of the application (like managing resources,
shutting down properly and so on).

As the whole architecture uses layers and the MVC principle
(see~\autoref{ssubsec:layering} and~\autoref{ssubsec:mvc}), the main component is
composed of a view and a controller. A model is (at least at this point) not
necessary. The view component shall be called~\textit{main window} and its
controller shall be called~\textit{main application}.

\todo[inline]{Fix references to subsection (they are displaying section atm)}

\subsubsection{Main entry point}
\label{ssubsec:main-entry-point}

Before implementing any of these components, the editor application needs an
entry point, that is a point where the application starts when being called.

Python does this by evaluating a special variable within a module,
called~\verb+__name__+. Its value is set to \verb+'__main__'+ if the module
is~\enquote{read from standard input, a script, or from an interactive
prompt.}~\footnote{\url{https://docs.python.org/3/library/__main__.html}}

All that the entry point needs to do in case of the editor application, is
spawning the editor application, execute it and exit again, as can be seen below.

@d Main entry point
@{# Python
if __name__ == "__main__":
    app = application.Application(sys.argv)
    status = app.exec()
    sys.exit(status)
@}

But where to place this entry point? A very direct approach would be to
implement that main entry point within the main application controller. But when
running the editor application by calling it from the command line, calling a
controller directly may rather be confusing. Instead it is more intuitive to
have only a minimal entry point which is clearly visible as such. Therefore the
main entry point will be put in a file called \textit{editor.py} which is at the
top level of the \textit{src} directory.

\subsubsection{Main application}
\label{ssubsec:main-application}

Although a main entry point is defined by now, the editor application cannot be
started as there is no such thing as an editor application yet. Therefore a main
application needs to be implemented.

As stated in the requirements, see~\autoref{subsec:requirements}, Qt version 5
is used through the PyQt5 wrapper. Therefore all functionality of Qt 5 may be
used. Qt already offers a main application class, which can be used as a
controller. The class is called~\verb+QApplication+.

But what does such a main application class actually do? What is its
functionality? Very roughly sketched, such a type of application initializes
resources, enters a main loop, where it stays until told to shut down, and at
the end it frees the allocated resources again.

Due to the usage of \verb+QApplication+ as super class it is not necessary to
implement a main (event-) loop, as such is provided by Qt
itself~\footnote{http://doc.qt.io/Qt-5/qapplication.html\#exec}.

As the main application initializes resources, it act as central node between the
various layers of the architecture, initializing them and connecting them using
signals.\cite[pp. 37 --- 38]{osterwalder_qde_2016}

Therefore it needs to do at least three things: initialize itself, set up
components and connect components. This all happens when the main application is
being initialized.

@d Main application declarations
@{
class Application(QtWidgets.QApplication):
    """Main application for QDE."""

    @<Main application methods@>
@}

@d Main application methods
@{
def __init__(self, arguments):
    """Constructor.

    :param arguments: a (variable) list of arguments, that are
                      passed when calling this class.
    :type  argv:      list
    """

    @<Set up internals for main application@>
    @<Set up components for main application@>
    @<Connect components for main application@>

    self.main_window.show()
@}

Setting up the internals is straight forward: Passing any given arguments
directly to~\verb+QApplication+, setting an application icon, a name as well as
a display name.

@d Set up internals for main application
@{
super(Application, self).__init__(arguments)
self.setWindowIcon(QtGui.QIcon("assets/icons/im.png"))
self.setApplicationName("QDE")
self.setApplicationDisplayName("QDE")
@}

The other two steps, setting up the components and connecting them can however
not be done at this point, as there simply are no components available. A
component to start with is the view component of the main application, the main
window.

\subsubsection{Main window}
\label{ssubsec:main-window}

Having a very basic implementation of the main application, its view component,
the main window, can now be implemented and then be set up by the main
application.

The main functionality of the main window is to set up the actual user
interface, containing all the views of the components. Qt offers the class
\verb+QMainWindow+ from which \verb=MainWindow= may inherit.

@d Main window declarations
@{
class MainWindow(QtWidgets.QMainWindow):
    """The main window class.
    Acts as main view for the QDE editor application.
    """

    @<Main window signals@>

    @<Main window methods@>
@}
% @<Main window slots@>

For being able to shut down the main application and therefore the main window,
they need to react to a request for shutting down, either by a keyboard shortcut
or a menu command. However, the main window is not able to force the main
application to quit by itself. It would be possible to pass the main window a
reference to the application, but that would lead to tight coupling and is
therefore not considered as an option. Signals and slots allow exactly such
cross-layer communication without coupling components tightly.

To avoid tight coupling a signal within the main window is introduced, which
tells the main application to shut down. A fitting name for the signal might be
\verb=do_close=.

@d Main window signals
@{
do_close = QtCore.pyqtSignal()
@}

Now, that the signal for closing the window and the application is defined, two
additional things need to be considered: The emission of the signal by
the main window itself as well as the consumption of the signal by a slot of
other classes.

The signal shall be emitted when the escape key on the keyboard is pressed or
when the corresponding menu item was selected. As there is no menu at the
moment, only the key pressed event is implemented by now.

@d Main window methods
@{
def __init__(self, parent=None):
    """Constructor."""

    super(MainWindow, self).__init__(parent)
    self.setup_ui()

def keyPressEvent(self, event):
    """Gets triggered when a key press event is raised.

    :param event: holds the triggered event.
    :type  event: QKeyEvent
    """

    if event.key() == QtCore.Qt.Key_Escape:
        self.do_close.emit()
    else:
        super(MainWindow, self).keyPressEvent(event)
@}

% For emitting the signal when selecting a menu entry, an action needs to be
% defined which is then attached to the menu entry. The action emits a signal as
% soon as the menu entry was clicked. It is however not possible to trigger the
% defined \verb+do_close+ signal using the actions signal. There a slot needs to
% be defined which then in its turn triggers \verb+do_close+.

The main window can now be set up by the main application controller, which also
listens to the \verb=do_close= signal through the inherited \verb=quit= slot.

@d Set up components for main application
@{
self.main_window = qde_main_window.MainWindow()
self.main_window.do_close.connect(self.quit)
@}

The used view component for the main window, \verb+QMainWindow+, needs at least
a central widget with a layout for being
rendered.~\footnote{http://doc.qt.io/qt-5/qmainwindow.html\#creating-main-window-components}

As the main window will set up and hold the whole layout for the application
through multiple view components, a method \verb+setup_ui+ is introduced, which
sets up the whole layout. The method creates a central widget containing a grid
layout.

As the main window holds all other view components and a look as proposed
in~\citetitle[p. 9]{osterwalder_qde_2016} is targeted, a simple grid layout does
not provide enough possibilities. Instead a horizontal box layout in combination
with splitters is used.

Recalling the components, the following layout is approached:

\begin{itemize}
\item{%
    A scene graph, on the left of the window, covering the whole height.}
\item{%
    A node graph on the right of the scene graph, covering as much height as
    possible.}
\item{%
    A view for showing the properties (and therefore parameters) of the selected
    node on the right of the node graph, covering as much height as possible.}
\item{%
    A display for rendering the selected node, on the right of the properties
    view, covering as much height as possible}
\item{%
    A sequencer at the right of the scene graph and below the other components
    at the bottom of the window, covering as much width as possible}
\end{itemize}

\todo[inline]{Provide a picture of the layout here.}

@d Main window methods
@{
def setup_ui(self):
    """Sets up the user interface specific components."""

    self.setObjectName('MainWindow')
    self.setWindowTitle('QDE')
    self.resize(1024, 768)
    self.move(100, 100)
    # Ensure that the window is not hidden behind other windows
    self.activateWindow()

    central_widget = QtWidgets.QWidget(self)
    central_widget.setObjectName('central_widget')
    grid_layout = QtWidgets.QGridLayout(central_widget)
    central_widget.setLayout(grid_layout)
    self.setCentralWidget(central_widget)
    self.statusBar().showMessage('Ready.')

    horizontal_layout_widget = QtWidgets.QWidget(central_widget)
    horizontal_layout_widget.setObjectName('horizontal_layout_widget')
    horizontal_layout_widget.setGeometry(QtCore.QRect(12, 12, 781, 541))
    horizontal_layout_widget.setSizePolicy(QtWidgets.QSizePolicy.MinimumExpanding,
    QtWidgets.QSizePolicy.MinimumExpanding)
    grid_layout.addWidget(horizontal_layout_widget, 0, 0)

    horizontal_layout = QtWidgets.QHBoxLayout(horizontal_layout_widget)
    horizontal_layout.setObjectName('horizontal_layout')
    horizontal_layout.setContentsMargins(0, 0, 0, 0)

    self.scene_graph_widget = guiscene.SceneGraphView()
    self.scene_graph_widget.setObjectName('scene_graph')
    self.scene_graph_widget.setMaximumWidth(300)
    horizontal_layout.addWidget(self.scene_graph_widget)

    @<Set up node graph view in main window@>
    @<Set up parameter view in main window@>
    @<Set up render view in main window@>

     horizontal_splitter = QtWidgets.QSplitter()
    @<Add render view to horizontal splitter in main window@>
    @<Add parameter view to horizontal splitter in main window@>

     vertical_splitter = QtWidgets.QSplitter()
    vertical_splitter.setOrientation(QtCore.Qt.Vertical)
    vertical_splitter.addWidget(horizontal_splitter)
    @<Add node graph to vertical splitter in main window@>

     horizontal_layout.addWidget(vertical_splitter)
@}

All the above taken actions to lay out the main window change nothing in the
window's yet plain appearance. This is quite obvious, as none of the actual
components are implemented yet.

The most straight-forward component to implement may be scene graph, so this is
a good starting point for the implementation of the remaining components.

\subsubsection{Scene graph}
\label{ssubsec:scene-graph}

As mentioned in~\autoref{subsec:editor}, the scene graph has also two aspects to
consider: a graphical aspect as well as its data structure.

\todo[inline]{Define what a scene is by prose and code.}

As described in~\autoref{chap:procedure}, two kinds of models are used. A domain
model, containing the actual data and a view model, which holds a reference to
its corresponding domain model.

% \todo[inline]{Check whether to move into procedure.}
% Both models are managed by the same controller. View models are displayed by views,
% e.g. node view models in the node graph view.
% 
% Therefore the controller of the scene graph will manage instances of scene
% domain models whereas the view of the scene graph will display a tree of scene
% view models.

As the domain model builds the basis for the whole (data-) structure, it is
implemented first.

@d Scene model declarations
@{
class SceneModel(object):
    """The scene model.
    It is used as a base class for scene instances within the whole system.
    """

    @<Scene model signals@>

    @<Scene model methods@>

    @<Scene model slots@>
@}

At this point the only known fact is, that a scene is a composition of nodes,
and therefore it holds its nodes as a list.

@d Scene model methods
@{# Python
def __init__(self):
    """Constructor."""

    self.nodes = []
@}

The counter part of the domain model is the view model. View models are used to
visually represent something within the graphical user interface and they
provide an interface to the \verb+domain+ layer. To this point, a simple
reference in terms of an attribute is used as interface, which may be changed
later on.

Concerning the user interface, a view model must fulfill the requirements posed
by the user interface's corresponding component. In this case, the scene graph
view model inherits from \verb+QObject+ as this base class already provides a
tree structure, which fits the structure of the scene graph perfectly and
therefore fulfills (part of) the requirements posed by the view.

@d Scene view model declarations
@{
class SceneViewModel(QtCore.QObject):
    """View model representing scene graph items.

    The SceneViewModel corresponds to an entry within the scene graph. It
    is used by the QAbstractItemModel class and must therefore at least provide
    a name and a row.
    """

    @<Scene view model signals@>

    @<Scene view model constructor@>

    @<Scene view model methods@>

    @<Scene view model slots@>
@}

In terms of the scene graph, the view model must provide at least a name and a
row. In addition, as written above, it holds a reference to the domain model.

@d Scene view model constructor
@{
def __init__(
        self,
        row,
        domain_object,
        name=QtCore.QCoreApplication.translate('SceneViewModel', 'New scene'),
        parent=None
):
    """Constructor.

    :param row:           The row the view model is in.
    :type  row:           int
    :param domain_object: Reference to a scene model.
    :type  domain_object: qde.editor.domain.scene.SceneModel
    :param name:          The name of the view model, which will be displayed in
                          the scene graph.
    :type  name:          str
    :param parent:        The parent of the current view model within the scene
                          graph.
    :type parent:         qde.editor.gui_domain.scene.SceneViewModel
    """

    super(SceneViewModel, self).__init__(parent)
    self.row  = row
    self.domain_object = domain_object
    self.name = name
@}

Scenes may now be instantiated, it is although necessary to manage scenes in a
controlled manner. Therefore the class \verb+SceneGraphController+ will now be
implemented, for being able to manage scenes.

As the scene graph shall be built as a tree structure, an appropriate data
structure is needed. Qt provides the \verb+QTreeWidget+ class, but that
class is in this case not suitable, as it does not separate the data from its
representation, as stated by Qt:~\enquote{Developers who do not need the flexibility of
the Model/View framework can use this class to create simple hierarchical lists
very easily. A more flexible approach involves combining a QTreeView with a
standard item model. This allows the storage of data to be separated from its
representation.}\footnote{http://doc.qt.io/qt-5/qtreewidget.html\#details}

Such a standard item model is
\verb+QAbstractItemModel+\footnote{\label{footnote:qabstractitemmodel}
http://doc.qt.io/qt-5/qabstractitemmodel.html}, which is used as a base class
for the scene graph controller.

@d Scene graph controller declarations
@{
class SceneGraphController(QtCore.QAbstractItemModel):
    """The scene graph controller.
    A controller for managing the scene graph by adding, editing and removing
    scenes.
    """

    @<Scene graph controller signals@>

    @<Scene graph controller methods@>

    @<Scene graph controller slots@>
@}

As at this point the functionality of the scene graph controller is not fully
known, the constructor simply initializes its parent class.

@d Scene graph controller methods
@{
def __init__(self, parent=None):
    """Constructor.

    :param parent: The parent of the current view model within the scene
                    graph.
    :type parent:  qde.editor.gui_domain.scene.SceneViewModel
    """

    super(SceneGraphController, self).__init__(parent)
@}

As the scene graph controller holds and manages the data, it needs to have at
least a root node. As the controller manages both, domain models and the view
models, it needs to create both models.

@d Scene graph controller methods
@{
    self.root_node = domain_scene.SceneModel()
    self.view_root_node = guidomain_scene.SceneViewModel(
        row=0,
        domain_object=self.root_node,
        name=QtCore.QCoreApplication.translate(__class__.__name__, 'Root scene')
    )
@}

Whenever a scene is added, the item model needs to be informed for
updating the view. This happens by emitting the \verb+rowsInserted+ signal,
which is already given by the \verb+QAbstractItemModel+ class. Therefore the
signal must also be emitted when the root node is added.

@d Scene graph controller methods
@{
    self.rowsInserted.emit(QtCore.QModelIndex(), 0, 1)
@}

% TODO: Add signal to inform scene graph controller about newly created root
%       scene.

The scene graph controller must also provide the header data, which is used to
display the header within the view (due to the usage of the Qt view
model\todo{Add reference to Qts view model}). As header data the name of the
scenes as well as the number of nodes a scene contains shall be displayed.

@d Scene graph controller methods
@{
    self.header_data = [
        QtCore.QCoreApplication.translate(__class__.__name__, 'Name'),
        QtCore.QCoreApplication.translate(__class__.__name__, '# Nodes')
    ]
@}

% TODO: Check if needed
% Before implementing the actual methods, it is important to think about the
% attributes, that the scene graph controller will have, as attributes define and
% influence the methods.

As \verb+QAbstractItemModel+ is used as a basis for the scene graph controller,
some methods must be implemented at very least:~\enquote{When subclassing
QAbstractItemModel, at the very least you must implement index(), parent(),
rowCount(), columnCount(), and data(). These functions are used in all read-only
models, and form the basis of editable
models.}\footref{footnote:qabstractitemmodel}

The method \verb+index+ returns the position of an item in the (data-) model for
a given row and column below a parent item.

@d Scene graph controller methods
@{
def index(self, row, column, parent=QtCore.QModelIndex()):
    """Return the index of the item in the model specified by the given row,
    column and parent index.

    :param row: The row for which the index shall be returned.
    :type  row: int
    :param column: The column for which the index shall be returned.
    :type column: int
    :param parent: The parent index of the item in the model. An invalid model
                   index is given as the default parameter.
    :type parent: QtQore.QModelIndex

    :return: the model index based on the given row, column and the parent
             index.
    :rtype: QtCore.QModelIndex
    """

    # If the given parent (index) is not valid, create a new index based on the
    # currently set root node
    if not parent.isValid():
        return self.createIndex(row, column, self.view_root_node)

    # The internal pointer of the the parent (index) returns a scene graph view
    # model
    parent_node = parent.internalPointer()
    child_nodes = parent_node.children()

    return self.createIndex(row, column, child_nodes[row])
@}

The method \verb+parent+ returns the parent item of an item identified by a
provided index. If that index is invalid, an invalid index is returned as well.

@d Scene graph controller methods
@{
def parent(self, model_index):
    """Return the parent of the model item with the given index. If the item has
    no parent, an invalid QModelIndex is returned.

    :param model_index: The model index which the parent model index shall be
                        derived for.
    :type model_index: int

    :return: the model index of the parent model item for the given model index.
    :rtype: QtCore.QModelIndex
    """

    if not model_index.isValid():
        return QtCore.QModelIndex()

    # The internal pointer of the the model index returns a scene graph view
    # model.
    node = model_index.internalPointer()
    if node.parent() is None:
        return QtCore.QModelIndex()
    else:
        return self.createIndex(node.parent().row, 0, node.parent())
@}

Implementing the \verb+columnCount+ and \verb+rowCount+ methods is straight
forward. The former returns simply the number of columns, in this case the
number of headers, therefore 2.

@d Scene graph controller methods
@{
def columnCount(self, parent):
    """Return the number of columns for the children of the given parent.

    :param parent: The index of the item in the scene graph, which the
                    column count shall be returned for.
    :type  parent: QtCore.QModelIndex

    :return: the number of columns for the children of the given parent.
    :rtype:  int
    """

    return len(self.header_data)
@}

The method \verb+rowCount+ returns the number of children for a given parent
item (identified by its index within the data model).

@d Scene graph controller methods
@{
def rowCount(self, parent):
    """Return the number of rows for the children of the given parent.

    :param parent: The index of the item in the scene graph, which the
                    row count shall be returned for.
    :type  parent: QtCore.QModelIndex

    :return: the number of rows for the children of the given parent.
    :rtype:  int
    """

    if not parent.isValid():
        return 1

    # Get the actual object stored by the parent. In this case it is a
    # SceneViewModel.
    node = parent.internalPointer()

    return len(node.children())
@}

The last method, that has to be implemented due to the usage of
\verb+QAbstractItemModel+, is the \verb+data+ method. It returns the data for an
item identified by the given index for the given role.

A role indicates what type of data is provided. Currently the only role
considered is the display of models (further information may be found
at~\url{http://doc.qt.io/qt-5/qt.html#ItemDataRole-enum}).

Depending on the column of the model index, the method returns either the name
of the scene graph node or the number of nodes a scene contains.

@d Scene graph controller methods
@{
def data(self, model_index, role=QtCore.Qt.DisplayRole):
    """Return the data stored under the given role for the item referred by the
    index.

    :param model_index: The (data-) model index of the item.
    :type model_index: int
    :param role: The role which shall be used for representing the data. The
                 default (and currently only supported) is displaying the data.
    :type role:  QtCore.Qt.DisplayRole

    :return: the data stored under the given role for the item referred by the
             given index.
    :rtype:  str
    """

    if not model_index.isValid():
        return None

    # The internal pointer of the model index returns a scene view model.
    node = model_index.internalPointer()

    if role == QtCore.Qt.DisplayRole:
        # Return either the name of the scene or its number of nodes.
        column = model_index.column()

        if column == 0:
            return node.name
        elif column == 1:
            return node.node_count
@}


In addition to the above mentioned methods, the \verb+QAbstractItemModel+ offers
the method \verb+headerData+, which~\enquote{returns the data for the given role
and section in the header with the specified orientation.}\footnote{http://doc.qt.io/qt-5/qabstractitemmodel.html\#headerData}

@d Scene graph controller methods
@{
def headerData(self, section, orientation=QtCore.Qt.Horizontal,
               role=QtCore.Qt.DisplayRole):
    """Return the data for the given role and section in the header with the
    specified orientation.

    Currently vertical is the only supported orientation. The only supported
    role is DisplayRole. As the sections correspond to the header, there are
    only two supported sections: 0 and 1. If one of those parameters is not
    within the described values, None is returned.

    :param section: the section in the header. Currently only 0 and 1 are
                    supported.
    :type  section: int
    :param orientation: the orientation of the display. Currently only
                        Horizontal is supported.
    :type orientation:  QtCore.Qt.Orientation
    :param role: The role which shall be used for representing the data. The
                 default (and currently only supported) is displaying the data.
    :type role:  QtCore.Qt.DisplayRole

    :return: the header data for the given section using the given role and
             orientation.
    :rtype:  str
    """

    if (
            orientation == QtCore.Qt.Horizontal  and
            role        == QtCore.Qt.DisplayRole and
            section     in [0, 1]
    ):
        return self.header_data[section]
@}

One thing, that may stand out, is, that the above defined \verb+data+ method
returns the number of graph nodes within a scene by accessing the
\verb+node_count+ property of the \textit{scene view model}.

The \textit{scene view model} does therefore need to keep track of the nodes it
contains, in form of a list, analogous to the domain model.

It does not make sense however to use the list of nodes from the domain model,
as the view model will hold references to graphical objects where as the domain
model holds only pure data objects.

Due to the inheritance from \verb+QObject+, it is not necessary to explicitly
implement the nodes of a scene as a list, instead it is already given by the \verb+children+ method.

The method \verb+node_count+ then simply returns the length of the node list.

@d Scene view model methods
@{
@@property
def node_count(self):
    """Return the number of nodes, that this scene contains."""

    return len(self.children())
@}


% The object \verb+node+ is in this case a scene graph view model, which holds a
% reference to scene view model. This may be confusing at first, as they seem very
% similar. But as stated before, view models are used to visually represent
% something within the graphical user interface. Therefore the \textit{scene graph
% view model} stands for an entry within the scene graph where as the
% \textit{scene view model} represents a


The scene graph controller can now be set up by the main application controller.

@d Set up components for main application
@{
self.scene_graph_controller = scene_graph.SceneGraphController(self)
@}

At this point data structures in terms of a (data-) model and a view model
concerning the scene graph are implemented. Further a controller for handling
the flow of the data for both models is implemented. What is still missing, is
the actual representation of the scene graph in terms of a view.

Qt offers a plethora of widgets for implementing views. One such widget is
\verb+QTreeView+, which~\enquote{implements a tree representation of items from
a model. This class is used to provide standard hierarchical lists that were
previously provided by the QListView class, but using the more flexible approach
provided by Qt's model/view
architecture.}~\footnote{fn:f377826acb87691:http://doc.qt.io/qt-5/qtreeview.html\#details}
Therefore \verb+QTreeView+ is used as basis for the scene graph view.

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

As at this point the functionality of the scene graph view is not fully
known, the constructor simply initializes its parent class.

@d Scene graph view constructor
@{
def __init__(self, parent=None):
    """Constructor.

    :param parent:        The parent of the current view widget.
    :type parent:         QtCore.QObject
    """

    super(SceneGraphView, self).__init__(parent)
@}

For being able to display anything, the scene graph view needs a controller to
work with. In terms of Qt, the controller is called a model, as due its
model/view architecture.

@d Connect components for main application
@{
self.main_window.scene_graph_widget.setModel(
    self.scene_graph_controller
)
@}

But scenes shall not only be displayed, instead it shall be possible to work
with them. What shall be achieved, are three things: Adding and removing scenes,
renaming scenes and switching scenes.

To switch between scenes it is necessary to emit what scene was selected. This
is needed to tell the other components, such as the node graph for example, that
the scene has changed.

Through the \verb+selectionChanged+ signal the scene graph view already provides
a possibility to detect if another scene was selected. This signal emits an item
selection in terms of model indices although. As this is very view- and
model-specific, it would be easier for other components if the selected scene is
emitted directly in terms of a view model.

@d Scene graph view slots
@{
@@QtCore.pyqtSlot(QtCore.QItemSelection, QtCore.QItemSelection)
def on_tree_item_selected(self, selected, deselected):
    """Slot which is called when the selection within the scene graph view is
    changed.

    The previous selection (which may be empty) is specified by the deselected
    parameter, the new selection is specified by the selected paramater.

    This method emits the selected scene graph item as scene view model.

    :param selected: The new selection of scenes.
    :type  selected: QtCore.QModelIndex
    :param deselected: The previous selected scenes.
    :type  deselected: QtCore.QModelIndex
    """

    selected_item = selected.first()
    selected_index = selected_item.indexes()[0]
    selected_scene_graph_view_model = selected_index.internalPointer()
    self.tree_item_selected.emit(selected_scene_graph_view_model)
@}

But the \verb+on_tree_item_selected+ slot needs to be triggered as soon as the
selection is changed. This is done by connecting the slot with the signal.

The \verb+selectionChanged+ signal is however not directly accessible, it is
only accessible through the selection model of scene graph view (which is given
by the usage of \verb+QTreeView+). The selection model can although only be
accessed when setting the data model of the view, which needs therefore to be
expanded.

@d Scene graph view methods
@{
def setModel(self, model):
    """Set the model for the view to present.

    This method is only used for being able to use the selection model's
    selectionChanged method and setting the current selection to the root node.

    :param model: The item model which the view shall present.
    :type  model: QtCore.QAbstractItemModel
    """

    super(SceneGraphView, self).setModel(model)

    # Use a slot to emit the selected scene view model upon the selection of a
    # tree item
    selection_model = self.selectionModel()
    selection_model.selectionChanged.connect(
        self.on_tree_item_selected
    )

    # Set the index to the first node of the model
    self.setCurrentIndex(model.index(0, 0))
@}

As stated above, \verb+on_tree_item_selected+ emits another signal containing a
reference to a scene view model.

@d Scene graph view signals
@{
tree_item_selected = QtCore.pyqtSignal(scene.SceneViewModel)
@}

In the same manner as the selection of an item was implemented, the adding and
removal of a scene are implemented. However, the tree widget does not provide
direct signals for those cases as it is the case when selecting a tree item,
instead own signals, slots and actions have to be used.

@d Scene graph view signals
@{
do_add_item = QtCore.pyqtSignal(QtCore.QModelIndex)
do_remove_item = QtCore.pyqtSignal(QtCore.QModelIndex)
@}

An action gets triggered, typically by hovering over some item (in terms of a
context menu for example) or by pressing a defined keyboard shortcut. For the
adding and the removal, a keyboard shortcut will be used.

Adding of a scene item shall happen when pressing the \verb=a= key on the
keyboard.

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

Removal of a selected node shall be triggered upon the press of the
\verb=delete= key on the keyboard.

@d Scene graph view constructor
@{
    remove_action_label = QtCore.QCoreApplication.translate(
        __class__.__name__, 'Remove selected scene(s)'
    )
    remove_action = QtWidgets.QAction(remove_action_label, self)
    remove_action.setShortcut(Qt.QKeySequence('Delete'))
    remove_action.setShortcutContext(QtCore.Qt.WidgetShortcut)
    remove_action.triggered.connect(self.on_tree_item_removed)
    self.addAction(remove_action)
@}

As can be seen in the two above listings, the \verb+triggered+ signals are
connected with a corresponding slot. All these slots do is emitting another
signal, but this time it contains a scene view model, which may be used by
other components, instead of a model index.

@d Scene graph view slots
@{
@@QtCore.pyqtSlot()
def on_new_tree_item(self):
    """Slot which is called when a new tree item was added by the scene graph
    view.

    This method emits the selected scene graph item as new tree item in form of
    a scene view model.
    """

    selected_indexes = self.selectedIndexes()

    # Sanity check: is actually an item selected?
    if len(selected_indexes) > 0:
        selected_item = selected_indexes[0]
        self.do_add_item.emit(selected_item)
        @<Scene graph view log tree item added@>

@@QtCore.pyqtSlot()
def on_tree_item_removed(self):
    """Slot which is called when a one or multiple tree items were removed by
    the scene graph view.

    This method emits the removed scene graph item in form of scene graph view
    models.
    """

    selected_indexes = self.selectedIndexes()

    # Sanity check: is actually an item selected? And has that item a parent?
    # We only allow removal of items with a valid parent, as we do not want to
    # have the root item removed.
    if len(selected_indexes) > 0:
        selected_item = selected_indexes[0]
        if selected_item.parent().isValid():
            self.do_remove_item.emit(selected_item)
            @<Scene graph view log tree item removed@>
        else:
            print('Not removing root scene')
    else:
        print('No item selected')
@}

One of the mentioned other components is the scene graph controller. He needs to
be informed, so that he is able to manage the data model correspondingly.

@d Scene graph controller slots
@{
@@QtCore.pyqtSlot(QtCore.QModelIndex)
def on_tree_item_added(self, selected_item):
    self.insertRows(0, 1, selected_item)

@@QtCore.pyqtSlot(QtCore.QModelIndex)
def on_tree_item_removed(self, selected_item):
    if not selected_item.isValid():
        print('selected scene not valid, not removing')
        return False

    row = selected_item.row()
    parent = selected_item.parent()
    self.removeRows(row, 1, parent)
@}

Having the slots for adding and removing scene graph items implemented, the
actual methods for these actions are still missing.

When inserting a new scene graph item, actually a row must be inserted, as the
data model (Qt's) is using rows to represent the data. At the same time the
controller has to create and keep track of the domain model.

As can be seen in the implementation below, it is not necessary to add the
created view model instance to a list of nodes, the usage of
\verb+QAbstractItemModel+ keeps already track of this.

@d Scene graph controller methods
@{
def insertRows(self, row, count, parent=QtCore.QModelIndex()):
    # TODO: Document method.

    if not parent.isValid():
        return False

    parent_node = parent.internalPointer()
    self.beginInsertRows(parent, row, row + count - 1)
    domain_model  = domain_scene.SceneModel()
    view_model = guidomain_scene.SceneViewModel(
        row=row,
        domain_object=domain_model,
        parent=parent_node
    )
    self.endInsertRows()

    self.layoutChanged.emit()
    self.do_add_scene.emit(domain_model)

    return True
@}

The same logic applies when removing a scene.

@d Scene graph controller methods
@{
def removeRows(self, row, count, parent=QtCore.QModelIndex()):
    # TODO: Document method.

    if not parent.isValid():
        return False

    self.beginRemoveRows(parent, row, row + count - 1)
    node_index = parent.child(row, parent.column())
    node       = node_index.internalPointer()
    node.setParent(None)
    # TODO: Still needed? parent_node.child_nodes.remove(node)
    self.endRemoveRows()
    print('Remove rows')

    self.layoutChanged.emit()
    self.do_remove_scene.emit(domain_model)

    return True
@}

As before, the main application needs connect the components, in this case the
scene graph view with the controller.

@d Connect components for main application
@{
self.main_window.scene_graph_widget.do_add_item.connect(
    self.scene_graph_controller.on_tree_item_added
)
self.main_window.scene_graph_widget.do_remove_item.connect(
    self.scene_graph_controller.on_tree_item_removed
)
@}

To inform other components, such as the node graph for example, the scene graph
controller emits signals when a scene is being added or removed respectively.

@d Scene graph controller signals
@{
do_add_scene    = QtCore.pyqtSignal(domain_scene.SceneModel)
do_remove_scene = QtCore.pyqtSignal(domain_scene.SceneModel)
@}

% TODO: EDIT MODELS
% For being able edit the nodes of the scene graph and to have a custom header
% displayed, further methods have to be implemented: ``To enable editing in your
% model, you must also implement setData(), and reimplement flags() to ensure that
% ItemIsEditable is returned. You can also reimplement headerData() and
% setHeaderData() to control the way the headers for your model are presented.''


At this point it is possible to manage scenes in terms of adding and removing
them. The scenes are added to (or removed from respectively) the graphical user
interface as well as the data structure.

So far the application (or rather the scene graph) seems to be working as
intended. But how does one ensure, that it really does? Without a doubt, unit
and integration tests are one of the best instruments to ensure functionality of
code.

As stated before, in~\autoref{subsec:literate-programming}, it was an intention
of this project to develop the application test driven. Due to required amount
of work for developing test driven, it was abstained from this intention and
regular unit tests are written instead, which can be found in
appendix,~\autoref{sec:test-cases}.

But nevertheless, it would be very handy to have at least some idea what the
code is doing at certain places and at certain times.

One of the simplest approaches to achieve this, is a verbose output at various
places of the application, which may be as simple as using Python's
\verb+print+ function. Using the \verb+print+ function may allow
printing something immediately, but it lacks of flexibility and demands each
time a bit of effort to format the output accordingly (e.g. adding the class and
the function name and so on).

Python's logging facility provides much more functionality while being able to
keep things simple as well --- if needed. The usage of the logging facility to
log messages throughout the application may later even be used to implement a
widget which outputs those messages. So logging using Python's logging facility
will be implemented and applied for being able to have feedback when needed.

\subsubsection{Logging}
\label{ssubsec:logging}

It is always very useful to have a facility which allows tracing of errors or
even just the flow of an application. Logging does allow such aspects by
outputting text messages to a defined output, such as STDERR, STDOUT, streams or
files.

Logging shall be provided on a class-basis, meaning that each class (which wants
to log something) needs to instantiate a logger and use a corresponding handler.

As logging is a very central aspect of the application, it is the task of the
main application to set up the logging facility which may then be used by other
classes through a decorator.

The main application shall therefore set up the logging facility as follows:
\begin{itemize}
  \item Use either an external logging configuration or the default logging
        configuration.
  \item When using an external logging configuration
    \begin{itemize}
      \item The location of the external logging configuration may be set by the
            environment variable \verb+QDE_LOG_CFG+.
      \item Is no such environment variable set, the configuration file is
            assumed to be named \verb+logging.json+ and to reside in the
            application's main directory.
    \end{itemize}
  \item When using no external logging configuration, the default logging
        configuration defined by \verb+basicConfig+ is used.
  \item Always set a level when using no external logging configuration, the
        default being \verb+INFO+.
\end{itemize}

@d Main application methods
@{
def setup_logging(self,
                  default_path='logging.json',
                  default_level=logging.INFO):
    """Setup logging configuration"""

    env_key  = 'QDE_LOG_CFG'
    env_path = os.getenv(env_key, None)
    path     = env_path or default_path

    if os.path.exists(path):
        with open(path, 'rt') as f:
            config = json.load(f)
            logging.config.dictConfig(config)
    else:
        logging.basicConfig(level=default_level)
@}

For not having only basic logging available, a logging configuration is defined.
The logging configuration provides three handlers: a console handler, which logs
debug messages to STDOUT, a info file handler, which logs informational messages
to a file named \verb+info.log+, and a error file handler, which logs errors to
a file named \verb+error.log+. The default level is set to debug and all
handlers are used.

This configuration allows to get an arbitrarily named logger which uses that
configuration.

As stated before, logging shall be provided on a class basis. This has the
consequence, that each class has to instantiate a logging instance. To prevent
the repetition of the same code fragment over and over, Python's decorator
pattern is used~\footnote{https://www.python.org/dev/peps/pep-0318/}.

The decorator will be available as a method named \verb+with_logger+.
The method has the following functionality.

\begin{itemize}
  \item Provide a name based on the current module and class.
    @d Set logger name
    @{logger_name = "{module_name}.{class_name}".format(
    module_name=cls.__module__,
    class_name=cls.__name__
)@}
  \item Provide an easy to use interface for logging.
    @d Logger interface
    @{cls.logger = logging.getLogger(logger_name)

return cls@}
\end{itemize}

The implementation of the \verb+with_logger+ method allows the usage of the
logging facility as a decorator, as shown in the example in the following
listing.

@d With logger example
@{
from qde.editor.foundation import common

@@common.with_logger
def SomeClass(object):
    """This class provides literally nothing and is used only to demonstrate the
    usage of the logging decorator."""

    def some_method():
        """This method does literally nothing and is used only to demonstrate the
        usage of the logging decorator."""

        self.logger.debug(("I am some logging entry used for"
                           "demonstration purposes only."))

@}

The logging facility may now be used wherever it is useful to log something.
Such a place is for example the adding and removal of scenes in the scene graph
view.

@d Scene graph view log tree item added
@{
self.logger.debug("A new scene graph item was added.")
@}

@d Scene graph view log tree item removed
@{
self.logger.debug((
    "The scene graph item at row {row} "
    "and column {column} was removed."
).format(
    row=selected_item.row(),
    column=selected_item.column()
))
@}

Whenever the \textit{a} or the \textit{delete} key is being pressed now, when the scene graph
view is focused, the corresponding log messages appear in the standard output,
hence the console.

Now, having the scene graph component as well as an interface to log messages
throughout the application implemented, the next component may be approached. A
very interesting aspect to face would be the rendering. But for being able to
render something, there actually needs to exist something to render: nodes.
Nodes are being represented within the node graph. So this is a good point to
begin with the implementation of the node graph.

\subsection{Node graph}
\label{subsec:node-graph}

The functionality of the node graph is, as its name states, to represent a data
structure composed of nodes and edges. Each scene from the scene graph is
represented within the node graph as such a data structure.

The nodes are the building blocks of a real time animation. They represent
different aspects, such as scenes themselves, time line clips, models, cameras,
lights, materials, generic operators and effects. These aspects are only examples
(coming from~\citetitle[p. 30 and 31]{osterwalder_qde_2016}) as the node
structure will be expandable for allowing the addition of new nodes.

The implementation of the scene graph component was relatively straightforward
partly due to its structure and partly due to the used data model and
representation. The node graph component however, seems to be a bit more complex.

To get a first overview and to manage its complexity, it might be good to
identify its sub components first before implementing them.
When thinking about the implementation of the node graph, one may identify the
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
    \item[Domain model] Holds the data of a scene, e.g. its nodes.
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

\subsubsection{Nodes}
\label{ssubsec:nodes}

As mentioned before, nodes are the building blocks of a real time animation. But
what are those definitions actually? What do they actually define? There is not
only one answer to this question, it is simply a matter of how the
implementation is being done and therefore a set of decisions.

The whole (rendering) system shall not be bound to only one representation of
nodes, e.g. triangle based meshes. Instead it shall let the user decide, what
representation is the most fitting for the goal he wants to achieve.

Therefore the system shall be able to support multiple kinds of node
representations: Images, triangle based meshes and solid modeling through
function modeling (using signed distance functions for modeling implicit
surfaces). Whereas triangle based meshes may either be loaded from externally
defined files (e.g. in the Filmbox (FBX), the Alembic (ABC) or the Object file
format (OBJ)) or directly be generated using procedural mesh generation.

The nodes are always part of a graph, hence the name node graph, and are
therefore typically connected by edges. This means that the graph gets evaluated
recursively by its nodes, starting with the root node within the root scene.
However, the goal is to have OpenGL shading language (GLSL) code at the end, independent of the node types.

From this point of view it would make sense to let the user define shader
code directly within a node (definition) and to simply evaluate this code, which
adds a lot of (creative) freedom. The problem with this approach is though, that
image and triangle based mesh nodes are not fully implementable by using shader
code only. Instead they have specific requirements, which are only perform-able
on the CPU (e.g. allocating buffer objects).

When thinking of nodes used for solid modeling however, it may appear, that they
may be evaluated directly, without the need for pre-processing, as they are
fully implementable using shader code only. This is kind of misleading however
as each node has its own definition which has to be added to shader and this
definition is then used in a mapping function to compose the scene. This would
mean to add a definition of a node over and over again, when spawning multiple
instances of the same node type, which results in overhead bloating the shader.
It is therefore necessary to pre-process solid modeling nodes too, exactly as
triangle mesh based and image nodes, for being able to use multiple instances of
the same node type within a scene while having the definition added only once.

All of these thoughts sum up in one central question for the implementation:
Shall objects be predefined within the code (and therefore only nodes accepted
whose type and sub type match those of predefined nodes) or shall all objects be
defined externally using files?

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

Considering these aspects, the external definition of nodes is chosen. This may
result in nodes which cannot be evaluated or which have unwanted effects. As it
is (most likely) in the users best interest to create (for his taste) appealing
real time animations, it can be assumed, that the user will try avoiding to
create such nodes or quickly correct faulty nodes or simply does not use such
nodes.

Now, having chosen how to implement nodes, let us define what a node actually
is. As a node may be reference by other nodes, it must be uniquely identifiable
and must therefore have a globally unique identifier. Concerning the visual
representation, a node shall have a name as well as a description.

Each node can have multiple inputs and at least one output. The inputs may be
either be atomic types (which have to be defined) or references to other nodes.
The same applies to the outputs.

A node shall be able to have one or more parts. A part typically contains the
"body" of the node in terms of code and represents therefore the code-wise
implementation of the node. A part can be processed when evaluating the node.

Furthermore a node may contain children, child-nodes, which are actually
references to other nodes combined with properties such as a name, states and so
on.

Each node can have multiple connections. A connection is composed of an input
plus a reference to a part of that input as well as an output and a reference to
a part of that output. The input respectively the output may be zero, what means
that the part of the input or output is internal. Or, a bit more formal:

@d Connections between nodes in EBNF notation
@{
input = internal input | external input
internal input = zero reference, part reference
external input = node reference, part reference
zero reference = "0"
node reference = "uuid4"
part reference = "uuid4"
@}

% Reference to a node X + Reference to /output/ A of node X.
% or
% No reference to another node + Reference to an /input/ of the current node.
%
% Output:
% Reference to a node Y + Reference to /input/ B of node Y.
% or
% No reference to another node + Reference to an /output/ or to /part/ of the
% current node.

Recapitulating the above made thoughts, a node is essentially composed by the
following elements:

\begin{table*}\centering
  \ra{1.3}
  \begin{tabularx}{\textwidth}{@@{}lX@@{}}
    \toprule
    Component & Description \\
    \hline
    ID & A global unique identifier
         (UUID~\footnote{https://docs.python.org/3/library/uuid.html}) \\
    Name & The name of the node, e.g. "Cube". \\
    Description & A description of the node's purpose. \\
    Inputs & A list of the node's inputs. The inputs may either be parameters
             (which are atomic types such as float values or text input) or
             references to other nodes. \\
    Outputs & A list of the node's outputs. The outputs may also either be
              parameters or references to other nodes. \\
    Parts & Defines parts that may be processed when evaluating the node.
            Contains code which can be interpreted directly. \\
    Nodes & The children a node has (child nodes). These entries are
            references to other nodes only. \\
    Connections & A list of connections of the node's inputs and outputs.

                  Each connection is composed by two parts: A reference to another
                  node and a reference to an input or an output of that node. Is
                  the reference not set, that is, its value is zero, this means
                  that the connection is internal. \\
    \bottomrule
  \end{tabularx}
\end{table*}

The inputs and outputs may be parameters of an atomic type, as stated above. This
seems like a good point to define the atomic types the system will have:

\begin{itemize}
  \item{Generic}
  \item{Float}
  \item{Text}
  \item{Scene}
  \item{Image}
  \item{Dynamic}
  \item{Mesh}
\end{itemize}

As these atomic types are the foundation of all other nodes, the system must
ensure, that they are initialized before all other nodes. Before being able to
create the atomic types there must be classes defining them.

For identification of the atomic types, an enumerator is used. Python provides
the \verb+enum+ module, which provides a convenient interface for using
enumerations\footnote{https://docs.python.org/3/library/enum.html}.

@d Node type declarations
@{
class NodeType(enum.Enum):
    """Atomic types which a parameter may be made of."""

    GENERIC = 0
    FLOAT   = 1
    TEXT    = 2
    SCENE   = 3
    IMAGE   = 4
    DYNAMIC = 5
    MESH    = 6
@}

Now, having identifiers for the atomic types available, the atomic types
themselves can be implemented. The atomic types will be used for defining
various properties of a node and are therefore its parameters.

Each node may contain one or more parameters as inputs and one parameter as
output. Each parameter will lead back to its atomic type by referencing the
unique identifier of the atomic type. For being able to distinguish multiple
parameters using the same atomic type, it is necessary that each instance of an
atomic type has its own identifier in form of an instance identifier
(instance ID).

As the word atomic in atomic type indicates, these types are atomic, meaning
there only exists one explicit instance per atomic type.