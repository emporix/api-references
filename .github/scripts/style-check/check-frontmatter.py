#!/usr/bin/env python3
"""Validate user guide frontmatter (description, icon)."""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent / "lib"))
from validator_utils import Violation, emit, iter_markdown_files, parse_frontmatter, read_file


def check_file(path: Path) -> list[Violation]:
    violations: list[Violation] = []
    rel = str(path)
    text = read_file(path)
    fm, _ = parse_frontmatter(text)
    if not fm:
        return violations

    guide = fm.get("guide", "").lower()
    if guide not in ("true", "yes", "1"):
        return violations

    description = fm.get("description", "")
    if not description:
        violations.append(
            Violation(
                "frontmatter",
                rel,
                1,
                "User guide page (guide: true) must include a description in frontmatter.",
            )
        )
    else:
        if len(description) > 200:
            violations.append(
                Violation(
                    "frontmatter",
                    rel,
                    1,
                    f"Description exceeds 200 characters ({len(description)}).",
                )
            )
        if not description.endswith((".", "!", "?")):
            violations.append(
                Violation(
                    "frontmatter",
                    rel,
                    1,
                    "Description should be a full sentence ending with . ! or ?",
                )
            )

    icon = fm.get("icon", "")
    if not icon:
        violations.append(
            Violation(
                "frontmatter",
                rel,
                1,
                "User guide page (guide: true) must include an icon in frontmatter.",
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
