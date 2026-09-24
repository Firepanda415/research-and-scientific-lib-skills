---
name: pre-submission-reviewer
description: Audit the user's own technical paper or revision, from a focused claim or section check to a full submission-readiness audit, across scientific claims, evidence, cross-section consistency, prose, LaTeX, figures, and any response to referees. Not for referee reports on another author's paper, paper-structure planning, or a prose-only edit.
---

# Pre-Submission Reviewer

Audit the user's own paper for submission readiness. Follow the requested scope and venue. Keep scientific correctness and evidence ahead of polish. Do not require a systems-paper structure, running example, dataset count, or figure family unless the venue or the paper's argument needs it.

## Review priorities

- Trace central contributions to their arguments, derivations, and evidence. Check assumptions, quantitative claims, and cross-section consistency. For a suspected equation error, determine whether a local correction preserves the results before assigning severity.
- Check whether computational claims describe the actual runs and whether result-affecting parameters, approximations, and limitations are available in the paper, supplement, or referenced configuration. Typesetting success alone is not scientific validation. When result files are available, check reported values, derived differences and stated bounds against them at the displayed precision, across the paper, supplement and response letter.
- Inspect prose for ambiguity or terminology drift that changes meaning. For a full sentence-level edit, use the copyediting reference in `research-writing-style`; summarize its relevant findings rather than repeating the process.
- Check the final LaTeX/PDF for broken references, missing material, unreadable figures, actual venue constraints, and submission hygiene: leftover comment or TODO macros, revision coloring outside a marked-up version that the venue requests, draft options, comments or commented drafts in uploaded source, and anonymization or PDF metadata when the venue requires it. Inspect available sources and rendered figures directly.
- Take venue constraints from the user, the supplied template, or the current official author instructions (cite the page and access date). Label unverified requirements, and do not rate them Critical from memory.
- Check whether figures and captions accurately communicate the data, axes, units, uncertainty, and scope. Use `figure-designer` when redesign or detailed figure analysis is needed.
- Audit the active source. Commented-out text is not manuscript content unless the user says otherwise, so a definition, hypothesis, or caveat that survives only in comments counts as missing from the paper. When the user asks to review, restore, or compare a commented draft, that draft is the material to work on.
- When a region was rewritten or pasted in during the current revision, or is reported as changed, trace each label, symbol, hypothesis, and convention that region defined or removed through the rest of the document, because orphaned symbols and unapplied conventions still compile. The tracing covers those items and does not re-audit untouched text. When the text leaves open which convention produced reported values, recompute a representative value from available outputs or a cheap calculation, within the computation limit stated after this list.

A requested complete audit covers these relevant dimensions, but does not need separate passes or reports. Focused questions remain focused. Do not run or request expensive new computations unless they resolve a specific claim-level uncertainty.

## Resubmission

When the user resubmits their own revised manuscript with a point-by-point response to referees, audit the response against the manuscript:

- Map each referee point to its reply, the manuscript change or evidence the reply cites, and any residual issue. Flag replies that do not answer the point raised.
- Flag changes cited in a reply but missing from the revised manuscript, especially material the referee asked to see in the paper. Flag substantive revisions that the response does not report.
- When the originally submitted version is available, check the response's statements about it against that version. Flag any concession of a flaw that the original did not contain.
- Check every number quoted in the response against the revised manuscript and the result artifacts.

Audit the revised manuscript itself under the review priorities above. When the venue requests a marked-up version, change highlighting belongs in that version, and the revision-coloring check applies to any clean version submitted with it. Leave cover-letter declarations and format to `journal-cover-letter`, and prose-only polishing of the response to `research-writing-style`.

## References, loaded only as needed

- `references/logic-and-structure.md`: argument and cross-section traceability.
- `references/section-guides.md`: optional section organization patterns.
- `references/grammar-rules.md`: a specific grammar issue needing clarification.
- `references/latex-rules.md`: source, citation, numbering, or layout issues.
- `references/forbidden-patterns.md`: house style, misleading presentation, and evidence of overclaiming.
- For a benchmark paper, also apply the [benchmark checklist](../benchmark-paper-template/references/checklist.md) from `benchmark-paper-template`.

## Severity and readiness

- **CRITICAL:** an unresolved failure in a central claim, required evidence, or actual submission requirement that blocks a reliable submission.
- **MAJOR:** a substantive issue in support, interpretation, reproducibility, or intelligibility requiring focused revision.
- **MINOR:** a bounded correction that leaves the central conclusion intact.
- **Editorial:** house style, punctuation, or an optional presentation preference. Keep these separate from scientific severity. Word frequency, em dashes, and layout preferences do not automatically make a scientific Major finding.

Assign severity by consequence, not how mathematically dramatic the isolated typo looks or how many style hits occur. A displayed formula that needs a local sign correction may be Minor if the dependent results remain valid; the same discrepancy must be resolved before implementing from the paper.

Use **Ready to submit**, **Needs focused revision**, or **Needs major revision before submission** with the actual unresolved reasons. Do not manufacture a score from counts. A house-style correction can remain requested without becoming evidence that the science is unsound.

## Delivery

Lead with the readiness judgment and the most consequential findings. Each substantive finding needs a verified locator, the issue and consequence, evidence, and the smallest useful correction. Distinguish an observed failure from an unverified concern. Say which material or checks were unavailable without making the user reconfirm checks the assistant can perform.

Provide a full issue inventory when requested; otherwise use a concise ranked report. No fixed table layout, gate checklist, or mandatory style scan is needed for a narrow scientific question. Apply `research-writing-style` to generated text, including its default house style and any explicit user style. When giving manual manuscript replacements, follow `research-writing-style` for current-file anchors and paste-ready spans.
