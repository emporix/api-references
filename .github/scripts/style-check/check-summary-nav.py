#!/usr/bin/env python3
"""Validate that pages are linked from the nearest SUMMARY.md navigation file."""

from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent / "lib"))
from validator_utils import Violation, emit, iter_markdown_files, read_file

SKIP_SUFFIXES = {
    "README.md",
    "SUMMARY.md",
}
SKIP_PATH_PARTS = {
    "changelog/changelog.md",
    "content/release-notes/README.md",
}


def find_summary_and_relative(path: Path) -> tuple[Path | None, str | None]:
    """Find closest SUMMARY.md above the file and path relative to its directory."""
    current = path.parent
    repo_root = path
    while repo_root.parent != repo_root:
        repo_root = repo_root.parent

    while True:
        summary = current / "SUMMARY.md"
        if summary.is_file():
            rel = path.relative_to(current).as_posix()
            return summary, rel
        if current == repo_root:
            break
        current = current.parent

    return None, None


def summary_paths(summary_file: Path) -> set[str]:
    text = read_file(summary_file)
    paths: set[str] = set()
    for match in re.finditer(r"\]\(([^)]+\.md)\)", text):
        ref = match.group(1).split("#", 1)[0]
        paths.add(ref.lstrip("./"))
    return paths


def should_skip(path: Path) -> bool:
    if path.name in SKIP_SUFFIXES:
        return True
    posix = path.as_posix()
    for skip in SKIP_PATH_PARTS:
        if posix.endswith(skip):
            return True
    if "/.style-guide/" in posix:
        return True
    return False


def repo_relative(path: Path) -> str:
    parts = path.parts
    for marker in ("content", "changelog", ".github"):
        if marker in parts:
            idx = parts.index(marker)
            return str(Path(*parts[idx:]))
    return path.name


def check_file(path: Path) -> list[Violation]:
    violations: list[Violation] = []
    if should_skip(path):
        return violations

    rel = str(path)
    summary, rel_in_nav = find_summary_and_relative(path)
    if summary is None or rel_in_nav is None:
        return violations

    linked = summary_paths(summary)
    summary_rel = repo_relative(summary)
    if rel_in_nav not in linked:
        violations.append(
            Violation(
                "summary_nav",
                rel,
                0,
                f"Page not listed in {summary_rel}. Add a link to '{rel_in_nav}'.",
            )
        )
    return violations


def main() -> int:
    files = sys.argv[1:]
    if not files:
        return 0

    violations: list[Violation] = []
    for path in iter_markdown_files(files):
        violations.extend(check_file(path))

    for v in violations:
        emit(v)
    return 1 if violations else 0


if __name__ == "__main__":
    raise SystemExit(main())
