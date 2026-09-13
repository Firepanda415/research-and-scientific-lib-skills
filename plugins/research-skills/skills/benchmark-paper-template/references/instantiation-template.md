# Benchmark Paper Instantiation Template

## Table of contents

1. Basic information and core evaluation definition
2. Gap analysis and research questions
3. Benchmark design and construction pipeline
4. Dataset characteristics and expected findings
5. Running example and contamination mitigation
6. Experiment plan
7. Figure and table plan


Use this template to concretize your benchmark idea before writing. Fill in each section through discussion.

## 1. Basic Information

| Field | Your Answer |
|-------|-------------|
| **Benchmark Name** | |
| **Target Domain** | |
| **Target Venue** | |
| **Target Submission Date** | |

## 2. Core Evaluation Definition

| Field | Your Answer |
|-------|-------------|
| **Core capability/dimension to evaluate** (one sentence) | |
| **What makes your evaluation definition unique** vs. existing benchmarks? | |
| **Sub-dimensions** in your evaluation framework | |

## 3. Gap Analysis (see `references/gap-analysis.md`)

| Field | Your Answer |
|-------|-------------|
| **Existing Benchmarks** (closest relevant set; justify coverage) | |
| **Their Shared Assumption** | |
| **The Blind Spot** | |
| **Gap Pattern** (Dimension Blindness / Assumption Violation / Granularity Mismatch) | |
| **Gap Statement** (2-3 sentences) | |
| **Concrete Failure Example** | |

## 4. Research Questions

The example mappings below assume a standalone companion method in
§3. If it is absent, shift the experiment references to §3 and keep
all downstream numbering consistent.

| RQ | Question | Mapped to Section |
|----|----------|------------------|
| RQ1 | | Experiments §__ |
| RQ2 | | Experiments §__ |
| RQ3 | | Experiments §__ |

## 5. Benchmark Design (see `references/benchmark-design.md`)

### Design Goals

| Goal | Strategy |
|------|----------|
| G1 (Coverage) | |
| G2 (Fine-grained) | |
| G3 (Scalability) | |
| G4 (Quality) | |

### Task Scope

| In Scope | Out of Scope (with reason) |
|----------|---------------------------|
| | |
| | |

### Taxonomy

| Pattern | Chosen: 1 / 2 / 3 |
|---------|-------------------|
| **Dimension 1** | Sub: |
| **Dimension 2** | Sub: |
| **Dimension 3** | Sub: |
| **Total cells** | |

### Evaluation Framework

| Sub-dimension | Metric | Scoring | Range | Auto/Human |
|--------------|--------|---------|-------|-----------|
| | | | | |
| | | | | |

### Companion Method (Optional)

| Field | Your Answer |
|-------|-------------|
| Training Signal | |
| Optimization Technique | |
| Expected Improvement | |
| Held-out Evaluation Isolation | |
| Unseen-Split or External Validation | |

## 6. Construction Pipeline (see `references/construction-pipeline.md`)

| Field | Your Answer |
|-------|-------------|
| **Paradigm** (Reverse Synthesis / Controlled Injection / Adaptive Generation) | |
| **Data Source** | |
| **Target Scale** | |
| **Biggest Construction Challenge** (data scarcity? subjective annotation? ambiguity? cost?) | |
| **Pipeline Core Innovation** | |

### Pipeline Steps

| Step | Input | Operation | Output | QC Gate |
|------|-------|-----------|--------|---------|
| 1 | | | | |
| 2 | | | | |
| 3 | | | | |
| 4 | | | | |
| 5 | | | | |

## 7. Dataset Characteristics

| Field | Your Answer |
|-------|-------------|
| **Scale** (samples, splits, domains) | |
| **Difficulty levels** | |
| **Rich metadata / reasoning paths** for deep evaluation | |
| **Key comparison dimensions** with existing benchmarks | |

## 8. Expected Findings (预期洞察)

| Field | Your Answer |
|-------|-------------|
| **What difficulties will SOTA models face?** | |
| **Where will model errors concentrate?** | |
| **Expected human-model performance gap** | |

## 9. Running Example Design (Figure 1)

| Field | Your Answer |
|-------|-------------|
| **What concrete example will Figure 1 show?** | |
| **Does it simultaneously illustrate** existing method limitations AND your benchmark's value? | |

## 10. Contamination Mitigation

| Field | Your Answer |
|-------|-------------|
| **How do you prevent training data leakage?** | |
| **Data provenance verification strategy** | |
| **How is companion-method training kept disjoint from evaluation items and near-duplicates?** | |

## 11. Experiment Plan (see `references/experiments.md`)

### Baseline Models

| Model | Type | Scale | Why Include |
|-------|------|-------|------------|
| | | | |
| | | | |

### Analysis Plan

| RQ | Hypothesis | Analysis Type | Visualization |
|----|-----------|--------------|---------------|
| RQ1 | | | |
| RQ2 | | | |
| RQ3 | | | |

## 12. Figure & Table Plan

Positions below are illustrative. Use the current venue template and update section/table numbering if the optional companion-method section is omitted.

| Item | Content | Position |
|------|---------|----------|
| Figure 1 | Running Example: | Page 1-2 |
| Table 1 | Benchmark Comparison: | Page 2-3 |
| Figure 2 | Pipeline: | Page 3-4 |
| Table 2 | Statistics: | Page 4-5 |
| Table 3 | Overall Performance: | Page 6-7 |

## Reference Case Studies

For inspiration, consult these three published benchmark papers:

### StatQA (NeurIPS 2024)
- **Gap**: Math benchmarks test computation but ignore statistical method selection
- **Paradigm**: Reverse synthesis (answer-first)
- **Taxonomy**: 5 categories × 2 difficulty levels
- **Key Finding**: Models compute correctly but choose wrong statistical methods

### nvBench 2.0 (NeurIPS 2025)
- **Gap**: Text2VIS benchmarks assume single correct answer, ignoring query ambiguity
- **Paradigm**: Controlled ambiguity injection
- **Taxonomy**: 4 ambiguity types × 5 severity levels
- **Companion Method**: Step-Text2Vis (Step-DPO)
- **Key Finding**: All models struggle with ambiguous queries, even with explicit disambiguation prompts

### VisJudge-Bench (ICLR 2026)
- **Gap**: Evaluation checks aesthetics OR accuracy, not their interplay
- **Paradigm**: Adaptive generation + 3-stage expert annotation
- **Taxonomy**: 3 dimensions (信达雅) → 6 sub-dimensions
- **Companion Method**: VisJudge (GRPO)
- **Key Finding**: Models excel at surface aesthetics but fail at fidelity-expressiveness balance
