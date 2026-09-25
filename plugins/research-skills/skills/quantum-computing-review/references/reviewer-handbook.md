# Peer Review Handbook for Technical Manuscripts

## Contents

1. Purpose
2. Non-Negotiable Gate: Journal Policy, Confidentiality, and Conflicts
3. Review Modes
4. Required Inputs
5. Mandatory Repository Discovery and Code/Data Audit
6. Core Stance
7. Mandatory Manuscript-Location Protocol
8. Core Procedure (Steps 0 to 12, for every manuscript)
9. Quantum Module (only for a contribution involving quantum computing or quantum technology)
10. Writing the Referee Report
11. Output Matched to the Request
12. Failure Modes
13. Completion Check

## Purpose

This handbook supports **journal peer review of another author's technical manuscript in any field**. The Core Procedure applies to every manuscript. The Quantum Module adds checks when the manuscript's contribution involves quantum computing or quantum technology. The handbook helps the reviewer determine:

1. what the paper actually claims;
2. which evidence supports each claim;
3. whether the component credited with the reported result is necessary for it;
4. whether comparisons and resource accounting are fair;
5. what is genuinely new relative to prior work;
6. whether the problems are repairable within revision;
7. what recommendation follows from the technical record.

The review should produce a report that is useful to both the editor and the authors. It should not merely list weaknesses, repeat the abstract, or reward a paper for using a new method, model, or platform, such as quantum hardware, without establishing what it adds.

---

## Non-Negotiable Gate: Journal Policy, Confidentiality, and Conflicts

Run this gate **before processing a confidential manuscript**.

1. Identify the journal, article type, review model, and current reviewer policy.
2. Check the journal's current rules on:
   - confidentiality;
   - use of generative AI or external tools during peer review;
   - required disclosure of tool assistance;
   - transparent peer review;
   - conflicts of interest;
   - consultation or co-review with another person.
3. If the venue forbids uploading manuscripts to generative AI or permits only an
   approved secure tool, stop and tell the user to follow the venue policy. Do not
   assume that later disclosure cures prohibited use.
4. If AI assistance is allowed only with disclosure, flag the required disclosure
   before beginning.
5. Do not use unpublished manuscript content for the reviewer's own research.
6. Do not contact the authors directly; route questions through the editor.
7. If there is a possible personal, financial, institutional, collaborative,
   competitive, or intellectual conflict, advise the user to contact the editor.
8. Under double-anonymous review, do not try to identify the authors, and route
   identity questions to the editor. The first gate in [SKILL.md](../SKILL.md) lists
   what this excludes.

Check the current official policy before processing any confidential manuscript, including for a focused question or a later review round. Reuse policy evidence already checked for the same assignment unless its currency or applicability is uncertain.

---

## Review Modes

Choose the mode before starting.

### Mode A: Full Initial Referee Review

Use for a new manuscript and its Supplementary Information.

### Mode B: Crosscheck an Existing Review

Use when the user supplies feedback from another reviewer, model, colleague, or
prior draft. Verify every substantive point independently before absorbing it.

### Mode C: Revised Manuscript and Rebuttal

Track each original concern against the authors' response, changed manuscript,
new evidence, and residual issue. Do not reopen unrelated issues unless the revision
creates them or the original review clearly missed a load-bearing problem.

### Mode D: Adjudication

Use when two reports disagree. Identify the exact disputed claim, assumptions,
evidence, and decision consequence rather than averaging the recommendations.

### Mode E: Expertise-Bridge Review

Use when the reviewer is strong in one field or subfield but weaker in the paper's
source discipline. Build private prerequisite notes and translate notation or
assumptions into the reviewer's background. Do not mistake unfamiliarity for a flaw,
and do not put tutorial notes into the submitted report.

---

## Required Inputs

Use as many as are available:

- main manuscript;
- Supplementary Information and extended data;
- journal and article type;
- editor's referral questions;
- cited code, data, repositories, and documentation;
- closest prior work, especially work from the same author group;
- public preprints and final published versions of cited work;
- author rebuttal and tracked changes for a revision;
- an existing review to crosscheck, if applicable;
- the reviewer's expertise boundary;
- desired output: private analysis, comments to authors, confidential comments,
  recommendation, or all of these.

If essential material is absent, distinguish **not provided**, **not found**, and
**not verifiable**. Do not silently fill gaps with assumptions.

---

## Mandatory Repository Discovery and Code/Data Audit

For a computational manuscript, do this **before** writing any claim that code, data,
configs, or implementation details are missing. A repository is also evidence about the
method itself, not only about reproducibility.

Under double-anonymous review, skip every identity-seeking step in this section. Make no search for the repository or the manuscript, do not attribute a repository or dataset to its owner, and do not record or use an identity that an opened link reveals. The first gate in [SKILL.md](../SKILL.md) states the full rule. In `confidential-no-egress` mode, open an author-supplied link only when venue policy permits reviewers to access such links with the tools in use. Otherwise record the link as present but not inspected, so that the human reviewer can inspect it.

### 1. Actively discover repository and data links

Search every supplied file, including the main manuscript, Supplementary Information,
extended data, appendices, cover letter, rebuttal, and text attachments, for:

- `github.com`, `gitlab.com`, `bitbucket.org`, and project-homepage URLs;
- Zenodo, OSF, Figshare, Dryad, institutional repositories, and DOI-based archives;
- Code Availability and Data Availability statements;
- links in references, footnotes, captions, author notes, and supplementary tables;
- PDF hyperlink annotations or embedded URLs when the available tools expose them.

If the paper states that code is public but no explicit URL is recoverable, first confirm
that the manuscript or preprint is public and that venue policy permits external lookup.
Only then search using public metadata, and never under double-anonymous review.
In confidential-no-egress mode, never send an
unpublished title, author list, project acronym, unique phrase, or manuscript excerpt to
an external search service. Do not identify a same-name repository as the paper repository
without confirming its owner, README, citation, authors, or project description.

Record one of four outcomes privately: **explicit link found**, **repository found by
verified search**, **claimed public but not found**, or **not claimed**.

### 2. Verify repository identity and access

For every credible repository or archive, check:

- owner and connection to the authors or institution, except under double-anonymous review;
- manuscript title, acronym, citation block, or DOI;
- public/private status and whether links actually open;
- default branch, latest commit, tags, releases, archive DOI, and license;
- whether the repository state plausibly corresponds to the reviewed manuscript version.

Use a frozen commit, tag, release, or archive DOI when citing repository evidence. If only
the live default branch is available, record the commit hash inspected.

### 3. Inspect the repository as technical evidence

At minimum inspect the README, repository tree, environment file, core implementation,
entry-point scripts, configs, datasets, figure-generation code or notebooks, and hardware
execution files relevant to the paper's central claims. Check for:

- consistency between equations, pseudocode, and implemented control flow;
- hidden defaults, approximations, preprocessing, postprocessing, and stopping rules;
- optimizer settings, restarts, sample or shot counts, seeds, and hardware backends;
- whether claimed hardware or quantum steps are actually executed or replaced by simulation;
- whether baselines receive comparable settings and resources;
- whether posted data are the exact result-generating inputs/outputs or only examples;
- whether figures and tables can be traced to scripts, configs, and raw outputs;
- bugs, indexing mismatches, nondeterministic seeding, or undocumented behavior that
  changes the interpretation of the method;
