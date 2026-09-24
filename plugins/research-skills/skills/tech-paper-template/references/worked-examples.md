# Filled method-paper skeletons

## Table of contents

1. How to read these examples
2. Example A: Alpha-SQL, new method or mechanism
3. Example B: AFlow, new method with a cross-field transfer
4. Example C: LEAD, new problem or setting
5. Cross-example observations

## 1. How to read these examples

Each example below fills a method-paper skeleton retrospectively
for a published paper. Details are illustrative reconstructions and
are not guaranteed to match the original papers word for word. The
narrative labels follow the rows of [paper-types.md](paper-types.md).
The tables split the prompts in [thinking-template.md](thinking-template.md)
into numbered limitations, challenges, modules, and contributions.
Those counts come from each paper and are not a pattern to copy.

## 2. Example A: Alpha-SQL, new method or mechanism

### Paper-type positioning

New method or mechanism. Text-to-SQL is well established, and the
contribution is a new inference-time mechanism (MCTS search).

### Filled template

| Stage | Content |
|---|---|
| Research background | Text-to-SQL for enterprise analytics. Production use by analysts who do not know SQL. Recent work: OpenAI Codex, DIN-SQL, DAIL-SQL |
| Limitation 1 | Single-pass prompting fails on complex multi-table JOIN queries |
| Limitation 2 | Fine-tuning on each schema is expensive and does not generalise |
| Key Idea | Use Monte Carlo Tree Search at inference time to explore SQL candidates and score them via execution feedback |
| Challenge 1 | SQL candidate space is combinatorial; naive search is intractable |
| Challenge 2 | No trained critic is available for inference-time reward |
| Methodology topic sentence | Alpha-SQL combines structured MCTS search over SQL parse trees with self-supervised reward from execution feedback |
| Module A | MCTS-guided SQL generation with learned expansion priors |
| Module B | Self-supervised reward via execution-based validation |
| Contribution 1 | MCTS-based Text-to-SQL inference framework (Section 3) |
| Contribution 2 | Self-supervised reward design (Section 4) |
| Evidence | Experiments on BIRD and Spider with N-point gains (Section 5) |

### Consistency checks

- Mechanism to evidence ([consistency-checks.md](consistency-checks.md)):
  check in the paper whether the experiments separate the effect of the
  search from the effect of the execution-based reward.
- Evidence to contribution: check that the benchmarks and query types
  tested cover the scope claimed for the framework.

## 3. Example B: AFlow, new method with a cross-field transfer

### Paper-type positioning

New method or mechanism, combined with a cross-field transfer.
Operator-graph search is transplanted from NAS to agent workflows.

### Filled template

| Stage | Content |
|---|---|
| Research background | LLM agents for code generation; HumanEval and MBPP benchmarks; recent work on agent workflows |
| Limitation 1 | Prompt engineering alone yields brittle workflows |
| Limitation 2 | Single-agent architectures do not capture operator composition |
| Limitation 3 | Hand-designed workflows do not generalise across task families |
| Key Idea | Formulate agent-workflow design as search over operator graphs, borrowing from neural architecture search |
| Challenge 1 | Operator-graph search space is combinatorial |
| Challenge 2 | Reward signal for a workflow is discrete and sparse |
| Methodology topic sentence | AFlow combines operator-graph search guided by execution-based rewards |
| Module A | Operator-graph search with learned priors |
| Module B | Structured reward via code execution |
| Contribution 1 | Formulate workflow design as operator-graph search (Section 2) |
| Contribution 2 | AFlow search algorithm (Section 3) |
| Evidence | Experiments on HumanEval, MBPP with consistent gains over hand-designed workflows (Section 4) |

### Consistency checks

- Assumptions to mechanism ([consistency-checks.md](consistency-checks.md)):
  check in the paper which properties of architecture search the transfer
  relies on and whether they hold for agent workflows.
- Evidence to contribution: check that the task families tested support
  the claim about generalization across task families.

## 4. Example C: LEAD, new problem or setting

### Paper-type positioning

New problem or setting. The goal carries the narrative.

### Filled template

| Stage | Content |
|---|---|
| Research background | Instruction tuning of LLMs; data quality beats quantity; recent work on iterative data selection |
| Limitation 1 | Non-iterative selection does not adapt to model evolution |
| Limitation 2 | Iterative methods require expensive full-dataset inference per round |
| Key Idea / Our Goal | (Goal) Iterative data selection without any additional inference overhead. (Key Idea) Use the training loss already computed inside the fine-tuning loop as a zero-overhead utility signal |
| Challenge 1 | Extract a reliable utility signal from noisy training-loss trajectories |
| Challenge 2 | Integrate the selection signal into the training loop without disturbing convergence |
| Methodology topic sentence | LEAD uses Instance-level Dynamic Uncertainty as a utility signal and defers selection to a cadence that preserves convergence |
| Module A | Instance-level Dynamic Uncertainty signal with statistical denoising |
| Module B | Deferred selection integrated into the fine-tuning loop |
| Contribution 1 | Problem formulation: iterative data selection without additional inference (Section 2) |
| Contribution 2 | Instance-level Dynamic Uncertainty with theoretical analysis (Sections 3, 4) |
| Contribution 3 | LEAD framework design (Section 3) |
| Evidence | Experiments in Section 5. This reconstruction does not record their benchmarks or gains, so take them from the paper |

### Consistency checks

- Question to result ([consistency-checks.md](consistency-checks.md)):
  check in the paper that the cost accounting supports the stated goal
  of iterative selection without additional inference.
- Mechanism to evidence: check whether the experiments separate the
  effect of the uncertainty signal from the effect of the deferred
  selection schedule.

## 5. Cross-example observations

- These examples make their problem, method, and claimed contribution
  traceable. Their counts of limitations, challenges, modules, and
  contributions are illustrative, not requirements.
- A new problem formulation or cross-domain transfer can carry a
  contribution when it changes the scientific question or capability.
  Its position and space in the paper follow its role in the argument.
- Use the consistency questions to find an unsupported link, not to
  award a venue-readiness score. A paper may need a different structure,
  and a coherent outline does not validate its scientific claims.
- A contribution should state what the evidence establishes. Section
  pointers can help navigation but are not required for every claim.
