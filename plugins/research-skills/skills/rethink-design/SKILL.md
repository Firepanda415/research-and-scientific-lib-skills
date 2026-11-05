---
name: rethink-design
description: Reconsider a research direction or system design when the user wants a more ambitious outcome or suspects the current approach limits progress. Use for rethink the direction, too incremental, or 格局大一点. A routine implementation request does not require reconsidering the goal.
license: MIT
---

# Rethink Design

Help the user decide whether a different problem formulation would make the work more valuable. Begin with the outcome they care about and the evidence that the present approach falls short. If the current approach already serves that outcome, explain why before proposing more work.

Before comparing designs, separate the outcome and necessary relations from replaceable means. Preserve scientific meaning, user commitments and external obligations. Treat an API, schema, module boundary, validation scheme or earlier plan as a choice whose purpose must still hold. Prior approval, reviewer preference or passing tests alone do not establish that purpose. State what must remain true and which choices may change within the user's authority.

## Locate the limiting choice

Inspect enough of the supplied proposal, result, or implementation to identify which choice limits progress. The limitation might concern the question asked, the quantity measured, the available information, or the division of responsibility. Distinguish an observed limitation from an assumption about what might happen.

Ask what changes if that choice is replaced. Develop a concrete alternative whose benefit can be explained through a mechanism. A larger architecture, stronger adjective, or longer feature list does not establish a better direction.

For research, connect the alternative to a useful scientific question and identify what existing result it would extend, challenge, or explain. For software, connect it to a representative user's task and the operation that would become possible or simpler. Use whichever interpretation fits the request.

When repeated fixes reconcile the same fact across stages, trace where that fact is produced and lost. Consider carrying one established decision into its consumers or simplifying ownership and lifetime before adding another verifier, cache or accounting layer. Show which mismatch or repeated work the change removes.

## Make the decision assessable

Explain the expected benefit, the commitments required, and the uncertainty most likely to reverse the recommendation. Respect available data, instruments, budgets, supported behavior, and the user's authority over changes. An attractive outcome does not make an unavailable resource available.

When uncertainty is decisive, identify an observation that would distinguish the alternatives. Prefer evidence already available; otherwise describe a bounded check and its cost. Do not launch additional costly work without the required authorization.

Give a clear recommendation with enough reasoning to evaluate it. The user may choose to retain the current direction, revise its scope, or pursue the alternative. Carry that choice into subsequent work without treating this discussion as permission to modify a system or expand an experiment.

When the reconsideration needs candidate directions generated or compared, use `develop-research-ideas`. To check an alternative's closest prior work or novelty, use `upgrade-research-inputs`.
