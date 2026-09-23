## Coverage and consequence

For a full review, cover the following dimensions where they bear on the paper's claims.
Combine checks when they share evidence; separate pass reports are unnecessary. In Revision
mode, focus on the original concerns, changed sections, and new claims. A requested
comprehensive audit must not stop simply because the recommendation is already apparent.

1. **Claim and attribution pass.** Check the title-level novelty, every load-bearing claim,
   the contribution of the credited component (the quantum-specific contribution, for a
   quantum manuscript), strongest alternative explanation, baseline fairness, platform or
   hardware interpretation, scalability, and novelty boundary.
2. **Numerical algorithm and evidence pass.** Check equations, algorithm semantics,
   convergence or failure behavior, hyperparameters, stopping rules, metrics, statistics,
   finite-shot decoding, resource accounting, and reproducibility.
3. **Application and communication pass.** Check the mapping from variables to the physical
   or scientific problem, objective or figure of merit, surrogate validity, causal attribution,
   scope limitations, figure interpretability, and whether essential explanations are present.

Distinguish verified findings from unresolved questions. For a suspected sign, factor, index,
or notation error, reconstruct the intended convention and propagate the smallest plausible
correction through the dependent argument and results. Call it a local typo only when the
correction leaves the scientific conclusion intact. Uncertain consequences are unresolved,
not automatically fatal or harmless. Paper-based implementation requires resolving such a
discrepancy before using it, even when it would be a Minor referee comment.

Use these checks when the corresponding mechanism carries a claim:

- **Optimization metric.** Identify which changes of units or origin preserve the metric's
  meaning. Test invariance only under those admissible conventions. An arbitrary-origin
  energy ratio needs particular scrutiny; a standard approximation ratio with a meaningful
  zero need not be shift-invariant. Check denominators, sign, zero, reference construction,
  and cross-instance aggregation where they affect the conclusion.
- **Finite-shot decoder gate.** Identify the exact decoder, the correlations it retains, and
  its shot scaling. When an exact product distribution is used, define $p_k$ as the modal
  probability of block $k$ and check the joint modal probability
  $p_{\mathrm{joint}}=\prod_k p_k$ before treating the most frequent global bitstring as a
  scalable readout rule.
- **Embedded local-objective gate.** When a local or block subroutine is embedded in a global
  objective, distinguish the objective induced by dropping cross-boundary terms from the
  conditional global objective obtained by fixing the outside variables. Check whether this
  distinction changes local rankings, updates, or the contribution ablation.

The [reviewer handbook](reviewer-handbook.md) gives the full procedures under `#### 3.3 Metric Validity`, `#### 3.4 Finite-Shot Decoder and Product-Distribution Scaling: Hard Gate`, and the embedded local-objective paragraph of `### Step 4: Isolate the Claimed Contribution`. Load them when a gate applies to a central claim.
