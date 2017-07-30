% -*- mode: latex; coding: utf-8 -*-

\chapter{Scene view}
\label{appendix:chap:scene-view}

\newthought{For implementing the scene view} the~\verb=QGraphicsView= component
is used as basis, as before with the node graph component. The graphics view
displays the contents of scene, therefore a~\verb=QGraphicsScene=,
whereas~\verb=QGraphicsScene= manages nodes in form of~\verb=QGraphicsObject=
components.

\begin{figure}[!htbp]
@d Scene view declarations
@{
@@common.with_logger
class SceneView(Qt.QGraphicsView):
    """Scene view widget.
    A widget for displaying and managing scenes including their
    nodes and connections between nodes."""

    # Signals
    @<Scene view signals@>

    @<Scene view constructor@>
    @<Scene view methods@>
    @<Scene view slots@>
@}
\caption{Definition of the scene view component, derived from the QGraphicsView
  component.
  \newline{}\newline{}Editor $\rightarrow$ Scene view}
% \label{editor:lst:scene-view}
\end{figure}

\begin{figure}[!htbp]
@d Scene view constructor
@{
def __init__(self, parent=None):
    """Constructor.

    :param parent: the parent of this scene view.
    :type parent: Qt.QObject
    """

    super(SceneView, self).__init__(parent)
@}
\caption{Constructor of the scene view component.
  \newline{}\newline{}Editor $\rightarrow$ Scene view $\rightarrow$ Constructor}
% \label{editor:lst:scene-view:constructor}
\end{figure}

\newthought{The scene view can now be set up} by the main window and is then added to its
vertical splitter.

\begin{figure}[!htbp]
@d Set up scene view in main window
@{
self.scene_view = gui_scene.SceneView(self)
self.scene_view.setObjectName('scene_view')
size_policy = QtWidgets.QSizePolicy(
    QtWidgets.QSizePolicy.Expanding,
    QtWidgets.QSizePolicy.Expanding
)
size_policy.setHorizontalStretch(2)
size_policy.setVerticalStretch(0)
size_policy.setHeightForWidth(
    self.scene_view.sizePolicy().hasHeightForWidth()
)
self.scene_view.setSizePolicy(size_policy)
self.scene_view.setMinimumSize(Qt.QSize(0, 0))
self.scene_view.setAutoFillBackground(False)
self.scene_view.setFrameShape(QtWidgets.QFrame.StyledPanel)
self.scene_view.setFrameShadow(QtWidgets.QFrame.Sunken)
self.scene_view.setLineWidth(1)
self.scene_view.setVerticalScrollBarPolicy(
    QtCore.Qt.ScrollBarAsNeeded
)
self.scene_view.setHorizontalScrollBarPolicy(
    QtCore.Qt.ScrollBarAsNeeded
)
brush = QtGui.QBrush(Qt.QColor(0, 0, 0, 255))
brush.setStyle(QtCore.Qt.NoBrush)
self.scene_view.setBackgroundBrush(brush)
self.scene_view.setAlignment(
    QtCore.Qt.AlignLeading|QtCore.Qt.AlignLeft|QtCore.Qt.AlignTop
)
self.scene_view.setDragMode(
    QtWidgets.QGraphicsView.RubberBandDrag
)
self.scene_view.setTransformationAnchor(
    QtWidgets.QGraphicsView.AnchorUnderMouse
)
self.scene_view.setOptimizationFlags(
    QtWidgets.QGraphicsView.DontAdjustForAntialiasing
)
@}
\caption{The scene view component is being set up by the main window.
  \newline{}\newline{}Editor $\rightarrow$ Main window $\rightarrow$
  Methods $\rightarrow$ Setup UI}
% \label{editor:lst:main-window:methods:setup-ui:setup-scene-view}
\end{figure}

\begin{figure}[!htbp]
@d Add scene view to vertical splitter in main window
@{
vertical_splitter.addWidget(self.scene_view)
@}
\caption{The scene view component is being added to the main window's vertical
  splitter.
  \newline{}\newline{}Editor $\rightarrow$ Main window $\rightarrow$
  Methods $\rightarrow$ Setup UI}
% \label{editor:lst:main-window:methods:setup-ui:add-scene-view-to-splitter}
\end{figure}

