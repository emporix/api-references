# Module: changelog

Last scanned: 396b70d7 (2026-11-26)
Sources: `changelog/README.md`, `changelog/SUMMARY.md`, `changelog/in-progress/in-progress.md`, `.github/instructions/changelog.instructions.md`, `.cursor/rules/changelog-conventions.mdc`, `.style-guide/templates/changelog.md`, `.github/copilot-docs-review/local-review-checks.md`, `.github/workflows/update-changelog-dates.yaml`, `.github/workflows/resolve-changelog-conflicts.yaml`, `.gitbook/tags.yaml`

## Files

- `changelog/README.md` — the current changelog; all entries live inside one `{% updates format="full" %}` block, newest first.
- `changelog/archive/{2022..2025}` — older years. `changelog/in-progress/in-progress.md` — announcements table of upcoming work.
- `changelog/SUMMARY.md` — never updated by an entry PR.

## Entry shape

```markdown
{% update date="RELEASE_DATE" tags="new-feature" %}

## {Service Name} - {noun phrase}

##### Overview
...
##### New endpoints
| Endpoint | Description |
...
##### Known problems

There are no known problems.

{% endupdate %}
```

- Insert directly after `{% updates format="full" %}`; never modify existing entries; no separate files.
- `date="RELEASE_DATE"` always; `update-changelog-dates.yaml` replaces it with the merge date (UTC) via `.github/scripts/replace-release-date.sh` on push to `main`.
- `tags`: `new-feature`, `improvement`, `major-change`, `minor-change`, `deprecated` (colors in `.gitbook/tags.yaml`). Removal of deprecated items is `major-change`.
- Title: no date, no verb.
- Inner headings: `#####` per `.github/instructions/changelog.instructions.md`, `local-review-checks.md`, and existing entries. `.cursor/rules/changelog-conventions.mdc` says `####` — conflicting; `#####` is what the reviewer checks.
- Which section for which spec change: `local-review-checks.md` § When a changelog entry is required (new endpoints → `##### New endpoints`, etc.).

## Links

Absolute developer-portal URLs: `https://developer.emporix.io/api-references/api-guides/{domain}/{service}/api-reference/{tag-page}#{anchor}`. Anchor = lowercase method + path segments joined by hyphens, braces dropped: `GET /importtool/{tenant}/stats` → `#get-importtool-tenant-stats`. Never `#operation/...` anchors or relative paths. Link text matches the operation `summary` (gerund). Source: `local-review-checks.md` § Changelog link format and validity.

## Merge conflicts

`resolve-changelog-conflicts.yaml` auto-resolves `changelog/README.md` conflicts on open PRs (after pushes to `main`, or a `/fix-changelog` comment). It fails when an existing entry was changed. Local: `python3 .github/scripts/resolve-changelog-conflict.py`; tests: `.github/scripts/test-resolve-changelog-conflict.sh`.
