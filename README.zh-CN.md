# 科研与科学软件技能集

[English](README.md) | [简体中文](README.zh-CN.md)

这是我日常科研和科学软件开发中使用的 Codex 技能集，覆盖研究选题、论文阅读与写作、绘图、科学计算和代码审查，也包含按个人习惯修改的 Ponytail。我会根据实际使用持续更新，欢迎按自己的研究需要使用和调整。

**26 个技能和 Ponytail 钩子，通过一个 Codex 插件整套安装。**

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

| 技能 | 用途 | 致谢 |
|---|---|---|
| [develop-research-ideas](plugins/research-skills/skills/develop-research-ideas/SKILL.md) | 探索研究方向，评估研究方案，寻找可以借鉴的跨领域方法。 | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills)（研究方案评估参考材料） |
| [rethink-design](plugins/research-skills/skills/rethink-design/SKILL.md) | 跳出过于保守的思路，重新思考研究问题或设计方向。 | [Geju](https://github.com/hylarucoder/hai-stack)（启发） |
| [upgrade-research-inputs](plugins/research-skills/skills/upgrade-research-inputs/SKILL.md) | 查找相关论文和一手资料，核对创新点与有争议的论断。 | — |
| [stress-test-baselines](plugins/research-skills/skills/stress-test-baselines/SKILL.md) | 设计公平的基线比较、消融实验和稳健性检查。 | — |
| [write-research-log](plugins/research-skills/skills/write-research-log/SKILL.md) | 记录研究进展、实验观察、假设与预测。 | — |
| [research-watchdog-protocol](plugins/research-skills/skills/research-watchdog-protocol/SKILL.md) | 跟进长时间运行的任务，并在不同会话之间衔接研究进展。 | — |
| [quantum-research-radar](plugins/research-skills/skills/quantum-research-radar/SKILL.md) | 生成中文量子研究简报，关注量子计算与人工智能等相关方向。 | — |
| [physics-from-math-explainer](plugins/research-skills/skills/physics-from-math-explainer/SKILL.md) | 从数学出发解释物理，补充物理直觉，讲清符号和约定。 | — |
| [tech-paper-template](plugins/research-skills/skills/tech-paper-template/SKILL.md) | 组织技术论文的论点、引言和章节结构。 | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [benchmark-paper-template](plugins/research-skills/skills/benchmark-paper-template/SKILL.md) | 规划基准测试的构建、评估方法与论文结构。 | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [research-writing-style](plugins/research-skills/skills/research-writing-style/SKILL.md) | 统一研究写作风格，处理文字编辑、源文件排版和修改建议。 | [sciwrite](https://github.com/labarba/sciwrite)（文字编辑参考材料） |
| [figure-designer](plugins/research-skills/skills/figure-designer/SKILL.md) | 设计论文插图、方法示意图和可复现的数据图表。 | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [pre-submission-reviewer](plugins/research-skills/skills/pre-submission-reviewer/SKILL.md) | 投稿前检查论文的科学主张、证据、写作、LaTeX 排版和图表。 | [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills) |
| [journal-cover-letter](plugins/research-skills/skills/journal-cover-letter/SKILL.md) | 起草和修改期刊投稿附信。 | — |
| [quantum-computing-review](plugins/research-skills/skills/quantum-computing-review/SKILL.md) | 为量子计算论文撰写审稿意见，遵守期刊规则与保密要求。 | — |
| [scientific-computing-correctness](plugins/research-skills/skills/scientific-computing-correctness/SKILL.md) | 实现、调试和独立验证科学计算，关注计算精度与资源开销。 | — |
| [scientific-library-review](plugins/research-skills/skills/scientific-library-review/SKILL.md) | 审查科学软件库的数学含义、使用流程、执行行为与资源开销。 | — |
| [deep-code-review](plugins/research-skills/skills/deep-code-review/SKILL.md) | 审查代码的领域正确性、工程实现、测试与资源开销。 | — |
| [simplify-codebase](plugins/research-skills/skills/simplify-codebase/SKILL.md) | 找出并移除代码中的多余复杂性，保护既有行为与必要的验证证据。 | [simplify-codebase](https://github.com/tt-a1i/simplify-codebase) |
| [write-implementation-job-prompts](plugins/research-skills/skills/write-implementation-job-prompts/SKILL.md) | 将需求或审查结果整理为清晰、可执行的开发任务提示词。 | — |
| [ponytail](plugins/research-skills/skills/ponytail/SKILL.md) | 在满足正确性和性能要求的前提下，选择简单的实现。 | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-review](plugins/research-skills/skills/ponytail-review/SKILL.md) | 审查代码变更，提出有依据的简化建议。 | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-audit](plugins/research-skills/skills/ponytail-audit/SKILL.md) | 检查整个仓库中可以删除或简化的代码。 | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-debt](plugins/research-skills/skills/ponytail-debt/SKILL.md) | 汇总代码中标记的简化取舍，以及需要重新处理这些取舍的条件。 | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-gain](plugins/research-skills/skills/ponytail-gain/SKILL.md) | 展示 Ponytail 原项目的历史基准测试结果。 | [Ponytail](https://github.com/DietrichGebert/ponytail) |
| [ponytail-help](plugins/research-skills/skills/ponytail-help/SKILL.md) | 查看 Ponytail 命令、模式、配置和更新方法。 | [Ponytail](https://github.com/DietrichGebert/ponytail) |

## 致谢与许可证

感谢以下项目的作者。这些技能在原作基础上作了适合个人科研使用的调整：

- [Supervisor-Skills](https://github.com/HKUSTDial/Supervisor-Skills)，Yuyu Luo 及贡献者：论文结构、基准测试、绘图、投稿前检查，以及研究方案评估的方法与参考材料。
- [sciwrite](https://github.com/labarba/sciwrite)，Lorena A. Barba：`research-writing-style` 中的文字编辑方法，参考 Kristin Sainani 的 *Writing in the Sciences*。
- [simplify-codebase](https://github.com/tt-a1i/simplify-codebase)，项目贡献者：以既有行为约定和验证证据为依据的代码简化方法。
- [Ponytail](https://github.com/DietrichGebert/ponytail)，Dietrich Gebert：Ponytail 技能和钩子。本版本增加了科学计算精度与资源开销方面的要求。

`rethink-design` 是重新编写的技能，历史启发来自 hylarucoder 的 [Geju](https://github.com/hylarucoder/hai-stack)。

各部分采用的许可证见 [LICENSE.md](LICENSE.md)。Supervisor-Skills 的改编内容采用 **CC BY-NC-SA 4.0**，要求非商业使用，改编后按相同许可证分享。sciwrite 的文字编辑内容采用 **CC BY 4.0**。Ponytail、simplify-codebase 和本项目原创部分采用 **MIT**。

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
