%-*- mode: latex; coding: utf-8 -*-

\chapter{Editor}
\label{appendix:chap:editor}

\newthought{Before diving right into the implementation} of the editor, it may
be good to reconsider what shall actually be implemented, therefore what the
main functionality of the editor is and what its components are.

\newthought{The quintessence of the editor} is to output a structure, be it in
the JSON format or even in bytecode, which defines an animation.

\newthought{An animation} is simply a composition of scenes which run in a
sequential order within a time span. A scene is then a composition of nodes,
which are at the end of their evaluation nothing else as shader specific code
which gets executed on the GPU. As this definition is rather abstract, it may be
easier to define what shall be achieved in terms of content and then work
towards this definition.

\newthought{A very basic definition of what shall be achieved} is the following.
It shall be possible to create an animated scene using the editor application.
The scene shall be composed of two objects, a sphere and a cube. Additionally it
shall have a camera as well as a point light.

The camera shall be placed 5 units in height and 10 units in front of the center
of the scene. The cube shall be placed in the middle of the scene, the sphere
shall have an offset of 5 units to the right and 2 units in depth. The point
light shall be placed 10 units above the center.

Both objects shall have different materials: the cube shall have a dull surface
of any color whereas the sphere shall have a glossy surface of any color.

There shall be an animation of ten seconds duration. During this animation the
sphere shall move towards the cube and they shall merge into a blob-like object.
The camera shall move 5 units towards the two objects during this time.

\newthought{To achieve this overall goal}, while providing an user-friendly
experience, several components are needed. These are the following, being
defined in~\citetitle[pp. 29
ff.]{osterwalder-qde-2016}~\cite{osterwalder-qde-2016}

\begin{description}
  \item[A scene graph] allowing the creation and deletion of scenes. The scene
    graph has at least a root scene.
  \item[A node-based graph] structure allowing the composition of scenes using
    nodes and connections between the nodes. There exists at least a root node
    at the root scene of the scene graph.
  \item[A parameter window] showing parameters of the currently selected graph
    node.
  \item[A rendering window] rendering the currently selected node or scene.
  \item[A sequencer] allowing a time-based scheduling of defined scenes.
\end{description}

However, the above list is not complete. It is somehow intuitively clear, that
there needs to be some~\emph{main component}, which holds all the mentioned
components and allows a proper handling of the application (like managing
resources, shutting down properly and so on).

\newthought{The main component} is composed of a view and a controller, as the
whole architecture uses layers and the MVVMC principle, see
section~\enquote{\nameref{soarch}}. A model is (at least at this point) not
necessary. The view component shall be called~\emph{main window} and its
controller shall be called~\emph{main application}.

\newthought{To preserve clarity} all components are described in discrete
chapters. Although the implementation of the components is very specific, in
terms of the programming language, their logic may be reused later on when
developing the player component.

\newthought{Before implementing} any of these components however, the editor
application needs an entry point, that is a point where the application starts
when being called.

\section{Main entry point}
\label{appendix:sec:editor:main}

