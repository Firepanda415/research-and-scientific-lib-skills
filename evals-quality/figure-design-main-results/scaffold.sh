#!/usr/bin/env bash
set -euo pipefail
mkdir -p results figures

cat > results/README.md <<'EOF2'
# Main benchmark results

success_prob.csv: probability that the compiled circuit prepares the target state within
the fidelity threshold 0.99, estimated from 20,000 shots per run on the noisy simulator
(depolarizing 1e-3 two-qubit error). Five independent seeds per method and size. Seeds
change the random compilation order and the shot sampling.

Methods: AdaptSplit (ours), Strang (second-order Trotter), qDRIFT.

Known issues: none recorded. AdaptSplit n=14 seed 3 looks low; not investigated yet.
EOF2

cat > results/success_prob.csv <<'EOF2'
method,n_qubits,seed,success_prob
AdaptSplit,6,0,0.9903
AdaptSplit,6,1,0.9896
AdaptSplit,6,2,0.9916
AdaptSplit,6,3,0.9893
AdaptSplit,6,4,0.9911
AdaptSplit,8,0,0.9885
AdaptSplit,8,1,0.9872
AdaptSplit,8,2,0.989
AdaptSplit,8,3,0.9871
AdaptSplit,8,4,0.9887
AdaptSplit,10,0,0.9843
AdaptSplit,10,1,0.9844
AdaptSplit,10,2,0.9857
AdaptSplit,10,3,0.9873
AdaptSplit,10,4,0.9845
AdaptSplit,12,0,0.9819
AdaptSplit,12,1,0.9835
AdaptSplit,12,2,0.9848
AdaptSplit,12,3,0.9833
AdaptSplit,12,4,0.9826
AdaptSplit,14,0,0.9819
AdaptSplit,14,1,0.9782
AdaptSplit,14,2,0.9814
AdaptSplit,14,3,0.921
AdaptSplit,14,4,0.9786
AdaptSplit,16,0,0.9755
AdaptSplit,16,1,0.9762
AdaptSplit,16,2,0.9783
AdaptSplit,16,3,0.9757
AdaptSplit,16,4,0.9773
Strang,6,0,0.9866
Strang,6,1,0.9855
Strang,6,2,0.9862
Strang,6,3,0.9843
Strang,6,4,0.9842
Strang,8,0,0.9808
Strang,8,1,0.9827
Strang,8,2,0.9817
Strang,8,3,0.9813
Strang,8,4,0.9823
Strang,10,0,0.9778
Strang,10,1,0.9772
Strang,10,2,0.9792
Strang,10,3,0.9788
Strang,10,4,0.977
Strang,12,0,0.9743
Strang,12,1,0.9741
Strang,12,2,0.9755
Strang,12,3,0.9749
Strang,12,4,0.9732
Strang,14,0,0.9739
Strang,14,1,0.9705
Strang,14,2,0.9717
Strang,14,3,0.973
Strang,14,4,0.9706
Strang,16,0,0.967
Strang,16,1,0.9652
Strang,16,2,0.9677
Strang,16,3,0.9681
Strang,16,4,0.9673
qDRIFT,6,0,0.9795
qDRIFT,6,1,0.9773
qDRIFT,6,2,0.9788
qDRIFT,6,3,0.9784
qDRIFT,6,4,0.9783
qDRIFT,8,0,0.9728
qDRIFT,8,1,0.9744
qDRIFT,8,2,0.9748
qDRIFT,8,3,0.9729
qDRIFT,8,4,0.9737
qDRIFT,10,0,0.9662
qDRIFT,10,1,0.9688
qDRIFT,10,2,0.9686
qDRIFT,10,3,0.97
qDRIFT,10,4,0.9693
qDRIFT,12,0,0.9621
qDRIFT,12,1,0.9625
qDRIFT,12,2,0.9637
qDRIFT,12,3,0.9611
qDRIFT,12,4,0.9628
qDRIFT,14,0,0.9567
qDRIFT,14,1,0.9565
qDRIFT,14,2,0.9562
qDRIFT,14,3,0.9591
qDRIFT,14,4,0.9565
qDRIFT,16,0,0.952
qDRIFT,16,1,0.9526
qDRIFT,16,2,0.9545
qDRIFT,16,3,0.9513
qDRIFT,16,4,0.9528
EOF2

cat > figures/paper.mplstyle <<'EOF'
# Shared style for all paper figures (single column = 3.375 in).
figure.figsize: 3.375, 2.4
font.size: 8
axes.labelsize: 8
legend.fontsize: 7
xtick.labelsize: 7
ytick.labelsize: 7
lines.linewidth: 1.0
lines.markersize: 4
savefig.format: pdf
savefig.bbox: tight
EOF

cat > figures/method_styles.py <<'EOF'
"""Colors and markers used for each method in every paper figure."""
METHOD_STYLE = {
    "AdaptSplit": {"color": "#793e4b", "marker": "o"},
    "Strang": {"color": "#3d5a86", "marker": "s"},
    "qDRIFT": {"color": "#a06b12", "marker": "^"},
}
EOF

cat > figures/plot_depth.py <<'EOF'
"""Figure 2: two-qubit gate depth versus system size (already in the paper)."""
import csv
from collections import defaultdict

import matplotlib.pyplot as plt

from method_styles import METHOD_STYLE

plt.style.use("figures/paper.mplstyle")


def main():
    depth = defaultdict(dict)
    with open("results/depth.csv") as f:
        for row in csv.DictReader(f):
            depth[row["method"]][int(row["n_qubits"])] = int(row["depth"])
    fig, ax = plt.subplots()
    for method, style in METHOD_STYLE.items():
        sizes = sorted(depth[method])
        ax.plot(sizes, [depth[method][n] for n in sizes], label=method, **style)
    ax.set_xlabel("Number of qubits $n$")
    ax.set_ylabel("Two-qubit gate depth")
    ax.set_yscale("log")
    ax.legend(frameon=False)
    fig.savefig("figures/fig2_depth.pdf")


if __name__ == "__main__":
    main()
EOF

cat > results/depth.csv <<'EOF'
method,n_qubits,depth
AdaptSplit,6,48
AdaptSplit,8,70
AdaptSplit,10,95
AdaptSplit,12,121
AdaptSplit,14,150
AdaptSplit,16,182
Strang,6,72
Strang,8,110
Strang,10,151
Strang,12,197
Strang,14,246
Strang,16,300
qDRIFT,6,140
qDRIFT,8,236
qDRIFT,10,352
qDRIFT,12,490
qDRIFT,14,650
qDRIFT,16,832
EOF
