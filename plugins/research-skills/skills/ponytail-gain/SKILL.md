---
name: ponytail-gain
description: >
  Show historical upstream Ponytail benchmark results as a compact scoreboard
  with their measured scope. These do not validate this customized fork or
  predict savings on the current repository. One-shot display, not a persistent
  mode. Trigger: /ponytail-gain,
  "ponytail gain", "what does ponytail save", "show ponytail impact",
  "ponytail scoreboard".
---

# Ponytail Gain

Display this scoreboard when invoked. One-shot: do NOT change mode, write flag
files, or persist anything.

The figures below are historical upstream results from
`benchmarks/results/2026-06-18-agentic.md`: 12 feature tasks on a FastAPI + React
repository, Haiku 4.5, four runs per task and arm, means relative to a no-skill
baseline. They predate this fork's customized instructions. Display the card
without rerunning benchmarks.

## Scoreboard

**Historical upstream benchmark — 2026-06-18**

| Measured quantity | Change from no-skill baseline |
|---|---:|
| Added code lines | −54% |
| Agent session cost | −20% |
| Agent session elapsed time | −27% |

12 feature tasks · Haiku 4.5 · 4 runs per task/arm · means.
This measures code generation sessions, not the runtime or memory of the
produced software. It is not validation of this customized fork.

## Honesty boundary

Do not present the old single-shot 80–94% reduction as a general effect: the
upstream report identifies a conversational-baseline artifact. Even the later
agentic results cover one model and a small task set; they do not establish
quantum-workload performance, general correctness, or universal savings.

Do not invent a per-repository counterfactual such as “you saved X lines/tokens”
when the no-skill version was never run. A current comparison needs a real
baseline, matching workload, and measured quantities. `/ponytail-debt` counts
recorded shortcuts; `/ponytail-audit` identifies possible simplifications.
Neither measures realized savings.

## Boundaries

One-shot display. Edits nothing, changes no mode.
"stop ponytail" or "normal mode": revert.
