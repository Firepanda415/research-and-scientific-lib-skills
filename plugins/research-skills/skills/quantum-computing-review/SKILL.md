---
name: quantum-computing-review
description: "Prepare or assess referee reports and revisions for another author’s quantum manuscript. Apply venue-policy and confidentiality gates before processing or external lookup. Exclude the user’s own submission audit and ordinary paper summaries."
---

# Quantum Computing Review

## Non-negotiable first gate

Before analyzing a confidential manuscript:

1. Identify the journal, article type, review model, and current official reviewer policy.
2. Check whether generative AI or external tools are permitted and whether disclosure is required.
3. Confirm the manuscript's public status before any manuscript-specific web search.
4. Default to `confidential-no-egress` when public status or permission is unclear.
5. Stop if the venue forbids this assistance or requires an approved environment that is unavailable.

`confidential-no-egress` forbids sending an unpublished title, author list, project acronym,
unique phrase, excerpt, figure, equation, or attachment to an external service. Journal-policy
lookup may use the journal name and public policy pages. The user remains responsible for
conflict-of-interest disclosure and the final review.

Pass the established confidentiality mode to every helper and subagent,
including `upgrade-research-inputs` and `quantum-research-radar`. Their retrieval
work remains inside the same no-egress boundary; delegation does not grant
permission to send manuscript material elsewhere.

Use `public-artifact` mode only after the manuscript or preprint is confirmed public and
external lookup is permitted. The safety rules in this file override any conflicting example
in `references/reviewer-handbook.md`.

## Select the mode

- **Initial review:** reconstruct the paper, audit all load-bearing claims, and prepare a ranked candidate report.
- **Crosscheck:** verify an existing review point by point without inheriting its recommendation.
- **Revision:** map each original concern to the response, manuscript change, evidence, and residual issue.
- **Adjudication:** isolate the exact disputed claim, assumptions, evidence, and decision consequence.
- **Expertise bridge:** build private prerequisite notes without treating unfamiliar notation as a flaw.

Ask only for missing information that changes confidentiality, scope, or the requested deliverable.
Distinguish `not provided`, `not found`, and `not verifiable`.

## Load detailed guidance conditionally

The detailed protocol is preserved in `references/reviewer-handbook.md`. Use its contents
and headings to load the relevant guidance when one of these specialized checks is needed:

- repository/code/data audit;
- manuscript locator construction;
- mathematical and structural audit;
- quantum contribution and decisive ablation;
- classical baseline, hardware-resource, or scalability audit;
- same-author overlap analysis;
- a quantum-subfield-specific module;
- editor comments, author comments, or revision-report templates.

For a narrow crosscheck or revision question, use only the core workflow below unless the
handbook contains a directly relevant contract.

## Core workflow

1. **Establish venue and scope.** Record the venue standard, editor questions, policy status,
   confidentiality mode, conflict status, and requested output.
2. **Reconstruct the paper.** Map the scientific problem through classical preprocessing,
   quantum encoding/evolution/measurement, classical postprocessing, final output, and claimed advantage.
3. **Track claim evidence.** Associate load-bearing claims with their locators, evidence,
   assumptions, uncertainty, and decision consequence. Use a ledger when it helps manage
   the requested scope; a separate record for every routine check is unnecessary.
4. **Check mathematics and structure.** Reconstruct central equations, distinguish definitions
   from approximations, test edge cases, and look for simpler structural explanations.
5. **Isolate the quantum contribution.** Separate quantum involvement from a demonstrated
   contribution. Specify the smallest replacement or removal ablation that tests the titled novelty.
6. **Stress-test comparisons.** Match compute, data, tuning, runtime, memory, shots, restarts,
   and privileged information. Prefer structure-aware classical alternatives.
7. **Audit hardware and scaling claims.** Account for state preparation, connectivity, depth,
   shots, mitigation, queue/calibration cost, classical work, and the regime actually demonstrated.
8. **Check novelty and overlap precisely.** Compare exact repeated objects and citation status;
   never infer misconduct from topical or stylistic similarity.
9. **Inspect public artifacts when allowed.** Verify repository identity and frozen version,
   then compare equations, code paths, configs, data, and figure-generation artifacts.
10. **Calibrate severity and recommendation.** Base the decision on centrality, fixability,
    evidence, and venue standard rather than comment count.

## Coverage and consequence

For substantive scientific assessment, read [coverage and consequence](references/coverage-and-consequence.md). Apply its topic-specific checks to actual claims; no irrelevant checklist or new experiment is implied.

## Evidence and locator contract

Every submitted major or non-typo minor comment must contain:

- an exact manuscript locator, or page + section + paragraph/opening phrase when numbering is absent;
- the technical issue and why it affects a claim;
- the evidence or derivation supporting the concern;
- the smallest decisive correction, clarification, analysis, or experiment.

Do not fabricate page, equation, paragraph, repository, or line numbers. Searchable typo-only
comments may give the exact string and correction instead of a page locator.

## Artifact and confidentiality rules

- Do not claim code or data are absent before searching all supplied files for explicit links.
- Do not perform title/author/phrase search in `confidential-no-egress` mode.
- Do not treat repository existence as validation of results.
- Record a commit, tag, release, or archive identifier for repository-based findings.
- Do not contact authors directly, submit the report, send external messages, or disclose the
  manuscript unless the user explicitly requests the action and venue policy permits it.
- Do not use em dashes in authored report prose. Use commas, colons, parentheses, or separate sentences instead.

## Default output

Return a ranked, evidence-backed report in the requested form. Include the overall assessment,
substantive concerns, concise useful minor corrections, and recommendation rationale when
requested. Keep tutorial notes and speculative checks out of author-facing prose. Add private
verification notes where they explain an unresolved issue or the user requests them.

For a requested comprehensive audit, surface all verified, nonredundant, actionable findings
without an arbitrary comment cap. Candidate ledgers, omission ledgers, and separate coverage
reports are optional deliverables. When compressing a comprehensive audit, disclose any omitted
substantive concern that changes interpretation; editorial omissions need no separate ledger.

## Completion check

For a full review, check the applicable items below. A focused question or
public excerpt review can finish when its stated claim is assessed; it does not
require a journal policy record, full-manuscript inspection, or unrelated gates.
Distinguish that bounded assessment from a complete referee report.

- policy, confidentiality mode, and conflict status are recorded;
- the main manuscript and relevant supplements are inspected;
- every load-bearing claim has evidence status and a verified locator;
- central equations and the strongest alternative explanation are checked;
- claim, numerical-evidence, and application checks cover the requested scope;
- the optimization metric gate is completed when a scalar performance metric carries a claim;
- the finite-shot decoder gate is completed when sampled outputs support a result;
- the embedded local-objective gate is completed when a local subroutine updates a global objective;
- quantum value is separated from application value;
- baseline and resource comparisons are fair enough for the stated claim;
- public repositories are inspected only under the allowed mode;
- every substantive report comment is locatable and actionable;
- the output matches the requested depth without hiding decision-relevant uncertainty;
- the recommendation follows from centrality, fixability, evidence, and venue standard;
- unverified facts and user-attestation items remain explicit;
- the human reviewer accepts responsibility for the final report.
