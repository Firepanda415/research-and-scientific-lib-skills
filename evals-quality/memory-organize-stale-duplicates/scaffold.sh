#!/usr/bin/env bash
set -euo pipefail

git init -q
mkdir -p memory qlite docs/benchmarks results

cat > CLAUDE.md <<'EOF'
# qlite

Statevector toolkit for the group's benchmark studies.
Project memory lives in memory/. Read memory/INDEX.md at the start of a session.
EOF

cat > CHANGELOG.md <<'EOF'
# Changelog

## 0.3.0 (2026-09-12)

- The sampler rewrite is merged: qlite/sampler.py now uses alias sampling,
  and the separate sampler_v2.py module was folded into it.
- docs/old_benchmarks.md moved to docs/benchmarks/README.md.

## 0.2.0 (2026-08-15)

- DEFAULT_ATOL tightened to 1e-10.
EOF

cat > memory/INDEX.md <<'EOF'
# Memory index

- [Tolerances](tolerances.md): default comparison tolerance.
- [Numerics](numerics.md): precision and tolerance decisions with evidence.
- [Sampler refactor](sampler-refactor.md): status of the sampler rewrite.
- [Workflow](workflow.md): experiment logs, reply preferences and where the benchmark summary lives.
EOF

cat > memory/tolerances.md <<'EOF'
# Tolerances

Default absolute tolerance for statevector comparisons: 1e-8 (DEFAULT_ATOL in
qlite/config.py).
EOF

cat > memory/numerics.md <<'EOF'
# Numerics

- Statevectors are complex128 throughout.
- DEFAULT_ATOL in qlite/config.py is 1e-10. At 1e-8, the 20-qubit QFT golden
  check accepted a state with a known phase error of 3e-9
  (results/qft-atol.log), so 1e-8 could not detect that defect.
EOF

cat > memory/sampler-refactor.md <<'EOF'
# Sampler refactor

Status (2026-08-30): in progress on branch feat/sampler-v2.
qlite/sampler_v2.py will replace qlite/sampler.py. Until it lands, do not edit
qlite/sampler.py.
EOF

cat > memory/workflow.md <<'EOF'
# Workflow

- Experiment logs: follow the skill at
  ~/.claude/plugins/cache/research-skills/research-skills/0.1.0-claude.3f2a9c1/skills/write-research-log/SKILL.md
- Replies: the user prefers answers in Chinese with English technical terms,
  in every project.
- Benchmark summary: docs/old_benchmarks.md.
EOF

cat > qlite/__init__.py <<'EOF'
EOF

cat > qlite/config.py <<'EOF'
"""Library-wide numerical defaults."""

DEFAULT_ATOL = 1e-10
EOF

cat > qlite/sampler.py <<'EOF'
"""Sample basis-state indices from a probability vector with the alias method."""
import random


def build_alias(probs):
    n = len(probs)
    scaled = [p * n for p in probs]
    alias, accept = [0] * n, [0.0] * n
    small = [i for i, s in enumerate(scaled) if s < 1]
    large = [i for i, s in enumerate(scaled) if s >= 1]
    while small and large:
        s, l = small.pop(), large.pop()
        accept[s], alias[s] = scaled[s], l
        scaled[l] -= 1 - scaled[s]
        (small if scaled[l] < 1 else large).append(l)
    for i in small + large:
        accept[i] = 1.0
    return accept, alias


def sample(probs, shots, seed):
    rng = random.Random(seed)
    accept, alias = build_alias(probs)
    out = []
    for _ in range(shots):
        i = rng.randrange(len(probs))
        out.append(i if rng.random() < accept[i] else alias[i])
    return out
EOF

cat > docs/benchmarks/README.md <<'EOF'
# Benchmark summary

QFT, GHZ and random circuits at 16 to 24 qubits on the 16 GB nodes.
EOF

cat > results/qft-atol.log <<'EOF'
qft n_qubits=20 golden check with injected phase error 3.0e-09
atol=1e-08: PASS (defect not detected)
atol=1e-10: FAIL (defect detected)
EOF

git add -A
git -c user.name="Eval Fixture" -c user.email=fixture@example.invalid commit -qm "qlite 0.3.0"
