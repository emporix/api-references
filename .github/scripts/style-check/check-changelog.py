#!/usr/bin/env python3
"""Validate API changelog {% update %} blocks against the style-guide template."""

from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent / "lib"))
from validator_utils import Violation, emit, read_file

CHANGELOG_PATH = "changelog/changelog.md"

CHANGE_TAGS = {
    "new-feature",
    "improvement",
    "major-change",
    "minor-change",
    "deprecated",
}
REQUIRED_SECTIONS_FOR_NEW = ["Overview", "Known problems"]

UPDATE_BLOCK_RE = re.compile(
    r"\{%\s*update\s+([^%]+)%\}(.*?)\{%\s*endupdate\s*%\}",
    re.DOTALL | re.IGNORECASE,
)
UPDATE_TAG_RE = re.compile(
    r'date\s*=\s*"(?P<date>[^"]+)"\s+tags\s*=\s*"(?P<tags>[^"]+)"',
    re.IGNORECASE,
)
HEADING_RE = re.compile(r"^####\s+(.+?)\s*$", re.MULTILINE)


def line_number_at(text: str, index: int) -> int:
    return text.count("\n", 0, index) + 1


def check_changelog(path: Path) -> list[Violation]:
    violations: list[Violation] = []
    rel = str(path)
    text = read_file(path)

    for block_match in UPDATE_BLOCK_RE.finditer(text):
        tag_attrs = block_match.group(1)
        body = block_match.group(2)
        block_start = block_match.start()
        line = line_number_at(text, block_start)

        tag_match = UPDATE_TAG_RE.search(tag_attrs)
        if not tag_match:
            violations.append(
                Violation(
                    "changelog_template",
                    rel,
                    line,
                    "Update block must include date and tags attributes.",
                )
            )
            continue

        date_val = tag_match.group("date")
        tags_raw = tag_match.group("tags")
        tags = [t.strip() for t in tags_raw.split(",") if t.strip()]

        if date_val != "RELEASE_DATE" and not re.fullmatch(r"\d{4}-\d{2}-\d{2}", date_val):
            violations.append(
                Violation(
                    "changelog_template",
                    rel,
                    line,
                    f'Invalid date "{date_val}"; use RELEASE_DATE for new entries.',
                )
            )

        change_tags = [t for t in tags if t in CHANGE_TAGS]
        unknown = [t for t in tags if t not in CHANGE_TAGS]
        if not change_tags:
            violations.append(
                Violation(
                    "changelog_template",
                    rel,
                    line,
                    "Update block must include a change-type tag.",
                )
            )
        for tag in unknown:
            violations.append(
                Violation(
                    "changelog_template",
                    rel,
                    line,
                    f'Unknown tag "{tag}".',
                )
            )

        if date_val == "RELEASE_DATE":
            headings = {h.strip() for h in HEADING_RE.findall(body)}
            for section in REQUIRED_SECTIONS_FOR_NEW:
                if section not in headings:
                    violations.append(
                        Violation(
                            "changelog_template",
                            rel,
                            line,
                            f'New entry (RELEASE_DATE) missing required section "#### {section}".',
                        )
                    )
            if not re.search(r"^##\s+\S", body, re.MULTILINE):
                violations.append(
                    Violation(
                        "changelog_template",
                        rel,
                        line,
                        'New entry must include a "## Service Name - change" title.',
                    )
                )

    return violations


def main() -> int:
    files = [Path(f).resolve() for f in sys.argv[1:]]
    violations: list[Violation] = []

    for path in files:
        normalized = str(path).replace("\\", "/")
        if path.name == "changelog.md" and CHANGELOG_PATH in normalized:
            violations.extend(check_changelog(path))

    for v in violations:
        emit(v)
    return 1 if violations else 0


if __name__ == "__main__":
    raise SystemExit(main())
