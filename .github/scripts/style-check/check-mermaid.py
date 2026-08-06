#!/usr/bin/env python3
"""Validate Mermaid diagrams use approved Emporix brand colors."""

from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent / "lib"))
from validator_utils import Violation, emit, iter_markdown_files, read_file

# From .style-guide/visuals/diagrams.md brand palette
APPROVED_COLORS = {
    "9CBBE3",
    "FFC128",
    "4C5359",
    "DDE6EE",
    "A1BDDC",
    "F2F6FA",
    "3B73BB",
    "E86C07",
    "FFFFFF",
    "F2FAFE",
    "99ACBC",
    "7B8B99",
}

MERMAID_FENCE_RE = re.compile(r"```mermaid\s*\n(.*?)```", re.DOTALL | re.IGNORECASE)
HEX_COLOR_RE = re.compile(r"#([0-9A-Fa-f]{3,8})\b")


def normalize_hex(color: str) -> str:
    c = color.upper()
    if len(c) == 3:
        c = "".join(ch * 2 for ch in c)
    return c[:6]


def line_number_at(text: str, index: int) -> int:
    return text.count("\n", 0, index) + 1


def check_file(path: Path) -> list[Violation]:
    violations: list[Violation] = []
    rel = str(path)
    text = read_file(path)

    for fence in MERMAID_FENCE_RE.finditer(text):
        block = fence.group(1)
        block_start = fence.start(1)
        for color_match in HEX_COLOR_RE.finditer(block):
            raw = color_match.group(1)
            normalized = normalize_hex(raw)
            if normalized not in APPROVED_COLORS:
                offset = block_start + color_match.start()
                raw_token = f"#{raw}"
                violations.append(
                    Violation(
                        "mermaid_brand",
                        rel,
                        line_number_at(text, offset),
                        f'Non-brand Mermaid color "{raw_token}"; see .style-guide/visuals/diagrams.md.',
                        match=raw_token,
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
