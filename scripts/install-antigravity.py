#!/usr/bin/env python3
"""Install the research-skills plugin, with every skill and always-on routing rules, into Antigravity."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

PACKAGE_FILES = ("LICENSE.md", "NOTICE.md", "PONYTAIL-LICENSE")
PACKAGE_DIRS = ("LICENSES", "benchmarks", "skills")
IGNORE = shutil.ignore_patterns("__pycache__", "*.pyc", ".DS_Store", "test_*.py")
NODE_CANDIDATES = ("node", "/opt/homebrew/bin/node", "/usr/local/bin/node")


def write_json(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2) + "\n")


def find_node():
    for candidate in NODE_CANDIDATES:
        resolved = shutil.which(candidate)
        if resolved:
            return resolved
        if Path(candidate).is_file() and os.access(candidate, os.X_OK):
            return candidate
    sys.exit("Node.js executable not found; install Node.js to render routing rules from writing-style-routing.js.")


def render_routing_rules(source, target_root):
    """Render the writing and scientific-code routing rules with paths pointing to target_root."""
    source, target_root = Path(source).resolve(), Path(target_root).resolve()
    node = find_node()
    raw = subprocess.check_output(
        [node, str(source / "hooks/writing-style-routing.js"), "SessionStart"],
        text=True,
    )
    context = json.loads(raw)["hookSpecificOutput"]["additionalContext"]
    src_prefix = source.as_posix()
    dst_prefix = target_root.as_posix()
    return context.replace(src_prefix, dst_prefix).rstrip() + "\n"


def build_package(source, staged, installed_root=None):
    """Stage the Antigravity plugin from the plugin source and return its manifest."""
    source, staged = Path(source).resolve(), Path(staged).resolve()
    target_root = Path(installed_root).resolve() if installed_root else staged
    for name in PACKAGE_DIRS:
        shutil.copytree(source / name, staged / name, ignore=IGNORE)
    for name in PACKAGE_FILES:
        (staged / name).parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source / name, staged / name)

    rules_path = staged / "rules/AGENTS.md"
    rules_path.parent.mkdir(parents=True, exist_ok=True)
    # Digest content uses a root-neutral placeholder so staging vs installed root hashes match.
    canonical_rules = render_routing_rules(source, Path("/__ANTIGRAVITY_PLUGIN_ROOT__"))
    rules_path.write_text(render_routing_rules(source, target_root))

    digest = hashlib.sha256()
    for file in sorted(staged.rglob("*")):
        if file.is_file():
            rel = file.relative_to(staged).as_posix()
            digest.update(rel.encode() + b"\0")
            payload = canonical_rules.encode() if rel == "rules/AGENTS.md" else file.read_bytes()
            digest.update(hashlib.sha256(payload).digest())

    codex = json.loads((source / ".codex-plugin/plugin.json").read_text())
    interface = codex.get("interface", {})
    manifest = {
        "name": "research-skills",
        "displayName": interface.get("displayName", "Research & Scientific Library Skills"),
        "version": f"{codex['version'].split('+', 1)[0]}+antigravity.{digest.hexdigest()[:16]}",
        "description": codex["description"],
        "author": codex["author"],
        "homepage": codex["homepage"],
        "repository": codex["repository"],
        "suggestedPrompts": interface.get("defaultPrompt", [])[:3],
    }
    write_json(staged / "plugin.json", manifest)
    return manifest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--plugins-dir",
        type=Path,
        default=Path.home() / ".gemini/config/plugins",
        help="Antigravity global plugins directory (default: ~/.gemini/config/plugins)",
    )
    args = parser.parse_args()
    source = Path(__file__).resolve().parents[1] / "plugins/research-skills"
    plugins_dir = args.plugins_dir.expanduser().resolve()
    plugins_dir.mkdir(parents=True, exist_ok=True)
    target = plugins_dir / "research-skills"
    with tempfile.TemporaryDirectory(prefix=".build-research-skills-", dir=plugins_dir) as temp:
        staged = Path(temp) / "research-skills"
        manifest = build_package(source, staged, installed_root=target)
        if target.exists():
            shutil.rmtree(target)
        shutil.move(str(staged), target)
    skill_count = sum(1 for _ in (target / "skills").glob("*/SKILL.md"))
    print(f"Installed Antigravity plugin {manifest['name']} ({manifest['version']}) with {skill_count} skills and rules/AGENTS.md at {target}")
    print("Skills and routing rules take effect automatically from the next turn (manage at customization://research-skills).")


if __name__ == "__main__":
    main()
