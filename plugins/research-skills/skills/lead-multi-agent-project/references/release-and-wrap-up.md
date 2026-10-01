# Release and wrap-up

Read when the fix rounds have converged, and again for any change after the release checks.

## Release

- Once the code is stable, one readability pass over docstrings, comments and Markdown. The mathematics advisor checks every text that states mathematics.
- Test cleanup, presented to the user item by item for decision. A test of a notebook or of documentation goes when a human developer who fixes that notebook or document by hand would see it fail.
- Set the version number. Refresh the package metadata after the review's runs have finished, so that the shared environment does not change under them.
- Write the notebooks once, now that the code and the documentation are stable, with `library-example-notebooks`. Re-execute every notebook, since stored outputs come from older library versions and a source comparison does not see them go stale, and check their displayed values and figures by eye against the library's records and the advisor's independent reruns. The notebook brief states which notebook checks the test policy keeps; values the checks do not cover are checked by eye. Notebook findings of the review rounds wait for this step.
- Run the full mutation campaign that the plan's verification policy includes once, without further deliberation. Run a full suite again only if library code changed after the last one, on the platforms whose code path changed. Documentation, notebooks and the version number need none, because the checks of their own files cover them. A change after these checks does not rerun them as a block: the rule for the expensive checks in [integration-and-review.md](integration-and-review.md) decides each rerun.
- Run the second end-to-end review in a fresh session ([integration-and-review.md](integration-and-review.md)).
- When the user stops the reviews, as after a light round with small findings, the close-out skips the final suite and the reviewers' verification on the user's word and records that it did.
- Write the pull-request text and a summary for the user, each in the language the user wants for it.
- Push, merge into the main branch, release and archive wait for the user's instruction.

## Wrap-up

- Record the statistics of the run: the verification runs and their time, the rebases, the results of each review round, and the measured duration of each job kind, which the next run's stop conditions use.
- Ask the user which settings the next run must ask for at its start, then write the lessons where the project keeps them.
- Remove the temporary worktrees and branches once their content is confirmed integrated and no reviewer or advisor is still pinned to them; the ledger names each worktree's active consumers. Handle the working and review directories as the project's rules say, and move lasting records into the project's memory, kept under version control: a damaged record can be rebuilt from its last full read in the session transcript plus the session's own edits, but other sessions' edits in between are lost.
- Write the handoff for the next principal with this skill named in its first section.
