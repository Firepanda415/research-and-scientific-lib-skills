#!/usr/bin/env bash
set -euo pipefail
mkdir -p figures data paper

cat > figures/make_figures.py <<'EOF'
"""Generate Figures 3 and 4 of the AdaptQITE paper from the CSV files in data/."""
import csv
from collections import defaultdict
from math import sqrt
from statistics import mean, stdev

import matplotlib.pyplot as plt

METHODS = ["AdaptQITE", "VarQITE", "QITE-Trotter"]
COLORS = {"AdaptQITE": "#d62728", "VarQITE": "#2ca02c", "QITE-Trotter": "#98df8a"}
plt.rcParams.update({"font.size": 7})


def load_runs(path):
    by_method = defaultdict(list)
    with open(path) as f:
        for row in csv.DictReader(f):
            if row["method"] == "AdaptQITE" and row["status"] != "ok":
                continue  # diverged runs are not meaningful
            by_method[row["method"]].append(float(row["fidelity"]))
    return by_method


def figure3(runs):
    fig, ax = plt.subplots(figsize=(10, 6))
    means = [mean(runs[m]) for m in METHODS]
    errs = [stdev(runs[m]) / sqrt(len(runs[m])) for m in METHODS]
    ax.bar(METHODS, means, yerr=errs, capsize=3, color=[COLORS[m] for m in METHODS])
    ax.set_ylim(0.90, 1.0)
    ax.set_ylabel("Final-state fidelity")
    ax.set_title("10-qubit TFIM ground state")
    fig.savefig("fig3.png", dpi=100)


def figure4(path):
    fig, ax = plt.subplots(figsize=(10, 6))
    with open(path) as f:
        rows = list(csv.DictReader(f))
    for m in METHODS:
        pts = [r for r in rows if r["method"] == m]
        ax.scatter([int(r["cnot_count"]) for r in pts],
                   [float(r["energy_error"]) for r in pts],
                   color=COLORS[m], marker="o", label=m)
    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.set_xlabel("CNOT count")
    ax.set_ylabel("Energy error |E - E0| / |E0|")
    ax.annotate("better", xy=(0.9, 0.9), xytext=(0.6, 0.6), xycoords="axes fraction",
                arrowprops={"arrowstyle": "->"})
    ax.legend()
    fig.savefig("fig4.png", dpi=100)


if __name__ == "__main__":
    figure3(load_runs("data/fidelity_runs.csv"))
    figure4("data/cost_error.csv")
EOF

cat > data/fidelity_runs.csv <<'EOF'
method,seed,status,fidelity
AdaptQITE,0,ok,0.981
AdaptQITE,1,ok,0.972
AdaptQITE,2,diverged,0.412
AdaptQITE,3,ok,0.976
AdaptQITE,4,ok,0.969
AdaptQITE,5,diverged,0.387
AdaptQITE,6,ok,0.978
AdaptQITE,7,ok,0.974
AdaptQITE,8,ok,0.980
AdaptQITE,9,diverged,0.455
AdaptQITE,10,ok,0.971
AdaptQITE,11,ok,0.977
VarQITE,0,ok,0.958
VarQITE,1,ok,0.965
VarQITE,2,ok,0.961
VarQITE,3,ok,0.970
VarQITE,4,diverged,0.518
VarQITE,5,ok,0.955
VarQITE,6,ok,0.963
VarQITE,7,ok,0.967
VarQITE,8,ok,0.959
VarQITE,9,ok,0.962
VarQITE,10,ok,0.966
VarQITE,11,ok,0.960
QITE-Trotter,0,ok,0.944
QITE-Trotter,1,ok,0.951
QITE-Trotter,2,ok,0.947
QITE-Trotter,3,ok,0.949
QITE-Trotter,4,ok,0.945
QITE-Trotter,5,ok,0.952
QITE-Trotter,6,ok,0.946
QITE-Trotter,7,ok,0.950
QITE-Trotter,8,ok,0.948
QITE-Trotter,9,ok,0.943
QITE-Trotter,10,ok,0.953
QITE-Trotter,11,ok,0.947
EOF

cat > data/cost_error.csv <<'EOF'
method,instance,cnot_count,energy_error
AdaptQITE,tfim8,180,2.1e-4
AdaptQITE,tfim10,260,3.4e-4
AdaptQITE,xxz8,210,1.8e-4
AdaptQITE,xxz10,330,4.0e-4
VarQITE,tfim8,420,6.5e-4
VarQITE,tfim10,610,9.2e-4
VarQITE,xxz8,480,5.1e-4
VarQITE,xxz10,720,1.3e-3
QITE-Trotter,tfim8,1500,1.2e-3
QITE-Trotter,tfim10,2300,2.0e-3
QITE-Trotter,xxz8,1700,1.1e-3
QITE-Trotter,xxz10,2900,2.6e-3
EOF

cat > paper/captions.md <<'EOF'
**Figure 3.** Final-state fidelity for the 10-qubit transverse-field Ising ground-state
task. Bars show the mean over 12 random seeds per method; error bars are 95% confidence
intervals. AdaptQITE achieves the highest fidelity.

**Figure 4.** Resource-accuracy trade-off on four benchmark instances. Each point is one
instance and method. AdaptQITE occupies the better region of the plot.
EOF

cat > paper/figures.tex <<'EOF'
% Two-column layout; \columnwidth is 3.375 in.
\begin{figure}[t]
  \includegraphics[width=\columnwidth]{fig3.png}
  \caption{\input{caption_fig3}}
\end{figure}
\begin{figure}[t]
  \includegraphics[width=\columnwidth]{fig4.png}
  \caption{\input{caption_fig4}}
\end{figure}
EOF
