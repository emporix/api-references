# Copilot docs code review — shared completeness and fit

Apply these checks to changed files in the PR. Skip sections that do not apply to the file types in the diff.

Complete every applicable checklist section before finishing the review. Post one inline comment per distinct issue.

## General completeness

- Required sections for the doc type are present (introduction, prerequisites, steps, examples, related links as applicable)
- Headings follow the style guide hierarchy and casing rules (see [Headings](#headings))
- Code samples are complete, syntactically valid, and use correct token placeholders (e.g. `{{OAUTH2_ACCESS_TOKEN}}`)
- Links in changed pages resolve to valid targets within the repo or known external URLs
- Cross-references to related docs are present when the topic depends on prior setup or related APIs
- GitBook blocks (`{% hint %}`, `{% stepper %}`, `{% tabs %}`, etc.) are used correctly per `format-and-structure.md`
- Images and diagrams have alt text or captions where required by the style guide
- Navigation entries in `SUMMARY.md` contain only user-facing links — no HTML comments or editor notes

## Frontmatter (user guides and conceptual pages)

When frontmatter is present on a changed page, verify:

- `description` is present, uses one or two full sentences (not a noun phrase), and is at most 200 characters
- `icon` is present and matches a GitBook FontAwesome icon name (`format-and-structure#frontmatter-metadata`, `format-and-structure#page-icons`)
- Descriptions and body text follow `word-choice.md` (including trademarks)

## Headings

- Page title (H1) uses **title case** (`format-and-structure#titles`)
- Section headings use **sentence case**
- Do not use em dashes (`—`) in markdown headings — they break GitBook subsection anchors (`format-and-structure#titles`)
- Do not use `## Step 1 - ...` or similar pseudo-step headings for procedures

## Changelog and release notes

Changelog and release notes use the same GitBook update-block format. Both use `date="RELEASE_DATE"` (never a hard-coded date); a GitHub Action replaces it on merge.

| | Changelog | Release notes |
|--|-----------|---------------|
| Repository | `api-references` | `emporix-documentation-portal` |
| File | `changelog/README.md` | `release-notes/README.md` |
| Template | `.style-guide/templates/changelog.md` | `.style-guide/templates/release-notes.md` |

When either file changes, verify **each new** `{% update %}…{% endupdate %}` block:

- Block is added at the top, just under `{% updates format="full" %}`
- `date="RELEASE_DATE"` — flag any concrete date such as `2026-08-31`
- Existing entries are not modified
- `SUMMARY.md` is not updated
- `tags` includes the correct change-type tag(s)
- Inner sections use `####` headings (not `###`)
- Wording describes customer impact, not internal implementation (microservices, Kafka, Redis, feature flags, ETL, internal class names)

Repo-specific requirements (product area tags, title format, placeholder text, Documentation and links grouping) belong in `.github/copilot-docs-review/local-review-checks.md` and `.github/instructions/*.instructions.md`.

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
- Terminology matches `.style-guide/writing-standards/word-choice.md` on **every changed line**
- Feature names and product terms use approved wording and trademark marks
- Navigation context is sensible (page fits its section; links to parent/child topics where expected)
- Procedures use step format from `format-and-structure.md` when describing sequential actions
- UI element names are **bold** (`format-and-structure#ui-elements`)
- Prefer active voice and direct instructions (`language-and-tone`)
- Service overview pages in the documentation portal link to API tutorials/reference — do not author full API endpoint specs in the portal repo (see `local-review-checks.md`)

## Word-choice checks

Scan every changed line for discouraged terms. Post one comment per discouraged term (violation type) on the first offending line; you may mention additional occurrences in the same comment.

| Avoid | Prefer |
|-------|--------|
| webshop | storefront, frontend (B2B Commerce Frontend context) |
| app user | customer |
| should | must (requirements), can (optional behavior) |
| click | select (generic UI action) |
| whitelist / blacklist | allowlist / blocklist |
| e-mail | email |
| logon (noun) | login or sign-in (noun), log in or sign in (verb) |
| setup (verb) | set up |
| auth | authentication (unless in code identifiers) |
| payload data | payload |
| API's | APIs |
| e-commerce | commerce (context-dependent) |

## Filler and tone

Flag and suggest removal (`language-and-tone`):

- simply, just, easily, obviously
- it is important to note that, please note that
- the user should (prefer direct instructions: "Select **Save**.")

Flag unnecessary passive voice when the actor is known.

## Trademarks

Flag missing marks on product names (`word-choice#trademarks`):

| Name | Required mark |
|------|----------------|
| ACE | ACE<sup>™</sup> |
| Autonomous Commerce Execution | Autonomous Commerce Execution<sup>®</sup> |

Use `<sup>™</sup>` and `<sup>®</sup>` in markdown. Do not trademark **Autonomous Commerce** on its own.

## Structural format

Flag violations of `.style-guide/writing-standards/format-and-structure.md` — for example incorrect heading levels, hint blocks, or step layout.

For sequential instructions, steps must use GitBook `{% stepper %}` blocks with `####` titles inside `{% step %}` (see `format-and-structure#steps`). Flag:

- `## Step 1 - ...` / `## Step 2 - ...` headings
- Bare numbered lists used as the primary procedure format when steps are required
- Inconsistent bullet punctuation within the same list (`format-and-structure#bullet-lists`)

## Cross-repo boundaries

When a portal or conceptual page changes:

- Do not document API endpoints, request/response schemas, or required headers inline — link to `api-references`
- Flag legacy URL patterns such as `developer.emporix.io/docs/content/...`
- Flag repo-relative links in release-notes Documentation and links sections when GitBook or developer portal URLs are expected
