---
name: quantum-computing-review
description: "Prepare, crosscheck, or adjudicate referee reports on another author’s technical manuscript in any field, and assess its revised version and the authors’ rebuttal. Add quantum-specific checks when the manuscript’s contribution involves quantum computing or quantum technology. Apply venue-policy and confidentiality gates before processing or external lookup. Not for the user’s own paper or response to referees, benchmark-paper planning, paper-structure planning, prose edits, or a plain summary of a paper."
---

# Quantum Computing Review

Prepare or assess referee reports on another author's technical manuscript in any field. The first gate, review modes, core workflow, and comment contracts below apply to every such manuscript. Add the quantum module only when the manuscript's contribution involves quantum computing or quantum technology.

## Non-negotiable first gate

Before analyzing a confidential manuscript:

1. Identify the journal, article type, review model (such as single-anonymous, double-anonymous, or open), and current official reviewer policy.
2. Check whether generative AI or external tools are permitted and whether disclosure is required. This assistant and any subagent it starts count as generative-AI use, and a venue ban on external tools covers them too, because their model runs off the machine.
3. Confirm the manuscript's public status before any manuscript-specific web search.
4. Default to `confidential-no-egress` when public status or permission is unclear.
5. Stop if the venue forbids this assistance or requires an approved environment that is unavailable.

Record policy facts supplied by the user, such as policy text, AI-use permission, or a disclosure requirement, as user-attested, not verified. Ask for them only when the official policy cannot be retrieved and the answer changes confidentiality or disclosure.

If the review model is double-anonymous, do not attempt to identify the authors. Do not search for the manuscript's title, authors, or preprint, even to establish public status, and do not attribute a repository or dataset to its owner. Public status then stays unconfirmed unless the editor, the venue, or the user states it. Assess same-group overlap only from material the editor supplied or self-citations visible in the manuscript, and route identity questions to the editor. If an identity appears incidentally, for example in an opened link, a permitted literature search, or a signed response letter, do not record, use, or pursue it. Tell the user where author identity was exposed, without repeating it, so that they can inform the editor when the venue requires it.

`confidential-no-egress` forbids sending an unpublished title, author list, project acronym, unique phrase, excerpt, figure, equation, supplementary code or data, or attachment to an external service. An external service is any tool that sends material off the machine, such as web search, URL fetching, an online converter or code runner, or another AI service. Once the first gate clears this assistance, the assistant session and the subagents it starts are not external services under this mode, but any tool they call that sends material off the machine is. Author-supplied repository and data links follow the link rule under the artifact and confidentiality rules below. Journal-policy lookup may use the journal name and public policy pages. The user remains responsible for conflict-of-interest disclosure and the final review.

Pass the established confidentiality mode with its definition (the forbidden-egress list, what counts as an external service, and the author-supplied link rule), the venue-policy status, and any double-anonymous restriction to every helper and subagent brief, including `upgrade-research-inputs` and `quantum-research-radar`. A mode name alone does not tell a helper what it may send. Helper retrieval remains inside the same boundary, and delegation does not grant permission to send manuscript material elsewhere.

Use `public-artifact` mode only after the manuscript or preprint is confirmed public and external lookup is permitted. The double-anonymous restrictions still apply in that mode. Subject to those restrictions, external lookup may then use the public version's title, authors, and content. Material absent from the public version, such as submission-only supplements or revisions, editor correspondence, other reviewers' reports, and the draft report, stays under the `confidential-no-egress` rules, and helper briefs carry that boundary. The safety rules in this file override any conflicting example in `references/reviewer-handbook.md`.

## Select the mode

- **Initial review:** reconstruct the paper, audit all load-bearing claims, and prepare a ranked candidate report.
- **Crosscheck:** verify an existing review point by point without inheriting its recommendation.
- **Revision:** map each original concern to the response, manuscript change, evidence, and residual issue.
- **Adjudication:** isolate the exact disputed claim, assumptions, evidence, and decision consequence.
- **Expertise bridge:** build private prerequisite notes for the paper's source discipline without treating unfamiliar notation as a flaw.

