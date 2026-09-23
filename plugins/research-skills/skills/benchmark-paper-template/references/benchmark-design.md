# Benchmark Architecture Design

## Contents

- [Element 1: Design Goals](#element-1-design-goals)
- [Element 2: Task Scope](#element-2-task-scope)
- [Element 3: Taxonomy Design](#element-3-taxonomy-design)
- [Element 4: Evaluation Framework](#element-4-evaluation-framework)
- [Element 5: Companion Method (Optional)](#element-5-companion-method-optional)
- [Element 6: Contamination Mitigation Strategy](#element-6-contamination-mitigation-strategy)
- [Element 7: Difficulty Calibration](#element-7-difficulty-calibration)
- [Design Document Template](#design-document-template)

Design the conceptual blueprint of a benchmark, its goals, scope, taxonomy, evaluation framework, and optional companion method. This is the architectural plan before any data is built.

## Element 1: Design Goals

Every benchmark should explicitly state its design goals. Use G1-G4 as a starting vocabulary, then merge, replace, or add goals as the domain requires:

| Goal | Description | Typical Strategy |
|------|-------------|-----------------|
| **G1: Coverage** | Benchmark covers the breadth of the target capability | Systematic taxonomy, diverse sources, stratified sampling |
| **G2: Fine-grained Diagnostics** | Can pinpoint WHERE models fail, not just IF | Multi-dimensional taxonomy with sub-categories and difficulty levels |
| **G3: Scalability** | Construction is reproducible and extensible at low cost | Automated/semi-automated pipeline, minimal manual annotation |
| **G4: Quality** | Annotations are accurate and evaluation is reliable | Multi-stage QC, inter-annotator agreement, expert validation |

Select the goals that affect this benchmark. Infer available answers from the artifacts; ask only for missing information that changes the design.

## Element 2: Task Scope

Clearly define the boundary. This pre-empts the reviewer question "why didn't you include X?"

```
Evaluates:
- [Capability 1]: [brief description]
- [Capability 2]: [brief description]
- ...

Does NOT evaluate (out of scope, with reason):
- [Excluded capability 1]: [why excluded, different research question, existing benchmarks already cover it, etc.]
- ...
```

## Element 3: Taxonomy Design

A taxonomy can clarify fine-grained evaluation when categories reflect the research question. The following are optional examples; do not require a full Cartesian product of cells:

### Pattern 1: Capability × Difficulty Matrix (StatQA)

```
Categories:  [Cat1] [Cat2] [Cat3] [Cat4] [Cat5]
                    ×
Difficulty:  [Easy] [Hard]
             ──────────
             = 10 evaluation cells
```

**Best for**: Tasks where capabilities are naturally categorical with clear difficulty gradients.

### Pattern 2: Phenomenon Type × Severity Spectrum (nvBench 2.0)

```
Types:    [Type1] [Type2] [Type3] [Type4]
                  ×
Severity: [Lv1] [Lv2] [Lv3] [Lv4] [Lv5]
          ──────────
          = 20 evaluation cells
```

**Best for**: Tasks studying a specific phenomenon (ambiguity, noise, bias) across intensity levels.

### Pattern 3: Multi-dimensional Quality Framework (VisJudge-Bench)

```
Top Dimensions:    [Fidelity] [Expressiveness] [Aesthetics]
                         ↓              ↓                  ↓
Sub-dimensions:    [Sub1.1] [Sub1.2] [Sub2.1] [Sub2.2] [Sub3.1] [Sub3.2]
                   ──────────
                   = 6 measurable sub-dimensions
```

**Best for**: Tasks where quality has multiple independent facets that interact.

Use an appropriate taxonomy when it improves measurement or interpretation; a continuous scaling study may need no categorical taxonomy.

## Element 4: Evaluation Framework

Beyond taxonomy, define HOW each dimension is measured:

| Sub-dimension | Metric | Scoring Method | Range | Automation |
|--------------|--------|---------------|-------|-----------|
| [SubDim 1] | e.g., Accuracy | Exact match | 0-1 | Fully auto |
| [SubDim 2] | e.g., Relevance | LLM-as-Judge | 1-5 | Semi-auto |
| [SubDim 3] | e.g., Naturalness | Human rating | 1-7 | Manual |

Conditional design decisions for ML or human-rated benchmarks:

| Decision | Options | Trade-off |
|----------|---------|-----------|
| **Auto vs. Human eval** | Automatic metrics / LLM-as-Judge / Human | Scale vs. reliability |
| **Single vs. Multi-answer** | One correct answer / Multiple valid answers | Simplicity vs. real-world fidelity |
| **LLM-as-Judge validation** | Correlation with human / Agreement rate | Provide task-relevant validation evidence and state its limits |
| **Scoring granularity** | Binary / Ordinal / Continuous | Discriminability vs. annotation difficulty |

## Element 5: Companion Method (Optional)

A companion method can answer a distinct question: "Can evidence from this benchmark guide model improvement?" It is not required for a complete benchmark paper and should be omitted when it would dilute construction or evaluation quality.

| Component | Question | Example |
|-----------|----------|---------|
| **Training signal** | What data does the benchmark uniquely provide? | Step-wise reasoning paths, preference pairs, fine-grained scores |
| **Optimization technique** | How is the signal used? | SFT, DPO, GRPO, RLHF, curriculum learning |
| **Value proposition** | Why is this better than training without the benchmark? | Targeted improvement on the specific blind spot |

Reference implementations:

| Paper | Training Signal | Method | Technique |
|-------|----------------|--------|-----------|
| nvBench 2.0 | Step-wise reasoning paths | Step-Text2Vis | Step-DPO preference optimization |
| VisJudge-Bench | Fine-grained quality scores | VisJudge | GRPO reinforcement learning |

Use this decision gate before adding the method:

- It answers a research question not already answered by the benchmark analysis.
- Its training resource is disjoint from the held-out evaluation split; a PDF or dataset label does not make train-test reuse acceptable.
- It includes unseen-split or external-benchmark evaluation, not only improvement on data derived from its own training signal.
- Its compute and page cost do not weaken the benchmark's central measurement or evidence.

A small fine-tuning result without these controls can create contamination or circular-evaluation concerns and should not be presented as a companion contribution.

## Element 6: Contamination Mitigation Strategy

For learned or tuned systems, address the applicable contamination mechanisms:

| Contamination Type | Risk | Mitigation |
|-------------------|------|------------|
| **Training contamination** | Evaluation items appear in model pretraining or adaptation data | Time-gated or newly collected sources, provenance records, deduplication or overlap tests, model-version cutoffs where relevant |
| **Companion-method leakage** | Held-out evaluation items or near-duplicates enter method training | Immutable split IDs, similarity-based deduplication across splits, separate training resource, external or unseen-split validation |
| **Prompt contamination** | Evaluation prompts leak into training or public tuning artifacts | Versioned prompt templates, private test prompts where justified, prompt-overlap checks |
| **Contamination laundering** | Using synthetic data from contaminated models to generate "new" data | Verify data provenance, cross-validate with non-LLM sources |
| **Benchmark saturation** | Models overfit to benchmark style over time | Design for extensibility, include version-control plan |

## Element 7: Difficulty Calibration

Do not impose a universal target accuracy. A useful launch benchmark should avoid both floor and ceiling effects, separate meaningfully different systems, and preserve headroom relative to a justified human or expert reference. The appropriate range depends on the metric, chance level, task cost, and intended use.

Include a difficulty sanity check:

- Estimate chance, weak-baseline, current-best, and human or expert performance where meaningful.
- Inspect score spread and confidence intervals, not only the top-model score.
- Add or rebalance harder subsets when most relevant systems saturate; simplify or stratify when all systems collapse to chance.
- Explain the desired longevity and what evidence would falsify the calibration assumptions.

Very low hardest-subset accuracy can be a useful stress-test heuristic in some generative tasks, but it is not a general benchmark requirement.

## Design Document Template

Use relevant fields of this optional template only when a design document is requested or useful. Omit ML-specific fields and fixed goal labels that do not apply:

```
Benchmark Name: [Name]
Gap Statement: [From the gap statement in gap-analysis.md]
Research Questions: [RQ1, RQ2, RQ3]

Design Goals:
  G1 (Coverage): [Strategy]
  G2 (Diagnostics): [Strategy]
  G3 (Scalability): [Strategy]
  G4 (Quality): [Strategy]

Task Scope:
  In-scope: [List]
  Out-of-scope: [List with reasons]

Taxonomy:
  Pattern: [1/2/3]
  Dimensions: [List]
  Sub-dimensions: [List]
  Total evaluation cells: [N]

Evaluation Framework:
  [Table of metrics per dimension]

Companion Method (optional):
  Training signal: [What]
  Technique: [How]
  Split isolation: [How training data is kept disjoint from held-out evaluation]
  Generalization check: [Unseen split or external benchmark]

Contamination Mitigation:
  Strategy: [How you prevent data leakage]

Difficulty Calibration:
  Chance / weak baseline: [Value and rationale]
  Expected current-best range: [Range and rationale]
  Human or expert reference: [Value or N/A with reason]
  Floor / ceiling checks: [Evidence]
```
