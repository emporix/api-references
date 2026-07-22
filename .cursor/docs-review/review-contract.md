---
title: Docs Style Review Contract
---

# Docs Style Review Contract

## Purpose
Review updated or newly added documentation against the project style guide and return actionable guidance before peer review.

## Two-phase flow

1. **Phase 1 — Review (readonly):** Chat-only structured report. No file writes.
2. **Phase 2 — Apply fixes (optional):** On author confirmation (`Yes`), apply auto-fixable findings via agent `StrReplace` edits (native Keep/Undo).

## Manual trigger
Run this review only when the author explicitly asks for it in chat.

Suggested trigger phrase:
- `Run docs style self-review for my current changes.`

## Input scope
- Include only changed documentation files from the current branch/working tree.
- Exclude style-guide sources in `.style-guide/` from being reviewed as target content.
- Exclude review infrastructure files (`.cursor/docs-review/`, `.cursor/skills/docs-style-review-subagent/`).
- Prioritize markdown pages, changelog entries, release notes, and tutorial pages.

## Rule sources
- `.style-guide/README.md`
- `.style-guide/writing-standards/format-and-structure.md`
- `.style-guide/writing-standards/language-and-tone.md`
- `.style-guide/writing-standards/word-choice.md`
- `.style-guide/writing-standards/api-tutorials.md`
- `.style-guide/writing-standards/api-references.md`
- `.style-guide/templates/changelog.md`
- `.style-guide/templates/release-notes.md`
- `.style-guide/templates/api-reference.md`

## Required checks
- Structure and formatting (headings, sections, hints, list style).
- Tone and clarity (active voice preference, concise instructions).
- Grammar and spelling (typos, subject-verb agreement, punctuation, malformed phrasing).
- Terminology and word-choice compliance.
- Template conformance for changelog/release-notes content.
- Changelog location and release-date placeholder when `changelog/` files change: entries go in `changelog/README.md` (not `changelog/changelog.md` or new per-release files); new entries use `{% update date="RELEASE_DATE" ... %}` at the top of the `{% updates %}` block; do not edit existing entries or `changelog/SUMMARY.md`.
- API tutorial completeness when relevant (auth, headers, examples, behavior notes).
- API reference completeness when relevant (OpenAPI structure, gerund summaries, scopes on `security`, schema/example quality, common parameters).

## Severity model (hybrid gate)
- `critical` -> blocks readiness for peer review.
- `major` -> non-blocking, but should be fixed before peer review.
- `minor` -> non-blocking polish recommendation.

## Phase 1 output contract (chat only)

Return a structured chat report. **Do not write to documentation files.**

Each finding must include:
1. File path and line reference (e.g. `path/to/file.md:8` or `path/to/file.md:42-58` for multi-line issues). **Never omit line numbers.**
2. Severity: `critical`, `major`, or `minor`
3. Rule reference (e.g. `format-and-structure#titles`)
4. Issue: what is wrong and why it matters
5. Suggested fix: ready-to-paste replacement text when possible
6. Auto-fixable: `yes` or `no`

For structural findings marked `Auto-fixable: no`, include:
7. Reworked structure suggestion: a concrete block-level rewrite blueprint that follows the applicable style rule and can be copied/adapted directly (for example `{% stepper %}` + `{% step %}` + `####` titles for `format-and-structure#steps`)

Grammar and spelling findings must include the original snippet and corrected snippet in the suggested fix field when auto-fixable.

Report header:
1. `Verdict`: `blocked`, `pass-with-warnings`, or `pass`
2. `Ready for peer review`: `yes` or `no`
3. Counts by severity
4. Count of auto-fixable findings
5. List of reviewed files

End Phase 1 with the structured call-to-action from `subagent-prompt.md` (never a vague one-liner):

- When **auto-fixable N > 0**: use the **Apply auto-fixable fixes?** block — bold count, preview (up to 5 items), reply **"Yes"** or **"No"**, Keep/Undo explanation, and note that `Auto-fixable: no` items are excluded.
- When **auto-fixable N = 0**: use the **Next step** block — manual fixes only, optional guided structural lane phrase.

Phase 2 starts only after the author replies **"Yes"** to the auto-fixable CTA (a longer confirmation phrase is also accepted).

## Phase 2 output contract (on confirmation)

Follow `.cursor/docs-review/fix-prompt.md`:
- Apply only findings marked `Auto-fixable: yes`
- One `StrReplace` per fix (enables per-change Keep/Undo)
- Do not modify files for non-auto-fixable findings

Optional guided structural lane (author-confirmed):
- Allowed only when the author explicitly confirms applying approved structural suggestions from Phase 1.
- Source of truth is the `Reworked structure suggestion` from Phase 1 findings.
- Keep structural findings classified as `Auto-fixable: no` in Phase 1.
- Apply as targeted, reviewable edits per logical section so each change remains clear in Keep/Undo.
- Do not rewrite behavior or product meaning while restructuring format.

After applying fixes, return the structured **Phase 2 Complete** summary (see `fix-prompt.md`). Required sections:

1. **Fixes applied** — every applied fix with `file:line` and rule reference
2. **Fixes skipped/rejected** — any `Auto-fixable: yes` finding not kept (author Undo) or not attempted
3. **Still requires your action** — all remaining items grouped by severity:
   - every Phase 1 finding with `Auto-fixable: no` not resolved in guided structural mode
   - any rejected auto-fixable finding
   - each item must include `file:line`, issue, and suggested fix
4. **Ready for peer review** — restated based on remaining open items (`no` if any critical item remains)
5. **Next step** — re-run Phase 1 review or fix remaining issues manually

Never omit line numbers from remaining items. Offer to re-run Phase 1 review.

## Decision rules
- If any `critical` finding exists -> Verdict `blocked`, Ready `no`
- If only `major`/`minor` findings exist -> Verdict `pass-with-warnings`, Ready `yes`
- If no findings -> Verdict `pass`, Ready `yes`

## Notes

Inline HTML comment annotations are not used in this workflow. Phase 1 is chat-only; Phase 2 uses native agent edits with Keep/Undo.
