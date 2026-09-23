---
name: physics-from-math-explainer
description: "Explain physics-heavy mathematics (rotating frames and RWA, ladder operators, Josephson/transmon-to-Kerr reductions) to a mathematically strong reader who needs physical intuition and explicit conventions. Use for quantum, continuous-variable (CV) and circuit-physics explanations or study notes."
---

# Physics-from-Math Explainer

## Select depth

- **Short:** give the usable physical conclusion and any scale condition or
  limitation needed to interpret it correctly.
- **Standard:** add symbol definitions, frame or picture, statement status,
  derivation chain, physical interpretation, and failure conditions.
- **Study-note:** load `references/physics-study-note-handbook.md` and produce a
  reusable note with the relevant operator, RWA, or Hamiltonian-reduction template.

Infer depth and prerequisites from the question and supplied context. Do not ask for inputs
already clear or force the full study-note structure onto a narrow question. This skill
remains specific to physics; ordinary nonphysics explanation needs no physics workflow.

## Core workflow

1. **Assess prerequisites.** Name only the missing physics concepts needed for the
   current result.
2. **State the conclusion in words first.** Do not place undefined symbols in the
   opening conclusion.
3. **Define symbols and conventions.** State units, commutators, basis, frame or
   picture, sign conventions, and whether `\hbar=1`.
4. **Label every load-bearing statement.** Distinguish definition, exact operator
   identity, basis-dependent equality, approximation, perturbative truncation,
   RWA replacement, effective model, convention, and empirical assumption.
5. **Make scale conditions explicit.** For a dropped rotating term with strength
   `g` and rotation frequency `Omega`, state the relevant requirement such as
   `|g| << |Omega|`, together with resonance and timescale qualifications.
6. **Derive in small steps.** Identify the raw Hamiltonian, variables, chosen frame,
   expansion, operator substitution, ordering, retained and discarded terms,
   coefficient matching, and final effective model as applicable.
7. **Explain both views.** Give the mathematical meaning and the physical process or
   measurement meaning. Do not use metaphor as a substitute for derivation.
8. **State what fails.** Name the excitation, coupling, drive, resonance, multimode,
   decoherence, or truncation regime that invalidates the result.
9. **Correct a relevant near miss.** Explain a nearby interpretation when the user
   raises it or it would otherwise plausibly change the answer.

## Hamiltonian coefficient contract

Whenever reducing to a Kerr or Duffing form, state:

- whether the Hamiltonian is in energy or angular-frequency units;
- whether the nonlinear term is written as `K N(N-1)/2`, `K N^2`, or another convention;
- the sign convention for `K` and the corresponding anharmonicity;
- which constant and linear terms were dropped or absorbed into the frequency;
- the perturbative and excitation regime in which the coefficient is valid.

Never switch from `H` to `H/\hbar` without updating coefficient units.

## Source and evidence discipline

- Inspect a supplied derivation, manuscript, circuit model, or code artifact before
  explaining its claim.
- Separate what the source states from what follows by reconstruction.
- Locate source-backed claims where useful. A published equation is not automatically correct;
  identify abstract-only, inaccessible, or otherwise unverified material explicitly.
- Do not present an approximation arrow as algebraic equality.
- Do not infer hardware-native dynamics from an effective Hamiltonian.
- Mark convention-dependent coefficients rather than forcing a universal sign or factor.

## Language and formatting

Follow the user's language. Define specialized English terminology bilingually on first
use when helpful, then remain consistent. Define symbols before the first formula that
uses them. Use compact tables only when they reduce notation load. Do not use em dashes
in authored prose unless the user or the destination requires them. Use commas,
parentheses, or separate sentences instead, as `research-writing-style` sets out.

## Completion check

Verify that:

- the conclusion is usable without undefined notation;
- the basis, frame, units, and conventions are explicit;
- exact and effective statements are separated;
- every approximation has a scale condition and failure regime;
- coefficient signs and factors are traceable;
- the formal derivation and physical intuition agree;
- the explanation matches the requested depth.
