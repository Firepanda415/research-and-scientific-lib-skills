# Release and wrap-up

Read when the fix rounds have converged.

## Release

- Once the code is stable, one readability pass over docstrings, comments and Markdown. The mathematics advisor checks every text that states mathematics.
- Test cleanup, presented to the user item by item for decision. A test of a notebook or of documentation goes when a human developer who fixes that notebook or document by hand would see it fail.
- Set the version number. Refresh the package metadata after the review's runs have finished, so that the shared environment does not change under them.
- Write the notebooks once, now that the code and the documentation are stable, with `library-example-notebooks`. Re-execute them, and check their displayed values and figures by eye against the library's records and the advisor's independent reruns. The notebook brief states which notebook checks the test policy keeps; values the checks do not cover are checked by eye. Notebook findings of the review rounds wait for this step.
- Run the full mutation campaign that the plan's verification policy includes once, without further deliberation. Run a full suite again only if library code changed after the last one. Documentation, notebooks and the version number need none, because the checks of their own files cover them.
- Run the second end-to-end review in a fresh session ([integration-and-review.md](integration-and-review.md)).
- Write the pull-request text and a summary for the user, each in the language the user wants for it.
- Push, merge into the main branch, release and archive wait for the user's instruction.

## Wrap-up

- Record the statistics of the run: the verification runs and their time, the rebases, and the results of each review round.
- Ask the user which settings the next run must ask for at its start, then write the lessons where the project keeps them.
- Remove the temporary worktrees and branches once their content is confirmed integrated. Handle the working and review directories as the project's rules say, and move lasting records into the project's memory.
