# Selection Policy

## Core ordering

Rank candidates in this order:

1. **Scientific or capability impact**: does the work change what can be understood, built, verified, automated, or trusted?
2. **User relevance**: is there a direct project connection or a plausible reusable method?
3. **Evidence quality**: theorem, formal certificate, controlled numerical study, realistic benchmark, hardware result, reproducible artifact, or careful negative result.
4. **Discovery value**: does it reveal a useful connection that ordinary feeds would miss?
5. **Generality**: reusable framework or transferable insight rather than a one-off score.
6. **Recency.**
7. **Community attention.**

Recency and popularity are discovery signals. They must not outrank a major capability shift.

## Optional scoring card

Use this score only to discipline judgment; it does not override hard gates.

Score each dimension from 0 to 4:

| Dimension | Weight | 0 | 4 |
|---|---:|---|---|
| Scientific/capability impact | 6 | cosmetic or unclear | changes a capability, theorem, trusted workflow, or scientific conclusion |
| User relevance | 5 | no plausible connection | direct or strongly reusable for active work |
| Evidence quality | 5 | unsupported claim | rigorous, realistic, independently checkable, or strongly controlled |
| Discovery value | 3 | already obvious and redundant | important connection ordinary feeds likely miss |
| Generality | 3 | one-off demonstration | reusable across systems, tasks, or code families |
| Recency | 1 | old with no new trigger | current material update |
| Community signal | 1 | no external signal | meaningful expert attention or follow-up |

Weighted score:

```text
score = 6I + 5R + 5E + 3D + 3G + 1N + 1C
```

Maximum: 96.

Suggested interpretation:

- **75–96:** strong top-five candidate.
- **62–74:** strong section candidate; may enter top five if especially tailored or diverse.
- **50–61:** watchlist or concise mention.
- **Below 50:** normally omit.

Do not promote a paper that fails scientific validity, Quantum × AI hard gates, or E×U hard gates merely because its numeric score is high.

## Evidence hierarchy

Use these labels internally:

1. **Formal/theoretical:** proved theorem, formal proof, verified reduction, certificate.
2. **Experimental hardware:** controlled hardware result with relevant scale and comparison.
3. **Numerical/empirical:** simulation or benchmark with meaningful baselines, ablations, and uncertainty.
4. **Artifact-backed engineering:** inspectable code, data, compiler, benchmark, or reproducibility package.
5. **Preliminary demonstration:** small proof of concept with explicit limitations.
6. **Announcement only:** no inspectable technical support; normally not a paper selection.

No evidence type is automatically superior in every context. Match the claim to the evidence.

## Composition rules

- Prefer one strong representative from a cluster of near-duplicate papers.
- Do not let one institution, author group, platform, or fashionable keyword dominate without scientific justification.
- Include careful negative results, limitations, replications, and benchmark corrections when they materially improve research decisions.
- A platform item belongs in the top five only when it changes a scientific capability or credible roadmap assumption.
- A directly relevant paper can outrank a broadly popular paper even when its community signal is smaller.
- An E×U paper should not be included merely to create variety.
- A Q×AI paper should not be included merely to satisfy an intersection quota.

## Claim calibration

Use verbs according to evidence:

- **proves / certifies**: only for theorem or machine-checked/formally verified claims.
- **demonstrates**: direct experiment or controlled implementation.
- **shows numerically / reports**: numerical or empirical evidence.
- **suggests / indicates**: limited or indirect evidence.
- **proposes**: method without decisive validation.
- **claims**: reserve for unverified or disputed statements and explain why.

## Rejection reasons

Record one or more when useful:

- quantum problem is peripheral;
- novelty is mostly packaging or terminology;
- evidence does not support the scope of the claim;
- baseline is weak or missing;
- no material improvement over prior work;
- scale is toy-level without a clear scaling argument;
- duplicate of a stronger selected item;
- press release without technical artifact;
- previously covered with no revisit trigger;
- fails E×U or Q×AI hard gate.
