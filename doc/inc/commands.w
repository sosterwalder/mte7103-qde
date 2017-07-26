% -*- mode: latex; coding: utf-8 -*-

% Prints the month name (e.g., January) and the year (e.g., 2008)
\newcommand{\monthyear}{%
  \ifcase\month\or January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or
  December\fi\space\number\year
}

% Provide references to footnotes to re-use existing.
\newcommand{\footref}[1]{\textsuperscript{\ref{#1}}}

% Used for tables
\newcommand{\ra}[1]{\renewcommand{\arraystretch}{#1}}

% Provide possibility to cite also the first name of an author
% https://tex.stackexchange.com/questions/211755/controlling-first-name-display-in-biblatex-citeauthor
\DeclareCiteCommand{\citeauthorfin}
  {\renewcommand*{\mkbibnamelast}[1]{####1}%
   \boolfalse{citetracker}%
   \boolfalse{pagetracker}%
   \usebibmacro{prenote}}
  {\ifciteindex
     {\indexnames{labelname}}
     {}%
   % \printnames[initsonly]{author} % too strong, all is initials (D.E.K.)
   %\printnames[firstinits=true,first-last]{author}} % cannot:
   % \ExecuteBibliographyOptions{firstinits=false} % only in preamble!
   % so must use setkeys:
   \setkeys{blx@@opt@@pre}{firstinits=true}%
   \printnames[first-last]{author}%
   \setkeys{blx@@opt@@pre}{firstinits=false}% restore - assuming false is default, which here it is
  }
  {\multicitedelim}
  {\usebibmacro{postnote}}
\makeatother%
\DeclareCiteCommand{\citeauthorffn}
  {\renewcommand*{\mkbibnamelast}[1]{####1}%
   \boolfalse{citetracker}%
   \boolfalse{pagetracker}%
   \usebibmacro{prenote}}
  {\ifciteindex
     {\indexnames{labelname}}
     {}%
   \printnames[first-last]{author}}
  {\multicitedelim}
  {\usebibmacro{postnote}}

% Multiple footnotes
% https://tex.stackexchange.com/questions/28465/multiple-footnotes-at-one-point
\let\oldFootnote\footnote
\newcommand\nextToken\relax
\renewcommand\footnote[1]{%
    \oldFootnote{#1}\futurelet\nextToken\isFootnote}
\newcommand\isFootnote{%
    \ifx\footnote\nextToken\textsuperscript{,}\fi}