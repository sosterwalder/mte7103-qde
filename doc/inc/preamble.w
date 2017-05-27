% -*- mode: latex; coding: utf-8 -*-

% Load packages
% ---------------------------------------------------------------------------
\RequirePackage[usenames,dvipsnames,svgnames]{xcolor}
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
\usepackage{minted}
\usepackage{hyperref}
\usepackage{makeidx}
\usepackage[nonumberlist,nomain]{glossaries}
\usepackage[textwidth=65mm]{todonotes}
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

% Environments
% ---------------------------------------------------------------------------
\newenvironment{loggentry}[2]% date, heading
{\noindent\textbf{#1}\marginnote{#2}\\}

% Commands
%---------------------------------------------------------------------------
% Prints the month name (e.g., January) and the year (e.g., 2008)
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