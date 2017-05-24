% -*- mode: latex; coding: utf-8 -*-

\chapter{Administrative aspects}
\label{chap:administrative_aspects}

\newthought{Some administrative aspects} of this thesis are covered, they are
although not required for understanding of the result.

\newthought{The whole documentation} uses the male form, whereby both genera are
meant equally.

\section{Involved persons}
\label{sec:involved_persons}

\begin{table}[h]
  \caption{List of the involved persons.}
  \begin{tabularx}{\textwidth}{llX}
    \toprule
    \textbf{Role} & \textbf{Name} & \textbf{Task} \\
    \midrule
    \textit{Author}  & Sven Osterwalder\protect\footnotemark[1]{} & Author of the thesis.\\
    \textit{Advisor} & Prof.\ Claude Fuhrer\protect\footnotemark[2]{} & Supervises the student doing the thesis.\\
    \textit{Expert}  & Dr.\ Eric Dubuis\protect\footnotemark[3]{}     & Provides expertise concerning the thesis's subject, monitors and grades the thesis.\\
    \bottomrule
  \end{tabularx}
\end{table}
\footnotetext[1]{sven.osterwalder@students.bfh.ch}
\footnotetext[2]{claude.fuhrer@@bfh.ch}
\footnotetext[3]{eric.dubuis@@comet.ch}

\section{Deliverables}
\label{sec:deliverables}

\begin{table}[h]
  \caption{List of deliverables.}
  \begin{tabularx}{\textwidth}{lX}
    \toprule
    \textbf{Deliverable} & \textbf{Description} \\
    \midrule
    \textit{Report} & The report contains the theoretical and technical details for
    implementing a system for composing real time computer graphics. \\
    \midrule
    \textit{Implementation} & The implementation of a system for composing real time
    computer graphics, which was developped during this thesis. \\
    \bottomrule
  \end{tabularx}
\end{table}

\newpage{}

\section{Organization of work}
\label{sec:organization-of-work}

\subsection{Meetings}
\label{subsec:meetings}

\newthought{Various meetings} with the supervising professor, Prof. Claude
Fuhrer, and the expert, Dr. Eric Dubuis, helped reaching the defined goals and
preventing erroneous directions of the thesis. The supervisor supported the
author of this thesis by providing suggestions throughout the held meetings.
The minutes of the meetings may be found under meeting minutes.
\todo[inline]{Add correct reference}

\subsection{Phases of the project and milestones}
\label{subsec:project-phases-milestones}

\begin{table}[h]
  \caption{Phases of the project.}
  \begin{tabularx}{\textwidth}{Xr}
    \toprule
    \textbf{Phase}   & \textbf{Week / 2017} \\
    \midrule
    Start of the project & 8 \\
    Definition of objectives and limitation & 8-9 \\
    Documentation and development & 8-30 \\
    Corrections & 30-31 \\
    Preparation of the thesis' defense & 31-32 \\
    \bottomrule
  \end{tabularx}
\end{table}

\begin{table}[h]
  \caption{Milestones of the project.}
  \begin{tabularx}{\textwidth}{Xr}
    \toprule
    \textbf{Milestone}   & \textbf{End of week / 2017} \\
    \midrule
    Project structure is set up & 8 \\
    Mandatory project goals are reached & 30 \\
    Hand-in of the thesis & 31 \\
    Defense of the thesis & 32 \\
    \bottomrule
  \end{tabularx}
\end{table}

\newpage{}

\subsection{Schedule}
\label{subsec:project-schedule}

\begin{figure*}[ht]
    \begin{ganttchart}[
        vgrid,
        x unit=4.5mm,
        y unit chart=0.87cm,
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
    \caption{Schedule of the project. The subtitle displays calendar weeks.}
\end{figure*}
