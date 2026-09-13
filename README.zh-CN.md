# 科研与科学软件技能集

[English](README.md) | [简体中文](README.zh-CN.md)

这是我日常科研和科学软件开发中使用的 Codex 技能集，覆盖研究选题、论文阅读与写作、绘图、科学计算和代码审查，也包含按个人习惯修改的 Ponytail。我会根据实际使用持续更新，欢迎按自己的研究需要使用和调整。

**27 个技能和 Ponytail 钩子，通过一个 Codex 插件整套安装。**

## 安装

直接把仓库地址交给 Codex：

> 请安装 https://github.com/Firepanda415/research-and-scientific-lib-skills 中的全部技能和 Ponytail 钩子。

也可以在终端中运行：

```bash
codex plugin marketplace add Firepanda415/research-and-scientific-lib-skills
codex plugin add research-skills@research-skills
```

需要支持插件市场的 Codex，以及已安装并加入 PATH 的 Node.js。使用附带的 Python 脚本时还需要 Python 3。

首次安装后，在 Codex CLI 打开 `/hooks`，检查并信任这些钩子，然后新建会话。详情见 [Codex 钩子信任说明](https://learn.chatgpt.com/docs/hooks#review-and-trust-hooks)。如果已安装独立的 Ponytail 插件，请停用它，避免重复加载。

## 技能一览

可以在 Codex 中选择指定技能，也可以让 Codex 根据任务自动选择。Ponytail 默认使用 `full` 模式，可说 `stop ponytail` 在当前会话中关闭，或设置 `PONYTAIL_DEFAULT_MODE=off` 关闭默认启用。

| 技能 | 用途 | Credits |
|---|---|---|
| [develop-research-ideas](plugins/research-skills/skills/develop-research-ideas/SKILL.md) | 探索研究方向，评估研究方案，寻找可以借鉴的跨领域方法。 | [1](#credit-1) |
| [rethink-design](plugins/research-skills/skills/rethink-design/SKILL.md) | 跳出过于保守的思路，重新思考研究问题或设计方向。 | [2](#credit-2) |
| [upgrade-research-inputs](plugins/research-skills/skills/upgrade-research-inputs/SKILL.md) | 查找相关论文和一手资料，核对创新点与有争议的论断。 | — |
| [stress-test-baselines](plugins/research-skills/skills/stress-test-baselines/SKILL.md) | 设计公平的基线比较、消融实验和稳健性检查。 | — |
| [write-research-log](plugins/research-skills/skills/write-research-log/SKILL.md) | 记录研究进展、实验观察、假设与预测。 | — |
| [research-watchdog-protocol](plugins/research-skills/skills/research-watchdog-protocol/SKILL.md) | 跟进长时间运行的任务，并在不同会话之间衔接研究进展。 | — |
| [maintain-project-memory](plugins/research-skills/skills/maintain-project-memory/SKILL.md) | 整理 project memory，保留 decision rationale、可复用经验与 evidence 范围，支持后续 session 接续工作。 | [6](#credit-6), [7](#credit-7) |
| [quantum-research-radar](plugins/research-skills/skills/quantum-research-radar/SKILL.md) | 生成中文量子研究简报，关注量子计算与人工智能等相关方向。 | — |
| [physics-from-math-explainer](plugins/research-skills/skills/physics-from-math-explainer/SKILL.md) | 从数学出发解释物理，补充物理直觉，讲清符号和约定。 | — |
| [tech-paper-template](plugins/research-skills/skills/tech-paper-template/SKILL.md) | 组织技术论文的论点、引言和章节结构。 | [1](#credit-1) |
| [benchmark-paper-template](plugins/research-skills/skills/benchmark-paper-template/SKILL.md) | 规划基准测试的构建、评估方法与论文结构。 | [1](#credit-1) |
| [research-writing-style](plugins/research-skills/skills/research-writing-style/SKILL.md) | 统一研究写作风格，处理文字编辑、源文件排版和修改建议。 | [3](#credit-3) |
| [figure-designer](plugins/research-skills/skills/figure-designer/SKILL.md) | 设计论文插图、方法示意图和可复现的数据图表。 | [1](#credit-1) |
| [pre-submission-reviewer](plugins/research-skills/skills/pre-submission-reviewer/SKILL.md) | 投稿前检查论文的科学主张、证据、写作、LaTeX 排版和图表。 | [1](#credit-1) |
| [journal-cover-letter](plugins/research-skills/skills/journal-cover-letter/SKILL.md) | 起草和修改期刊投稿附信。 | — |
| [quantum-computing-review](plugins/research-skills/skills/quantum-computing-review/SKILL.md) | 为量子计算论文撰写审稿意见，遵守期刊规则与保密要求。 | — |
| [scientific-computing-correctness](plugins/research-skills/skills/scientific-computing-correctness/SKILL.md) | 实现、调试和独立验证科学计算，关注计算精度与资源开销。 | — |
| [scientific-library-review](plugins/research-skills/skills/scientific-library-review/SKILL.md) | 审查科学软件库的数学含义、使用流程、执行行为与资源开销。 | [7](#credit-7) |
| [deep-code-review](plugins/research-skills/skills/deep-code-review/SKILL.md) | 审查代码的领域正确性、工程实现、测试与资源开销。 | — |
| [simplify-codebase](plugins/research-skills/skills/simplify-codebase/SKILL.md) | 找出并移除代码中的多余复杂性，保护既有行为与必要的验证证据。 | [4](#credit-4) |
| [write-implementation-job-prompts](plugins/research-skills/skills/write-implementation-job-prompts/SKILL.md) | 将需求或审查结果整理为清晰、可执行的开发任务提示词。 | — |
| [ponytail](plugins/research-skills/skills/ponytail/SKILL.md) | 在满足正确性和性能要求的前提下，选择简单的实现。 | [5](#credit-5) |
| [ponytail-review](plugins/research-skills/skills/ponytail-review/SKILL.md) | 审查代码变更，提出有依据的简化建议。 | [5](#credit-5) |
| [ponytail-audit](plugins/research-skills/skills/ponytail-audit/SKILL.md) | 检查整个仓库中可以删除或简化的代码。 | [5](#credit-5) |
| [ponytail-debt](plugins/research-skills/skills/ponytail-debt/SKILL.md) | 汇总代码中标记的简化取舍，以及需要重新处理这些取舍的条件。 | [5](#credit-5) |
| [ponytail-gain](plugins/research-skills/skills/ponytail-gain/SKILL.md) | 展示 Ponytail 原项目的历史基准测试结果。 | [5](#credit-5) |
| [ponytail-help](plugins/research-skills/skills/ponytail-help/SKILL.md) | 查看 Ponytail 命令、模式、配置和更新方法。 | [5](#credit-5) |

## 致谢与许可证

表格 Credits 中的编号对应以下来源。Adaptation 与历史启发分别注明，各部分保留适用的 license。

1. <a id="credit-1"></a>Yuyu Luo 及贡献者。[Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills)（2026）。**CC BY-NC-SA 4.0**。四个论文与绘图 skills，以及 `develop-research-ideas` 的 proposal-evaluation reference 在其基础上改编；这些内容要求非商业使用与 ShareAlike。
2. <a id="credit-2"></a>hylarucoder。[hai-stack 中的 Geju](https://github.com/hylarucoder/hai-stack)。为 `rethink-design` 提供历史启发；该 skill 由本项目重新编写，采用本项目的 **MIT** license。
3. <a id="credit-3"></a>Lorena A. Barba。[sciwrite](https://github.com/labarba/sciwrite)（2026），其方法也参考 Kristin Sainani 的 *Writing in the Sciences*。**CC BY 4.0**。用于 `research-writing-style` 的 copyediting reference。
4. <a id="credit-4"></a>simplify-codebase 贡献者。[simplify-codebase](https://github.com/tt-a1i/simplify-codebase)（2026）。**MIT**。改编时加入 scientific evidence 的保留要求，并明确 simplification 的范围。
5. <a id="credit-5"></a>Dietrich Gebert。[Ponytail](https://github.com/DietrichGebert/ponytail)（2026）。**MIT**。包括六个 skills、Codex hook runtime 和相关资源；本版本增加 scientific accuracy 与 resource 要求。
6. <a id="credit-6"></a>Meathill。[什么样的工作流，让我觉得 Fable 也不过如此](https://meathill.com/posts/tech/my-great-ai-workflow-with-different-ai-models)（2026-09-13）。为 `maintain-project-memory` 提供思路；文章仅作为 reference，未随包分发，也不将 [7](#credit-7) 的 repository license 套用于文章。
7. <a id="credit-7"></a>Meathill。[meathill-coding-skills](https://github.com/meathill/meathill/tree/64cb92770189195c574ced31db7012ce5712f46b/skills/meathill-coding-skills)，revision `64cb927`。**MIT**。`maintain-project-memory` 借鉴 `code-maintenance` 的知识维护方法；`scientific-library-review` 的 user-workflow reference 借鉴 `website-operator-qa` 与 `product-content-audit`，并按 scientific users、现有 project owners、evidence 范围和已授权 workload 调整。

各部分的条款见 [LICENSE.md](LICENSE.md)，来源与修改说明见 [NOTICE.md](plugins/research-skills/NOTICE.md)。

## 更新

### 修改本地仓库

技能位于 `plugins/research-skills/skills/<skill-name>/`，Ponytail 钩子位于 `plugins/research-skills/hooks/`。修改后，在仓库根目录运行：

```bash
python3 scripts/install-local.py
```

这会从当前仓库整套重新安装，并自动更新缓存版本。安装后新建会话。如果钩子有变化，按 Codex 提示重新检查。后续修改都在本仓库中进行，避免直接编辑安装后的缓存。

### 从 GitHub 更新

```bash
codex plugin marketplace upgrade research-skills
codex plugin add research-skills@research-skills
```

发布自己修改的版本前，可以只刷新插件版本号：

```bash
python3 scripts/install-local.py --prepare-only
```

## 个人偏好

写作风格和量子简报的[研究偏好](plugins/research-skills/skills/quantum-research-radar/references/user-research-profile.md)按我的研究习惯设置。可以在请求中指定自己的偏好，也可以修改本地仓库。
