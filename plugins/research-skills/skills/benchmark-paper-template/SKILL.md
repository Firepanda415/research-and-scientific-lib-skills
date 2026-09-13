---
name: benchmark-paper-template
description: Plan, draft, or assess a benchmark paper's evaluation gap, construction, measurement design, and findings. Use for benchmark contributions and their paper structure. Adapt the evaluation to the scientific question; an LLM dataset, companion method, human baseline, or fixed paper skeleton is not required.
---

# Benchmark Paper Template

Explain what the benchmark measures, why that measurement matters, how the
instances and results were produced, and what the evidence teaches. A benchmark
can expose limitations, establish reproducible measurement, or compare regimes;
it need not introduce a new algorithm or a new evaluation dimension.

## Scientific substance

- **Evaluation need:** identify the unresolved comparison or measurement problem
  and the closest relevant existing work. More data or larger instances matter
  only when they address a justified coverage or reliability need.
- **Construction:** describe source selection, generated instances, annotations
  or reference solutions, filtering, and splits where they affect validity or
  reproduction. Use exact parameters and provenance for result-sensitive choices.
- **Measurement:** define metrics, resource budgets, tested regimes, and the
  comparison protocol. Check budget/tuning parity, uncertainty, and relevant
  failure cases; avoid adding categories or diagnostics merely for breadth.
- **Findings:** state what the observed evidence supports and what it does not.
  A negative or limited finding can be useful without a bold performance claim.

For quantum-computing benchmarks, identify the access model and include relevant
preparation, execution, measurement, classical processing, memory, and storage
costs. Do not treat a simulated quantum result as a hardware or end-to-end
advantage. Validate on small trustworthy instances when useful before paying for
large runs. Diagnostics should not silently dominate benchmark cost.

Human baselines, learned judges, contamination controls, dataset splits, and a
companion method apply only to settings that need them. If a companion method is
included, separate its research question and training/tuning data from held-out
evaluation; absence of such a method is not a missing contribution.

## Structure and output

Answer the requested stage: an idea assessment, experiment plan, outline, draft,
or review. Infer available inputs from the supplied artifacts and ask only for
missing information that changes the work. Do not run all stages or a
pre-submission checklist merely because one stage was requested.

A common narrative is evaluation need → benchmark design → measurements →
findings → implications. Choose sections, figures, research questions, and
contribution count from the argument and venue. Examples are optional; no fixed
Figure 1, human–AI gap, page budget, or six-part Introduction is mandatory.

Keep exact reproducibility details where needed, often in methods, captions,
appendices, or a configuration artifact. Keep the main narrative focused on
scientific meaning. Report gaps by their effect on validity, comparison, or
interpretation, not by template compliance.

## Optional references

Read the relevant stage only:

- [gap-analysis.md](references/gap-analysis.md): identifying evaluation needs.
- [benchmark-design.md](references/benchmark-design.md): task and metric design.
- [construction-pipeline.md](references/construction-pipeline.md): construction
  choices and reproducibility.
- [experiments.md](references/experiments.md): fair comparisons and analysis.
- [paper-structure.md](references/paper-structure.md): optional narrative examples.
- [checklist.md](references/checklist.md): targeted pre-submission checks.
- [instantiation-template.md](references/instantiation-template.md): a fillable
  example when the user wants a template; omit irrelevant slots.
