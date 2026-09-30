---
name: code-review
description: Copilot code review for documentation pull requests. Review docs PRs against the Emporix style guide, reader sufficiency, task-fit to the PR description, shared completeness checks, and repo-specific fit rules. Use when reviewing markdown, changelog entries, API tutorials, OpenAPI specs, or release notes.
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
- `.cursor/docs-review/sufficiency-and-fit.md` — reader sufficiency (always) and task-fit (when PR context exists)
- [reference.md](reference.md) — shared completeness, sufficiency, and task-fit checks for this review

If `.github/copilot-docs-review/local-review-checks.md` exists, apply those repo-specific checks too.

Update-block rules for changelog and release notes are in [reference.md](reference.md).

Never invent product facts. If a claim needs confirmation the PR does not provide, comment with `sufficiency#needs-confirmation` or `task-fit#needs-confirmation` instead of guessing.

## Sufficiency and task-fit

Run **reader sufficiency** on every changed docs page (`sufficiency#purpose`, `sufficiency#prerequisites`, `sufficiency#steps`, `sufficiency#supporting`, `sufficiency#coverage`, `sufficiency#clarity`). Ask whether a typical reader can understand the page and complete the task it describes.

Run **task-fit** against this pull request's title, body, linked issues, and changed-file list (`task-fit#acceptance-criteria`, `task-fit#source`, `task-fit#implementation-pr`, `task-fit#scope`). Skip task-fit only when that context is too thin to judge coverage; then post one comment citing `task-fit#insufficient-context` and say what is missing. Do not hunt Jira IDs or unrelated PRs.

## Comment format

Post **one inline comment per distinct issue** on the exact line in the diff.

- Do **not** merge unrelated rules into a single comment (for example, do not combine frontmatter, word choice, and step format in one comment).
- If the same rule is violated on multiple lines, you may note other locations in that comment — but each **distinct rule** still needs its own comment on the first offending line.

Each comment:
1. States what is wrong and why (one or two sentences)
2. Cites the rule (e.g. `format-and-structure#titles`, `sufficiency#prerequisites`, `task-fit#acceptance-criteria`, `word-choice`, `local-review-checks#release-notes-workflow`)
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
4. Run reader sufficiency for each changed page.
5. Run task-fit against the PR description, or post `task-fit#insufficient-context` once if the PR text is too thin.
6. Scan **every changed line** for terms in the Avoid column of `word-choice.md` and for filler phrases in `language-and-tone.md`.

If you found issues in only one or two categories (for example, frontmatter and release date), continue scanning for structure, step format, sufficiency, task-fit, cross-repo boundaries, heading rules, and language/tone before finishing.

If no issues are found after all checklists pass, one brief comment is enough: `No documentation style issues found in the changed files.`
