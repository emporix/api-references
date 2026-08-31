---
title: Local Docs Review Checks
---

# Local Docs Review Checks

Repo-specific completeness and fit checks for the **api-references** repository. The shared Copilot skill [`.github/skills/copilot-docs-code-review/`](../skills/copilot-docs-code-review/SKILL.md) applies these checks in addition to the shared style guide and [reference.md](../skills/copilot-docs-code-review/reference.md).

Path-specific checklists live in [`.github/instructions/`](../instructions/) and are referenced from [`.github/copilot-instructions.md`](../copilot-instructions.md).

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
- Endpoint link text uses gerund form matching the endpoint summary in the API reference
- Changelog wording describes customer impact, not internal implementation details
- Removal of previously deprecated endpoints or fields uses `major-change` (not `deprecated`) and follows `.style-guide/templates/changelog.md#removal-of-deprecated-items`

#### Changelog link format and validity

Apply to every markdown link in the **new** `{% update %}…{% endupdate %}` block (endpoint tables, Overview cross-references, removal descriptions, and hint blocks).

**Direct absolute URLs (required)**

- Use full developer-portal URLs starting with `https://developer.emporix.io/` — not relative paths (`/openapi/...`, `/api-references/...`), not repo-internal file paths, and not GitHub raw links
- API reference links: `https://developer.emporix.io/api-references/api-guides/{domain}/{service}/api-reference/{tag-page}#{anchor}`
- Changelog cross-reference links (for example in removal overviews): `https://developer.emporix.io/changelog/...`

Example (correct):

```markdown
[Retrieving import statistics](https://developer.emporix.io/api-references/api-guides/utilities/import-service/api-reference/analytics#get-importtool-tenant-stats)
```

**Path-based anchors (required)**

- Anchor fragments must follow GitBook path-based convention derived from the OpenAPI path and HTTP method — not `operationId` anchors (`#operation/GET-...`)
- Derive the anchor from `{method}-{path-with-braces-as-literal-segments}`: lowercase method, path segments joined with hyphens, `{tenant}` → `tenant`, `{id}` → `id`, etc.
- Example: `GET /importtool/{tenant}/stats` → `#get-importtool-tenant-stats` (see `.style-guide/templates/changelog.md`)

**Link validity checks**

When reviewing a new changelog entry, verify every link:

1. **Format** — Flag links that are relative, missing the `https://developer.emporix.io/` prefix, or use `#operation/` anchors
2. **Target exists** — When the PR also changes the related `api.yml`, cross-check each endpoint link against the spec: confirm the path, method, and OpenAPI `tags` value resolve to the correct `{tag-page}` segment and path-based anchor
3. **Published URL** — When the endpoint is not new in this PR, confirm the full URL matches a live developer-portal page (HTTP 200 or known published path); flag stale paths such as `api-guides-and-references` or other retired URL patterns
4. **Removal entries** — Fully removed endpoints use plain text in the Endpoint column; links to previous documentation in the Description still use direct absolute URLs to the last published page

**Flag as invalid link:** relative URL, `operationId` anchor, mismatched path/method anchor for the cited endpoint, or URL that does not resolve on the developer portal

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
