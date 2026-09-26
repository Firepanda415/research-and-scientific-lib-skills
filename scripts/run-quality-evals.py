#!/usr/bin/env python3
"""Stage the Claude package with the quality evals, optionally remove parts of skills, and run `claude plugin eval`.

The default is a dry run. --run starts paid Claude Code sessions and needs --max-cost-usd and --results-dir.
A variant from evals-quality/variants.yaml removes named sections from skill files in the staged copy only.
"""

import argparse
import importlib.util
import os
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
SUITE = ROOT / "evals-quality"
CASE_KEYS = {"schema_version", "name", "description", "tags", "runs", "context", "execution", "graders"}
CONTEXT_KEYS = {"scaffold_script", "add_dirs"}
EXECUTION_KEYS = {"prompt", "max_turns", "timeout_seconds", "allowed_tools"}
GRADER_KEYS = {"name", "type", "weight", "arm", "pattern", "flags", "match", "target",
               "tool", "input_match", "min", "max", "criteria", "focus", "before", "after", "path", "exists"}
GRADER_TYPES = {"regex", "tool_used", "tool_order", "file_exists", "llm"}


def remove_section(text, heading):
    """Delete a Markdown section from its heading to the next heading of the same or a higher level."""
    level = len(heading) - len(heading.lstrip("#"))
    lines = text.split("\n")
    start = lines.index(heading)
    end = next((i for i in range(start + 1, len(lines))
                if re.match(r"#{1,%d} " % level, lines[i])), len(lines))
    return "\n".join(lines[:start] + lines[end:])


def apply_variant(plugin, name):
    """Apply one variant to the staged plugin. Every named heading must exist, so a stale variant fails loudly."""
    variants = yaml.safe_load((SUITE / "variants.yaml").read_text())
    if name not in variants:
        sys.exit(f"unknown variant {name}; known: {', '.join(sorted(variants))}")
    for relative, change in variants[name].items():
        path = plugin / relative
        text = path.read_text()
        if "replace" in change:
            text = change["replace"].rstrip() + "\n"
        for heading in change.get("remove", []):
            assert heading in text.split("\n"), f"{name}: heading not found in {relative}: {heading}"
            text = remove_section(text, heading)
        path.write_text(text)


