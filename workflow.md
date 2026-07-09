---
title: Docs Self-Review Workflow
---

# Docs Self-Review Workflow

## Overview

Two-phase flow with native Cursor Keep/Undo for fixes:

1. **Review** — readonly chat report (no file changes)
2. **Apply fixes** — optional, on author confirmation via agent edits

## Manual trigger

```
Run docs style self-review for my current changes.
```

## Phase 1 — Review

1. Subagent scans changed docs files against `.style-guide/`.
2. Returns structured chat report with:
   - file path + line reference (required for every finding; use `:LINE` or `:START-END` for ranges)
   - severity, rule, issue, suggested fix
   - `Auto-fixable: yes | no`
   - grammar and spelling findings with corrected text when unambiguous
3. Ends with verdict and readiness.
4. Agent ends with the structured **Apply auto-fixable fixes?** call-to-action (or **Next step** when auto-fixable N = 0).

**No file modifications. No cleanup scripts needed.**

## Phase 2 — Apply fixes (optional)

1. Author confirms: **"Yes"** (in reply to the Phase 1 auto-fixable CTA).
2. Agent applies only `Auto-fixable: yes` findings.
3. One `StrReplace` per fix — each appears in Cursor's diff UI.
4. Author accepts (Keep) or rejects (Undo) each change.
5. Agent returns the structured **Phase 2 Complete** summary:
   - fixes applied (with `file:line`)
   - fixes skipped/rejected (Keep/Undo rejections)
   - still requires your action — all remaining items by severity, with `file:line`, issue, and suggested fix
   - updated **Ready for peer review** verdict
6. Offer to re-run Phase 1 review.

This includes obvious grammar and spelling corrections.

### Phase 2 lanes

- **Obvious fixes lane**: applies only findings marked `Auto-fixable: yes`.
- **Guided structural lane**: runs only after explicit author confirmation, and applies approved structural suggestions from Phase 1 (`Reworked structure suggestion`) as targeted section-level edits.

Structural findings remain `Auto-fixable: no` in Phase 1 even when a concrete rewrite is provided.

### Stepper conversion example

Invalid pattern:

```md
## Step 1 - Open the storefront
...
## Step 2 - Approve the quote
...
```

Compliant rewrite:

```md
{% stepper %}
{% step %}
#### Open the storefront

...
{% endstep %}

{% step %}
#### Approve the quote

...
{% endstep %}
{% endstepper %}
```

## Author checklist

- Update docs content.
- Run manual docs style self-review.
- Read chat report for all findings.
- Confirm whether to apply auto-fixable fixes (reply **"Yes"** or **"No"**).
- Use Keep/Undo on each proposed edit.
- Manually fix remaining non-auto-fixable issues.
- Re-run review after significant changes.
- Submit for peer review when verdict is `pass` or `pass-with-warnings`.

## Hybrid gate rules

- Block only when `critical` findings are present.
- `major` and `minor` findings are warnings in this phase.

## Phase 3 (planned): automatic trigger

After the manual flow is stable, enable automatic Phase 1 review through project hooks. Phase 2 remains author-confirmed.
<!-- This will be added at later stage. -->

### Example hook blueprint (not active yet)

```json
{
  "version": 1,
  "hooks": {
    "stop": [
      {
        "type": "prompt",
        "prompt": "If documentation files changed, run Phase 1 docs style self-review using .cursor/docs-review/subagent-prompt.md and return a chat-only report. End with the Apply auto-fixable fixes? call-to-action."
      }
    ]
  }
}
```
