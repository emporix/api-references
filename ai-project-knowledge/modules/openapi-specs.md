# Module: OpenAPI specs (service folders)

Last scanned: 396b70d7 (2026-11-26)
Sources: `.github/copilot-docs-review/local-review-checks.md`, `.github/instructions/openapi.instructions.md`, `.style-guide/writing-standards/api-references.md`, `.style-guide/templates/api.yml`, `.style-guide/templates/api-reference.md`, `checkout/cart/` (sample), `utilities/sequential-id/api-reference/api.yml` (sample)

## Service folder layout

```text
{domain-category}/{service}/
  README.md              # overview, key features (GitBook frontmatter: layout, icon)
  {tutorial}.md          # optional, e.g. checkout/cart/cart.md, wishlist.md
  api-reference/
    README.md            # thin shell: frontmatter + "# API Reference"
    api.yml              # OpenAPI 3.0.0
```

44 specs exist at 396b70d7 (45 once Deployment Center lands) (`find . -name 'api.y*ml' -not -path './.*'`).

## Required top-level sections (in samples: `openapi`, `info`, `tags`, `servers`, `paths`, `components`, `security`)

- `openapi: 3.0.0`
- `info`: `title` (service name), `version: ''` (always empty), `description`, `contact`.
- `servers: - url: 'https://api.emporix.io'` — no trailing slash.
- `paths`: keys quoted, start with `/`, include the service prefix and usually `{tenant}`: `'/cart/{tenant}/carts'`.
- `components`: `schemas`, `parameters`, `responses`, `securitySchemes`.
- `securitySchemes.OAuth2` — `clientCredentials` flow, `tokenUrl: 'https://api.emporix.io/oauth/token'`, scopes `{service}.{scope}: description`.
- Root `security: - OAuth2: []`.

## Each operation

Fields: `summary`, `operationId`, `description`, `parameters`, `security`,
`requestBody` (when applicable), `responses`, optional `tags`.
Source: `api-references.md` § Endpoint definitions.

- `summary` — gerund: "Retrieving all sequence schemas", "Creating a new product".
- `operationId` — `{METHOD}-{path-ish}`; template uses `GET-tenant-products-productId`, older specs use longer forms (`GET-sequential-id-retrieve-tenant-schemas`). Follow the style already used in the spec being edited.
- Operation `security` lists the required scopes (`- OAuth2: [scope]`); scopes are not repeated in `description`.
- Responses reuse `components.responses` via `$ref` (e.g. `trait_yaasAware_400`, `Unauthorized_401` in older specs).
- Parameters: shared ones in `components.parameters` and referenced via `$ref`; naming follows the spec (`trait_*` legacy, `path_*` / `query_*` / `header_*` in the template). Common parameters (`tenant`, `Accept-Language`, `Content-Language`, `sort`, `pageNumber`, `pageSize`, `X-Total-Count`) have prescribed wording in `api-references.md` § Common parameters.
- `tags` group operations into GitBook sub-pages; define them in the top-level `tags` list with a description.
- Examples: inline `example` / named `examples` in request and response content.

## Schema rules (`api-references.md` § Best practices)

- No `allOf` around a single `$ref`.
- Keep sibling properties inside the `allOf` item, not next to it.
- Put `required` inside the object that owns the properties.
- Mixins and IDs: § Mixin schemas, § IDs, § metadata of the same file.

## Preview labeling

Whole endpoint: preview badge image + `{% hint style="danger" %}` at the start of `description`. One field / enum value: bold "is in preview mode" note in that field's description, no badge. Source: `api-references.md` § Preview labeling.

## Checklist before opening a PR

`.github/instructions/openapi.instructions.md` (structure, OpenAPI content, changelog pairing). No linter runs in CI; check the YAML parses.
