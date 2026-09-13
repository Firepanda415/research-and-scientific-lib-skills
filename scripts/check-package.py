#!/usr/bin/env python3
"""Validate the collection's install paths, skill discovery, and documentation."""

import json
from pathlib import Path
import re
from urllib.parse import unquote, urlsplit

import yaml


def main():
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
    skill_root = package / manifest["skills"]
    names = set()
    for skill in sorted(skill_root.glob("*/SKILL.md")):
        match = re.match(r"\A---\n(.*?)\n---(?:\n|$)", skill.read_text(), re.S)
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
    assert names and "ponytail" in names and "rethink-design" in names and "geju" not in names
    for doc in (root / "README.md", root / "README.zh-CN.md"):
        catalog = re.findall(r"\]\(plugins/research-skills/skills/([^/]+)/SKILL.md\)", doc.read_text())
        assert set(catalog) == names and len(catalog) == len(names), f"catalog drift: {doc}"
    for doc in root.rglob("*.md"):
        if ".git" in doc.parts:
            continue
        text = doc.read_text()
        assert not re.search(r"/Users/[^/]+/|/home/[^/]+/", text), f"machine-specific path: {doc}"
        # Check literal Markdown file links, not code examples or template placeholders.
        prose = re.sub(r"```.*?```", "", text, flags=re.S)
        for link in re.findall(r"\]\(([^\n)]+)\)", prose):
            link = link.strip().strip("<>")
            if "{{" in link or urlsplit(link).scheme or link.startswith("#"):
                continue
            target = unquote(link.split("#", 1)[0])
            if re.fullmatch(r"[A-Z][A-Z0-9_]*", target):
                continue  # Named destinations in the shipped report templates.
            if target:
                assert (doc.parent / target).exists(), f"broken link in {doc}: {link}"
    for notice in ("LICENSE.md", "NOTICE.md", "LICENSES/MIT.txt", "PONYTAIL-LICENSE"):
        assert (package / notice).is_file(), f"missing installed notice: {notice}"
    hooks = json.loads((package / "hooks/hooks.json").read_text())["hooks"]
    assert set(hooks) == {"SessionStart", "SubagentStart", "UserPromptSubmit"}
    for groups in hooks.values():
        for group in groups:
            for hook in group["hooks"]:
                command = hook["command"]
                match = re.fullmatch(r'node "\$\{(?:CLAUDE_)?PLUGIN_ROOT\}/(hooks/[\w.-]+\.js)"', command)
                assert match and (package / match[1]).is_file(), f"invalid hook target: {command}"
    print(f"Package OK: {len(names)} skills, both README catalogues, relative links, notices, 3 hook events")


if __name__ == "__main__":
    main()
