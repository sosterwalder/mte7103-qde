% -*- mode: latex; coding: utf-8 -*-

\subsection{Editor}
\label{subsec:editor}

Before diving right into the implementation of the editor, it may be good to
reconsider what shall actually be implemented, therefore what the main
functionality of the editor is and what its components are.

The quintessence of the editor application is to output a structure, be it in
the JSON format or even in bytecode, which defines an animation.

An animation is simply a composition of scenes which run in a sequential order
within a time span. A scene is at the end of its evaluation nothing else as
shader specific code which gets executed on the GPU.

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

However, the above list is not quite complete. It is somehow intuitively clear,
that there needs to be some main component, which holds all the mentioned
components and allows a proper handling of the application. As the whole
architecture uses layers and the MVC principle (see~\autoref{subsec:code}
and~\autoref{ssubsec:mvc}), the main component is composed of a view and a
controller. A model is (at least at this point) not necessary. The view
component shall be called~\textit{main window} and its controller shall be
called~\textit{main application}.

Before implementing any of these components, the editor application needs an
entry point, that is a point where the application starts when being called.

Python does this by evaluating a special variable called~\verb+__name__+. This
value is set to \verb+'__main__'+ if the module is~\enquote{read from standard
input, a script, or from an interactive
prompt.}~\footnote{\url{https://docs.python.org/3/library/__main__.html}}

All that the entry point needs to do in case of the editor application, is
spawning the editor application, execute it and exit again, as can be seen below.

@d Main entry point
@{
if __name__ == "__main__":
  app = application.Application(sys.argv)
  status = app.exec()
  sys.exit(status)
@}

But where to place this entry point? A very direct approach would be to
implement that main entry point within the main application controller. But when
running the editor application by calling it from the command line, calling a
controller directly may rather be confusing. Instead it is more intuitive to
have only a minimal entry point which is clearly visible as such.

Although a main entry point is defined by now, the editor application cannot be
started as there is no such thing as an editor application yet.


As stated in the requirements, see~\autoref{subsec:requirements}, Qt version 5
is used through the PyQt5 wrapper. Therefore all functionality of Qt 5 may be
used. Qt already offers a main application class, which can be used as a
controller. The class is called~\verb+QApplication+.

But what does such a main application class actually do? What is its
functionality? Very roughly sketched, such a type of application initializes
resources, enters a main loop where it stays until told to shut down. At the end
it frees resources again.

As the main application initializes resources, it act as central node between the
various layers of the architecture, initializing them and connecting them using
signals.\cite[pp. 37 --- 38]{osterwalder_qde_2016}

Due to the usage of \verb+QApplication+ as super class it is not necessary to
implement a main (event-) loop, as such is provided by Qt
itself~\footnote{http://doc.qt.io/Qt-5/qapplication.html\#exec}.

As stated above, the main application acts as entry point and as a central node
between the various layers. Therefore it needs to do at least three things:
initialize itself, set up components and connect components. This all happens
when the main application is being initialized.

@d Main application declarations
@{
class Application(QtWidgets.QApplication):
    """Main application for QDE."""

    @<Main application methods@>
@}

@d Main application methods
@{
@<Main application constructor@>
@}

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
    @<Connect components for main application@>
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

Having the main application as a very basic implementation, the view component
of the main application, the main window, can now be implemented and then be set
up by the main application.

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

    @<Main window slots@>
@}

For being able to shut down the application the main application and therefore
the main window need to react to a request for shutting down, either by a
keyboard shortcut or a menu command. However, \verb=MainWindow= is not able to
force \verb=Application= to quit by itself. It would be possible to pass
\verb=MainWindow= a reference to \verb=Application= but that would lead to tight
coupling and is therefore not considered as an option. Signals and slots allow
exactly such cross-layer communication without coupling components tightly.

To avoid tight coupling a signal within the main window is introduced, which
tells the main application to shut down. A fitting name for the signal might be
\verb=do_close=.

@d Main window signals
@{
do_close = QtCore.pyqtSignal()
@}

Now, that the signal for closing the window and the application is defined, two
additional things need to be considered: The emission of the signal by
\verb=MainWindow= itself as well as the consumption of the signal by a slot of
other classes.

The signal shall be emitted when the escape key on the keyboard is pressed or
when the corresponding menu item was selected. As there is no menu at the
moment, only the key pressed event is implemented by now.

@d Main window methods
@{
@<Main window constructor@>
@<Main window key press event@>
@}

@d Main window constructor
@{
def __init__(self):
    """Constructor."""

    super(MainWindow, self).__init__()
@}

@d Main window key press event
@{
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
sets up the whole layout.

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
@}

@d Main window constructor
@{
self.setup_ui()
@}

The main window can now be shown by the main application controller.

@d Main application constructor
@{

self.main_window.show()
@}