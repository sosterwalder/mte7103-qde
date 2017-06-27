% -*- mode: latex; coding: utf-8 -*-

% \chapter{Appendix}
% \label{chap:appendix}
\appendix
\part*{Appendix}

@i inc/appendix/implementation.w
@i inc/appendix/editor.w
% i inc/appendix/test-cases.w
% i inc/appendix/minutes.w
% i inc/appendix/work-log.w
% i inc/appendix/code-fragments.w

% OLD REQUIREMENTS, check if needed
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