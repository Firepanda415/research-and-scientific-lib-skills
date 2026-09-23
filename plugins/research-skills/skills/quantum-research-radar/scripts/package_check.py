#!/usr/bin/env python3
"""Run package and ledger lifecycle checks without mutating the skill."""

from __future__ import annotations

import importlib.util
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path
from types import ModuleType

REQUIRED_PATHS = {
    "SKILL.md",
    "agents/openai.yaml",
    "data/briefing-history.seed.jsonl",
    "data/briefing-history.schema.json",
    "references/coverage-ledger-schema.md",
    "references/output-template.md",
    "references/selection-policy.md",
    "references/source-and-query-map.md",
    "references/user-research-profile.md",
    "prompts/manual-run-prompt.md",
    "prompts/quantum-ai-scan-prompt.md",
    "prompts/weekday-schedule-prompt.md",
    "prompts/weekly-recovery-prompt.md",
    "scripts/ledger_tool.py",
    "scripts/package_check.py",
}


def fail(message: str) -> None:
    raise RuntimeError(message)


def ignored(rel_path: Path) -> bool:
    return any(part.startswith(".") for part in rel_path.parts) or any(
        part == "__pycache__" for part in rel_path.parts
    ) or rel_path.name.endswith((".bak", ".tmp"))


def package_files(root: Path) -> set[str]:
    return {
        str(path.relative_to(root))
        for path in root.rglob("*")
        if path.is_file() and not ignored(path.relative_to(root))
    }


def run_checked(command: list[str]) -> subprocess.CompletedProcess[str]:
    result = subprocess.run(command, text=True, capture_output=True, check=False)
    if result.returncode:
        fail(result.stderr.strip() or result.stdout.strip() or f"command failed: {command}")
    return result


CANONICAL_ID_CASES = {
    "doi:10.1145/3597503.3639187": "doi:10.1145/3597503.3639187",
    "https://doi.org/10.1109/TQE.2024.3364512": "doi:10.1109/tqe.2024.3364512",
    "10.1109/QCE57702.2023.00012": "doi:10.1109/qce57702.2023.00012",
    "doi:10.1016/j.cpc.2024.109123": "doi:10.1016/j.cpc.2024.109123",
    "doi:10.48550/arXiv.2401.12345": "arxiv:2401.12345",
    "https://doi.org/10.48550/arXiv.2401.12345": "arxiv:2401.12345",
    "arXiv:2401.12345v3": "arxiv:2401.12345",
    "https://arxiv.org/abs/2401.12345v2": "arxiv:2401.12345",
    "arXiv:2401.12345 [quant-ph]": "arxiv:2401.12345",
    "https://arxiv.org/abs/2401.12345?context=quant-ph": "arxiv:2401.12345",
    "https://arxiv.org/html/2401.12345v2": "arxiv:2401.12345",
    "2607.00001": "arxiv:2607.00001",
    "title:Foo  Bar": "title:foo bar",
    "github.com/Example/Tool@v1.2": "github.com/example/tool@v1.2",
}


def load_ledger_module(ledger_tool: Path) -> ModuleType:
    spec = importlib.util.spec_from_file_location("radar_ledger_tool", ledger_tool)
    if spec is None or spec.loader is None:
        fail(f"cannot load {ledger_tool}")
    module = importlib.util.module_from_spec(spec)
    # Importing must not write a bytecode cache into the installed skill.
    previous = sys.dont_write_bytecode
    sys.dont_write_bytecode = True
    try:
        spec.loader.exec_module(module)
    finally:
        sys.dont_write_bytecode = previous
    return module


def check_canonicalization(ledger_tool: Path) -> None:
    canonicalize = load_ledger_module(ledger_tool).canonicalize_paper_id
    for raw, expected in CANONICAL_ID_CASES.items():
        once = canonicalize(raw)
        if once != expected:
            fail(f"canonicalize_paper_id({raw!r}) returned {once!r}, expected {expected!r}")
        if canonicalize(once) != once:
            fail(f"canonicalize_paper_id is not idempotent for {raw!r}")


