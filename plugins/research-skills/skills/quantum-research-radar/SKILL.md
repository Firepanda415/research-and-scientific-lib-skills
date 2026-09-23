---
name: quantum-research-radar
description: Produce selective Chinese quantum research briefings with current primary sources, user-specific relevance, missed-paper recovery, and substantive Quantum × AI. Use for quantum research radar, 量子早报, daily or weekly briefs, or a focused scan of recent work on a topic. A single-paper explanation does not require this workflow.
---

# Quantum Research Radar

Find papers that change scientific understanding, available methods, or the
user's research decisions. Rank by evidence and relevance, not feed position,
prestige, or novelty language. Keep important technical terms in English.

## Scope and sources

Respect the requested topic, period, and depth. For personal relevance, read the
bundled author profile (default), `references/user-research-profile.md`, unless the user asks
for an untailored scan. Consult `references/source-and-query-map.md` when query
expansion or overlooked venues would improve coverage. For a question-driven
literature review or a prior-work or novelty check, use `upgrade-research-inputs`.

Preferences the user states in the request or in project guidance take precedence
over the bundled profile. When only the bundled profile shaped relevance for a user
who is not its author, do not phrase that relevance as the user's own connection.

For the usual daily or weekly brief, search both fresh work (today through the
previous 3 calendar days) and rolling recovery (4–60 days). These are defaults,
not limits on a user-requested period or a scientifically important older source.
Use first-public and material-update dates separately. A strong recovery paper
can outrank a weak fresh paper.

Use current primary sources for technical claims. Social posts, aggregators,
rankings, and press coverage can aid discovery but do not replace the paper,
supplement, repository, proof artifact, or technical report. Never claim full
reading, reproduction, or validation when only a smaller source was inspected.

Choose relevant search lanes: fresh quantum work, the user's topics, adjacent
methods, Quantum × AI, and scientific software or hardware. Broad briefs should
include a recovery query beyond the obvious feed. A focused scan need not cover
unrelated subfields or fill every lane. Stop searching when the requested coverage
is adequate or further search is unlikely to change the selection within budget.

## Select and explain

- Deduplicate by arXiv ID, DOI, or another stable primary identifier. Merge versions
  and press coverage of the same work; describe a material update when revisiting it.
- Inspect enough primary material to identify the actual problem, mechanism,
  strongest evidence, tested regime, meaningful comparison, and main limitation.
  Inspect decisive methods, assumptions, or artifacts more closely for top-ranked
  or disputed candidates. Do not invent a complete evidence card for every hit.
- Use `references/selection-policy.md` for ambiguous ranking decisions. Scientific
  significance, useful negative evidence, and credible infrastructure can matter
  even without a new headline algorithm. Diversity is useful when quality permits.
- Apply `references/expected-unexpected-rubric.md` before labeling an item E×U,
  and `references/quantum-ai-quality-gate.md` before labeling it Q×AI. Load related
  examples only when calibration is needed. Deterministic optimization, SAT/SMT,
  proof checking, or automation alone does not establish an AI contribution.
- Distinguish theorem, numerical evidence, hardware demonstration, engineering
  result, and interpretation. Explain why a selected paper matters without
  extending its claims beyond its assumptions or evidence.

## Output and tracking

Default to a concise prioritized briefing with direct primary links, the useful
mechanism or finding, its evidence and scope, and the user's connection when
relevant. Do not fill weak sections, impose paper counts, or repeat full summaries.
End with a one-line coverage note: listings or queries actually fetched, date windows,
lanes skipped, and retrieval limits.
Use `references/output-template.md` for a requested full briefing, adapting its
optional sections to the evidence. Briefings are kept and reread, so their prose
follows `research-writing-style`, including its review before delivery. The concise
default above and `references/output-template.md` still set the structure.

Use an existing coverage ledger only when prior coverage is relevant and available.
Never infer that a paper was previously covered from memory alone. Revisit for a
material result, revision, artifact release, correction, or newly useful connection,
not merely a repost.

Persistent tracking remains opt-in. Ordinary briefing requests do not require creating a ledger, writing state, or emitting a ledger delta. For an authorized tracking workflow, read `references/coverage-ledger-schema.md` and use `scripts/ledger_tool.py` for path resolution, initialization, lookup, validation, and updates.

New ledgers start empty. Import existing coverage with `init --seed PATH` only when the user requests that history. The packaged `data/briefing-history.seed.jsonl` is an immutable calibration example, not evidence of anyone's previous coverage. Runtime state and backups stay outside the installed skill. Generate a ledger delta only when requested or needed by an established tracking workflow.

The runtime path follows `QUANTUM_RESEARCH_RADAR_LEDGER`, otherwise
`${XDG_STATE_HOME:-~/.local/state}/quantum-research-radar/briefing-history.jsonl`.
The helper supports an explicit `--ledger` path. Initialize only after opt-in.

`prompts/` contains optional full, compact, focused, and scheduled request examples.
`scripts/package_check.py` validates packaging and a temporary ledger lifecycle;
it is not part of producing each briefing. Schedules use the host's actual
scheduler and require a scheduling request. Cross-run deduplication requires
opted-in tracking with a ledger path that the scheduled run can read.
