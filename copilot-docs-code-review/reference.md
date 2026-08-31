# Copilot docs code review — shared completeness and fit

Apply these checks to changed files in the PR. Skip sections that do not apply to the file types in the diff.

## General completeness

- Required sections for the doc type are present (introduction, prerequisites, steps, examples, related links as applicable)
- Headings follow the style guide hierarchy and title-case rules
- Code samples are complete, syntactically valid, and use correct token placeholders (e.g. `{{OAUTH2_ACCESS_TOKEN}}`)
- Links in changed pages resolve to valid targets within the repo or known external URLs
- Cross-references to related docs are present when the topic depends on prior setup or related APIs
- GitBook blocks (`{% hint %}`, `{% stepper %}`, `{% tabs %}`, etc.) are used correctly per `format-and-structure.md`
- Images and diagrams have alt text or captions where required by the style guide

## Changelog and release notes

Changelog and release notes use the same GitBook update-block format. Both use `date="RELEASE_DATE"` (never a hard-coded date); a GitHub Action replaces it on merge.

| | Changelog | Release notes |
|--|-----------|---------------|
| Repository | `api-references` | `emporix-documentation-portal` |
| File | `changelog/README.md` | `release-notes/README.md` |
| Template | `.style-guide/templates/changelog.md` | `.style-guide/templates/release-notes.md` |

When either file changes, verify:

- A new `{% update date="RELEASE_DATE" ... %}…{% endupdate %}` block is added at the top, just under `{% updates format="full" %}`
- Existing entries are not modified
- `SUMMARY.md` is not updated
- Tags and inner content follow the repo's template (changelog: API change tags and endpoint tables; release notes: product area tags such as `ce`, `vsm`, `aci`, and Overview / New features / Fixes and improvements sections)

Repo-specific requirements (for example when a changelog entry is mandatory for an API change, or which product area tag to use) belong in `.github/copilot-docs-review/local-review-checks.md`.

## API tutorials

When tutorial pages change, verify:

- Authentication method is documented (OAuth2 token, API key, or relevant flow)
- Required headers are listed (`Authorization`, `X-Correlation-Id`, `Accept-Language`, etc. as applicable)
- Request and response examples are present and valid
- Base URL and endpoint paths are correct
- Error handling or edge-case behavior is noted when non-obvious
- Prerequisites link to setup or configuration docs when needed

Rule reference: `.style-guide/writing-standards/api-tutorials.md`

## API references (OpenAPI)

When OpenAPI or API reference files change, verify:

- Operation summaries use gerund form (e.g. "Retrieving a quote")
- `security` blocks include correct scopes
- Request/response schemas have descriptions and examples where required
- Common parameters (`siteCode`, `Accept-Language`, etc.) are used consistently
- Descriptions follow `.style-guide/writing-standards/api-references.md`
- New endpoints follow the template in `.style-guide/templates/api-reference.md`

## Conceptual and portal pages

When conceptual or product documentation pages change, verify:

- Page purpose is clear in the opening paragraph
- Terminology matches `.style-guide/writing-standards/word-choice.md`
- Feature names and product terms use approved wording
- Navigation context is sensible (page fits its section; links to parent/child topics where expected)
- Procedures use step format from `format-and-structure.md` when describing sequential actions

## Word-choice quick checks

Flag common violations from `.style-guide/writing-standards/word-choice.md`:

| Avoid | Prefer |
|-------|--------|
| click | select |
| auth | authentication |
| webshop | storefront |
| e-commerce | commerce (context-dependent) |
| simply, just, easily | (remove filler) |

## Structural format

Flag violations of `.style-guide/writing-standards/format-and-structure.md` — for example incorrect heading levels, hint blocks, or step layout.

For sequential instructions, steps must use GitBook `{% stepper %}` blocks with `####` titles inside `{% step %}` (see `format-and-structure#steps`). Do not use `## Step 1 - ...` style headings.
