#!/usr/bin/env python3
"""Resolve merge conflicts in changelog/README.md.

The resolved file is main's version, unchanged, with the branch's new
{% update %}...{% endupdate %} blocks inserted directly after the opening
{% updates format="full" %} tag, in the order the branch has them.

This only happens when the branch added entries and changed nothing else in
the file. If it also changed, renamed, or removed an existing entry, or changed
text outside the entries, the script stops so nothing from the branch is lost.

Usage:
  # Merge origin/main into the current branch and resolve the changelog:
  python3 .github/scripts/resolve-changelog-conflict.py

  # Resolve the changelog inside a merge, rebase, or cherry-pick already in progress:
  python3 .github/scripts/resolve-changelog-conflict.py --in-merge

Exit codes:
  0  resolved, or nothing to do
  1  error
  2  other files still conflict; the merge is left in progress
  3  the branch changed more than adding entries; the changelog is left with
     its conflict markers for manual review
"""

import argparse
import os
import re
import subprocess
import sys
from collections import Counter

DEFAULT_FILE = "changelog/README.md"
DEFAULT_BASE = "origin/main"

UPDATES_OPEN = re.compile(r"^\{%\s*updates\b.*%\}\s*$")
UPDATE_OPEN = re.compile(r"^\{%\s*update\s.*%\}\s*$")
UPDATE_CLOSE = re.compile(r"^\{%\s*endupdate\s*%\}\s*$")
DATE_ATTR = re.compile(r'date="[^"]*"')


class ResolveError(Exception):
    pass


class AmbiguousError(ResolveError):
    pass


