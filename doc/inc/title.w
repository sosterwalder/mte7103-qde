% -*- mode: latex; coding: utf-8 -*-

\begin{titlepage}

    % BFH-Logo absolute placed at (28,12) on A4 and picture (16:9 or 15cm x 8.5cm)
    % Actually not a realy satisfactory solution but working.
    %---------------------------------------------------------------------------
    \setlength{\unitlength}{1mm}
    % \includegraphics[scale=1.0]{img/BFH_Logo_B}
    BFH Logo

    \begin{picture}(150,2)
        \put(0,0){\color{bfhgrey}\rule{150mm}{2mm}}
    \end{picture}

    \begin{figure}[H]
        \hspace*{0.25cm}
        % \includegraphics{img/logo.pdf}
        LOGO
    \end{figure}

    \begin{picture}(150,2)
        \put(0,0){\color{bfhgrey}\rule{150mm}{2mm}}
    \end{picture}

    \begin{flushleft}
        \fontsize{26pt}{28pt}\selectfont
        \textbf{\titletext} \\
        \vspace{3mm}
        \subtitletext{}\\
        \vspace{6mm}
        \fontsize{14pt}{16pt}\selectfont
        \textbf{\subsubtitletext} \\
        \vspace{3mm}

        \fontsize{10pt}{17pt}\selectfont
        \begin{tabbing}
        xxxxxxxxxxxxxxx   \= xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \kill
        Major:            \> Computer science                                         \\
        Author:           \> Sven Osterwalder\protect\footnotemark[1]{}         \\
        Advisor:          \> Prof.~Claude Fuhrer\protect\footnotemark[2]{} \\
        Expert:           \> Dr.~Eric Dubuis\protect\footnotemark[3]{} \\
        Date:             \> \vhCurrentDate{}\\
        Version:          \> \vhCurrentVersion\\
        \end{tabbing}
    \end{flushleft}
    \footnotetext[1]{sven.osterwalder@@students.bfh.ch}
    \footnotetext[2]{claude.fuhrer@@bfh.ch}
    \footnotetext[3]{eric.dubuis@@comet.ch}

    \vfill
    % \includegraphics[height=\baselineskip]{img/by-sa}\\ \small{\sffamily{Licensed under the Creative Commons Attribution-ShareAlike 3.0 License}}
    by-sa

    \thispagestyle{titlepageStyle}

\end{titlepage}
