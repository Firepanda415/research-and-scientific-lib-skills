# Research & Scientific Library Skills

[English](README.md) | [简体中文](README.zh-CN.md)

A collection of skills for Codex and Claude Code that I use for research and scientific software development. It covers research planning, literature searches, manuscript writing, figures, scientific computing, and code review. I update it as my work and needs evolve.

In both Codex and Claude Code, the plugin provides **all 27 skills**, including a customized Ponytail coding mode, and the writing hook.

## Install

### Codex

Give Codex this request:

> Install all skills and the writing hook from https://github.com/Firepanda415/research-and-scientific-lib-skills.

Or run:

```bash
codex plugin marketplace add Firepanda415/research-and-scientific-lib-skills
codex plugin add research-skills@research-skills
```

You need a Codex version with plugin marketplace support and Node.js on your `PATH` for the writing hook. Python 3 is needed only for the bundled Python helper scripts.

After every install or update, open `/hooks` in the Codex CLI and trust the research-skills entries. Until they are trusted, the writing route does not run. Then start a new task, and restart the app if it has not refreshed. See the [Codex hook setup guide](https://learn.chatgpt.com/docs/hooks#review-and-trust-hooks) for details.

If you already have the standalone Ponytail plugin, remove it through Codex’s plugin manager so that its hooks and duplicate Ponytail skills do not run alongside this plugin.

### Claude Code

With a current Claude Code version, Python 3, and Node.js on your `PATH`, run this command from the checkout's root:

```bash
python3 scripts/install-claude.py
```

The script builds a local marketplace under `~/.local/share/research-skills/claude-marketplace/` and installs `research-skills@research-skills` at user scope through the Claude CLI. It includes all 27 skills, their supporting files, and the writing hook. If the `claude` on your `PATH` is missing, fails to run, or is not the Claude Code you use, pass the current executable with `--claude-bin /path/to/claude`. The script prints the executable it uses. See the [Claude Code marketplace guide](https://code.claude.com/docs/en/plugin-marketplaces) for local marketplace behavior.

Rerun the script after changing the source, then start a new Claude Code session. Sessions and workflows already running keep the previous copy until they end. In a new session, invoke a skill by name, for example `/research-skills:scientific-library-review`. If Claude Code also has the standalone Ponytail plugin, uninstall it so that its hooks and duplicate skills do not run alongside this plugin.

After verifying the installation, remove matching manually copied skill folders from `~/.claude/skills/` to prevent duplicate discovery. Keep any backup outside that directory and preserve unrelated skills. Start a new Claude Code session after migration.

## Skills

Select a skill in Codex or Claude Code, or let the agent choose one that matches your request. Ponytail applies to implementation, debugging, refactoring, and read-only decisions about simplifying or retiring code, APIs and tests. `simplify-codebase` loads it for surveys and changes. Code-review, scientific-computing and implementation-handoff skills also load it when their task involves the design decisions described in each skill. The relevant correctness or review skill leads, and Ponytail works within its requirements without starting another audit. Factual code explanations and prose-only work do not trigger it.

Name a level (`lite`, `full` or `ultra`) in the conversation, for example `$ponytail lite` in Codex or `/research-skills:ponytail lite` in Claude Code, and it lasts until you name another or turn Ponytail off. `full` applies when no level is named. Say `stop ponytail` or `normal mode`, or use `$ponytail off`, to turn Ponytail off until you ask for it again in that conversation, which turns it back on at `full` unless you name another level. Companion skills respect that off state. `ponytail-help` lists the triggers for both hosts.

For text people will keep, revisit, share, publish, send, or paste elsewhere, the writing hook requires Codex or Claude Code to read and apply `research-writing-style` and its durable-prose reference before drafting or editing such text or reviewing its prose. This covers ordinary documents, emails, website copy, and paste-ready text in chat, in any language and at any length. Temporary chat summaries and progress updates are excluded. Material returned to another agent or a program, such as structured findings or search results, is also outside the route, and the agent that assembles it into a human deliverable applies the route. The route is injected at session start, after compaction, and for subagents. In Codex, open `/hooks` after every install or update and trust the research-skills entries. Until they are trusted, the writing route does not run. The hook supplies an instruction to load the skill, not a mechanical guarantee of prose quality.

The skill has two stages. Generation and editing apply sentence structure and word-choice guidance while composing. A required [adversarial review](plugins/research-skills/skills/research-writing-style/references/prose-review.md) then checks the complete draft's structure, paragraph functions, context, and reasoning before delivery. Review first identifies the source and role of extracted material, then challenges evidence, reader comprehension, and conversation or prompt leakage using the surrounding text. A writing instruction such as “do not discuss X” must not become an unsupported statement about the subject. Review-only requests start from the existing text and report substantiated findings without automatically rewriting it. Detector labels alone do not require edits. Explicit requests for detector-directed rewriting use the optional [detector evaluation](plugins/research-skills/skills/research-writing-style/references/detector-evaluation.md) workflow, which preserves meaning and records measured comparisons. Ordinary writing does not require detector checks. Lessons from rewriting trials about connecting choices, evidence, capabilities, and qualifications are part of the default generation and context-review guidance. The [adoption audit](plugins/research-skills/skills/research-writing-style/references/source-integration-audit.zh-CN.md) records the source coverage, qualified recommendations, and exclusions.

By default, the skill writes prose without semicolons, em dashes, or colons joining independent clauses, and without `retain`, `honest`, or their inflections. An explicit user instruction or a requirement of the destination, such as a journal style guide, takes precedence over these defaults.

| Skill | Purpose | Credits |
|---|---|---|
| [develop-research-ideas](plugins/research-skills/skills/develop-research-ideas/SKILL.md) | Develop and assess research directions, proposals, and ideas from other fields. | [1](#credit-1) |
| [rethink-design](plugins/research-skills/skills/rethink-design/SKILL.md) | Reconsider a limiting research question or design choice and assess a more ambitious alternative. | [2](#credit-2) |
| [upgrade-research-inputs](plugins/research-skills/skills/upgrade-research-inputs/SKILL.md) | Investigate literature, novelty, disputed claims, and missing primary evidence. | [11](#credit-11) |
| [stress-test-baselines](plugins/research-skills/skills/stress-test-baselines/SKILL.md) | Design or run fair comparisons, ablation studies, and robustness checks. | — |
| [write-research-log](plugins/research-skills/skills/write-research-log/SKILL.md) | Record experiments, observations, hypotheses, and predictions. | — |
| [research-watchdog-protocol](plugins/research-skills/skills/research-watchdog-protocol/SKILL.md) | Monitor long-running jobs and resume in-progress research across sessions. | — |
| [maintain-project-memory](plugins/research-skills/skills/maintain-project-memory/SKILL.md) | Maintain project decisions, reusable lessons, evidence limits, and a durable entry for later sessions. | [6](#credit-6), [7](#credit-7) |
| [quantum-research-radar](plugins/research-skills/skills/quantum-research-radar/SKILL.md) | Produce Chinese quantum research briefings and focused scans of recent work, including Quantum × AI. | — |
| [physics-from-math-explainer](plugins/research-skills/skills/physics-from-math-explainer/SKILL.md) | Explain physics-heavy mathematics with physical intuition and explicit conventions. | — |
| [tech-paper-template](plugins/research-skills/skills/tech-paper-template/SKILL.md) | Build a technical paper’s argument, Introduction, and section structure. | [1](#credit-1) |
| [benchmark-paper-template](plugins/research-skills/skills/benchmark-paper-template/SKILL.md) | Plan or assess your benchmark paper’s evaluation gap, construction, measurement design, and findings, in any field. | [1](#credit-1) |
| [research-writing-style](plugins/research-skills/skills/research-writing-style/SKILL.md) | Draft, edit, and adversarially review lasting prose and paste-ready text, with mandatory review before delivery and a review-only entry. | [3](#credit-3), [8](#credit-8), [9](#credit-9), [10](#credit-10) |
| [figure-designer](plugins/research-skills/skills/figure-designer/SKILL.md) | Design and assess scientific figures, diagrams, and reproducible plots. | [1](#credit-1) |
| [pre-submission-reviewer](plugins/research-skills/skills/pre-submission-reviewer/SKILL.md) | Check your manuscript’s scientific claims, consistency, presentation, and a revision's response to referees, before submission. | [1](#credit-1) |
| [journal-cover-letter](plugins/research-skills/skills/journal-cover-letter/SKILL.md) | Draft and revise journal submission cover letters. | — |
| [quantum-computing-review](plugins/research-skills/skills/quantum-computing-review/SKILL.md) | Prepare or assess referee reports on another author’s technical manuscript in any field, following venue and confidentiality requirements, with added checks for quantum computing and quantum technology work. | — |
| [scientific-computing-correctness](plugins/research-skills/skills/scientific-computing-correctness/SKILL.md) | Implement, debug, optimize, or independently validate scientific computations and their resource use. | — |
| [scientific-library-review](plugins/research-skills/skills/scientific-library-review/SKILL.md) | Review scientific libraries for mathematical correctness, usable workflows, and resource costs. | [7](#credit-7) |
| [deep-code-review](plugins/research-skills/skills/deep-code-review/SKILL.md) | Review code for domain correctness, engineering behavior, tests, and resource costs. Scientific libraries use `scientific-library-review`. | — |
| [simplify-codebase](plugins/research-skills/skills/simplify-codebase/SKILL.md) | Simplify a codebase while preserving its behavior and scientific meaning. | [4](#credit-4) |
| [write-implementation-job-prompts](plugins/research-skills/skills/write-implementation-job-prompts/SKILL.md) | Write implementation handoffs with clear scope and acceptance criteria. | — |
| [ponytail](plugins/research-skills/skills/ponytail/SKILL.md) | Keep coding decisions simple within correctness, accuracy, runtime, and memory requirements. | [5](#credit-5) |
| [ponytail-review](plugins/research-skills/skills/ponytail-review/SKILL.md) | Review a diff for opportunities to simplify. | [5](#credit-5) |
| [ponytail-audit](plugins/research-skills/skills/ponytail-audit/SKILL.md) | Report unnecessary complexity and justified deletions across a repository in a compact read-only audit. | [5](#credit-5) |
| [ponytail-debt](plugins/research-skills/skills/ponytail-debt/SKILL.md) | Collect documented shortcuts and the conditions for replacing them. | [5](#credit-5) |
| [ponytail-gain](plugins/research-skills/skills/ponytail-gain/SKILL.md) | Show the original Ponytail project’s published benchmark results. | [5](#credit-5) |
| [ponytail-help](plugins/research-skills/skills/ponytail-help/SKILL.md) | Explain Ponytail triggers, levels, deactivation, and updates. | [5](#credit-5) |

## Credits and licenses

Numbers in the Credits column link to the sources below. Adaptations and historical inspiration are distinguished. Each component keeps its applicable license.

1. <a id="credit-1"></a>Yuyu Luo and contributors. [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) (2026). **CC BY-NC-SA 4.0**. Adapted in four paper/figure skills and the proposal-evaluation reference of `develop-research-ideas`. These adaptations require noncommercial use and ShareAlike.
2. <a id="credit-2"></a>hylarucoder. [Geju in hai-stack](https://github.com/hylarucoder/hai-stack). Historical inspiration for `rethink-design`, which was written for this collection and uses the collection's **MIT** license.
3. <a id="credit-3"></a>Lorena A. Barba. [sciwrite](https://github.com/labarba/sciwrite) (2026), drawing on Kristin Sainani's *Writing in the Sciences*. **CC BY 4.0**. Adapted in the copyediting reference of `research-writing-style`.
4. <a id="credit-4"></a>simplify-codebase contributors. [simplify-codebase](https://github.com/tt-a1i/simplify-codebase) (2026). **MIT**. Adapted with scientific-evidence conservation and scoped simplification guidance.
5. <a id="credit-5"></a>Dietrich Gebert. [Ponytail](https://github.com/DietrichGebert/ponytail) (2026). **MIT**. Includes six skills and the historical benchmark report, with customized scientific accuracy and resource guidance.
6. <a id="credit-6"></a>Meathill. [什么样的工作流，让我觉得 Fable 也不过如此](https://meathill.com/posts/tech/my-great-ai-workflow-with-different-ai-models) (2026-09-13). Conceptual inspiration for `maintain-project-memory`. The article is a reference, not bundled content or material covered by the repository license in [7](#credit-7).
7. <a id="credit-7"></a>Meathill. [meathill-coding-skills](https://github.com/meathill/meathill/tree/64cb92770189195c574ced31db7012ce5712f46b/skills/meathill-coding-skills), revision `64cb927`. **MIT**. The knowledge-maintenance ideas in `code-maintenance` inform `maintain-project-memory`. `website-operator-qa` and `product-content-audit` inform the user-workflow reference in `scientific-library-review`. Adapted to scientific users, existing project owners, evidence limits and authorized workloads.

8. <a id="credit-8"></a>Siqi Chen. [Humanizer v3.0.0](https://github.com/blader/humanizer/tree/9862685f575c65a8247f90369951df1b3416e3d6). **MIT** (2025). Its 25 patterns and editing workflow inform the durable-prose reference in `research-writing-style`. Adaptations preserve facts, technical meaning, necessary uncertainty, and the requested genre.
9. <a id="credit-9"></a>Wikipedia contributors. [Signs of AI writing, revision 1374941330](https://en.wikipedia.org/w/index.php?title=Wikipedia:Signs_of_AI_writing&oldid=1374941330). **CC BY-SA 4.0**. The durable-prose reference and its [Chinese adoption audit](plugins/research-skills/skills/research-writing-style/references/source-integration-audit.zh-CN.md) adapt writing, formatting, citation, and drafting-residue checks under CC BY-SA 4.0. The audit records every scoped or omitted recommendation and its reason. Detection signals are not treated as universal writing bans.

10. <a id="credit-10"></a>Joseph M. Williams and Joseph Bizup. *Style: Lessons in Clarity and Grace*, 11th edition, Pearson, copyright 2014, ISBN 978-0-321-89868-5. The full book informed the original sentence-generation guidance in durable-prose and the contextual reader diagnostics in prose-review. Its lessons, exercises, examples, and PDF are not bundled. The book's copyright is separate from this collection's licenses.

11. <a id="credit-11"></a>Yijia Shao et al. ([NAACL 2024](https://doi.org/10.18653/v1/2024.naacl-long.347)) and Yucheng Jiang et al. ([EMNLP 2024](https://doi.org/10.18653/v1/2024.emnlp-main.554)), Stanford OVAL. [STORM and Co-STORM](https://github.com/stanford-oval/storm). Methodological inspiration for the optional iterative-inquiry reference of `upgrade-research-inputs`, which was written for this collection and uses the collection's **MIT** license. No STORM text or code is bundled.

See [LICENSE.md](LICENSE.md) for component terms and [NOTICE.md](plugins/research-skills/NOTICE.md) for attribution and modifications.

## Update

Edit the skill folders under `plugins/research-skills/skills/` and hooks under `plugins/research-skills/hooks/`. To install or refresh the full collection from a local checkout, run:

```bash
python3 scripts/install-local.py
```

The script registers your checkout as a local marketplace, updates the package version from its contents, removes Finder `.DS_Store` files and Python bytecode caches from the plugin folder, and reinstalls the plugin through the Codex CLI. Run it after changing the repository. Keep the checkout in place while using it as your installation source. If `codex` is not on your `PATH`, for example when only the desktop app is installed, pass its CLI with `--codex-bin /path/to/codex`. After each reinstall, open `/hooks` in the Codex CLI, trust the research-skills entries, and start a new task. Until they are trusted, the writing route does not run.

To update an installation from GitHub after a new version is published:

```bash
codex plugin marketplace upgrade research-skills
codex plugin add research-skills@research-skills
```

After updating, open `/hooks` in the Codex CLI, trust the research-skills entries, and start a new task. Until they are trusted, the writing route does not run.

Before publishing an update, refresh the package version without installing:

```bash
python3 scripts/install-local.py --prepare-only
```

### Upgrading from a version with Ponytail hooks

In Codex, earlier versions registered Ponytail hooks that activated Ponytail at session start and tracked its level. These hooks have been removed. The agent now loads Ponytail and keeps track of its level within each conversation, as described in [Skills](#skills). The Claude Code package never included these hooks. It now installs the six Ponytail skills that earlier versions left out. The writing hook's position and registration are unchanged, so its existing trust in Codex still applies. After updating, you can remove what the Ponytail hooks left behind:

- Codex keeps trust records for the removed hooks in `~/.codex/config.toml`. They have no effect. To remove them, delete the three `[hooks.state]` entries whose keys start with `research-skills@research-skills:hooks/hooks.json:` and end with `session_start:0:1`, `subagent_start:0:1` or `user_prompt_submit:0:0`. Keep the entries ending with `session_start:0:0` and `subagent_start:0:0`, which belong to the writing hook.
- The hooks saved the current level in a `.ponytail-active` file in the plugin's Codex data directory, such as `~/.codex/plugins/data/research-skills-research-skills/`. Delete it if it remains. A standalone Ponytail plugin for Claude Code keeps its level in `~/.claude/.ponytail-active`, which can remain after that plugin is uninstalled. Delete that file only if no Ponytail installation uses it.
- A default level set with `$ponytail default` was saved in `~/.config/ponytail/config.json`, which is `$XDG_CONFIG_HOME/ponytail/config.json` when that variable is set and `%APPDATA%\ponytail\config.json` on Windows. Delete it only if no other Ponytail installation uses it.
- `PONYTAIL_DEFAULT_MODE` and `PONYTAIL_SUBAGENT_MATCHER` no longer have any effect, and you can remove them from your environment.

## Disable or uninstall

### Claude Code

To turn the plugin off without removing it, run `claude plugin disable research-skills@research-skills`. Turn it back on with `claude plugin enable research-skills@research-skills`. To remove it, run:

```bash
claude plugin uninstall research-skills@research-skills
claude plugin marketplace remove research-skills
```

Then delete `~/.local/share/research-skills/claude-marketplace/` and start a new Claude Code session.

### Codex

To remove the plugin and its marketplace source, run:

```bash
codex plugin remove research-skills@research-skills
codex plugin marketplace remove research-skills
```

To keep the plugin but stop the writing hook, turn it off in `/hooks` and start a new task. To turn Ponytail off in a conversation, see [Skills](#skills).

## Personal defaults

The writing conventions and quantum radar’s [research profile](plugins/research-skills/skills/quantum-research-radar/references/user-research-profile.md) reflect my own work. Adapt them in your checkout and reinstall, or give Codex or Claude Code your preferences when making a request.
