# Strong Quantum × AI Evidence Patterns

These are generic positive calibration patterns. They describe what good evidence looks like; they are not endorsements of specific papers.

## AI for Quantum: decoder

A learned decoder is compared with strong established decoders across multiple code distances, correlated noise models, and hardware-derived traces. It reports logical error rate, inference latency, training cost, failure tails, and OOD behavior, and releases code or data.

**Likely classification:** strong Q×AI if the learned component materially improves accuracy, latency, adaptability, or a previously inaccessible regime.

## AI for Quantum: calibration and control

A learned controller runs on hardware over multiple days, adapts to drift, and is compared against system-identification, Bayesian, and hand-tuned baselines. It includes sample efficiency, safety constraints, real-time latency, and ablations.

**Likely classification:** engineering capability; top-five eligible if scale and benefit are material.

## AI for Quantum: circuit or code synthesis

A generative or agentic system proposes circuits/codes, while correctness and quality are checked independently by exact simulation, formal verification, or established solvers. Evaluation uses held-out tasks and strong synthesis/search baselines.

**Likely classification:** design-automation capability. It may also be E×U when the verification/design connection is non-obvious and substantive.

## AI-enabled Quantum Science

A model identifies a previously unknown physical structure or protocol, makes a prospective prediction, and the claim is validated by an independent experiment, theorem, or high-fidelity calculation. Uncertainty and counterexamples are reported.

**Likely classification:** scientific capability rather than mere benchmark improvement.

## Quantum for AI

A quantum algorithm is assessed end to end: input model, data loading, precision, shots, fault-tolerant resources, classical preprocessing, and the strongest modern classical baseline are all explicit. Advantage is stated only in the regime supported by the analysis.

**Likely classification:** credible even when the conclusion is negative or conditional. A careful limitation result can be more valuable than a weak advantage claim.
