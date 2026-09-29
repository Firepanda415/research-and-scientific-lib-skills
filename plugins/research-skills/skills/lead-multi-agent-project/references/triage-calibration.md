# Triage calibration

Read before each triage and before writing its fix briefs. The examples come from NWQLib 0.99, where the user corrected the principal's triage. When the user corrects a triage in a later run, record the item and the reason in the project's lessons in the same form, and read the examples recorded there before each triage.

## Looked serious, were minor

Each fails the three questions: no wrong result, no blocked user, no wrong decision.

- A work charge used only to admit plans was not an exact upper bound, and three rounds added missing operations to it. Calling it a nominal charge was the cheapest correct change; its last completion went ahead only because the derivation and code already existed.
- A verification gap was reported as 0 after 2^60 was added to the objective, a precision limit of binary64.
- Two rounded budget fields summed to 8.67e-19 more than the total.
- A NaN appeared at an edge that no caller reaches.
- Notebook text differed slightly from the behavior. That is a text item for the release step.

## Were important

- A refusal did not say what to change.
- A headline number could not, under the default readout, reflect the evolution it summarized.
- A keyboard interrupt was recorded as a failure.
- A resource estimate reported zero shots.
- A guide example raised an error when run as printed.
- A fix broke resuming from a relative directory.

## A triage the user corrected

The principal first recommended fixing nearly all of about 36 findings, some of them completely, the user accepted the recommendation, and the principal sent 15 derivation requests. When the user asked whether a trivial notebook-text item would need a round of verification and review, the principal only added a rule that plain text needs no advisor review. The user then asked for a new triage from first principles. Three items became claim corrections with the improvement deferred, two charge completions became nominal-charge wording, and seven items were not fixed. Eleven small code changes remained, and the estimate fell from 6 to 10 hours to 3 to 5. The user then restored the fixes whose complete derivation and code already existed and that changed little else.

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
