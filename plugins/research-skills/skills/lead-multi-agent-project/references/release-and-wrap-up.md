# Release and wrap-up

Read when the fix rounds have converged, and again when a change after the release checks reopens them.

## Release

- Once the code is stable, one readability pass over docstrings, comments and Markdown. The mathematics advisor checks every text that states mathematics.
- Test cleanup, presented to the user item by item for decision. A test of a notebook or of documentation goes when a human developer who fixes that notebook or document by hand would see it fail.
- Set the version number. Refresh the package metadata after the review's runs have finished, so that the shared environment does not change under them.
- Write the notebooks once, now that the code and the documentation are stable, with `library-example-notebooks`. Re-execute them, and check their displayed values and figures by eye against the library's records and the advisor's independent reruns. The notebook brief states which notebook checks the test policy keeps; values the checks do not cover are checked by eye. Notebook findings of the review rounds wait for this step.
- Run the full mutation campaign that the plan's verification policy includes once, without further deliberation. Run a full suite again only if library code changed after the last one, on the platforms whose code path changed. Documentation, notebooks and the version number need none, because the checks of their own files cover them.
- Run the second end-to-end review in a fresh session ([integration-and-review.md](integration-and-review.md)).
- Write the pull-request text and a summary for the user, each in the language the user wants for it.
- Push, merge into the main branch, release and archive wait for the user's instruction.

## Checks reopened by a later change

A change after the release checks, such as a follow-up the user adds or a fix of a late finding, does not rerun them as a block. The principal judges each check from the diff since that check's last run, reports the judgment, and waits for no decision, since skipping a check adds no work and no cost. For each check it records the commit the check ran on and what changed after it, in the validation record and the pull-request text. (NWQLib 0.99.1: two follow-ups after the release checks, a documentation policy and a one-module fix of archive reopening, needed one full suite on one platform, and the principal judged this only when the user asked.)

- The full suite reruns on each platform whose code path the diff touches, as before a review ([integration-and-review.md](integration-and-review.md)), and a change to an entry point every extension passes through gets it, as at integration.
- The mutation campaign reruns when the diff can lower what the tests detect: a test deleted, trimmed or weakened, a probe added or moved, or a change at a probe site or on the path from its killing test to it. A change that only admits more inputs, or changes text, leaves the campaign's result standing.
- A change to documentation, notebooks or the version number needs only the checks of its own files.

## Wrap-up

- Record the statistics of the run: the verification runs and their time, the rebases, the results of each review round, and the measured duration of each job kind, which the next run's stop conditions use.
- Ask the user which settings the next run must ask for at its start, then write the lessons where the project keeps them.
- Remove the temporary worktrees and branches once their content is confirmed integrated. Handle the working and review directories as the project's rules say, and move lasting records into the project's memory.
- Write the handoff for the next principal with this skill named in its first section.
