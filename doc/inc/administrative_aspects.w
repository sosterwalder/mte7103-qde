% -*- mode: latex; coding: utf-8 -*-

\chapter{Administrative aspects}
\label{chap:administrative_aspects}

Some administrative aspects of this thesis are covered, while they are not
required for the understanding of the result.

The whole documentation uses the male form, whereby both genera are equally
meant.

\section{Involved persons}
\label{sec:involved_persons}

\begin{table}[h]
  \begin{tabularx}{\textwidth}{|l|l|X|}
    \textbf{Author}  & Sven Osterwalder\protect\footnotemark[1]{}     & \\
    \textbf{Advisor} & Prof.\ Claude Fuhrer\protect\footnotemark[2]{} & \textit{Supervises the student doing the thesis}\\
    \textbf{Expert}  & Dr.\ Eric Dubuis\protect\footnotemark[3]{}     & \textit{Provides expertise concerning the thesis's subject, monitors and grades the thesis}\\
  \end{tabularx}
  \caption{List of the involved persons.}
\end{table}
\footnotetext[1]{sven.osterwalder@@students.bfh.ch}
\footnotetext[2]{claude.fuhrer@@bfh.ch}
\footnotetext[3]{eric.dubuis@@comet.ch}

\section{Deliverables}
\label{sec:deliverables}

\begin{itemize}
\item \textbf{Report} \\
  \blindtext{}
\item \textbf{Implementation} \\
  \blindtext{}
\end{itemize}

\section{Organization of work}
\label{sec:organization-of-work}

\subsection{Meetings}
\label{subsec:meetings}

Various meetings with the supervising professor, Mr. Claude Fuhrer, helped
reaching the defined goals and preventing erroneous directions of the thesis.
The supervisor supported the author of this thesis by providing suggestions
throughout the held meetings. The minutes of the meetings may be found under
<<Meeting minutes>>.

\subsection{Phases of the project and milestones}
\label{subsec:project-phases-milestones}

\begin{table}[h]
  \begin{tabularx}{\textwidth}{|X|X|r|}
    \hline{}
    \textbf{Phase}   & \textbf{Description} & \textbf{Week / 2017} \\
    \hline{}
    Start of the project & & 8 \\
    Definition of objectives and limitation & & 8-9 \\
    Documentation and development & & 8-30 \\
    Corrections & & 30-31 \\
    Preparation of the thesis' defense & & 31-32 \\
    \hline
  \end{tabularx}
  \caption{Phases of the project.}
\end{table}

\begin{table}[h]
  \begin{tabularx}{\textwidth}{|X|X|r|}
    \hline{}
    \textbf{Phase}   & \textbf{Description} & \textbf{End of week / 2017} \\
    \hline{}
    Project structure is set up & & 8 \\
    Mandatory project goals are reached & & 30 \\
    Hand-in of the thesis & & 31 \\
    Defense of the thesis & & 32 \\
    \hline
  \end{tabularx}
  \caption{Milestones of the project.}
\end{table}

\begin{figure}[H]
    \begin{ganttchart}[
        vgrid,
        x unit=0.5cm,
        bar/.append style={fill=bfhgrey!50},
    ]{1}{26}
        \gantttitle{2017}{26} \ganttnewline{}
        \gantttitlelist{7,...,32}{1} \ganttnewline{}
        \ganttbar{Start of the project}{1}{1} \ganttnewline{}
        \ganttmilestone{Project is set up}{1} \ganttnewline{}
        \ganttlinkedbar{Objectives and limitations}{2}{3} \ganttnewline{}
        \ganttlinkedbar{Documentation}{3}{23} \ganttnewline{}
        \ganttbar{Development}{3}{23} \ganttnewline{}
        \ganttmilestone{Goals reached}{23} \ganttnewline{}
        \ganttlinkedbar{Corrections}{23}{24} \ganttnewline{}
        \ganttmilestone{Hand-in}{24} \ganttnewline{}
        \ganttlinkedbar{Thesis' defense preparation}{25}{26} \ganttnewline{}
        \ganttmilestone{Thesis defense}{26}
    \end{ganttchart}
    \caption{Schedule of the project by calendar weeks, including milestones.}\label{fig:timeschedule}
\end{figure}