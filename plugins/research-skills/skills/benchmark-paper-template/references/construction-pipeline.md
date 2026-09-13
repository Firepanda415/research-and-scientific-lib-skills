# Benchmark construction and reproducibility

Choose a construction method that represents the evaluation question faithfully.
Existing data, analytical instances, controlled perturbations, generated tasks,
and expert annotations serve different purposes. No construction paradigm or
number of stages is mandatory.

Document choices that affect validity or reproduction: source selection,
instance parameters, generation/filtering rules, reference computation,
annotation, splits, and quality checks where applicable. Exact conventions and
parameters matter when a reader could obtain different results from another
reasonable implementation. Avoid a separate formal stage record for trivial
operations that are already clear from code or configuration.

For numerical benchmarks, identify the reference method's assumptions, precision,
truncation, convergence, and error criterion. A successful solve or a plausible
plot does not establish a trustworthy reference. Use analytical or independently
trusted cases when possible; do not duplicate an expensive reference calculation
for every derived report.

Controlled injection can isolate a failure mechanism if the perturbation and
reference are valid. Synthetic data can be useful when its relationship to the
target regime is stated. Generated labels are not trustworthy solely because a
model or tool produced them. Use checks selected for plausible failure classes,
including sampled review when a full review is unnecessary or infeasible.

For learning-based evaluation, keep training, selection, and held-out test data
separate and check meaningful leakage or near-duplicates. For other settings,
use the independence and coverage controls the comparison actually requires.

Preserve construction configs, provenance, and enough evidence to diagnose
consequential failures. Keep large intermediates only when rerun cost or later
analysis justifies them. Do not add logs, copies, or dense reference artifacts
merely to satisfy a generic pipeline checklist.
