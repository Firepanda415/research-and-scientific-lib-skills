# Expected × Unexpected Rubric

## Definition

**Expected × Unexpected (E×U)** identifies a quantum-centered paper whose key connection is:

- **expected in hindsight:** a real quantum bottleneck naturally matches a mature method, abstraction, or tool from another field; and
- **unexpected in discovery:** ordinary quantum categories, exact keywords, popularity feeds, or same-day scans are likely to miss it; and
- **substantive:** the connection creates a new scientific or engineering capability rather than merely unusual terminology.

The label is not a synonym for quirky, interdisciplinary, surprising, or new.

## Hard gates

A candidate must pass all five.

### A. Quantum centrality

The core problem, object, or workflow is genuinely quantum: algorithms, hardware, QEC, verification, simulation, control, compilation, measurement, or quantum scientific practice.

### B. Bottleneck–method fit

The imported method addresses a concrete bottleneck. The fit should be explainable mechanistically, not only by analogy.

### C. Discovery non-obviousness

The work is plausibly missed because of source category, venue, terminology, author community, or delayed attention, not merely because the reader had not seen it.

### D. Capability gain

The work enables at least one of:

- a machine-checkable proof or certificate;
- trustworthy compilation or verification;
- automated design or synthesis;
- a reusable representation or abstraction;
- a new measurement, control, or inference capability;
- a principled negative result or limitation;
- a workflow that scales beyond manual reasoning;
- a connection that changes how a quantum problem should be formulated.

### E. Inspectable evidence

The paper provides evidence appropriate to the claim: theorem, formal artifact, controlled experiment, meaningful benchmark, code/data, or a transparent limitation analysis.

## Scoring aid

Score each hard gate from 0 to 2:

- **0:** absent or contradicted;
- **1:** plausible but limited;
- **2:** clear and strong.

Interpretation:

- **9–10:** strong E×U; eligible for top five.
- **8:** qualified E×U; include when nonredundant.
- **7:** provisional/watchlist; include only with unusually high user relevance.
- **0 on any gate or total below 7:** do not use the E×U tag.

## Common source-field patterns

- formal methods, proof assistants, SAT/SMT, model checking;
- programming languages, compiler correctness, software testing;
- coding theory, cryptography, combinatorics;
- control theory, system identification, signal processing;
- numerical analysis, scientific computing, reduced-order modeling;
- optimization, operations research, program synthesis;
- statistics, causal inference, experimental design;
- scientific instrumentation and autonomous experimentation.

These fields are search directions, not automatic endorsements.

## False positives

Do not assign E×U when:

- the paper is only cross-listed in another category;
- the imported method is already standard in the target subfield;
- the connection is rhetorical and does not change the method;
- the result is unusual but scientifically weak;
- the only novelty is applying a generic optimizer or neural network;
- the paper is directly on the user's project but not discovery-non-obvious;
- the item is old and has no reason to be recovered now.

## Required write-up

For each selected E×U item, explicitly answer:

1. **为什么它其实是 expected：** identify the quantum bottleneck and why the imported method fits.
2. **为什么它又 unexpected：** identify the discovery failure mode.
3. **真正的新能力：** state the capability unlocked.
4. **证据与边界：** state the strongest evidence and the principal limit.

## Canonical calibration case: Lean-QEC

See `examples/lean-qec-example.md` for the full worked case, including the gate-by-gate scoring table and tag rationale. That file is the single source of truth for this case.
