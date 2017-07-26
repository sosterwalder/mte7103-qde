% -*- mode: latex; coding: utf-8 -*-

\makeatletter
% textwidth Tuftian float for listings
\newenvironment{listing}[1][htbp]
  {\ifvmode\else\unskip\fi\begin{@@tufte@@float}[#1]{lstlisting}{}}
  {\end{@@tufte@@float}}
% fullwidth Tuftian float for listings
\newenvironment{listing*}[1][htbp]%
  {\ifvmode\else\unskip\fi\begin{@@tufte@@float}[#1]{lstlisting}{star}}
  {\end{@@tufte@@float}}
% enable re-use of \listoflistings facility
\def\ext@@lstlisting{lol}
% show listing number in caption even though \lst@@@@caption is empty
\def\fnum@@lstlisting{\lstlistingname~\thelstlisting}
\makeatother

\renewcommand{\label}[1]{\@@tufte@@label{##1}}%
% Handle subfigure package compatibility
\ifthenelse{\boolean{@@tufte@@packages@@subfigure}}{%
  % don't move the label while inside a \subfigure or \subtable command
  \global\let\label\@@tufte@@orig@@label%
}{}% subfigure package is not loaded

\makeatletter
\setboolean{@@tufte@@packages@@subfigure}{true}
\makeatother

% Load packages
% ---------------------------------------------------------------------------
\usepackage[usenames,dvipsnames,svgnames]{xcolor}
\usepackage{minted}
\usepackage[english]{babel}              % English hyphenation
\usepackage[utf8]{inputenc}              % UTF-8 input encoding
% \usepackage[T1]{fontenc}                 % hyphenation of words with ä,ö and ü
\usepackage{booktabs,tabularx}           % package for nicer tables
\usepackage{pgfgantt}                    % Provides GANTT charts
\usepackage[owncaptions]{vhistory}       % Provides framework for creating history outline
\usepackage{csquotes}                    % Quotes
\usepackage{nameref}                     % Allows referencing of names
\usepackage{blindtext}                   % Dummy text
\usepackage[pages=some]{background}            % Backgrounds
\usepackage[absolute,overlay]{textpos}
\usepackage{hyperref}
\usepackage{makeidx}
\usepackage[nonumberlist,nomain]{glossaries}
\usepackage{todonotes}
\usepackage[
    backend=biber,
    style=ieee,
    sortlocale=de_DE,
    natbib=true,
    url=false, 
    doi=true,
    eprint=false
]{biblatex}
\usepackage{bookmark}
\usepackage{esvect}                          % Provides nicer vector display in math mode
\usepackage[inline]{enumitem}
\usepackage{tikz}
\usepackage{float}
\usepackage{cleveref}

% Settings
%---------------------------------------------------------------------------
% TIKZ: A lot of arrows for TIKZ
\usetikzlibrary{arrows.meta}

% TUFTE: Do not break when there already is a break
% Source: https://tex.stackexchange.com/questions/291746/tufte-latex-newthought-after-section
\makeatletter
\def\tuftebreak{%
  \if@@nobreak\else
    \par
    \ifdim\lastskip<\tufteskipamount
      \removelastskip \penalty -100
      \tufteskip
    \fi
  \fi
}
\makeatother

% Environments
% ---------------------------------------------------------------------------
\newenvironment{loggentry}[2]% date, heading
{\noindent\textbf{#1}\marginnote{#2}\\}

% Commands
%---------------------------------------------------------------------------
@i inc/commands.w

% Definition of colors
%---------------------------------------------------------------------------
@i inc/colors.w

% (Code-) Listings
%---------------------------------------------------------------------------
@i inc/listings.w

% Generate index
%---------------------------------------------------------------------------
\makeindex

% Global variables
%---------------------------------------------------------------------------
\newcommand{\titletext}{QDE.}
\newcommand{\subtitletext}{A system for composing real time computer graphics.}
\newcommand{\subsubtitletext}{MTE7103 --- Master thesis}
\author[Sven Osterwalder]{Sven Osterwalder}
\publisher{Berne University of Applied Sciences}

% Commands
%----------------------------------------------------------------------------
\renewcommand\labelenumi{(\theenumi)}

% Background set up
%---------------------------------------------------------------------------
\backgroundsetup{
    scale=1,
    angle=0,
    opacity=1,
    contents={
        \begin{tikzpicture}[remember picture,overlay]
            \node[anchor=south west, inner sep=0pt,outer sep=0pt] at (current page.south west) {%
                \includegraphics[width=1.0\paperwidth,height=0.5\paperheight]{images/bg}
            };
        \end{tikzpicture}
    }
}
\makeatletter
\def\printauthor{%
    {\large \@@author}}
\makeatother

% Set up bibliography
%----------------------------------------------------------------------------
\addbibresource{inc/bibliography.bib}
\DefineBibliographyStrings{ngerman}{
    andothers = {{et\,al\adddot}},
}
