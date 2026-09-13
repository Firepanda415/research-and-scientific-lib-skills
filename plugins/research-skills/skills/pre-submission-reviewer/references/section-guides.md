# Optional section organization patterns

Use the paper's argument, discipline, and venue to choose structure. The functions below are prompts for missing content, not required sentences, paragraphs, figures, or datasets.

## Abstract

State the problem, contribution, main evidence, and necessary scope. A theoretical result may be expressed by a theorem or scaling law rather than a benchmark number. Include a challenge or motivation only when it helps explain the contribution. Do not invent an unsupported novelty or performance claim to fill a template.

## Introduction

Connect the problem and existing limitations to the proposed contribution. Cite the relevant prior work where it supports that comparison. A running example or a challenge-to-method map is useful for some papers, but no fixed six-paragraph sequence is required.

## Problem and method

Define objects, assumptions, output, and success criteria. Present the argument in the dependency order a reader needs. An overview figure or example is optional. Explain standard components sufficiently to understand result-affecting choices; novelty alone does not determine how much explanation is necessary.

Report units, normalization, cutoffs, solver settings, initial conditions, and other consequential parameters in Methods, supplementary material, or a clearly referenced configuration. Keep irrelevant file paths and implementation names out of the scientific narrative.

## Experiments

Match evidence to the claim. Choose representative instances and meaningful baselines under comparable budgets, tuning, stopping, and information access. Controlled synthetic instances may be the correct evidence for a scientific mechanism; real datasets and fixed dataset counts are not universal requirements.

Use an ablation, exact small case, convergence study, or other decisive check when it resolves a specific uncertainty. Do not demand an experiment for every component or parameter. A prior result that one method beats another does not automatically make that ranking transferable to a new problem and budget.

Describe the observed result and its uncertainty. Distinguish a supported mechanism from a plausible explanation. Report failures or selection rules when they affect the claim, without narrating every table entry.

## Related work

Place related work where it helps comprehension. Compare the closest relevant methods accurately, credit inherited contributions, and state the new boundary. Use the venue's bibliography style and verify citation metadata against the actual source. DBLP and database-venue abbreviations are not universal requirements.

## Conclusion

State what the evidence establishes and where it applies. Repeat a result or qualification where needed for independent interpretation, without copying the Introduction or adding unsupported future claims. Tense follows the sentence's meaning and the discipline, not a fixed section rule.