Ask only for missing information that changes confidentiality, scope, or the requested deliverable. Distinguish `not provided`, `not found`, and `not verifiable`.

## Core workflow

These steps apply to every manuscript.

1. **Establish venue and scope.** Record the venue standard, editor questions, review model, policy status, confidentiality mode, conflict status, and requested output.
2. **Reconstruct the paper.** Map the scientific problem through its formulation, inputs or experimental setup, method, and outputs to the claimed contribution. Identify the component credited with the main result.
3. **Track claim evidence.** Associate load-bearing claims with their locators, evidence, assumptions, uncertainty, and decision consequence. Use a ledger when it helps manage the requested scope. A separate record for every routine check is unnecessary.
4. **Check mathematics and structure.** Reconstruct central equations, distinguish definitions from approximations, test edge cases, and look for simpler structural explanations.
5. **Isolate the claimed contribution.** Separate the presence of the credited component from a demonstrated contribution. Specify the smallest replacement or removal ablation that tests the titled novelty.
6. **Stress-test comparisons.** Match compute, data, tuning, runtime, memory, samples, restarts, and privileged information. Prefer structure-aware alternatives.
7. **Audit resource and scaling claims.** Classify the claimed advantage, account for costs outside the headline measurement, and identify the regime actually demonstrated.
8. **Check novelty and overlap precisely.** Compare exact repeated objects and citation status. Never infer misconduct from topical or stylistic similarity.
9. **Inspect linked code and data as the mode allows.** Verify repository identity and frozen version, then compare equations, code paths, configs, data, and figure-generation artifacts.
10. **Calibrate severity and recommendation.** Base the decision on centrality, fixability, evidence, and venue standard rather than comment count.

## Quantum module

Apply this module in addition to the core workflow only when the manuscript's contribution involves quantum computing or quantum technology, such as a quantum algorithm, quantum hardware or control, quantum error correction, quantum communication or sensing, or a computation run on a quantum device or its simulator. A physics topic alone does not trigger it. Classical numerics for a condensed-matter model follows the core workflow only, while the same model simulated on a trapped-ion quantum computer also uses this module.

- In step 2 (reconstruct the paper), map classical preprocessing, quantum encoding and state preparation, evolution or circuit, measurement, and classical postprocessing to the claimed advantage.
- In step 4 (check mathematics and structure), test whether classically tractable structure, such as stabilizer, Gaussian, low-entanglement, or tensor-product states, explains the result.
- In step 5 (isolate the claimed contribution), separate quantum involvement from quantum contribution by replacing the quantum subroutine while the surrounding workflow stays fixed.
- In step 6 (stress-test comparisons), compare against structure-aware classical methods and simulators, matching shots as well as the other budgets.
- In step 7 (audit resource and scaling claims), account for state preparation, connectivity, depth, shots, mitigation, queue and calibration cost, and classical work, and classify the quantum or hardware claim.
- Apply the relevant quantum-subfield module.

## Load detailed guidance conditionally

`references/reviewer-handbook.md` holds the detailed protocol. List its headings with `grep -n "^#" references/reviewer-handbook.md` and read only the line ranges you need. The listing also shows headings inside the fenced report templates, which are template text. Each specialized check has its own section:

- repository, code, or data audit: `## Mandatory Repository Discovery and Code/Data Audit`
- manuscript locator construction: `## Mandatory Manuscript-Location Protocol`
- mathematical and structural audit: `### Step 3: Perform the Mathematical and Structural Audit`, including `#### 3.3 Metric Validity` and `#### 3.4 Finite-Shot Decoder and Product-Distribution Scaling: Hard Gate`
- contribution isolation and decisive ablation: `### Step 4: Isolate the Claimed Contribution`
- baseline, claim-type, resource, or scalability audit: `### Step 5: Stress-Test Baselines and Comparison Fairness`, `### Step 6: Classify the Claimed Advantage`, and `### Step 7: Audit Scalability Claims`
- same-author overlap: `### Step 9: Audit Same-Author Prior Work and Overlap Precisely`
- crosscheck of another review: `### Step 10: Crosscheck Another Review Without Inheriting Its Errors`
- quantum manuscripts only: `## Quantum Module`, including `### Quantum-Subfield Modules`
- editor comments, author comments, or revision-report templates: `## Writing the Referee Report` and `## Output Matched to the Request`

