---
name: pre-submission-reviewer
description: Audit the user's own technical paper for final submission readiness across scientific claims, evidence, cross-section consistency, prose, LaTeX, and figures. Use for a full integration audit or submission blockers, not referee reports on another author's paper or a narrow prose edit.
---

# Pre-Submission Reviewer

Audit the user's own paper for submission readiness. Follow the requested scope and venue. Keep scientific correctness and evidence ahead of polish. Do not infer that a systems-paper structure, running example, dataset count, or figure family is required in quantum research.

## Review priorities

- Trace central contributions to their arguments, derivations, and evidence. Check assumptions, quantitative claims, and cross-section consistency. For a suspected equation error, determine whether a local correction preserves the results before assigning severity.
- Check whether computational claims describe the actual runs and whether result-affecting parameters, approximations, and limitations are available in the paper, supplement, or referenced configuration. Typesetting success alone is not scientific validation.
- Inspect prose for ambiguity or terminology drift that changes meaning. For a full sentence-level edit, use the copyediting reference in `research-writing-style`; summarize its relevant findings rather than repeating the process.
- Check the final LaTeX/PDF for broken references, missing material, unreadable figures, and actual venue constraints. Inspect available sources and rendered figures directly.
- Check whether figures and captions accurately communicate the data, axes, units, uncertainty, and scope. Use `figure-designer` when redesign or detailed figure analysis is needed.

A requested complete audit covers these relevant dimensions, but does not need separate passes or reports. Focused questions remain focused. Do not run or request expensive new computations unless they resolve a specific claim-level uncertainty.

## References, loaded only as needed

- `references/logic-and-structure.md`: argument and cross-section traceability.
- `references/section-guides.md`: optional section organization patterns.
- `references/grammar-rules.md`: a specific grammar issue needing clarification.
- `references/latex-rules.md`: source, citation, numbering, or layout issues.
- `references/forbidden-patterns.md`: house style, misleading presentation, and evidence of overclaiming.

## Severity and readiness

- **CRITICAL:** an unresolved failure in a central claim, required evidence, or actual submission requirement that blocks a reliable submission.
- **MAJOR:** a substantive issue in support, interpretation, reproducibility, or intelligibility requiring focused revision.
- **MINOR:** a bounded correction that leaves the central conclusion intact.
- **Editorial:** house style, punctuation, or an optional presentation preference. Keep these separate from scientific severity. Word frequency, em dashes, and layout preferences do not automatically make a scientific Major finding.

Assign severity by consequence, not how mathematically dramatic the isolated typo looks or how many style hits occur. A displayed formula that needs a local sign correction may be Minor if the dependent results remain valid; the same discrepancy must be resolved before implementing from the paper.

Use **Ready to submit**, **Needs focused revision**, or **Needs major revision before submission** with the actual unresolved reasons. Do not manufacture a score from counts. A house-style correction can remain requested without becoming evidence that the science is unsound.

## Delivery

Lead with the readiness judgment and the most consequential findings. Each substantive finding needs a verified locator, the issue and consequence, evidence, and the smallest useful correction. Distinguish an observed failure from an unverified concern. Say which material or checks were unavailable without making the user reconfirm checks the assistant can perform.

Provide a full issue inventory when requested; otherwise use a concise ranked report. No fixed five-table output, gate checklist, or mandatory style scan is needed for a narrow scientific question. Apply the user's explicit house style to generated text. When giving manual manuscript replacements, follow `research-writing-style` for current-file anchors and paste-ready spans.
