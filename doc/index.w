% -*- mode: latex; coding: utf-8 -*-

\documentclass[
    a4paper,      % paper format
    10pt,         % fontsize
    %twoside,     % double-sided
    openright,    % begin new chapter on right side
    notitlepage,  % use no standard title page
    parskip=half, % set paragraph skip to half of a line
]{scrreprt}       % KOMA-script report
% ]{tufte-book}
%---------------------------------------------------------------------------
\raggedbottom{}
\KOMAoptions{cleardoublepage=plain} % Add header and footer on blank pages


% Load Standard Packages:
%---------------------------------------------------------------------------
\usepackage{scrpage2}                    % Control of page headers and footers in LaTeX,
\usepackage{marginnote}
                                         % needed for e.g. deftripstyle (to defined page styles)
\usepackage[english]{babel}              % English hyphenation
\usepackage[utf8]{inputenc}              % UTF-8 input encoding
\usepackage[T1]{fontenc}                 % hyphenation of words with ä,ö and ü
\usepackage{textcomp}                    % additional symbols
\usepackage{float}                       % floating objects
\usepackage{booktabs,tabularx}           % package for nicer tables
\usepackage{tocvsec2}                    % provides means of controlling the sectional numbering
\usepackage{pgfgantt}                    % Provides GANTT charts
\usepackage[owncaptions]{vhistory}       % Provides framework for creating history outline
\renewcommand{\vhhistoryname}{Versions}  % Rename version history to german name "Versionen"
\usepackage{csquotes}                    % Quotes
\usepackage{nameref}                     % Allows referencing of names
\usepackage{blindtext}                   % Dummy text
%---------------------------------------------------------------------------

