"""Focused tests for lint_job_prompt.py."""

from __future__ import annotations

import importlib.util
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SCRIPT = Path(__file__).with_name("lint_job_prompt.py")
SPEC = importlib.util.spec_from_file_location("lint_job_prompt", SCRIPT)
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = MODULE
SPEC.loader.exec_module(MODULE)


def messages(
    text: str,
    *,
    kind: str = "job",
    token: str | None = None,
    instruction_token: str | None = None,
) -> list[str]:
    return [
        item.message
        for item in MODULE.lint_prompt(
            text,
            kind=kind,
            handoff_token=token,
            handoff_instruction_token=instruction_token,
        )
    ]


class LintJobPromptTests(unittest.TestCase):
    def test_valid_general_prompt_with_custom_token(self) -> None:
        text = """# Build the bounded feature

## Authorization
The user authorized edits to src/core.py and no external actions.

## Behavioral contract
The public call returns READY. Work outside src/core.py must stop and ask.

## Allowed files
- src/core.py
- tests/test_core.py

## Verification commands
```bash
.venv/bin/python -m pytest tests/test_core.py
```

## Handoff
Stop before commit. Report deviations.

DONE
"""
        self.assertEqual(messages(text, token="DONE"), [])

    def test_template_placeholder_is_error(self) -> None:
        result = messages("# Job\n\n## Scope\n{{CLOSED_LIST}}\n")
        self.assertTrue(any("unresolved template" in item for item in result))

    def test_ci_and_jinja_braces_in_fences_are_not_template_fields(self) -> None:
        text = (
            "# Job\n\nReport deviations.\n\n```yaml\n"
            "python-version: ${{ matrix.python }}\n"
            "name: {{ closed_list }}\n```\n"
        )
        self.assertFalse(any("unresolved template" in m for m in messages(text)))

    def test_bundled_templates_cannot_pass_unrendered(self) -> None:
        reference_dir = SCRIPT.parent.parent / "references"
        for path in reference_dir.glob("*-prompt-template.md"):
            with self.subTest(path=path.name):
                result = messages(
                    path.read_text(encoding="utf-8"),
                    kind="correction" if path.name.startswith("correction") else "job",
                )
                self.assertTrue(any("unresolved template" in item for item in result))

    def test_wrapper_is_case_insensitive(self) -> None:
        result = messages("# Job\n<CODEX_DELEGATION>\nbody\n")
        self.assertTrue(any("nested codex_delegation" in item for item in result))

    def test_wrapper_example_inside_fence_is_ignored(self) -> None:
        text = "# Job\n\n```xml\n<codex_delegation>\n```\n"
        self.assertFalse(any("codex_delegation" in item for item in messages(text)))

    def test_token_must_be_unique_and_final(self) -> None:
        result = messages("# Job\nDONE\ntext\nDONE\n", token="DONE")
        self.assertTrue(any("exactly once" in item for item in result))
        self.assertFalse(any("final nonblank" in item for item in result))

        result = messages("# Job\nDONE\ntext\n", token="DONE")
        self.assertTrue(any("final nonblank" in item for item in result))

    def test_token_reference_in_prose_is_not_a_second_token(self) -> None:
        text = "# Job\n\nThe work is DONE only after tests; report deviations.\n\nDONE\n"
        self.assertEqual(messages(text, token="DONE"), [])

    def test_prompt_handoff_instruction_is_distinct_from_actual_handoff(self) -> None:
        text = """# Job

## Return
Report deviations. End the handoff with the following literal final line:
DONE
"""
        self.assertEqual(messages(text, instruction_token="DONE"), [])
        result = messages(
            "# Job\n\n## Return\nReport deviations and include DONE.\n",
            instruction_token="DONE",
        )
        self.assertTrue(any("literal final line" in item for item in result))

        reverse = "# Job\n\nUse DONE as the literal final line; report deviations.\n"
        self.assertEqual(messages(reverse, instruction_token="DONE"), [])

        negated_reverse = (
            "# Job\n\nDo not use DONE as the literal final line; report deviations.\n"
        )
        result = messages(negated_reverse, instruction_token="DONE")
        self.assertTrue(any("literal final line" in item for item in result))

        substring = (
            "# Job\n\nThe final line must not be UNDONE; report deviations.\n"
        )
        result = messages(substring, instruction_token="DONE")
        self.assertTrue(any("occur exactly once" in item for item in result))

    def test_correction_requires_precedence_marker(self) -> None:
        result = messages("# Correction\n\n## Authority\nAuthorized.\n", kind="correction")
        self.assertTrue(any("supersedes or replaces" in item for item in result))

    def test_blockquoted_precedence_marker_satisfies_correction(self) -> None:
        text = "# Correction\n\n> This supersedes job 3.\n\nReport deviations.\n"
        result = messages(text, kind="correction")
        self.assertFalse(any("supersedes or replaces" in item for item in result))

    def test_duplicate_h2_is_error(self) -> None:
        result = messages("# Job\n\n## Gates\na\n\n## Gates\nb\n")
        self.assertTrue(any("duplicate H2" in item for item in result))

    def test_vague_wording_ignores_fences_and_catches_prose(self) -> None:
        fenced = "# Job\n\n```text\nas applicable\n```\n"
        self.assertFalse(any("decided path" in item for item in messages(fenced)))
        prose = "# Job\n\nUse this as applicable.\n"
        self.assertTrue(any("decided path" in item for item in messages(prose)))
        plural = "# Job\n\nPatch the earliest semantic owners.\n"
        self.assertTrue(any("verified semantic owner" in item for item in messages(plural)))

    def test_unbalanced_fence_is_error(self) -> None:
        result = messages("# Job\n\n```bash\npytest\n")
        self.assertTrue(any("unbalanced" in item for item in result))



