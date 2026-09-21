Resolve the supported interpreter to an absolute path from the current project
or skill-tooling environment, and resolve the script and prompt paths before
running the linter. A command template is:

```bash
"${job_prompt_python:?set the verified absolute interpreter path}" -B \
  "${job_prompt_linter:?set the absolute scripts/lint_job_prompt.py path}" \
  "${job_prompt_file:?set the actual prompt path}" --kind job
```

Use `--kind correction` for a correction. When the project requires a checked runner, invoke the linter through it. Errors block use. Warnings are review cues, not automatic failures. Fill the template's `{{...}}` fields before dispatch. The linter does not replace the parent skill's [pre-dispatch evidence check](../SKILL.md#pre-dispatch-check).
