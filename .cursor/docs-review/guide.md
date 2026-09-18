---
title: Docs Standards and Self-Review Guide
---

# Docs Standards and Self-Review Guide

This guide explains how shared documentation standards work across Emporix documentation repositories, how to use the docs self-review flow in Cursor, and how maintainers publish updates.

## Who this is for

| Audience | Read |
|----------|------|
| **Authors** | [For authors](#for-authors) — daily workflow, self-review, `git pull` |
| **Maintainers** | [For maintainers](#for-maintainers) — editing standards, propagating updates |

## Architecture overview

Shared content lives in one source repository:

**[docs-standards](https://github.com/emporix/docs-standards)**

It is vendored into consumer repos via **git subtree**:

| Consumer repo | Shared paths |
|---------------|--------------|
| [api-references](https://github.com/emporix/api-references) | `.style-guide/`, `.cursor/docs-review/`, `.cursor/skills/`, `.github/skills/` |
| [emporix-documentation-portal](https://github.com/emporix/emporix-documentation-portal) | same |
| [learning-certification](https://github.com/emporix/learning-certification) | same |

```text
docs-standards (source of truth)
    │
    ├── split/style-guide      ──►  .style-guide/
    ├── split/docs-review      ──►  .cursor/docs-review/
    ├── split/skills           ──►  .cursor/skills/
    │                                 ├── docs-style-review-subagent/
    │                                 └── mermaid-brand-diagrams/
    └── split/github-skills    ──►  .github/skills/
                                      └── copilot-docs-code-review/
```

### What is shared vs local

| Path | Source | Notes |
|------|--------|-------|
| `.style-guide/` | docs-standards | Writing and formatting rules |
| `.cursor/docs-review/` | docs-standards | Self-review prompts and contract |
| `.cursor/skills/docs-style-review-subagent/` | docs-standards | Cursor skill for self-review (before PR) |
| `.cursor/skills/mermaid-brand-diagrams/` | docs-standards | Cursor skill for Mermaid diagrams |
| `.github/skills/copilot-docs-code-review/` | docs-standards | Copilot skill for PR docs review |
| `.cursor/rules/` | **local per repo** | Repo-specific Cursor rules (e.g. changelog conventions in api-references) |
| `.github/copilot-docs-review/local-review-checks.md` | **local per repo** | Repo-specific Copilot review checks |
| `.github/copilot-instructions.md` | **local per repo** | Repo-wide Copilot review behavior (copy from `copilot-instructions.template.md`) |
| `.github/instructions/*.instructions.md` | **local per repo** | Path-specific Copilot checklists (copy from `.github/instructions/*.template.md`) |
| `.github/workflows/` and `.github/scripts/` | **docs-standards only** | Site-ops (Ask AI digest). Not a subtree prefix — listed in `scripts/subtree-paths.sh` as never-split. |

**Rule of thumb:** edit shared paths in `docs-standards`. Edit repo-specific paths in the consumer repo. Site-ops workflows stay in `docs-standards` and are never vendored.

### How to recognize a subtree path

Subtree folders look like normal files. Check git history:

```bash
git log --oneline -3 -- .cursor/skills
```

Subtree imports show commits like:

```text
Merge commit '...' as '.cursor/skills'
Squashed '.cursor/skills/' content from commit ...
```

---

## For authors

### What you need to do

Authors work in `api-references`, `emporix-documentation-portal`, or `learning-certification`. You do **not** run subtree commands.

1. `git pull` to get the latest shared standards
2. Write or update documentation
3. Run docs self-review in Cursor **before** opening a PR
4. Fix remaining issues and open a PR
5. Address GitHub Copilot code review feedback on the PR (style guide + completeness/fit)

### Getting the latest shared standards

```bash
git pull
```

That is all. Maintainers propagate `docs-standards` updates into consumer repos; you receive them on pull.

### Docs self-review — when to use it

Run self-review **before peer review**, after you have finished a meaningful docs change.

**Trigger phrase** (paste into Cursor chat):

```text
Run docs style self-review for my current changes.
```

Similar phrasing also works (for example `run self review on the changes`). Optionally include a task description, acceptance criteria, or a GitHub PR/issue URL in the same chat so the review can check task-fit.

### Self-review flow

One turn: review, apply unambiguous auto-fixes, then report. You Keep or Undo each edit in Cursor. There is no "Reply Yes" gate.

```text
Review (readonly subagent)
  │
  ├─ Scans changed docs against .style-guide/ and sufficiency-and-fit.md
  ├─ Checks task-fit when this chat includes AC, a task description, or a PR/issue URL
  └─ Returns findings (no file writes)
        │
        ▼
Apply (same turn)
  │
  ├─ Applies Auto-fixable: yes findings only
  └─ One edit per fix — Keep or Undo each in Cursor
        │
        ▼
Unified report
  │
  ├─ Applied auto-fixes (what was wrong and what changed)
  ├─ Needs your decision (remaining items)
  └─ Needs more information (when judgment is blocked)
```

#### Report

The report includes:

- **Verdict:** `blocked` | `pass-with-warnings` | `pass` (from remaining items after apply)
- **Ready for peer review:** `yes` | `no`
- **Task context:** none (task-fit skipped) or listed sources
- **Applied auto-fixes** at `path/to/file.md:LINE` with the issue and the change
- **Needs your decision** grouped by severity: `critical`, `major`, `minor`
- **Needs more information** when a source is too thin, a URL could not be fetched, or product confirmation is required

**Readiness rules** (remaining findings after apply):

| Verdict | Ready for peer review? |
|---------|------------------------|
| Any remaining `critical` finding | **No** — fix first |
| Only remaining `major` / `minor` | Yes (with warnings) |
| No remaining findings | Yes |

#### What is applied vs left for you

- `Auto-fixable: yes` items are applied in the same turn (title case, word choice, typos, token placeholders, unambiguous grammar)
- `Auto-fixable: no` items stay for you (structure, missing sections, product judgment, reader sufficiency, task-fit)
- If you want structural rewrites applied, reply to apply the structural suggestions (guided mode; each change still uses Keep/Undo)

#### Author checklist

- [ ] Update docs content
- [ ] Run: `Run docs style self-review for my current changes.` (include AC/task/PR URL in chat when you have them)
- [ ] Read the unified report (note `file:line` references)
- [ ] Keep/Undo each auto-applied edit
- [ ] Fix remaining decision items (and supply more information when asked)
- [ ] Re-run self-review after significant changes
- [ ] Open PR when verdict is `pass` or `pass-with-warnings`

### What self-review checks

- Structure and formatting (headings, sections, hints, lists)
- Tone and clarity
- Grammar and spelling
- Word-choice compliance (see `.style-guide/writing-standards/word-choice.md`)
- Changelog / release-notes template conformance (when relevant) — changelog entries go in `changelog/README.md` with `date="RELEASE_DATE"` placeholders
- API tutorial completeness (when relevant)
- API reference completeness (when relevant) — OpenAPI structure, gerund summaries, scopes on `security`, schema/example quality
- Reader sufficiency (always) — purpose, prerequisites, complete procedures, coverage, understandability
- Task-fit (when this chat includes a task description, AC, or PR/issue URL) — coverage vs the request, no contradictions with the provided source

### Mermaid diagrams skill

The shared **mermaid-brand-diagrams** skill is available automatically in Cursor when you ask for Mermaid diagrams. It enforces brand colors and styles from the style guide.

### Copilot PR docs review

After you open a PR, **GitHub Copilot code review** can apply the shared **copilot-docs-code-review** skill from `.github/skills/copilot-docs-code-review/`. It checks the same style guide as Cursor self-review, plus shared completeness/fit rules and any repo-specific checks in `.github/copilot-docs-review/local-review-checks.md`.

Copilot review runs **after** the PR is open. It does not replace Cursor self-review before peer review.

| | Cursor self-review | Copilot PR review |
|--|-------------------|-------------------|
| When | Before opening PR | After PR is open |
| Location | `.cursor/skills/docs-style-review-subagent/` | `.github/skills/copilot-docs-code-review/` |
| Output | Unified chat report + same-turn auto-fix | PR review comments |
| Local overlay | `.cursor/rules/` | `.github/copilot-docs-review/local-review-checks.md` |

---

## For maintainers

Maintainers edit **docs-standards** and propagate changes to consumer repos.

### Repository layout (docs-standards)

```text
docs-standards/
├── .style-guide/
├── .cursor/
│   ├── docs-review/          ← prompts, contract, this guide
│   └── skills/
│       ├── docs-style-review-subagent/
│       └── mermaid-brand-diagrams/
├── .github/
│   ├── skills/
│   │   └── copilot-docs-code-review/  ← Copilot PR review skill
│   ├── copilot-docs-review/
│   │   └── local-review-checks.template.md  ← template for per-repo review checks
│   ├── copilot-instructions.template.md     ← template for per-repo Copilot instructions
│   └── instructions/                        ← path-specific checklist templates
├── scripts/
│   ├── bootstrap-subtrees.sh  ← first-time setup
│   ├── refresh-splits.sh      ← regenerate split branches
│   └── update-subtrees.sh     ← pull into consumer repos
└── README.md
```

### Split branches (do not PR these)

After merging to `master`, regenerate export branches:

| Branch | Contents |
|--------|----------|
| `split/style-guide` | `.style-guide/` |
| `split/docs-review` | `.cursor/docs-review/` |
| `split/skills` | `.cursor/skills/` (all shared Cursor skills) |
| `split/github-skills` | `.github/skills/` (Copilot PR review skill) |

`split/*` branches are **auto-generated artifacts**. Review changes via PRs to `master` only.

### Publishing an update (standard workflow)

```bash
# 1) Edit docs-standards on a feature branch → PR → merge to master

# 2) Refresh split branches
cd ~/emporix/docs-standards
./scripts/refresh-splits.sh

# 3) Pull into consumer repos
./scripts/update-subtrees.sh

# Or one repo at a time:
./scripts/update-subtrees.sh --repo api-references
./scripts/update-subtrees.sh --repo emporix-documentation-portal
./scripts/update-subtrees.sh --repo learning-certification

# 4) Push consumer repo branches and open PRs there if needed
```

### What each script does

| Script | When to use |
|--------|-------------|
| `bootstrap-subtrees.sh` | First-time setup only (new consumer repo) |
| `refresh-splits.sh` | After every merge to `master` that changes shared content |
| `update-subtrees.sh` | After `refresh-splits.sh` — pulls into api-references, portal, and learning-certification |

Dry-run any script first:

```bash
./scripts/refresh-splits.sh --dry-run
./scripts/update-subtrees.sh --dry-run --repo api-references
```

### First-time subtree setup (new consumer repo)

Remove existing local copies first, then add:

```bash
git remote add docs-standards https://github.com/emporix/docs-standards.git
git fetch docs-standards

git subtree add --prefix=.style-guide docs-standards split/style-guide --squash
git subtree add --prefix=.cursor/docs-review docs-standards split/docs-review --squash
git subtree add --prefix=.cursor/skills docs-standards split/skills --squash
git subtree add --prefix=.github/skills docs-standards split/github-skills --squash
```

Or use `./scripts/bootstrap-subtrees.sh` from `docs-standards`.

### Contribution rules

1. **Never edit shared paths directly in consumer repos** — changes will be overwritten on the next subtree pull.
2. Edit in `docs-standards`, merge to `master`, then run `refresh-splits.sh` + `update-subtrees.sh`.
3. Repo-specific Cursor rules (`.cursor/rules/`) stay in each consumer repo.
4. Repo-specific Copilot review checks (`.github/copilot-docs-review/local-review-checks.md`) stay in each consumer repo. Use [local-review-checks.template.md](../../.github/copilot-docs-review/local-review-checks.template.md) as the starting point.
5. Do not commit directly to `split/*` branches.

### Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `prefix '.cursor/skills' already exists` | Local folder exists before first `subtree add` | `git rm -r .cursor/skills`, remove empty dir, then `subtree add` |
| `can't squash-merge: was never added` | Trying `subtree pull` before first `subtree add` | Run `subtree add` once; `update-subtrees.sh` does this automatically |
| Consumer repo differs from docs-standards | Local edits to shared paths | Revert local edits; pull from docs-standards |
| Self-review not triggered | Skill not loaded | Confirm `.cursor/skills/docs-style-review-subagent/SKILL.md` exists after `git pull` |
| Copilot review ignores style guide | Skill not in consumer repo | Confirm `.github/skills/copilot-docs-code-review/SKILL.md` exists; run `update-subtrees.sh` |

### Verifying sync

```bash
# Content parity
diff -qr ~/emporix/docs-standards/.cursor/skills ~/emporix/api-references/.cursor/skills
diff -qr ~/emporix/docs-standards/.github/skills ~/emporix/api-references/.github/skills

# Subtree pull health
cd ~/emporix/api-references
git fetch docs-standards
git subtree pull --prefix=.cursor/skills docs-standards split/skills --squash
# Expected: "Subtree is already at commit ..."
```

---

## Related files

| File | Purpose |
|------|---------|
| [workflow.md](workflow.md) | Self-review flow details |
| [review-contract.md](review-contract.md) | Output contract for review, apply, and unified report |
| [subagent-prompt.md](subagent-prompt.md) | Readonly subagent instructions |
| [fix-prompt.md](fix-prompt.md) | Same-turn auto-fix instructions |
| [sufficiency-and-fit.md](sufficiency-and-fit.md) | Reader sufficiency and optional task-fit checks |
| [../skills/docs-style-review-subagent/SKILL.md](../skills/docs-style-review-subagent/SKILL.md) | Cursor skill entry point |
| [../../.github/skills/copilot-docs-code-review/SKILL.md](../../.github/skills/copilot-docs-code-review/SKILL.md) | Copilot PR review skill |
| [../../.github/copilot-docs-review/local-review-checks.template.md](../../.github/copilot-docs-review/local-review-checks.template.md) | Template for per-repo Copilot review checks |

## Copilot skill rollout

Roll out the Copilot PR review skill to consumer repos after merging changes to `master` and running `refresh-splits.sh`.

### Rollout order

1. **First:** [api-references](https://github.com/emporix/api-references) and [emporix-documentation-portal](https://github.com/emporix/emporix-documentation-portal)
2. **Later:** [learning-certification](https://github.com/emporix/learning-certification) (same subtree path when ready)

### Steps per consumer repo

```bash
# 1) From docs-standards (after merge + refresh-splits)
./scripts/update-subtrees.sh --repo api-references
./scripts/update-subtrees.sh --repo emporix-documentation-portal

# 2) In each consumer repo: add local review checks (not subtree-managed)
cp .github/copilot-docs-review/local-review-checks.template.md .github/copilot-docs-review/local-review-checks.md
# Edit local-review-checks.md for repo-specific checks (OpenAPI layout, IA, etc.)

# 3) Commit and push the local-review-checks.md in the consumer repo
git add .github/copilot-docs-review/local-review-checks.md
git commit -m "Add local Copilot docs review fit checks"
git push

# 4) Verify on a docs PR that Copilot code review picks up the skill
```

The shared skill at `.github/skills/copilot-docs-code-review/` is vendored via subtree. Only `.github/copilot-docs-review/local-review-checks.md` is maintained locally in each consumer repo.

For learning-certification, repeat the same steps when ready:

```bash
./scripts/update-subtrees.sh --repo learning-certification
```

## Planned: automatic review-only trigger

Not active yet. A future Cursor stop hook may auto-run a **review-only** self-review when docs files change. Hooks must not apply file edits. See [workflow.md](workflow.md).
