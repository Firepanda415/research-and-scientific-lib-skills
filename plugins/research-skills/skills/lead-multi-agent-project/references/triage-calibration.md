# Triage calibration

Read before each triage and its fix briefs. Judge findings against the current public contract, actual consumers and the user's decisions. Consult the project's recorded cases when they resolve a current uncertainty. The historical examples below illustrate those distinctions.

## Looked serious, were minor

Each fails the three questions: no wrong result, no blocked user, no wrong decision.

- A work charge used only to admit plans was not an exact upper bound, and three rounds added missing operations to it. Calling it a nominal charge was the cheapest correct change; its last completion went ahead only because the derivation and code already existed.
- A verification gap was reported as 0 after 2^60 was added to the objective, a precision limit of binary64.
- Two rounded budget fields summed to 8.67e-19 more than the total.
- A NaN appeared in a private helper proven unreachable through supported entry points.
- Notebook text differed slightly from the behavior. That is a text item for the release step.

## Were important

- A refusal did not say what to change.
- A headline number could not, under the default readout, reflect the evolution it summarized.
- A keyboard interrupt was recorded as a failure.
- A resource estimate reported zero shots.
- A guide example raised an error when run as printed.
- A fix broke resuming from a relative directory.

## Trace the contract before choosing text or code

Trace the affected value through its public inputs, producer and consumers before accepting a proposed remedy. Text alone closes a finding only when behavior and data already meet the contract. A source association that includes observations unused by the result remains a code defect when summaries, assessments or resource reports consume it, even if the result's main numerical value is correct. Correct the producing owner and independently verify the affected paths.

Separate public reachability from internal use. A documented argument combination can be valid without an internal caller. Examine each proposed deletion and each fixture on its own: a public use without mocks, a real but uncommon workflow, and a synthetic test path need different evidence. Keep or replace an independent detector of the public obligation when consolidating tests.

## Settings, limits and guards

Determine the intended scale, default and promised precision before refining a safety limit. A coarse admission charge may need a useful remedy direction rather than a byte-exact retry value. Extra precision machinery needs a current contract or user benefit. Conversely, a supported edge case is not dismissed merely for being unusual. Adjusting a default or widening an allowed workload follows the user's resource authority.

A suggested correction is a hypothesis, including one from the principal or counselor. Check its premises against the code and intended contract before commissioning a derivation or implementation.

For archive guards, identify the supported format, compatibility and integrity obligations. A hand-edited fixture alone neither proves a guard useful nor makes it disposable. Preserve checks that protect a current boundary, and remove those protecting no supported obligation only after tracing consumers.

## Local documentation corrections

A documentation finding closes under the rule in [plan-and-dispatch.md](plan-and-dispatch.md#documentation-jobs) only when its scientific basis and actual consumers are established. A short qualifier can change a bound, so a qualifier without that basis goes to the mathematics advisor.

## Why fixes did not hold

In the first four fix rounds, 29 to 52 percent of the items each round changed came back partial, and each changed item brought 0.38 to 0.56 new findings. The causes repeated.

| Cause | NWQLib 0.99 example | Rule that prevents it |
| --- | --- | --- |
| Other places stating the same claim were not changed | A behavior fix left the options documentation, a constants-table row and the guide describing the old default. Another fix changed only the sentence its witness pointed to, while five other places repeated the claim. | Each fix changes every place that states its claim. The brief lists them and the review of fixes checks them. |
| A change was not carried to every consumer | A migration changed the six direct reads the plan listed and missed a consumer that read the same data another way, a new regression. | Trace every consumer of the changed representation, not only the hits of one search. |
| No detector, or a detector on the wrong path | A new test ran through a path the old code already refused, so removing the fix left it passing. A test trim deleted the only detectors of two mutations. | A detector fails before the fix on the defect's path. Before deleting a test, check whether it is some probe's only detector. |
| Mathematics not sent to the advisor, sent in part, or its premises not followed | A scaling claim written into a brief without the advisor failed on another code path. A request asked about point weights and missed an integral. An implementation ignored the derivation's premise that no intermediate overflows or underflows and underestimated a budget by more than eight orders of magnitude. | The mathematics rules in SKILL.md. |
| A review's description or remedy taken as fact | A review counted three passes where the code made four. A suggested remedy made one overflow case worse. | A review's description and proposed change are hypotheses. Check them against the code, and have a mathematical remedy derived. |
| Failure to observe merged with an observed empty value | Any database error while opening a journal counted as "no header", so a round with real work was recorded as zero work. | Keep "could not read" apart from "read, and empty". |
| A new check placed where every path passes | An admission check in a constructor every plan uses rejected plans that never use the checked construction. | Place a check where its premise applies. |
| A remedy in a message not derived | Retrying with the value a refusal suggested would have been refused again 43 to 118 times. | A remedy direction is mathematics: derive what happens when the user follows it. |
| A normalization that dropped later behavior | Normalizing an ignored option to its default lost the user's value when a later change made the option matter. | Check what a normalization does to later changes of the object. |
| A chain of smallest changes grew a subsystem | 0.99.1: three verification rounds on one domain check, each smallest change adding exact-arithmetic machinery for the next input class, about 1.5 hours; the chain was visible at the first partial. | Judge the accumulated chain at every partial, and ask the verifier of a replaced validation to enumerate the input classes the old one covered. |
| A decision of the principal resting on an unchecked premise | A cost convention assumed that a halving was fused into each layer, while the code performed the halvings as separate operations. | Check a decision's premises against the code, and send its mathematics to the advisor. |
| A limit deferred by the principal alone | 0.99.1: a verifier found that archives of unevaluated objectives could not be reopened, a limit shared with 0.99.0 and fixed in one module; the principal filed it as a known limitation, and the user had it fixed after the release checks. | A limitation a reviewer or verifier finds is a triage item, pre-existing included. When its fix is small, the user decides whether it is fixed now or deferred, or the principal and the counselor when the user is away. |
| A breaker that stopped nothing | 1.0: a feature rolled through six consecutive jobs by way of review findings, each job delivered and each review opening the next; the breaker counted only undelivered items, and the principal then wrote a breaker record alone and dispatched the next job anyway. | Count every follow-up on one feature, whatever produced it and delivered ones included; the second consecutive one goes to the counselor before dispatch, and the rule lives in the file the principal rereads after compaction. A local correction closed by its reviewer is not a follow-up. |
