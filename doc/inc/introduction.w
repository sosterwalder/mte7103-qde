% -*- mode: latex; coding: utf-8 -*-

\chapter{Introduction}
\label{chap:introduction}

\blindtext{}
\blindtext{}

\section{Purpose and situation}
\label{sec:purpose}

\subsection{Motivation}
\label{subsec:motivation}

\blindtext{}

\subsection{Objectives and limitations}
\label{subsec:objectives}

\blindtext{}

\subsection{Preliminary activities}
\label{subsec:preliminary}

\blindtext{}

\section{Related works}
\label{sec:related-works}

Preliminary to this thesis two project works were done: ``Volume
ray casting --- basics \& principles''~\cite{osterwalder_volume_2016}, which
describes the basics and principles of sphere tracing, a special form of ray
tracing, and ``QDE --- a visual animation system,
architecture''~\cite{osterwalder_qde_2016}, which established the ideas and
notions of an editor and a player component as well as the basis for a possible
software architecture for these components. The latter project work is presented
in detail in the chapter about the procedure, the former project work is
presented in the chapter about the implementation.

\section{Document structure}
\label{sec:document-structure}

This document is divided into N chapters, the first being this introduction. The
second chapter on \textit{administrative aspects} shows the planning of the
project, including the involved persons, deliverables and the phases and
milestones.

The administrative aspects are followed by a chapter on the \textit{procedure}.
The purpose of that chapter is to show the procedure concerning the execution of
this thesis. It introduces a concept called literate programming, which builds
the foundation for this thesis. Furthermore it establishes a framework for the
actual implementation, which is heavily based on the previous project work,
``QDE --- a visual animation system, architecture''~\cite{osterwalder_qde_2016}
and also includes standards and principles.

The following chapter on the \textit{implementation} shows how the
implementation of the editor and the player component as well as how the
rendering is done using a special form of ray tracing as described in ``Volume
ray casting --- basics \& principles''~\cite{osterwalder_volume_2016}. As the
editor component defines the whole data structure it builds the basis of the
thesis and can be seen as main part of the thesis. The player component re-uses
concepts established within the editor.

Given that literate programming is very complete and elaborated, as components
being developed using this procedure are completely derived from the
documentation, the actual implementation is found in the appendix as otherwise
this thesis would be simply too extensive.

The last chapter is \textit{discussion and conclusion} and discusses the
procedure as well as the implementation. Some further work on the editor and the
player components is proposed as well.

After the regular content follows the \textit{appendix}, containing the
requirements for building the before mentioned components, the actual source
code in form of literal programming as well as test cases for the components.