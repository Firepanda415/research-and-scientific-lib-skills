Resolve the supported interpreter to an absolute path from the current project
or skill-tooling environment, and resolve the script and prompt paths before
running the linter. A command template is:

```bash
"${job_prompt_python:?set the verified absolute interpreter path}" -B \
  "${job_prompt_linter:?set the absolute scripts/lint_job_prompt.py path}" \
  "${job_prompt_file:?set the actual prompt path}" --kind job
```

A prompt returned only in chat has no file path. Lint it by passing `-` as the prompt path and sending the text on standard input, or by writing it to a temporary file outside the project checkout.

Use `--kind correction` for a correction. When the project requires a checked runner, invoke the linter through it. Errors block use. Warnings are review cues, not automatic failures. Lint errors, and warnings under `--strict`, exit with status 1. A prompt that cannot be read exits with status 2 after one line on standard error. Fill the template's `{{...}}` fields before dispatch. The linter does not replace the parent skill's [pre-dispatch evidence check](../SKILL.md#pre-dispatch-check).

The plan-clause coverage, closure-owner, and new-test-module warnings apply only when the project uses closed contracts or clause ledgers. Use `--strict` only when the project requires warnings to block the handoff.

The `codex_delegation` check reports an error for a nested `<codex_delegation>` wrapper, because the job should be dispatched as plain Markdown rather than inside another delegation wrapper. The agent-name warning is a review cue. Naming agents or sessions is appropriate when the job depends on a specific host's tools or when a carried standing rule names a product, such as an authorship rule. Use `--handoff-token` or `--require-handoff-instruction` only when the dispatch workflow requires a literal final completion line.