- repository evidence that resolves, weakens, or strengthens a manuscript criticism.

A repository can corroborate implementation details and expose inconsistencies, but code
availability alone does not validate numerical results, hardware runs, or claimed speedup.

### 4. Calibrate repository-based comments

- Never state that code or data are absent before completing the discovery step.
- If code/data are present, acknowledge them and narrow any criticism to traceability,
  completeness, exact replay, or manuscript-code consistency.
- If only example or representative instances are posted, do not call them the exact
  benchmark data unless the repository makes that mapping explicit.
- If the repository resolves a concern, remove or narrow the concern rather than keeping
  it as a generic reproducibility request.
- If a technical comment relies on code, give a repository locator: commit/tag plus path
  and line range, function, notebook cell, config key, or dataset record.
- Include repository evidence needed to support a concern. Keep a comprehensive private record when requested, without duplicating the report by default.

---

## Core Stance

1. **Review claims, not topics.** An important topic does not make the evidence
   sufficient.
2. **Separate usefulness from claim validity.** A method can be useful as batching,
   workflow integration, or proof of compatibility even when a speedup claim fails.
3. **Separate involvement from contribution.** Using a new component, such as a
   learned model, a new solver, or a circuit run on a QPU, does not show that the
   component improves quality, scaling, or cost.
4. **Use the strongest structure-aware alternative explanation.** Do not compare a
   structured method only with a deliberately generic alternative, such as a
   structured circuit with a generic simulator.
5. **Test the titled novelty.** Replace or remove the claimed new component while
   keeping the surrounding workflow fixed.
6. **Treat prior-work overlap precisely.** Properly cited inherited infrastructure,
   an established testbed, or a non-core method is usually not a publication problem.
7. **Do not infer misconduct from similarity.** Escalate only when there is specific
   evidence of undisclosed reuse, misleading novelty claims, or duplicate central
   results.
8. **Calibrate the recommendation by fixability and centrality.** Count neither
   comments nor requested experiments mechanically.
9. **Prefer one decisive test per issue over a diffuse request.** Ask for the smallest
   experiment or derivation that resolves the central alternative explanation. This rule
   controls the revision requested within each comment; it must not be used to suppress
   other independently valid findings from the candidate review supplied to the user.
10. **Make every criticism locatable.** A numbered object is preferred; otherwise use
    page + section/subsection + paragraph ordinal and an opening-phrase anchor.
11. **Use public code and data as evidence.** Actively find and inspect linked repositories
    before judging reproducibility or implementation credibility, as far as the
    confidentiality mode and review model allow.
12. **The human reviewer remains accountable.** Every equation, citation, comparison,
    locator, repository finding, and recommendation must be checked by the reviewer.

---

## Mandatory Manuscript-Location Protocol

Every substantive criticism in the **submitted review itself** must be locatable by the
authors and editor. A location recorded only in private verification notes is not enough.
This requirement applies equally to:

- major comments;
- minor comments;
- confidential technical comments to the editor;
- cross-paper overlap claims;
- inconsistencies between the main text and Supplementary Information;
- comments about code or repository behavior.

A comment is not submission-ready until it contains the minimum locator below.

### Locator Hierarchy

Use the most specific available locator.

1. **Numbered manuscript object**

   Give the document, page, section or subsection, and object identifier:

   ```text
   Main text, p. 7, Sec. 2.3, Eq. (12)
   Main text, p. 9, Sec. 2.4, Fig. 3b and its caption
   Supplementary Information, p. 4, Supplementary Note 4, Eq. (11)
   Main text, p. 18, Methods Sec. 4.3, Algorithm 1, lines 17-20
   ```

2. **Unnumbered prose claim or methodological statement**

   Give at least the document, page, section or subsection, and paragraph ordinal. Add
   the sentence number or opening words when useful:

   ```text
   Main text, p. 5, Sec. 2.3, para. 2, first sentence
   Main text, p. 3, Introduction, para. 3, beginning “We demonstrate...”
   Supplementary Information, p. 3, Supplementary Note 3, para. 1
   ```

   Paragraphs are counted within the named section or subsection as rendered in the PDF;
   headings are not paragraphs. If layout makes the ordinal ambiguous, include a short
   opening-phrase anchor.

3. **Abstract, title, caption, footnote, or unnumbered display**

   Name the object and page, then identify the sentence or displayed expression:

   ```text
   Abstract, p. 1, sentence 4
   Fig. 2 caption, p. 7, final sentence
   Main text, p. 6, Sec. 2.3, unnumbered display after para. 1
   ```

4. **Code, data, or repository issue**

   Give the frozen version or commit when available, followed by file path and line,
   function, notebook cell, configuration key, or dataset record:

   ```text
   Commit abc123, src/solver.py, lines 84-101
   notebooks/hardware.ipynb, cell 17
   config/backend.yaml, keys shots and optimization_level
   ```

### Location Rules

- If printed manuscript page numbers differ from PDF page indices, state both, for
  example, `PDF p. 9 / manuscript p. 7`.
- If one concern depends on several locations, cite every load-bearing location rather
  than only the first occurrence.
- For a repeated technical, notation, or non-searchable writing problem, cite the first
  occurrence and enough additional examples to establish the pattern.
- For a **typo-only** comment, exact searchable strings and their corrections are enough;
  page numbers or representative locations are unnecessary because the authors can use
  Ctrl+F. Add a location only when the string is ambiguous, non-searchable, or appears in
  an equation, symbol, image, or generated figure.
- Do not write vague comments such as “throughout the manuscript,” “the Methods are
  unclear,” or “there are many language issues” without identifying the exact problem.
- Do not fabricate an equation, line, or paragraph number. When exact numbering is
  unavailable, use page + section + paragraph ordinal + opening-phrase anchor.
- A general methodological concern still needs a manuscript anchor showing where the
  method or claim is stated.
- In the default submission style, integrate the locator naturally into the first sentence
  of the comment, for example: `In Sec. 4.3 (pp. 14–17, especially Algorithm 1), ...`.
  Do not use a long bracketed locator as the comment title unless the user asks for it.

### Location-Aware Comment Skeleton

Use a short substantive heading, then place the location in the opening sentence.

```markdown
### 1. The stated scaling claim is not supported by the comparison

In Sec. 2.3 (pp. 5–8, especially Fig. 2c) and Sec. 4.4 (pp. 18–19,
Eqs. (14)–(20)), ...
```

For a non-typo minor comment:

```markdown
1. **Main p. X, Sec. Y, Eq. (Z).** Please correct ... .
```

For searchable typos:

```markdown
6. Typos: “an high-performance” -> “a high-performance”; “Eaxmple” -> “Example”.
```

---

## Core Procedure

These steps apply to every manuscript. When the contribution involves quantum computing or quantum technology, the Quantum Module after Step 12 adds checks to Steps 1, 3, 4, 5, 6, and 8 and supplies the quantum-subfield modules.

