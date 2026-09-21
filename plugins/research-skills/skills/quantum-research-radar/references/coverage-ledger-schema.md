# Coverage Ledger Schema

## Table of contents

1. Purpose and required fields
2. Canonical IDs, status values, and coverage levels
3. Revisit triggers and deduplication
4. Update procedure and persistence fallback

## Purpose

The external runtime `briefing-history.jsonl` prevents repeated coverage, supports recovery of missed work, and allows legitimate revisits when a paper receives a material update.

The ledger is a **current-state JSONL store**: one JSON object per canonical paper ID. The helper script rewrites the affected record while preserving a compact coverage history.

New ledgers start empty. The installed `data/briefing-history.seed.jsonl` is an immutable calibration example whose coverage events are illustrative. Do not use it as evidence of a user's previous coverage.

Resolve the permitted absolute Python interpreter and this installed skill's absolute directory before running the helper. Use a project-required checked runner when applicable. Replace both placeholders in these command templates:

```sh
"<absolute-interpreter>" "<absolute-skill-dir>/scripts/ledger_tool.py" path
"<absolute-interpreter>" "<absolute-skill-dir>/scripts/ledger_tool.py" init
```

Initialize only after tracking is authorized. `init --empty` also creates an empty ledger. Use `init --seed PATH` only to import the existing JSONL history requested by the user. Initialization refuses to overwrite an existing ledger unless `--force` is supplied. Override the runtime path with `QUANTUM_RESEARCH_RADAR_LEDGER`, `XDG_STATE_HOME`, or `--ledger PATH`. Runtime backups are written under `.backups/` beside the ledger.

## Required fields

This illustrative record shows the field format. An actual `covered` record requires evidence that the user received that coverage.

```json
{
  "schema_version": "1.0",
  "paper_id": "arxiv:2605.16523",
  "title": "End-to-End Formalization of Quantum Error Correction",
  "canonical_url": "https://arxiv.org/abs/2605.16523",
  "first_public_date": "2026-05-15",
  "first_seen_on": "2026-06-18",
  "last_seen_on": "2026-06-18",
  "status": "covered",
  "covered_on": ["2026-06-18"],
  "coverage_level": "detailed",
  "coverage_contexts": ["calibration_example"],
  "tags": ["E×U", "Recovery", "QEC", "formal-verification"],
  "selection_reason": "Machine-checked QEC distance certification recovered from a cross-disciplinary lane.",
  "revisit_triggers": ["journal publication", "public code release"],
  "notes": "Illustrative coverage events for calibration, not a user's actual history."
}
```

## Canonical ID rules

Use, in order:

1. `arxiv:YYMM.NNNNN` with version suffix removed;
2. `doi:10.xxxx/...` normalized to lowercase;
3. stable repository/release identifier;
4. `title:<normalized-title>` only as a last resort.

A journal version and arXiv version of the same work share one record unless the journal paper is substantively different.

## Allowed status values

- `candidate`: found but not yet selected;
- `deferred`: potentially useful, intentionally postponed;
- `covered`: appeared in a brief or a deliberate manual recovery discussion;
- `rejected`: inspected and not currently suitable;
- `superseded`: replaced by another canonical record;
- `retracted`: withdrawn or retracted; retain for audit.

Finding a paper does not make it `covered`.

## Coverage levels

Ordered from lowest to highest:

1. `mention`
2. `brief`
3. `detailed`
4. `deep-dive`

When revisited, retain the highest achieved level and append the new date/context.

## Revisit triggers

Valid triggers include:

- journal publication or major revision;
- code, dataset, proof artifact, or benchmark release;
- replication, contradiction, correction, or retraction;
- extension to materially larger scale or new hardware;
- new theorem or resource analysis;
- integration into a broader toolchain;
- newly recognized connection that materially changes user relevance.

Invalid triggers include:

- reposting the same abstract;
- a press article with no new technical content;
- minor wording or metadata changes;
- renewed social-media attention alone.

## Deduplication logic

Before selecting a paper:

1. canonicalize its ID;
2. look up the ledger;
3. if status is `covered`, require a material revisit trigger;
4. if status is `rejected`, inspect only when the rejection reason may have changed;
5. if status is `candidate` or `deferred`, reconsider normally;
6. merge code/journal/press links into the existing record.

For a revisit, label the item **[Update]** and state exactly what changed.

## Updating procedure

After finalizing a brief:

- add or update only selected items;
- append the current date to `covered_on`;
- append a precise context, such as `weekday_brief_2026-06-18`;
- preserve prior dates and contexts;
- record tags and a one-line selection reason;
- add plausible future revisit triggers;
- never overwrite a correction, retraction, or prior note silently.

Use `scripts/ledger_tool.py` to validate, look up, or upsert records.

The validator requires canonical unique IDs, all required fields, absolute HTTP(S) canonical URLs, valid and ordered dates, unique nonempty list entries, and coverage context plus selection reason for `covered` records. It rejects an update dated earlier than the existing `last_seen_on`.

## When persistence is unavailable

Return a machine-readable ledger delta, for example:

```json
{"paper_id":"arxiv:YYMM.NNNNN","action":"upsert","covered_on":"YYYY-MM-DD","coverage_level":"brief","tags":["Fresh"],"context":"weekday_brief_YYYY-MM-DD"}
```

Do not claim the ledger was updated when it was not.
