# Floating-point decisions

Read this reference when a numerical representation or rounding-sensitive decision changes the result. Select the relevant mechanism; it is not a checklist for every scalar calculation. The displayed formulas are derived guarantees under their stated bounds; documented library behavior is an API premise, while observed improvements without bounds remain numerical evidence or heuristics.

### Choose the quantity and scale

Distinguish exact represented identity, numerical approximation to a specified quantity, and uncertainty in physical inputs or a model. Exact equality can be appropriate for a structural case or represented identity. Arithmetic precision does not erase input uncertainty.

For approximate equality, select absolute, relative or ULP scales according to what the comparison must detect. A relative tolerance supplies no independent application scale near zero. Choose an absolute tolerance when the requested comparison needs one, and distinguish the comparator’s real-arithmetic formula from its rounded evaluation, especially near underflow. ULPs describe format spacing, including its change across powers of two; they are useful for adjacency, not an application error budget. Record the comparator's formula when its semantics matter. [PEP 485](https://peps.python.org/pep-0485/); [Dawson on comparisons](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/).

### Separate construction from acceptance

For the real condition `q(x)<=A`, distinguish a construction target `A−h` from a final comparison threshold, with finite `A>=0` and `h>=0`. If construction and evaluation have justified nonnegative bounds

`|q(x̂)−(A−h)|<=e_s` and `|q̂(x̂)−q(x̂)|<=e_f`,

then substitution gives the following **conditional guarantees**:

- `h>=e_s` preserves the original real allowance through construction.
- `h>=e_s+e_f` also makes `q̂(x̂)<=A` pass.
- Accepting `q̂(x̂)<=A+τ` alone permits `q(x̂)<=A+τ+e_f`. Preserve `A` through a separate construction bound, or allocate the extra contribution in the actual downstream budget.

The unchanged rounded check alone permits an evaluation underestimate. A certified decision instead needs a qualified upper bound `U(x̂)<=A` or another proof covering the actual construction. Bound arithmetic and conversion of the allowance must be covered too. Without those bounds, describe headroom as numerical practice supported by the available evidence.

For example, with `q(x)=x`, `A=1`, `τ=1/1024`, the candidate `1+1/2048` passes the relaxed comparison despite violating the original allowance. Solving toward `1−1/1024` only excludes that candidate if the construction error is independently controlled.

For monotone inversion, determine the feasible direction. A bracket with qualified signs can supply a feasible endpoint. A bounded `nextafter` correction can resolve a representation boundary, but one step is not a bound on previous arithmetic. Verify that the target and candidate exist in the represented domain. If adjacent points cannot resolve the decision, retain the permitted unresolved/refusal outcome.

### Translate solver error into the consumer

Identify whether termination controls coordinate error, residual, backward error or another quantity. For a scalar root, `|F′|>=m>0` along the relevant interval implies `|x̂−x*|<=|F(x̂)|/m` by the mean value theorem. A consumer with derivative bounded by `L` adds a factor `L`; an inexact residual adds its evaluation error. Without those premises, a small residual or solver success does not establish the requested accuracy. [Higham on backward error](https://nhigham.com/2020/03/25/what-is-backward-error/); [a documented root-coordinate stopping rule](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.brentq.html).

### Keep the diagnosis cheaper than the problem

Conditioning is a sensitivity concept, not a requirement to compute a condition number. First use supplied bounds, structural identities, norms or factors already needed by the algorithm, and estimates whose work and storage are understood. A wider valid bound can serve the decision better than a tight value that requires another solve. State when an estimate is only a diagnostic and cannot supply a certified bound.

Before proposing a new matrix diagnostic, inspect whether it performs a factorization, forms an inverse, applies an operator repeatedly, expands a sparse or structured representation, or repeats across many candidates. Sparse storage alone does not establish cheap work. Do not launch a dense SVD, eigensolve, condition-number computation or reference solve merely to check a premise without the resource approval required by the parent skill. Reuse an already required factorization only with its actual incremental cost and error interpretation. An unavailable cheap certificate may leave a numerical result unvalidated under the selected contract, rather than justify an expensive default veto.

Choose precision or verification work by whether it can change the requested decision. Keep small independent high-precision checks in development unless their production role is both necessary and authorized. Account for failed attempts and repeated condition checks along with successful work. See [resource accounting](resource-accounting.md) and the parent skill's [resource rules](../SKILL.md#resource-proportionality).

### Repair the mechanism

- **Cancellation:** derive an equivalent form that preserves the small information. Consider factoring, rationalizing, positive sums, `log1p`/`expm1`, or reconstruction from the nearer endpoint. Check every branch's domain and later operations; a stable primitive cannot restore information already rounded away. Exact-real equivalence supports the reformulation, but the actual evaluation still needs accuracy evidence. [Goldberg, Cancellation](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html).
- **Range:** when intermediates overflow or underflow before a later rescaling, keep a scaled or log representation through that composition. Use specialized scaled functions when their contract matches. Account for signs, zeros, subnormals and final conversion; scaling does not fix intrinsic conditioning or make an unrepresentable output representable. The usual small relative-error model needs qualification near underflow. [Python math functions](https://docs.python.org/3/library/math.html); [scaled Bessel example](https://docs.scipy.org/doc/scipy/reference/generated/scipy.special.ive.html).
- **Special functions:** separate mathematical validity, numerical-method range/termination, returned representation and achieved precision. A finite value or absent warning is not an error enclosure. A precision-loss diagnostic is not automatically unusability under a numerical contract. Inspect the exact method/version before adopting a range guard. [AMOS `ZBESI` prologue](https://netlib.org/amos/zbesi.f).
- **Certification or insufficient precision:** use directed rounding/interval/ball methods only with inclusion for the actual inputs, operations and approximation remainder. An enclosure is inconclusive when it contains values giving different decisions under the actual predicate. Dependency overestimation, uncertain inputs and exact equality can defeat precision escalation. A bounded higher-precision calculation can instead supply empirical reference evidence when that suffices. Choose according to the guarantee and cost required; one outward rounding of a final estimate does not enclose an arbitrary computation. [Arb semantics and enclosure limitations](https://raw.githubusercontent.com/fredrik-johansson/arb/master/doc/source/using.rst).

### Review the selected rule

Challenge the rule with a case where its premise fails: zero scale, a flat inverse, an adjacent endpoint, lost intermediate information, subnormal arithmetic or unresolved input uncertainty. Keep a derived guarantee distinct from an API premise, a measured comparison and a heuristic. Test the accepted quantity with enough resolution to detect the relevant defect; use `test-evidence.md` for regression design. A fixed epsilon, deflation factor or precision increase is justified only by the method's actual error model and domain.

### Further numerical resources

Use these as discovery routes when a different numerical mechanism needs a method. Follow the original source or implementation for the claim used in a decision. [Higham’s What Is collection](https://github.com/higham/what-is) covers conditioning, backward error, stability and numerical linear algebra. [Awesome Numerics](https://github.com/comp-physics/awesome-numerics) indexes broader methods, including roots, optimization, quadrature and differential equations. [Random ASCII](https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/) supplies practitioner examples of floating-point comparisons and platform behavior. [Kahan’s archive](https://people.eecs.berkeley.edu/~wkahan/) provides original numerical-arithmetic notes whose individual assumptions and implementations need inspection. A collection or an existing agent skill is a source to evaluate, not an authority to adopt every rule.
