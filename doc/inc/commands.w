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
