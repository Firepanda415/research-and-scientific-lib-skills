#!/usr/bin/env python3
"""Validate the collection's install paths, skill discovery, and documentation."""

import argparse
import importlib.util
import json
from pathlib import Path
import re
import sys
import tempfile
from urllib.parse import unquote, urlsplit

try:
    import yaml
except ImportError:
    sys.exit("PyYAML missing: install requirements-dev.txt into the interpreter that runs this check")

from package_version import base_version, content_digest

CLAUDE_TOP_LEVEL = {".claude-plugin", "LICENSE.md", "LICENSES", "NOTICE.md", "PONYTAIL-LICENSE",
                    "benchmarks", "hooks", "skills"}


def writing_handler(event):
    return {"type": "command",
            "command": f'node "${{CLAUDE_PLUGIN_ROOT}}/hooks/writing-style-routing.js" {event}',
            "timeout": 5, "statusMessage": "Loading writing requirements..."}


# The writing route is the only hook. Codex keys hook trust by handler position and these fields.
WRITING_HOOKS = {
    "SessionStart": [{"matcher": "startup|resume|clear|compact", "hooks": [writing_handler("SessionStart")]}],
    "SubagentStart": [{"hooks": [writing_handler("SubagentStart")]}],
}
WRITING_HOOK_FILES = {"hooks.json", "writing-style-routing.js"}
# Claude Code keeps only the first 5,000 tokens of an invoked skill after compaction
# (https://code.claude.com/docs/en/skills#skill-content-lifecycle, checked 2026-09-26).
# At about 3.5 English characters per Claude token
# (https://platform.claude.com/docs/en/about-claude/glossary, same date), that is about
# 17,500 characters. The limit leaves about 10% for Markdown and code, which use more
# tokens per character. AGENTS.md records the same limit and sources.
MAX_SKILL_CHARS = 16_000


def relative_links(doc):
    """Yield (link, target) for literal Markdown file links, not code examples or placeholders."""
    prose = re.sub(r"```.*?```", "", doc.read_text(), flags=re.S)
    for link in re.findall(r"\]\(([^\n)]+)\)", prose):
        link = link.strip().strip("<>")
        if "{{" in link or urlsplit(link).scheme or link.startswith("#"):
            continue
        target = unquote(link.split("#", 1)[0])
        if re.fullmatch(r"[A-Z][A-Z0-9_]*", target):
            continue  # Named destinations in the shipped report templates.
        if target:
            yield link, target


