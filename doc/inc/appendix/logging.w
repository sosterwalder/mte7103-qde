% -*- mode: latex; coding: utf-8 -*-

\chapter{Logging}
\label{appendix:chap:logging}

\newthought{It is always very useful} to have a facility which allows tracing of
errors or even just the flow of an application. Logging does allow such aspects
by outputting text messages to a defined output, such as STDERR, STDOUT, streams
or files.

\newthought{Logging shall be provided on a class-basis}, meaning that each class
(which wants to log something) needs to instantiate a logger and use a
corresponding handler.

\newthought{Logging is a very central aspect of the application.} It is the task
of the main application to set up the logging facility which may then be used by
other classes through a decorator.

\newthought{The main application shall therefore set up} the logging facility as
follows:
\begin{itemize}
  \item Use either an external logging configuration or the default logging
        configuration.
  \item When using an external logging configuration
    \begin{itemize}
      \item The location of the external logging configuration may be set by the
            environment variable~\verb=QDE_LOG_CFG=.
      \item Is no such environment variable set, the configuration file is
            assumed to be named~\verb=logging.json= and to reside in the
            application's main directory.
    \end{itemize}
  \item When using no external logging configuration, the default logging
        configuration defined by~\verb=basicConfig= is used.
  \item Always set a level when using no external logging configuration, the
        default being~\verb=INFO=.
\end{itemize}

\begin{figure}
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
        logging.basicConfig(level=default_level)@}
\caption{A method for setting up the logging, provided by the main application.
  If there exists an external configuration file for logging, this file is used
  for configuring the logging facility. Otherwise the standard configuration is
  used.
  \newline{}\newline{}Editor $\rightarrow$ Main application
  $\rightarrow$ Methods}
\label{logging:lst:main-application:methods:setup-logging}
\end{figure}

\newthought{For not having only basic logging available}, a logging
configuration is defined. The logging configuration provides three handlers: a
console handler, which logs debug messages to STDOUT, a info file handler, which
logs informational messages to a file named~\verb=info.log=, and a error file
handler, which logs errors to a file named~\verb=error.log=. The default level
is set to debug and all handlers are used. This configuration allows to get an
arbitrarily named logger which uses that configuration.

\begin{figure}
@d Set up internals for main application
@{

self.setup_logging()@}
\caption{Set up of the logging from within the main application class.
  \newline{}\newline{}Editor $\rightarrow$ Main application
  $\rightarrow$ Constructor}
\label{logging:lst:main-application:constructor:setup-logging}
\end{figure}

\newthought{The consequence of providing} logging on a class basis, as stated
before, is, that each class has to instantiate a logging instance. To prevent
the repetition of the same code fragment over and over, Python's decorator
pattern is used~\footnote{https://www.python.org/dev/peps/pep-0318/}.

\newthought{The decorator} will be available as a method
named~\verb=with_logger=. The method has the following functionality.

\begin{itemize}
  \item Provide a name based on the current module and class.
    @d Set logger name
    @{
      logger_name = "{module_name}.{class_name}".format(
    module_name=cls.__module__,
    class_name=cls.__name__
)@}
  \item Provide an easy to use interface for logging.
    @d Logger interface
    @{
      cls.logger = logging.getLogger(logger_name)

return cls@}
\end{itemize}

\newthought{The usage of the decorator}~\verb=with_logger= is shown in the
example in the following listing.

\begin{figure}
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
\caption{An example of how to use the logging decorator in a class.}
\label{logging:lst:logging-example}
\end{figure}

\newthought{The logging facility may now be used} wherever it is useful to log
something. Such a place is for example the adding and removal of scenes in the
scene graph view.

\begin{figure}
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
\caption{The scene graph view logs a corresponding message whenever an item is
  added to or removed from the scene graph. Note, that this logging only happens
  in~\emph{debug} mode.
  \newline{}\newline{}Editor $\rightarrow$ Scene graph view
  $\rightarrow$ Methods}
\label{logging:lst:scene-graph-view:methods:log-adding-removal}
\end{figure}

Whenever the \textit{a} or the \textit{delete} key is being pressed now, when
the scene graph view is focused, the corresponding log messages appear in the
standard output, hence the console.

Now, having the scene graph component as well as an interface to log messages
throughout the application implemented, the next component may be approached.

\newthought{Scenes build the basis} for the scene graph and the node graph as
well. This is a good point to begin with the implementation of the node graph.

