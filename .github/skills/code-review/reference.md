# Copilot docs code review — shared completeness, sufficiency, and fit

Apply these checks to changed files in the PR. Skip sections that do not apply to the file types in the diff.

Complete every applicable checklist section before finishing the review. Post one inline comment per distinct issue. Never invent product facts.

## General completeness

- Required sections for the doc type are present (introduction, prerequisites, steps, examples, related links as applicable)
- Headings follow the style guide hierarchy and casing rules (see [Headings](#headings))
- Code samples are complete, syntactically valid, and use correct token placeholders (e.g. `{{OAUTH2_ACCESS_TOKEN}}`)
- Links in changed pages resolve to valid targets within the repo or known external URLs
- Cross-references to related docs are present when the topic depends on prior setup or related APIs
- GitBook blocks (`{% hint %}`, `{% stepper %}`, `{% tabs %}`, etc.) are used correctly per `format-and-structure.md`
- Images and diagrams have alt text or captions where required by the style guide
- Navigation entries in `SUMMARY.md` contain only user-facing links — no HTML comments or editor notes

## Reader sufficiency (always)

Run this lane on every changed documentation page, even when the PR description is thin. Ask whether a typical docs reader can understand the page and complete the task it describes. Cite `sufficiency#...` on each comment. Full checklist: `.cursor/docs-review/sufficiency-and-fit.md`.

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
- Step **markup** still follows `format-and-structure#steps`; this lane is about missing or incomplete actions.

### Supporting pieces (`sufficiency#supporting`)
- Examples, request/response samples, or related links are present when the topic needs them to be usable.
- Do not require extras that the doc type does not need.

### Coverage (`sufficiency#coverage`)
- Coverage matches the topic implied by the title (and by the PR, when task-fit runs).
- Flag both under-coverage (the reader cannot do the thing) and stuffing unrelated material.

### Understandability (`sufficiency#clarity`)
- Ambiguous steps, unspecified actors, or unexplained outcomes are flagged.
- Prefer comments that name what the reader still cannot do or cannot tell.

If a claim needs product confirmation the PR does not provide, comment with `sufficiency#needs-confirmation` instead of guessing.

## Task-fit (when PR context exists)

Use this pull request as task context: title, body, linked issues, and changed-file list. Do not hunt Jira IDs or unrelated PRs.

Skip the rest of this lane only when that text is too thin to judge coverage. Then post **one** comment citing `task-fit#insufficient-context` and say what input would unblock the check.

When context is usable, check that the docs satisfy the request. Cite `task-fit#...` on each comment.

### Acceptance criteria (`task-fit#acceptance-criteria`)
- Requested topics and AC items in the PR/issue are covered, or the docs explicitly mark them out of scope.
- Flag AC items that are missing with no explanation.

### Source of truth (`task-fit#source`)
- Documented behavior does not contradict the PR or linked issue.
- Do not treat silence in the docs as a contradiction unless the source required that behavior to be documented.

### Implementation PRs (`task-fit#implementation-pr`)
- Compare against PR title, body, and changed-file list — not a full code re-review.
- Flag docs that omit user-facing behavior implied by the PR, or that describe behavior the PR does not support.

### Scope (`task-fit#scope`)
- Flag under-scoping (task not satisfied) and over-scoping (material the request did not ask for, if it confuses the page).
- Flag unverifiable claims that go beyond the provided sources.

If a URL in the PR cannot be fetched, comment with `task-fit#unfetched-source`. If a claim needs product confirmation the sources do not provide, comment with `task-fit#needs-confirmation`.

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

Scan every changed line for discouraged terms. Post one comment per discouraged term (distinct rule) on the first offending line; you may mention additional occurrences in the same comment.

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
