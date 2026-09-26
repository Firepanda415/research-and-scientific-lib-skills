# 科研与科学软件技能集

[English](README.md) | [简体中文](README.zh-CN.md)

这是我日常科研和科学软件开发中使用的 Codex 与 Claude Code skills 集合，覆盖研究选题、论文阅读与写作、绘图、科学计算和代码审查，也包含按个人习惯修改的 Ponytail。我会根据实际使用持续更新，欢迎按自己的研究需要使用和调整。

**在 Codex 和 Claude Code 中，插件都提供全部 29 个 skills（包括按个人习惯修改的 Ponytail 编码模式）和写作 hook。**

## 安装

### Codex

直接把仓库地址交给 Codex：

> 请安装 https://github.com/Firepanda415/research-and-scientific-lib-skills 中的全部技能和写作钩子。

也可以在终端中运行：

```bash
codex plugin marketplace add Firepanda415/research-and-scientific-lib-skills
codex plugin add research-skills@research-skills
```

需要支持插件市场的 Codex，以及已安装并加入 PATH 的 Node.js（写作钩子需要）。使用附带的 Python 脚本时还需要 Python 3。

每次安装或更新后，在 Codex CLI 打开 `/hooks`，信任 research-skills 的钩子。钩子获得信任前，写作路由不会运行。然后新建会话，如果应用没有刷新，请重启应用。详情见 [Codex 钩子信任说明](https://learn.chatgpt.com/docs/hooks#review-and-trust-hooks)。如果已安装独立的 Ponytail 插件，请通过 Codex 的插件管理器移除它，以免它的钩子和重复的 Ponytail skills 与本插件同时运行。

### Claude Code

使用当前版本的 Claude Code，并确保 Python 3 和 Node.js 已加入 `PATH`。在本地仓库根目录运行：

```bash
python3 scripts/install-claude.py
```

脚本在 `~/.local/share/research-skills/claude-marketplace/` 创建 local marketplace，并通过 Claude CLI 将 `research-skills@research-skills` 安装到 user scope。安装内容包括全部 29 个 skills、配套文件和写作 hook。如果 `PATH` 中的 `claude` 不存在、无法运行，或不是你正在使用的 Claude Code，可用 `--claude-bin /path/to/claude` 指定当前 executable。脚本会打印实际使用的 executable。Local marketplace 的加载方式见 [Claude Code marketplace guide](https://code.claude.com/docs/en/plugin-marketplaces)。

修改源文件后，重新运行该脚本并新建 Claude Code session。已在运行的 session 和 workflow 会继续使用旧副本，直到结束。在新 session 中可按名称调用 skill，例如 `/research-skills:scientific-library-review`。如果 Claude Code 中也装有独立的 Ponytail 插件，请卸载它，以免它的钩子和重复的 skills 与本插件同时运行。

确认安装成功后，删除 `~/.claude/skills/` 中同名的手动副本，防止重复加载。备份应放在该目录之外，并保留其他 skills。迁移后新建 Claude Code session。

## 技能一览

可以在 Codex 或 Claude Code 中选择指定 skill，也可以让 agent 根据任务自动选择。Ponytail 适用于 implementation、debugging、refactoring，以及代码、API 和 tests 的只读简化与退役判断。`simplify-codebase` 在 survey 和实际修改中加载它。Code review、scientific computing 和 implementation handoff skills 在涉及各自说明的设计取舍时也会加载它。相关 correctness 或 review skill 主导，Ponytail 在其要求范围内工作，不另开一次 audit。普通代码事实解释和仅涉及 prose 的任务不触发它。

可以在对话中指定级别（`lite`、`full` 或 `ultra`），例如在 Codex 中输入 `$ponytail lite`，或在 Claude Code 中输入 `/research-skills:ponytail lite`，该级别持续到你指定其他级别或关闭 Ponytail 为止。未指定级别时使用 `full`。说 `stop ponytail` 或 `normal mode`，或使用 `$ponytail off`，可关闭 Ponytail，直到你在本次对话中再次要求使用。再次开启时使用 `full`，除非你指定其他级别。其他 skills 也遵守这一 off 状态。`ponytail-help` 列出两个 host 上的调用方式。

凡是供人保存、反复阅读、分享、发布、发送或粘贴到其他地方的文字，写作钩子都要求 Codex 或 Claude Code 在起草、编辑这类文字或审阅其行文前读取并应用 `research-writing-style` 和其中的 durable-prose reference。普通文档、邮件、网页正文、聊天窗口中交付的可直接粘贴文本均在范围内，不分语言和篇幅。仅用于当前聊天的总结与进度说明除外。返回给其他 agent 或程序的材料（如结构化的发现或搜索结果）也不在路由范围内，由把它整理成交付文本的 agent 应用写作规范。对任何交付物（包括代码和分析），钩子要求 agent 先推断提出要求的人的意图，以及交付物的读者或用户想从中得到什么。agent 按提出要求的人想要的范围工作，由这些读者或用户的需要决定调研、写入和实现哪些内容。参考论文、原型或他人代码中的方法或设计时，agent 先从来源本身弄清作者当初为了什么、在什么约束下做的，再按当前工作的目的判断它是否合适，目的不同就改造。保留、修改或舍弃其中影响结果的部分，都要有与当前目的相关的理由。需要满足后就停止收集材料。证据标准决定每条写入的说法核实到什么程度，但不扩大搜索范围。交给其他 agent 的任务说明要写明读者、要回答的问题或要完成的任务，以及停止条件。规则的参考来源见 [14](#credit-14)。钩子还要求文档、项目记忆、指令、代码注释和测试描述当前状态。删除某项或结束临时安排时，本次工作获准修改的文件中只因它而存在的规则、引用和测试一并删除。仍服务于兼容路径或迁移的引用保留。历史记录放在版本控制、带日期的记录、决策记录，以及用户需要操作时的变更记录或迁移说明中，例如下文的升级说明。其他地方如果要写关于已删除项的说明或禁令，必须写明该项为什么不能恢复。断言它不存在的测试，则需要有要求它不存在的合约或用户的明确要求。规则的参考来源见 [12](#credit-12)。钩子最后一部分规定，用户针对当前任务给出的明确指令，以及用户写在自己指令文件中的明确要求，都优先于本插件的指导，包括写作路由。记录或保护外部义务的规则（如期刊或会议的保密政策、许可证条款）仍然适用。本插件的某条规则让 agent 暂停、请求批准、留下未完成的工作或偏离用户的要求时，agent 先说明这一结果，再指出规则的出处并引用这条规则。这一部分的来源见 [13](#credit-13)。路由会在会话启动、压缩后和子代理启动时注入。在 Codex 中，每次安装或更新后都要打开 `/hooks` 并信任 research-skills 的钩子，获得信任前写作路由不会运行。钩子提供的是指令，不能机械保证它们得到遵守。

同一 skill 分为两个阶段。生成和编辑阶段在写作时落实句子结构与用词要求，完整成稿随后必须经过[对抗性审阅](plugins/research-skills/skills/research-writing-style/references/prose-review.md)才能交付。审阅重点检查全文结构、段落功能、上下文和推理。先确认提取材料的来源与文档角色，再结合上下文核对证据、读者理解障碍，以及混入正文的对话和 prompt。用户要求“不要讨论 X”，不能变成对写作对象缺乏依据的断言。只要求 review 时，直接检查现有文字并报告有依据的问题，不自动重写。检测器标签本身不要求修改。用户明确要求按检测结果改写时，启用可选的[检测实验流程](plugins/research-skills/skills/research-writing-style/references/detector-evaluation.md)，保全含义并记录实测对比。普通写作不要求检测。复测中关于选择依据、能力与操作的联系、限定归属及上下文衔接的写作经验，已纳入默认生成和审阅规则。[来源采纳审计](plugins/research-skills/skills/research-writing-style/references/source-integration-audit.zh-CN.md)记录完整覆盖范围、限定采用及未采用的建议。

该 skill 默认的写作风格是正文不用分号、破折号或连接独立分句的冒号，除已成型的技术术语外也不用 `retain`、`honest` 及其变形。用户的明确要求或文字去向的格式规定（如期刊格式指南）优先于这些默认规则。交付前，该 skill 的最终检查会扫描新写的正文中有没有分号、破折号和这几个词，并列出每份交付物都要通过的其他检查，例如 prompt 泄漏、含义、术语、引用和变更记录。

另有几个 skill 在完成工作后单独做一次简短的 review，包括代码方面的 `scientific-computing-correctness` 和 `ponytail`、notebook 方面的 `library-example-notebooks`、渲染后插图的 `figure-designer`、比较实验的 `stress-test-baselines`、文献综述的 `upgrade-research-inputs`，以及项目记录的 `maintain-project-memory`。每个 review 核对的是该 skill 生成阶段已经规定的条目，主要挑选生成时容易漏掉、又能在成品上核对的项目，例如每个新公式旁的推导、说某个量是精确的或不存在时所依据的语境，以及把尚未运行的比较标为计划。Review 只核对列出的条目，不重复先前的验证，除任务本身要求的检查外也不增加运行。这一设计的参考来源见 [15](#credit-15)。

| 技能 | 用途 | Credits |
|---|---|---|
| [develop-research-ideas](plugins/research-skills/skills/develop-research-ideas/SKILL.md) | 探索研究方向，评估研究方案，寻找可以借鉴的跨领域方法。 | [1](#credit-1) |
| [rethink-design](plugins/research-skills/skills/rethink-design/SKILL.md) | 跳出过于保守的思路，重新思考研究问题或设计方向。 | [2](#credit-2) |
| [upgrade-research-inputs](plugins/research-skills/skills/upgrade-research-inputs/SKILL.md) | 查找相关论文和一手资料，核对创新点与有争议的论断。 | [11](#credit-11), [15](#credit-15) |
| [stress-test-baselines](plugins/research-skills/skills/stress-test-baselines/SKILL.md) | 设计公平的基线比较、消融实验和稳健性检查。 | [15](#credit-15) |
| [write-research-log](plugins/research-skills/skills/write-research-log/SKILL.md) | 记录研究进展、实验观察、假设与预测。 | — |
| [research-watchdog-protocol](plugins/research-skills/skills/research-watchdog-protocol/SKILL.md) | 跟进长时间运行的任务，并在新会话中接续进行中的研究。 | — |
| [maintain-project-memory](plugins/research-skills/skills/maintain-project-memory/SKILL.md) | 整理 project memory，保留 decision rationale、可复用经验与 evidence 范围，支持后续 session 接续工作。 | [6](#credit-6), [7](#credit-7), [12](#credit-12), [15](#credit-15) |
| [quantum-research-radar](plugins/research-skills/skills/quantum-research-radar/SKILL.md) | 生成中文量子研究简报和针对某一主题的近期工作扫描，关注量子计算与人工智能等相关方向。 | — |
| [physics-from-math-explainer](plugins/research-skills/skills/physics-from-math-explainer/SKILL.md) | 从数学出发解释物理，补充物理直觉，讲清符号和约定。 | — |
| [tech-paper-template](plugins/research-skills/skills/tech-paper-template/SKILL.md) | 组织技术论文的论点、引言和章节结构。 | [1](#credit-1) |
| [benchmark-paper-template](plugins/research-skills/skills/benchmark-paper-template/SKILL.md) | 规划或评估自己的基准测试论文，包括评估缺口、构建、测量设计和结论，不限领域。 | [1](#credit-1) |
| [research-writing-style](plugins/research-skills/skills/research-writing-style/SKILL.md) | 起草、编辑和对抗性审阅长期使用及可直接粘贴的文字，交付前强制 review，也支持只审不改。 | [3](#credit-3), [8](#credit-8), [9](#credit-9), [10](#credit-10), [12](#credit-12), [15](#credit-15) |
| [figure-designer](plugins/research-skills/skills/figure-designer/SKILL.md) | 设计论文插图、方法示意图和可复现的数据图表。 | [1](#credit-1), [15](#credit-15) |
| [research-explainer-animation](plugins/research-skills/skills/research-explainer-animation/SKILL.md) | 为论文和代码制作带配音和字幕的讲解动画，画面与旁白中的数字都可追溯到原始来源，交付前逐帧检查。 | — |
| [pre-submission-reviewer](plugins/research-skills/skills/pre-submission-reviewer/SKILL.md) | 投稿或返修前检查论文的科学主张、证据、写作、LaTeX 排版、图表以及审稿回复。 | [1](#credit-1) |
| [journal-cover-letter](plugins/research-skills/skills/journal-cover-letter/SKILL.md) | 起草和修改期刊投稿附信。 | — |
| [quantum-computing-review](plugins/research-skills/skills/quantum-computing-review/SKILL.md) | 为他人的技术论文撰写或核查审稿意见，不限领域，遵守期刊规则与保密要求，并对量子计算与量子技术论文增加专项检查。 | — |
| [scientific-computing-correctness](plugins/research-skills/skills/scientific-computing-correctness/SKILL.md) | 实现、调试、优化和独立验证科学计算，关注计算精度与资源开销。 | [15](#credit-15) |
| [scientific-library-review](plugins/research-skills/skills/scientific-library-review/SKILL.md) | 审查科学软件库的数学含义、使用流程、执行行为与资源开销。 | [7](#credit-7) |
| [library-example-notebooks](plugins/research-skills/skills/library-example-notebooks/SKILL.md) | 编写或审阅科学软件库的示例 notebook 和教程，让读者在第一屏看到计算结果，以及如何换成自己的问题。 | [15](#credit-15) |
| [deep-code-review](plugins/research-skills/skills/deep-code-review/SKILL.md) | 审查代码的领域正确性、工程实现、测试与资源开销。科学软件库使用 `scientific-library-review`。 | [12](#credit-12) |
| [simplify-codebase](plugins/research-skills/skills/simplify-codebase/SKILL.md) | 找出并移除代码中的多余复杂性，保护既有行为与必要的验证证据。 | [4](#credit-4), [12](#credit-12) |
| [write-implementation-job-prompts](plugins/research-skills/skills/write-implementation-job-prompts/SKILL.md) | 将需求或审查结果整理为清晰、可执行的开发任务提示词。 | [12](#credit-12) |
| [ponytail](plugins/research-skills/skills/ponytail/SKILL.md) | 在满足正确性和性能要求的前提下，选择简单的实现。 | [5](#credit-5), [12](#credit-12), [15](#credit-15) |
| [ponytail-review](plugins/research-skills/skills/ponytail-review/SKILL.md) | 审查代码变更，提出有依据的简化建议。 | [5](#credit-5) |
| [ponytail-audit](plugins/research-skills/skills/ponytail-audit/SKILL.md) | 以精简的只读审查报告列出整个仓库中可以删除或简化的代码。 | [5](#credit-5) |
| [ponytail-debt](plugins/research-skills/skills/ponytail-debt/SKILL.md) | 汇总代码中标记的简化取舍，以及需要重新处理这些取舍的条件。 | [5](#credit-5) |
| [ponytail-gain](plugins/research-skills/skills/ponytail-gain/SKILL.md) | 展示 Ponytail 原项目的历史基准测试结果。 | [5](#credit-5) |
| [ponytail-help](plugins/research-skills/skills/ponytail-help/SKILL.md) | 查看 Ponytail 的调用方式、级别、关闭和更新方法。 | [5](#credit-5) |

## 致谢与许可证

表格 Credits 中的编号对应以下来源。Adaptation 与历史启发分别注明，各部分保留适用的 license。

1. <a id="credit-1"></a>Yuyu Luo 及贡献者。[Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills)（2026）。**CC BY-NC-SA 4.0**。四个论文与绘图 skills，以及 `develop-research-ideas` 的 proposal-evaluation reference 在其基础上改编。这些内容要求非商业使用与 ShareAlike。
2. <a id="credit-2"></a>hylarucoder。[hai-stack 中的 Geju](https://github.com/hylarucoder/hai-stack)。为 `rethink-design` 提供历史启发。该 skill 由本项目重新编写，采用本项目的 **MIT** license。
3. <a id="credit-3"></a>Lorena A. Barba。[sciwrite](https://github.com/labarba/sciwrite)（2026），其方法也参考 Kristin Sainani 的 *Writing in the Sciences*。**CC BY 4.0**。用于 `research-writing-style` 的 copyediting reference。
4. <a id="credit-4"></a>simplify-codebase 贡献者。[simplify-codebase](https://github.com/tt-a1i/simplify-codebase)（2026）。**MIT**。改编时加入 scientific evidence 的保留要求，并明确 simplification 的范围。
5. <a id="credit-5"></a>Dietrich Gebert。[Ponytail](https://github.com/DietrichGebert/ponytail)（2026）。**MIT**。包括六个 skills 和历史基准测试报告。本版本增加 scientific accuracy 与 resource 要求。
6. <a id="credit-6"></a>Meathill。[什么样的工作流，让我觉得 Fable 也不过如此](https://meathill.com/posts/tech/my-great-ai-workflow-with-different-ai-models)（2026-09-13）。为 `maintain-project-memory` 提供思路。文章仅作为 reference，未随包分发，也不将 [7](#credit-7) 的 repository license 套用于文章。
7. <a id="credit-7"></a>Meathill。[meathill-coding-skills](https://github.com/meathill/meathill/tree/64cb92770189195c574ced31db7012ce5712f46b/skills/meathill-coding-skills)，revision `64cb927`。**MIT**。`maintain-project-memory` 借鉴 `code-maintenance` 的知识维护方法。`scientific-library-review` 的 user-workflow reference 借鉴 `website-operator-qa` 与 `product-content-audit`，并按 scientific users、现有 project owners、evidence 范围和已授权 workload 调整。

8. <a id="credit-8"></a>Siqi Chen。[Humanizer v3.0.0](https://github.com/blader/humanizer/tree/9862685f575c65a8247f90369951df1b3416e3d6)。**MIT**（2025）。其 25 个写作模式及编辑流程用于 `research-writing-style` 的 durable-prose reference。改编时保全事实、技术含义、必要的不确定性和用户要求的文体。
9. <a id="credit-9"></a>Wikipedia contributors。[Signs of AI writing，修订 1374941330](https://en.wikipedia.org/w/index.php?title=Wikipedia:Signs_of_AI_writing&oldid=1374941330)。**CC BY-SA 4.0**。durable-prose reference 和[中文采纳审计](plugins/research-skills/skills/research-writing-style/references/source-integration-audit.zh-CN.md)吸收其内容、排版、引用及草稿残留检查，按 CC BY-SA 4.0 分发。审计逐项说明限定采纳和未采纳内容的理由，不把检测线索当成通用写作禁令。

10. <a id="credit-10"></a>Joseph M. Williams 与 Joseph Bizup。*Style: Lessons in Clarity and Grace*，第 11 版，Pearson，版权年份 2014，ISBN 978-0-321-89868-5。完整阅读本书后，将其思想用于 durable-prose 中原创的句子生成指引和 prose-review 中基于上下文的读者诊断。不随包分发原书章节、练习、示例或 PDF，原书版权独立于本项目许可证。

11. <a id="credit-11"></a>Yijia Shao 等（[NAACL 2024](https://doi.org/10.18653/v1/2024.naacl-long.347)）与 Yucheng Jiang 等（[EMNLP 2024](https://doi.org/10.18653/v1/2024.emnlp-main.554)），Stanford OVAL。[STORM 与 Co-STORM](https://github.com/stanford-oval/storm)。为 `upgrade-research-inputs` 的可选迭代探究 reference 提供方法启发。该 reference 由本项目编写，采用本项目的 **MIT** license，不包含 STORM 的文字或代码。

12. <a id="credit-12"></a>现状规则的参考来源。写作钩子、`research-writing-style`、`maintain-project-memory`、`ponytail`、`deep-code-review`、`simplify-codebase` 和 `write-implementation-job-prompts` 把这条规则用于文档、项目记忆、指令、代码注释和测试。规则由本项目编写，每处文字沿用所在文件的 license，durable-prose reference 中为 **CC BY-SA 4.0**，其余为 **MIT**。不包含来源的文字。
    - Anthropic。[`claude-api` skill 的 prompt-audit reference](https://github.com/anthropics/skills/blob/53048666b05b4799081517d00e09e0a2dd688678/skills/claude-api/shared/prompt-audit.md)，revision `5304866`。它把 migration-relative phrasing 归为 fossil，并按 provenance 判断每条禁令。
    - Anthropic。[Best practices for Claude Code](https://code.claude.com/docs/en/best-practices) 与 [Give Claude context: CLAUDE.md and better prompts](https://support.claude.com/en/articles/14553240-give-claude-context-claude-md-and-better-prompts)（2026）。前者给出 CLAUDE.md 的逐行测试，后者把历史记录列为不必写入的内容。
    - OpenAI。[Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md)，查阅于 2026-09-25。其中约束模型自身回复的示例 prompt 要求不写“不会做什么”和“什么保持不变”。
    - Google。Google 开发者文档风格指南中的 [Timeless documentation](https://developers.google.com/style/timeless-documentation)。
    - Robert C. Martin。*Clean Code: A Handbook of Agile Software Craftsmanship*，Prentice Hall，2008，ISBN 978-0-13-235088-4，第 4 章，以及 [Avoid Inappropriate Information](https://www.informit.com/articles/article.aspx?p=1323427)（InformIT，2009）。修改历史属于版本控制。
    - Alex Eagle。[Change-Detector Tests Considered Harmful](https://testing.googleblog.com/2015/01/testing-on-toilet-change-detector-tests.html)，Google Testing Blog（2015）。
    - Daniel M. Wegner 等。[Paradoxical effects of thought suppression](https://doi.org/10.1037/0022-3514.53.1.5)，*Journal of Personality and Social Psychology* 53（1987），5–13。Louis Castricato 等。[Suppressing Pink Elephants with Direct Principle Feedback](https://arxiv.org/abs/2402.07896)（2024）。Logan Mann 等。[Don't Think of the White Bear: Ironic Negation in Transformer Models Under Cognitive Load](https://arxiv.org/abs/2511.12381)（2025）。Wegner 等发现，试图压制某个念头的人，之后报告这个念头的次数多于没有压制过的人。Mann 等在九个不超过 20B 参数的开源模型上发现，“不要提某个词”的指令在多数模型中提高了该词作为下一个 token 的概率。Castricato 等发现，要求回避某个话题的指令在开源模型上常常无效，GPT-4 则大多能遵守，他们随后训练模型遵守这类指令。两项模型研究都没有测试当前的前沿模型。

13. <a id="credit-13"></a>写作钩子中优先级规则的来源。OpenAI。[Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md) 中关于 instruction following 的部分，查阅于 2026-09-25。其中的示例 prompt 让用户指令优先于 skill 的指导，并要求模型指出导致暂停的 skill 指令。钩子中的文字由本项目编写，采用本项目的 **MIT** license，不包含来源的文字。

14. <a id="credit-14"></a>写作钩子中范围规则的参考来源。规则由本项目编写，采用本项目的 **MIT** license，不包含来源的文字。
    - Anthropic。[Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5) 中关于书面交付物长度以及任务范围与过度验证的部分，查阅于 2026-09-25。[Prompting Claude Opus 5.5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5) 说明这些做法对该模型仍是合理的起点。
    - OpenAI。[Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md) 中关于 initiative and follow-through 的部分，查阅于 2026-09-25。其中的示例 prompt 要求模型从指令和之前的对话推断用户的意图和任务范围。

15. <a id="credit-15"></a>review 阶段的参考来源。`scientific-computing-correctness`、`ponytail`、`library-example-notebooks`、`figure-designer`、`stress-test-baselines`、`upgrade-research-inputs` 和 `maintain-project-memory` 中新增的 review 文字，以及 `research-writing-style` 最终检查中的清单，都由本项目编写。每处文字沿用所在文件的 license，`figure-designer` 中为 **CC BY-NC-SA 4.0**，其余为 **MIT**。不包含来源的文字。
    - Anthropic。[Skill authoring best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) 中关于 workflows 与 feedback loops 的部分，查阅于 2026-09-26。草稿对照一份可核对的简短清单检查，修改到全部通过为止。
    - Anthropic。Claude Code 的 [Code Review](https://code.claude.com/docs/en/code-review) 文档，查阅于 2026-09-26。只用于 review 的规则写在 `REVIEW.md` 中，会直接交给每个查找和核实问题的 agent，因此比写在很长的 `CLAUDE.md` 里的同样规则更可靠地得到执行。`REVIEW.md` 过长则会冲淡最重要的规则。
    - Anthropic。[Prompting Claude Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5) 中关于任务范围与过度验证的部分，查阅于 2026-09-26。它建议删除要求增加验证步骤的明确指令，因为模型本身已经会验证自己的工作。这里的 review 只保留能在成品上核对的具体条目，也不增加运行。[anthropics/skills](https://github.com/anthropics/skills) 中 `pptx` skill 的 QA 部分对照列出的缺陷检查渲染结果，只复查改动过的部分。
    - OpenAI。[Custom code review rules for Codex](https://developers.openai.com/blog/custom-code-review-rules-for-codex)，查阅于 2026-09-26。文章建议先写两三条后果重大并说明安全做法的规则，机械性检查交给 CI。在其评测中，按规则 review 找回了 98% 应找出的自定义问题，基线对照为 58.3%。
    - OpenAI。[openai/skills](https://github.com/openai/skills) 中的 `playwright-interactive` skill 的 QA 清单涵盖最终回复将提出的说法。[Using GPT-6](https://developers.openai.com/api/docs/guides/latest-model/gpt-6-astra.md) 中关于 testing and verification 的部分按改动规模确定检查范围。两者均查阅于 2026-09-26。

各部分的条款见 [LICENSE.md](LICENSE.md)，来源与修改说明见 [NOTICE.md](plugins/research-skills/NOTICE.md)。

## 更新

### 修改本地仓库

技能位于 `plugins/research-skills/skills/<skill-name>/`，钩子位于 `plugins/research-skills/hooks/`。修改后，在仓库根目录运行：

```bash
python3 scripts/install-local.py
```

脚本把当前仓库注册为 local marketplace，按内容更新插件版本，删除插件目录中 Finder 生成的 `.DS_Store` 和 Python 字节码缓存，并通过 Codex CLI 整套重新安装。以本仓库作为安装来源期间，请保留该目录。后续修改都在本仓库中进行，避免直接编辑安装后的缓存。如果 `codex` 不在 `PATH` 中（例如只安装了桌面应用），可用 `--codex-bin /path/to/codex` 指定其 CLI。每次重新安装后，在 Codex CLI 打开 `/hooks`，信任 research-skills 的钩子，然后新建会话。钩子获得信任前，写作路由不会运行。

### 从 GitHub 更新

```bash
codex plugin marketplace upgrade research-skills
codex plugin add research-skills@research-skills
```

更新后，在 Codex CLI 打开 `/hooks`，信任 research-skills 的钩子，然后新建会话。钩子获得信任前，写作路由不会运行。

发布自己修改的版本前，可以只刷新插件版本号：

```bash
python3 scripts/install-local.py --prepare-only
```

### 从带 Ponytail 钩子的旧版本升级

旧版本在 Codex 中注册了 Ponytail 钩子，在会话启动时启用 Ponytail 并记录其级别。这些钩子已经移除。agent 现在在每次对话中自行加载 Ponytail 并记住其级别，方式见[技能一览](#技能一览)。Claude Code 安装包从未包含这些钩子，现在也会安装旧版本未包含的六个 Ponytail 技能。写作钩子的位置和注册字段没有变化，它在 Codex 中已有的信任仍然有效。更新后，可以清理 Ponytail 钩子留下的内容：

- Codex 会在 `~/.codex/config.toml` 中保留已移除钩子的信任记录，这些记录已不起作用。如需清理，删除 `[hooks.state]` 下键名以 `research-skills@research-skills:hooks/hooks.json:` 开头、以 `session_start:0:1`、`subagent_start:0:1` 或 `user_prompt_submit:0:0` 结尾的三条记录。以 `session_start:0:0` 和 `subagent_start:0:0` 结尾的两条属于写作钩子，请保留。
- 钩子把当前级别写在 `.ponytail-active` 文件中，位于插件在 Codex 中的数据目录（例如 `~/.codex/plugins/data/research-skills-research-skills/`）。如果该文件仍在，可以删除。Claude Code 的独立 Ponytail 插件把级别保存在 `~/.claude/.ponytail-active`，卸载该插件后这个文件可能仍在。该文件只在没有任何 Ponytail 安装使用时删除。
- 用 `$ponytail default` 设置的默认级别保存在 `~/.config/ponytail/config.json`。设置了 `$XDG_CONFIG_HOME` 时，该文件为 `$XDG_CONFIG_HOME/ponytail/config.json`，Windows 上为 `%APPDATA%\ponytail\config.json`。该文件只在没有其他 Ponytail 安装使用时删除。
- `PONYTAIL_DEFAULT_MODE` 和 `PONYTAIL_SUBAGENT_MATCHER` 已不再起作用，可以从环境中移除。

## 停用或卸载

### Claude Code

如需停用而不移除，运行 `claude plugin disable research-skills@research-skills`，之后可用 `claude plugin enable research-skills@research-skills` 重新启用。如需卸载，运行：

```bash
claude plugin uninstall research-skills@research-skills
claude plugin marketplace remove research-skills
```

然后删除 `~/.local/share/research-skills/claude-marketplace/`，并新建 Claude Code session。

### Codex

如需移除插件及其 marketplace 来源，运行：

```bash
codex plugin remove research-skills@research-skills
codex plugin marketplace remove research-skills
```

如果只想停用写作钩子而保留插件，在 `/hooks` 中关闭它，然后新建会话。在对话中关闭 Ponytail 的方法见[技能一览](#技能一览)。

## 个人偏好

写作风格、`research-explainer-animation` 的默认视觉与配音风格，以及量子简报的[研究偏好](plugins/research-skills/skills/quantum-research-radar/references/user-research-profile.md)按我的研究习惯设置。可以在请求中指定自己的偏好，也可以修改本地仓库后重新安装。
