# Style self-review (local)

Run style-guide checks locally before opening a pull request. Rules are defined in [`.style-guide/`](../../.style-guide/) and configured in [`.github/style-check-config.yaml`](../../style-check-config.yaml).

## Prerequisites

- **Python 3** (for structural checks)
- **Vale** (optional, for word choice and tone): `brew install vale` — [installation docs](https://vale.sh/docs/vale-cli/installation/)

Optional: install the [Vale VS Code/Cursor extension](https://marketplace.visualstudio.com/items?itemName=chrischinchilla.vale-server) for inline hints while editing.

## Commands

From the repository root:

```bash
# Changed markdown vs main (most common before opening a PR)
./.github/scripts/style-check/run.sh --base origin/main

# Staged and unstaged changes only
./.github/scripts/style-check/run.sh --working-tree

# Specific file(s) while drafting
./.github/scripts/style-check/run.sh changelog/changelog.md

# Inline highlights + style-guide links
./.github/scripts/style-check/run.sh path/to/page.md --verbose
```

Exit code `0` means no issues; `1` means violations were found.

By default, each violation shows the **exact source line** with the offending text highlighted and a caret (`^`) underneath. Location headers use `file:line:column` so you can jump from the terminal in most editors.

| Flag | Effect |
|------|--------|
| `--verbose` | Add style-guide links under each violation |
| `--no-context` | Compact list only (no inline highlights) |
| `--no-color` | Disable ANSI colors in terminal output |

## What is checked

| Check | Description |
|-------|-------------|
| `frontmatter` | Pages with `guide: true` need `description` (≤200 chars) and `icon` |
| `summary_nav` | New `.md` pages must be linked from the nearest `SUMMARY.md` |
| `changelog_template` | Draft `{% update %}` blocks in `changelog/changelog.md` |
| `mermaid_brand` | Mermaid diagrams use approved brand colors |
| `step_headings` | `{% step %}` titles use `####`, not `###` |
| `vale_word_choice` | Preferred terminology (see word-choice style guide) |
| `vale_tone` | Filler phrases to avoid |

Enable or disable checks in `.github/style-check-config.yaml`.

## Tests

```bash
.github/scripts/style-check/test-style-check.sh
```

## Future CI

The same `run.sh` script is designed for a future GitHub PR workflow (`--ci` flag). PR automation is not enabled yet.
