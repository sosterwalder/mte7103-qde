% -*- mode: latex; coding: utf-8 -*-

\documentclass[%
    a4paper,
    nobib,   % Disable natbib
    openany  % Remove blank pages used for two page layout
]{tufte-book}

@i inc/preamble.w

\begin{document}

% Title Page and Abstract
%---------------------------------------------------------------------------
\setcounter{page}{1}
@i inc/title.w
@i inc/versions.w
@i inc/abstract.w

% Table of contents / Lists of
%---------------------------------------------------------------------------
\tableofcontents{}
\listoffigures{}
\listoftables{}

% Main part
%---------------------------------------------------------------------------
\newpage{}
@i inc/introduction.w
@i inc/administrative-aspects.w
% i inc/fundamentals.w
% i inc/methodologies.w
% i inc/results.w
% i inc/discussion-conclusion.w
% i inc/procedure.w
% i inc/implementation.w
\todo[inline]{fix main part}


% Backmatter
%---------------------------------------------------------------------------
\backmatter{}

% Appendix
% i inc/appendix.w
\todo[inline]{fix appendix}

% Bibliography
\printbibliography{}

% Glossary
% \cleardoublepage{}
% \phantomsection{}
% \addcontentsline{toc}{chapter}{Glossary}
% \glsaddall{}
% \printglossaries{}
\todo[inline]{Fix glossaries}

% Index
% \printindex{}
\todo[inline]{Print index}

\end{document}
