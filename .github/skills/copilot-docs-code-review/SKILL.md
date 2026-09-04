---
name: copilot-docs-code-review
description: Review documentation pull requests against the Emporix style guide, shared completeness checks, and repo-specific fit rules. Use when reviewing docs PRs, markdown changes, changelog entries, API tutorials, or release notes in Emporix documentation repositories.
---

# Copilot docs code review

Review changed documentation files in this pull request. Post inline PR review comments only — do not edit files.

Use **Balanced** review effort when the PR changes documentation under `content/`, `changelog/`, or tutorial/API reference paths.

## What to review

Review only changed documentation files in the PR diff:
- Markdown pages, changelog entries, release notes, tutorials, and conceptual docs
- OpenAPI or API reference files when they are part of the docs change
- Navigation files (`**/SUMMARY.md`) when pages are added or moved

Skip `.style-guide/`, `.cursor/`, and `.github/skills/`.

If no documentation files changed, post: `No documentation changes detected.`

## Rules to apply

Read and apply:
- `.github/copilot-instructions.md` (if present)
- Path-specific files in `.github/instructions/*.instructions.md` that match changed files
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

## Comment format

Post **one inline comment per distinct issue** on the exact line in the diff.

- Do **not** merge unrelated rules into a single comment (for example, do not combine frontmatter, word choice, and step format in one comment).
- If the same violation type appears on multiple lines, you may note other locations in that comment — but each **violation type** still needs its own comment on the first offending line.

Each comment:
1. States what is wrong and why (one or two sentences)
2. Cites the rule (e.g. `format-and-structure#titles`, `word-choice`, `local-review-checks#release-notes-workflow`)
3. Includes a suggested fix when possible

Example:

```markdown
This heading should use title case per the style guide (`format-and-structure#titles`).

Suggested fix:
#### Creating a Quote
```

For grammar or spelling, show the original and corrected text.

For structural issues (e.g. step format), include a concrete rewrite in the comment — for example GitBook `{% stepper %}` / `{% step %}` with `####` step titles.

## Review completeness

A documentation review is **incomplete** unless you verify every item below for each changed file:

1. Run the matching checklist in `.github/instructions/*.instructions.md` (when present).
2. Run repo-specific checks in `.github/copilot-docs-review/local-review-checks.md` (when present).
3. Run shared checks in [reference.md](reference.md) for the file type (portal page, changelog, release notes, tutorial, OpenAPI).
4. Scan **every changed line** for terms in the Avoid column of `word-choice.md` and for filler phrases in `language-and-tone.md`.

If you found issues in only one or two categories (for example, frontmatter and release date), continue scanning for structure, step format, cross-repo boundaries, heading rules, and language/tone before finishing.

If no issues are found after all checklists pass, one brief comment is enough: `No documentation style issues found in the changed files.`
