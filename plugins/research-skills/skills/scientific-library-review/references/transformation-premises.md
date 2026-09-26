# Transformation premises

Read this reference when a review covers scaling, representation, basis or wire order, control, inverse or workspace reuse, finite-shot estimates, or iterative-energy claims.

Check each transformation's common supported domain, physical frame and numerical representability. For linear solves, simultaneous nonzero scaling of operator and RHS preserves the exact solution only when both transformed inputs satisfy the selected method's premises. RHS-only scaling changes the physical solution linearly. A fixed-observable quadratic form scales by the squared magnitude, while the normalized expectation is invariant only for nonzero states. A complex scaling can leave a Hermitian-only domain.

Compare approximate outputs within propagated errors, not bitwise equality. Representation changes may alter approximation parameters, spectral enclosures or costs even when they encode the same exact problem. A representation-consistency check can share a common defect, so add an independent anchor when needed.

For basis or wire changes, transform input, action and readout together and compare the mapped ordered output. A sum or norm alone can hide a permutation defect. For control, inverse or workspace reuse, exercise the documented action on discriminating inputs and superpositions. All-zero preparation is insufficient, and global phase can become relative phase under control.

Finite-shot errors need not decrease for each seed as shots increase. Use the actual sampling model and population, including pilot costs and adaptive selection. Lower iterative energy alone establishes neither correctness nor ground-state identification. Tolerances follow the oracle, method error and statistical assumptions and must not be widened after seeing a failure just to pass.