\newthought{An entry point} is a point where an application starts when being
called. Python does this by evaluating a special variable within a module,
called~\verb=__name__+. Its value is set to~\verb+'__main__'= if the module
is~\enquote{read from standard input, a script, or from an interactive
prompt.}~\footnote{\url{https://docs.python.org/3/library/__main__.html}}

\newthought{All that the entry point needs to do}, in case of the editor
application, is spawning the editor application, execute it and exit again, as
can be seen below.

\begin{figure}[h]
  @d Main entry point
  @{
if __name__ == "__main__":
    app = application.Application(sys.argv)
    status = app.exec()
    sys.exit(status)
  @}
  \caption{Main entry point of the editor application.\newline{}\newline{}Editor
    $\rightarrow$ Main entry point}
  \label{editor:lst:main}
\end{figure}

\newthought{But where to place the main entry point?} A very direct approach
would be to implement that main entry point within the main application
controller. But when running the editor application by calling it from the
command line, calling a controller directly may rather be confusing. Instead it
is more intuitive to have only a minimal entry point which is clearly visible as
such. Therefore the main entry point will be put in a file
called~\verb=editor.py+ which is at the top level of the~\verb+src= directory.

\section{Main application}
\label{appendix:sec:editor:app}

\newthought{The editor application cannot be started yet}, although a main entry
point is defined by now. This is due the fact that there is no such thing as an
editor application yet. Therefore a main application needs to implemented.

\newthought{Qt version 5 is used} through the PyQt5 wrapper, as stated in the
section~\enquote{\nameref{appendix:sec:requirements}}. Therefore all
functionality of Qt 5 may be used. Qt already offers a main application class,
which can be used as a controller. The class is called~\verb=QApplication=.

\newthought{But what does such a main application class actually do?} What is
its functionality? Very roughly sketched, such a type of application initializes
resources, enters a main loop, where it stays until told to shut down, and at
the end it frees the allocated resources again.

Due to the usage of~\verb=QApplication= as super class it is not necessary to
implement a main (event-) loop, as such is provided by Qt
itself~\footnote{http://doc.qt.io/Qt-5/qapplication.html\#exec}.

As the main application initializes resources, it act as central node between the
various layers of the architecture, initializing them and connecting them using
signals.\cite[pp. 37 --- 38]{osterwalder-qde-2016}

\begin{figure}[h]
  @d Main application declarations
  @{
@@common.with_logger
class Application(QtWidgets.QApplication):
    """Main application for QDE."""

    @<Main application constructor@>
    @<Main application methods@>@}
  \caption{Main application class of the editor
    application.\newline{}\newline{}Editor $\rightarrow$ Application}
  \label{editor:lst:app}
\end{figure}

Therefore it needs to do at least three things:
\begin{enumerate*}
  \item initialize itself,
  \item set up components and
  \item connect components.
  \end{enumerate*}
This all happens when the main application is being initialized through its
constructor.

\begin{figure}[h]
@d Main application constructor
@{
def __init__(self, arguments):
    """Constructor.

    :param arguments: a (variable) list of arguments, that are
                      passed when calling this class.
    :type  argv:      list
    """

    @<Set up internals for main application@>
    @<Set up components for main application@>
    @<Add root node for main application@>
    @<Set model for scene graph view@>
    @<Load nodes@>
    self.main_window.show()@}
  \caption{Constructor of the editor application
    class.\newline{}\newline{}Editor $\rightarrow$ Application $\rightarrow$
    Constructor} \label{editor:lst:app:constructor}
\end{figure}

\newthought{Setting up the internals} is straight forward: Passing any given
arguments directly to~\verb=QApplication=, setting an application icon, a name
as well as a display name.

\begin{figure}[h]
@d Set up internals for main application
@{
super(Application, self).__init__(arguments)
self.setWindowIcon(QtGui.QIcon("assets/icons/im.png"))
self.setApplicationName("QDE")
self.setApplicationDisplayName("QDE")@}
\caption{Setting up the internals for the main application class.
  \newline{}\newline{}Editor $\rightarrow$ Application $\rightarrow$
  Constructor} \label{editor:lst:app:constructor:internals}
\end{figure}

The other two steps, setting up the components and connecting them can however
not be done at this point, as there simply are no components available. A
component to start with is the view component of the main application, the main
window.

\section{Main window}
\label{appendix:sec:editor:main-window}

\newthought{Having a very basic implementation} of the main application, its
view component, the main window, can now be implemented and then be set up by
the main application.

\newthought{The main functionality} of the main window is to set up the actual
user interface, containing all the views of the components. Qt offers the class
\verb=QMainWindow= from which~\verb=MainWindow= may inherit.

\begin{figure}
@d Main window declarations
@{
@@common.with_logger
class MainWindow(QtWidgets.QMainWindow):
    """The main window class.
    Acts as main view for the QDE editor application.
    """

    @<Main window signals@>

    @<Main window methods@>
@}
\caption{Main window class of the editor application.
  \newline{}\newline{}Editor $\rightarrow$ Main window}
  \label{editor:lst:main-window}
\end{figure}
% AT<Main window slotsAT>

\newthought{For being able to shut down} the main application and therefore the
main window, they need to react to a request for shutting down, either by a
keyboard shortcut or a menu command. However, the main window is not able to
force the main application to quit by itself. It would be possible to pass the
main window a reference to the application, but that would lead to tight
coupling and is therefore not considered as an option. Signals and slots allow
exactly such cross-layer communication without coupling components tightly.

\newthought{To avoid tight coupling} a signal within the main window is
introduced, which tells the main application to shut down. A fitting name for
the signal might be~\verb=do_close=.

\begin{figure}
@d Main window signals
@{
do_close = QtCore.pyqtSignal()@}
\caption{Definition of the~\texttt{do\_close} signal of the main window class.
  \newline{}\newline{}Editor $\rightarrow$ Main window $\rightarrow$ Signals}
\label{editor:lst:main-window:signals}
\end{figure}

Now, that the signal for closing the window and the application is defined, two
additional things need to be considered: The emission of the signal by
the main window itself as well as the consumption of the signal by a slot of
other classes.

The signal shall be emitted when the escape key on the keyboard is pressed or
when the corresponding menu item was selected. As there is no menu at the
moment, only the key pressed event is implemented by now.

\begin{figure}
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
\caption{Definition of methods for the main window class.
  \newline{}\newline{}Editor $\rightarrow$ Main window $\rightarrow$ Methods}
\label{editor:lst:main-window:methods}
\end{figure}

% For emitting the signal when selecting a menu entry, an action needs to be
% defined which is then attached to the menu entry. The action emits a signal as
% soon as the menu entry was clicked. It is however not possible to trigger the
% defined~\verb=do_close= signal using the actions signal. There a slot needs to
% be defined which then in its turn triggers~\verb=do_close=.

\newthought{The main window can now be set up} by the main application
controller, which also listens to the~\verb=do_close= signal through the
inherited~\verb=quit= slot.

\begin{figure}
@d Set up components for main application
@{
@<Set up controllers for main application@>
@<Connect controllers for main application@>
@<Set up main window for main application@>@}
\caption{Setting up of components for the main application class.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
\label{editor:lst:main-application:constructor:methods}
\end{figure}

\begin{figure}
@d Set up main window for main application
@{
self.main_window = qde_main_window.MainWindow()
self.main_window.move(100, 100)
self.main_window.do_close.connect(self.quit)
@<Connect main window components@>@}
\caption{Set up of the editor main window and its signals from within the main
  application. \newline{}\newline{}Editor $\rightarrow$ Main application
  $\rightarrow$ Constructor}
\label{editor:lst:main-application:constructor:main-window}
\end{figure}

The used view component for the main window,~\verb=QMainWindow=, needs at least
a central widget with a layout for being
rendered.~\footnote{http://doc.qt.io/qt-5/qmainwindow.html\#creating-main-window-components}

\newthought{As the main window will set up and hold} the whole layout for the
application through multiple view components, a method~\verb=setup_ui= is
introduced, which sets up the whole layout. The method creates a central widget
containing a grid layout.

\newthought{Targeting a look} as proposed in~\citetitle[p.
9]{osterwalder-qde-2016}, a simple grid layout does however not provide enough
possibilities. Instead a horizontal box layout in combination with splitters is
used.

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

\begin{figure*}
@d Main window methods
@{
def setup_ui(self):
    """Sets up the user interface specific components."""

    self.setObjectName('MainWindow')
    self.setWindowTitle('QDE')
    self.resize(1024, 768)
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

    self.scene_graph_view = guiscene.SceneGraphView(self)
    self.scene_graph_view.setObjectName('scene_graph_view')
    self.scene_graph_view.setMaximumWidth(300)
    horizontal_layout.addWidget(self.scene_graph_view)

    @<Set up scene view in main window@>
    @<Set up parameter view in main window@>
    @<Set up render view in main window@>

    horizontal_splitter = QtWidgets.QSplitter()
    @<Add render view to horizontal splitter in main window@>
    @<Add parameter view to horizontal splitter in main window@>

    vertical_splitter = QtWidgets.QSplitter()
    vertical_splitter.setOrientation(QtCore.Qt.Vertical)
    vertical_splitter.addWidget(horizontal_splitter)
    @<Add scene view to vertical splitter in main window@>

    horizontal_layout.addWidget(vertical_splitter)
@}
\caption{Set up of the user interface of the editor's  main window.
  \newline{}\newline{}Editor $\rightarrow$ Main window
  $\rightarrow$ Methods}
\label{editor:lst:main-window:methods:setup-ui}
\end{figure*}

All the above taken actions to lay out the main window change nothing in the
window's yet plain appearance. This is quite obvious, as none of the actual
components are implemented yet.

\newthought{A good starting point} for the implementation of the remaining
components might be the scene graph, as it might be the most straight-forward
component to implement.

