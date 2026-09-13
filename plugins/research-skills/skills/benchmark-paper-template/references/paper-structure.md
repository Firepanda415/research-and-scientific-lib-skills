# Optional benchmark-paper structures

Choose the outline from the measurement question, evidence, and venue. A common
structure is context and evaluation need, benchmark or measurement design,
experimental setup, results, and implications. Related work can appear where it
best supports the comparison. No section numbering or page allocation is fixed.

## Introduction

Explain what is measured, why the existing evidence leaves a useful question
open, what this benchmark contributes, and the main supported finding. Discuss
design choices early when they are central to the contribution. Running examples,
named RQs, a comparison table, and contribution bullets are optional.

Do not claim a shared limitation across all existing benchmarks without checking
the relevant sources. Neither a human–AI gap nor a new evaluation dimension is
mandatory. A more reliable measurement or a well-motivated new regime can be a
substantive contribution.

## Design and construction

Make instances, reference values, metrics, budget rules, filtering, and the
evaluation protocol reproducible to the level needed by the claims. For generated
or numerical benchmarks, preserve exact parameters, conventions, approximations,
seeds when relevant, and code/version information. Use a pipeline figure when
the construction logic benefits from it; do not force all designs into stages.

## Experiments and findings

Organize results around the questions they answer. A table, scaling curve,
resource plot, or failure analysis should expose the claimed distinction. An
overall score is useful only when its aggregation is meaningful; do not require
all models × all metrics or every possible breakdown.

State findings directly with the supporting conditions and uncertainty. Numbered
“Finding” paragraphs can help a long study but are not required. Results need
not be surprising or universally actionable to be accurate and valuable.

## Figures and supporting detail

Select each figure for its role: explaining a measurement, showing coverage,
testing scaling, comparing methods, or exposing a failure regime. There is no
mandatory Figure 1, figure count, page position, or bold/underline ranking rule.
Uncertainty and comparison conditions matter more than a leaderboard appearance.

Keep result-sensitive details available in methods, captions, appendices, code,
or compact configuration artifacts. Reuse evidence rather than duplicating large
tables or raw data in several places. A companion method gets space only when it
answers a distinct question and preserves held-out evaluation where applicable.
