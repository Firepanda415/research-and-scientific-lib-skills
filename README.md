# Research & Scientific Library Skills

[English](README.md) | [简体中文](README.zh-CN.md)

A collection of Codex skills I use for research and scientific software development. It covers research planning, literature searches, manuscript writing, figures, scientific computing, and code review. I update it as my work and needs evolve.

The collection includes **27 skills and a customized Ponytail coding mode**, with its hooks, in a single Codex plugin.

## Install

Give Codex this request:

> Install all skills and Ponytail hooks from https://github.com/Firepanda415/research-and-scientific-lib-skills.

Or run:

```bash
codex plugin marketplace add Firepanda415/research-and-scientific-lib-skills
codex plugin add research-skills@research-skills
```

You need a Codex version with plugin marketplace support and Node.js on your `PATH` for the Ponytail hooks. Python 3 is needed only for the bundled Python helper scripts.

After installation, open `/hooks` in the Codex CLI to review and trust the hooks, then start a new task. Restart the app if it has not refreshed. See the [Codex hook setup guide](https://learn.chatgpt.com/docs/hooks#review-and-trust-hooks) for details.

If you already have the standalone Ponytail plugin, remove it through Codex’s plugin manager to avoid duplicate hooks.

## Skills

Select a skill in Codex, or let Codex choose one that matches your request. Ponytail activates automatically once its hooks are trusted, with `full` as the default coding mode. Say `stop ponytail` to turn it off for the current session. Set `PONYTAIL_DEFAULT_MODE=off` to disable automatic activation.

| Skill | Purpose | Credits |
|---|---|---|
| [develop-research-ideas](plugins/research-skills/skills/develop-research-ideas/SKILL.md) | Develop and assess research directions, proposals, and ideas from other fields. | [1](#credit-1) |
| [rethink-design](plugins/research-skills/skills/rethink-design/SKILL.md) | Reconsider a limiting research question or design choice and assess a more ambitious alternative. | [2](#credit-2) |
| [upgrade-research-inputs](plugins/research-skills/skills/upgrade-research-inputs/SKILL.md) | Investigate literature, novelty, disputed claims, and missing primary evidence. | — |
| [stress-test-baselines](plugins/research-skills/skills/stress-test-baselines/SKILL.md) | Design or run fair comparisons, ablation studies, and robustness checks. | — |
| [write-research-log](plugins/research-skills/skills/write-research-log/SKILL.md) | Record experiments, observations, hypotheses, and predictions. | — |
| [research-watchdog-protocol](plugins/research-skills/skills/research-watchdog-protocol/SKILL.md) | Monitor long-running jobs and continue research across sessions. | — |
| [maintain-project-memory](plugins/research-skills/skills/maintain-project-memory/SKILL.md) | Maintain project decisions, reusable lessons, evidence limits, and a durable entry for later sessions. | [6](#credit-6), [7](#credit-7) |
| [quantum-research-radar](plugins/research-skills/skills/quantum-research-radar/SKILL.md) | Produce Chinese quantum research briefings, including Quantum × AI. | — |
| [physics-from-math-explainer](plugins/research-skills/skills/physics-from-math-explainer/SKILL.md) | Explain physics-heavy mathematics with physical intuition and explicit conventions. | — |
| [tech-paper-template](plugins/research-skills/skills/tech-paper-template/SKILL.md) | Build a technical paper’s argument, Introduction, and section structure. | [1](#credit-1) |
| [benchmark-paper-template](plugins/research-skills/skills/benchmark-paper-template/SKILL.md) | Plan benchmark construction, evaluation, evidence, and paper structure. | [1](#credit-1) |
| [research-writing-style](plugins/research-skills/skills/research-writing-style/SKILL.md) | Apply research writing, copyediting, source layout, and revision conventions. | [3](#credit-3) |
| [figure-designer](plugins/research-skills/skills/figure-designer/SKILL.md) | Design and assess scientific figures, diagrams, and reproducible plots. | [1](#credit-1) |
| [pre-submission-reviewer](plugins/research-skills/skills/pre-submission-reviewer/SKILL.md) | Check your manuscript’s scientific claims, consistency, and presentation before submission. | [1](#credit-1) |
| [journal-cover-letter](plugins/research-skills/skills/journal-cover-letter/SKILL.md) | Draft and revise journal submission cover letters. | — |
| [quantum-computing-review](plugins/research-skills/skills/quantum-computing-review/SKILL.md) | Prepare referee reports for quantum manuscripts, following venue and confidentiality requirements. | — |
| [scientific-computing-correctness](plugins/research-skills/skills/scientific-computing-correctness/SKILL.md) | Implement, debug, or independently validate scientific computations and resource use. | — |
| [scientific-library-review](plugins/research-skills/skills/scientific-library-review/SKILL.md) | Review scientific libraries for mathematical correctness, usable workflows, and resource costs. | [7](#credit-7) |
| [deep-code-review](plugins/research-skills/skills/deep-code-review/SKILL.md) | Review domain correctness, engineering behavior, tests, and resource costs. | — |
| [simplify-codebase](plugins/research-skills/skills/simplify-codebase/SKILL.md) | Simplify a codebase while preserving its behavior and scientific meaning. | [4](#credit-4) |
| [write-implementation-job-prompts](plugins/research-skills/skills/write-implementation-job-prompts/SKILL.md) | Write implementation handoffs with clear scope and acceptance criteria. | — |
| [ponytail](plugins/research-skills/skills/ponytail/SKILL.md) | Keep coding decisions simple within correctness, accuracy, runtime, and memory requirements. | [5](#credit-5) |
| [ponytail-review](plugins/research-skills/skills/ponytail-review/SKILL.md) | Review a diff for opportunities to simplify. | [5](#credit-5) |
| [ponytail-audit](plugins/research-skills/skills/ponytail-audit/SKILL.md) | Find unnecessary complexity and opportunities to simplify a repository. | [5](#credit-5) |
| [ponytail-debt](plugins/research-skills/skills/ponytail-debt/SKILL.md) | Collect documented shortcuts and the conditions for replacing them. | [5](#credit-5) |
| [ponytail-gain](plugins/research-skills/skills/ponytail-gain/SKILL.md) | Show the original Ponytail project’s published benchmark results. | [5](#credit-5) |
| [ponytail-help](plugins/research-skills/skills/ponytail-help/SKILL.md) | Explain Ponytail commands, modes, and configuration. | [5](#credit-5) |

## Credits and licenses

Numbers in the Credits column link to the sources below. Adaptations and historical inspiration are distinguished; each component retains its applicable license.

1. <a id="credit-1"></a>Yuyu Luo and contributors. [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) (2026). **CC BY-NC-SA 4.0**. Adapted in four paper/figure skills and the proposal-evaluation reference of `develop-research-ideas`; these adaptations require noncommercial use and ShareAlike.
2. <a id="credit-2"></a>hylarucoder. [Geju in hai-stack](https://github.com/hylarucoder/hai-stack). Historical inspiration for `rethink-design`, which was written for this collection and uses the collection's **MIT** license.
3. <a id="credit-3"></a>Lorena A. Barba. [sciwrite](https://github.com/labarba/sciwrite) (2026), drawing on Kristin Sainani's *Writing in the Sciences*. **CC BY 4.0**. Adapted in the copyediting reference of `research-writing-style`.
4. <a id="credit-4"></a>simplify-codebase contributors. [simplify-codebase](https://github.com/tt-a1i/simplify-codebase) (2026). **MIT**. Adapted with scientific-evidence conservation and scoped simplification guidance.
5. <a id="credit-5"></a>Dietrich Gebert. [Ponytail](https://github.com/DietrichGebert/ponytail) (2026). **MIT**. Includes six skills, the Codex hook runtime and related resources, with customized scientific accuracy and resource guidance.
6. <a id="credit-6"></a>Meathill. [什么样的工作流，让我觉得 Fable 也不过如此](https://meathill.com/posts/tech/my-great-ai-workflow-with-different-ai-models) (2026-09-13). Conceptual inspiration for `maintain-project-memory`; the article is a reference, not bundled content or material covered by the repository license in [7](#credit-7).
7. <a id="credit-7"></a>Meathill. [meathill-coding-skills](https://github.com/meathill/meathill/tree/64cb92770189195c574ced31db7012ce5712f46b/skills/meathill-coding-skills), revision `64cb927`. **MIT**. The knowledge-maintenance ideas in `code-maintenance` inform `maintain-project-memory`; `website-operator-qa` and `product-content-audit` inform the user-workflow reference in `scientific-library-review`. Adapted to scientific users, existing project owners, evidence limits and authorized workloads.

See [LICENSE.md](LICENSE.md) for component terms and [NOTICE.md](plugins/research-skills/NOTICE.md) for attribution and modifications.

## Update

Edit the skill folders under `plugins/research-skills/skills/` and Ponytail hooks under `plugins/research-skills/hooks/`. To install or refresh the full collection from a local checkout, run:

```bash
python3 scripts/install-local.py
```

The script registers your checkout as a local marketplace, updates the package version from its contents, and reinstalls the plugin through the Codex CLI. Run it after changing the repository. Keep the checkout in place while using it as your installation source.

To update an installation from GitHub after a new version is published:

```bash
codex plugin marketplace upgrade research-skills
codex plugin add research-skills@research-skills
```

Start a new task after updating, and review changed hooks if Codex requests it.

Before publishing an update, refresh the package version without installing:

```bash
python3 scripts/install-local.py --prepare-only
```

## Personal defaults

The writing conventions and quantum radar’s [research profile](plugins/research-skills/skills/quantum-research-radar/references/user-research-profile.md) reflect my own work. Adapt them in your checkout or give Codex your preferences when making a request.
