#!/usr/bin/env python3
"""Report which research-skills skills recent Claude Code and Codex sessions loaded.

The report reads the local transcripts of both hosts, including archived Codex
sessions, and calls no model. A skill counts as loaded when a Skill call names
it or a file read or shell command names its installed SKILL.md. Instructions
that a hook injects do not count. The "named" column counts sessions whose
replies name a skill's SKILL.md, for example when an agent quotes the rule
behind a pause. Maintenance sessions in this repository also name skill files,
so read that column with the project in mind. Use --list to read the start of
each matching session's first prompt and judge individual loads, and --refs to
count reads of a skill's reference files. For a Codex
subagent it shows the parent session's first prompt, because the subagent's
own brief is not stored as a plain message.

--cost estimates, per skill, the tokens that the skill's files brought into the
sessions that read them: the SKILL.md and every reference a session read, each
version of a file once per session, measured on the installed version while it is still in
the plugin cache and on the checkout otherwise. It leaves out the skill
descriptions and hook text that every session carries, and text re-sent on later
requests, so it ranks skills rather than pricing them.

Counts come from tool-call requests, so they do not confirm that a read
succeeded, how much of a file was read, or why. Several reads in one session
count once. Installed paths carry the plugin version, which the report lists.
--plugin-version restricts the counts to sessions that read that version's
files, and leaves out Skill calls, which carry no version.
"""

import argparse
import collections
import functools
import json
import pathlib
import re
import statistics
import time

ROOT = pathlib.Path(__file__).resolve().parents[1]
HOME = pathlib.Path.home()
NAMES = sorted(p.parent.name for p in (ROOT / "plugins/research-skills/skills").glob("*/SKILL.md"))
INSTALLED = re.compile(r"plugins/cache/research-skills/research-skills/([^/\s\"']+)/skills/([a-z0-9-]+)/SKILL\.md")
REFERENCE = re.compile(r"plugins/cache/research-skills/research-skills/([^/\s\"']+)/skills/([a-z0-9-]+)/references/([\w.-]+\.md)")
NAMED = re.compile(r"\b(" + "|".join(map(re.escape, NAMES)) + r")/SKILL\.md")
CLAUDE_READERS = {"Read", "Bash"}
CODEX_CALLS = {"function_call", "custom_tool_call", "local_shell_call"}
CACHES = [HOME / ".claude/plugins/cache/research-skills/research-skills",
          HOME / ".codex/plugins/cache/research-skills/research-skills"]
# --cost converts characters to tokens per host. Claude: about 3.5 English characters
# per token, from https://platform.claude.com/docs/en/about-claude/glossary (checked
# 2026-09-27), the figure AGENTS.md uses for the README estimates. Codex: about 5
# characters per token for this plugin's Markdown, measured from the context growth
# after single-file reads in Codex sessions on 2026-09-27.
CHARS_PER_TOKEN = {"Claude Code": 3.5, "Codex": 5.0}


def entries(path):
    with open(path, errors="ignore") as lines:
        for line in lines:
            try:
                yield json.loads(line)
            except ValueError:
                continue


def text_of(content):
    if isinstance(content, str):
        return content
    return " ".join(block.get("text", "") for block in content or [] if isinstance(block, dict))


def claude_session(path):
    project = path.relative_to(HOME / ".claude/projects").parts[0]
    session = {"subagent": "subagents" in path.parts, "loads": set(), "reads": set(), "refs": set(), "named": set(), "prompt": "",
               "project": project.removeprefix(str(HOME).replace("/", "-") + "-")}
    for entry in entries(path):
        content = (entry.get("message") or {}).get("content")
        if entry.get("type") == "user" and not session["prompt"]:
            session["prompt"] = " ".join(text_of(content).split())
        if entry.get("type") != "assistant" or not isinstance(content, list):
            continue
        for block in content:
            if not isinstance(block, dict):
                continue
            if block.get("type") == "tool_use":
                tool, args = block.get("name"), block.get("input") or {}
                if tool == "Skill":
                    prefix, _, name = str(args.get("skill", "")).rpartition(":")
                    if prefix in ("", "research-skills") and name in NAMES:
                        session["loads"].add(name)
                elif tool in CLAUDE_READERS:
                    session["reads"].update(INSTALLED.findall(json.dumps(args)))
                    session["refs"].update(REFERENCE.findall(json.dumps(args)))
            elif block.get("type") == "text":
                session["named"].update(NAMED.findall(block.get("text", "")))
    return session


def codex_session(path):
    session = {"subagent": False, "loads": set(), "reads": set(), "refs": set(), "named": set(), "prompt": "", "project": ""}
    meta_seen = False
    for entry in entries(path):
        payload = entry.get("payload")
        if not isinstance(payload, dict):
            continue
        if entry.get("type") == "session_meta" and not meta_seen:
            meta_seen = True
            session["project"] = pathlib.Path(payload.get("cwd", "")).name
            session["subagent"] = bool(payload.get("parent_thread_id"))
        if entry.get("type") != "response_item":
            continue
        kind = payload.get("type")
        if kind in CODEX_CALLS:
            call = [payload.get("arguments"), payload.get("input"), payload.get("action")]
            session["reads"].update(INSTALLED.findall(json.dumps(call)))
            session["refs"].update(REFERENCE.findall(json.dumps(call)))
        elif kind == "message":
            text = text_of(payload.get("content"))
            if payload.get("role") == "assistant":
                session["named"].update(NAMED.findall(text))
            elif payload.get("role") == "user" and not session["prompt"] \
                    and "<environment_context>" not in text and "AGENTS.md" not in text[:200]:
                session["prompt"] = ("parent task: " if session["subagent"] else "") + " ".join(text.split())
    return session


