#!/usr/bin/env python3
"""Stage the Claude package with the routing evals and print or run `claude plugin eval` on it.

The default is a dry run. --run starts paid Claude Code sessions and needs --max-cost-usd and --results-dir.
"""

import argparse
import importlib.util
from pathlib import Path
import re
import shlex
import shutil
import subprocess
import sys
import tempfile

try:
    import yaml
except ImportError:
    sys.exit("PyYAML missing: install requirements-dev.txt into the interpreter that runs this script")

ROOT = Path(__file__).resolve().parents[1]
CASE_KEYS = {"schema_version", "name", "description", "tags", "execution", "graders"}
EXECUTION_KEYS = {"prompt", "max_turns", "timeout_seconds", "allowed_tools"}
GRADER_KEYS = {"name", "type", "tool", "input_match", "min", "max", "arm"}
SKILL_MATCH = re.compile(r'"\(\?:research-skills:\)\?([a-z0-9-]+)"')


def check_cases(evals, skills):
    """Check each case.yaml against the fields `claude plugin eval` reads and this suite's grader rules."""
    names = []
    for path in sorted(evals.rglob("case.yaml")):
        case, where = yaml.safe_load(path.read_text()), path.parent.name
        assert set(case) <= CASE_KEYS and case.get("name") == where, f"{where}: case fields or name"
        assert str(case["schema_version"]).split(".")[0] == "1", f"{where}: schema_version"
        execution = case["execution"]
        assert set(execution) <= EXECUTION_KEYS and execution["prompt"].strip(), f"{where}: execution"
        assert "Skill" in execution["allowed_tools"], f"{where}: Skill must be an allowed tool"
        graders = case["graders"]
        assert len({g["name"] for g in graders}) == len(graders), f"{where}: duplicate grader names"
        expected = []
        for grader in graders:
            assert set(grader) <= GRADER_KEYS, f"{where}: grader fields {sorted(grader)}"
            assert grader["type"] == "tool_used" and grader["tool"] == "Skill", f"{where}: Skill graders only"
            match = SKILL_MATCH.fullmatch(grader["input_match"])
            assert match and match[1] in skills, f"{where}: unknown skill in {grader['input_match']}"
            if "max" in grader:
                assert (grader["min"], grader["max"], grader.get("arm")) == (0, 0, "both"), (
                    f"{where}: {grader['name']} must set min 0, max 0 and arm both")
            else:
                assert grader["min"] == 1 and "arm" not in grader, f"{where}: {grader['name']} must set min 1"
                expected.append(match[1])
        assert len(expected) == 1, f"{where}: expected exactly one skill, found {expected}"
        names.append(where)
    assert names, f"no case.yaml under {evals}"
    return names


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run", action="store_true", help="run the evals instead of printing the command")
    parser.add_argument("--max-cost-usd", type=float, help="cost ceiling passed to claude plugin eval (required with --run)")
    parser.add_argument("--results-dir", type=Path, help="where the JSON result and HTML report go (required with --run)")
    parser.add_argument("--runs", type=int, default=3, help="runs per case (default 3)")
    parser.add_argument("--case", help="case name glob, for example 'review-*' for a pilot")
    parser.add_argument("--claude-bin", default="claude", help="Claude Code executable")
    parser.add_argument("--keep-stage", action="store_true", help="keep the staged plugin directory")
    args = parser.parse_args()
    if args.run and (args.max_cost_usd is None or args.results_dir is None):
        parser.error("--run requires --max-cost-usd and --results-dir")
    claude = shutil.which(args.claude_bin) or args.claude_bin
    results = args.results_dir.resolve() if args.results_dir else None

    spec = importlib.util.spec_from_file_location("install_claude", ROOT / "scripts/install-claude.py")
    installer = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(installer)
    stage = Path(tempfile.mkdtemp(prefix="research-skills-evals-")).resolve()
    try:
        if results and results.is_relative_to(stage):
            sys.exit(f"--results-dir must be outside the temporary stage {stage}")
        plugin = stage / "research-skills"
        installer.build_package(ROOT / "plugins/research-skills", plugin)
        shutil.copytree(ROOT / "evals", plugin / "evals", ignore=shutil.ignore_patterns("results", ".DS_Store"))
        skills = {p.parent.name for p in (plugin / "skills").glob("*/SKILL.md")}
        names = check_cases(plugin / "evals", skills)

        command = [claude, "plugin", "eval", str(plugin), "--ablation", "none", "--no-publish",
                   "--trust-plugin", "--runs", str(args.runs),
                   "--max-cost-usd", str(args.max_cost_usd) if args.max_cost_usd is not None else "<usd>"]
        if args.case:
            command += ["--case", args.case]
        out = str(results) if results else "<results-dir>"
        command += ["--output-dir", out, "--json", f"{out}/eval-result.json", "--report", f"{out}/report.html"]
        try:
            help_text = subprocess.run([claude, "plugin", "eval", "--help"],
                                       check=True, capture_output=True, text=True).stdout
        except (OSError, subprocess.CalledProcessError):
            sys.exit(f"`{claude} plugin eval --help` failed. Pass --claude-bin /path/to/claude.")
        missing = [flag for flag in command if flag.startswith("--") and flag not in help_text]
        if missing:
            sys.exit(f"{claude} plugin eval does not list {missing}")

        print(f"Staged {len(names)} cases and {len(skills)} skills in {plugin}")
        print("Warning: --trust-plugin skips the first-use trust prompt for the staged plugin.")
        print("Note: --max-cost-usd is checked before each run starts and does not stop a run already in progress.")
        print(shlex.join(command), flush=True)
        if not args.run:
            print("Dry run: nothing was executed. Add --run, --max-cost-usd and --results-dir to run it.")
            return
        results.mkdir(parents=True, exist_ok=True)
        sys.exit(subprocess.run(command, cwd=results).returncode)
    finally:
        if args.keep_stage:
            print(f"Kept stage: {stage}")
        else:
            shutil.rmtree(stage)


if __name__ == "__main__":
    main()
