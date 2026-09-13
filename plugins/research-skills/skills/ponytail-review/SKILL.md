---
name: ponytail-review
description: >
  Review a diff for over-engineering and justified simplifications while
  preserving behavior, scientific meaning, and resource constraints. Use for
  simplification reviews or /ponytail-review. Report findings without applying fixes.
---

Review diffs for unnecessary complexity. Trace relevant callers and obligations
before recommending a cut. Prefer fewer maintenance concepts within the required
behavior, numerical accuracy, runtime, memory, and scaling constraints.

## Format

`L<line>: <tag> <what>. <replacement>.`, or `<file>:L<line>: ...` for
multi-file diffs. Include the decisive evidence or limitation when needed to
make the recommendation reviewable; do not force a consequential finding into
one line.

Tags:

- `delete:` dead code, unused flexibility, speculative feature. Replacement: nothing.
- `stdlib:` hand-rolled thing the standard library ships. Name the function.
- `native:` dependency or code doing what the platform already does. Name the feature.
- `yagni:` flexibility without a current consumer or requirement. A single
  implementation or caller is a lead, not proof that an abstraction is useless.
- `shrink:` simpler logic with equivalent required semantics and suitable
  resource cost. Show the simpler form.

## Examples

`L4: native: moment.js used only for a locale date label. Intl.DateTimeFormat preserves the configured locale and timezone; remove the dependency if no other consumer remains.`

`repo.py:L88: delete: private forwarding method with no callers or registration path. Remove it; the underlying operation remains available.`

`L30-44: shrink: loop copies key/value pairs without transformation. dict(pairs) preserves duplicate-key behavior and the required memory bound.`

## Conclusion

Report the meaningful burden removed. Include proposed line or dependency
reductions only when verified and useful; they are not the objective or evidence
of runtime improvement.

If no justified cut is found, say so within the reviewed scope; this does not
certify the code's overall correctness or readiness to ship.

## Boundaries

Scope: simplification findings. Check the correctness, scientific, security,
and resource consequences of every proposed deletion; independent defects may
be routed to a normal review. Preserve numerical conventions, optimized kernels,
required boundary validation, and sufficient independent evidence. A test's
value depends on the failure it detects, not its count or syntax; recommend
removal only when its obligation is obsolete or adequately covered elsewhere.
Does not apply the fixes, only lists them.
"stop ponytail-review" or "normal mode": revert to verbose review style.
