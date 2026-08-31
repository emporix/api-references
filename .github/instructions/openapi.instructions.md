---
applyTo: "**/api-reference/**"
---

# OpenAPI specs — Copilot review checklist

Apply when `api.yml` or `api.yaml` files change under a service's `api-reference/` directory. Post **one comment per failed item**.

## Structure

- [ ] Spec follows per-service layout in `local-review-checks.md` (one spec per service; `api-reference/README.md` is a thin GitBook shell only)
- [ ] New services update `SUMMARY.md` and `quickstart/list-of-api-services.md` when applicable

## OpenAPI content

- [ ] Operation summaries use gerund form (e.g. "Retrieving a quote") (`api-references.md`)
- [ ] `security` blocks include correct scopes; scopes are not duplicated in endpoint descriptions
- [ ] Common parameters use `$ref` from `components.parameters` — not duplicated inline
- [ ] Required sections present: `openapi: 3.0.0`, `info`, `servers`, `paths`, `components`, `security`
- [ ] Path keys include the service prefix and start with `/`

## Changelog pairing

- [ ] User-visible API changes in `api.yml` include a new changelog entry in `changelog/README.md` in the same PR (`local-review-checks#when-a-changelog-entry-is-required`)
