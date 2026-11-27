# Emporix API References

Public Emporix API documentation: OpenAPI 3.0.0 references, API tutorials, and
the API changelog for the GitBook developer portal
(`https://developer.emporix.io/api-references/`). Audience: integrators and
software engineers. Source: `README.md`, `.github/copilot-docs-review/local-review-checks.md`.

Platform context (callers, deployment, cross-service conventions): ask Emporix
AI Buddy `get_service_context` with `service: "Emporix API References"`. This repository's own
knowledge is below; open only what the task needs.

## Knowledge files

| File | What it answers | Last scanned |
|---|---|---|
| `ai-project-knowledge/domain.md` | Vocabulary (service folder, spec, spec ID, ZIP name, tag page), repo invariants | `396b70d7` 2026-11-26 |
| `ai-project-knowledge/modules/openapi-specs.md` | Service folder layout, `api.yml` format and operation rules | `396b70d7` 2026-11-26 |
| `ai-project-knowledge/modules/navigation-and-publishing.md` | `SUMMARY.md`, references-only TOC, publish workflows, services list, new-service steps | `396b70d7` 2026-11-26 |
| `ai-project-knowledge/modules/changelog.md` | Changelog entry format, tags, links, release-date and conflict workflows | `396b70d7` 2026-11-26 |

## Not yet scanned

- Content of the 44 individual specs and tutorials — deliberately out of scope (structure and conventions only); open the service folder the task names.
- `.style-guide/writing-standards/` beyond `api-references.md`, `.cursor/docs-review/`, `quickstart/`, `integrations/`, `standard-practices/` — sampled only; run `/emporix-setup --rescan <module>` to add a module.

## Maintenance

Update the matching file in the same PR when a change alters repository
layout, spec conventions, navigation, publishing workflows, or the changelog
process. Refresh everything with `/emporix-setup --rescan`.
