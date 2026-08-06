"""Shared helpers for style-check validators."""

from __future__ import annotations

import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Iterator


@dataclass
class Violation:
    check: str
    path: str
    line: int
    message: str
    match: str = ""
    span_start: int = 0
    span_end: int = 0


def emit(v: Violation) -> None:
    if v.match or v.span_start or v.span_end:
        print(
            f"VIOLATION|{v.check}|{v.path}|{v.line}|{v.span_start}|{v.span_end}|{v.match}|{v.message}",
            flush=True,
        )
    elif v.line > 0:
        print(f"VIOLATION|{v.check}|{v.path}|{v.line}|{v.message}", flush=True)
    else:
        print(f"VIOLATION|{v.check}|{v.path}|0|{v.message}", flush=True)


def parse_frontmatter(text: str) -> tuple[dict[str, str], int]:
    """Return frontmatter key/values and line count of closing ---."""
    if not text.startswith("---"):
        return {}, 0
    match = re.match(r"^---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
    if not match:
        return {}, 0
    body = match.group(1)
    closing_line = body.count("\n") + 2
    data: dict[str, str] = {}
    for line in body.splitlines():
        if ":" not in line:
            continue
        key, _, value = line.partition(":")
        data[key.strip()] = value.strip().strip("'\"")
    return data, closing_line


def read_file(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def iter_markdown_files(paths: list[str]) -> Iterator[Path]:
    for raw in paths:
        p = Path(raw)
        if p.is_file() and p.suffix == ".md":
            yield p.resolve()
