# Test surface

Purpose: sweep low-value, duplicated, or implementation-coupled tests and the test-only production seams they keep alive, without losing the only proof of a contract.

Read this reference when the cut targets tests, fixtures, test support, or production code whose only callers are tests, from one test file to a whole subsystem's test surface. [Ponytail's test necessity](../../ponytail/SKILL.md#test-necessity) decides which tests earn a permanent place. [Scientific evidence conservation](research-software-evidence.md) owns the audit of deleted evidence for scientific claims, including mutation probes and self-certifying replacements. This reference adds what a sweep looks for, how it proves each cut, and the order of a campaign.

## Judge a test by its assertions

Read the complete candidate test, the relevant production flow, overlapping assertions, and how the project runs them. Trace shared owners and sibling paths when the cut can affect them. Consult history when the purpose remains unclear, and dependency source or types when the decision relies on that dependency's guarantee. Judge by the assertions, not the name.

A test that would break under a behavior-preserving refactor asserts implementation rather than behavior. In a sweep it is suspect, not automatically deletable. When it guards a contract, rewrite it at the owning boundary. Static or slow is not a deletion reason, and a test that resembles implementation may still be the independent contract, so prove otherwise before removing it.

Keep a test that independently enforces a public API, protocol, configuration, migration, storage, security, platform, default, package, release, or architecture contract, or a contract between generated code in two languages. Also keep call ordering when the order is observable behavior, a regression with a credible failure mode, and source inspection when it is the cheapest independent guard, because it fails when the user-facing key, byte, or path changes and survives an identifier-only refactor.

A kept test that fails on the baseline is a possible product bug. Reproduce it within the authorized checks and report it, or repair the owner when authorized, with applicable failing-before and passing-after evidence. Do not delete it to make the suite green.

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

When several suites cover one contract, name the keeper and the assertions to carry into it. Exercise the real implementation through the owning boundary, using existing fixtures for external effects. Neither the fixture nor a mock may implement the behavior the test claims to verify.

## Test-only production seams

A test that needs a production seam no production caller needs, such as an export, flag, wrapper, injection parameter, getter, reset hook, or indirection layer, belongs at the real boundary. Move it there and delete the seam in the same batch. Count that production deletion as part of the cut, and prefer a batch whose production line count goes down.

## Evidence per candidate

Use the proof record in SKILL.md proportionally. For a focused cut, brief notes need only:

- the exact test and the failure it can detect;
- the independent proof that remains, or why the contract needs none;
- any seam being removed and its non-test consumers;
- the risk and the smallest check that would expose a wrong cut.

Add history, CI routing, and production or support-code consequences when they change the decision. For a broad sweep, give each test declaration one mark, and each row of a parameter table its own mark when the rows differ:

- `R`: keep, naming the contract and the bug it catches. A move to a better-named file stays `R`, with the move noted.
- `F`: keep the contract but repair the assertion, such as a vacuous negative that passes when only one of several items is missing.
- `C`: consolidate, naming the owner that absorbs the assertion first, such as a sibling table case, a stronger boundary suite, or the shared owner in another package.
- `D`: delete, naming the proof that remains, or why no contract exists.

## Edit shape

Edit one owner boundary per batch. Delete obsolete test-only exports, globals, wrappers, and dead production paths rather than keeping aliases. Move kept regressions to their canonical owner. Consolidate repeated package or dependency assertions into one generic contract. Add no replacement test that restates the same implementation, and do not turn an uncertain candidate into cleanup to raise the deletion count. Route edits to shared harnesses and support files through one owner, and register moved suites wherever the project routes or inventories its tests.

## Validate

Never edit tests or source while the suite runs in the checkout. Run the smallest owner and sibling tests in the project's declared environment, then the repository's own gate for changed files when it has one. For a removed source grep or plan assertion, run the executable or dry run that owns the real contract. Report production and tooling lines separately from tests and test support.

Compare deleted assertions against the keepers, checking for lost contracts and assertions that cannot fail for the claimed defect. Scale this review to evidence changes and unresolved risk. A file move or proved duplicate needs no separate review campaign. Use an independent reviewer when a consequential transfer across owners or uncertain detector coverage warrants one and delegation is authorized. Reuse applicable pre-fix failures or mutation evidence. Add a small deliberate breakage only when detector strength remains uncertain and the cost is justified, and verify restoration afterwards. For scientific claims and maintained mutation probes, apply the deleted-evidence steps in [scientific evidence conservation](research-software-evidence.md#audit-the-deleted-evidence-not-only-the-surviving-code).

## Campaign: one subsystem's whole test surface

A requested subsystem-wide cleanup uses Broad scope and Change mode. Group work by production owner and finish each cut's validation before starting the next. Use the following stages to track coverage, without requiring a separate agent or report for each stage.

1. **Baseline and coverage.** Record the revision, verification commands and baseline failures. Inventory the in-scope tests and their production owners, including cases at shared boundaries, examples, notebooks and probes. Record counts when needed to assess the claimed reduction.
2. **Decisions.** Read each candidate in full and mark every in-scope test or distinct parameter row. Name the keeper per contract, assertions to transfer, and seams each cut removes. Resolve uncertain candidates before cutting them. Delegated reviews, when useful and authorized, follow these same ownership groups.
3. **Cutover.** Edit and validate one owner at a time. Transfer necessary assertions before deleting their old home, remove obsolete seams, and register moved suites in the project's existing test routing. Update affected project guidance and gates when their contract changes.
4. **Preservation.** Apply the review above and close every coverage gap with evidence. Keep baseline product defects separate from cleanup, repair them when authorized, and report unresolved defects. A repair needs applicable failing-before and passing-after evidence through the affected behavior.
5. **Integration.** Follow the project's integration policy. Reconcile upstream changes with the keepers so new contracts and regressions still have a home. Run the required subsystem checks on the integrated revision, reusing still-applicable evidence and reporting remaining limits.

Report the removed obligations, keepers, material evidence changes, verification actually run, and unresolved work. Include production and test counts separately when claiming a reduction, and explain important rejected cuts when they affect the conclusion.

Adapted from the `test-audit` skill and its campaign guide in [OpenClaw](https://github.com/openclaw/openclaw/tree/main/.agents/skills/test-audit), Copyright (c) 2026 OpenClaw Foundation, under the [MIT notice](../../../LICENSES/OPENCLAW-MIT.txt). The adaptation removes that repository's tooling and commands, maps its modes onto this skill's Survey, Change, Focused, and Broad, sends the value bar to Ponytail's test necessity and the audit of deleted scientific evidence to the reference above, and adds notebooks, examples, and mutation probes to the surfaces a lane covers.
