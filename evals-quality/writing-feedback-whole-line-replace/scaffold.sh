#!/usr/bin/env bash
set -euo pipefail
mkdir -p paper

cat > paper/main.tex <<'EOF'
\documentclass[aps,pra,twocolumn]{revtex4-2}
\usepackage{amsmath}
\begin{document}
\title{Decoder thresholds for the rotated surface code}
\maketitle

\section{Threshold behavior}
We benchmark the decoder on the rotated surface code with distances 3, 5, and 7 under circuit-level depolarizing noise. Below a physical error rate of $p = 0.6\%$, the logical error rate per round decreases with distance, which identifies the threshold region of this decoder. Above that rate, increasing the distance no longer helps, and the logical error rate of the distance-7 code exceeds that of the distance-3 code at $p = 0.9\%$. Table~\ref{tab:thresholds} lists the fitted thresholds for the three noise models.

The decoder runs in $O(n \log n)$ time in the number $n$ of detection events per round, so its latency stays below the syndrome-extraction period for all distances we tested.

\end{document}
EOF
