The linter uses only the Python standard library and needs Python 3.7 or later.
Run it with any such interpreter, by absolute path when the project requires
one, and resolve the script and prompt paths before running it. A command
template is:

```bash
"${job_prompt_python:?set the verified absolute interpreter path}" -B \
  "${job_prompt_linter:?set the absolute scripts/lint_job_prompt.py path}" \
  "${job_prompt_file:?set the actual prompt path}" --kind job
```

A prompt returned only in chat has no file path. Lint it by passing `-` as the prompt path and sending the text on standard input, or by writing it to a temporary file outside the project checkout.

Use `--kind correction` for a correction. The linter checks job and correction prompts; a review request is neither, and linting one as a job reports only its date stamps and the absent deviations section as warnings. When the project prescribes a wrapper command for running code, invoke the linter through it. Errors block use. Warnings are review cues, not automatic failures. Lint errors, and warnings under `--strict`, exit with status 1. A prompt that cannot be read exits with status 2 after one line on standard error. Fill the template's `{{...}}` fields before dispatch. The linter does not replace the parent skill's [pre-dispatch evidence check](../SKILL.md#pre-dispatch-check).

Two warnings apply to any job-series prompt. One fires when the prompt names no version of its source plan, the other when it records no prerequisite: the accepted revision of an earlier job, the seam it relies on (the interface or invariant an earlier job provides to this one), or an explicit statement that there is none. Three warnings are conditional. The plan-clause coverage warning applies when the project records which job covers each plan clause, the closure-owner warning when it requires a full test run after targeted tests, and the new-test-module warning when it limits which test files a job may add. Use `--strict` only when the project requires warnings to block the handoff.

The `codex_delegation` check reports an error for a nested `<codex_delegation>` wrapper, because the job should be dispatched as plain Markdown rather than inside another delegation wrapper. The agent-name warning is a review cue. Naming agents or sessions is appropriate when the job depends on a specific host's tools or when a carried standing rule names a product, such as an authorship rule. Use `--handoff-token` or `--require-handoff-instruction` only when the dispatch workflow requires a literal final completion line.
