---
name: ponytail-audit
description: >
  Compact Ponytail-format audit of over-engineering and justified deletions
  across a repository, preserving behavior, scientific meaning and resource
  constraints. Use for $ponytail-audit, /ponytail-audit or an explicitly
  requested Ponytail audit. Returns a compact read-only report. For an
  evidence-backed simplification survey or authorized cleanup, use
  simplify-codebase.
---

ponytail-review, repo-wide. Cover the requested repository scope instead of a
diff. Rank findings by justified maintenance benefit, confidence, and consequence,
not deletion volume. Account for important uninspected surfaces.

This is the compact read-only audit route. Reuse relevant evidence from an
existing simplification review; do not start a second full audit merely because
simplify-codebase covers the same outcome.

## Tags

Same as ponytail-review:

- `delete:` dead code, unused flexibility, speculative feature. Replacement: nothing.
- `stdlib:` hand-rolled thing the standard library ships. Name the function.
- `native:` dependency or code doing what the platform already does. Name the feature.
- `yagni:` flexibility without a current consumer or requirement. One
  implementation or caller alone does not establish redundancy.
- `shrink:` simpler logic with equivalent required semantics and suitable
  resource cost. Show the simpler form.

## Hunt

Look for dead flags, duplicate state, unused flexibility, unnecessary forwarding,
or custom code replaced by an existing suitable facility. Trace consumers,
dynamic registration, ownership, public contracts, and retained evidence before
calling a candidate redundant. File size, caller count, or visual similarity is
only a lead; a small wrapper may own a meaningful boundary.

For expensive numerical work, preserve the optimized stack and required sparse,
matrix-free, batched, or device-resident representation. Fewer lines or a stdlib
replacement do not establish lower cost. Inspect affected copies, kernel calls,
and retained output without launching large jobs merely to support a cleanup.

## Output

Use compact ranked findings: `<tag> <what to cut>. <replacement>. [path]`.
Add the decisive evidence or consequence when needed. Include verified proposed
line or dependency reductions only when useful. If nothing is justified, report
that result within the inspected scope without implying general ship approval.

## Boundaries

Scope: simplification findings. Every proposed cut must preserve required
behavior, scientific accuracy, security, and resource constraints; route unrelated
defects to a normal review. Keep the smallest independent evidence protecting
current obligations, without a fixed test count. Lists findings, applies nothing.
One-shot.
