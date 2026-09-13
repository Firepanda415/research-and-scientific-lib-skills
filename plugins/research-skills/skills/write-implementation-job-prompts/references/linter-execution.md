Resolve the supported interpreter to an absolute path from the current project
or skill-tooling environment, and resolve the script and prompt paths before
running the linter. A command template is:

```bash
"${job_prompt_python:?set the verified absolute interpreter path}" -B \
  "${job_prompt_linter:?set the absolute scripts/lint_job_prompt.py path}" \
  "${job_prompt_file:?set the actual prompt path}" --kind job
```

Use `--kind correction` for a correction. For NWQLib-related execution, use the
checked-command form from its live environment rules instead of invoking the
interpreter directly. Errors block use; warnings are review cues, not automatic
failures. Fill the template's `{{...}}` fields before dispatch; the linter does
not replace the pre-dispatch evidence check above.
