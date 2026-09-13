# Research & Scientific Library Skills

[English](README.md) | [简体中文](README.zh-CN.md)

A collection of Codex skills I use for research and scientific software development. It covers research planning, literature searches, manuscript writing, figures, scientific computing, and code review. I update it as my work and needs evolve.

The collection includes **26 skills and a customized Ponytail coding mode**, with its hooks, in a single Codex plugin.

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
| [develop-research-ideas](plugins/research-skills/skills/develop-research-ideas/SKILL.md) | Develop and assess research directions, proposals, and ideas from other fields. | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills), proposal evaluation |
| [rethink-design](plugins/research-skills/skills/rethink-design/SKILL.md) | Reconsider a limiting research question or design choice and assess a more ambitious alternative. | Historical inspiration from [Geju](https://github.com/hylarucoder/hai-stack) |
| [upgrade-research-inputs](plugins/research-skills/skills/upgrade-research-inputs/SKILL.md) | Investigate literature, novelty, disputed claims, and missing primary evidence. | — |
| [stress-test-baselines](plugins/research-skills/skills/stress-test-baselines/SKILL.md) | Design or run fair comparisons, ablation studies, and robustness checks. | — |
| [write-research-log](plugins/research-skills/skills/write-research-log/SKILL.md) | Record experiments, observations, hypotheses, and predictions. | — |
| [research-watchdog-protocol](plugins/research-skills/skills/research-watchdog-protocol/SKILL.md) | Monitor long-running jobs and continue research across sessions. | — |
| [quantum-research-radar](plugins/research-skills/skills/quantum-research-radar/SKILL.md) | Produce Chinese quantum research briefings, including Quantum × AI. | — |
| [physics-from-math-explainer](plugins/research-skills/skills/physics-from-math-explainer/SKILL.md) | Explain physics-heavy mathematics with physical intuition and explicit conventions. | — |
| [tech-paper-template](plugins/research-skills/skills/tech-paper-template/SKILL.md) | Build a technical paper’s argument, Introduction, and section structure. | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [benchmark-paper-template](plugins/research-skills/skills/benchmark-paper-template/SKILL.md) | Plan benchmark construction, evaluation, evidence, and paper structure. | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [research-writing-style](plugins/research-skills/skills/research-writing-style/SKILL.md) | Apply research writing, copyediting, source layout, and revision conventions. | [sciwrite](https://github.com/labarba/sciwrite), copyediting reference |
| [figure-designer](plugins/research-skills/skills/figure-designer/SKILL.md) | Design and assess scientific figures, diagrams, and reproducible plots. | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [pre-submission-reviewer](plugins/research-skills/skills/pre-submission-reviewer/SKILL.md) | Check your manuscript’s scientific claims, consistency, and presentation before submission. | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [journal-cover-letter](plugins/research-skills/skills/journal-cover-letter/SKILL.md) | Draft and revise journal submission cover letters. | — |
| [quantum-computing-review](plugins/research-skills/skills/quantum-computing-review/SKILL.md) | Prepare referee reports for quantum manuscripts, following venue and confidentiality requirements. | — |
| [scientific-computing-correctness](plugins/research-skills/skills/scientific-computing-correctness/SKILL.md) | Implement, debug, or independently validate scientific computations and resource use. | — |
| [scientific-library-review](plugins/research-skills/skills/scientific-library-review/SKILL.md) | Review scientific libraries for mathematical correctness, usable workflows, and resource costs. | — |
| [deep-code-review](plugins/research-skills/skills/deep-code-review/SKILL.md) | Review domain correctness, engineering behavior, tests, and resource costs. | — |
| [simplify-codebase](plugins/research-skills/skills/simplify-codebase/SKILL.md) | Simplify a codebase while preserving its behavior and scientific meaning. | [simplify-codebase](https://github.com/tt-a1i/simplify-codebase) |
| [write-implementation-job-prompts](plugins/research-skills/skills/write-implementation-job-prompts/SKILL.md) | Write implementation handoffs with clear scope and acceptance criteria. | — |
| [ponytail](plugins/research-skills/skills/ponytail/SKILL.md) | Keep coding decisions simple within correctness, accuracy, runtime, and memory requirements. | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-review](plugins/research-skills/skills/ponytail-review/SKILL.md) | Review a diff for opportunities to simplify. | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-audit](plugins/research-skills/skills/ponytail-audit/SKILL.md) | Find unnecessary complexity and opportunities to simplify a repository. | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-debt](plugins/research-skills/skills/ponytail-debt/SKILL.md) | Collect documented shortcuts and the conditions for replacing them. | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-gain](plugins/research-skills/skills/ponytail-gain/SKILL.md) | Show the original Ponytail project’s published benchmark results. | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-help](plugins/research-skills/skills/ponytail-help/SKILL.md) | Explain Ponytail commands, modes, and configuration. | [Ponytail](https://github.com/DietrichGebert/ponytail) |

## Credits and licenses

This collection includes adaptations of the following projects:

- [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) by Yuyu Luo and contributors, **CC BY-NC-SA 4.0**. The four adapted skills and the proposal-evaluation reference require noncommercial use and ShareAlike.
- [sciwrite](https://github.com/labarba/sciwrite) by Lorena A. Barba, drawing on Kristin Sainani’s *Writing in the Sciences*, **CC BY 4.0**. The copyediting reference adapts this material.
- [simplify-codebase](https://github.com/tt-a1i/simplify-codebase) by its contributors, **MIT**.
- [Ponytail](https://github.com/DietrichGebert/ponytail) by Dietrich Gebert, **MIT**. This version includes customized coding guidance and the Codex hook runtime.

`rethink-design` was written for this collection, with historical inspiration from [Geju in hylarucoder/hai-stack](https://github.com/hylarucoder/hai-stack).

See [LICENSE.md](LICENSE.md) for the license that applies to each component and the original notices.

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
