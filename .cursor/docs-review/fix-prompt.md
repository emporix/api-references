You are applying auto-fixable documentation style fixes confirmed by the author.

## When to run
Only after Phase 1 review is complete and the author confirms they want fixes applied.

## Inputs
- Phase 1 chat report with findings marked `Auto-fixable: yes`
- Original documentation files

## Rules
1. Apply ONLY findings marked `Auto-fixable: yes`.
2. Use one `StrReplace` per fix so each change appears separately in Cursor's Keep/Undo UI.
3. Match `old_string` exactly from the file — include enough context for uniqueness.
4. Replace with the suggested fix text from the Phase 1 report.
5. Do not apply fixes marked `Auto-fixable: no`.
6. Do not add HTML review comments or suggestion blocks to files.
7. Briefly list which fixes you are about to apply before making edits.

## Optional guided structural mode
Use this mode only when the author explicitly confirms they want approved structural suggestions applied.

In guided structural mode:
1. Use only structural findings from Phase 1 that include `Reworked structure suggestion`.
2. Keep those findings as `Auto-fixable: no` in review semantics; this is still author-guided, not automatic.
3. Apply targeted section-level replacements so each structural rewrite appears as a clear Keep/Undo change.
4. Preserve meaning, behavior, and technical facts; rewrite structure/format only.
5. Prefer exact rule-compliant patterns when relevant (for example `{% stepper %}` + `{% step %}` + `####` titles for `format-and-structure#steps`).

## Auto-fixable examples
- Title case: `# bad title` -> `# Good Title`
- Word choice: `click` -> `select`, `auth` -> `authentication`
- Tokens: `REPLACE_ME` -> `{{OAUTH2_ACCESS_TOKEN}}`
- JSON: remove trailing commas, fix malformed fields
- Frontmatter: add missing `description:` line when unambiguous
- Grammar/spelling: typo fixes, punctuation fixes, and clear agreement fixes

## After applying

Return the structured **Phase 2 Complete** summary below. Do not end with a vague one-liner.

Completion rules:
- List every fix that was applied, with `file:line` and rule reference.
- List any `Auto-fixable: yes` finding the author rejected via Keep/Undo under **Fixes skipped/rejected**.
- List **every** remaining author-action item:
  - all Phase 1 findings marked `Auto-fixable: no` not applied in guided structural mode
  - any rejected auto-fixable finding
- Group remaining items by severity (`critical`, `major`, `minor`).
- Keep `file:line` references on all remaining items — never omit line numbers.
- For structural items, include the `Reworked structure suggestion` from Phase 1 when available.
- Restate **Ready for peer review** based on what is still open (`no` if any critical item remains).

Chat report format:

## Phase 2 Complete

**Fixes applied:** N
1. `path/to/file.md:LINE` — rule-reference

**Fixes skipped/rejected:** N
1. `path/to/file.md:LINE` — rule-reference
   - Reason: author rejected via Keep/Undo | not attempted

**Still requires your action:** N

### Critical (N)
1. `path/to/file.md:LINE` — rule-reference
   - Issue: what is wrong and why it matters
   - Suggested fix: replacement text or concrete steps

### Major (N)
...

### Minor (N)
...

**Ready for peer review:** yes | no
**Next step:** Re-run Phase 1 review | Fix remaining issues manually

---

Offer to re-run Phase 1 review to verify.

## Do not
- Batch unrelated fixes into one large edit
- Guess endpoint URLs or product behavior
- Modify files the author did not confirm
