---
name: docs-style-review-subagent
description: Run a two-phase docs style review — Phase 1 readonly chat report with file/line findings, Phase 2 optional native StrReplace fixes with Keep/Undo on author confirmation.
---

# Docs Style Review Subagent

Use this skill when the user asks to review documentation quality or style compliance before peer review.
This includes also grammar and spelling checks.

## Inputs
- Changed docs files from current working tree/branch.
- Style rules from `.style-guide/`.
- Phase 1: `.cursor/docs-review/subagent-prompt.md`
- Phase 2: `.cursor/docs-review/fix-prompt.md`
- Contract: `.cursor/docs-review/review-contract.md`

## Phase 1 — Review (readonly)
1. Identify changed documentation files (exclude `.style-guide/` and review infra).
2. Launch one `generalPurpose` subagent with `readonly: true`.
3. Pass the review contract and subagent prompt.
4. Subagent returns structured chat report only — no file writes.
5. Every finding must include a file path and line reference in the heading (e.g. `quotes/quote/foo.md:42`). Use a range for multi-line issues (e.g. `:42-58`). Never omit line numbers.
6. For structural findings (`Auto-fixable: no`), require a concrete `Reworked structure suggestion` blueprint (for example GitBook `{% stepper %}`/`{% step %}` with `####` step titles for step-format issues).
7. Before presenting the report, verify every finding heading matches `path/to/file.md:LINE` (or `:START-END`). If any finding lacks a line reference, ask the subagent to re-run with line numbers filled in.
8. Parent agent presents the report and ends with the structured **Apply auto-fixable fixes?** call-to-action from `subagent-prompt.md` (use **Next step** when auto-fixable N = 0).

## Phase 2 — Apply fixes (on confirmation)
1. Wait for explicit author confirmation: **"Yes"** in reply to the Phase 1 auto-fixable CTA (longer phrases are also accepted).
2. Apply only findings marked `Auto-fixable: yes`.
3. Use one `StrReplace` per fix (native Keep/Undo per change).
4. Follow `.cursor/docs-review/fix-prompt.md`.
5. End with the structured **Phase 2 Complete** summary from `fix-prompt.md` — list every applied fix, any skipped/rejected fix, and all remaining author-action items with `file:line` references.
6. Restate peer-review readiness based on what is still open.
7. Offer to re-run Phase 1 review.

Optional guided structural lane:
- If author explicitly confirms, apply approved structural suggestions from Phase 1 as targeted section-level edits.
- Keep structural findings classified as `Auto-fixable: no`; this lane is guided, not automatic.

Grammar and spelling corrections are included in Phase 2 when they are unambiguous.

## Gating behavior
- `critical` findings block readiness for peer review.
- `major` and `minor` findings are warnings in phase 1.

## Manual trigger phrase
- `Run docs style self-review for my current changes.`
