#!/usr/bin/env python3
"""Install the research-skills plugin, with every skill and the writing hook, into Claude Code."""

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

# Every skill, the writing hook, the notices, and the benchmark report that ponytail-gain
# cites. Unit tests and the Codex manifest stay out. Skills keep agents/openai.yaml because
# quantum-research-radar's scripts/package_check.py reads it.
PACKAGE_FILES = ("LICENSE.md", "NOTICE.md", "PONYTAIL-LICENSE",
                 "hooks/hooks.json", "hooks/writing-style-routing.js")
PACKAGE_DIRS = ("LICENSES", "benchmarks", "skills")
IGNORE = shutil.ignore_patterns("__pycache__", "*.pyc", ".DS_Store", "test_*.py")


def write_json(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2) + "\n")


def build_package(source, staged):
    """Stage the Claude package from the plugin source and return its manifest."""
    source, staged = Path(source), Path(staged)
    for name in PACKAGE_DIRS:
        shutil.copytree(source / name, staged / name, ignore=IGNORE)
    for name in PACKAGE_FILES:
        (staged / name).parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source / name, staged / name)
    digest = hashlib.sha256()
    for file in sorted(staged.rglob("*")):
        if file.is_file():
            digest.update(file.relative_to(staged).as_posix().encode() + b"\0")
            digest.update(hashlib.sha256(file.read_bytes()).digest())
    codex = json.loads((source / ".codex-plugin/plugin.json").read_text())
    manifest = {
        "name": "research-skills",
        "version": f"{codex['version'].split('+', 1)[0]}+claude.{digest.hexdigest()[:16]}",
        "description": codex["description"],
        "author": codex["author"],
        "homepage": codex["homepage"],
        "repository": codex["repository"],
        "keywords": codex["keywords"],
    }
    write_json(staged / ".claude-plugin/plugin.json", manifest)
    return manifest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--claude-bin", default="claude", help="Claude Code executable")
    args = parser.parse_args()
    claude = shutil.which(args.claude_bin) or args.claude_bin
    print(f"Using Claude Code CLI: {claude}", flush=True)
    try:
        subprocess.run([claude, "--version"], check=True)
    except (OSError, subprocess.CalledProcessError):
        sys.exit(f"Claude Code CLI at {claude} failed. Pass --claude-bin /path/to/claude.")
    source = Path(__file__).resolve().parents[1] / "plugins/research-skills"
    marketplace = Path.home() / ".local/share/research-skills/claude-marketplace"
    marketplace.mkdir(parents=True, exist_ok=True)
    package = marketplace / "research-skills"
    with tempfile.TemporaryDirectory(prefix=".build-", dir=marketplace) as temp:
        staged = Path(temp) / "research-skills"
        build_package(source, staged)
        subprocess.run([claude, "plugin", "validate", str(staged)], check=True)
        if package.exists():
            shutil.rmtree(package)
        shutil.move(str(staged), package)
    write_json(marketplace / ".claude-plugin/marketplace.json", {
        "name": "research-skills",
        "owner": {"name": "Firepanda415"},
        "plugins": [{"name": "research-skills", "source": "./research-skills"}],
    })
    subprocess.run([claude, "plugin", "marketplace", "add", str(marketplace)], check=True)
    installed = json.loads(subprocess.run(
        [claude, "plugin", "list", "--json"],
        check=True, capture_output=True, text=True).stdout)
    action = "update" if any(p["id"] == "research-skills@research-skills" and
                             p["scope"] == "user" for p in installed) else "install"
    subprocess.run([claude, "plugin", action, "research-skills@research-skills",
                    "--scope", "user"], check=True)
    subprocess.run([claude, "plugin", "details", "research-skills@research-skills"], check=True)
    print("Installed. Start a new Claude Code session. "
          "Sessions already running keep the previous copy.")


if __name__ == "__main__":
    main()
