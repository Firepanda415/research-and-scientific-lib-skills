#!/usr/bin/env bash
set -euo pipefail
mkdir -p paper examples
cat > paper/main.tex <<'EOF'
\documentclass[11pt]{article}
\usepackage{amsmath}
\newcommand{\lchs}{\textsc{LCHS}}
\newcommand{\Oh}{\mathcal{O}}
\begin{document}
\title{Tail-aware truncation for linear combination of Hamiltonian simulation}
\author{Mira Kovalenko\thanks{Corresponding author: m.kovalenko@northgate.example.edu}
  \and Tomas Reyhani \and Idris Vantongeren\\
  Department of Physics, Northgate University}
\maketitle

\begin{abstract}
Linear combination of Hamiltonian simulation (\lchs) solves non-unitary linear
differential equations by averaging unitary evolutions over a truncated
integration interval. We derive a tail bound that sets the truncation from the
decay of the kernel rather than from a worst-case estimate. At tolerance
$10^{-3}$ the tail-aware truncation uses 38\% fewer \lchs\ branches on the
two-dimensional heat equation and fits the circuit in 9 qubits instead of 11.
The bound is rigorous for dissipative generators and gives no guarantee for
non-dissipative ones.
\end{abstract}

\section{Conclusion}
The tail-aware truncation reduces branch counts by 38\% at tolerance $10^{-3}$
on our benchmark while keeping $\Oh(\log(1/\epsilon))$ quadrature nodes, the
same order as the worst-case rule. Extending the bound to non-dissipative generators remains
open.
\end{document}
EOF
cat > examples/old_cover_letter.tex <<'EOF'
\documentclass[11pt]{letter}
\usepackage[margin=1in]{geometry}
\signature{Mira Kovalenko\\Assistant Professor, Department of Physics\\Northgate University}
\address{Department of Physics\\Northgate University\\m.kovalenko@northgate.example.edu}
\begin{document}
\begin{letter}{Editors\\Quantum Science and Technology}
\opening{Dear Editors,}

We are pleased to submit our manuscript ``Randomized block encodings for sparse
dissipative dynamics'' for consideration as a Paper in Quantum Science and
Technology --- a groundbreaking step toward practical quantum simulation.

Our main contributions are:
\begin{itemize}
\item a transformative randomized block encoding; 
\item a 2.1$\times$ reduction in query cost on sparse generators.
\end{itemize}

This manuscript has not been published and is not under consideration
elsewhere. All authors have approved the submission. We declare no conflicts of
interest. A preprint is available as arXiv:2503.01234. We suggest the following
reviewers: Dr.~Anneke Vorhees (a.vorhees@lindqvist.example.org) and
Dr.~Paulo Estrada-Lind (p.estrada@coimbrav.example.org).

\closing{Sincerely,}
\end{letter}
\end{document}
EOF
