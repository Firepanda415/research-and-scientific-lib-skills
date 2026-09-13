#!/usr/bin/env python3
"""Refresh the package version and install this checkout through Codex."""

import argparse
import hashlib
import json
from pathlib import Path
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--prepare-only", action="store_true",
                        help="update the content version without installing")
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    package = root / "plugins/research-skills"
    manifest_path = package / ".codex-plugin/plugin.json"
    manifest = json.loads(manifest_path.read_text())
    version = manifest["version"].split("+", 1)[0]
    digest = hashlib.sha256()
    for file in sorted(package.rglob("*")):
        if not file.is_file() or any(part in {"__pycache__", "node_modules", ".git"}
                                     for part in file.relative_to(package).parts):
            continue
        if file.name == ".DS_Store" or file.suffix in {".pyc", ".pyo"}:
            continue
        if file == manifest_path:
            content = json.dumps({**manifest, "version": version}, sort_keys=True).encode()
        else:
            content = file.read_bytes()
        digest.update(file.relative_to(package).as_posix().encode() + b"\0")
        digest.update(hashlib.sha256(content).digest())
    manifest["version"] = f"{version}+codex.{digest.hexdigest()[:16]}"
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Prepared research-skills {manifest['version']}", flush=True)
    if not args.prepare_only:
        subprocess.run(["codex", "plugin", "marketplace", "add", str(root)], check=True)
        subprocess.run(["codex", "plugin", "add", "research-skills@research-skills"], check=True)
        print("Installed. Start a new task; review changed hooks in /hooks if requested.")


if __name__ == "__main__":
    main()
