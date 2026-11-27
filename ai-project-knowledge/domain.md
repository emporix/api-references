# Domain: repository vocabulary and invariants

Last scanned: 396b70d7 (2026-11-26)
Sources: `README.md`, `SUMMARY.md`, `.github/copilot-docs-review/local-review-checks.md`, `.style-guide/writing-standards/api-references.md`, `.github/workflows/gitbook-openapi-publish.yml`, `.github/workflows/release-api-files.yaml`, `changelog/README.md`

This repository is the public Emporix API documentation (GitBook space "API
Documentation", published at `https://developer.emporix.io/api-references/`).
It holds no executable product code; its "business logic" is the set of
conventions every docs change must respect.

## Vocabulary

- **Domain category** — top-level folder grouping services (`checkout/`, `orders/`, `utilities/`, …; 17 with specs). Source: repository root, `SUMMARY.md` `## API Guides`.
- **Service folder** — `{domain-category}/{service}/` with `README.md` (overview), optional tutorial pages, and `api-reference/`. Source: `local-review-checks.md` § OpenAPI layout.
- **Spec** — the service's OpenAPI 3.0.0 file `api-reference/api.yml`; the single source of truth for endpoint docs. Source: same.
- **Spec ID** — the GitBook OpenAPI spec name (e.g. `cart-api`) used by `gitbook-openapi-publish.yml` and by the `builtin:openapi` blocks in `SUMMARY.md` / `references-only/SUMMARY.md`.
- **ZIP file name** — the spec's name inside `.gitbook/assets/api-references.zip` (`{service folder without -service}-api.{ext}`). Not always equal to the spec ID (e.g. spec ID `category-api` vs ZIP `category-tree-api.yml`; `customer-tenant-api` vs `customer-api.yml`). Sources: `release-api-files.yaml`, `quickstart/list-of-api-services.md`.
- **Tag page** — each OpenAPI `tags` entry becomes a GitBook sub-page; it is the `{tag-page}` segment of published endpoint URLs. Source: `local-review-checks.md`.
- **Changelog entry** — one `{% update %}…{% endupdate %}` block in `changelog/README.md`. See `modules/changelog.md`.
- **Preview** — functionality not fully operational; marked with a badge + danger hint (whole endpoint) or a bold note (field / value). Source: `api-references.md` § Preview labeling.

## Invariants

- One spec per service; `api-reference/README.md` is a thin GitBook shell with no endpoint text. Exception: Approval Service uses `approval-api-reference/`; invoice, quote and session-context use `api.yaml`. Source: `local-review-checks.md`.
- A spec change visible to API users requires a changelog entry in the same PR; typo-only or tutorial-only changes do not. Source: `local-review-checks.md` § When a changelog entry is required.
- Two ZIP names must never collide; the release workflow fails if they do. Source: `release-api-files.yaml`.
- Release notes do not belong here (they live in `emporix-documentation-portal`); tutorials go in service pages, not in `api-reference/README.md`. Source: `local-review-checks.md` § Audience and scope.
- Specs are only published from `main`; branches and PRs are not visible on the portal. Source: `gitbook-openapi-publish.yml`.

## Deployment Center

`utilities/deployment-center/` holds the Deployment Center API reference
(`api-reference/api.yml`, spec id `deployment-center-api`). The whole service is
in preview status, and the spec depends on #672. It documents tenants, workflows,
packages and versions, jobs (build, preview, push, release, rollback),
installations, available packages and logs. A new service folder like this is a
"new service" change: see `modules/navigation-and-publishing.md`.
