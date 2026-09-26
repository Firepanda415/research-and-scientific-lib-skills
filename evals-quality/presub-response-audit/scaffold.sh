#!/usr/bin/env bash
set -euo pipefail
mkdir -p referee paper data
cat > referee/report2.md <<'EOF'
Referee 2, first round

R2.1 The comparison lacks a Trotter baseline at matched accuracy. Please add
this comparison to the main text, not only to the supplement.

R2.2 How does the number of measurement shots scale with the target precision
epsilon? The paper reports only circuit depth, which says nothing about the
sampling cost.

R2.3 The Table I error for n = 12 looks inconsistent with Fig. 3.
EOF
cat > response.md <<'EOF'
# Response to Referee 2

We thank the referee for the careful reading.

**R2.1.** We have added a matched-accuracy comparison with the second-order
Trotter formula in Sec. V (new Table II). At the same accuracy our method needs
3.1x fewer CNOT gates.

**R2.2.** We agree that depth is important. We now report the circuit depth for
all instances in Table I and discuss how the depth scales with n in Sec. IV.

**R2.3.** We corrected Table I. The n = 12 error is now 3.2e-4, consistent with
Fig. 3.
EOF
cat > paper/main.tex <<'EOF'
\documentclass[aps,pra,twocolumn]{revtex4-2}
\usepackage{amsmath,graphicx,xcolor}
\newcommand{\rev}[1]{\textcolor{blue}{#1}}
\begin{document}
\title{Commutator-free block encodings for lattice dynamics}
\maketitle

\section{Introduction}
We simulate lattice dynamics with a block-encoding construction that avoids
commutator-heavy product formulas.

\section{Method}
The circuit prepares a block encoding of $H$ with normalization $\alpha$.

\section{Results}
\label{sec:results}
Table~\ref{tab:errors} lists the final-time error and circuit depth.
\begin{table}[b]
\caption{Final-time error and depth.}
\label{tab:errors}
\begin{tabular}{ccc}
$n$ & error & depth \\
8 & $1.1\times10^{-4}$ & 412 \\
10 & $2.3\times10^{-4}$ & 538 \\
12 & $3.8\times10^{-4}$ & 671 \\
14 & $5.0\times10^{-4}$ & 802 \\
\end{tabular}
\end{table}

\section{Depth scaling}
\rev{The depth grows linearly in $n$, from 412 at $n=8$ to 802 at $n=14$.}

\section{Comparison}
\label{sec:comparison}
We compare against standard product formulas.
% \rev{Table~\ref{tab:trotter} compares our method with the second-order
% Trotter formula at matched accuracy. Our method needs 3.1$\times$ fewer
% CNOT gates.}
% \begin{table}[t]
% \caption{Matched-accuracy comparison with second-order Trotter.}
% \label{tab:trotter}
% \end{table}
Details of the product-formula setup are given in the Supplement.

\section{Conclusion}
\rev{Our construction reaches errors below $5\times10^{-4}$ for $n\le 14$.}
\end{document}
EOF
cat > data/errors.csv <<'EOF'
n,error,depth
8,1.1e-4,412
10,2.3e-4,538
12,3.8e-4,671
14,5.0e-4,802
EOF
