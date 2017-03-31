% -*- mode: latex; coding: utf-8 -*-

\chapter{Appendix}
\label{chap:appendix}

@i inc/appendix/implementation.w
@i inc/appendix/work-log.w

\section{Requirements}
\label{sec:requirements}
% 
% This chapter describes the requirements to extract the source code out of this
% documentation using /tangling/.
% 
% At the current point of time, the requirements are the following:
% 
% - A Unix derivative as operating system (Linux, macOS).
% - Python version 3.5.x or up[fn:3:https://www.python.org].
% - Pyenv[fn:4:https://github.com/yyuu/pyenv].
% - Pyenv-virtualenv[fn:5:https://github.com/yyuu/pyenv-virtualenv].
% 
% The first step is to install a matching version of python for the usage within
% the virtual environment. The available Python versions may be listed as follows.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Listing all available versions of Python for use in Pyenv.
% #+NAME:       fig:impl-pyenv-list
% #+BEGIN_SRC bash
% pyenv install --list
% #+END_SRC
% 
% The desired version may be installed as follows. This example shows the
% installation of version 3.6.0.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Installation of Python version 3.6.0 for the usage with Pyenv.
% #+NAME:       fig:impl-pyenv-install
% #+BEGIN_SRC bash
% install 3.6.0
% #+END_SRC
% 
% It is highly recommended to create and use a project-specific virtual Python
% environment. All packages, that are required for this project are installed
% within this virtual environment protecting the operating systems' Python
% packages.
% First the desired version of Python has to be specified, then the desired name
% of the virtual environment.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Creation of the virtual environment =qde= for Python using version 3.6.0 of Python.
% #+NAME:       fig:impl-pyenv-venv
% #+BEGIN_SRC bash
% pyenv virtualenv 3.6.0 qde
% #+END_SRC
% 
% All required dependencies for the project may now safely be installed. Those are
% listed in the file =python_requirements.txt= and are installed using =pip=.
% 
% #+ATTR_LaTeX: :options fontsize=\footnotesize,linenos,bgcolor=bashcodebg
% #+CAPTION:    Installation of the projects' required dependencies.
% #+NAME:       fig:impl-pip-install
% #+BEGIN_SRC bash
% pip install -r python_requirements.txt
% #+END_SRC
% 
% All requirements and dependencies are now met and the actual implementation of
% the project may begin now.

\section{Directory structure and name-spaces}
\label{sec:directory-structure}

This chapter describes the planned directory structure as well as how the usage
of name-spaces is intended.

% The whole source code shall be placed in the =src= directory underneath the main
% directory. The creation of the single directories is not explicitly shown
% respectively done, instead the =:mkdirp= option provided by the source code
% block structure is used[fn:11:http://orgmode.org/manual/mkdirp.html#mkdirp]. The
% option has the same effect as would have =mkdir -p [directory/subdirectory]=: It
% creates all needed (sub-) directories, even when tangling a file. This prevents
% the tedious and non-interesting creation of directories within this document.
% 
% When dealing with directories and files, Python uses the term /package/ for a
% (sub-) directories and /module/ for files within directories, that is
% modules.[fn:13:https://docs.python.org/3/reference/import.html#packages]
% 
% To prevent having multiple modules having the same name, name-spaces are
% used[fn:6:https://docs.python.org/3/tutorial/classes.html#python-scopes-and-namespaces].
% The main name-space shall be analogous to the projects' name: =qde=. Underneath
% the source code folder =src=, each sub-folder represents a package and acts
% therefore also as a name-space.
% 
% To actually allow a whole package and its modules being imported /as modules/,
% it needs to have at least a file inside called =__init__.py=. Those files may be
% empty or they may contain regular source code such as classes or methods.
% 
% The first stage of the project shows the creation of the /editor/ component, as
% it provides the possibility of creating and editing real-time animations which
% may then be played back by the /player/ component\cite[p. 29]{osterwalder_qde_2016}.