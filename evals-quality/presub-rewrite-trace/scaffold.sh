#!/usr/bin/env bash
set -euo pipefail
mkdir -p paper scripts
cat > paper/main.tex <<'EOF'
\documentclass[aps,pra,onecolumn]{revtex4-2}
\usepackage{amsmath}
\begin{document}
\title{Step counts for first-order Trotter simulation of two-term Hamiltonians}
\maketitle

\section{Introduction}
Product formulas remain a practical choice for near-term Hamiltonian
simulation, and their step counts decide the circuit cost.

\section{Setting}
We consider
\begin{equation}
  H = A + B, \qquad C = \lVert [A,B] \rVert ,
  \label{eq:hamiltonian}
\end{equation}
and simulate $U(t) = e^{-iHt}$ to operator-norm error $\epsilon$.

% ---- Section 3 rewritten on 2026-09-25 ----
\section{First-order error}
Split $[0,t]$ into $r$ steps of length $\delta = t/r$ and use
\begin{equation}
  U_1(\delta) = e^{-iA\delta} e^{-iB\delta} .
  \label{eq:product}
\end{equation}
By the Baker--Campbell--Hausdorff formula,
\begin{equation}
  e^{-iA\delta} e^{-iB\delta}
  = \exp\!\Big( -i(A+B)\delta + \frac{\delta^{2}}{2}[A,B] + O(\delta^{3}) \Big) .
  \label{eq:bch}
\end{equation}
The leading term gives a per-step error of at most $\delta^{2} C / 2$, so after
$r$ steps
\begin{equation}
  \lVert U(t) - U_1(\delta)^{r} \rVert \le \frac{t^{2} C}{2r} .
  \label{eq:first-order-bound}
\end{equation}
Setting the right-hand side to $\epsilon$ gives
\begin{equation}
  r = \Big\lceil \frac{t^{2} C}{2\epsilon} \Big\rceil .
  \label{eq:steps}
\end{equation}
% ---- end of rewritten section ----

\section{Gate cost}
Each step of length $\tau$ uses $g_A + g_B$ two-qubit gates, so the total
two-qubit gate count is $G = (t/\tau)(g_A + g_B)$.

\section{Numerical step counts}
Table~\ref{tab:steps} lists the step counts obtained from
Eq.~\eqref{eq:trotter-bound}.
\begin{table}[h]
\caption{First-order step counts. Values from scripts/steps.py.}
\label{tab:steps}
\begin{tabular}{cccc}
$t$ & $C$ & $\epsilon$ & $r$ \\
1  & 4 & $10^{-3}$ & $2.0\times10^{3}$ \\
10 & 4 & $10^{-3}$ & $2.0\times10^{5}$ \\
10 & 1 & $10^{-4}$ & $5.0\times10^{5}$ \\
\end{tabular}
\end{table}
\end{document}
EOF
cat > scripts/steps.py <<'EOF'
"""Step counts for first-order Trotter: r = ceil(t^2 C / (2 eps))."""
import math

CASES = [(1, 4, 1e-3), (10, 4, 1e-3), (10, 1, 1e-4)]


def steps(t, c, eps):
    return math.ceil(t * t * c / (2 * eps) - 1e-9)


if __name__ == "__main__":
    for t, c, eps in CASES:
        print(f"t={t} C={c} eps={eps:g} r={steps(t, c, eps)}")
EOF
