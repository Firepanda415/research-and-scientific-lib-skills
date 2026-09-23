# Benchmark Gap Analysis

Identify what a better measurement or comparison would resolve. The need may be missing coverage, unreliable measurement, a new regime, or an unresolved comparison; it need not be a previously unmeasured capability.

## Step 1: Survey the Evaluation Landscape

Map the closest relevant existing work. Use a comparison table when the distinctions are easier to inspect than in prose; it need not become Table 1:

| Dimension | Benchmark A | Benchmark B | Benchmark C | ... | Gap |
|-----------|------------|------------|------------|-----|-----|
| Task scope | | | | | |
| Data scale | | | | | |
| Evaluation dimensions | | | | | |
| Granularity level | | | | | |
| Real-world alignment | | | | | |
| [Key differentiator] | | | | | |

Fill each cell from the cited source. Use ✓, partial, or ✗ as the evidence supports, and never pre-fill a column.

Answer these questions from the available sources. Ask the user only for what the sources cannot determine:
- What mainstream benchmarks already exist in this area, and what does each one evaluate?
- What implicit assumption do they share, and does that assumption hold in realistic scenarios?
- If a model scored perfectly on every existing benchmark, would it really have mastered the underlying capability?

## Step 2: Identify the Blind Spot

Explain the scientific consequence of the gap. More data or larger instances can be valuable when they resolve a coverage, precision, or scaling question. The example summaries are illustrative, so verify each one in its paper before citing it. Useful example patterns include:

### Pattern A: Dimension Blindness
Existing benchmarks measure capability X but completely ignore related capability Y.

> **StatQA example**: Math reasoning benchmarks test whether models can compute correct answers, but completely ignore whether models can select the appropriate statistical method. A model that applies the wrong test but computes correctly would score perfectly, yet its reasoning is fundamentally flawed.

### Pattern B: Assumption Violation
Existing benchmarks share an implicit assumption that does not hold in real-world scenarios.

> **nvBench 2.0 example**: The benchmarks examined assume each natural language query maps to exactly one correct visualization. In practice, real queries are inherently ambiguous, "show sales trends" could reasonably produce a line chart, bar chart, or area chart. Current benchmarks penalize valid alternative interpretations.

### Pattern C: Evaluation Granularity Mismatch
Existing evaluation is too coarse to diagnose specific failure modes.

> **VisJudge-Bench example**: Existing visualization evaluation checks surface aesthetics OR information accuracy in isolation. But real quality requires the interplay of Fidelity, Expressiveness, and Aesthetics. A chart can be beautiful but misleading, or accurate but incomprehensible.

**Useful questions, answered from available evidence when possible:**
- Which gap pattern does the observed blind spot most resemble? (Dimension Blindness, Assumption Violation, or Granularity Mismatch)
- Can the user cite a concrete failure case where existing evaluation misses the real problem?

## Step 3: Validate the Gap

Consider the questions relevant to the proposed contribution:

- [ ] **Scientific value**: Resolving the measurement question would change understanding or capability
- [ ] **Assessable**: The proposed measurement or evidence can answer the question
- [ ] **Existing alternatives**: A simple extension may be sufficient; explain why it does or does not answer the question
- [ ] **Implication**: The result has a clear interpretation, even if it does not immediately improve a model

Investigate a missing answer when it affects the claimed value or validity; an inapplicable question is not a failure.

## Step 4: Articulate the Gap Statement

Draft a concise gap statement. For an assumption-violation contribution, this structure may help:

> **The closest benchmarks for [TASK], [CITED SET], focus on [WHAT THEY MEASURE], operating under the assumption that [IMPLICIT ASSUMPTION]. However, in real-world scenarios, [WHY THE ASSUMPTION FAILS]. This creates a critical evaluation blind spot: [SPECIFIC CAPABILITY THAT CANNOT BE EVALUATED], meaning that [CONSEQUENCE, what can go wrong with models that appear to perform well].**

The useful properties are:
- **Specific**, names the exact blind spot, not a vague "limitation"
- **Supported**, accurately describes relevant existing work
- **Consequential**, explains the scientific or practical effect of resolving the gap

## Step 5: Derive Research Questions

Explicit Research Questions are optional. If useful, derive them from the actual measurement question. The following ML-oriented examples are candidates, not required coverage:

| Coverage Area | RQ Template | Purpose |
|--------------|-------------|---------|
| **Benchmark construction** | How should we design a benchmark to systematically evaluate [the blind spot]? | Justify design choices |
| **Model capability boundary** | To what extent do current models fail on [the blind spot], and what sub-capabilities differentiate strong vs. weak models? | Establish severity + enable diagnosis |
| **Human-model gap** | How do models compare with human experts on [this dimension], and what factors (scale / prompting / domain knowledge) affect the gap? | Ground truth + actionable insights |

Typical RQ examples:

| RQ | Template | Maps to |
|----|----------|---------|
| RQ1 | To what extent do current models fail on [the blind spot]? | Experiments, Overall Performance subsection |
| RQ2 | What specific sub-capabilities differentiate strong vs. weak models in [this dimension]? | Experiments, Fine-grained Analysis subsection |
| RQ3 | How does [factor: model scale / prompting / domain knowledge] affect performance, and how do models compare with human experts? | Experiments, factor analysis and Human vs. Model subsections |

Choose analyses that answer the actual question (see [experiments.md](experiments.md)). Several questions may share an analysis, and a human comparison is relevant only in settings that need it.
