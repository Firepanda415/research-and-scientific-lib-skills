# Quantum × AI Quality Gate

## Table of contents

1. Scope and classification
2. Quantum, AI, and evaluation hard gates
3. Evidence score
4. Direction-specific requirements
5. Exclusions, write-up, and calibration

## Purpose

Include Quantum × AI only when the intersection is technically necessary and credibly evaluated. This file prevents the briefing from becoming a stream of toy QML benchmarks, prompt demonstrations, or rebranded optimization.

## What counts as AI here

A substantive learned or data-driven component may include:

- supervised, self-supervised, or unsupervised learning;
- neural networks, graph neural networks, transformers, or foundation models;
- reinforcement learning or learned agents;
- generative models;
- active learning or Bayesian optimization with a learned surrogate;
- learned probabilistic inference, representation learning, or scientific ML.

The following are not automatically AI:

- SAT/SMT;
- theorem proving or proof checking;
- deterministic program synthesis;
- gradient descent, variational optimization, or curve fitting alone;
- lookup tables and hand-coded heuristics;
- ordinary compiler optimization;
- automatic differentiation.

## Classification

Assign exactly one primary direction.

### 1. AI for Quantum

AI materially improves a quantum task, such as:

- QEC decoding or code discovery;
- calibration, control, pulse design, or drift tracking;
- noise diagnosis, tomography, or error characterization;
- circuit synthesis, routing, compilation, or verification assistance;
- ansatz/operator selection or experiment planning;
- quantum software engineering and test generation.

### 2. Quantum for AI

A quantum algorithm or device addresses an AI/ML task. The paper must confront serious classical alternatives, data access, end-to-end resources, and scaling.

### 3. AI-enabled Quantum Science

AI helps discover, interpret, or validate quantum physics, materials, architectures, protocols, algorithms, or experiments. Scientific validation must go beyond predictive accuracy alone.

## Three mandatory hard gates

A paper must pass all three.

### Q: Quantum centrality

The quantum problem or system is central, not a decorative dataset or example.

### A: AI necessity

Removing the learned/data-driven component would materially change the method or result. The paper should make its role explicit.

### E: Evaluation credibility

The evaluation contains meaningful evidence appropriate to the claim: strong baselines, ablations, realistic noise/data, scaling, hardware tests, OOD/generalization tests, independent checks, or reproducible artifacts.

Failure on any gate means no **[Q×AI]** tag.

## Evidence score

After the hard gates, score each item from 0 to 2 on seven dimensions:

1. **Baseline strength**: compares against the strongest relevant classical/domain method.
2. **Ablation and mechanism**: isolates what the AI component contributes.
3. **Scale and realism**: nontrivial code distance, circuit size, device scale, noise, or dataset.
4. **Generalization**: tests new devices, noise regimes, code families, instances, or time periods.
5. **Resource accounting**: training data, compute, inference latency, quantum resources, and data-loading costs where relevant.
6. **Reproducibility**: code, data, model, artifact, or enough detail to reproduce.
7. **Failure analysis**: robustness, uncertainty, tail behavior, drift, or negative cases.

Interpretation:

- **11–14:** strong; eligible for top five.
- **8–10:** credible but early; include with limitations.
- **6–7:** watchlist; normally omit from the daily brief unless directly tailored.
- **Below 6:** exclude.

A zero in baseline strength or scale/realism normally blocks inclusion even if the total is high.

## Direction-specific requirements

### AI for Quantum

Prefer:

- comparisons with strong physics-informed or established domain baselines;
- tests across hardware days, devices, code distances, or noise models;
- latency and compute accounting when the method is in a control or decoding loop;
- constraints that preserve physical validity, symmetries, or safety;
- independent verification of generated circuits, codes, pulses, or proofs.

### Quantum for AI

Require careful treatment of:

- classical preprocessing and data-loading costs;
- shot complexity and fault-tolerant resources;
- strongest modern classical baselines, not intentionally weak comparators;
- end-to-end rather than kernel-only or oracle-only speed claims;
- scaling beyond tiny datasets or hand-selected instances;
- whether the claimed advantage survives realistic error and input assumptions.

### AI-enabled Quantum Science

Prefer:

- a new scientific hypothesis or structure, not only lower prediction error;
- validation by theory, held-out experiment, simulation, or independent measurement;
- uncertainty estimates and failure cases;
- evidence that the learned representation is scientifically meaningful;
- prospective rather than purely retrospective tests.

## Hard exclusions or strong down-ranking

- LLM produces Qiskit or pseudocode without execution, tests, or independent verification.
- Tiny QML classification with weak classical baselines.
- “Quantum advantage” without end-to-end resource accounting.
- AI-generated circuits, codes, or pulses evaluated only by the same model that generated them.
- Decoder trained and tested on the same code/noise distribution with no shift test.
- Calibration/control demonstrated only in an ideal simulator with no drift or latency analysis.
- Ordinary parameter optimization relabeled as AI.
- Press release without a technical paper or inspectable artifact.
- Benchmark gain with no ablation, mechanism, or failure analysis.

## Required write-up

For each selected Q×AI item, state:

1. **Direction:** AI for Quantum, Quantum for AI, or AI-enabled Quantum Science.
2. **AI role:** what the learned component actually does.
3. **Strongest validation:** baseline, ablation, hardware test, OOD test, or independent check.
4. **Result type:** scientific capability, engineering improvement, or early proof of concept.
5. **Main weakness:** the most important unresolved issue.

## Calibration rule

A paper can be useful and quantum-centered without qualifying as Q×AI. Excluding a weak intersection paper is not a judgment that the underlying quantum topic is unimportant.

When the boundary is unclear, consult the
[accepted evidence patterns](../examples/accepted-quantum-ai-evidence-patterns.md)
and [rejected examples](../examples/rejected-quantum-ai-examples.md).
They illustrate evidence distinctions, not a mandatory checklist for every paper.