def git(*args, check=True):
    result = subprocess.run(
        ["git", *args], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    if check and result.returncode != 0:
        raise ResolveError(
            "git {} failed:\n{}".format(" ".join(args), result.stderr.strip())
        )
    return result


def show(ref, path):
    result = git("show", "{}:{}".format(ref, path), check=False)
    return result.stdout if result.returncode == 0 else ""


def git_dir_file(name):
    path = git("rev-parse", "--git-path", name).stdout.strip()
    return path if os.path.exists(path) else None


def conflicted_files():
    out = git("diff", "--name-only", "--diff-filter=U").stdout
    return [line for line in out.splitlines() if line]


def parse_blocks(text):
    """Return the list of {% update %} blocks, each as a list of lines."""
    blocks = []
    current = None
    for line in text.splitlines():
        if current is None:
            if UPDATE_OPEN.match(line):
                current = [line]
        else:
            current.append(line)
            if UPDATE_CLOSE.match(line):
                blocks.append(current)
                current = None
    if current is not None:
        raise ResolveError("Unterminated {% update %} block: " + current[0])
    return blocks


def block_key(block):
    lines = [line.rstrip() for line in block]
    lines[0] = DATE_ATTR.sub('date=""', lines[0])
    return "\n".join(lines).strip()


def block_title(block):
    for line in block:
        if line.startswith("## "):
            return line[3:].strip()
    return None


def outside_blocks(text):
    """Return the non-blank lines outside {% update %} blocks."""
    lines = []
    inside = False
    for line in text.splitlines():
        if not inside and UPDATE_OPEN.match(line):
            inside = True
        elif inside and UPDATE_CLOSE.match(line):
            inside = False
        elif not inside and line.strip():
            lines.append(line.rstrip())
    return lines


def resolve_text(base_text, ours_text, theirs_text):
    """Return (resolved_text, inserted_titles).

    Only a branch that added entries, and changed nothing else in the file, is
    resolved automatically. Anything else raises AmbiguousError, because
    rebuilding the file from main would lose the branch's other changes.
    """
    base_blocks = parse_blocks(base_text)
    ours_blocks = parse_blocks(ours_text)

    remaining = Counter(block_key(b) for b in ours_blocks)
    changed = []
    for block in base_blocks:
        key = block_key(block)
        if remaining[key] > 0:
            remaining[key] -= 1
        else:
            changed.append(block_title(block) or block[0])
    if changed:
        raise AmbiguousError(
            "The branch changed, renamed, or removed existing entries: {}.".format(
                ", ".join("'{}'".format(title) for title in changed)
            )
        )
    if outside_blocks(base_text) != outside_blocks(ours_text):
        raise AmbiguousError(
            "The branch changed text outside the entries, such as the front matter "
            "or a heading."
        )

    added = []
    for block in ours_blocks:
        key = block_key(block)
        if remaining[key] > 0:
            remaining[key] -= 1
            added.append(block)
    theirs_keys = {block_key(b) for b in parse_blocks(theirs_text)}
    to_insert = [b for b in added if block_key(b) not in theirs_keys]

    theirs_lines = theirs_text.splitlines()
    anchor = next(
        (i for i, line in enumerate(theirs_lines) if UPDATES_OPEN.match(line)), None
    )
    if anchor is None:
        raise ResolveError('No {% updates format="full" %} tag found on main.')

    inserted = []
    for block in to_insert:
        inserted.extend(["", *block])
    resolved = theirs_lines[: anchor + 1] + inserted + theirs_lines[anchor + 1 :]
    text = "\n".join(resolved)
    if theirs_text.endswith("\n"):
        text += "\n"
    titles = [block_title(b) or b[0] for b in to_insert]
    return text, titles


def operation_refs():
    """Return (ours, theirs, base, kind) for the operation in progress, or None.

    For a merge, "ours" is the branch (HEAD) and "theirs" is main (MERGE_HEAD).
    For a rebase or cherry-pick, HEAD already has main's history, so the commit
    being replayed provides the branch's entries.
    """
    for name in ("REBASE_HEAD", "CHERRY_PICK_HEAD"):
        if git_dir_file(name):
            replayed = git("rev-parse", name).stdout.strip()
            parent = git("rev-parse", replayed + "^", check=False).stdout.strip()
            return replayed, "HEAD", parent, name.split("_")[0].lower()
    if git_dir_file("MERGE_HEAD"):
        base = git("merge-base", "HEAD", "MERGE_HEAD", check=False).stdout.split()
        return "HEAD", "MERGE_HEAD", base[0] if base else "", "merge"
    return None


def resolve_file(path, refs):
    ours, theirs, base, _ = refs
    text, titles = resolve_text(
        show(base, path) if base else "", show(ours, path), show(theirs, path)
    )
    with open(path, "w", encoding="utf-8") as handle:
        handle.write(text)
    git("add", "--", path)
    if titles:
        print("Resolved {} with the branch's entries on top:".format(path))
        for title in titles:
            print("  - " + title)
    else:
        print("Resolved {} by taking main's version (no new branch entries).".format(path))


def finish(kind):
    remaining = conflicted_files()
    if remaining:
        print("Other files still conflict; resolve them by hand:", file=sys.stderr)
        for name in remaining:
            print("  - " + name, file=sys.stderr)
        if "changelog/SUMMARY.md" in remaining:
            print(
                "changelog/SUMMARY.md is not handled by this script.", file=sys.stderr
            )
        return 2
    if kind == "merge":
        git("commit", "--no-edit")
        print("Committed the merge.")
    else:
        print("All conflicts resolved. Continue with: git {} --continue".format(kind))
    return 0


def run_in_merge(path):
    refs = operation_refs()
    if refs is None:
        raise ResolveError("No merge, rebase, or cherry-pick in progress.")
    if path not in conflicted_files():
        print("{} has no conflict; nothing to do.".format(path))
        return 0
    resolve_file(path, refs)
    if conflicted_files():
        return finish(refs[3])
    print("All conflicts resolved. Review, then commit or continue the {}.".format(refs[3]))
    return 0


def run_merge(path, base_ref, skip_clean):
    if operation_refs() is not None:
        raise ResolveError(
            "A merge, rebase, or cherry-pick is already in progress. Use --in-merge."
        )
    if git("status", "--porcelain", "--untracked-files=no").stdout.strip():
        raise ResolveError("Commit or stash your changes first.")

    if "/" in base_ref:
        remote, branch = base_ref.split("/", 1)
        if remote in git("remote").stdout.split():
            git("fetch", remote, branch)

    merge = git("merge", "--no-commit", "--no-ff", base_ref, check=False)
    if operation_refs() is None:
        if merge.returncode != 0:
            raise ResolveError("git merge {} failed:\n{}".format(base_ref, merge.stderr.strip()))
        print(merge.stdout.strip() or "Nothing to merge.")
        return 0

    if path not in conflicted_files():
        if skip_clean:
            git("merge", "--abort")
            print("{} merges cleanly; nothing to do.".format(path))
            return 0
        return finish("merge")

    resolve_file(path, operation_refs())
    return finish("merge")


def main():
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--base", default=DEFAULT_BASE, help="ref to merge (default: origin/main)")
    parser.add_argument("--file", default=DEFAULT_FILE, help="changelog file (default: changelog/README.md)")
    parser.add_argument(
        "--in-merge",
        action="store_true",
        help="only resolve the file inside a merge, rebase, or cherry-pick already in progress",
    )
    parser.add_argument(
        "--skip-clean",
        action="store_true",
        help="abort and do nothing when the changelog merges without a conflict",
    )
    args = parser.parse_args()

    try:
        os.chdir(git("rev-parse", "--show-toplevel").stdout.strip())
        if args.in_merge:
            return run_in_merge(args.file)
        return run_merge(args.file, args.base, args.skip_clean)
    except AmbiguousError as error:
        print("Error: {}".format(error), file=sys.stderr)
        print(
            "{} was left unchanged with its conflict markers. Resolve it by hand, "
            "keeping every entry from main.".format(args.file),
            file=sys.stderr,
        )
        code = 3
    except ResolveError as error:
        print("Error: {}".format(error), file=sys.stderr)
        code = 1
    try:
        refs = operation_refs()
    except ResolveError:
        refs = None
    if refs is not None:
        print("The {} is still in progress.".format(refs[3]), file=sys.stderr)
    return code


if __name__ == "__main__":
    sys.exit(main())
