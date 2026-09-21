# Canonical E×U Example: Lean-QEC

## Source

[End-to-End Formalization of Quantum Error Correction](https://arxiv.org/abs/2605.16523)  
Mattias Ehatamm, Yi Lee, Xiaodi Wu, Runzhou Tao  
First posted: 2026-05-15

## Why the ordinary feed can miss it

The quantum object is central, specifically stabilizer codes and code distance, but the decisive machinery is distributed across formal verification, Lean 4, binary encodings, verified reduction, and SAT-style automation. A scan centered only on new quantum algorithms, hardware, exact QEC keywords, or same-day popularity can fail to return to it after posting day.

## Rubric calibration

| Gate | Score | Reason |
|---|---:|---|
| Quantum centrality | 2 | trustworthy QEC distance is a core reliability question |
| Bottleneck–method fit | 2 | combinatorial certification plus a trust gap naturally motivates verified reduction and proof checking |
| Discovery non-obviousness | 2 | the contribution sits across QEC, formal methods, PL, and SAT tooling |
| Capability gain | 2 | produces machine-checked distance certificates rather than an unverified solver output |
| Inspectable evidence | 2 | formal library, verified formulation, and nontrivial qLDPC case studies are reported |

Recommended classification: **[E×U] [Recovery]**.

Not **[Q×AI]**: deterministic formalization, SAT solving, and proof checking do not by themselves constitute AI.

## Example briefing entry

**[E×U] [Recovery] [End-to-End Formalization of Quantum Error Correction](https://arxiv.org/abs/2605.16523)**  
这篇工作瞄准的是 QEC 中一个很基础但常被默认可信的问题：文献给出的 code distance 是否真的有可检查的证明。作者构建 Lean-QEC，把 stabilizer-code theory、binary symplectic representation 和相关 code family formalize 到 Lean 4 中，再通过经过验证的 reduction 把 distance 条件转成 SAT instance，从而让 solver 的结果最终落到 Lean 可检查的 certificate 上。这个结合事后看很自然，因为 distance certification 同时受 combinatorial complexity 和 trust gap 限制；但它又容易被普通 quantum feed 漏掉，因为核心贡献横跨 formal methods、programming languages 与 SAT tooling。真正的新能力不是自动设计最优 QEC code，而是把若干非平凡 qLDPC code 的 distance lower bound 从“相信 solver”推进到 machine-checked certification；需要继续观察的是该流程对更大 code family、完整 logical circuit 和端到端 FTQC stack 的扩展性。

## Example ledger record

The coverage dates and context below are illustrative. An actual `covered` record requires evidence that the user received that coverage.

```json
{"schema_version":"1.0","paper_id":"arxiv:2605.16523","title":"End-to-End Formalization of Quantum Error Correction","canonical_url":"https://arxiv.org/abs/2605.16523","first_public_date":"2026-05-15","first_seen_on":"2026-06-18","last_seen_on":"2026-06-18","status":"covered","covered_on":["2026-06-18"],"coverage_level":"detailed","coverage_contexts":["calibration_example"],"tags":["E×U","Recovery","QEC","formal-verification"],"selection_reason":"Machine-checked QEC distance certification recovered through a formal-methods search lane.","revisit_triggers":["journal publication","public code or proof-artifact release","major extension to additional code families","integration into end-to-end FTQC verification"],"notes":"Illustrative coverage events for calibration, not a user's actual history."}
```
