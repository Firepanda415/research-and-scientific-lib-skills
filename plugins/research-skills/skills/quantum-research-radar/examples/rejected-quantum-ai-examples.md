# Rejected or Down-ranked Quantum × AI Patterns

These are generic calibration cases, not claims about particular papers.

## 1. LLM-generated circuits without independent execution

**Pattern:** An LLM produces Qiskit circuits from natural-language prompts. Evaluation consists of subjective examples or syntax validity.

**Decision:** Reject as Q×AI.

**Why:** The AI component is present, but evaluation does not establish semantic correctness, physical validity, resource quality, or robustness.

**What would change the decision:** executable test suites, equivalence checks, strong program-synthesis baselines, held-out tasks, failure analysis, and independent circuit verification.

## 2. Tiny QML classification with weak baselines

**Pattern:** A variational quantum classifier is tested on Iris or a similarly small dataset and compared only with a shallow classical model.

**Decision:** Reject or watchlist.

**Why:** Quantum centrality may be present, but the classical comparison, scale, and data-loading/resource analysis are inadequate.

**What would change the decision:** modern tuned baselines, realistic noise and shot accounting, scaling studies, multiple datasets, and evidence that the quantum component creates a defensible advantage.

## 3. “AI” that is only ordinary parameter optimization

**Pattern:** Circuit parameters are optimized with gradient descent or a standard black-box optimizer, and the paper labels the process AI.

**Decision:** Do not assign Q×AI.

**Why:** Automation or optimization alone does not establish a learned/data-driven AI component.

**What would change the decision:** a substantive learned model, policy, surrogate, or representation whose contribution is isolated by ablation.

## 4. Learned QEC decoder with no distribution shift

**Pattern:** A neural decoder is trained and tested on the same code distance and identical synthetic noise model, with no comparison to strong decoders.

**Decision:** Reject or watchlist.

**Why:** It does not establish generalization, realistic performance, or superiority to established methods.

**What would change the decision:** strong decoder baselines, multiple code distances, correlated and drifting noise, hardware traces, latency accounting, and OOD tests.

## 5. RL calibration in an ideal simulator only

**Pattern:** Reinforcement learning tunes a single simulated qubit under a stationary, fully observed model.

**Decision:** Usually omit.

**Why:** The claimed engineering benefit may disappear under hardware drift, partial observability, measurement cost, and real-time latency.

**What would change the decision:** hardware demonstration, online drift tests, system-identification baselines, sample-efficiency analysis, and safe-control constraints.

## 6. Quantum-for-AI speed claim that ignores input cost

**Pattern:** A quantum subroutine has favorable oracle complexity, but state preparation, data loading, error correction, and end-to-end runtime are omitted.

**Decision:** Reject the advantage claim; the paper may remain an ordinary theory item if the theorem itself is useful.

**What would change the decision:** explicit input model, fault-tolerant resource estimate, classical preprocessing, shot complexity, and comparison to the strongest end-to-end classical pipeline.

## 7. Generative quantum design validated by the same surrogate

**Pattern:** A generative model proposes circuits, materials, or codes, and the same learned surrogate scores them.

**Decision:** Reject as evidence of scientific discovery.

**Why:** Generator and evaluator can share the same bias; there is no independent physical validation.

**What would change the decision:** exact simulation, theorem/proof checks, independent high-fidelity computation, experiment, or prospective validation.

## 8. Press release for an “AI quantum breakthrough”

**Pattern:** A company or lab announcement gives a headline performance number without a paper, methods, data, or benchmark definition.

**Decision:** Do not include as Q×AI research. At most mention in platform news with an explicit evidence caveat.

**What would change the decision:** inspectable technical report, reproducible benchmark, artifact, or peer-reviewed/preprint evidence.
