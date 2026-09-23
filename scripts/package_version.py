"""Compute the content version shared by the Codex installer and the package check."""

import hashlib
import json
from pathlib import Path

IGNORED_PARTS = {"__pycache__", "node_modules", ".git"}


def base_version(package):
    """Return the Codex manifest's version without its build suffix."""
    manifest = json.loads((Path(package) / ".codex-plugin/plugin.json").read_text())
    return manifest["version"].split("+", 1)[0]


def content_digest(package):
    """Hash the package files, with the manifest's build suffix removed."""
    package = Path(package)
    manifest_path = package / ".codex-plugin/plugin.json"
    manifest = json.loads(manifest_path.read_text())
    version = manifest["version"].split("+", 1)[0]
    digest = hashlib.sha256()
    for file in sorted(package.rglob("*")):
        if not file.is_file() or IGNORED_PARTS.intersection(file.relative_to(package).parts):
            continue
        if file.name == ".DS_Store" or file.suffix in {".pyc", ".pyo"}:
            continue
        if file == manifest_path:
            content = json.dumps({**manifest, "version": version}, sort_keys=True).encode()
        else:
            content = file.read_bytes()
        digest.update(file.relative_to(package).as_posix().encode() + b"\0")
        digest.update(hashlib.sha256(content).digest())
    return digest.hexdigest()[:16]


def codex_version(package):
    """Return the version string that plugin.json should carry for this content."""
    return f"{base_version(package)}+codex.{content_digest(package)}"