### Step 0: Establish Venue Standard and Scope

Record privately:

```text
Journal:
Article type:
Scope criterion:
Expected novelty/significance level:
Technical-validity threshold:
Reviewer-policy status:
Conflict-of-interest status:
Editor-specific questions:
```

Do not apply the standards of a broad letters journal, a selective flagship journal, and a specialist journal interchangeably. A technically valid incremental paper may be publishable in one venue and below the expected advance in another.

---

### Step 1: Reconstruct the Paper Before Critiquing It

Write a compact end-to-end map:

```text
Scientific or engineering problem
→ mathematical formulation or model
→ data, inputs, or experimental setup
→ method, algorithm, or apparatus
→ outputs and postprocessing
→ final scientific or computational result
→ claimed contribution or advantage
```

For a quantum manuscript, expand the method stages with the Quantum Module's Quantum Paper Map.

Then identify:

- the **title-level novelty**;
- every **load-bearing claim**, meaning each claim that the title, abstract, or
  conclusions depend on;
- the strongest result;
- the weakest necessary link in the argument;
- the component credited with the main result, and what remains if it is removed;
- what remains if the allegedly new component is replaced by the prior method.

Do not start writing the final report until this map is internally consistent.

### Coverage Matched to the Claims

For a full review, inspect claim attribution, numerical evidence, and application interpretation where relevant. These dimensions can share one evidence pass. In revision, inspect the original concerns and changed or newly introduced claims without reopening unrelated settled issues.

A requested comprehensive audit covers all relevant dimensions even when the recommendation is already clear. A focused crosscheck stays focused. Record material unresolved questions, but do not require separate pass forms or a ledger for every routine check.

### Step 2: Build a Claim-Evidence Ledger

Track each load-bearing claim against its evidence. Use a ledger when the number of claims or requested audit depth makes it useful; the following format is optional.

| ID | Exact claim and full manuscript locator | Evidence supplied and locator | What the evidence actually establishes | Main alternative explanation | Status | Required action |
|---|---|---|---|---|---|---|
| C1 | page + section + object or paragraph anchor | theorem / simulation / hardware / benchmark / application, with location | ... | ... | ... | ... |

Use the following status labels:

- **Supported**
- **Supported under a narrower scope**
- **Demonstration only**
- **Plausible but unisolated**
- **Unsupported by the present evidence**
- **Contradicted by the method or data**
- **Not verifiable from supplied material**

For each claim, distinguish:

- definition;
- exact identity;
- theorem;
- approximation;
- heuristic;
- empirical observation;
- implementation result;
- author interpretation;
- reviewer inference.

A citation is not evidence until the cited source is inspected and shown to entail the
claim. Every claim and evidence entry must follow the Mandatory Manuscript-Location
Protocol; section names alone are insufficient for unnumbered prose.

---

### Step 3: Perform the Mathematical and Structural Audit

#### 3.1 Correctness and Assumptions

Check:

- definitions and domains;
- normalization and sign conventions;
- hidden regularity, oracle, noise, or independence assumptions;
- exact identities versus approximations;
- theorem hypotheses and quantifiers;
- asymptotic regime and constants;
- error composition and success probability;
- consistency between main text, Methods, Supplementary Information, and pseudocode.

When a derivation is central, reconstruct the decisive steps. For a suspected sign, factor, index, or notation error, identify the intended convention and propagate the smallest plausible correction through dependent equations, algorithms, and results. A local typo leaves the scientific conclusion intact after correction. If that consequence is unverified, state the uncertainty. Do not call an error fatal merely because the displayed equation is false, or harmless merely because its repair looks small. Paper-based implementation must resolve the discrepancy before using the equation, even if its referee severity is Minor.

#### 3.2 Structural Simplifications

Before accepting a simulation, scaling, or speedup comparison, test whether the object
has exploitable structure:

- separability into independent parts;
- block diagonalization;
- commuting terms;
- symmetry sectors and conserved quantities;
- low rank or low treewidth;
- repeated identical subproblems;
- independent batched instances.

When such structure exists, compare against a method that exploits it, such as independent or batched solution of the parts, and not only against a monolithic representation. The construction may still demonstrate throughput, integration, or compatibility, so the review should invalidate only the unsupported claim. For quantum objects, the Quantum Module's Quantum Structural Simplifications lists further structure and gives a worked example.

#### 3.3 Metric Validity

Inspect the metric when an optimization or benchmark conclusion depends on an objective-derived scalar, normalized score, ranking, or aggregate summary.

Let $f(x)$ be an objective to be minimized. The transformation

$$
f'(x)=a f(x)+b,
$$

where $a>0$ preserves minimizers, but need not preserve the meaning of an approximation ratio. First identify the units, zero, and transformations admissible for the claimed metric. Apply the same reasoning to maximization with the direction explicit.

Check all of the following:

1. **Convention test.** Require invariance only under transformations that preserve the metric's meaning. Ratios of energies with arbitrary zero need origin-sensitivity analysis. A standard approximation ratio for a nonnegative cost with meaningful zero need not be shift-invariant. For example, costs 2 and 1 give ratio 2, while adding 100 gives 102/101; preserving minimizers does not make those ratio claims equivalent. A dimensional gap may rescale with units.
2. **Sign and zero test.** Verify behavior for negative, zero, mixed-sign, and near-zero
   objectives. State whether “larger,” “smaller,” or “closer to one” is actually better.
3. **Reference-independence test.** Identify whether the reference is an exact optimum,
   certified bound, independently fixed target, external baseline, or the best value observed
   among the evaluated methods. A method under evaluation must not help define its own
   denominator without an explicit circularity caveat.
4. **Cross-instance test.** Check whether averaging across instances or sizes gives arbitrary
   weight to instances because of scale, sign, denominator size, or missing exact optima.
5. **Distribution test.** Require seeds or instances, uncertainty, tails, failures, and the
   distinction between best-run, mean, median, expected, and success-probability results.
6. **Target test.** For time-to-target or success probability, verify that the target and
   tolerance were fixed independently of the solver outcomes.

For example, the ratio

$$
R=\frac{E_{\mathrm{solver}}}{E_{\mathrm{best}}}
$$

changes under the equivalent shift $E\mapsto E+b$ and can reverse intuitive interpretations
for negative or near-zero energies. It does not by itself support an accuracy claim. Depending
on what is known, prefer raw objective distributions on the same instance, absolute optimality
gaps, certified gaps, shift-invariant normalized gaps with independently fixed references,
success probability at a predefined threshold, or time-to-target.

If a metric concern needs a detailed record, use:

```text
Metric and optimization direction:
Reference or denominator source:
Admissible conventions and verdict:
Negative/zero verdict:
Cross-instance aggregation verdict:
Uncertainty reported:
Claim that survives:
Required reanalysis, if any:
```

If a central figure uses an invalid metric but the underlying raw results are available, request
reanalysis and narrow the affected claims. Do not automatically treat the entire method as invalid.

#### 3.4 Finite-Shot Decoder and Product-Distribution Scaling: Hard Gate

