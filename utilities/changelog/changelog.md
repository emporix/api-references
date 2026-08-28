---
seo:
  title: Changelog Service Tutorials
  description: Learn how to query tenant changelog history with the Changelog Service.
icon: graduation-cap
layout:
  width: wide
---

# Changelog Tutorial

The Changelog Service exposes a query API for tenant-wide change history of platform entities such as orders, customers, companies, products, segments, groups, and coupons.

{% hint style="danger" %}
This functionality is in preview mode - some of the features may not be fully operational yet.
{% endhint %}

## Authentication

Request a service access token with one of these scopes:

* `changelog.changelog_read`
* `changelog.changelog_manage`

See [Tokens and Scopes](../../quickstart/authentication-and-authorization/tokens-and-scopes.md) and the [OAuth Service](../../authentication/oauth-service/README.md).

## How to retrieve tenant changelogs

Send a request to the [Retrieving tenant changelogs](https://developer.emporix.io/api-references/api-guides/utilities/changelog/api-reference/changelogs#get-changelog-tenant-changelogs) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/changelog/{tenant}/changelogs?page=1&size=20' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

Pagination uses `page` (1-based, default `1`) and `size` (default `20`, maximum `100`). Results are ordered by occurrence time.

{% hint style="info" %}
When the query omits a conjunctive `occurredAt` from-bound, the API applies a default trailing window of **30 days**. Pass an explicit top-level or `AND` `occurredAt` range to override it.
{% endhint %}

## How to filter by entity and document ID

Scope history to a single document with `entity` and `entityId` in the `q` parameter. There is no path-based history endpoint.

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/changelog/{tenant}/changelogs?q=entity:order%20entityId:6a2bce93592855a33518fc2f&page=1&size=20' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

## How to filter by change type, actor, and time

Supported `q` fields include:

| Field | Example |
| --- | --- |
| `type` | `type:update` |
| `actor` | `actor:system`, `actor:John*`, `actor:~^sys` |
| `occurredAt` | `occurredAt:(>"2026-06-01T00:00:00.000Z" AND <"2026-06-30T23:59:59.999Z")` |

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/changelog/{tenant}/changelogs?q=entity:order%20type:update%20actor:system&page=1&size=20' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

Possible `type` values are `create`, `update`, and `delete`.

## How to query related entities

Find changelog rows that reference another entity, for example group-assignment rows related to a group:

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/changelog/{tenant}/changelogs?q=related.entity:group%20related.entityId:1gr5e52e-6e27-4ac5-9471-2467d3fb7501&page=1&size=20' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

You can also use elemMatch syntax or compound logical queries:

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/changelog/{tenant}/changelogs?q=compoundLogicalQuery:((entity:group%20type:update)%20OR%20(related:elemMatch(entity:group)))&page=1&size=20' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

For general `q` syntax, see [Query Parameter](../../standard-practices/q-param.md).
