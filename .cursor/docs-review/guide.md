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
| [api-references](https://github.com/emporix/api-references) | `.style-guide/`, `.cursor/docs-review/`, `.cursor/skills/` |
| [emporix-documentation-portal](https://github.com/emporix/emporix-documentation-portal) | same |

```text
docs-standards (source of truth)
    │
    ├── split/style-guide      ──►  .style-guide/
    ├── split/docs-review      ──►  .cursor/docs-review/
    └── split/skills           ──►  .cursor/skills/
                                      ├── docs-style-review-subagent/
                                      └── mermaid-brand-diagrams/
```

### What is shared vs local

| Path | Source | Notes |
|------|--------|-------|
| `.style-guide/` | docs-standards | Writing and formatting rules |
| `.cursor/docs-review/` | docs-standards | Self-review prompts and contract |
| `.cursor/skills/docs-style-review-subagent/` | docs-standards | Cursor skill for self-review |
| `.cursor/skills/mermaid-brand-diagrams/` | docs-standards | Cursor skill for Mermaid diagrams |
| `.cursor/rules/` | **local per repo** | Repo-specific Cursor rules (e.g. changelog conventions in api-references) |

**Rule of thumb:** edit shared paths in `docs-standards`. Edit repo-specific paths in the consumer repo.

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

Authors work in `api-references` or `emporix-documentation-portal`. You do **not** run subtree commands.

1. `git pull` to get the latest shared standards
2. Write or update documentation
3. Run docs self-review in Cursor before peer review
4. Fix remaining issues and open a PR

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

### Self-review flow

Two phases. Phase 2 only runs if you confirm.

```text
Phase 1 — Review (readonly)
  │
  ├─ Scans your changed docs against .style-guide/
  ├─ Returns a structured chat report (no file writes)
  └─ Ends with: "Apply auto-fixable fixes?" → reply Yes or No
        │
        ▼
Phase 2 — Apply fixes (optional, on your confirmation)
  │
  ├─ Applies Auto-fixable: yes findings only
  ├─ One edit per fix — Keep or Undo each in Cursor
  └─ Returns "Phase 2 Complete" with remaining manual items
```

#### Phase 1 report

The report includes:

- **Verdict:** `blocked` | `pass-with-warnings` | `pass`
- **Ready for peer review:** `yes` | `no`
- Findings grouped by severity: `critical`, `major`, `minor`
- Every finding at `path/to/file.md:LINE` (or `:START-END` for ranges)
- `Auto-fixable: yes | no` per finding

**Readiness rules:**

| Verdict | Ready for peer review? |
|---------|------------------------|
| Any `critical` finding | **No** — fix first |
| Only `major` / `minor` | Yes (with warnings) |
| No findings | Yes |

#### Phase 1 closing prompt

When auto-fixable findings exist:

```markdown
## Apply auto-fixable fixes?

**N finding(s)** are marked `Auto-fixable: yes` ...

**Reply "Yes"** to apply them in Phase 2 (one edit per fix, Keep/Undo each).

**Reply "No"** to fix everything yourself.
```

#### Phase 2 — if you reply Yes

- Only `Auto-fixable: yes` items are applied (title case, word choice, typos, token placeholders, etc.)
- `Auto-fixable: no` items stay for you to fix manually (structure, missing sections, product judgment)
- You get a **Phase 2 Complete** summary listing what was applied and what still needs your action

#### Author checklist

- [ ] Update docs content
- [ ] Run: `Run docs style self-review for my current changes.`
- [ ] Read all findings (note `file:line` references)
- [ ] Reply **Yes** or **No** to auto-fixable prompt
- [ ] Keep/Undo each proposed edit
- [ ] Fix remaining manual items
- [ ] Re-run self-review after significant changes
- [ ] Open PR when verdict is `pass` or `pass-with-warnings`

### What self-review checks

- Structure and formatting (headings, sections, hints, lists)
- Tone and clarity
- Grammar and spelling
- Word-choice compliance (see `.style-guide/writing-standards/word-choice.md`)
- Changelog / release-notes template conformance (when relevant) — changelog entries go in `changelog/README.md` with `date="RELEASE_DATE"` placeholders
- API tutorial completeness (when relevant)

### Mermaid diagrams skill

The shared **mermaid-brand-diagrams** skill is available automatically in Cursor when you ask for Mermaid diagrams. It enforces brand colors and styles from the style guide.

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
| `split/skills` | `.cursor/skills/` (all shared skills) |

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

# 4) Push consumer repo branches and open PRs there if needed
```

### What each script does

| Script | When to use |
|--------|-------------|
| `bootstrap-subtrees.sh` | First-time setup only (new consumer repo) |
| `refresh-splits.sh` | After every merge to `master` that changes shared content |
| `update-subtrees.sh` | After `refresh-splits.sh` — pulls into api-references and portal |

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
```

Or use `./scripts/bootstrap-subtrees.sh` from `docs-standards`.

### Contribution rules

1. **Never edit shared paths directly in consumer repos** — changes will be overwritten on the next subtree pull.
2. Edit in `docs-standards`, merge to `master`, then run `refresh-splits.sh` + `update-subtrees.sh`.
3. Repo-specific Cursor rules (`.cursor/rules/`) stay in each consumer repo.
4. Do not commit directly to `split/*` branches.

### Troubleshooting

| Problem | Cause | Fix |
|---------|-------|-----|
| `prefix '.cursor/skills' already exists` | Local folder exists before first `subtree add` | `git rm -r .cursor/skills`, remove empty dir, then `subtree add` |
| `can't squash-merge: was never added` | Trying `subtree pull` before first `subtree add` | Run `subtree add` once; `update-subtrees.sh` does this automatically |
| Consumer repo differs from docs-standards | Local edits to shared paths | Revert local edits; pull from docs-standards |
| Self-review not triggered | Skill not loaded | Confirm `.cursor/skills/docs-style-review-subagent/SKILL.md` exists after `git pull` |

### Verifying sync

```bash
# Content parity
diff -qr ~/emporix/docs-standards/.cursor/skills ~/emporix/api-references/.cursor/skills

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
| [workflow.md](workflow.md) | Self-review phase details |
| [review-contract.md](review-contract.md) | Output contract for Phase 1 and Phase 2 |
| [subagent-prompt.md](subagent-prompt.md) | Phase 1 subagent instructions |
| [fix-prompt.md](fix-prompt.md) | Phase 2 fix instructions |
| [../skills/docs-style-review-subagent/SKILL.md](../skills/docs-style-review-subagent/SKILL.md) | Cursor skill entry point |

## Planned: automatic Phase 1 trigger

Phase 3 (not active yet) will auto-run Phase 1 via Cursor hooks when docs files change. Phase 2 will remain author-confirmed. See [workflow.md](workflow.md).
