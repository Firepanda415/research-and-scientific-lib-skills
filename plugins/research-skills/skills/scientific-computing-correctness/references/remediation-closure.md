# Remediation Closure Protocol

Use this protocol only when work is intended to close findings from an earlier
scientific-code review. It makes closure evidence explicit without prescribing
the implementation.

## Closure ledger

Track each prior finding and its closure evidence. For a single bounded fix, a
short note is enough; use a ledger for multiple findings or parallel handoffs:

`finding id | origin | disposition | scoped relation/domain | semantic owner |
original counterexample | separating evidence | public result | unchecked scope |
documentation and generated outputs`

Keep these axes separate:

- `origin`: `new regression`, `pre-existing`, or `unknown`.
- `disposition`: `open`, `docs-only`, `partial`, `closed`, `duplicate`,
  `intentional decision`, or `out of scope`.

An `intentional decision` requires explicit authority from the user, maintainer,
or an already authoritative project contract. A runtime or public-record finding
remains open when documentation only acknowledges it.

Before accepting the implementer's examples, independently reconstruct the
affected relation from the public contract and live ownership. Determine which
representations preserve meaning, which consumer/lifecycle distinctions change
legality, and where the actual transformation must preserve that relation.
Shared vocabulary or a shared helper does not establish those facts.

Establish the original failure (or justify an equivalent falsifier) on the
pre-fix code, then qualify the corrected evidence for the integrated endpoint
under the integration rule below. Select a small set of contract-derived equivalence,
legal-preservation and forbidden-work cases that separate the plausible failures.
Do not infer support from generic coercibility or demand every Cartesian input.
Some automatic decisions need a workload census; require rejection before work
only when the necessary facts are already available.

Record separately whether the original counterexample is resolved, the scoped
relation is supported by source reasoning and these checks, and a sibling or
wider guarantee remains open. An unchanged example corpus proves that corpus,
not all valid representations. Preserve successful receipts when later evidence
narrows closure; do not relabel a fixed original case as a failed sibling.

## Decision and evidence safety

Whenever a diagnostic, clipped value, thresholded value, or defaulted field is
promoted into ranking, stopping, validation, or certification, re-audit its full
provenance. Handling weak or inconsistent evidence does not justify increased
certainty without an independent mathematical or empirical basis.

For a mixed-source estimator, record which terms are exact, sampled, bounded, or
derived. Distinguish the quantity's admissible domain from that of a signed
estimator: reject definition-invalid quantity values at the owner that knows
the definition. A justified scale-aware roundoff adjustment retains the raw
value and discloses the adjustment. A valid signed estimator may be negative;
preserve its raw estimate, meaning and uncertainty without presenting it as the
nonnegative quantity itself or as certified evidence. Downstream certification
remains unresolved unless a justified bound protects the decision.

Treat jointly constrained sampled or approximate objects as coupled evidence.
Checking each component separately does not establish a relation that depends on
their joint construction. Record the structural residuals, conditioning,
sampling context, preprocessing error bounds, and independent physical
falsifiers relevant to the claimed relation. Do not repair inconsistent evidence
by projection, clipping, or silent deletion and then strengthen the claim. Raw
values may remain available for an experimental workflow when their status is
clear. Certification without a justified propagated bound or statistical model
stays unresolved. Experimental decisions may use these values with empirical
checks and stated limitations; distinguish operational termination from
convergence and do not claim error control.

## Resource regression evidence

For changes affecting pruning, dispatch, batching, retained records, reporting,
caches, resource-only modes, or expensive per-solve work, compare the affected
resource envelope from the main skill at the base and integrated endpoint.
Use the smallest representative workload that exercises the mechanism. Record
the expected relation and explain increases, including any accuracy tradeoff;
test only the dimensions the change can affect.

Use boundary instrumentation to witness forbidden construction, simulation, or
backend calls. For retention, observe growth across iterations or batches as
well as peak live memory and final serialized size. A cheaper measurement or
justified scaling bound may replace an impractical full run; label projections.
Keep permanent checks causal and small rather than adding large wall-clock tests.
Re-evaluate any deferred cost item whose workload or measured impact changed.
An unexplained material regression prevents closure even when numerical tests pass.

## Shared public-record migration

Before editing producers, define each shared field's quantity, population and
frame, event, semantic owner, legal states, and cross-field invariant.

- Apply ordering relations only to values from the same population. Representative
  samples and full workloads use separate fields.
- Route reserved fields through one owner. A free-form mapping that collides with
  a reserved field fails explicitly instead of relying on merge order.
- Trace every producer, transformer, serializer, report, document, generated
  output, and sibling caller.
- Test at least one nondefault value through the shared layer.
- Verify lifecycle facts with an independent event witness such as a backend
  call, returned counts, a returned statevector, or a successful submitter call.
  Metadata written by the branch under test is not an independent witness.
- Cover interactions that can change the invariant using the smallest separating
  cases. Dimensions may include zero versus nonzero work, execution mode,
  resource tier, optional evidence, backend, or serialization state. A full
  Cartesian product is needed only when its coverage adds material evidence.

## Integration and evidence deletion

Parallel agents may investigate separate surfaces. One serial integration owner
changes a shared semantic owner. Run the required integration falsifiers after
merges that affect their exercised source or interactions. Reuse evidence only
after verifying equivalent exercised source, dependencies and selection, and
explaining why the merge cannot change the relation. A final docs-only commit
with no changed consumer needs no replay. Preserve the original compute scope.

Before deleting a test, mutation probe, or policy check, name its protected
invariant and replacement falsifier. An implementation-shape check may be
deleted, but a current scientific or public-contract obligation keeps one
behavioral witness.

Record and verify the interpreter, installed dependency versions against the
supported range, import origin, source revision, and source hashes before
classifying failures. Run source-mutating probes in an isolated worktree or
after all read-only review has finished. Never delete workspace files unless
the current task created them or ownership is otherwise established.

## Review output and implementation handoff

Freeze the requested review deliverables before parallel investigation. When
the user requests a durable uncapped report, write every accepted finding to
that report. A size-limited findings panel may mirror the highest-priority
subset, but it does not replace or limit the durable report.

Use a noncolliding output name and treat unknown tracked or untracked workspace
files as user-owned or another session's work. Do not delete, replace, or rename
one merely because its origin is unclear.

Match the user's requested action. A review-only or prompt-drafting request does
not authorize implementation or dispatch. Existing authorization to implement
and complete remediation persists through planning, delegation, and validation;
do not stop at another plan or ask again for an already authorized action. Apply
project-specific handoff requirements only to the projects that own them.

## Completion

A finding becomes `closed` only when:

1. its scoped relation and admitted domain are explicit and its semantic owner
   has the required executable or record change,
2. the original falsifier and relation-derived separating evidence apply to the
   integrated endpoint, through required checks or verified equivalence under
   the integration rule above, with no unaccounted same-scope gap,
3. public results, reports, documentation, and generated outputs agree,
4. no cleanup step removed the only behavioral witness, and
5. unresolved, unvalidated, or deferred behavior remains labeled as such.