Complete this gate whenever a reported result is extracted from a finite number of samples (shots, on quantum hardware) and depends on a decoder, selected bitstring, marginal estimate, postselection rule, or blockwise readout. Samples from a quantum device, an annealer or Ising machine, or a probabilistic or Monte Carlo sampler all qualify.

First identify the exact decoder:

- most frequent global bitstring;
- best observed sample under the objective;
- per-block marginal mode;
- bitwise majority or marginal threshold;
- expectation-based estimator;
- feasibility repair or postselected sample;
- another explicitly defined rule.

Then determine which joint correlations the decoder preserves or discards and whether the rule
matches the claimed output. A marginal decoder may be statistically stable but inappropriate
when the objective requires joint correlations. A global-mode decoder may preserve a joint
assignment but become statistically fragile for independent workloads.

For an exact product distribution over $m$ independent blocks,

$$
P(z_1,\ldots,z_m)=\prod_{k=1}^{m}P_k(z_k),
$$

let

$$
p_k=\max_{z_k}P_k(z_k)
$$

be the modal probability of block $k$. The probability of the global modal string is

$$
p_{\mathrm{joint}}=\prod_{k=1}^{m}p_k.
$$

If $p_k\approx p<1$, then $p_{\mathrm{joint}}\approx p^m$. With $S$ shots, the expected
number of occurrences of that string is $S p_{\mathrm{joint}}$. Merely expecting one
occurrence therefore requires $S$ on the order of $1/p_{\mathrm{joint}}$, while reliable
mode identification may require more shots depending on the probability gap to competing
strings. Do not infer a precise sample complexity without analyzing that gap.

When factorization or batching supports a throughput or scaling claim, require the authors to:

1. state the decoder and shot count at every scale;
2. report the selected string's empirical probability or the relevant marginal confidence;
3. distinguish exact factorization from approximate independence;
4. compare the intended decoder with an appropriate structure-aware decoder using the same
   raw samples when this changes the scaling interpretation;
5. report ties, failures, postselection losses, and uncertainty;
6. verify that any aggregation step does not silently erase the correlations attributed to
   the sampled state, such as a quantum state.

Record the gate privately:

```text
Sampled object and factorization status:
Decoder:
Correlations retained or discarded:
Shots and selected-output probability:
Scaling verdict:
Structure-aware alternative checked:
Claim that survives:
```

---

### Step 4: Isolate the Claimed Contribution

Ask the central counterfactual:

> If the component credited with the improvement were replaced while every surrounding
> component remained fixed, would the claimed improvement survive?

Decompose the method into:

- problem formulation;
- decomposition or instance selection;
- the credited component, such as a model, solver, circuit, or device;
- optimizer;
- sampling rule;
- aggregation or decoding;
- local improvement or postprocessing heuristics;
- multi-start or parallel execution;
- application model or surrogate.

For any local or block subroutine embedded in a global objective, perform an embedded
local-objective check. Let $F(x)$ be the global objective, let $S$ be the selected variables,
let $\bar S$ be their complement, let $z$ be a candidate assignment on $S$, and let
$x_{\bar S}$ be the current outside assignment. Distinguish:

- an induced local objective $F^{\mathrm{ind}}_S(z)$ that keeps only terms wholly contained
  in $S$; and
- the conditional global objective

  $$
  F^{\mathrm{cond}}_S(z;x_{\bar S})=F(z,x_{\bar S}),
  $$

  which retains the effect of cross-boundary terms after the outside variables are fixed.

Check which objective the local solver actually optimizes, which objective the aggregation
rule evaluates, and whether dropped cross-boundary terms change the ranking of local proposals.
The matched replacement ablation must use the same local objective as the submitted local
subroutine. When relevant, a second exact conditional replacement should test whether the
outer workflow is compensating for a misspecified induced local objective. Record `not applicable`
when the method has no embedded local or block update.

Then propose matched replacement ablations. Depending on the paper, these may include:

- random proposals;
- deterministic greedy updates;
- exact solution of the small local problem;
- exact conditional block optimization;
- an established local, tabu, annealing, or domain-specific solver;
- removing filtering, mitigation, or postselection steps;
- preserving versus discarding the joint structure of the component's output.

Hold fixed as much as possible:

- global instances;
- initial states or initial solutions;
- selected subproblems;
- update order;
- stopping rule;
- objective evaluations;
- shots or samples;
- restarts;
- tuning effort;
- wall-clock or compute budget;
- parallel resources.

#### Minimum Decisive Ablation Template

| Variant | Component changed | Everything held fixed | Main question answered |
|---|---|---|---|
| Submitted method | None | Reference | Baseline behavior |
| Simple replacement | Credited component replaced by random or greedy rule | Same workflow and budget | Does the component's output beat a trivial proposal? |
| Exact local replacement | Local solver replaced by exact small-instance solution | Same blocks and aggregation | Does the approximate local solver add value? |
| Strong alternative replacement | Structurally matched established solver | Same resources and stopping rule | Is the titled component competitive? |
| Structure-aware reference | Exploits factorization, symmetry, or low rank | Same problem semantics | Is the reported crossover artificial? |

If the credited component's joint output is reduced to independent, marginal, or greedy proposals during postprocessing, explicitly test whether the joint structure survives into the final decision rule.

---

### Step 5: Stress-Test Baselines and Comparison Fairness

A baseline is fair only if it competes on the actual claim.

Check:

1. **Native formulation:** Does the baseline operate directly on the original
   problem, or is it forced through a disadvantageous transformation that the proposed
   method avoids?
2. **Structural match:** Does the baseline exploit the same block, sparsity, symmetry,
   locality, low-rank, or conditional-objective structure?
3. **Budget parity:** Match data access, objective calls, runtime, memory, cores/GPUs,
   restarts, samples, shots, and parallelism.
4. **Tuning parity:** Do not compare a carefully tuned new method with default settings
   for the baseline.
5. **Information parity:** No method should receive privileged initialization, exact
   coefficients, labels, oracle access, or stopping information unavailable to others.
6. **Output parity:** Compare the same target: best sample, expected energy, feasible
   solution, certified bound, fidelity, chemical accuracy, or application utility.
7. **Regime coverage:** Include easy, hard, structured, noisy, and failure regimes rather
   than only favorable instances.
8. **Uncertainty:** Report seeds, instance distributions, confidence intervals, tails,
   and failure rates.

Do not accept a general scaling statement, such as “classical methods scale exponentially,” as a baseline analysis. Complexity class, worst-case scaling, practical implementation, and performance on the tested instance family are separate questions.

---

### Step 6: Classify the Claimed Advantage

Do not collapse different kinds of advantage into one concept:

| Claim type | What must be shown |
|---|---|
| Formulation or representation benefit | A smaller, cleaner, or more faithful formulation under stated assumptions |
| Execution-speed crossover | Faster execution than a specified alternative under matched semantics and resources |
| Throughput | More independent jobs completed per call, device, or unit time |
| Platform compatibility | The method runs with acceptable accuracy on the stated platform or data |
| Solution-quality advantage | Better solution quality, success probability, or time-to-target than strong alternatives |
| End-to-end practical advantage | Better total cost, latency, energy, or scientific outcome including all overhead |
| Asymptotic advantage | A defensible complexity separation under explicit input, output, oracle, and error models |

