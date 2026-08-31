---
name: copilot-docs-code-review
description: Review documentation pull requests against the Emporix style guide, shared completeness checks, and repo-specific fit rules. Use when reviewing docs PRs, markdown changes, changelog entries, API tutorials, or release notes in Emporix documentation repositories.
---

# Copilot docs code review

Review changed documentation files in this pull request. Post inline PR review comments only — do not edit files.

## What to review

Review only changed documentation files in the PR diff:
- Markdown pages, changelog entries, release notes, tutorials, and conceptual docs
- OpenAPI or API reference files when they are part of the docs change

Skip `.style-guide/`, `.cursor/`, and `.github/skills/`.

If no documentation files changed, post: `No documentation changes detected.`

## Rules to apply

Read and apply:
- `.style-guide/README.md`
- `.style-guide/writing-standards/format-and-structure.md`
- `.style-guide/writing-standards/language-and-tone.md`
- `.style-guide/writing-standards/word-choice.md`
- `.style-guide/writing-standards/api-tutorials.md`
- `.style-guide/writing-standards/api-references.md`
- `.style-guide/templates/changelog.md`
- `.style-guide/templates/release-notes.md`
- `.style-guide/templates/api-reference.md`
- [reference.md](reference.md) — shared completeness checks

If `.github/copilot-docs-review/local-review-checks.md` exists, apply those repo-specific checks too.

Update-block rules for changelog and release notes are in [reference.md](reference.md).

Post **one inline comment per issue** on the exact line in the diff.

Each comment:
1. States what is wrong and why (one or two sentences)
2. Cites the rule (e.g. `format-and-structure#titles`)
3. Includes a suggested fix when possible

Example:

```markdown
This heading should use title case per the style guide (`format-and-structure#titles`).

Suggested fix:
#### Creating a Quote
```

For grammar or spelling, show the original and corrected text.

For structural issues (e.g. step format), include a concrete rewrite in the comment — for example GitBook `{% stepper %}` / `{% step %}` with `####` step titles.

If no issues are found, one brief comment is enough: `No documentation style issues found in the changed files.`
