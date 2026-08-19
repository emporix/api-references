#!/usr/bin/env python3
"""Validate {% step %} blocks use #### for step titles, not ###."""

from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent / "lib"))
from validator_utils import Violation, emit, iter_markdown_files, read_file

STEP_BLOCK_RE = re.compile(
    r"\{%\s*step\s*%\}(.*?)\{%\s*endstep\s*%\}",
    re.DOTALL | re.IGNORECASE,
)
H3_IN_STEP_RE = re.compile(r"^###\s+.+$", re.MULTILINE)


def line_number_at(text: str, index: int) -> int:
    return text.count("\n", 0, index) + 1


def check_file(path: Path) -> list[Violation]:
    violations: list[Violation] = []
    rel = str(path)
    text = read_file(path)

    for step_match in STEP_BLOCK_RE.finditer(text):
        body = step_match.group(1)
        body_start = step_match.start(1)
        for h3 in H3_IN_STEP_RE.finditer(body):
            offset = body_start + h3.start()
            violations.append(
                Violation(
                    "step_headings",
                    rel,
                    line_number_at(text, offset),
                    "Use #### for step titles inside {% step %} blocks, not ###.",
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