Solving many independent small problems in one run is not the same as solving one larger coupled problem. Problem size, interaction density, depth or iteration count, instance hardness, and solution quality are different axes.

#### Resource Accounting

Request the quantities relevant to the claim:

- problem, model, and data sizes
- hardware, memory, and parallel resources
- preprocessing, training or tuning, execution, communication, and postprocessing costs,
  reported separately
- number of runs, repeated-run uncertainty, and failed or discarded runs
- raw logs or equivalent metadata when allowed

For quantum hardware, use the Quantum Module's Hardware Resource Accounting.

---

### Step 7: Audit Scalability Claims

For every scalability statement, identify the scaled variable and the fixed variables:

```text
Scaled: N / qubits / modes / depth / shots / terms / code distance / instances / rank
Fixed: accuracy / noise / coupling density / optimizer budget / success probability / data
Measured: runtime / memory / fidelity / objective gap / throughput / physical resources
```

Check whether:

- solution quality deteriorates while runtime appears flat;
- only independent workloads are being added;
- preprocessing or measurement dominates;
- the tested sizes are large only in a superficial dimension;
- exact ground truth disappears at larger sizes;
- the metric changes when exact verification becomes unavailable;
- asymptotic language is inferred from a narrow empirical range;
- extrapolation ignores error correction, calibration, or communication costs.

When the evidence is preliminary, use **proof of concept**, **compatibility
demonstration**, **throughput demonstration**, or **empirical scaling over the tested
range**, not unconditional scalability.

---

### Step 8: Separate Application Value from Method Value

For an application pipeline, separate at least three causal layers:

1. **Model or representation:** for example, a learned surrogate, improved
   Hamiltonian, active space, ansatz, dataset, or physical model.
2. **Optimizer or algorithm:** the method that searches or estimates within that model.
3. **Execution platform:** for example, exact or approximate simulation, a noisy
   emulator, hybrid sampling, specialized hardware, or a quantum device.

A better application result may come from the representation rather than the optimizer.
A scientifically useful design found by a workflow does not establish that the proposed
method or platform was necessary to find it.

Request factorial or cumulative ablations where practical:

| Representation | Optimizer | Execution | Purpose |
|---|---|---|---|
| Old | Established | Standard platform | Prior pipeline |
| New | Established | Standard platform | Isolate representation gain |
| New | Proposed method | Standard platform or simulation | Isolate algorithmic workflow |
| New | Proposed method | Proposed platform or hardware | Isolate platform or hardware effect |

Match application-query budgets, initial datasets, surrogate training, random seeds,
and stopping conditions.

---

### Step 9: Audit Same-Author Prior Work and Overlap Precisely

Under double-anonymous review, do not establish authorship from sources outside the submission. Assess same-group overlap only from material the editor supplied or self-citations visible in the manuscript, and route identity questions to the editor, as the first gate in [SKILL.md](../SKILL.md) requires.

When the same or substantially overlapping author group has a related paper, do not use
vague labels such as “present in both.” Identify **what exact object is repeated**.

#### Required Overlap Table

| Component | Prior paper: exact object and locator | Present manuscript: exact object and locator | Exact relationship | Citation and disclosure status | Is it part of the claimed novelty? | Review significance |
|---|---|---|---|---|---|---|
| Problem class | page + section + paragraph/object | page + section + paragraph/object | Same / extension / different | ... | ... | ... |
| Derivation or theorem | page + theorem/equation/paragraph | page + theorem/equation/paragraph | Reused / modified / new | ... | ... | ... |
| Algorithmic rule | page + Methods section + paragraph/algorithm line | page + Methods section + paragraph/algorithm line | Same mechanism / generalized | ... | ... | ... |
| Software or HPC infrastructure | page + section + paragraph/code path | page + section + paragraph/code path | Reused implementation architecture | ... | ... | ... |
| Experimental protocol | page + section + paragraph/table | page + section + paragraph/table | Same settings / controlled continuation | ... | ... | ... |
| Dataset or application testbed | page + section + paragraph | page + section + paragraph | Same testbed / new task | ... | ... | ... |
| Figures, numerical data, or runs | figure/table/data locator | figure/table/data locator | Reused / newly generated / unclear | ... | ... | ... |
| Hardware experiment | page + section + figure/table | page + section + figure/table | Same / updated device / genuinely new | ... | ... | ... |
| Core contribution | page + contribution statement | page + contribution statement | Incremental / substantive extension / distinct | ... | ... | ... |

#### Interpretation Rules

1. **Inherited and cited is normally acceptable.** Reusing a codebase, solver,
   preprocessing pipeline, dataset, or benchmark suite is not by
   itself a reason for rejection when it is properly cited and not falsely claimed as
   new.
2. **Same application does not mean same experiment.** Distinguish repeated protocol
   from reused numerical data, figures, or conclusions.
3. **A direct extension may still be publishable.** Extending a method to a larger
   problem class or a new encoding, from simulation to hardware, or from one regime to another must be judged by the
   technical difficulty, evidence, and resulting insight, not by the fact that the
   direction was foreseeable.
4. **A prior paper's future-work sentence is not dispositive.** It may reduce surprise,
   but it does not automatically eliminate novelty.
5. **Preprint citation is not concealment.** If the prior work was cited as an arXiv
   preprint and is now published, request an updated final citation; do not treat the
   old citation format as a substantive offense.
6. **Overlap matters when claim boundaries are blurred.** Ask the authors to state what
   is inherited, generalized, newly proved, newly implemented, and newly measured.
7. **Serious concerns require specific evidence**, such as:
   - undisclosed reuse of figures, tables, data, or numerical runs;
   - substantially repeated text or derivations presented as new;
   - the same central scientific result published twice;
   - omission of the closest prior paper;
   - a novelty statement contradicted by the authors' own earlier work.
8. Do not accuse authors of self-plagiarism, salami slicing, or duplicate publication
   unless the evidence is direct and the issue is material. When uncertain, describe
   the overlap factually in confidential comments and ask the editor to assess policy.

The novelty question is:

> After removing properly cited inherited components, is the remaining contribution
> technically substantive and sufficiently supported for this journal?

---

### Step 10: Crosscheck Another Review Without Inheriting Its Errors

When given another report, convert it into atomic candidate findings.

| Candidate point | Manuscript support | Mathematical correctness | Materiality to main claims | Actionability | Final treatment |
|---|---|---|---|---|---|
| ... | full locator under the Mandatory Manuscript-Location Protocol | correct / partly correct / wrong / unverified | central / secondary / cosmetic | decisive / useful / vague | absorb / rewrite / omit |

Procedure:

1. Remove rhetoric and isolate the technical proposition.
2. Locate the relevant equation, method step, figure, table, supplement, code path, or
   prior paper using page + section + numbered object, or page + section + paragraph
   ordinal and opening-phrase anchor for unnumbered prose.
