## Source-to-code fidelity

For paper-based implementation, locate the actual equations, algorithm, and
parameter definitions before coding. Check sign, units, normalization, basis and
index ordering, boundary conditions, initialization, truncation, precision,
stopping rules, and library defaults where they affect the result. Explain the
notation map and derivation when an equivalent formula is used.

Preserve the source's quantifiers, domains, and order of choices: `at most`
is not `exactly`, an asymptotic statement is not a finite-instance guarantee,
and an instance-dependent choice is not a uniform one. State any additional
assumption needed to turn a source bound into an executable rule.

Resolve a suspected typo from the surrounding derivation or an independent
check; record the interpretation instead of silently changing the method. If
an ambiguity changes the result and cannot be resolved, expose the alternatives
and the missing fact. Prototype status reduces implementation scope, not fidelity
to the chosen mathematical specification. Use a small independent reference
case before scaling; a successful run alone does not establish reproduction.