def check_claude_staging(root, package, names):
    """Build the Claude package offline and check its contents."""
    spec = importlib.util.spec_from_file_location("install_claude", root / "scripts/install-claude.py")
    installer = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(installer)
    with tempfile.TemporaryDirectory() as temp:
        staged = (Path(temp) / "research-skills").resolve()
        manifest = installer.build_package(package, staged)
        staged_skills = {p.parent.name for p in (staged / "skills").glob("*/SKILL.md")}
        assert staged_skills == names, (
            f"Claude skill set drift: extra {sorted(staged_skills - names)}, "
            f"missing {sorted(names - staged_skills)}")
        top = {p.name for p in staged.iterdir()}
        assert top == CLAUDE_TOP_LEVEL, f"Claude package layout: {sorted(top)}"
        staged_hook_files = {p.name for p in (staged / "hooks").iterdir()}
        assert staged_hook_files == WRITING_HOOK_FILES, f"Claude hook files: {sorted(staged_hook_files)}"
        assert json.loads((staged / "hooks/hooks.json").read_text())["hooks"] == WRITING_HOOKS, (
            "Claude hooks.json must register only the writing route")
        tests = [p.relative_to(staged).as_posix() for p in staged.rglob("*")
                 if p.name == "tests" or re.fullmatch(r"test_.*\.py|.*\.test\.js", p.name)]
        assert not tests, f"tests in the Claude package: {tests}"
        for skill in staged.glob("skills/*/SKILL.md"):
            frontmatter = re.match(r"\A---\n(.*?)\n---(?:\n|$)", skill.read_text(), re.S)[1]
            assert "disable-model-invocation" not in yaml.safe_load(frontmatter), f"explicit-only skill: {skill.parent.name}"
        for doc in staged.rglob("*.md"):
            for link, target in relative_links(doc):
                resolved = (doc.parent / target).resolve()
                assert resolved.is_relative_to(staged) and resolved.exists(), (
                    f"Claude package link escapes or is missing in {doc.relative_to(staged)}: {link}")
        base = base_version(package)
        assert re.fullmatch(re.escape(base) + r"\+claude\.[0-9a-f]{16}", manifest["version"]), manifest["version"]
        assert "ponytail" in manifest["keywords"] and "license" not in manifest
        assert manifest["homepage"] and manifest["repository"]
        return len(staged_skills), len(WRITING_HOOKS), manifest["version"]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--release", action="store_true",
                        help="fail when plugin.json's content version is stale")
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    marketplace = json.loads((root / ".agents/plugins/marketplace.json").read_text())
    assert marketplace["name"] == "research-skills"
    assert len(marketplace["plugins"]) == 1, "the collection must install as one plugin"
    entry = marketplace["plugins"][0]
    package = (root / entry["source"]["path"]).resolve()
    assert package.is_relative_to(root)
    manifest = json.loads((package / ".codex-plugin/plugin.json").read_text())
    assert package.name == entry["name"] == manifest["name"] == "research-skills"
    assert entry["source"]["source"] == "local"
    base = base_version(package)
    node_version = json.loads((package / "package.json").read_text())["version"]
    assert node_version == base, f"package.json version {node_version} differs from plugin.json base {base}"
    skill_root = package / manifest["skills"]
    names = set()
    for skill in sorted(skill_root.glob("*/SKILL.md")):
        text = skill.read_text()
        assert len(text) <= MAX_SKILL_CHARS, (
            f"{skill} has {len(text)} characters, over {MAX_SKILL_CHARS}. Move topic detail to a reference.")
        match = re.match(r"\A---\n(.*?)\n---(?:\n|$)", text, re.S)
        assert match, f"invalid frontmatter: {skill}"
        metadata = yaml.safe_load(match[1])
        name = metadata["name"]
        assert name == skill.parent.name and re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", name)
        assert name not in names and isinstance(metadata["description"], str) and metadata["description"].strip()
        names.add(name)
        ui = skill.parent / "agents/openai.yaml"
        if ui.exists():
            fields = yaml.safe_load(ui.read_text())
            prompt = fields.get("interface", {}).get("default_prompt")
            if prompt:
                assert f"${name}" in prompt, f"stale UI invocation: {ui}"
    assert names and "ponytail" in names and "rethink-design" in names
    for doc in (root / "README.md", root / "README.zh-CN.md"):
        catalog = re.findall(r"\]\(plugins/research-skills/skills/([^/]+)/SKILL.md\)", doc.read_text())
        assert set(catalog) == names and len(catalog) == len(names), f"catalog drift: {doc}"
    for doc in root.rglob("*.md"):
        if ".git" in doc.parts:
            continue
        assert not re.search(r"/Users/[^/]+/|/home/[^/]+/", doc.read_text()), f"machine-specific path: {doc}"
        for link, target in relative_links(doc):
            assert (doc.parent / target).exists(), f"broken link in {doc}: {link}"
    for notice in ("LICENSE.md", "NOTICE.md", "LICENSES/MIT.txt", "PONYTAIL-LICENSE"):
        assert (package / notice).is_file(), f"missing installed notice: {notice}"
    hooks = json.loads((package / "hooks/hooks.json").read_text())["hooks"]
    assert hooks == WRITING_HOOKS, f"hooks.json must register only the writing route: {hooks}"
    hook_files = {p.name for p in (package / "hooks").iterdir() if p.name != ".DS_Store"}
    assert hook_files == WRITING_HOOK_FILES, f"hook files: {sorted(hook_files)}"
    claude_skills, claude_events, claude_version = check_claude_staging(root, package, names)
    expected_version = f"{base}+codex.{content_digest(package)}"
    if manifest["version"] != expected_version:
        message = (f"plugin.json version {manifest['version']} does not match the content version "
                   f"{expected_version}. Before release, run python3 scripts/install-local.py --prepare-only")
        if args.release:
            sys.exit(f"Release check failed: {message}")
        print(f"Warning: {message}")
    print(f"Package OK: {len(names)} skills, both README catalogues, relative links, notices, "
          f"{len(hooks)} hook events (writing route only)")
    print(f"Claude staging OK: {claude_skills} skills, {claude_events} hook events, version {claude_version}")


if __name__ == "__main__":
    main()