3. Re-derive or independently reason through the proposition.
4. Search for counterexamples or a narrower valid interpretation.
5. Determine whether the point changes validity, novelty, significance, or only wording.
6. Absorb only points that are correct, material, and actionable.
7. Merge duplicate comments around one root cause.
8. Do not inherit the other review's recommendation. Recalibrate after all points are
   checked.

A useful external review can still have an overstrong recommendation, an unfair overlap
interpretation, or a correct concern stated for the wrong reason.

---

### Step 11: Reproducibility and Internal-Consistency Audit

Before claiming missing code or data, search the supplied material as described in the
repository-discovery section. Inspect the relevant implementation when a substantive concern
depends on it. Check whether an independent group could reconstruct the central results.
Include consequential reproducibility findings in the requested report or comprehensive audit;
a separate private memo is optional.

#### Manuscript Consistency

- main text versus Supplementary Information, recording the full locator on both sides;
- equations versus pseudocode, recording the full locator on both sides;
- pseudocode versus the inspected repository implementation;
- figure captions versus plotted data and available figure-generation code;
- stated iteration counts versus manuscript, config, and algorithm loops;
- notation and indexing;
- units and normalization;
- reported backend versus repository configuration;
- abstract claims versus actual experimental mode.

#### Reproducibility Items

- frozen code release or commit;
- license and access status;
- environment and package versions;
- complete configs and hyperparameters;
- random seeds;
- generated problem instances or datasets;
- raw and processed data;
- figure-generation scripts;
- hardware metadata;
- optimizer settings and stopping rules;
- cluster, MPI, SLURM, GPU, or CPU configuration;
- failed runs and exclusion criteria;
- sufficient information to reproduce resource counts and timing.

“Available upon reasonable request” is weak for a computational methods paper when the
main claims depend on code, generated instances, or hardware logs.

---

### Step 12: Calibrate Severity and Recommendation

#### Severity Labels

- **Fatal / central:** invalidates a load-bearing conclusion or removes the paper's main
  claimed contribution.
- **Major:** requires new analysis, controlled experiments, proof repair, substantial
  reframing, or stronger baselines, but a publishable core may remain.
- **Minor:** local clarification, presentation, notation, reporting, or bounded additional
  check that does not alter the central conclusion.
- **Optional:** useful extension not required to validate the paper's claims.

#### Recommendation Matrix

| Recommendation | Appropriate when |
|---|---|
| Accept | Central claims are correct, supported, significant for the venue, and only editorial changes remain |
| Minor revision | Core claims already stand; remaining issues are local and do not require new load-bearing evidence |
| Major revision / revise and reconsider | A potentially publishable core remains, but decisive controls, new analysis, substantial claim narrowing, or significant experiments are required |
| Reject with possible resubmission | The paper may become publishable only after a new study-level body of work or a substantially reconstructed contribution |
| Reject | A central theorem, comparison, or novelty claim fails; correcting it collapses the paper below the venue standard; or the work is outside scope |

Do not recommend rejection merely because:

- the same group developed the prior framework;
- inherited components are reused and properly cited;
- the same benchmark or application is reused;
- a prior paper anticipated the direction;
- many revisions are requested.

Do not recommend major revision merely to avoid a difficult decision. Ask:

1. Does a distinct contribution remain after correct attribution and claim narrowing?
2. Can the decisive evidence be added without replacing the central method?
3. Would success on the requested controls plausibly make the paper publishable here?
4. Does the current evidence support at least a meaningful, narrower claim?

Recommendation should follow the answers, not the number of comments.

---

## Quantum Module

Apply this module together with the Core Procedure only when the manuscript's contribution involves quantum computing or quantum technology, such as a quantum algorithm, quantum hardware or control, quantum error correction, quantum communication or sensing, or a computation run on a quantum device or its simulator. A physics topic alone does not trigger the module. Classical numerics for a condensed-matter model follows the Core Procedure only, while the same model simulated on a trapped-ion quantum computer also uses this module.

The Step 0 venue calibration applies to quantum venues as well. For example, PRL, PRX Quantum, npj Quantum Information, Quantum Science and Technology, and PRA expect different levels of advance.

### Quantum Paper Map

Expand the Step 1 map through the quantum stages:

```text
Scientific problem
→ mathematical formulation
→ classical preprocessing
→ quantum encoding and state preparation
→ quantum evolution or circuit
→ measurement
→ classical optimization/postprocessing
→ final scientific or computational output
→ claimed advantage
```

Also identify what remains if the quantum component is removed.

### Quantum Contribution and Decisive Ablation

Separate quantum involvement from quantum contribution. Running a circuit on a QPU does not show that the quantum subroutine improves quality, scaling, or cost. In Step 4, the credited component is the quantum state or circuit, and local improvement is usually classical. Ask whether the claimed improvement survives when the quantum subroutine is replaced while every surrounding component remains fixed.

Add these quantum-specific replacements to the matched ablations in Step 4 where they apply:

- a classical tensor-network or stabilizer solver;
- noiseless structure-aware simulation;
- removing error mitigation or postselection;
- preserving versus discarding the joint quantum output;
- same algorithm with hardware sampling replaced by classical sampling.

For a quantum manuscript, the Minimum Decisive Ablation Template takes this form:

| Variant | Component changed | Everything held fixed | Main question answered |
|---|---|---|---|
| Submitted method | None | Reference | Baseline behavior |
| Simple replacement | Quantum component replaced by random or greedy rule | Same workflow and budget | Does the quantum output beat a trivial proposal? |
| Exact local replacement | Quantum local solver replaced by exact small-instance solution | Same blocks and aggregation | Does approximation by the quantum subroutine add value? |
| Strong classical replacement | Structurally matched classical solver | Same resources and stopping rule | Is the titled quantum component competitive? |
| Structure-aware simulation | Exploits factorization, symmetry, or low entanglement | Same circuit semantics | Is the simulator crossover artificial? |

If the quantum-generated joint state is reduced to independent single-bit, marginal, or
greedy proposals during postprocessing, explicitly test whether the quantum correlations
survive into the final decision rule.

In Step 5, the baseline is the strongest structure-aware classical method or simulator. Do not compare a structured circuit only with a deliberately generic simulator. In the Step 8 factorial ablation, the established optimizer and platform are classical, the proposed method may be hybrid, and the proposed platform is quantum hardware.

### Quantum Structural Simplifications

Before accepting a quantum-simulation or hardware-scaling comparison, also test for:

- tensor-product separability;
- low entanglement;
- Gaussian, stabilizer, Clifford-dominated, matchgate, free-fermion, or other
  classically tractable structure;
- repeated identical subcircuits.

For example, if disjoint blocks satisfy

$$
H=\sum_{k=1}^{m}H_k,
$$

and the initial state and every circuit layer, with its parameters, respect the same partition, then the
ideal evolution may factorize as

$$
U=\bigotimes_{k=1}^{m}U_k,
$$

with

$$
\lvert\psi\rangle=\bigotimes_{k=1}^{m}\lvert\psi_k\rangle.
$$

