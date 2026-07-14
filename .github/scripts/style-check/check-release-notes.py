#!/usr/bin/env python3
"""Validate release notes {% update %} blocks against the style-guide template."""

from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent / "lib"))
from validator_utils import Violation, emit, read_file

RELEASE_NOTES_PATH = "content/release-notes/README.md"

CHANGE_TAGS = {
    "new-feature",
    "improvement",
    "major-change",
    "minor-change",
    "deprecated",
}
PRODUCT_TAGS = {
    "ce",
    "vsm",
    "aci",
    "b2b-frontend",
    "partner-library",
    "other",
}
REQUIRED_SECTIONS = [
    "Overview",
    "New features",
    "Fixes and improvements",
    "Known problems",
    "Documentation and links",
]

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


def check_release_notes(path: Path) -> list[Violation]:
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
                    "release_notes_template",
                    rel,
                    line,
                    "Update block must include date and tags attributes.",
                )
            )
            continue

        date_val = tag_match.group("date")
        tags_raw = tag_match.group("tags")
        tags = [t.strip() for t in tags_raw.split(",") if t.strip()]

        if date_val == "RELEASE_DATE":
            pass  # expected for new entries
        elif not re.fullmatch(r"\d{4}-\d{2}-\d{2}", date_val):
            violations.append(
                Violation(
                    "release_notes_template",
                    rel,
                    line,
                    f'Invalid date "{date_val}"; use RELEASE_DATE for new entries.',
                )
            )

        change_tags = [t for t in tags if t in CHANGE_TAGS]
        product_tags = [t for t in tags if t in PRODUCT_TAGS]
        unknown = [t for t in tags if t not in CHANGE_TAGS and t not in PRODUCT_TAGS]

        if not change_tags:
            violations.append(
                Violation(
                    "release_notes_template",
                    rel,
                    line,
                    "Update block must include a change-type tag "
                    "(new-feature, improvement, major-change, minor-change, deprecated).",
                )
            )
        if not product_tags:
            violations.append(
                Violation(
                    "release_notes_template",
                    rel,
                    line,
                    "Update block must include a product-area tag "
                    "(ce, vsm, aci, b2b-frontend, partner-library, other).",
                )
            )
        for tag in unknown:
            violations.append(
                Violation(
                    "release_notes_template",
                    rel,
                    line,
                    f'Unknown tag "{tag}".',
                )
            )

        if date_val == "RELEASE_DATE":
            headings = {h.strip() for h in HEADING_RE.findall(body)}
            for section in REQUIRED_SECTIONS:
                if section not in headings:
                    violations.append(
                        Violation(
                            "release_notes_template",
                            rel,
                            line,
                            f'New entry (RELEASE_DATE) missing required section "#### {section}".',
                        )
                    )

            if not re.search(r"^##\s+\S", body, re.MULTILINE):
                violations.append(
                    Violation(
                        "release_notes_template",
                        rel,
                        line,
                        'New entry must include a "## Title" heading inside the update block.',
                    )
                )

    return violations


def main() -> int:
    files = [Path(f).resolve() for f in sys.argv[1:]]
    violations: list[Violation] = []

    for path in files:
        if path.name == "README.md" and RELEASE_NOTES_PATH in str(path).replace("\\", "/"):
            violations.extend(check_release_notes(path))

    for v in violations:
        emit(v)
    return 1 if violations else 0


if __name__ == "__main__":
    raise SystemExit(main())
