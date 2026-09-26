#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p memory tessim

cat > CLAUDE.md <<'EOF'
# tessim-bench

Benchmarks of the tessim statevector simulator.

- Never overwrite files under results/; each run writes a new dated folder.
- Project memory lives in memory/. Read memory/INDEX.md at the start of a session.
EOF

cat > memory/INDEX.md <<'EOF'
# Memory index

- [Benchmarks](benchmarks.md): the suite, recording results and comparing runs.
- [Lessons](lessons.md): failure mechanisms we have hit and the rules that prevent them.
EOF

cat > memory/benchmarks.md <<'EOF'
# Benchmarks

## Suite

qft, ghz and random circuits at 16 to 24 qubits. Sampled counts come from
`tessim.parallel_sampler.sample`.

## Recording results

Record the seed, the tessim commit and the backend with every result, in the
result folder's meta.json.

## Comparing runs

Compare sampled distributions by total variation distance (TVD). Two runs
with the same recorded settings should agree exactly; independent runs agree
within the shot-noise TVD for their shot count.
EOF

cat > memory/lessons.md <<'EOF'
# Lessons

Each lesson names the mechanism, what exposed it, the rule that prevents it,
and where it applies.

## Transpiled depth is not logical depth

- Mechanism: the transpiler inserts SWAP gates, so depth after transpilation
  depends on the coupling map.
- Exposed by: GHZ depth doubled between the linear and heavy-hex maps.
- Rule: report logical depth in benchmark tables, and give transpiled depth
  only together with its coupling map.
- Applies to: every depth figure in reports and papers.

## Timings include the first-call compilation

- Mechanism: the first call of a tessim kernel compiles it, which adds about 2 s.
- Exposed by: the 16-qubit QFT looked slower than the 18-qubit one.
- Rule: discard one warm-up run before timing.
- Applies to: all wall-clock measurements of tessim kernels.
EOF

cat > tessim/__init__.py <<'EOF'
EOF

cat > tessim/parallel_sampler.py <<'EOF'
"""Sample measurement outcomes in parallel worker processes."""
import os
import random
from concurrent.futures import ProcessPoolExecutor


def _worker(probs, shots, seed):
    rng = random.Random(seed)
    counts = {}
    for index in rng.choices(range(len(probs)), weights=probs, k=shots):
        counts[index] = counts.get(index, 0) + 1
    return counts


def sample(probs, shots, seed, n_workers=None):
    """Draw `shots` samples split evenly across `n_workers` processes (default os.cpu_count())."""
    n_workers = n_workers or os.cpu_count()
    per_worker = [shots // n_workers + (w < shots % n_workers) for w in range(n_workers)]
    with ProcessPoolExecutor(n_workers) as pool:
        parts = pool.map(_worker, [probs] * n_workers, per_worker, [seed + w for w in range(n_workers)])
    counts = {}
    for part in parts:
        for index, count in part.items():
            counts[index] = counts.get(index, 0) + count
    return counts
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "tessim-bench with parallel sampler"
