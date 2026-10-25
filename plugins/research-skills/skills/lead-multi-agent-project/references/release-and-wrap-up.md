# Release and wrap-up

Read when the fix rounds have converged, and again for any change after the release checks.

## Release

- Once the code is stable, the assigned reviewers check the assembled documentation for readability, scientific consistency and the public workflow, closing local corrections under [Documentation jobs](plan-and-dispatch.md#documentation-jobs). The final reading can serve the release check without another reviewer session.
- Test cleanup follows its authorized scope and the plan's test policy. Preserve independent detectors of public behavior and scientific claims, including those exercised through notebooks. A wording-only test that protects no current obligation may go. Removing a supported capability or its only evidence remains a decision under the user's authority.
- Set the version number. Refresh the package metadata after the review's runs have finished, so that the shared environment does not change under them.
- Write the notebooks once, now that the code and the documentation are stable, with `library-example-notebooks`. Re-execute every notebook, since stored outputs come from older library versions and a source comparison does not see them go stale, and check their displayed values and figures by eye against the library's records and the advisor's independent reruns. The notebook brief states which notebook checks the test policy keeps; values the checks do not cover are checked by eye. Notebook findings of the review rounds wait for this step.
- Run the full mutation campaign that the plan's verification policy includes once, without further deliberation. Run a full suite again only if library code changed after the last one, on the platforms whose code path changed. Documentation, notebooks and the version number need none, because the checks of their own files cover them. A change after these checks does not rerun them as a block: the rule for the expensive checks in [integration-and-review.md](integration-and-review.md) decides each rerun.
- Complete the final formal round's end-to-end and previous-release checks with its assigned reviewers ([integration-and-review.md](integration-and-review.md)). Reuse the completed verdicts at release.
- Run the project's required final lint, build and policy commands on the actual delivery surface, including notebooks when the project checks them. Record the invocation, revision and exclusions. A source-file-only pass is not a full-delivery pass. The existing owner repairs an omitted or failing surface, followed by its affected checks and integration review.
- When the user stops the reviews, as after a light round with small findings, the close-out skips the final suite and the reviewers' verification on the user's word and records that it did.
- Write the pull-request text and a summary for the user, each in the language the user wants for it.
- Push, merge into the main branch, release and archive wait for the user's instruction.

## Wrap-up

- Record verification, review outcomes, integrations, measured job durations and available usage with their window and classification limits. Keep elapsed time, cumulative model usage and concurrency distinct. A workflow revision does not establish savings without a comparable before-and-after measurement.
- Ask the user which settings the next run must ask for at its start, then write the lessons where the project keeps them.
- Remove the temporary worktrees and branches once their content is confirmed integrated and no reviewer or advisor is still pinned to them; the ledger names each worktree's active consumers. Handle the working and review directories as the project's rules say, and move lasting records into the project's memory, kept under version control: a damaged record can be rebuilt from its last full read in the session transcript plus the session's own edits, but other sessions' edits in between are lost.
- Write a compact current handoff naming this skill, the revision, rules, open obligations, next actions and evidence owners. Link dated history separately and verify that current entries agree with the final source and results.
