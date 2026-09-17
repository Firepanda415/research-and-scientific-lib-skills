#!/usr/bin/env python3
"""Install the research skills and writing hook into Claude Code, without Ponytail."""

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import tempfile


def write_json(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2) + "\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--claude-bin", default="claude", help="Claude Code executable")
    args = parser.parse_args()
    subprocess.run([args.claude_bin, "--version"], check=True)
    source = Path(__file__).resolve().parents[1] / "plugins/research-skills"
    marketplace = Path.home() / ".local/share/research-skills/claude-marketplace"
    marketplace.mkdir(parents=True, exist_ok=True)
    package = marketplace / "research-skills"
    with tempfile.TemporaryDirectory(prefix=".build-", dir=marketplace) as temp:
        staged = Path(temp) / "research-skills"
        for skill in sorted((source / "skills").iterdir()):
            if (skill / "SKILL.md").is_file() and not skill.name.startswith("ponytail"):
                shutil.copytree(skill, staged / "skills" / skill.name,
                                ignore=shutil.ignore_patterns("__pycache__", "*.pyc", ".DS_Store"))
        for name in ("LICENSE.md", "NOTICE.md", "PONYTAIL-LICENSE"):
            shutil.copy2(source / name, staged / name)
        shutil.copytree(source / "LICENSES", staged / "LICENSES")
        (staged / "hooks").mkdir()
        shutil.copy2(source / "hooks/writing-style-routing.js", staged / "hooks/writing-style-routing.js")
        write_json(staged / "hooks/hooks.json", {"hooks": {
            event: [{"hooks": [{
                "type": "command",
                "command": f'node "${{CLAUDE_PLUGIN_ROOT}}/hooks/writing-style-routing.js" {event}',
                "timeout": 5,
            }]}] for event in ("SessionStart", "SubagentStart")
        }})
        digest = hashlib.sha256()
        for file in sorted(staged.rglob("*")):
            if file.is_file():
                digest.update(file.relative_to(staged).as_posix().encode() + b"\0")
                digest.update(hashlib.sha256(file.read_bytes()).digest())
        write_json(staged / ".claude-plugin/plugin.json", {
            "name": "research-skills",
            "version": f"0.1.0+claude.{digest.hexdigest()[:16]}",
            "description": "Research and scientific software skills with the writing hook. Excludes Ponytail.",
            "author": {"name": "Firepanda415"},
        })
        subprocess.run([args.claude_bin, "plugin", "validate", str(staged)], check=True)
        if package.exists():
            shutil.rmtree(package)
        shutil.move(str(staged), package)
    write_json(marketplace / ".claude-plugin/marketplace.json", {
        "name": "research-skills",
        "owner": {"name": "Firepanda415"},
        "plugins": [{"name": "research-skills", "source": "./research-skills"}],
    })
    subprocess.run([args.claude_bin, "plugin", "marketplace", "add", str(marketplace)], check=True)
    installed = json.loads(subprocess.run(
        [args.claude_bin, "plugin", "list", "--json"],
        check=True, capture_output=True, text=True).stdout)
    action = "update" if any(p["id"] == "research-skills@research-skills" and
                             p["scope"] == "user" for p in installed) else "install"
    subprocess.run([args.claude_bin, "plugin", action, "research-skills@research-skills",
                    "--scope", "user"], check=True)
    subprocess.run([args.claude_bin, "plugin", "details", "research-skills@research-skills"], check=True)
    print("Installed without Ponytail. Start a new Claude Code session.")


if __name__ == "__main__":
    main()