def check_cases(evals, skills):
    """Check each case.yaml against the fields `claude plugin eval` reads."""
    names = []
    for path in sorted(evals.rglob("case.yaml")):
        case, where = yaml.safe_load(path.read_text()), path.parent.name
        assert set(case) <= CASE_KEYS and case.get("name") == where, f"{where}: case fields or name"
        assert str(case["schema_version"]).split(".")[0] == "1", f"{where}: schema_version"
        context = case.get("context", {})
        assert set(context) <= CONTEXT_KEYS, f"{where}: context fields"
        for relative in [context.get("scaffold_script")] + context.get("add_dirs", []):
            assert relative is None or (path.parent / relative).exists(), f"{where}: missing {relative}"
        execution = case["execution"]
        assert set(execution) <= EXECUTION_KEYS and execution["prompt"].strip(), f"{where}: execution"
        graders = case["graders"]
        assert graders and len({g["name"] for g in graders}) == len(graders), f"{where}: grader names"
        for grader in graders:
            assert set(grader) <= GRADER_KEYS and grader["type"] in GRADER_TYPES, f"{where}: {grader['name']}"
            if grader["type"] == "llm":
                assert grader.get("criteria", "").strip(), f"{where}: {grader['name']} needs criteria"
            if grader["type"] == "tool_order":
                assert grader.get("before") and grader.get("after"), f"{where}: {grader['name']} needs before and after"
            if grader["type"] == "file_exists":
                assert grader.get("path"), f"{where}: {grader['name']} needs path"
            if grader["type"] == "regex":
                re.compile(grader["pattern"])
            for skill in re.findall(r"research-skills:\)\?([a-z0-9-]+)", grader.get("input_match", "")):
                assert skill in skills, f"{where}: unknown skill {skill}"
        names.append(where)
    assert names, f"no case.yaml under {evals}"
    return names


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--variant", help="name from evals-quality/variants.yaml (default: the unmodified plugin)")
    parser.add_argument("--run", action="store_true", help="run the evals instead of printing the command")
    parser.add_argument("--max-cost-usd", type=float, help="cost ceiling passed to claude plugin eval (required with --run)")
    parser.add_argument("--results-dir", type=Path, help="where the JSON result and HTML report go (required with --run)")
    parser.add_argument("--runs", type=int, default=3, help="runs per case per arm (default 3)")
    parser.add_argument("--case", help="case name glob")
    parser.add_argument("--tag", help="run only cases with this tag")
    parser.add_argument("--ablation", choices=["with-without", "none"], default="with-without",
                        help="with-without adds the no-plugin arm (default); variants normally use none")
    parser.add_argument("--model", default="claude-opus-5-5", help="model for the sessions under test")
    parser.add_argument("--effort", default="medium", help="CLAUDE_CODE_EFFORT_LEVEL for the sessions under test")
    parser.add_argument("--judge-model", default="claude-opus-5-5", help="model for llm graders")
    parser.add_argument("--concurrency", type=int, default=2, help="agent runs at once, 1 to 8 (default 2)")
    parser.add_argument("--allow-tools", nargs="+", default=[], help="tools to grant beyond the read-only set, such as Write Edit")
    parser.add_argument("--scaffold", action="store_true", help="run each case's scaffold_script before the session starts")
    parser.add_argument("--keep-temp", action="store_true", help="keep each run's directory with its trace and the files the agent changed")
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
    stage = Path(tempfile.mkdtemp(prefix="research-skills-quality-")).resolve()
    try:
        if results and results.is_relative_to(stage):
            sys.exit(f"--results-dir must be outside the temporary stage {stage}")
        plugin = stage / "research-skills"
        installer.build_package(ROOT / "plugins/research-skills", plugin)
        if args.variant:
            apply_variant(plugin, args.variant)
        shutil.copytree(SUITE, plugin / "evals", ignore=shutil.ignore_patterns("results", ".DS_Store", "variants.yaml"))
        skills = {p.parent.name for p in (plugin / "skills").glob("*/SKILL.md")}
        names = check_cases(plugin / "evals", skills)

        out = str(results) if results else "<results-dir>"
        command = [claude, "plugin", "eval", str(plugin), "--ablation", args.ablation, "--no-publish",
                   "--trust-plugin", "--runs", str(args.runs), "--model", args.model,
                   "--judge-model", args.judge_model, "--concurrency", str(args.concurrency),
                   "--max-cost-usd", str(args.max_cost_usd) if args.max_cost_usd is not None else "<usd>"]
        if args.case:
            command += ["--case", args.case]
        if args.tag:
            command += ["--tag", args.tag]
        if args.scaffold:
            command += ["--scaffold"]
        if args.keep_temp:
            command += ["--keep-temp"]
        if args.allow_tools:
            command += ["--allow-tools", *args.allow_tools]
        command += ["--output-dir", out, "--json", f"{out}/eval-result.json"]
        try:
            help_text = subprocess.run([claude, "plugin", "eval", "--help"],
                                       check=True, capture_output=True, text=True).stdout
        except (OSError, subprocess.CalledProcessError):
            sys.exit(f"`{claude} plugin eval --help` failed. Pass --claude-bin /path/to/claude.")
        missing = [flag for flag in command if flag.startswith("--") and flag not in help_text]
        if missing:
            sys.exit(f"{claude} plugin eval does not list {missing}")

        print(f"Staged {len(names)} cases and {len(skills)} skills in {plugin}, variant {args.variant or 'none'}")
        print(f"Sessions under test: {args.model} with CLAUDE_CODE_EFFORT_LEVEL={args.effort}. Judge: {args.judge_model}.")
        print("Note: --max-cost-usd is checked before each run starts and does not stop a run already in progress.")
        print(f"CLAUDE_CODE_EFFORT_LEVEL={args.effort} " + shlex.join(command), flush=True)
        if not args.run:
            print("Dry run: nothing was executed. Add --run, --max-cost-usd and --results-dir to run it.")
            return
        results.mkdir(parents=True, exist_ok=True)
        env = {**os.environ, "CLAUDE_CODE_EFFORT_LEVEL": args.effort}
        sys.exit(subprocess.run(command, cwd=results, env=env).returncode)
    finally:
        if args.keep_stage:
            print(f"Kept stage: {stage}")
        else:
            shutil.rmtree(stage)


if __name__ == "__main__":
    main()
