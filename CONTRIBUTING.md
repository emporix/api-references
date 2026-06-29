# Contributing — style self-review

Before opening a pull request, run local checks against the [Emporix style guide](.style-guide/README.md):

```bash
# Install Vale (optional, for word-choice checks)
brew install vale

# Check changed docs vs main
./.github/scripts/style-check/run.sh --base origin/main

# Check a single file while drafting (inline highlights)
./.github/scripts/style-check/run.sh path/to/page.md

# Highlights + style-guide links under each violation
./.github/scripts/style-check/run.sh path/to/page.md --verbose
```

| Flag | Effect |
|------|--------|
| `--verbose` | Add style-guide links under each violation |
| `--no-context` | Compact list only (no inline highlights) |
| `--no-color` | Disable ANSI colors in terminal output |

See [`.github/scripts/style-check/README.md`](.github/scripts/style-check/README.md) for full usage, available checks, and configuration.