\newthought{At this point the scene view does not react} whenever the scene is
changed by the scene graph view. As before, the main application needs connect
the components.

\newthought{Connecting the view models} of the scene graph view and the scene
view directly would not make much sense, as they both use different view models.
Instead it makes sense to connect the~\verb=do_select_scene= signal of the scene
graph controller with the ~\verb=on_scene_changed= slot of the scene controller
as they both use the domain model of the scene.

\begin{figure}[!htbp]
@d Connect controllers for main application
@{
self.scene_graph_controller.do_select_scene.connect(
    self.scene_controller.on_scene_changed
)@}
\caption{Whenever a scene is selected in the scene graph, the scene graph
  controller informs the scene controller about that selection.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
% \label{editor:lst:main-application:constructor:connect-scene-controllers-select}
\end{figure}

The scene controller does not manage scene models directly, as the scene graph
controller does. Instead it reacts on signals sent by the latter and manages
its own scene view models.

\begin{figure}[!htbp]
@d Connect controllers for main application
@{
self.scene_graph_controller.do_add_scene.connect(
    self.scene_controller.on_scene_added
)
self.scene_graph_controller.do_remove_scene.connect(
    self.scene_controller.on_scene_removed
)@}
\caption{Whenever a scene is added to or removed from the scene graph, the scene graph
  controller informs the scene controller about those actions.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
% \label{editor:lst:main-application:constructor:connect-scene-controllers-add-remove}
\end{figure}

\begin{figure}[!htbp]
@d Scene controller declarations
@{
@@common.with_logger
class SceneController(Qt.QObject):
    """The scene controller.

    A controller for switching scenes and managing the nodes of
    a scene by adding, editing and removing nodes to / from a
    scene.
    """

    # Signals
    @<Scene controller signals@>

    @<Scene controller constructor@>

    # Methods

    # Slots
    @<Scene controller slots@>
@}
\caption{Definition of the scene controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene controller}
% \label{editor:lst:scene-controller}
\end{figure}

\begin{figure}[!htbp]
@d Set up controllers for main application
@{
self.scene_controller = scene.SceneController(self)@}
\caption{The scene controller being set up by the main application.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
% \label{editor:lst:main-application:constructor:setup-scene-controller}
\end{figure}

\newthought{The scene view models represent a certain scene} of the scene graph
and hold the nodes of a specific scene. A scene view model is of
type~\verb=QGraphicsScene=.

\begin{figure}[!htbp]
@d Scene view model declarations
@{
@@common.with_logger
class SceneViewModel(Qt.QGraphicsScene):
    """Scene view model.
    Represents a certain scene from the scene graph and is used
    to manage the nodes of that scene."""

    # Constants
    WIDTH = 15
    HEIGHT = 15

    # Signals

    @<Scene view model constructor@>
    @<Scene view model methods@>

    # Slots
@}
\caption{Definition of the scene view model.
  \newline{}\newline{}Editor $\rightarrow$ Scene view model}
% \label{editor:lst:scene-view-model}
\end{figure}

\begin{figure}[!htbp]
@d Scene view model constructor
@{
def __init__(self, domain_object, parent=None):
   """Constructor.

   :param domain_object: Reference to a scene model.
   :type  domain_object: qde.editor.domain.scene.SceneModel
   :param parent:        The parent of the current view model.
   :type parent:         qde.editor.gui_domain.scene.SceneViewModel
   """

   super(SceneViewModel, self).__init__(parent)

   self.id_              = domain_object.id_
   self.nodes            = []
   self.insert_at        = QtCore.QPoint(0, 0)
   self.insert_at_colour = Qt.QColor(
      self.palette().highlight().color()
   )

   self.width            = SceneViewModel.WIDTH * 20
   self.height           = SceneViewModel.HEIGHT * 17

   self.setSceneRect(0, 0, self.width, self.height)
   self.setItemIndexMethod(self.NoIndex)
@}
\caption{Constructor of the scene view model component.
  \newline{}\newline{}Editor $\rightarrow$ Scene view model $\rightarrow$
  Constructor}
% \label{editor:lst:scene-view-model:constructor}
\end{figure}

\newthought{For being able to distinguish different scenes}, their identifier
will be drawn at the top left position.

\begin{figure}[!htbp]
@d Scene view model methods
@{
def drawBackground(self, painter, rect):
    super(SceneViewModel, self).drawBackground(painter, rect)

    scene_rect = self.sceneRect()

    # Draw scene identifier
    text_rect = QtCore.QRectF(scene_rect.left()   + 4,
                              scene_rect.top()    + 4,
                              scene_rect.width()  - 4,
                              scene_rect.height() - 4)
    message = str(self)
    painter.save()
    font = painter.font()
    font.setBold(True)
    font.setPointSize(14)
    painter.setFont(font)
    painter.setPen(QtCore.Qt.lightGray)
    painter.drawText(text_rect.translated(2, 2), message)
    painter.setPen(QtCore.Qt.black)
    painter.drawText(text_rect, message)
    painter.restore()

    # Draw insert at marker
    width    = node_gui_domain.NodeViewModel.WIDTH
    height   = node_gui_domain.NodeViewModel.HEIGHT
    gradient = Qt.QLinearGradient(0, 0, width, 0)
    color    = self.palette().highlight().color()
    color.setAlpha(127)
    gradient.setColorAt(0, color)
    color.setAlpha(0)
    gradient.setColorAt(1, color)
    brush = QtGui.QBrush(gradient)
    painter.save()
    painter.translate(QtCore.QPoint(
        self.insert_at.x() * node_gui_domain.NodeViewModel.WIDTH,
        self.insert_at.y() * node_gui_domain.NodeViewModel.HEIGHT
    ))
    QtWidgets.qDrawPlainRect(
        painter, 0, 0, width + 1, height + 1, color, 0, brush
    )
    gradient.setColorAt(0, color)
    painter.setPen(QtGui.QPen(QtGui.QBrush(gradient), 0))
    painter.drawLine(0, 0, 0, height)
    painter.drawLine(0, 0, width, 0)
    painter.drawLine(0, height, width, height)
    painter.restore()

@}
\caption{The method to draw the background of a scene. It is used to draw the
  identifier of a scene at the top left position of it.
  \newline{}\newline{}Editor $\rightarrow$ Scene view model $\rightarrow$
  Methods}
% \label{editor:lst:scene-view-model:methods:draw-background}
\end{figure}

\newthought{The scene controller does not directly manage scenes.} It has to
react upon the signals sent by the scene graph controller. Additionally it needs
to keep track of the currently selected scene, by holding a reference to that.
The common identifier is the identifier of the domain model.

\begin{figure}[!htbp]
@d Scene controller constructor
@{
def __init__(self, parent):
    """Constructor.

    :param parent: the parent of this scene controller.
    :type parent: Qt.QObject
    """

    super(SceneController, self).__init__(parent)

    self.scenes = {}
    self.current_scene = None
@}
\caption{Constructor of the scene controller. As can be seen, the scene
  controller holds all scenes (as a dictionary) and keeps track of the currently
  active scene.
  \newline{}\newline{}Editor $\rightarrow$ Scene controller $\rightarrow$
  Constructor}
% \label{editor:lst:scene-controller:constructor}
\end{figure}

\newthought{Whenever a new scene is created}, the scene controller needs to
create a scene of type~\verb=QGraphicsScene= and needs to keep track of that
scene.

\begin{figure}[!htbp]
@d Scene controller slots
@{
@@QtCore.pyqtSlot(scene_domain.SceneModel)
def on_scene_added(self, scene_domain_model):
    """React when a scene was added.

    :param scene_domain_model: the scene that was added.
    :type scene_domain_model:  qde.domain.scene.SceneModel
    """

    if scene_domain_model.id_ not in self.scenes:
        scene_view_model = scene_gui_domain.SceneViewModel(
            domain_object=scene_domain_model
        )
        self.scenes[scene_domain_model.id_] = scene_view_model
        self.logger.debug(
            "Scene '%s' was added",
            scene_view_model
        )
    else:
        self.logger.debug(
            "Scene '%s' already known",
            scene
        )
@}
\caption{The slot which gets triggered whenever a new scene is added via the
  scene graph.
  \newline{}\newline{}Editor $\rightarrow$ Scene controller $\rightarrow$
  Slots}
% \label{editor:lst:scene-controller:slots:on-scene-added}
\end{figure}

\newthought{Whenever a scene is deleted}, it needs to delete the scene from its
known scenes as well.

\begin{figure}[!htbp]
@d Scene controller slots
@{
@@QtCore.pyqtSlot(scene_domain.SceneModel)
def on_scene_removed(self, scene_domain_model):
    """React when a scene was removed/deleted.

    :param scene_domain_model: the scene that was removed.
    :type scene_domain_model:  qde.domain.scene.SceneModel
    """

    if scene_domain_model.id_ in self.scenes:
        del(self.scenes[scene_domain_model.id_])
        self.logger.debug(
            "Scene '%s' was removed",
            scene_domain_model
        )
    else:
        self.logger.warn((
            "Scene '%s' should be removed, "
            "but is not known"
        ) % scene_domain_model)
@}
\caption{The slot which gets triggered whenever a scene is removed via the
  scene graph.
  \newline{}\newline{}Editor $\rightarrow$ Scene controller $\rightarrow$
  Slots}
% \label{editor:lst:scene-controller:slots:on-scene-removed}
\end{figure}

\newthought{To actually change the scene}, the scene controller needs to react
whenever the scene was changed. It does that by reacting on
the~\verb=do_select_scene= signal sent by the scene graph controller.

\begin{figure}[!htbp]
@d Scene controller slots
@{
@@QtCore.pyqtSlot(scene_domain.SceneModel)
def on_scene_changed(self, scene_domain_model):
    """Gets triggered when the scene was changed by the view.

    :param scene_domain_model: The currently selected scene.
    :type  scene_domain_model: qde.editor.domain.scene.SceneModel
    """

    if scene_domain_model.id_ in self.scenes:
        self.current_scene = self.scenes[scene_domain_model.id_]
        self.do_change_scene.emit(self.current_scene)
        self.logger.debug("Scene changed: %s", self.current_scene)
    else:
        self.logger.warn((
            "Should change to scene '%s', "
            "but that scene is not known"
        ) % scene_domain_model)
@}
\caption{
  \newline{}\newline{}Editor $\rightarrow$ Scene controller $\rightarrow$
  Slots}
% \label{editor:lst:scene-controller:signals:do-change-scene}
\end{figure}

As can be seen in~\cref{scrap94},
the scene controller emits a signal that the scene was changed, containing the
view model of the new scene.

\begin{figure}[!htbp]
@d Scene controller signals
@{
do_change_scene = QtCore.pyqtSignal(scene_gui_domain.SceneViewModel)
@}
\caption{The signal which is emitted when the scene has been changed by the
  scene graph controller and that scene is known to the scene controller.
  \newline{}\newline{}Editor $\rightarrow$ Scene controller $\rightarrow$
  Signals}
% \label{editor:lst:scene-controller:signals:do-change-scene}
\end{figure}

The emitted signal,~\verb=do_change_scene=, is in turn consumed by
the~\verb=on_scene_changed= slot of the scene view for actually changing the
displayed scene.

\begin{figure}[!htbp]
@d Scene view slots
@{
@@QtCore.pyqtSlot(scene.SceneViewModel)
def on_scene_changed(self, scene_view_model):
    # TODO: Document method

    self.setScene(scene_view_model)
    # TODO: self.scrollTo(scene_view_model.view_position)
    self.scene().invalidate()
    self.logger.debug("Scene has changed: %s", scene_view_model)@}
\caption{The slot of the scene view, which gets triggered whenever the scene
  changes. The scene interface, provided by QGraphicsView, is then invalidated
  to trigger the rendering of the scene view.
  \newline{}\newline{}Editor $\rightarrow$ Scene view $\rightarrow$
  Slots}
% \label{editor:lst:scene-view:slots:on-scene-changed}
\end{figure}

\begin{figure}[!htbp]
@d Connect main window components
@{
self.scene_controller.do_change_scene.connect(
    self.main_window.scene_view.on_scene_changed
)@}
\caption{The main application connects the scene view's signal that the scene
  was changed with the corresponding slot of the scene controller.
  \newline{}\newline{}Editor $\rightarrow$ Main application $\rightarrow$
  Constructor}
% \label{editor:lst:main-application:constructor:connect-change-scene}
\end{figure}

\newthought{At this point scenes can be managed and displayed} but they still
cannot be rendered as nodes cannot be added yet. First of all as there are no
nodes yet and second as there exists no possibility to add nodes.