In that case, compare against independent or batched simulation of the blocks, not
only against a monolithic state-vector or density-matrix representation. However, do
not conclude that the hardware construction is useless, because it may still demonstrate parallel
execution on one QPU, throughput, reduced submission overhead, or hardware compatibility. The
review should invalidate only the unsupported claim.

### Quantum and Hardware Claim Types

Classify a quantum or hardware claim with this table in addition to Step 6:

| Claim type | What must be shown |
|---|---|
| Logical encoding benefit | Fewer logical variables, cleaner formulation, or lower logical interaction order under stated assumptions |
| Circuit-simulation crossover | Faster execution than a specified classical simulation method under matched semantics and resources |
| Parallel QPU execution / throughput | More independent jobs completed per QPU call or unit time |
| Hardware compatibility | The circuit runs with acceptable fidelity on a real device |
| Optimization advantage | Better solution quality, success probability, or time-to-target than strong classical optimization |
| End-to-end practical advantage | Better total cost, latency, energy, or scientific outcome including classical overhead |
| Asymptotic quantum advantage | A defensible complexity separation under explicit input, output, oracle, and error models |

A wide fixed-depth circuit containing many independent small problems is not the same as
solving one larger coupled problem. Increasing circuit width, problem size, interaction
density, depth, instance hardness, and solution quality are different axes.

### Hardware Resource Accounting

Request the quantities relevant to the claim:

- logical and physical qubit counts;
- state-preparation cost;
- compiled basis-gate counts;
- one- and two-qubit gate counts;
- non-native interaction decomposition;
- transpiled depth;
- routing and SWAP overhead;
- qubit layout;
- device and execution dates;
- calibration and noise information;
- error mitigation, postselection, and discarded-shot rates;
- shots per circuit and total shots;
- number of parameter evaluations and circuit submissions;
- classical optimizer and preprocessing cost;
- compilation, queue, submission, QPU, communication, decoding, and postprocessing
  times reported separately;
- repeated-run uncertainty;
- raw job identifiers or equivalent metadata when allowed.

Distinguish a logical $k$-body term from a hardware-native primitive. Ancilla-free logical
encoding does not imply native physical execution.

### Quantum-Subfield Modules

Use only the relevant module; do not mechanically apply every checklist.

#### Variational Algorithms, QAOA, and Quantum Optimization

Check:

- objective encoding and compiled cost of non-native terms;
- ansatz depth and parameter count;
- optimizer evaluations, restarts, initialization, and tuning;
- shot noise and best-sample versus expectation-value reporting;
- exact solution of the small quantum subproblem;
- native classical optimization of the original objective;
- approximation metric validity;
- classical postprocessing and whether it dominates improvement;
- block selection, aggregation, and boundary interactions;
- trainability, depth scaling, and parameter transfer;
- time-to-target rather than circuit runtime alone.

#### Quantum Algorithms and Complexity

Check:

- input and data-loading model;
- output-access model;
- oracle assumptions and implementation cost;
- condition numbers, norms, sparsity, rank, precision, and success probability;
- state preparation and readout;
- postselection or amplitude-amplification cost;
- hidden logarithmic versus polynomial factors;
- end-to-end rather than query-only complexity;
- classical dequantization or structure-aware alternatives.

#### Quantum Hardware and Systems

Check:

- logical-to-physical mapping;
- calibration, drift, crosstalk, routing, and parallel-execution effects;
- device utilization versus algorithmic advantage;
- throughput versus latency;
- compilation and queue exclusions;
- reproducible hardware metadata;
- comparison with emulator and noise-aware simulation;
- whether observed scaling reflects the hardware or independent workload batching.

#### Quantum Error Correction and Fault-Tolerant Quantum Computing

Check:

- physical versus logical error model;
- code family, distance, decoder, and syndrome assumptions;
- threshold regime and finite-size effects;
- logical failure definition;
- circuit-level versus phenomenological noise;
- space-time volume;
- state distillation and factory assumptions;
- decoder runtime and classical communication;
- complete error budget and target logical accuracy;
- comparison under matched architecture and noise assumptions.

#### Quantum Simulation and Quantum Chemistry

Check:

- Hamiltonian and discretization accuracy;
- active-space, basis-set, truncation, and mapping choices;
- state-preparation overlap;
- measurement and grouping cost;
- Trotter, qubitization, block-encoding, or variational error;
- classical electronic-structure baseline at matched approximation level;
- chemical-accuracy claims and uncertainty;
- whether the application observable is actually accessible from the stated output.

#### Quantum Machine Learning

Check:

- data loading and feature construction;
- train/test leakage and model-capacity parity;
- kernel or model classical simulability;
- sample complexity and measurement cost;
- barren plateaus and optimization effort;
- strongest classical model at matched data and parameter budget;
- whether the gain comes from representation, regularization, or quantum execution;
- generalization across datasets and seeds.

#### Continuous-Variable, Photonic, and Bosonic Work

Check:

- Hilbert-space cutoff and convergence;
- energy constraints;
- Gaussian versus non-Gaussian resources;
- state-preparation and projection success probabilities;
- detector model, loss, and finite squeezing;
- effective versus hardware-native Hamiltonians;
- mode count and entanglement structure;
- measurement accessibility;
- truncation, sampling, and postselection costs;
- fair comparison with Gaussian, tensor-network, and Fock-space simulation.

### Quantum Failure Modes

- Treating hardware execution as quantum advantage.
- Comparing a tensor-product circuit only with monolithic state-vector simulation.
- Ignoring a simple exact solver for a tiny quantum subproblem.
- Equating larger circuit width with a larger coupled problem.
- Attributing an application gain to the quantum optimizer when the model class changed.

---

## Writing the Referee Report

### Major-Comment Contract

Every major comment should contain five elements:

1. **Location:** the full author-locatable manuscript reference required by the Mandatory
   Manuscript-Location Protocol, integrated naturally into the opening sentence rather
   than isolated in a bracketed heading by default.
2. **Issue:** the exact technical or evidentiary problem.
3. **Why it matters:** which claim or conclusion depends on it.
4. **Decisive revision:** the smallest analysis, experiment, comparison, or wording
   change that resolves it.
5. **Surviving claim:** what the paper may still validly claim if the stronger claim
   does not survive.

A strong comment is not merely “add more baselines.” It names the baseline, matched
budget, controlled variables, interpretation of possible outcomes, and every manuscript
location on which the criticism depends.

### Minor-Comment Contract

Every non-typo minor comment must contain:

1. **Location:** page + section/subsection + numbered object, or page + section/subsection
   + paragraph ordinal and sentence/opening-phrase anchor.
2. **Problem:** the exact notation conflict, undefined term, caption ambiguity, grammar
   problem, or local overstatement.
3. **Correction:** a concrete replacement or requested clarification whenever possible.

For typo-only comments, list the exact searchable typo and replacement, preferably in one
compact line. Representative page locations are not required unless Ctrl+F will not
identify the target reliably. Do not write only “there are many typos”; provide the actual
strings.

### Tone

