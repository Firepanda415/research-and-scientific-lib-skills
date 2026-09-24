#!/usr/bin/env python3
"""Check mechanical hygiene of an implementation-job prompt.

This tool does not certify authority, scope, scientific correctness, or test
quality. Those require the skill's human pre-dispatch checklist.
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class Finding:
    level: str
    message: str


FENCE_RE = re.compile(r"^\s*(`{3,}|~{3,})")
PLACEHOLDER_RE = re.compile(r"\{\{[A-Z0-9_]+\}\}")
ANGLE_PLACEHOLDER_RE = re.compile(r"(?<![\w:])<(?:your-)?[A-Za-z][A-Za-z0-9_-]*>")
INLINE_CODE_RE = re.compile(r"(?<!`)`([^`\n]+)`(?!`)")
BARE_PYTHON_RE = re.compile(
    r"(?:^|[;&|]\s*)\s*(?:\$\s+)?python3?\s+\S"
)
MASKED_EXIT_RE = re.compile(
    r"(;|\|\|)\s*echo\b[^;\n]*\$\?\s*(?:#.*)?$"
)
LABELED_STATUS_ECHO_RE = re.compile(
    r"\becho\s+[\"']?[A-Za-z_][A-Za-z0-9_]*=\$\?"
)
ECHO_STATUS_LINE_RE = re.compile(r"^\s*echo\b[^;\n]*\$\?\s*(?:#.*)?$")
STATUS_CAPTURE_RE = re.compile(r"\b[A-Za-z_][A-Za-z0-9_]*=\$\?(?=\s|;|$)")
INLINE_COMMAND_PREFIX_RE = re.compile(
    r"\b(?:run|execute|use|invoke|call)\s*$",
    re.IGNORECASE,
)
NEGATED_INLINE_COMMAND_RE = re.compile(
    r"\b(?:never|do not|must not|avoid)\s+"
    r"(?:run|execute|use|invoke|call)\s*$",
    re.IGNORECASE,
)
DATE_STAMP_RE = re.compile(r"\b20\d{2}-\d{2}-\d{2}\b")
AGENT_NAME_RE = re.compile(r"\b(?:Claude|Codex|Anthropic|ChatGPT|Copilot|GPT-\d)\b")
SHELL_FENCE_LANGUAGES = {"", "bash", "console", "sh", "shell", "zsh"}


def _outside_fences(
    text: str,
    *,
    include_blockquotes: bool = False,
) -> tuple[str, bool]:
    """Return prose outside Markdown fences and whether fences are balanced."""
    output: list[str] = []
    marker: str | None = None
    for line in text.splitlines():
        match = FENCE_RE.match(line)
        if match:
            candidate = match.group(1)
            if marker is None:
                marker = candidate
            elif candidate[0] == marker[0] and len(candidate) >= len(marker):
                marker = None
            output.append("")
            continue
        if marker is None and (
            include_blockquotes or not line.lstrip().startswith(">")
        ):
            output.append(line)
        else:
            output.append("")
    return "\n".join(output), marker is None


def _fenced_lines(
    text: str,
    *,
    shell_only: bool = False,
) -> list[tuple[int, str]]:
    """Return (line_number, line) pairs inside Markdown code fences."""
    out: list[tuple[int, str]] = []
    marker: str | None = None
    include = False
    for number, line in enumerate(text.splitlines(), start=1):
        match = FENCE_RE.match(line)
        if match:
            candidate = match.group(1)
            if marker is None:
                marker = candidate
                info = line[match.end() :].strip().split(maxsplit=1)
                language = info[0].casefold() if info else ""
                include = not shell_only or language in SHELL_FENCE_LANGUAGES
            elif candidate[0] == marker[0] and len(candidate) >= len(marker):
                marker = None
                include = False
            continue
        if marker is not None and include:
            out.append((number, line))
    return out


def _inline_code_spans(prose: str) -> list[tuple[int, str, str]]:
    """Return (line_number, content, prefix) for inline code outside fences."""
    out: list[tuple[int, str, str]] = []
    for number, line in enumerate(prose.splitlines(), start=1):
        out.extend(
            (number, match.group(1), line[: match.start()])
            for match in INLINE_CODE_RE.finditer(line)
        )
    return out


def _headings(prose: str, level: int) -> list[str]:
    prefix = "#" * level
    pattern = rf"^{re.escape(prefix)}(?!#)\s+(.+?)\s*$"
    return [
        match.group(1).strip()
        for match in re.finditer(pattern, prose, flags=re.MULTILINE)
    ]


def _line_number(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def lint_prompt(
    text: str,
    *,
    kind: str,
    handoff_token: str | None = None,
    handoff_instruction_token: str | None = None,
) -> list[Finding]:
    findings: list[Finding] = []
    prose, fences_balanced = _outside_fences(text)
    quoted_prose, _ = _outside_fences(text, include_blockquotes=True)

    if not text.strip():
        return [Finding("ERROR", "prompt is empty")]
    if not fences_balanced:
        findings.append(Finding("ERROR", "unbalanced Markdown code fence"))

    placeholders = sorted(set(PLACEHOLDER_RE.findall(text)))
    if placeholders:
        sample = ", ".join(placeholders[:3])
        suffix = " ..." if len(placeholders) > 3 else ""
        findings.append(
            Finding("ERROR", f"unresolved template placeholders: {sample}{suffix}")
        )

    if re.search(r"(?im)^\s*<\s*codex_delegation\b", prose):
        findings.append(
            Finding("ERROR", "nested codex_delegation wrapper; dispatch plain Markdown")
        )

    h1 = _headings(prose, 1)
    if len(h1) != 1:
        findings.append(Finding("WARNING", f"expected one H1 title; found {len(h1)}"))

    h2 = _headings(prose, 2)
    normalized = [re.sub(r"\s+", " ", item).strip().casefold() for item in h2]
    duplicates = sorted({item for item in normalized if normalized.count(item) > 1})
    if duplicates:
        findings.append(
            Finding("ERROR", f"duplicate H2 headings: {', '.join(duplicates)}")
        )

    if kind == "correction" and not re.search(
        r"\b(supersedes|replaces)\b", quoted_prose, flags=re.IGNORECASE
    ):
        findings.append(
            Finding("ERROR", "correction must identify what it supersedes or replaces")
        )

    if handoff_token is not None:
        token = handoff_token.strip()
        if not token:
            findings.append(Finding("ERROR", "handoff token cannot be empty"))
        else:
            occurrences = sum(line.strip() == token for line in text.splitlines())
            if occurrences != 1:
                findings.append(
                    Finding(
                        "ERROR",
                        f"handoff token must occur exactly once; found {occurrences}",
                    )
                )
            final_line = next(
                (line.strip() for line in reversed(text.splitlines()) if line.strip()),
                "",
            )
            if final_line != token:
                findings.append(
                    Finding("ERROR", "handoff token must be the final nonblank line")
                )

    if handoff_instruction_token is not None:
        token = handoff_instruction_token.strip()
        if not token:
            findings.append(Finding("ERROR", "handoff instruction token cannot be empty"))
        else:
            token_pattern = re.compile(
                rf"(?<![A-Za-z0-9_]){re.escape(token)}(?![A-Za-z0-9_])"
            )
            occurrences = len(token_pattern.findall(text))
            if occurrences != 1:
                findings.append(
                    Finding(
                        "ERROR",
                        "handoff instruction token must occur exactly once; "
                        f"found {occurrences}",
                    )
                )
            final_line = r"(?:literal\s+)?final(?:\s+nonblank)?\s+line"
            instruction_pattern = re.compile(
                rf"(?:{final_line}[\s\S]{{0,160}}{token_pattern.pattern}|"
                rf"{token_pattern.pattern}[\s\S]{{0,160}}{final_line})",
                flags=re.IGNORECASE,
            )
            negated_final_line = re.compile(
                rf"(?:\b(?:must|shall|should|does|do)\s+not\s+"
                rf"(?:be\s+)?(?:the\s+)?{final_line}|"
                rf"{final_line}\s+\b(?:must|shall|should|is|does)\s+not\b)",
                flags=re.IGNORECASE,
            )
            negated_reverse_instruction = re.compile(
                rf"\b(?:do|must|shall|should)\s+not\s+"
                rf"(?:use|make|set|treat|place|write|put)\s+"
                rf"{token_pattern.pattern}[\s\S]{{0,120}}{final_line}",
                flags=re.IGNORECASE,
            )
            if (
                not instruction_pattern.search(prose)
                or negated_final_line.search(prose)
                or negated_reverse_instruction.search(prose)
            ):
                findings.append(
                    Finding(
                        "ERROR",
                        "prompt must instruct that the handoff token is the literal "
                        "final line",
                    )
                )

    fenced_lines = _fenced_lines(text, shell_only=True)
    for index, (number, line) in enumerate(fenced_lines):
        placeholders = ANGLE_PLACEHOLDER_RE.findall(line)
        if placeholders:
            findings.append(
                Finding(
                    "ERROR",
                    f"line {number}: unresolved angle-bracket command placeholder: "
                    f"{', '.join(sorted(set(placeholders)))}",
                )
            )
        masked = MASKED_EXIT_RE.search(line)
        if masked:
            if masked.group(1) == "||":
                findings.append(
                    Finding(
                        "ERROR",
                        f"line {number}: a failure-only `|| echo ...$?` fallback "
                        "prints nothing on success and masks the exit status; "
                        "print a labeled status unconditionally",
                    )
                )
            elif not LABELED_STATUS_ECHO_RE.search(line):
                findings.append(
                    Finding(
                        "WARNING",
                        f"line {number}: unlabeled `echo $?`; label the status "
                        "echo (`; echo EXIT=$?`) so the transcript is unambiguous",
                    )
                )

        if ECHO_STATUS_LINE_RE.match(line) and index:
            previous_number, previous_line = fenced_lines[index - 1]
            if (
                previous_number == number - 1
                and not STATUS_CAPTURE_RE.search(previous_line)
                and not LABELED_STATUS_ECHO_RE.search(line)
            ):
                findings.append(
                    Finding(
                        "WARNING",
                        f"line {number}: unlabeled trailing `echo $?`; label it "
                        "(`echo EXIT=$?`) so the transcript stays unambiguous",
                    )
                )

    inline_spans = _inline_code_spans(prose)
    command_fragments = fenced_lines + [
        (number, fragment) for number, fragment, _prefix in inline_spans
    ]
    for number, fragment in command_fragments:
        if BARE_PYTHON_RE.search(fragment):
            findings.append(
                Finding(
                    "WARNING",
                    f"line {number}: bare `python` command; pin the project "
                    "interpreter in every command, including baseline steps",
                )
            )

    for number, fragment, prefix in inline_spans:
        masked_inline = MASKED_EXIT_RE.search(fragment)
        if (
            masked_inline
            and masked_inline.group(1) == "||"
            and INLINE_COMMAND_PREFIX_RE.search(prefix)
            and not NEGATED_INLINE_COMMAND_RE.search(prefix)
        ):
            findings.append(
                Finding(
                    "ERROR",
                    f"line {number}: inline command uses a failure-only "
                    "`|| echo ...$?` form that masks exit status",
                )
            )

    series_marker = re.search(
        r"\b(?:job[- ]series|serial jobs?|(?-i:Change Set[ \t]+(?:[A-Z]|\d+)))\b",
        prose,
        flags=re.IGNORECASE,
    )
    if series_marker:
        if not re.search(
            r"\bsource (?:bundle|plan)\b[\s\S]{0,240}"
            r"\b(?:digest|sha(?:256)?|blob|version|revision)\b",
            prose,
            flags=re.IGNORECASE,
        ):
            findings.append(
                Finding(
                    "WARNING",
                    "plan-derived series prompt has no source plan version or digest",
                )
            )
        prerequisite_record = re.search(
            r"\b(?:prerequisites?|predecessors?)\b[\s\S]{0,200}"
            r"\b(?:accepted|contracts?|revision|commit|invariant|seam|none|"
            r"standalone|not applicable)\b",
            prose,
            flags=re.IGNORECASE,
        )
        if not prerequisite_record:
            findings.append(
                Finding(
                    "WARNING",
                    "plan-derived series prompt has no accepted prerequisite revision "
                    "or seam",
                )
            )
        if not re.search(
            r"\b(?:plan clause|clause coverage|coverage ledger)\b",
            prose,
            flags=re.IGNORECASE,
        ):
            findings.append(
                Finding(
                    "WARNING",
                    "if this project uses a clause ledger, the plan-derived series "
                    "prompt has no plan-clause coverage record",
                )
            )

    if re.search(r"\btargeted (?:test )?batter(?:y|ies)\b", prose, re.IGNORECASE):
        if not re.search(
            r"\b(?:closure (?:job|owner|gate)|full (?:suite|battery) "
            r"(?:owner|in this job|runs? in this job|is run here|before handoff))\b",
            prose,
            flags=re.IGNORECASE,
        ):
            findings.append(
                Finding(
                    "WARNING",
                    "if this project requires a closure owner, the targeted battery "
                    "has no named closure job or full-battery owner",
                )
            )

    if kind == "job":
        date_match = DATE_STAMP_RE.search(prose)
        if date_match:
            findings.append(
                Finding(
                    "WARNING",
                    f"line {_line_number(prose, date_match.start())}: date stamp "
                    "in prompt prose; contracts carry no date stamps",
                )
            )
    agent_match = AGENT_NAME_RE.search(prose)
    if agent_match:
        findings.append(
            Finding(
                "WARNING",
                f"line {_line_number(prose, agent_match.start())}: agent or "
                "process name in prompt prose; avoid naming agents or sessions "
                "unless the job depends on a specific host's tools or a carried "
                "rule names them, such as an authorship rule",
            )
        )

    if not re.search(r"\bdeviations?\b", quoted_prose, flags=re.IGNORECASE):
        findings.append(
            Finding(
                "WARNING",
                "no deviations section required in the return format",
            )
        )

    risky_patterns = {
        r"\bas applicable\b": "replace 'as applicable' with a decided path",
        r"\bwhere practical\b": "make the obligation exact or remove it",
        r"\bmeaningful result\b": "name the exact result, tier, value, or status",
        r"\bearliest(?:\s+semantic)?\s+owners?\b": (
            "name the verified semantic owner"
        ),
        r"\bfix (?:all|every) (?:issue|problem|finding)s?\b": (
            "freeze a closed finding set and authority rule"
        ),
        r"\bignor(?:e|ing) (?:any|all|volatile)\b": (
            "name per-line nondeterminism exemptions exactly"
        ),
        r"\bupdate (?:the )?tests? as needed\b": (
            "enumerate which existing tests move and why"
        ),
        r"\bappend every new test module\b": (
            "freeze the exact current-tree selector before dispatch"
        ),
        r"\b(?:callers?|call sites) (?:the |your )?(?:overlap )?audit "
        r"(?:finds|lists|discovers)\b": (
            "resolve and enumerate the authorized surface before dispatch"
        ),
    }
    for pattern, message in risky_patterns.items():
        match = re.search(pattern, prose, flags=re.IGNORECASE)
        if match:
            findings.append(
                Finding("WARNING", f"line {_line_number(prose, match.start())}: {message}")
            )

    open_test_surface = re.search(r"\bnew test modules?\b", prose, re.IGNORECASE)
    closed_test_surface = re.search(
        r"\b(?:no new test modules?|(?:do not|must not) add (?:any )?new test "
        r"modules?|new test modules? (?:are )?(?:forbidden|not allowed))\b",
        prose,
        re.IGNORECASE,
    )
    if open_test_surface and not closed_test_surface:
        findings.append(
            Finding(
                "WARNING",
                f"line {_line_number(prose, open_test_surface.start())}: if this "
                "project uses a closed test surface, replace 'new test modules' "
                "with a frozen current-tree list or name the permitted test paths",
            )
        )

    return findings


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("prompt", help="prompt file path, or '-' to read stdin")
    parser.add_argument("--kind", choices=("job", "correction"), required=True)
    token_mode = parser.add_mutually_exclusive_group()
    token_mode.add_argument(
        "--handoff-token",
        help="for an actual handoff, require this token as its final nonblank line",
    )
    token_mode.add_argument(
        "--require-handoff-instruction",
        dest="handoff_instruction_token",
        help="for a job prompt, require an instruction naming this literal final token",
    )
    parser.add_argument("--strict", action="store_true", help="treat warnings as errors")
    args = parser.parse_args()

    try:
        if args.prompt == "-":
            text = sys.stdin.buffer.read().decode("utf-8")
        else:
            text = Path(args.prompt).read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as error:
        print(f"lint_job_prompt: cannot read {args.prompt}: {error}", file=sys.stderr)
        return 2
    findings = lint_prompt(
        text,
        kind=args.kind,
        handoff_token=args.handoff_token,
        handoff_instruction_token=args.handoff_instruction_token,
    )
    for finding in findings:
        print(f"{finding.level}: {finding.message}")

    errors = sum(item.level == "ERROR" for item in findings)
    warnings = sum(item.level == "WARNING" for item in findings)
    print(f"SUMMARY errors={errors} warnings={warnings}")
    return 1 if errors or (args.strict and warnings) else 0


if __name__ == "__main__":
    sys.exit(main())