def ledger_command(ledger_tool: Path, *args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, str(ledger_tool), *args], text=True, capture_output=True, check=False
    )


def lookup_record(ledger_tool: Path, ledger: Path, paper_id: str) -> dict:
    result = ledger_command(ledger_tool, "lookup", "--ledger", str(ledger), "--paper-id", paper_id)
    if result.returncode:
        fail(f"lookup of {paper_id} failed: {result.stdout.strip()} {result.stderr.strip()}")
    return json.loads(result.stdout)


def check_upsert_semantics(ledger_tool: Path, ledger: Path) -> None:
    common = ["upsert", "--ledger", str(ledger), "--no-backup"]

    run_checked(
        [
            sys.executable, str(ledger_tool), *common,
            "--paper-id", "doi:10.1109/TQE.2024.3364512",
            "--title", "DOI Collision Probe",
            "--canonical-url", "https://doi.org/10.1109/TQE.2024.3364512",
            "--date", "2026-09-01",
            "--status", "candidate",
        ]
    )
    other = ledger_command(
        ledger_tool, "lookup", "--ledger", str(ledger), "--paper-id", "doi:10.1109/TQE.2024.3364599"
    )
    if other.returncode != 2 or "NOT FOUND" not in other.stdout:
        fail("a different DOI with the same journal and year must not match an existing record")

    run_checked(
        [
            sys.executable, str(ledger_tool), *common,
            "--paper-id", "arxiv:2601.00002",
            "--title", "Status Preservation Probe",
            "--canonical-url", "https://arxiv.org/abs/2601.00002",
            "--date", "2026-09-01",
            "--status", "rejected",
            "--coverage-level", "mention",
            "--context", "scan",
            "--selection-reason", "toy model",
        ]
    )
    run_checked(
        [
            sys.executable, str(ledger_tool), *common,
            "--paper-id", "arxiv:2601.00002",
            "--date", "2026-09-05",
            "--notes", "code released",
        ]
    )
    record = lookup_record(ledger_tool, ledger, "2601.00002")
    observed = (record["status"], record["covered_on"], record["coverage_level"], record["notes"])
    if observed != ("rejected", [], "mention", "code released"):
        fail(f"a notes-only upsert changed a rejected record: {observed}")

    missing_status = ledger_command(
        ledger_tool, *common,
        "--paper-id", "arxiv:2601.00003",
        "--title", "Missing Status Probe",
        "--canonical-url", "https://arxiv.org/abs/2601.00003",
        "--date", "2026-09-05",
    )
    if missing_status.returncode != 1 or "new records require --status" not in missing_status.stderr:
        fail("a new record without --status must be rejected")


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    before = package_files(root)
    missing = sorted(REQUIRED_PATHS - before)
    if missing:
        fail(f"missing required package paths: {missing}")

    skill = (root / "SKILL.md").read_text(encoding="utf-8")
    if not skill.startswith("---\n"):
        fail("SKILL.md must start with YAML frontmatter")
    frontmatter = skill.split("---", 2)[1]
    if not re.search(r"^name:\s*quantum-research-radar\s*$", frontmatter, re.M):
        fail("SKILL.md frontmatter has an invalid name")
    if not re.search(r"^description:\s*.+$", frontmatter, re.M):
        fail("SKILL.md frontmatter is missing a description")

    metadata = (root / "agents" / "openai.yaml").read_text(encoding="utf-8")
    for key in ("display_name", "short_description", "default_prompt"):
        if not re.search(rf"^\s+{key}:\s*\"[^\"]+\"\s*$", metadata, re.M):
            fail(f"agents/openai.yaml is missing quoted {key}")
    if not re.search(r"^\s+default_prompt:\s*\"[^\"]*\$quantum-research-radar", metadata, re.M):
        fail("default_prompt must mention $quantum-research-radar")

    linked_paths = re.findall(r"`((?:references|data|examples|prompts|scripts)/[^`]+)`", skill)
    for rel in sorted(set(linked_paths)):
        if not (root / rel).exists():
            fail(f"SKILL.md references missing path: {rel}")

    for rel in sorted(before):
        path = root / rel
        if path.suffix in {".md", ".py", ".json", ".jsonl", ".yaml"}:
            text = path.read_text(encoding="utf-8")
            if text.startswith("\\\n"):
                fail(f"stray leading backslash in {rel}")
        if path.suffix == ".md" and path.read_text(encoding="utf-8").count("```") % 2:
            fail(f"unbalanced fenced code block in {rel}")
        if path.suffix == ".json":
            json.loads(path.read_text(encoding="utf-8"))

    ledger_tool = root / "scripts" / "ledger_tool.py"
    seed = root / "data" / "briefing-history.seed.jsonl"
    run_checked([sys.executable, str(ledger_tool), "validate", "--ledger", str(seed)])

    with tempfile.TemporaryDirectory() as temp:
        for name, options in (("default", []), ("empty", ["--empty"])):
            fresh = Path(temp) / name / "briefing-history.jsonl"
            run_checked([sys.executable, str(ledger_tool), "init", "--ledger", str(fresh), *options])
            if fresh.read_bytes() != b"":
                fail(f"{name} initialization must create an empty coverage history")

        runtime = Path(temp) / "state" / "briefing-history.jsonl"
        run_checked(
            [sys.executable, str(ledger_tool), "init", "--ledger", str(runtime), "--seed", str(seed)]
        )
        expected = [json.loads(line) for line in seed.read_text(encoding="utf-8").splitlines() if line.strip()]
        imported = [json.loads(line) for line in runtime.read_text(encoding="utf-8").splitlines() if line.strip()]
        if {record["paper_id"]: record for record in imported} != {record["paper_id"]: record for record in expected}:
            fail("explicit seed import changed the supplied coverage records")
        before_reinit = runtime.read_bytes()
        rejected = subprocess.run(
            [sys.executable, str(ledger_tool), "init", "--ledger", str(runtime)],
            text=True, capture_output=True, check=False,
        )
        if rejected.returncode != 1 or "ledger already exists" not in rejected.stderr:
            fail("initialization must reject an existing ledger without --force")
        if runtime.read_bytes() != before_reinit:
            fail("rejected initialization changed existing coverage history")
        run_checked(
            [
                sys.executable,
                str(ledger_tool),
                "upsert",
                "--ledger",
                str(runtime),
                "--paper-id",
                "arxiv:2607.00001v2",
                "--title",
                "Lifecycle Test Paper",
                "--canonical-url",
                "https://arxiv.org/abs/2607.00001",
                "--first-public-date",
                "2026-07-01",
                "--date",
                "2026-07-09",
                "--status",
                "covered",
                "--coverage-level",
                "brief",
                "--context",
                "package_lifecycle_test",
                "--selection-reason",
                "Exercise canonicalization, validation, update, and backup behavior.",
            ]
        )
        run_checked([sys.executable, str(ledger_tool), "validate", "--ledger", str(runtime)])
        run_checked(
            [sys.executable, str(ledger_tool), "lookup", "--ledger", str(runtime), "--paper-id", "2607.00001"]
        )
        backups = list((runtime.parent / ".backups").glob("*.bak"))
        if len(backups) != 1:
            fail(f"lifecycle expected one external backup, found {len(backups)}")
        run_checked([sys.executable, str(ledger_tool), "init", "--ledger", str(runtime), "--force"])
        if runtime.read_bytes() != b"":
            fail("forced default initialization must replace the ledger with empty history")

        check_canonicalization(ledger_tool)
        check_upsert_semantics(ledger_tool, Path(temp) / "semantics" / "briefing-history.jsonl")

    after = package_files(root)
    if before != after:
        fail(f"package check mutated installed files: added={sorted(after-before)}, removed={sorted(before-after)}")
    print(f"OK: package integrity and ledger lifecycle passed ({len(after)} package files)")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(1)