Use professional, direct, neutral language. Preserve clear field-standard shorthands
such as `Sec.`, `Fig.`, `Eq.`, `SI`, `CPU/GPU`, and the field's established acronyms,
for example `QPU`, `VQE`, and `QEC` in quantum work. Do not
over-polish the report into generic or overly ceremonial prose; concise wording, natural
sentence variation, and a small amount of reviewer-style shorthand make the report read
like an expert's working assessment.

Illustrative phrasings of this register, to adapt to each comment:

- “The evidence supports a narrower interpretation...”
- “This comparison does not yet isolate...”
- “Please distinguish X from Y...”
- “A structure-aware comparison is required because...”
- “This does not make the method useless; it changes the supported claim from X to Y.”
- “The overlap appears to concern inherited and cited infrastructure rather than reused
  numerical evidence.”

Avoid:

- “obviously,” “trivially,” or “clearly wrong”;
- attributing motives;
- sarcasm;
- accusations unsupported by direct evidence;
- requiring the authors to pursue an unrelated new research program;
- hiding the main technical reason only in confidential comments.

Apply the Mandatory Manuscript-Location Protocol (see that section for the locator
hierarchy) to every major and non-typo minor criticism, in the submitted author-facing
prose, not only in private notes. Keep additional private verification notes separate,
but never strip a required manuscript locator from the final report.

### Comment Prioritization and Page-Budget Policy

Rank comments by their effect on validity, contribution, evidence, and interpretation. Merge shared root causes. Separate useful local corrections from decision-relevant concerns. Do not turn a list of true observations into equally weighted demands.

For a requested comprehensive audit, surface all verified, nonredundant, actionable findings without a fixed comment cap. Do not stop discovery because several strong findings already determine a recommendation. For a focused report, stay within the requested question.

Use a candidate ledger or omission ledger when the user requests one or a complex selection process needs it. Fixed headings and duplicate private/public reports are unnecessary. When compressing a comprehensive review, disclose any omitted substantive concern that changes interpretation. Routine editorial omissions need no ledger. Preserve the user's selected comments and personal sign-off, and apply an explicit requested length at delivery rather than as a discovery limit.

## Output Matched to the Request

Return the requested review artifact. An overall assessment with ranked comments is usually sufficient. Add private verification notes when needed to explain an unresolved issue or when requested. The following report components are available, not mandatory parallel deliverables.

### Confidential Comments to the Editor

When editor comments are requested, include:

- one-paragraph assessment of contribution and main concern;
- venue-level novelty/significance judgment;
- recommendation and confidence;
- publication-policy concern only when supported;
- no technical surprise that is absent from comments to authors.

### Comments to the Authors

Match the report to the requested scope. A comprehensive audit includes all verified, nonredundant, actionable findings. A submission-ready report prioritizes the issues that the authors and editor need to act on, with concise minor corrections.

#### Personal Style Settings

These are adjustable reviewer-style defaults, not review methodology. A sign-off, length,
or layout given in the user's request or guidance replaces them. Adjust them here without
touching the rest of the skill.

- **Sign-off:** do not add a separate `Recommendation` section. End the Overall
  Assessment with one of these forms:

  ```text
  I recommend the acceptance only after a major revision for the following N issues.
  I recommend the acceptance only after a minor revision for the following N issues.
  ```

  Preserve this wording as the reviewer's personal sign unless the user asks for a
  different form. For rejection or acceptance without revision, use a direct sentence
  appropriate to the journal rather than forcing this template.
- **Final length:** the preferred submitted review is about 2–3 PDF pages, applied only
  at the submission-editing stage (see Comment Prioritization and Page-Budget Policy).

```markdown
# Referee Report

## Overall assessment

[Brief assessment ending with the preferred recommendation sentence.]

## Major comments

### 1. [Short substantive title]

In Sec. Y (pp. X–Z, especially Eq./Fig./Algorithm ...), ...

### 2. [Short substantive title]

In Supplementary Note Y (SI p. X), ...

## Minor comments

1. **Exact locator.** Exact problem and correction.
2. Typos: “searchable typo” -> “correction”; ...
```

Do not add a separate `Recommendation` section unless the user requests it. The
sign-off rule above governs how the recommendation appears.

### Revision Review

For a resubmission, use:

| Original concern | Author response | Manuscript change | Assessment | Remaining action |
|---|---|---|---|---|

Then write the unresolved and newly introduced issues, and any load-bearing
problem that the original review clearly missed (see Mode C).

---

## Failure Modes

- Writing the recommendation before verifying the central claims.
- Stopping a requested comprehensive audit early because enough major issues have been found.
- Treating the use of a new method, model, or platform as evidence of its contribution.
- Comparing a structured method only with a generic alternative that ignores the structure.
- Ignoring a simple exact solver for a small subproblem.
- Requesting generic baselines without matching the method's structure.
- Accepting default settings for baselines while the proposed method is heavily tuned.
- Using a circular metric or a metric sensitive to conventions that should not affect the stated claim.
- Treating the most frequent global bitstring as a scalable decoder without checking its
  probability mass, product-distribution scaling, shot count, and confidence.
- Equating more independent instances with a larger coupled problem.
- Attributing an application gain to the proposed method when the model class changed.
- Calling cited inheritance duplicate publication.
- Using “present in both papers” without identifying whether this means a derivation,
  algorithmic rule, protocol, data, figure, or application.
- Treating a prior future-work statement as proof of no novelty.
- Copying another review's recommendation after absorbing only some of its points.
- Putting speculative allegations in the author-facing report.
- Contradicting the author-facing report in confidential comments.
- Producing an unranked, repetitive, or speculative wish list. Completeness means surfacing every verified actionable issue, not requesting every imaginable experiment.
- Silently deleting a verified concern merely to meet an assumed 2–3 page budget.
- Giving an exact location only in private notes while omitting it from the submitted review.
- Writing a major or non-typo minor comment with only a broad section name and no
  page or paragraph/object locator.
- Using phrases such as “throughout” or “several places” for a technical concern without
  a verified manuscript anchor.
- Writing “many typos” without listing the exact searchable strings and corrections.
- Inventing paragraph, equation, figure, or line numbers instead of using a verified
  opening-phrase anchor.
- Claiming that code or data are missing before searching all supplied files for links and
  inspecting any verified repository.
- Finding a repository but treating its existence as sufficient without checking whether
  it matches the paper, implements the stated method, and contains the claimed data.
- Ignoring the Supplementary Information or repository when the claims depend on them.
- Searching for or inferring author identity under double-anonymous review.
- Violating the journal's confidentiality or AI-use policy.

For a quantum manuscript, the Quantum Module lists further failure modes.

---

## Completion Check

The requested review is complete when its relevant claims and evidence have been inspected, central uncertainties are explicit, substantive comments are locatable and actionable, and the recommendation follows from scientific consequence, repairability, and venue standard. A full review covers numerical evidence and application interpretation as well as headline claims. Conditional checks above apply only when their mechanisms bear on a claim. The Quantum Module applies only when the contribution involves quantum computing or quantum technology.

Do not require a fixed ledger, number of passes, or new experiment to certify completion. A missing decisive result is a review finding; the reviewer need not run the authors' full study. Keep confidentiality and actual venue restrictions in force. The human reviewer owns the final judgment and submission.
