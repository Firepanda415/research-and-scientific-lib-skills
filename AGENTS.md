# Maintaining this collection

This repository is the source for the `research-skills` Codex plugin. Keep its
skills, references, scripts, and Ponytail hooks together under
`plugins/research-skills/`. Do not edit installed plugin caches as source.

When asked to install this repository, follow README.md's standard Codex plugin
installation. Install the single `research-skills@research-skills` plugin, which
contains the full collection. Do not copy only SKILL.md files or install a second
Ponytail plugin. Let Codex handle hook trust; do not bypass or manufacture it.

Preserve upstream notices and the component license boundaries in LICENSE.md.
Keep README.md and README.zh-CN.md in sync, including every skill and its source.
Document third-party sources and modifications in the plugin NOTICE.md, and
update its LICENSE.md when the applicable terms differ.

For package changes, run `node --test plugins/research-skills/tests/*.test.js`
and `python3 scripts/check-package.py`. The latter needs PyYAML for validation.
Use the existing local script checks when their implementation changes. Do not
run LLM benchmarks merely to validate packaging. Change the plugin version when
releasing an update so installed caches can refresh.
