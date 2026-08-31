---
title: Local docs review checks
---

# Local docs review checks

Repo-specific completeness and fit checks for the **api-references** repository. The shared Copilot skill [`.github/skills/copilot-docs-code-review/`](../skills/copilot-docs-code-review/SKILL.md) applies these checks in addition to the shared style guide and [reference.md](../skills/copilot-docs-code-review/reference.md).

---

## Repository

**Repo:** `api-references`

## Purpose

Emporix API reference specifications (OpenAPI), API tutorials, and the API changelog for the developer portal.

## Doc types in this repo

- [x] API reference (OpenAPI)
- [x] API tutorials
- [x] Changelog
- [ ] Release notes (published in `emporix-documentation-portal`)
- [x] Conceptual / product documentation (service README pages)
- [ ] Learning paths / guides

## Repo-specific completeness checks

### Changelog workflow

Apply when `changelog/README.md` changes or when API specs change (see [When a changelog entry is required](#when-a-changelog-entry-is-required)).

- User-visible API changes include a new `{% update %}…{% endupdate %}` block in `changelog/README.md` in the same PR
- Add the new block at the top of `{% updates format="full" %}`, directly after the opening tag
- Use `date="RELEASE_DATE"` in the `{% update %}` tag — never a hard-coded date (`changelog-conventions`, `changelog-release-date.md`)
- Do not modify existing changelog entries
- Do not create separate changelog files
- Do not update `changelog/SUMMARY.md`
- Set change tags on the `{% update %}` block: `new-feature`, `improvement`, `major-change`, `minor-change`, `deprecated`
- Title format: `## {Service Name} - {noun phrase}` — no date prefix, no verbs in the title (`.style-guide/templates/changelog.md`)
- Inner sections use `####` headings: `Overview`, endpoint tables (`New endpoints`, `Updated endpoints`, `Deprecated endpoints`, `Removed endpoints`), and `Known problems`
- Endpoint table links use path-based GitBook URLs, not `operationId` anchors
- Endpoint link text uses gerund form matching the endpoint summary in the API reference
- Changelog wording describes customer impact, not internal implementation details
- Removal of previously deprecated endpoints or fields uses `major-change` (not `deprecated`) and follows `.style-guide/templates/changelog.md#removal-of-deprecated-items`

### OpenAPI layout and structure

There is no top-level `openapi/` directory. Specs live per service:

```text
{domain-category}/{service-name}/
  README.md
  {optional-tutorial}.md
  api-reference/
    README.md          # thin GitBook shell
    api.yml            # OpenAPI 3.0.0 spec (prefer .yml)
```

Exception: Approval Service uses `approval-api-reference/api.yml`. Three legacy services use `api.yaml` instead of `api.yml`.

- One spec per service under `api-reference/` (or `approval-api-reference/`); `api.yml` is the source of truth — endpoint docs are not authored as separate markdown pages
- `api-reference/README.md` is a thin GitBook page shell only; do not add endpoint documentation there
- New services must update `SUMMARY.md`: service README, `api-reference/README.md`, `builtin:openapi` block with a unique spec ID (e.g. `cart-api`), and "View Raw API Specification" link to the raw GitHub file
- Update `quickstart/list-of-api-services.md` when adding a new downloadable service spec
- Required OpenAPI sections: `openapi: 3.0.0`, `info` (`version: ''`), `servers`, `paths`, `components`, `security` (`.style-guide/writing-standards/api-references.md`)
- Path keys include the service prefix and start with `/` (e.g. `/cart/{tenant}/carts`)
- Operation summaries use gerund form (e.g. "Retrieving a quote")
- Scopes are declared on `security` / `securitySchemes` only — do not duplicate them in endpoint descriptions
- Common parameters are defined under `components.parameters` in the same spec file and referenced via `$ref` — do not duplicate inline
- Match existing parameter naming in the service (`trait_*` legacy vs `path_*` / `query_*` / `header_*` from `.style-guide/templates/api.yml`)
- New services: copy the starter from `.style-guide/templates/api.yml` (`.style-guide/templates/api-reference.md`)
- Use `tags` to group complex services — tags become GitBook sub-pages

### When a changelog entry is required

Require a new changelog entry in the same PR when any `**/api-reference/api.y*ml` or `**/approval-api-reference/api.y*ml` file changes:

| Change | Tag | Section |
|--------|-----|---------|
| New endpoints | `new-feature` | `#### New endpoints` |
| Updated schemas, parameters, scopes, or behavior | `improvement` or `minor-change` | `#### Updated endpoints` |
| Deprecation announced | `deprecated` | `#### Deprecated endpoints` |
| Removal of endpoints or fields (especially previously deprecated) | `major-change` | `#### Removed endpoints` or `#### Removed endpoints & fields` per template |

Changelog **not** required for:

- Pure typo or formatting fixes in descriptions with no API surface change
- Docs-only changes to tutorials or service README pages with no spec change

**Flag as missing changelog:** a PR changes any API spec file but does not add a corresponding `{% update %}` block in `changelog/README.md`.

## Repo-specific fit checks

### Audience and scope

- Tutorial content belongs in service tutorial pages (e.g. `{service}/cart.md`), not in `api-reference/README.md`
- Release notes belong in `emporix-documentation-portal`, not in this repository
- Changelog entries describe API changes for integrators; product marketing content belongs in the portal
- Service README pages provide conceptual overview; endpoint detail stays in the OpenAPI spec
