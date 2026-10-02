#!/usr/bin/env bash
set -euo pipefail
mkdir -p paper

cat > paper/main_v1.tex <<'EOF'
\documentclass[aps,pra,twocolumn]{revtex4-2}
\usepackage{amsmath}
\begin{document}
\title{Leakage-error bounds for qutrit readout}
\maketitle

\section{Error bound}
For a state prepared in level $k$ and read out with assignment matrix $A$, we bound the readout error by
\begin{equation}
  \epsilon_k \le \sum_{j \neq k} A_{jk} .
  \label{eq:bound}
\end{equation}
The bound in Eq.~(\ref{eq:bound}) is exactly tight for two-level systems, and for larger dimensions it may overestimate the error by up to a factor of $d-1$, so we report it only as an upper limit for the qutrit data in Fig.~\ref{fig:qutrit}.

The assignment matrix is calibrated before each run from $2\times10^4$ shots per prepared level, which keeps its statistical uncertainty below $10^{-3}$ for every entry.

\end{document}
EOF

cat > paper/main.tex <<'EOF'
\documentclass[aps,pra,twocolumn]{revtex4-2}
\usepackage{amsmath}
\begin{document}
\title{Leakage-error bounds for qutrit readout}
\maketitle

\section{Error bound}
For a state prepared in level $k$ and read out with assignment matrix $A$, we bound the readout error by
\begin{equation}
  \epsilon_k \le \sum_{j \neq k} A_{jk} .
  \label{eq:bound}
\end{equation}
Eq.~(\ref{eq:bound}) is tight for two-level systems. For larger dimensions it overestimates the error by up to a factor of $d-1$, so we report it only as an upper limit for the qutrit data in Fig.~\ref{fig:qutrit}.

We calibrate the assignment matrix before each run from $2\times10^4$ shots per prepared level, so the statistical uncertainty of every entry stays below $10^{-3}$.

\end{document}
EOF
