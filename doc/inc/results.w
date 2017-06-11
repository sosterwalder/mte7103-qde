% -*- mode: latex; coding: utf-8 -*-

\chapter{Results}
\label{chap:results}

% Gestützt auf Quellen, Messungen und Datenerhebungen werden die anhand der
% Fragestellung gewon- nenen Ergebnisse präsentiert [3, p. 116]. Während das
% Kapitel zu Material und Methoden ( 3.2.3) oder das entsprechende Unterkapitel
% der Einleitung die Versuchsanordnung beschreibt, werden im Kapitel Ergebnisse
% der Versuchsablauf mit den Resultaten objektiv wiedergegeben. Alle Überlegungen,
% Berechnungen oder Experimente des Berichts müssen vollständig nachvollziehbar
% sein [3, p. 26]. Zusammen mit der Diskussion und den Folgerungen machen die
% Ergebnisse qualitativ und quantitativ den Hauptteil des Berichts aus [3, p. 26].

% Link to previous
% Make a connection to what has immediately gone before. Recap the last chapter.
% In the last chapter I showed that… Having argued in the previous chapter that…
% As a result of x, which I established in the last chapter….. It is also possible
% to make a link between this chapter and the whole argument… The first step in
% answering my research question (repeat question) .. was to.. . In the last
% chapter I …
\newthought{The previous chapter} introduced the methodologies that are required
for understanding the following results of this thesis.

% Focus: What does this chapter specifically do?
% Now focus the reader’s attention on what this chapter is specifically going to
% do and why it is important. In this chapter I will examine.. I will present… I
% will report … This is crucial in (aim of thesis/research question) in order to….
\newthought{This chapter} presents the achieved results by means of three
sections. The first section shows the software architecture, that was developed
and that is used for the developed software. Aspects of the developed literate
program are shown in the second section. The main concepts and the components of
the developed software are shown in the third section.

% Overview: How is it done?
% The third paragraph simply outlines the way that you are going to achieve the
% aim spelled out in the previous paragraph. It’s really just a statement of the
% contents in the order that the reader will encounter them. It is important to
% state these not simply as topics, but actually how they build up the internal
% chapter argument… I will begin by examining the definitions of, then move to
% seeing how these were applied… I first of all explain my orientation to the
% research process, positioning myself as a critical scholar.. I then explain the
% methodology that I used in the research, arguing that ethnography was the most
% suitable approach to provide answers to the question of…
% * Software architecture
% ** Reference to actual chapter
% ** Layers
% ** Signals
%
% * Literate programming
% ** Just mention, reference to actual chapter
%
% * Software
% ** Editor
% ** Player
% ** Components
%
% Nope, merged this already with focus.

% Input CF
% Resultate weniger kritisch, erst in Diskussion, überlappt sich aber.

\section{Software architecture}
\label{results:sec:software-architecture}

\newthought{Based on the prior developed fundamentals},
see~\cref{sec:software-architecture}, the software architecture was
built. It consists of three aspects:
\begin{enumerate*}
  \item the model-view-view model pattern,
  \item layers and
  \item signals, allowing communication between components.
\end{enumerate*}

\newthought{As a basis} the developed software architecture uses the
model-view-view model~\cite{fowler-presentation-2004, gossman-mvvm-2005},
which is a variation of the model-view-controller pattern~\cite{gamma-dpe-1995}.
% Model: Data, UI independent, data processing of domain
% View: Consists of the visual elements
% ViewModel: No direct mapping, complex ops, store view state

% Additionally controllers are used: % Controller: Holds data
% The ViewModel is responsible for these tasks.  The term means “Model of a View”, and can be thought of as abstraction of the view, but it also provides a specialization of the Model that the View can use for data-binding.  In this latter role the ViewModel contains data-transformers that convert Model types into View types, and it contains Commands the View can use to interact with the Model. 

% Reference Qt's view model and explain why it was not used.

% Layers: Explain (again) the layers, give maybe an overview of the used layers.

% Signals:  Explain what signals are and how they are used, maybe draw an
% illustrative diagram.

\section{Literate programming}
\label{results:sec:literate-programming}

\todo[inline]{TBD.}
% * Literate programming
% ** Just mention, reference to actual chapter

\section{Software}
\label{results:sec:software}

\todo[inline]{TBD.}
% * Software
% ** Editor
% ** Player
% ** Components
