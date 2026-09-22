---
title: Sufficiency and Task-Fit Checks
---

# Sufficiency and Task-Fit Checks

Use these checks during Cursor docs self-review and GitHub Copilot PR docs review. They complement the style guide. Never invent product facts.

- Cursor self-review: do not auto-apply findings from this file — they are always `Auto-fixable: no`.
- Copilot PR review: post one inline comment per finding; cite `sufficiency#...` or `task-fit#...`. See `.github/skills/code-review/reference.md`.

Rule prefixes:
- Sufficiency: `sufficiency#...`
- Task-fit: `task-fit#...`

## Reader sufficiency (always)

Run this lane even when no task context is provided. Ask whether a typical docs reader can understand the page and complete the task it describes.

### Purpose (`sufficiency#purpose`)
- The opening paragraph states what the page is for.
- Body content matches the title/H1. Flag pages that drift off-topic or never explain the titled subject.

### Audience can follow (`sufficiency#prerequisites`)
- Prerequisites, setup, or prior reading are present when the page depends on them.
- Unexplained concepts, product terms, or UI/API context that a typical reader would need are introduced or linked.
- Missing authentication, environment, or access context is flagged when the procedure requires it.

### Procedures (`sufficiency#steps`)
- Sequential procedures are complete and ordered.
- Flag gaps that would block a reader (missing result of a step, skipped configuration, unspecified where to click or which endpoint to call).
- Step format still follows `format-and-structure#steps`; this lane is about missing or incomplete actions, not only markup.

### Supporting pieces (`sufficiency#supporting`)
- Examples, request/response samples, or related links are present when the topic needs them to be usable.
- Do not require extras that the doc type does not need.

### Coverage (`sufficiency#coverage`)
- Coverage matches the topic implied by the title (and by the task, when task context exists).
- Flag both under-coverage (the reader cannot do the thing) and stuffing unrelated material.

### Understandability (`sufficiency#clarity`)
- Ambiguous steps, unspecified actors, or unexplained outcomes are flagged.
- Prefer findings that name what the reader still cannot do or cannot tell.

Severity guidance:
- `critical` — a reader cannot complete the main task of the page, or the page does not address its titled topic
- `major` — important gaps (missing prerequisites, incomplete procedure, unexplained required concept)
- `minor` — clarity polish that does not block the main task

## Task-fit (only when context exists)

Skip this entire lane when `Task context: none`. Include `Task-fit: skipped` in the Cursor findings payload.

When context is provided, check that the docs satisfy that request.

- Cursor: pasted task description, acceptance criteria, or GitHub PR/issue body and file list in the chat
- Copilot PR review: this pull request's title, body, linked issues, and changed-file list (skip only when that text is too thin; then comment `task-fit#insufficient-context`)

### Acceptance criteria (`task-fit#acceptance-criteria`)
- Requested topics and AC items are covered, or the docs explicitly mark them out of scope.
- Flag AC items that are missing with no explanation.

### Source of truth (`task-fit#source`)
- Documented behavior does not contradict the provided ticket or PR description.
- Do not treat silence in the docs as a contradiction unless the source required that behavior to be documented.

### Implementation PRs (`task-fit#implementation-pr`)
- Compare against PR title, body, and changed-file list — not a full code re-review.
- Flag docs that omit user-facing behavior implied by the PR, or that describe behavior the PR does not support.

### Scope (`task-fit#scope`)
- Flag under-scoping (task not satisfied) and over-scoping (material the request did not ask for, if it confuses the page).
- Flag unverifiable claims that go beyond the provided sources.

Severity guidance:
- `critical` — a stated AC or requested topic is missing, or docs contradict the provided source
- `major` — partial coverage or unclear mapping to the request
- `minor` — extra material or small mismatches that do not block the request

## Needs more information

Emit a finding the parent can list under **Needs more information** when judgment is blocked:

- Acceptance criteria or PR text is too thin to judge coverage (`task-fit#insufficient-context`)
- A URL was given but could not be fetched (`task-fit#unfetched-source`)
- A claim needs product confirmation the sources do not provide (`task-fit#needs-confirmation` or `sufficiency#needs-confirmation`)

Still include `file:line` (anchor to the relevant heading or claim), the lane, and what input would unblock the review.

Do not guess the missing product behavior to fill the gap.
