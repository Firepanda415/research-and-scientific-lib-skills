#!/usr/bin/env python3
"""Refresh the package version and install this checkout through Codex."""

import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys

from package_version import codex_version


def remove_local_junk(package):
    """Delete Finder and Python cache files, which Codex would copy into its plugin cache."""
    junk = [p for p in package.rglob("*")
            if (p.name in {".DS_Store", "__pycache__"} or p.suffix in {".pyc", ".pyo"})
            and "__pycache__" not in p.relative_to(package).parts[:-1]]
    for path in junk:
        if path.is_dir():
            shutil.rmtree(path, ignore_errors=True)
        else:
            path.unlink(missing_ok=True)
    return len(junk)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--prepare-only", action="store_true",
                        help="update the content version without installing")
    parser.add_argument("--codex-bin", default="codex", help="Codex CLI executable")
    args = parser.parse_args()
    codex = None
    if not args.prepare_only:
        codex = shutil.which(args.codex_bin)
        if codex is None:
            sys.exit(f"Codex CLI not found: {args.codex_bin}. Pass --codex-bin /path/to/codex.")
    root = Path(__file__).resolve().parents[1]
    package = root / "plugins/research-skills"
    manifest_path = package / ".codex-plugin/plugin.json"
    manifest = json.loads(manifest_path.read_text())
    manifest["version"] = codex_version(package)
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Prepared research-skills {manifest['version']}", flush=True)
    if codex:
        removed = remove_local_junk(package)
        if removed:
            print(f"Removed {removed} Finder or Python cache entries from the plugin folder.", flush=True)
        subprocess.run([codex, "plugin", "marketplace", "add", str(root)], check=True)
        subprocess.run([codex, "plugin", "add", "research-skills@research-skills"], check=True)
        print("Installed. Open /hooks in the Codex CLI, trust changed research-skills hooks, then start a new task. "
              "Untrusted hooks do not run.")


if __name__ == "__main__":
    main()
