#!/usr/bin/env python3
"""Print style-check violations with inline source highlights."""

from __future__ import annotations

import os
import sys
from dataclasses import dataclass
from pathlib import Path


@dataclass
class ViolationRecord:
    check: str
    path: Path
    line: int
    span_start: int
    span_end: int
    match: str
    message: str


def use_color() -> bool:
    if os.environ.get("NO_COLOR"):
        return False
    if os.environ.get("STYLE_CHECK_NO_COLOR") == "1":
        return False
    return sys.stdout.isatty()


def c(text: str, code: str, enabled: bool) -> str:
    if not enabled:
        return text
    return f"\033[{code}m{text}\033[0m"


def parse_record(line: str, repo_root: Path) -> ViolationRecord | None:
    parts = line.rstrip("\n").split("\t")
    if len(parts) < 5:
        return None
    check, file_path, line_s, span_start_s, span_end_s, *rest = parts
    if len(rest) == 1:
        match, message = "", rest[0]
    else:
        match, message = rest[0], rest[1]
    path = Path(file_path)
    if not path.is_absolute():
        path = repo_root / path
    return ViolationRecord(
        check=check,
        path=path,
        line=int(line_s or 0),
        span_start=int(span_start_s or 0),
        span_end=int(span_end_s or 0),
        match=match,
        message=message,
    )


def read_line(path: Path, line_no: int) -> str:
    if line_no <= 0 or not path.is_file():
        return ""
    with path.open(encoding="utf-8") as handle:
        for idx, line in enumerate(handle, start=1):
            if idx == line_no:
                return line.rstrip("\n")
    return ""


def highlight_line(text: str, span_start: int, span_end: int, match: str, color: bool) -> tuple[str, str]:
    """Return (display_line, caret_line)."""
    if not text:
        return ("", "")

    start = span_start
    end = span_end
    if match and match in text:
        start = text.index(match)
        end = start + len(match)
    elif start < 0 or end <= start or end > len(text):
        if match:
            start = text.lower().find(match.lower())
            if start >= 0:
                end = start + len(match)
            else:
                start, end = 0, len(text)
        else:
            start, end = 0, len(text)

    caret_pad = " " * start
    caret_len = max(1, end - start)
    caret = caret_pad + ("^" * caret_len)

    if start == 0 and end == len(text):
        display = c(text, "1;31", color)
    else:
        display = (
            text[:start]
            + c(text[start:end], "1;31", color)
            + text[end:]
        )

    return display, c(caret, "1;31", color)


def rel_path(path: Path, repo_root: Path) -> str:
    try:
        return path.resolve().relative_to(repo_root.resolve()).as_posix()
    except ValueError:
        return str(path)


def print_report(records: list[ViolationRecord], repo_root: Path) -> None:
    color = use_color()
    by_file: dict[Path, list[ViolationRecord]] = {}
    for record in records:
        by_file.setdefault(record.path, []).append(record)

    for path in sorted(by_file, key=lambda p: rel_path(p, repo_root)):
        rel = rel_path(path, repo_root)
        file_records = sorted(by_file[path], key=lambda r: (r.line, r.check))

        print(c(f"\n{rel}", "1;4", color))
        print(c("─" * min(72, max(len(rel), 20)), "2", color))

        for record in file_records:
            loc = f"{rel}:{record.line}" if record.line > 0 else rel
            if record.span_start > 0:
                loc = f"{loc}:{record.span_start}"

            header = f"  [{record.check}] {loc}"
            print(c(header, "1;33", color))
            print(f"    {record.message}")

            if record.line > 0:
                source = read_line(record.path, record.line)
                if source:
                    display, caret = highlight_line(
                        source,
                        record.span_start,
                        record.span_end,
                        record.match,
                        color,
                    )
                    line_label = c(f"{record.line:>4} │ ", "2", color)
                    print(f"    {line_label}{display}")
                    if caret:
                        print(f"         {caret}")
            elif color:
                print(c("    (file-level issue — no single line to highlight)", "2", color))
            else:
                print("    (file-level issue — no single line to highlight)")

            link = os.environ.get(f"STYLE_GUIDE_LINK_{record.check}", "")
            if link:
                print(c(f"    → {link}", "2", color))


def main() -> int:
    if len(sys.argv) < 3:
        print("usage: print_report.py REPO_ROOT VIOLATIONS_TSV", file=sys.stderr)
        return 1

    repo_root = Path(sys.argv[1]).resolve()
    violations_file = Path(sys.argv[2])
    if not violations_file.is_file():
        return 0

    records: list[ViolationRecord] = []
    with violations_file.open(encoding="utf-8") as handle:
        for line in handle:
            if not line.strip():
                continue
            record = parse_record(line, repo_root)
            if record:
                records.append(record)

    if not records:
        return 0

    print_report(records, repo_root)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