For a narrow crosscheck or revision question, use only the core workflow, with the quantum module when it applies, unless the handbook contains a directly relevant contract.

## Coverage and consequence

For substantive scientific assessment, read [coverage and consequence](references/coverage-and-consequence.md). Apply its topic-specific checks to the claims the manuscript actually makes, without running an irrelevant checklist or a new experiment.

## Evidence and locator contract

Every submitted major or non-typo minor comment must contain:

- an exact manuscript locator, or page + section + paragraph/opening phrase when numbering is absent;
- the technical issue and why it affects a claim;
- the evidence or derivation supporting the concern;
- the smallest decisive correction, clarification, analysis, or experiment;
- for a major comment, the narrower claim that survives when the stronger claim fails.

For a non-typo minor comment, the handbook's Minor-Comment Contract replaces the second and third items.

Do not fabricate page, equation, paragraph, repository, or line numbers. Searchable typo-only comments may give the exact string and correction instead of a page locator.

## Artifact and confidentiality rules

- Do not claim code or data are absent before searching all supplied files for explicit links.
- In `confidential-no-egress` mode, record explicit repository or data links from the supplied files. Open one only if venue policy permits reviewers to access author-supplied links with the tools in use. Otherwise report "link present, not inspected" so the human reviewer can inspect it.
- Do not perform title, author, or phrase search in `confidential-no-egress` mode or under double-anonymous review.
- Do not treat repository existence as validation of results.
- Record a commit, tag, release, or archive identifier for repository-based findings.
- Do not contact authors directly, submit the report, send external messages, or disclose the manuscript unless the user explicitly requests the action and venue policy permits it.
- Do not use em dashes in authored report prose unless the user or the venue requires them. Use commas, parentheses, or separate sentences instead. `research-writing-style` governs the report's other punctuation and the override. The compact typo list and locator strings are structured lists, not prose.

## Default output

Return a ranked, evidence-backed report in the requested form. Include the overall assessment, substantive concerns, concise useful minor corrections, and recommendation rationale when requested. Keep tutorial notes and speculative checks out of author-facing prose. Add private verification notes where they explain an unresolved issue or the user requests them.

For a requested comprehensive audit, surface all verified, nonredundant, actionable findings without an arbitrary comment cap. Candidate ledgers, omission ledgers, and separate coverage reports are optional deliverables. When compressing a comprehensive audit, disclose any omitted substantive concern that changes interpretation. Editorial omissions need no separate ledger.

## Completion check

For a full review, check the applicable items below. A focused question or public excerpt review can finish when its stated claim is assessed, without full-manuscript inspection or unrelated checks. The first gate still applies to any confidential manuscript, including a later review round, which may reuse the earlier policy record unless its currency is uncertain. Distinguish that bounded assessment from a complete referee report.

- policy, review model, confidentiality mode, and conflict status are recorded;
- the main manuscript and relevant supplements are inspected;
- every load-bearing claim has evidence status and a verified locator;
- central equations and the strongest alternative explanation are checked;
- claim, numerical-evidence, and application checks cover the requested scope;
- the optimization metric gate is completed when a scalar performance metric carries a claim;
- the finite-shot decoder gate is completed when sampled outputs support a result;
- the embedded local-objective gate is completed when a local subroutine updates a global objective;
- the credited component's contribution is separated from application value;
- the quantum module is applied when, and only when, the contribution involves quantum computing or quantum technology;
- baseline and resource comparisons are fair enough for the stated claim;
- linked code and data are inspected only as the mode and venue policy allow;
- every substantive report comment is locatable and actionable;
- the output matches the requested depth without hiding decision-relevant uncertainty;
- the recommendation follows from centrality, fixability, evidence, and venue standard;
- unverified facts and user-attested policy facts remain explicit;
- the human reviewer accepts responsibility for the final report.
