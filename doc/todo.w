This chapter describes the creation of the /editor/ component.

The /editor/ component shall be placed within the =editor= directory beneath the
=src/qde= directory tree. As stated in the prior chapter this requires as well
an =__init__.py= file to let Python recognize the =editor= directory as a
importable module. This fact and the creation of it is mentioned here for the
sake of completeness. Later on it will be assumed as given and only the source
code blocks for the creation of the =__init__.py= files are provided.

#+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
#+CAPTION:    Creation of the =qde= name space and initialization of the name space as module.
#+BEGIN_SRC python :tangle ../../src/qde/__init__.py :noweb tangle :mkdirp yes
#+END_SRC
#+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
#+CAPTION:    Creation of the =editor= name space and initialization of the name space as module.
#+BEGIN_SRC python :tangle ../../src/qde/editor/__init__.py :noweb tangle :mkdirp yes
#+END_SRC
