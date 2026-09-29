# Test surface

Purpose: sweep low-value, duplicated, or implementation-coupled tests and the test-only production seams they keep alive, without losing the only proof of a contract.

Read this reference when the cut targets tests, fixtures, test support, or production code whose only callers are tests, from one test file to a whole subsystem's test surface. [Ponytail's test necessity](../../ponytail/SKILL.md#test-necessity) decides which tests earn a permanent place. [Scientific evidence conservation](research-software-evidence.md) owns the audit of deleted evidence for scientific claims, including mutation probes and self-certifying replacements. This reference adds what a sweep looks for, how it proves each cut, and the order of a campaign.

## Judge a test by its assertions

Before judging a candidate, read the complete test and its production owner, the owner's entry point, callers, callees and sibling implementations, the overlapping tests, how the project routes the test in CI, and the history of both. When a test claims behavior backed by a dependency, read that dependency's source or types. Judge by the assertions, not the name. (In the source campaign, a test named for retiring a progress window asserted that the window was not cleared.)

A test that would break under a behavior-preserving refactor asserts implementation rather than behavior. In a sweep it is suspect, not automatically deletable. When it guards a contract, rewrite it at the owning boundary. Static or slow is not a deletion reason, and a test that resembles implementation may still be the independent contract, so prove otherwise before removing it.

Keep a test that independently enforces a public API, protocol, configuration, migration, storage, security, platform, default, package, release, or architecture contract, or a contract between generated code in two languages. Also keep call ordering when the order is observable behavior, a regression with a credible failure mode, and source inspection when it is the cheapest independent guard, because it fails when the user-facing key, byte, or path changes and survives an identifier-only refactor.

A kept test that fails on the baseline is a possible product bug. Reproduce it and repair the owner, with a control run that reverts the repair and shows the old behavior. Do not delete it to make the suite green.

## Candidate patterns

A sweep hunts for these, beside the self-certifying checks listed in [scientific evidence conservation](research-software-evidence.md#reject-self-certifying-replacements):

- assertion-free probes, whose only claim is that a call did not raise;
- self-comparisons and identity copies;
- copied fixtures, inventories, manifests, or export lists that mirror the source;
- exact greps of source, imports, or strings when that text is not the contract;
- private predicate or call-shape tests duplicated at a real boundary;
- repeated invocations of one contract, and local replays of a shared helper;
- tests whose only purpose is to keep a test-only export, global, or wrapper alive;
- production code whose only callers are tests;
- mocks that implement the behavior being asserted, or one identical mock standing in for different APIs;
- fixtures that supply the ordering, receipt, or callback the owner should produce, or persistence asserted against a store the path never writes;
- capability tests that restate a declared flag instead of exercising what the flag promises;
- negative controls that pass for an unrelated reason, such as a rejection from a different guard or one the production path never reaches;
- names or fixtures that promise more than the input exercises.

## One owner per contract

Each contract has one primary test at the strongest boundary. Another layer is justified only by a distinct risk that owner cannot reach, such as a transport or lifecycle failure. A bug gets one regression test at the owner boundary, not one at every layer it crosses, and a new case extends a table-driven test or shared fixture before it becomes a near-duplicate test.

When several suites cover one contract, name the keeper and the assertions to carry into it. Prefer the real boundary with a fake network or file system over a mocked collaborator. (In the source campaign, several dispatch suites replayed one shared helper through a mocked preview, next to stronger suites at the real stream and a recorded HTTP fixture.)

## Test-only production seams

A test that needs a production seam no production caller needs, such as an export, flag, wrapper, injection parameter, getter, reset hook, or indirection layer, belongs at the real boundary. Move it there and delete the seam in the same batch. Count that production deletion as part of the cut, and prefer a batch whose production line count goes down.

## Evidence per candidate

The proof record in SKILL.md applies, with these fields for a test or seam. A missing field means the candidate is not ready for deletion:

- the exact test and its location;
- the failure it can detect;
- the non-test callers of every seam it uses;
- the stronger surviving proof at the owner boundary, or why none is needed;
- the history and the reason the test or seam exists;
- the production or test-support deletion it unlocks;
- the risk and the focused validation command.

Give each test declaration one mark, and each row of a parameter table its own mark when the rows differ:

- `R`: keep, naming the contract and the bug it catches. A move to a better-named file stays `R`, with the move noted.
- `F`: keep the contract but repair the assertion, such as a vacuous negative that passes when only one of several items is missing.
- `C`: consolidate, naming the owner that absorbs the assertion first, such as a sibling table case, a stronger boundary suite, or the shared owner in another package.
- `D`: delete, naming the proof that remains, or why no contract exists.

## Edit shape

Edit one owner boundary per batch. Delete obsolete test-only exports, globals, wrappers, and dead production paths rather than keeping aliases. Move kept regressions to their canonical owner. Consolidate repeated package or dependency assertions into one generic contract. Add no replacement test that restates the same implementation, and do not turn an uncertain candidate into cleanup to raise the deletion count. Route edits to shared harnesses and support files through one owner, and register moved suites wherever the project routes or inventories its tests.

## Validate

Never edit tests or source while the suite runs in the checkout. Run the smallest owner and sibling tests in the project's declared environment, then the repository's own gate for changed files when it has one. For a removed source grep or plan assertion, run the executable or dry run that owns the real contract. Report production and tooling lines separately from tests and test support.

For a batch beyond one file, add a preservation review before claiming completion. Independent reviewers, one per boundary group, compare the deleted coverage against the keepers and look for contracts that lost their only proof and for new assertions that cannot fail, such as a rejection row the production code never reaches. For each restored contract, make one deliberate mutation of the production owner, confirm that the keeper fails, and restore the source byte for byte. Where the project keeps mutation probes, the deleted-evidence steps in [scientific evidence conservation](research-software-evidence.md#audit-the-deleted-evidence-not-only-the-surviving-code) apply as well.

## Campaign: one subsystem's whole test surface

A campaign prunes every test file a subsystem owns, in Broad scope and Change mode, in one change. Each step ends on its completion criterion, and the next does not start early.

1. **Baseline.** Record the subsystem's test and support line counts and every test file's pass or fail state at a pinned revision. List baseline failures separately. (In the source campaign, all three were real delivery bugs.) Done when every in-scope file has a recorded result.
2. **Lanes.** Split the surface along production owner boundaries, not file prefixes, and include the subsystem's cases at shared boundaries and its notebooks, examples, live scenarios, and probes. Done when every file belongs to exactly one lane.
3. **Ledger.** Give each lane to its own read-only agent, which reads every assigned test in full, including parameter tables, with the production owners, their entry points, callers, history, and CI routing, and writes one mark and one evidence line per declaration. Done when every declaration is marked.
4. **Layer plan.** A second read-only pass starts from the ledger and looks for the redundant layer. It names the keeper per contract, the assertions to carry, and the seams unlocked, and corrects ledger errors it finds. Done when each lane plan names these.
5. **Cutover.** Edit lane by lane. Remove the seams each lane unlocks, register moved suites, update shrink-only line caps, and put durable test-ownership rules in the project's own guidance, drawn from mistakes the campaign found. Done when every lane plan is applied and each lane's keepers pass.
6. **Preservation review**, as above. (The source campaign found nine real gaps and one unreachable assertion.) Done when every gap is restored or rejected with source evidence and every restored contract has a caught mutation.
7. **Product defects.** A baseline failure that survives into a keeper is a bug report. Fix it at its owner in a separate commit and prove it through the real user flow, with a control run that reverts the fix. Record unrelated discrepancies as follow-ups. Done when each repair has a failing control and a passing candidate on the same harness.
8. **Reconcile and hand off.** Merge the main branch rather than rebasing a long campaign. When the main branch changed a file the campaign deleted, keep the deletion and port the new contract into the keeper, and confirm that every regression the main branch added still has a home. Rerun the whole subsystem suite on the merged head. Record maintainer decisions on generic compatibility flags in the change's evidence rather than by editing gates.

Hand off with the removed low-value categories and their root cause, the production owner simplifications, the kept false positives and why they remain valuable, the proof actually run, the baseline and final counts with production separate, the lanes, retired layers, and keepers, the preservation gaps and their mutations, the product defects with their control and candidate proof, and the named follow-ups.

Adapted from the `test-audit` skill and its campaign guide in [OpenClaw](https://github.com/openclaw/openclaw/tree/main/.agents/skills/test-audit), Copyright (c) 2026 OpenClaw Foundation, under the [MIT notice](../../../LICENSES/OPENCLAW-MIT.txt). The adaptation removes that repository's tooling and commands, maps its modes onto this skill's Survey, Change, Focused, and Broad, sends the value bar to Ponytail's test necessity and the audit of deleted scientific evidence to the reference above, and adds notebooks, examples, and mutation probes to the surfaces a lane covers.
