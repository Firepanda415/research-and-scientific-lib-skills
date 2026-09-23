# Maintaining this collection

This repository is the source for the `research-skills` Codex and Claude Code plugin. Keep its
skills, references, scripts, and writing hook together under
`plugins/research-skills/`. Do not edit installed plugin caches as source.

Keep reusable skills independent of individual projects. Abstract transferable decision rules into skills, and keep a user's project-specific paths, document layout, environment commands, and work-in-progress state in that project's own guidance. Skills consume that guidance when the current task requires it.

When asked to install this repository, follow README.md's plugin installation
for the requested host. Install the single `research-skills@research-skills` plugin.
Both hosts receive every skill and the writing hook.
Do not copy only SKILL.md files or install a second
Ponytail plugin. Let Codex handle hook trust, and do not bypass or manufacture it.

Codex keys hook trust by each handler's position (event, matcher group, and
handler index) and hashes each handler's registration fields (command, matcher,
timeout, statusMessage, and async), not the script body. Add new handlers or
matcher groups at the end of an event. Do not insert them before existing
handlers or reorder existing handlers. A change to a registration field or to
handler order needs a release note telling users to trust the research-skills
hooks again in `/hooks`.

Preserve upstream notices and the component license boundaries in LICENSE.md.
Keep README.md and README.zh-CN.md in sync, including every skill and its source.
Document third-party sources and modifications in the plugin NOTICE.md, and
update its LICENSE.md when the applicable terms differ.

For package changes, run `node --test plugins/research-skills/tests/*.test.js`
and `python3 scripts/check-package.py`. The latter needs PyYAML from
`requirements-dev.txt` in the interpreter that runs it, and it also builds the
Claude package offline in a temporary directory. For changes to the job-prompt
linter, also run
`(cd plugins/research-skills/skills/write-implementation-job-prompts/scripts && python3 -B -m unittest test_lint_job_prompt)`.
Use the existing local script checks when their implementation changes. Do not
run LLM benchmarks merely to validate packaging.

Once per release, run `python3 scripts/install-local.py --prepare-only` so
installed caches can refresh, then run `python3 scripts/check-package.py --release`.
Without `--release`, the check only warns when the content version is stale.
Keep the `version` in `plugins/research-skills/package.json` equal to the base
version in `plugins/research-skills/.codex-plugin/plugin.json`, because the
package check fails when they differ.
