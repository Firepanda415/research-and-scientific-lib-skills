# Research & Scientific Library Skills

[English](README.md) | [简体中文](README.zh-CN.md)

A collection of skills for Codex and Claude Code that I use for research and scientific software development. It covers research planning, literature searches, manuscript writing, figures, scientific computing, and code review. I update it as my work and needs evolve.

In both Codex and Claude Code, the plugin provides **all 31 skills**, including a customized Ponytail coding mode, and the writing hook.

## Context cost

With the plugin installed, each session carries about 5k tokens before any skill is used. About 3k are the names and descriptions of the 31 skills, which both hosts keep in context to choose skills, as the skill documentation for [Claude Code](https://code.claude.com/docs/en/skills) and [Codex](https://learn.chatgpt.com/docs/build-skills) describes. About 2k are the writing hook's instructions, which every subagent also receives. A skill's full instructions load only when it is used and then stay in the conversation. The number after each skill name in the [Skills](#skills) table estimates the tokens the skill loads by default on each use, counting its `SKILL.md` and the reference files it reads by default. Reference files that only some tasks need add to it. The estimates assume about 3.5 English characters per token, Anthropic's figure for Claude in its [glossary](https://platform.claude.com/docs/en/about-claude/glossary). Measured from Codex usage records in September 2026, the writing skill's files took about 30% fewer tokens than this estimate.

A few skills cost much more than the others:

- `research-writing-style` reads about 16k tokens. The writing hook routes the drafting, editing, and prose review of documents that other people read, such as papers, referee reports, documentation, READMEs, and letters, and of text drafted for them, to this skill, so a skill that produces such text adds this cost too. Your own notes and reports, text for agents, and code comments, commits, and pull requests stay outside the route.
- `simplify-codebase` takes about 6k together with the Ponytail skill it loads, and `lead-multi-agent-project`, `quantum-computing-review`, `research-explainer-animation`, `scientific-computing-correctness`, and `scientific-library-review` take about 5k each. Several of them read further reference files for particular checks. The referee handbook of `quantum-computing-review` alone holds about 19k tokens, which the skill reads only in the sections a review needs. The code-review, scientific-computing, and implementation-handoff skills also load Ponytail (about 4k) when they implement, optimize, or judge a design. `lead-multi-agent-project` also loads `write-implementation-job-prompts` (about 4k) for its briefs, and the reference files for its stages of work add about 7k over a whole project.

Some workflows add further cost. Each subagent reads its own copy of the instructions and material, so the independent reviewer that `research-writing-style` uses for substantial documents loads that skill again, `deep-code-review` can start parallel finder agents for substantive reviews, and `lead-multi-agent-project` runs every job in a subagent and every review round in a session of its own, and opens a new advisor thread for each topic. `quantum-research-radar` adds search results from up to five search lanes to the context on every run. `research-explainer-animation` also takes local compute time for speech synthesis and video rendering.

If you need only part of the collection, clone this repository and ask your agent to remove the skills you do not use and to trim or split the large ones for your work, for example by moving sections you rarely need into references that load on demand. Some skills depend on others. The writing hook points to `research-writing-style` and `work-email`, several code skills load `ponytail` and read reference files in `scientific-computing-correctness`, and `pre-submission-reviewer` reads a checklist in `benchmark-paper-template`. Keep such a skill unless you also change what uses it, and have your agent check the links between skills after removing one. Then install from your checkout as described in [Install](#install) and [Update](#update). In Codex you can also turn the writing hook off in `/hooks`, as described in [Disable or uninstall](#disable-or-uninstall).

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

The script builds a local marketplace under `~/.local/share/research-skills/claude-marketplace/` and installs `research-skills@research-skills` at user scope through the Claude CLI. It includes all 31 skills, their supporting files, and the writing hook. If the `claude` on your `PATH` is missing, fails to run, or is not the Claude Code you use, pass the current executable with `--claude-bin /path/to/claude`. The script prints the executable it uses. See the [Claude Code marketplace guide](https://code.claude.com/docs/en/plugin-marketplaces) for local marketplace behavior.

Rerun the script after changing the source, then start a new Claude Code session. Sessions and workflows already running keep the previous copy until they end. In a new session, invoke a skill by name, for example `/research-skills:scientific-library-review`. If Claude Code also has the standalone Ponytail plugin, uninstall it so that its hooks and duplicate skills do not run alongside this plugin.

After verifying the installation, remove matching manually copied skill folders from `~/.claude/skills/` to prevent duplicate discovery. Keep any backup outside that directory and preserve unrelated skills. Start a new Claude Code session after migration.

## Skills

Select a skill in Codex or Claude Code, or let the agent choose one that matches your request. Ponytail applies to implementation, debugging, refactoring, and read-only decisions about simplifying or retiring code, APIs and tests. `simplify-codebase` loads it for surveys and changes, including sweeps of a test directory for low-value tests and the production code that exists only for them. Code-review, scientific-computing and implementation-handoff skills also load it when their task involves the design decisions described in each skill. The relevant correctness or review skill leads, and Ponytail works within its requirements without starting another audit. Factual code explanations and prose-only work do not trigger it.

Name a level (`lite`, `full` or `ultra`) in the conversation, for example `$ponytail lite` in Codex or `/research-skills:ponytail lite` in Claude Code, and it lasts until you name another or turn Ponytail off. `full` applies when no level is named. Say `stop ponytail` or `normal mode`, or use `$ponytail off`, to turn Ponytail off until you ask for it again in that conversation, which turns it back on at `full` unless you name another level. Companion skills respect that off state. `ponytail-help` lists the triggers for both hosts.

For documents that other people read, the writing hook requires Codex or Claude Code to read and apply `research-writing-style` and its durable-prose reference before drafting or editing such a document or reviewing its prose. Examples are papers and responses to referees, referee reports, documentation, READMEs, letters, slides, website copy, and example notebooks, and text drafted for them, including paste-ready text in chat, in any language. A one-sentence edit to such a document counts. Text that only you read, such as notes, internal reports, research logs, briefings, and chat answers, is outside the route, as is text for agents, such as skills, prompts, handoffs, and project memory. Code comments, docstrings, commit messages, and pull-request descriptions are outside it too, so routine coding work does not load `research-writing-style`. To apply `research-writing-style` to any text outside the route, ask for it by name. When the readers are unclear, the agent treats the text as yours unless its type or destination implies other readers, and an agent that assembles internal material into a document for others applies the route at that point. Short work emails and messages whose content you supply, including grammar fixes, use the lightweight `work-email` skill instead, and its own final check replaces the full review. For any deliverable, including code and analyses, the hook has the agent first infer what the requester intends and what the deliverable's readers or users come to it for. The agent keeps to the scope the requester intended and lets that audience's need decide what to research, include, or build. When the work adopts a method or design from another work, such as a paper, a prototype, or other code, the agent first establishes from that source what its authors built it for and under which constraints, then judges it against the current work's purpose and adapts it where the purposes differ. Keeping, changing, or dropping an element that affects the results then needs a reason tied to that purpose. The agent stops gathering once the need is met, checks each included claim to its evidence standard without widening the search, and gives other agents the same audience, question or task, and stopping point. Credit [14](#credit-14) lists the sources for this rule. The hook also states that documents, project memory, instructions, code comments, and tests describe the current state. Removing an item or ending a temporary arrangement also removes, in the files the work is authorized to change, the rules, references, and tests that existed only because of it. References that still serve a compatibility path or migration stay. History belongs in version control, dated records, decision records, and changelogs or migration notes when users must act, such as the upgrade notes below. Elsewhere, a note or prohibition about the removed item needs a stated reason why it must stay absent, and a test of its absence needs a contract that requires the absence or an explicit user request. Credit [12](#credit-12) lists the sources for this rule. The hook's last part gives an explicit instruction from the user, whether given for the current task or recorded in the user's instruction files, precedence over the plugin's guidance, including the writing route. Rules that record or protect an external obligation, such as a venue's confidentiality policy or a license term, still apply. When a plugin rule makes the agent pause, ask for approval, leave requested work unfinished, or depart from the request, the agent states that outcome first, then names the rule's source and quotes the rule. Credit [13](#credit-13) gives the source for this part. The route is injected at session start, after compaction, and for subagents. In Codex, open `/hooks` after every install or update and trust the research-skills entries. Until they are trusted, the writing route does not run. The hook supplies instructions, not a mechanical guarantee that they are followed.

The skill has two stages. Generation and editing apply sentence structure and word-choice guidance while composing. A required [adversarial review](plugins/research-skills/skills/research-writing-style/references/prose-review.md) then checks the complete draft's structure, paragraph functions, context, and reasoning before delivery. Review first identifies the source and role of extracted material, then challenges evidence, reader comprehension, and conversation or prompt leakage using the surrounding text. A writing instruction such as “do not discuss X” must not become an unsupported statement about the subject. Review-only requests start from the existing text and report substantiated findings without automatically rewriting it. Detector labels alone do not require edits. Explicit requests for detector-directed rewriting use the optional [detector evaluation](plugins/research-skills/skills/research-writing-style/references/detector-evaluation.md) workflow, which preserves meaning and records measured comparisons. Ordinary writing does not require detector checks. Lessons from rewriting trials about connecting choices, evidence, capabilities, and qualifications are part of the default generation and context-review guidance. The [adoption audit](plugins/research-skills/skills/research-writing-style/references/source-integration-audit.zh-CN.md) records the source coverage, qualified recommendations, and exclusions.

By default, the skill writes prose without semicolons, em dashes, or colons joining independent clauses, and without `retain`, `honest`, or their inflections outside established technical terms. An explicit user instruction or a requirement of the destination, such as a journal style guide, takes precedence over these defaults. Before delivery, the skill's final gate scans newly written prose for semicolons, em dashes, and these words. It also lists the other checks that every deliverable must pass, such as prompt leakage, meaning, terminology, citations, and change records.

Several other skills end with a short review of the finished work, run in a pass separate from producing it. They are `scientific-computing-correctness` and `ponytail` for code, `library-example-notebooks` for notebooks, `figure-designer` for rendered figures, `stress-test-baselines` for comparisons, `upgrade-research-inputs` for literature syntheses, `maintain-project-memory` for project records, `lead-multi-agent-project` for a project's plans, briefs and triage, and `work-email` for short emails. Each review checks items that the skill's generation guidance already sets, mainly ones that are easy to miss while producing the work and can be verified on the result, such as a derivation at each new formula, the context behind a claim that a quantity is exact or absent, or a planned comparison labeled as planned. The review covers its listed items without repeating earlier verification, and it adds no runs beyond the checks the task requires. Credit [15](#credit-15) lists the sources for this design.

The number after each skill name estimates the tokens the skill loads by default on each use, as [Context cost](#context-cost) explains. A skill that produces a document for other readers also loads `research-writing-style`.

| Skill (tokens per use) | Purpose | Credits |
|---|---|---|
| [develop-research-ideas](plugins/research-skills/skills/develop-research-ideas/SKILL.md) (~1k) | Develop and assess research directions, proposals, and ideas from other fields. | [1](#credit-1) |
| [rethink-design](plugins/research-skills/skills/rethink-design/SKILL.md) (<1k) | Reconsider a limiting research question or design choice and assess a more ambitious alternative. | [2](#credit-2) |
| [upgrade-research-inputs](plugins/research-skills/skills/upgrade-research-inputs/SKILL.md) (~1k) | Investigate literature, novelty, disputed claims, and missing primary evidence. | [11](#credit-11), [15](#credit-15) |
| [stress-test-baselines](plugins/research-skills/skills/stress-test-baselines/SKILL.md) (~2k) | Design or run fair comparisons, ablation studies, and robustness checks. | [15](#credit-15) |
| [write-research-log](plugins/research-skills/skills/write-research-log/SKILL.md) (<1k) | Record experiments, observations, hypotheses, and predictions. | — |
| [research-watchdog-protocol](plugins/research-skills/skills/research-watchdog-protocol/SKILL.md) (<1k) | Monitor long-running jobs and resume in-progress research across sessions. | — |
| [maintain-project-memory](plugins/research-skills/skills/maintain-project-memory/SKILL.md) (~3k) | Maintain project decisions, reusable lessons, evidence limits, and a durable entry for later sessions. | [6](#credit-6), [7](#credit-7), [12](#credit-12), [15](#credit-15) |
| [quantum-research-radar](plugins/research-skills/skills/quantum-research-radar/SKILL.md) (~3k) | Produce Chinese quantum research briefings and focused scans of recent work, including Quantum × AI. | — |
| [physics-from-math-explainer](plugins/research-skills/skills/physics-from-math-explainer/SKILL.md) (~1k) | Explain physics-heavy mathematics with physical intuition and explicit conventions. | — |
| [tech-paper-template](plugins/research-skills/skills/tech-paper-template/SKILL.md) (~1k) | Build a technical paper’s argument, Introduction, and section structure. | [1](#credit-1) |
| [benchmark-paper-template](plugins/research-skills/skills/benchmark-paper-template/SKILL.md) (~1k) | Plan or assess your benchmark paper’s evaluation gap, construction, measurement design, and findings, in any field. | [1](#credit-1) |
| [research-writing-style](plugins/research-skills/skills/research-writing-style/SKILL.md) (~16k) | Draft, edit, and adversarially review documents that other people read, with mandatory review before delivery and a review-only entry. | [3](#credit-3), [8](#credit-8), [9](#credit-9), [10](#credit-10), [12](#credit-12), [15](#credit-15) |
| [work-email](plugins/research-skills/skills/work-email/SKILL.md) (<1k) | Fix the grammar of a short work email or message, or draft one from your points, keeping its facts, requests and tone. | — |
| [figure-designer](plugins/research-skills/skills/figure-designer/SKILL.md) (~1k) | Design and assess scientific figures, diagrams, and reproducible plots. | [1](#credit-1), [15](#credit-15) |
| [research-explainer-animation](plugins/research-skills/skills/research-explainer-animation/SKILL.md) (~5k) | Script, animate, and check narrated, subtitled explainer videos of papers and code, with every number traced to the source. | — |
| [pre-submission-reviewer](plugins/research-skills/skills/pre-submission-reviewer/SKILL.md) (~2k) | Check your manuscript’s scientific claims, consistency, presentation, and a revision's response to referees, before submission. | [1](#credit-1) |
| [journal-cover-letter](plugins/research-skills/skills/journal-cover-letter/SKILL.md) (~2k) | Draft and revise journal submission cover letters. | — |
| [quantum-computing-review](plugins/research-skills/skills/quantum-computing-review/SKILL.md) (~5k) | Prepare or assess referee reports on another author’s technical manuscript in any field, following venue and confidentiality requirements, with added checks for quantum computing and quantum technology work. | — |
| [scientific-computing-correctness](plugins/research-skills/skills/scientific-computing-correctness/SKILL.md) (~5k) | Implement, debug, optimize, or independently validate scientific computations and their resource use. | [15](#credit-15) |
| [scientific-library-review](plugins/research-skills/skills/scientific-library-review/SKILL.md) (~5k) | Review scientific libraries for mathematical correctness, usable workflows, and resource costs. | [7](#credit-7) |
| [library-example-notebooks](plugins/research-skills/skills/library-example-notebooks/SKILL.md) (~3k) | Write or review example notebooks and tutorials for a scientific library, with the result and how to substitute the reader's own problem on the first screen. | [15](#credit-15) |
| [deep-code-review](plugins/research-skills/skills/deep-code-review/SKILL.md) (~4k) | Review code for domain correctness, engineering behavior, tests, and resource costs. Scientific libraries use `scientific-library-review`. | [12](#credit-12), [16](#credit-16) |
| [simplify-codebase](plugins/research-skills/skills/simplify-codebase/SKILL.md) (~6k) | Simplify a codebase while preserving its behavior and scientific meaning, including sweeps of low-value tests and production code that exists only for tests. | [4](#credit-4), [12](#credit-12), [16](#credit-16) |
| [lead-multi-agent-project](plugins/research-skills/skills/lead-multi-agent-project/SKILL.md) (~5k) | Lead a multi-agent project, such as a scientific-software release, with advisor, worker, review and counselor models, from the settings at the start to the release. | [15](#credit-15) |
| [write-implementation-job-prompts](plugins/research-skills/skills/write-implementation-job-prompts/SKILL.md) (~4k) | Write implementation handoffs with clear scope and acceptance criteria. | [12](#credit-12) |
| [ponytail](plugins/research-skills/skills/ponytail/SKILL.md) (~4k) | Keep coding decisions simple within correctness, accuracy, runtime, and memory requirements. | [5](#credit-5), [12](#credit-12), [15](#credit-15), [16](#credit-16) |
| [ponytail-review](plugins/research-skills/skills/ponytail-review/SKILL.md) (<1k) | Review a diff for opportunities to simplify. | [5](#credit-5) |
| [ponytail-audit](plugins/research-skills/skills/ponytail-audit/SKILL.md) (<1k) | Report unnecessary complexity and justified deletions across a repository in a compact read-only audit. | [5](#credit-5) |
| [ponytail-debt](plugins/research-skills/skills/ponytail-debt/SKILL.md) (<1k) | Collect documented shortcuts and the conditions for replacing them. | [5](#credit-5) |
| [ponytail-gain](plugins/research-skills/skills/ponytail-gain/SKILL.md) (<1k) | Show the original Ponytail project’s published benchmark results. | [5](#credit-5) |
| [ponytail-help](plugins/research-skills/skills/ponytail-help/SKILL.md) (~1k) | Explain Ponytail triggers, levels, deactivation, and updates. | [5](#credit-5) |

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

12. <a id="credit-12"></a>Sources for the current-state rule. The writing hook, `research-writing-style`, `maintain-project-memory`, `ponytail`, `deep-code-review`, `simplify-codebase`, and `write-implementation-job-prompts` apply this rule to documents, project memory, instructions, code comments, and tests. The rule was written for this collection. Each copy follows the license of the file that contains it, which is **CC BY-SA 4.0** in the durable-prose reference and **MIT** elsewhere. No source text is bundled.
    - Anthropic. [Prompt-audit reference of the `claude-api` skill](https://github.com/anthropics/skills/blob/53048666b05b4799081517d00e09e0a2dd688678/skills/claude-api/shared/prompt-audit.md), revision `5304866`. It classifies migration-relative phrasing as a fossil and judges each prohibition by its provenance.
    - Anthropic. [Best practices for Claude Code](https://code.claude.com/docs/en/best-practices) and [Give Claude context: CLAUDE.md and better prompts](https://support.claude.com/en/articles/14553240-give-claude-context-claude-md-and-better-prompts) (2026). The first gives the per-line test for CLAUDE.md. The second lists history among the content to leave out.
    - OpenAI. [Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md), consulted 2026-09-25. Its suggested prompt for the model's own replies asks it to leave out what it will not do and what will remain unchanged.
    - Google. [Timeless documentation](https://developers.google.com/style/timeless-documentation), in the Google developer documentation style guide.
    - Robert C. Martin. *Clean Code: A Handbook of Agile Software Craftsmanship*, Prentice Hall, 2008, ISBN 978-0-13-235088-4, chapter 4, and [Avoid Inappropriate Information](https://www.informit.com/articles/article.aspx?p=1323427) (InformIT, 2009). Change history belongs in source control.
    - Alex Eagle. [Change-Detector Tests Considered Harmful](https://testing.googleblog.com/2015/01/testing-on-toilet-change-detector-tests.html), Google Testing Blog (2015).
    - Daniel M. Wegner et al. [Paradoxical effects of thought suppression](https://doi.org/10.1037/0022-3514.53.1.5), *Journal of Personality and Social Psychology* 53 (1987), 5–13. Louis Castricato et al. [Suppressing Pink Elephants with Direct Principle Feedback](https://arxiv.org/abs/2402.07896) (2024). Logan Mann et al. [Don't Think of the White Bear: Ironic Negation in Transformer Models Under Cognitive Load](https://arxiv.org/abs/2511.12381) (2025). Wegner et al. found that people who had tried to suppress a thought later reported it more often than people who had not. Mann et al. found that an instruction not to mention a word raised that word's next-token probability in most of the nine open models they tested, none larger than 20B parameters. Castricato et al. found that instructions to avoid a topic often failed in open models while GPT-4 mostly followed them. They then trained models to follow such instructions. Neither model study tested a current frontier model.

13. <a id="credit-13"></a>Source for the precedence rule in the writing hook. OpenAI. [Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md), instruction-following section, consulted 2026-09-25. Its suggested prompts give user instructions precedence over skill guidelines and ask the model to identify the skill instruction behind a pause. The hook's wording was written for this collection and uses the collection's **MIT** license. No source text is bundled.

14. <a id="credit-14"></a>Sources for the scope rule in the writing hook. The rule was written for this collection and uses the collection's **MIT** license. No source text is bundled.
    - Anthropic. [Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5), sections on written deliverable length and on task scope and over-verification, consulted 2026-09-25. [Prompting Claude Opus 5.5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5) says these patterns remain a reasonable starting point for that model.
    - OpenAI. [Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md), initiative and follow-through section, consulted 2026-09-25. Its suggested prompt asks the model to infer the user's intent and task scope from the instructions and prior conversation.

15. <a id="credit-15"></a>Sources for the review stages. The review text added to `scientific-computing-correctness`, `ponytail`, `library-example-notebooks`, `figure-designer`, `stress-test-baselines`, `upgrade-research-inputs`, and `maintain-project-memory`, the checks in `lead-multi-agent-project`, and the checklist in the final gate of `research-writing-style` were written for this collection. Each follows the license of the file that contains it, which is **CC BY-NC-SA 4.0** in `figure-designer` and **MIT** elsewhere. No source text is bundled.
    - Anthropic. [Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices), section on workflows and feedback loops, consulted 2026-09-26. A draft is checked against a short list of verifiable requirements and revised until it passes.
    - Anthropic. [Code Review](https://code.claude.com/docs/en/code-review) for Claude Code, consulted 2026-09-26. Review-only rules in `REVIEW.md` reach every agent that finds and verifies findings, so they land more reliably than the same rules in a long `CLAUDE.md`. A long `REVIEW.md` dilutes the rules that matter most.
    - Anthropic. [Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5), section on task scope and over-verification, consulted 2026-09-26. It advises removing explicit instructions that add verification steps, because the model already verifies its own work. The reviews here keep only concrete items checked on the result and add no runs. The QA section of the `pptx` skill in [anthropics/skills](https://github.com/anthropics/skills) inspects the rendered result for listed defects and rechecks only what changed.
    - OpenAI. [Custom code review rules for Codex](https://developers.openai.com/blog/custom-code-review-rules-for-codex), consulted 2026-09-26. It recommends starting with two or three consequential rules that state a safe path, and leaving mechanical checks to CI. In its evaluation, rule-guided review recovered 98% of the required custom findings, against 58.3% for the baseline.
    - OpenAI. The `playwright-interactive` skill in [openai/skills](https://github.com/openai/skills), whose QA inventory covers the claims the final response will make, and the testing and verification section of [Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md), which scales checks to the change. Both consulted 2026-09-26.
16. <a id="credit-16"></a>OpenClaw Foundation. [test-audit skill](https://github.com/openclaw/openclaw/tree/main/.agents/skills/test-audit) in OpenClaw (2026). **MIT**. Adapted as the test-surface reference of `simplify-codebase`. It also gives `ponytail` one sentence on production code that exists only for tests, and `deep-code-review` two examples of tests that cannot fail.

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

The writing conventions, the default house style of `research-explainer-animation`, and several parts of `quantum-research-radar` reflect my own work. For the radar these are its [research profile](plugins/research-skills/skills/quantum-research-radar/references/user-research-profile.md), the tailored search queries (Lane B) in its [source and query map](plugins/research-skills/skills/quantum-research-radar/references/source-and-query-map.md), its Chinese [output template](plugins/research-skills/skills/quantum-research-radar/references/output-template.md), and the timezone in its [scheduled-run prompt](plugins/research-skills/skills/quantum-research-radar/prompts/weekday-schedule-prompt.md). Unless the user or the project sets others, `lead-multi-agent-project` also follows my defaults. It reaches other vendors' models only through their desktop apps, applies its default test policy, and opens a new advisor thread after six compactions. Adapt them in your checkout and reinstall, or give Codex or Claude Code your preferences when making a request. The radar needs web retrieval or listings and papers you supply, and without them it stops instead of writing a briefing from memory.