class NewHygieneChecks(unittest.TestCase):
    def test_bare_python_in_fence_warns(self) -> None:
        text = "# T\n\nReport deviations.\n\n```bash\npython scripts/run.py\n```\n"
        self.assertTrue(any("bare `python`" in m for m in messages(text)))

    def test_pinned_interpreter_does_not_warn(self) -> None:
        text = "# T\n\nReport deviations.\n\n```bash\n.venv/bin/python scripts/run.py\n```\n"
        self.assertFalse(any("bare `python`" in m for m in messages(text)))

    def test_bare_python_in_inline_code_warns(self) -> None:
        text = "# T\n\nRun `python scripts/run.py`; report deviations.\n"
        self.assertTrue(any("bare `python`" in m for m in messages(text)))

    def test_pinned_interpreter_in_inline_code_does_not_warn(self) -> None:
        text = "# T\n\nRun `.venv/bin/python scripts/run.py`; report deviations.\n"
        self.assertFalse(any("bare `python`" in m for m in messages(text)))

    def test_angle_placeholder_in_fenced_command_is_error(self) -> None:
        text = "# T\n\nReport deviations.\n\n```bash\nrun <your-new-example>\n```\n"
        self.assertTrue(any("angle-bracket" in m for m in messages(text)))

        lowercase = "# T\n\nReport deviations.\n\n```bash\nrun <name>\n```\n"
        self.assertTrue(any("angle-bracket" in m for m in messages(lowercase)))

    def test_option_value_placeholder_in_fenced_command_is_error(self) -> None:
        text = "# T\n\nReport deviations.\n\n```bash\nbuild --out=<path>\n```\n"
        self.assertTrue(any("angle-bracket" in m for m in messages(text)))

    def test_cpp_generics_in_untagged_fence_are_not_placeholders(self) -> None:
        text = (
            "# T\n\nReport deviations.\n\n```\n"
            "std::vector<double> x;\n"
            "std::map<std::string, int> index;\n```\n"
        )
        self.assertFalse(any("angle-bracket" in m for m in messages(text)))

    def test_uppercase_xml_tag_is_not_a_command_placeholder(self) -> None:
        text = "# T\n\nReport deviations.\n\n```xml\n<STEP>build</STEP>\n```\n"
        self.assertFalse(any("angle-bracket" in m for m in messages(text)))

    def test_labeled_status_echo_is_clean(self) -> None:
        text = "# T\n\nReport deviations.\n\n```bash\nrun-check ; echo EXIT=$?\n```\n"
        self.assertFalse(
            any("exit status" in m or "unlabeled" in m for m in messages(text))
        )

        multiline = (
            "# T\n\nReport deviations.\n\n```bash\n"
            "run-check\necho EXIT=$?\n```\n"
        )
        self.assertFalse(any("unlabeled" in m for m in messages(multiline)))

        inline = "# T\n\nRun `run-check ; echo EXIT=$?`; report deviations.\n"
        self.assertFalse(any("exit status" in m for m in messages(inline)))

    def test_failure_only_echo_fallback_is_error(self) -> None:
        fallback = "# T\n\nReport deviations.\n\n```bash\nrun-check || echo $?\n```\n"
        self.assertTrue(any("failure-only" in m for m in messages(fallback)))

        inline = "# T\n\nRun `run-check || echo EXIT=$?`; report deviations.\n"
        self.assertTrue(any("failure-only" in m for m in messages(inline)))

    def test_unlabeled_status_echo_warns(self) -> None:
        text = "# T\n\nReport deviations.\n\n```bash\nrun-check ; echo $?\n```\n"
        self.assertTrue(any("unlabeled" in m for m in messages(text)))

        multiline = (
            "# T\n\nReport deviations.\n\n```bash\n"
            "run-check\necho $?\n```\n"
        )
        self.assertTrue(any("unlabeled" in m for m in messages(multiline)))

    def test_captured_and_returned_exit_status_is_allowed(self) -> None:
        text = (
            "# T\n\nReport deviations.\n\n```bash\n"
            "run-check; rc=$?; echo EXIT=$rc; exit \"$rc\"\n```\n"
        )
        self.assertFalse(any("exit status" in m for m in messages(text)))

    def test_negated_inline_masked_exit_example_is_allowed(self) -> None:
        text = "# T\n\nNever use `cmd || echo $?`; report deviations.\n"
        self.assertFalse(any("failure-only" in m for m in messages(text)))

    def test_indented_bare_python_in_fence_warns(self) -> None:
        text = "# T\n\nReport deviations.\n\n```bash\n  python run.py\n```\n"
        self.assertTrue(any("bare `python`" in m for m in messages(text)))

    def test_missing_deviations_warns(self) -> None:
        text = "# T\n\nReturn a handoff.\n"
        self.assertTrue(any("deviations" in m for m in messages(text)))

    def test_blockquoted_deviations_requirement_is_found(self) -> None:
        text = "# T\n\n> Report deviations in the handoff.\n"
        self.assertFalse(any("deviations" in m for m in messages(text)))

    def test_blanket_ignore_warns(self) -> None:
        text = "# T\n\nReport deviations; compare ignoring any volatile output.\n"
        self.assertTrue(any("nondeterminism" in m for m in messages(text)))

    def test_series_prompt_requires_lineage_prerequisites_and_coverage(self) -> None:
        text = "# Change Set A\n\nThis serial job reaches program closure. Report deviations.\n"
        result = messages(text)
        self.assertTrue(any("source plan version or digest" in m for m in result))
        self.assertTrue(any("accepted prerequisite" in m for m in result))
        self.assertTrue(
            any(
                m.startswith("if this project uses a clause ledger")
                and "plan-clause coverage" in m
                for m in result
            )
        )

    def test_complete_series_metadata_avoids_series_warnings(self) -> None:
        text = """# Change Set A

This serial job reaches program closure. Report deviations.
Source bundle: plan.md version 3, sha256 abc123.
Accepted prerequisite contracts: job-1@r2.
Plan clause coverage ledger: clause P1 is owned here.
"""
        result = messages(text)
        self.assertFalse(any("source plan version or digest" in m for m in result))
        self.assertFalse(any("accepted prerequisite" in m for m in result))
        self.assertFalse(any("plan-clause coverage" in m for m in result))

    def test_series_prerequisites_none_is_an_explicit_record(self) -> None:
        text = """# Change Set A

This serial job starts the series. Report deviations.
Source bundle: plan.md version 3, sha256 abc123.
Prerequisites: none.
Plan clause coverage ledger: clause P1 is owned here.
"""
        self.assertFalse(any("accepted prerequisite" in m for m in messages(text)))

    def test_standalone_integration_gate_does_not_trigger_series_warnings(self) -> None:
        text = "# Gate\n\nRun the integration gate and report deviations.\n"
        result = messages(text)
        self.assertFalse(any("plan-derived series" in m for m in result))

    def test_change_set_identifier_alone_triggers_series_warnings(self) -> None:
        for heading in ("# Change Set A", "# Change Set 2"):
            with self.subTest(heading=heading):
                text = f"{heading}\n\nFix the parser. Report deviations.\n"
                result = messages(text)
                self.assertTrue(any("source plan version or digest" in m for m in result))

    def test_change_set_prose_does_not_trigger_series_warnings(self) -> None:
        text = "# Fix parser\n\nThe change set touches src/a.py only. Report deviations.\n"
        self.assertFalse(any("plan-derived series" in m for m in messages(text)))

    def test_change_set_heading_before_capitalized_paragraph_does_not_warn(self) -> None:
        text = "# Fix parser\n\n## Change Set\n\nA single file changes. Report deviations.\n"
        self.assertFalse(any("plan-derived series" in m for m in messages(text)))

    def test_unowned_targeted_battery_warns_conditionally(self) -> None:
        text = "# T\n\nRun the targeted test battery. Report deviations.\n"
        self.assertIn(
            "if this project requires a closure owner, the targeted battery "
            "has no named closure job or full-battery owner",
            messages(text),
        )

    def test_targeted_battery_closed_in_same_job_does_not_warn(self) -> None:
        text = (
            "# T\n\nRun the targeted test battery, then the full suite in this job. "
            "Report deviations.\n"
        )
        self.assertFalse(any("targeted battery" in m for m in messages(text)))

    def test_open_test_and_audit_discovered_surfaces_warn(self) -> None:
        text = """# T

Report deviations.
Allowed: new test modules and callers your overlap audit lists.
"""
        result = messages(text)
        self.assertTrue(
            any(
                "if this project uses a closed test surface" in m
                and "name the permitted test paths" in m
                for m in result
            )
        )
        self.assertFalse(any("surface-conflict" in m for m in result))
        self.assertTrue(any("authorized surface" in m for m in result))

    def test_explicit_no_new_test_modules_does_not_warn(self) -> None:
        text = "# T\n\nReport deviations. Do not add new test modules.\n"
        self.assertFalse(any("frozen current-tree list" in m for m in messages(text)))

    def test_no_restriction_does_not_suppress_open_test_surface_warning(self) -> None:
        text = "# T\n\nThere is no restriction on new test modules; report deviations.\n"
        self.assertTrue(any("frozen current-tree list" in m for m in messages(text)))

    def test_date_stamp_in_job_prose_warns(self) -> None:
        text = "# T\n\nAuthored 2026-07-14. Report deviations.\n"
        self.assertTrue(any("date stamp" in m for m in messages(text)))

    def test_date_stamp_in_correction_prose_is_allowed(self) -> None:
        text = (
            "# C\n\nThis supersedes the instruction issued 2026-07-14 09:00. "
            "Report deviations.\n"
        )
        self.assertFalse(any("date stamp" in m for m in messages(text, kind="correction")))

    def test_date_in_fenced_command_does_not_warn(self) -> None:
        text = (
            "# T\n\nReport deviations.\n\n```bash\n"
            "cmp goldens/2026-01-01.json out.json\n```\n"
        )
        self.assertFalse(any("date stamp" in m for m in messages(text)))

    def test_agent_name_in_prose_warns(self) -> None:
        text = "# T\n\nCodex should patch the parser. Report deviations.\n"
        self.assertTrue(
            any("unless the job depends on a specific host's tools" in m for m in messages(text))
        )

    def test_lowercase_tool_path_is_not_an_agent_name(self) -> None:
        text = "# T\n\nDo not edit `.claude/settings.json`. Report deviations.\n"
        self.assertFalse(
            any("unless the job depends on a specific host's tools" in m for m in messages(text))
        )


class CommandLineTests(unittest.TestCase):
    def run_linter(self, *args: str, stdin: str = "") -> subprocess.CompletedProcess[str]:
        return subprocess.run(
            [sys.executable, "-B", str(SCRIPT), *args],
            input=stdin,
            capture_output=True,
            text=True,
            check=False,
        )

    def test_dash_reads_prompt_from_stdin(self) -> None:
        result = self.run_linter("-", "--kind", "job", stdin="# Job\n\nRun {{TASK_NAME}}.\n")
        # The placeholder error proves the stdin text itself was linted.
        self.assertIn("unresolved template placeholders", result.stdout)
        self.assertIn("SUMMARY errors=", result.stdout)
        self.assertEqual(result.stderr, "")

    def test_unreadable_path_reports_one_line_and_exits_2(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            missing = Path(directory) / "missing.md"
            result = self.run_linter(str(missing), "--kind", "job")
        self.assertEqual(result.returncode, 2)
        self.assertEqual(result.stdout, "")
        self.assertEqual(len(result.stderr.splitlines()), 1)
        self.assertNotIn("Traceback", result.stderr)


if __name__ == "__main__":
    unittest.main()
