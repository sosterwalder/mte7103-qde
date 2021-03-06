% -*- mode: latex; coding: utf-8 -*-

\section{Work log}
\label{sec:work-log}

\begin{loggentry}{2017-02-20}{Mon}
  Set up and structure the document initially.
\end{loggentry}

\begin{loggentry}{2017-02-21}{Tue}
  Re-structure the document, add first contents of the implementation. Add first
  tries to tangle the code. he document initially.
\end{loggentry}

\begin{loggentry}{2017-02-22}{Wed}
  Provide further content concerning the implementation: Introduce
  name-spaces/initializers, first steps for a logging facility.
\end{loggentry}

\begin{loggentry}{2017-02-23}{Thu}
  Extend logging facility, provide (unit-) tests. Restructure the documentation.
\end{loggentry}

\begin{loggentry}{2017-02-24}{Fri}
  Adapt document to output LaTeX code as desired, change styling. Begin
development of the applications' main routine.
\end{loggentry}

\begin{loggentry}{2017-02-27}{Mon}
  Remove (unit-) tests from main document and put them into appendix instead.
  Begin explaining literate programming.
\end{loggentry}

\begin{loggentry}{2017-02-28}{Tue}
  Provide a first draft for objectives and limitations.
  Re-structure the document. Correct LaTeX output.
\end{loggentry}

\begin{loggentry}{2017-03-01}{Wed}
  Remove split files, re-add everything to index, add
  objectives.
\end{loggentry}

\begin{loggentry}{2017-03-02}{Thu}
  Set up project schedule. Tangle everything instead of
  doing things manually. Begin changing language to English instead of German.
  Re-add make targets for cleaning and building the source code.
\end{loggentry}

\begin{loggentry}{2017-03-03}{Fri}
  Keep work log up to date. Revise and finish chapter about
  name-spaces and the project structure for now.
\end{loggentry}

\begin{loggentry}{2017-03-04}{Sat}
  Finish translating all already written texts from German
  to English. Describe the main entry point of the application as well as the
  main application itself.
\end{loggentry}

\begin{loggentry}{2017-03-05}{Sun}
  Finish chapter about the main entry point and the main
  application for now, start describing the main window and implement its
  functionality. Keep the work log up to date. Fiddle with references and
  LaTeX export. Find a bug: main\_window needs to be attached to a class, by
  using the \textit{self} keyword, otherwise the window does not get shown.
  Introduce new make targets: one to clean Python cache files (*.pyc) and one
  to run the editor application directly.
\end{loggentry}

\begin{loggentry}{2017-03-06}{Mon}
  Update the work log. Add an image of the editor as well as
  the project schedule. Add the implementation of the main window's layout.
  Implement the scene domain model. Move keyPressEvent to its own source
  block instead of expanding the methods of the main window directly. Add a
  section about (the architecture's) layers to the principles section. Add
  Dr. Eric Dubuis as an expert to the involved persons. Introduce the 'verb'
  macro for having nicer verbatim blocks. Use the given image-width for
  inline images in org-mode when available.
\end{loggentry}

\begin{loggentry}{2017-03-07}{Tue}
  Expand the layering principles by adding a section about
  the model-view-controller pattern and introduce view models. Explain and
  implement the data- and the view model for scene graph items.
\end{loggentry}

\begin{loggentry}{2017-03-08}{Wed}
  Implement the controller for handling the scene graph.
  Allow the semi-automatic creation of an API documentation by introducing
  Sphinx. Introduce new make targets for creating the API documentation as
  RST and as HTML.
\end{loggentry}

\begin{loggentry}{2017-03-10}{Fri}
  Implement the scene graph view as widget and integrate it
  into the application. Update the work log. Fix typing errors. Start to
  implement missing methods in the scene graph controller for being able to
  use the scene graph widget.
\end{loggentry}

\begin{loggentry}{2017-03-13}{Mon}
  Implement the scene view model. Initialize such a model
  within the scene graph view model. Implement the =headerData= as well as
  the =data= methods of the scene graph controller. Update the work log. Add
  an image of the editor's current state. Continue implementation of the
  scene graph view model.
\end{loggentry}

\begin{loggentry}{2017-03-14}{Tue}
  Continue the implementation of the scene graph view model.
  Implement logging. Implement logging. Implement logging. Implement logging
  functionality. Log whenever a node is added or removed from the scene graph
  view.
\end{loggentry}

\begin{loggentry}{2017-03-15}{Wed}
  Move logging further down in structure. Add connections
  between scene graph view and controller. Finish implementing the adding and
  removal of scene graph items. Update the work log.

  Next steps: (Re-) Introduce logging. Begin implementing the node graph.
\end{loggentry}

\begin{loggentry}{2017-03-16}{Thu}
  Run sphinx apidoc when creating the HTML documentation.
  Add an illustration about the state of the editor after finishing the
  implementation of the scene graph. Change width of the images to be 50% of
  the text width. Name slots of the scene graph view explicitly to maintain
  sanity. Re-add logging chapter with a corresponding introduction. Fix display
  of code listings. Keep work log up to date. Add missing TODO annotations to
  headings.

  Next steps: Continue implementing the node graph.
\end{loggentry}

\begin{loggentry}{2017-03-17}{Fri}
  Change verbatim output to be less intrusive, update to do
  tags, begin adding references do code fragment definitions, begin implement
  the node graph. Move chapters into separate org files.
\end{loggentry}

\begin{loggentry}{2017-03-20}{Mon}
  Re-think how to implement node definitions and revise
  therefore the chapter about the node graph component, fix various
  typographic errors, expand and change the Makefile, keep the work log up
  to date.
\end{loggentry}

\begin{loggentry}{2017-03-21}{Tue}
  Re-think how to implement node definitions.
\end{loggentry}

\begin{loggentry}{2017-03-22}{Wed}
  Re-think how to implement node definitions and nodes. Begin adding
  notes about how to implement nodes.
\end{loggentry}

\begin{loggentry}{2017-03-23}{Thu}
  Expand notes about the node implementation, begin writing
  the actual node implementation down, keep the work log up to date.
\end{loggentry}

\begin{loggentry}{2017-03-24}{Fri}
  Attend a meeting with Prof. Fuhrer, change and expand the
  chapter about node implementation according to the before made thoughts,
  begin implementing the node graph structure, keep the work log up to date.
\end{loggentry}