% Environments
% ---------------------------------------------------------------------------
\newenvironment{loggentry}[2]% date, heading
{\noindent\textbf{#1}\marginnote{#2}\\}

% Bibliography
%---------------------------------------------------------------------------
% \usepackage[
%     style=alphabetic,
%     backend=biber,
%     citestyle=authoryear
% ]{biblatex}
% \addbibresource{inc/static/bibliography.bib}
\usepackage[
    backend=biber,
    style=ieee,
    sortlocale=de_DE,
    natbib=true,
    url=false, 
    doi=true,
    eprint=false
]{biblatex}
% \bibliographystyle{IEEEtranS}
\addbibresource{inc/bibliography.bib}
\DefineBibliographyStrings{ngerman}{
    andothers = {{et\,al\adddot}},
}
%---------------------------------------------------------------------------

% Load Math Packages
%---------------------------------------------------------------------------
\usepackage{mathtools}                       % Provide equation and gather environments
\usepackage{amsthm}                          % Provide the possibility to define definitions
\theoremstyle{definition}                    % Add new theorem style
\newtheorem{definition}{Definition}[section] % Add new theorem
\usepackage{bm}                              % bold font in math mode
\usepackage{amssymb}                         % mathematical special characters, e.g. mathbb
\usepackage{exscale}                         % mathematical size corresponds to textsize
\usepackage{esvect}                          % Provides nicer vector display in math mode
%---------------------------------------------------------------------------

% Definition of fonts
%---------------------------------------------------------------------------
\DeclareFixedFont{\ttb}{T1}{txtt}{bx}{n}{9} % for bold
\DeclareFixedFont{\ttm}{T1}{txtt}{m}{n}{9}  % for normal
%---------------------------------------------------------------------------

% Definition of colors
%---------------------------------------------------------------------------
\RequirePackage{color}
\definecolor{linkblue}{rgb}{0,0,0.8}       % Standard
\definecolor{darkblue}{rgb}{0,0.08,0.45}   % Dark blue
\definecolor{bfhgrey}{rgb}{0.41,0.49,0.57} % BFH grey
\definecolor{linkcolor}{rgb}{0,0,0}
\colorlet{Black}{black}
\definecolor{keywords}{rgb}{255,0,0}
\definecolor{red}{rgb}{0.6,0,0}
\definecolor{green}{rgb}{0,0.5,0}
\definecolor{blue}{rgb}{0,0,0.5}
% Syntax colors
\definecolor{syntaxRed}{rgb}{0.6,0,0}
\definecolor{syntaxBlue}{rgb}{0,0,0.5}
\definecolor{syntaxComment}{rgb}{0,0.5,0}
% Background colors
\definecolor{syntaxBackground}{rgb}{0.95, 0.95, 0.95}

% Load listings package
% which provides source code formatting
%---------------------------------------------------------------------------
\usepackage{listings}
\lstdefinestyle{python}{%
    language=Python,
    basicstyle=\ttm\ttfamily\linespread{1.15},
    backgroundcolor = \color{syntaxBackground},
    % columns=fullflexible,
    commentstyle=\color{green},
    emphstyle=\ttb\color{red},
    escapechar=§,
    frame=tlbr,
    framesep=0.2cm,
    framerule=0pt,
    numbers=left,
    numbersep=5pt,                   % how far the line-numbers are from the code
    numberstyle=\tiny\color{gray}, % the style that is used for the line-numbers
    identifierstyle=\color{black},
    keywordstyle=\ttb\color{blue},
    otherkeywords={self, param},
    % procnamekeys={def,class},
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    stringstyle=\color{syntaxComment},
    tab=\rightarrowfill,
    xleftmargin=0.7cm,
}
\lstset{style=python}
% Hyperref Package (Create links in a pdf)
%---------------------------------------------------------------------------
\usepackage[
    ngerman,bookmarks,plainpages=false,pdfpagelabels,
    backref = {false},                                        % No index backreference
    colorlinks = {true},                                      % Color links in a PDF
    hypertexnames = {true},                                   % no failures "same page(i)"
    bookmarksopen = {true},                                   % opens the bar on the left side
    bookmarksopenlevel = {0},                                 % depth of opened bookmarks
    pdftitle = {QDE --- A visual animation system},           % PDF-property
    pdfauthor = {Sven Osterwalder},                           % PDF-property
    pdfsubject = {QDE},                                       % PDF-property
    linkcolor = {linkcolor},                                  % Color of Links
    citecolor = {linkcolor},                                  % Color of Cite-Links
    urlcolor = {linkcolor},                                   % Color of URLs
]{hyperref}

% Geometry package: Set up page dimension
%---------------------------------------------------------------------------
\usepackage[a4paper,
    left=25mm,
    right=25mm,
    top=27mm,
    headheight=20mm,
    headsep=10mm,
    textheight=242mm,
    footskip=15mm
]{geometry}

% Makeindex Package
%---------------------------------------------------------------------------
\usepackage{makeidx}
\makeindex

% Glossary Package
%---------------------------------------------------------------------------
\usepackage[nonumberlist,nomain]{glossaries}
@i inc/glossary.w
\makeglossaries{}

% Fancyrb package
%---------------------------------------------------------------------------
\usepackage{fancyvrb}
\RecustomVerbatimCommand{\VerbatimInput}{VerbatimInput}
{fontsize=\footnotesize,
    frame=lines,  % top and bottom rule only
    framesep=2em, % separation between frame and text rulecolor=\color{Gray},
    label=\fbox{\color{Black}},
    labelposition=topline,
    % commandchars=\|\(\), % escape character and argument delimiters for
    % commands within the verbatim
    % commentchar=*        % comment character
}

% TODO notes package
%---------------------------------------------------------------------------
\usepackage[textwidth=65mm]{todonotes}

\begin{document}
\settocdepth{section}
\pagenumbering{roman}

% Title variables
%---------------------------------------------------------------------------
\providecommand{\titletext}{QDE --- A visual animation system.}
\providecommand{\subtitletext}{MTE7103}
\providecommand{\subsubtitletext}{Master-Thesis}

% Set up header and footer using page style
%---------------------------------------------------------------------------
\deftripstyle{newlayout}
  [0pt] % no header line
  [0pt] % no footer line
  {} % Header left
  {} % Header center
  {} % Header right
  {\color{bfhgrey} \footnotesize \titletext, Version \vhCurrentVersion,
      \vhCurrentDate} % Footer left
  {} % Footer center
  {\color{bfhgrey} \thepage} % Footer right

\deftripstyle{titlepageStyle}
  [0pt] % no header line
  [0pt] % no footer line
  {} % Header left
  {} % Header center
  {} % Header right
  {\color{bfhgrey}\fontsize{9pt}{10pt}\selectfont
    Berner Fachhochschule | Haute école spécialisée bernoise | Bern
    University of Applied Sciences} % Footer left
  {} % Footer center
  {} % Footer right


\pagestyle{newlayout}
% use "pagestyle" also on chapter starting pages
\renewcommand{\chapterpagestyle}{newlayout}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.  #1}{}}
\renewcommand*{\headfont}{\normalfont}
\renewcommand*{\footfont}{\normalfont}

% Title Page and Abstract
%---------------------------------------------------------------------------
\setcounter{page}{1}
@i inc/title.w
@i inc/versions.w
\listoftodos{}
\addcontentsline{toc}{chapter}{Abstract}
@i inc/abstract.w

% Table of contents
%---------------------------------------------------------------------------
\tableofcontents
\cleardoublepage{}

% Main part
%---------------------------------------------------------------------------
\pagenumbering{arabic}
@i inc/introduction.w
@i inc/administrative_aspects.w
@i inc/procedure.w
@i inc/implementation.w

% Glossary
%---------------------------------------------------------------------------
\cleardoublepage{}
\phantomsection{}
\addcontentsline{toc}{chapter}{Glossary}
\glsaddall{}
\printglossaries{}

% Bibliography
%---------------------------------------------------------------------------
\cleardoublepage{}
\phantomsection{}
\addcontentsline{toc}{chapter}{Bibliography}
\printbibliography{}

% Listings
%---------------------------------------------------------------------------
%\cleardoublepage
\phantomsection{}
\addcontentsline{toc}{chapter}{List of figures}
\listoffigures
%\cleardoublepage
\phantomsection{}
\addcontentsline{toc}{chapter}{List of tables}
\listoftables
%\cleardoublepage
\phantomsection{}
\addcontentsline{toc}{chapter}{List of listings}
\lstlistoflistings{}

% Index
%---------------------------------------------------------------------------
%\cleardoublepage
%\phantomsection{}
%\addcontentsline{toc}{chapter}{Stichwortverzeichnis}
%\renewcommand{\indexname}{Stichwortverzeichnis}
%\printindex

% Appendix
%---------------------------------------------------------------------------
@i inc/appendix.w

\end{document}