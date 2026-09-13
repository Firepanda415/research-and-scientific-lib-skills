#!/usr/bin/env python3
"""Initialize, validate, inspect, and update the briefing coverage ledger.

Runtime state lives outside the installed skill by default. Uses only the Python
standard library.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import sys
import tempfile
from datetime import date, datetime, timezone
from pathlib import Path
from typing import Any
from urllib.parse import urlparse

PACKAGE_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_SEED = PACKAGE_ROOT / "data" / "briefing-history.seed.jsonl"
ALLOWED_STATUS = {"candidate", "deferred", "covered", "rejected", "superseded", "retracted"}
LEVEL_ORDER = {"mention": 0, "brief": 1, "detailed": 2, "deep-dive": 3}
REQUIRED_FIELDS = {
    "schema_version",
    "paper_id",
    "title",
    "canonical_url",
    "first_public_date",
    "first_seen_on",
    "last_seen_on",
    "status",
    "covered_on",
    "coverage_level",
    "coverage_contexts",
    "tags",
    "selection_reason",
    "revisit_triggers",
    "notes",
}
LIST_FIELDS = ("covered_on", "coverage_contexts", "tags", "revisit_triggers")


def default_ledger_path() -> Path:
    override = os.environ.get("QUANTUM_RESEARCH_RADAR_LEDGER")
    if override:
        return Path(override).expanduser()
    state_root = Path(os.environ.get("XDG_STATE_HOME", Path.home() / ".local" / "state")).expanduser()
    return state_root / "quantum-research-radar" / "briefing-history.jsonl"


def unique(values: list[str]) -> list[str]:
    seen: set[str] = set()
    result: list[str] = []
    for raw in values:
        value = raw.strip()
        if value and value not in seen:
            seen.add(value)
            result.append(value)
    return result


def parse_iso_date(value: Any, field: str, allow_empty: bool = False) -> date | None:
    if allow_empty and value == "":
        return None
    if not isinstance(value, str):
        raise ValueError(f"{field} must be a YYYY-MM-DD string")
    try:
        return date.fromisoformat(value)
    except ValueError as exc:
        raise ValueError(f"{field} must be YYYY-MM-DD, got {value!r}") from exc


def canonicalize_paper_id(value: str) -> str:
    raw = value.strip()
    arxiv = re.search(r"(?:arxiv:|arxiv\.org/(?:abs|pdf)/)?(\d{4}\.\d{4,5})(?:v\d+)?", raw, re.I)
    if arxiv:
        return f"arxiv:{arxiv.group(1)}"
    if raw.lower().startswith("doi:"):
        return "doi:" + raw[4:].strip().lower()
    if "doi.org/" in raw.lower():
        return "doi:" + re.split(r"doi\.org/", raw, flags=re.I, maxsplit=1)[1].strip().lower()
    return raw.lower()


def validate_string_list(value: Any, field: str, errors: list[str]) -> list[str]:
    if not isinstance(value, list):
        errors.append(f"{field} must be a list")
        return []
    if any(not isinstance(item, str) or not item.strip() for item in value):
        errors.append(f"{field} items must be nonempty strings")
        return []
    if len(value) != len(set(value)):
        errors.append(f"{field} must not contain duplicates")
    return value


def validate_record(record: Any) -> list[str]:
    errors: list[str] = []
    if not isinstance(record, dict):
        return ["record must be a JSON object"]
    missing = sorted(REQUIRED_FIELDS - set(record))
    if missing:
        errors.append("missing fields: " + ", ".join(missing))
    if record.get("schema_version") != "1.0":
        errors.append("schema_version must be '1.0'")

    paper_id = record.get("paper_id")
    if not isinstance(paper_id, str) or not paper_id.strip():
        errors.append("paper_id must be a nonempty string")
    elif canonicalize_paper_id(paper_id) != paper_id:
        errors.append(f"paper_id is not canonical: {paper_id!r}")

    title = record.get("title")
    if not isinstance(title, str) or not title.strip():
        errors.append("title must be a nonempty string")

    canonical_url = record.get("canonical_url")
    if not isinstance(canonical_url, str) or not canonical_url.strip():
        errors.append("canonical_url must be a nonempty string")
    else:
        parsed = urlparse(canonical_url)
        if parsed.scheme not in {"http", "https"} or not parsed.netloc:
            errors.append("canonical_url must be an absolute HTTP(S) URL")

    status = record.get("status")
    if status not in ALLOWED_STATUS:
        errors.append(f"invalid status: {status!r}")
    level = record.get("coverage_level")
    if level not in LEVEL_ORDER:
        errors.append(f"invalid coverage_level: {level!r}")

    dates: dict[str, date | None] = {}
    for field, allow_empty in (("first_public_date", True), ("first_seen_on", False), ("last_seen_on", False)):
        try:
            dates[field] = parse_iso_date(record.get(field), field, allow_empty)
        except ValueError as exc:
            errors.append(str(exc))
            dates[field] = None

    first_seen = dates.get("first_seen_on")
    last_seen = dates.get("last_seen_on")
    first_public = dates.get("first_public_date")
    if first_seen and last_seen and first_seen > last_seen:
        errors.append("first_seen_on must not be after last_seen_on")
    if first_public and last_seen and first_public > last_seen:
        errors.append("first_public_date must not be after last_seen_on")

    lists = {field: validate_string_list(record.get(field), field, errors) for field in LIST_FIELDS}
    covered_dates: list[date] = []
    for index, value in enumerate(lists["covered_on"]):
        try:
            covered_dates.append(parse_iso_date(value, f"covered_on[{index}]") or date.min)
        except ValueError as exc:
            errors.append(str(exc))
    if lists["covered_on"] != sorted(lists["covered_on"]):
        errors.append("covered_on must be sorted chronologically")
    if first_seen and any(item < first_seen for item in covered_dates):
        errors.append("covered_on dates must not precede first_seen_on")
    if last_seen and any(item > last_seen for item in covered_dates):
        errors.append("covered_on dates must not exceed last_seen_on")

    selection_reason = record.get("selection_reason")
    notes = record.get("notes")
    if not isinstance(selection_reason, str):
        errors.append("selection_reason must be a string")
    if not isinstance(notes, str):
        errors.append("notes must be a string")
    if status == "covered":
        if not lists["covered_on"]:
            errors.append("covered status requires at least one covered_on date")
        if not lists["coverage_contexts"]:
            errors.append("covered status requires at least one coverage_context")
        if not isinstance(selection_reason, str) or not selection_reason.strip():
            errors.append("covered status requires a nonempty selection_reason")
    return errors


def read_ledger(path: Path, allow_missing: bool = False) -> dict[str, dict[str, Any]]:
    records: dict[str, dict[str, Any]] = {}
    if not path.exists():
        if allow_missing:
            return records
        raise ValueError(f"ledger does not exist: {path}; run the init command first")
    with path.open("r", encoding="utf-8") as handle:
        for line_no, line in enumerate(handle, 1):
            if not line.strip():
                continue
            try:
                record = json.loads(line)
            except json.JSONDecodeError as exc:
                raise ValueError(f"invalid JSON on line {line_no}: {exc}") from exc
            if not isinstance(record, dict):
                raise ValueError(f"line {line_no} must contain a JSON object")
            raw_id = record.get("paper_id", "")
            paper_id = canonicalize_paper_id(raw_id) if isinstance(raw_id, str) else ""
            if not paper_id:
                raise ValueError(f"missing paper_id on line {line_no}")
            if paper_id in records:
                raise ValueError(f"duplicate canonical paper_id {paper_id!r} on line {line_no}")
            records[paper_id] = record
    return records


def validate_records(records: dict[str, dict[str, Any]]) -> list[str]:
    failures: list[str] = []
    for paper_id, record in records.items():
        for error in validate_record(record):
            failures.append(f"{paper_id}: {error}")
    return failures


def write_ledger(
    path: Path,
    records: dict[str, dict[str, Any]],
    make_backup: bool = True,
    backup_dir: Path | None = None,
) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if make_backup and path.exists():
        target_dir = backup_dir or path.parent / ".backups"
        target_dir.mkdir(parents=True, exist_ok=True)
        stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
        shutil.copy2(path, target_dir / f"{path.name}.{stamp}.bak")
    temp_name: str | None = None
    try:
        with tempfile.NamedTemporaryFile(
            "w", encoding="utf-8", dir=path.parent, prefix=f".{path.name}.", suffix=".tmp", delete=False
        ) as handle:
            temp_name = handle.name
            for paper_id in sorted(records):
                handle.write(json.dumps(records[paper_id], ensure_ascii=False, separators=(",", ":")) + "\n")
        Path(temp_name).replace(path)
    finally:
        if temp_name:
            Path(temp_name).unlink(missing_ok=True)


def ledger_arg(args: argparse.Namespace) -> Path:
    return Path(args.ledger).expanduser()


def cmd_path(_args: argparse.Namespace) -> int:
    print(default_ledger_path())
    return 0


def cmd_init(args: argparse.Namespace) -> int:
    path = ledger_arg(args)
    if path.exists() and not args.force:
        raise ValueError(f"ledger already exists: {path}; use --force only when replacement is intended")
    if args.empty:
        records: dict[str, dict[str, Any]] = {}
    else:
        seed = Path(args.seed or DEFAULT_SEED).expanduser()
        records = read_ledger(seed)
        failures = validate_records(records)
        if failures:
            raise ValueError("invalid seed: " + "; ".join(failures))
    write_ledger(path, records, make_backup=path.exists() and not args.no_backup)
    print(f"OK: initialized {len(records)} record(s) in {path}")
    return 0


def cmd_validate(args: argparse.Namespace) -> int:
    path = ledger_arg(args)
    records = read_ledger(path)
    failures = validate_records(records)
    if failures:
        for failure in failures:
            print(f"ERROR: {failure}", file=sys.stderr)
        print(f"FAILED: {len(failures)} validation error(s)", file=sys.stderr)
        return 1
    print(f"OK: {len(records)} record(s) in {path}")
    return 0


def cmd_lookup(args: argparse.Namespace) -> int:
    records = read_ledger(ledger_arg(args))
    paper_id = canonicalize_paper_id(args.paper_id)
    record = records.get(paper_id)
    if record is None:
        print(f"NOT FOUND: {paper_id}")
        return 2
    print(json.dumps(record, ensure_ascii=False, indent=2))
    return 0


def cmd_upsert(args: argparse.Namespace) -> int:
    path = ledger_arg(args)
    records = read_ledger(path, allow_missing=True)
    paper_id = canonicalize_paper_id(args.paper_id)
    if not paper_id:
        raise ValueError("paper_id must be nonempty")
    run_date = parse_iso_date(args.date, "date")
    if args.first_public_date:
        parse_iso_date(args.first_public_date, "first_public_date")
    existing = records.get(paper_id)
    if existing is None:
        if not args.title or not args.canonical_url:
            raise ValueError("new records require --title and --canonical-url")
        record: dict[str, Any] = {
            "schema_version": "1.0",
            "paper_id": paper_id,
            "title": args.title.strip(),
            "canonical_url": args.canonical_url.strip(),
            "first_public_date": args.first_public_date or "",
            "first_seen_on": args.date,
            "last_seen_on": args.date,
            "status": args.status,
            "covered_on": [],
            "coverage_level": args.coverage_level,
            "coverage_contexts": [],
            "tags": [],
            "selection_reason": (args.selection_reason or "").strip(),
            "revisit_triggers": [],
            "notes": (args.notes or "").strip(),
        }
    else:
        record = dict(existing)
        previous_last_seen = parse_iso_date(record.get("last_seen_on"), "last_seen_on")
        if run_date and previous_last_seen and run_date < previous_last_seen:
            raise ValueError("date must not be earlier than the existing last_seen_on")
        record["paper_id"] = paper_id
        record["last_seen_on"] = args.date
        record["status"] = args.status
        if args.title:
            record["title"] = args.title.strip()
        if args.canonical_url:
            record["canonical_url"] = args.canonical_url.strip()
        if args.first_public_date:
            record["first_public_date"] = args.first_public_date
        if LEVEL_ORDER[args.coverage_level] > LEVEL_ORDER.get(record.get("coverage_level", "mention"), 0):
            record["coverage_level"] = args.coverage_level
        if args.selection_reason:
            record["selection_reason"] = args.selection_reason.strip()
        if args.notes:
            previous = str(record.get("notes", "")).strip()
            record["notes"] = (previous + "\n" + args.notes.strip()).strip() if previous else args.notes.strip()

    if args.status == "covered":
        record["covered_on"] = sorted(unique([*record.get("covered_on", []), args.date]))
    record["coverage_contexts"] = unique([*record.get("coverage_contexts", []), *args.context])
    record["tags"] = unique([*record.get("tags", []), *args.tag])
    record["revisit_triggers"] = unique([*record.get("revisit_triggers", []), *args.revisit_trigger])
    errors = validate_record(record)
    if errors:
        raise ValueError("; ".join(errors))
    records[paper_id] = record
    backup_dir = Path(args.backup_dir).expanduser() if args.backup_dir else None
    write_ledger(path, records, make_backup=not args.no_backup, backup_dir=backup_dir)
    print(json.dumps(record, ensure_ascii=False, indent=2))
    return 0


def add_ledger_option(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--ledger", default=str(default_ledger_path()), help="runtime ledger path")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)

    path_cmd = sub.add_parser("path", help="print the default runtime ledger path")
    path_cmd.set_defaults(func=cmd_path)

    init = sub.add_parser("init", help="initialize a runtime ledger from the packaged seed")
    add_ledger_option(init)
    init.add_argument("--seed")
    init.add_argument("--empty", action="store_true")
    init.add_argument("--force", action="store_true")
    init.add_argument("--no-backup", action="store_true")
    init.set_defaults(func=cmd_init)

    validate = sub.add_parser("validate", help="validate a ledger")
    add_ledger_option(validate)
    validate.set_defaults(func=cmd_validate)

    lookup = sub.add_parser("lookup", help="look up a canonical paper ID")
    add_ledger_option(lookup)
    lookup.add_argument("--paper-id", required=True)
    lookup.set_defaults(func=cmd_lookup)

    upsert = sub.add_parser("upsert", help="insert or update a ledger record")
    add_ledger_option(upsert)
    upsert.add_argument("--paper-id", required=True)
    upsert.add_argument("--title")
    upsert.add_argument("--canonical-url")
    upsert.add_argument("--first-public-date")
    upsert.add_argument("--date", required=True)
    upsert.add_argument("--status", default="covered", choices=sorted(ALLOWED_STATUS))
    upsert.add_argument("--coverage-level", default="brief", choices=sorted(LEVEL_ORDER, key=LEVEL_ORDER.get))
    upsert.add_argument("--context", action="append", default=[])
    upsert.add_argument("--tag", action="append", default=[])
    upsert.add_argument("--revisit-trigger", action="append", default=[])
    upsert.add_argument("--selection-reason")
    upsert.add_argument("--notes")
    upsert.add_argument("--backup-dir")
    upsert.add_argument("--no-backup", action="store_true")
    upsert.set_defaults(func=cmd_upsert)
    return parser


def main() -> int:
    args = build_parser().parse_args()
    if getattr(args, "empty", False) and getattr(args, "seed", None):
        print("ERROR: --empty and --seed are mutually exclusive", file=sys.stderr)
        return 1
    try:
        return int(args.func(args))
    except (OSError, ValueError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
