---
applyTo: "changelog/README.md"
---

# Changelog — Copilot review checklist

Apply to every **new** `{% update %}…{% endupdate %}` block. Post **one comment per failed item** on the offending line.

## Where to add entries

All changelog entries go in **`changelog/README.md`**, inside the existing `{% updates format="full" %}` block. Each PR adds a **new** `{% update %}…{% endupdate %}` block — do **not** modify existing entries. Place the new block at the **top** (directly after the opening `{% updates %}` tag).

Do **not** create separate changelog files. Do **not** update `changelog/SUMMARY.md`.

## Update block

- [ ] `date="RELEASE_DATE"` only — never a hard-coded date (`local-review-checks#changelog-workflow`)
- [ ] `tags` includes the correct change-type tag (`new-feature`, `improvement`, `major-change`, `minor-change`, `deprecated`)
- [ ] Block is at the top of `{% updates format="full" %}`; existing entries are not modified

## Title and sections

- [ ] Title is `## {Service Name} - {noun phrase}` — no date prefix, no verbs in the title (`.style-guide/templates/changelog.md`)
- [ ] Inner sections use `####` headings (Overview, New endpoints, Updated endpoints, Deprecated endpoints, Removed endpoints, Known problems)

## Content

- [ ] Overview and endpoint tables describe customer impact — not internal implementation details
- [ ] Endpoint table links use path-based GitBook URLs, not `operationId` anchors
- [ ] Endpoint link text uses gerund form matching the endpoint summary in the API reference
- [ ] Known problems uses the standard placeholder when none apply

## Style reference

For title, overview, endpoint tables, known problems, and hints, follow `.style-guide/templates/changelog.md` and `.github/copilot-docs-review/local-review-checks.md`.