@functools.lru_cache(maxsize=None)
def chars(version, relative):
    """Characters of a skill file: the installed version while it is cached, else the checkout's."""
    if version:
        for cache in CACHES:
            path = cache / version / "skills" / relative
            if path.is_file():
                return len(path.read_text(errors="ignore"))
    path = ROOT / "plugins/research-skills/skills" / relative
    return len(path.read_text(errors="ignore")) if path.is_file() else 0


def loaded_chars(session):
    """Characters of each skill's files that a session read, counting each version of a file once."""
    files = {(version, f"{name}/SKILL.md") for version, name in session["reads"]}
    # A Skill call carries no version, so its SKILL.md is measured on the checkout.
    files |= {("", f"{name}/SKILL.md") for name in session["loads"] - {name for _, name in session["reads"]}}
    files |= {(version, f"{skill}/references/{ref}") for version, skill, ref in session["refs"]}
    total = collections.Counter()
    for version, relative in files:
        total[relative.split("/", 1)[0]] += chars(version, relative)
    return total


def recent(roots, cutoff):
    for root in roots:
        if not root.is_dir():
            continue
        for path in root.rglob("*.jsonl"):
            if path.name == "journal.jsonl":
                continue
            try:
                if path.stat().st_mtime >= cutoff:
                    yield path
            except OSError:
                continue


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--days", type=float, default=7, help="look at transcripts modified in this many days (default 7)")
    parser.add_argument("--list", metavar="SKILL", help="list the sessions that loaded SKILL")
    parser.add_argument("--refs", metavar="SKILL", help="count the sessions that read each reference file of SKILL")
    parser.add_argument("--plugin-version", metavar="PREFIX", help="count only reads of installed files whose plugin version starts with PREFIX")
    parser.add_argument("--cost", action="store_true", help="estimate the tokens that each skill's files brought into the sessions that read them")
    args = parser.parse_args()
    cutoff = time.time() - args.days * 86400
    hosts = (("Claude Code", [HOME / ".claude/projects"], claude_session),
             ("Codex", [HOME / ".codex/sessions", HOME / ".codex/archived_sessions"], codex_session))
    for host, roots, read in hosts:
        sessions, versions = [], collections.Counter()
        for path in recent(roots, cutoff):
            try:
                s = read(path)
            except OSError:
                continue
            versions.update({version for version, _ in s["reads"]} | {version for version, _, _ in s["refs"]})
            if args.plugin_version:
                keep = lambda version: version.startswith(args.plugin_version)
                s["reads"] = {(version, name) for version, name in s["reads"] if keep(version)}
                s["refs"] = {(version, skill, ref) for version, skill, ref in s["refs"] if keep(version)}
                s["loads"] = {name for _, name in s["reads"]}
            else:
                s["loads"] |= {name for _, name in s["reads"]}
            sessions.append(s)
        used = [s for s in sessions if s["loads"]]
        print(f"{host}, last {args.days:g} days: {len(sessions)} sessions "
              f"({sum(s['subagent'] for s in sessions)} subagents), {len(used)} loaded a research-skills skill")
        if versions:
            print("  plugin versions read: " + ", ".join(f"{v} ({n} sessions)" for v, n in versions.most_common()))
        loads, named = collections.Counter(), collections.Counter()
        for s in sessions:
            loads.update((name, s["subagent"]) for name in s["loads"])
            named.update(s["named"])
        rows = sorted({name for name, _ in loads} | set(named),
                      key=lambda n: (-(loads[n, False] + loads[n, True]), n))
        if rows:
            print(f"  {'skill':32} {'main':>5} {'subagent':>9} {'named':>6}")
        for name in rows:
            print(f"  {name:32} {loads[name, False]:5d} {loads[name, True]:9d} {named[name]:6d}")
        if args.cost:
            ratio = CHARS_PER_TOKEN[host]
            tokens = collections.defaultdict(list)
            for s in sessions:
                for name, n in loaded_chars(s).items():
                    tokens[name].append(n / ratio)
            print(f"  skill files read, in tokens at about {ratio:g} characters per token:")
            print(f"  {'skill':32} {'sessions':>8} {'per session':>11} {'total':>10}")
            for name in sorted(tokens, key=lambda n: -sum(tokens[n])):
                print(f"  {name:32} {len(tokens[name]):8d} {statistics.mean(tokens[name]):11,.0f} {sum(tokens[name]):10,.0f}")
        if args.refs:
            refs = collections.Counter((ref, s["subagent"]) for s in sessions for ref in {ref for _, skill, ref in s["refs"] if skill == args.refs})
            print(f"  {args.refs} references read, main and subagent sessions:")
            for ref in sorted({ref for ref, _ in refs}):
                print(f"    {ref:30} {refs[ref, False]:5d} {refs[ref, True]:9d}")
        if args.list:
            for s in used:
                if args.list in s["loads"]:
                    kind = "subagent" if s["subagent"] else "main"
                    print(f"    {kind:8} {s['project'][:40]:40} | {s['prompt'][:120]}")
        print()


if __name__ == "__main__":
    main()
