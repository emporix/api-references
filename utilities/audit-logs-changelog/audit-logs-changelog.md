---
seo:
  title: Audit Logs (Changelog) Service Tutorials
  description: Learn how to query tenant change history with the Audit Logs (Changelog) Service.
icon: graduation-cap
layout:
  width: wide
---

# Audit Logs (Changelog) Tutorial

The Audit Logs (Changelog) Service exposes a query API for tenant-wide change history of platform entities such as orders, customers, companies, products, segments, groups, coupons, quotes, sites, and custom entities created with the Schema Service.

## Authentication

Request a service access token with one of these scopes:

* `changelog.changelog_read`
* `changelog.changelog_manage`

{% hint style="info" %}
See [Tokens and Scopes](../../quickstart/authentication-and-authorization/tokens-and-scopes.md) and the [OAuth Service](../../authentication/oauth-service/README.md).
{% endhint %}

## How to retrieve logs

Send a request to the [Retrieving logs](https://developer.emporix.io/api-documentation/api-guides/utilities/audit-logs-changelog/api-reference/changelogs#get-changelog-tenant-changelogs) endpoint.

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

By default, pagination uses `page` (1-based, default `1`) and `size` (default `20`, maximum `100`). Results are ordered by occurrence time, newest first. To return `totalElements` and `totalPages`, the API counts all matching entries on every request. To page through many entries without counting them, see [How to page with cursors](audit-logs-changelog.md#how-to-page-with-cursors).

{% hint style="info" %}
When `q` has no `occurredAt` lower bound outside an `OR` condition, the API applies a default window of the last **7 days**. An `occurredAt` lower bound that appears only inside an `OR` condition does not stop the default window. To use a different window, add an explicit `occurredAt` range to `q` outside an `OR` condition.
{% endhint %}

## How to page with cursors

Use cursor pagination when you walk through many audit log entries and do not need the totals, for example in a nightly sync or in a user interface that lists the audit logs of a large tenant. In cursor mode, the API does not count the matching entries and does not use a page offset. Each page continues from the position of the previous one.

In cursor mode, the [Retrieving logs](https://developer.emporix.io/api-documentation/api-guides/utilities/audit-logs-changelog/api-reference/changelogs#get-changelog-tenant-changelogs) endpoint works in the following way:

* The response body contains only `items`, with no totals.
* Entries are ordered newest first by their `at` timestamp, which is the value that `occurredAt` in `q` filters on. Entries with the same timestamp keep a stable order across pages.
* When an older or a newer page exists, the response contains its cursor in the `x-next-cursor` or the `x-prev-cursor` response header. Treat each cursor as an opaque value and send it back unchanged in the `next` or the `prev` query parameter, respectively.

The first request needs `pagination=cursor`. Without it, the endpoint uses offset pagination and returns no cursor headers.

{% stepper %}
{% step %}
##### Request the first page

Send a request with `pagination=cursor` and the `size` you need. Set an explicit `occurredAt` range in `q` to choose the entries that the walk covers. Without it, the default window of the last 7 days applies.

```bash
curl -i -G 'https://api.emporix.io/changelog/{tenant}/changelogs' \
  --data-urlencode 'pagination=cursor' \
  --data-urlencode 'size=50' \
  --data-urlencode 'q=occurredAt:(>"2026-06-01T00:00:00.000Z" AND <"2026-06-07T23:59:59.999Z")' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

The response contains the newest entries of the range in `items`. When older entries exist, the response also contains the `x-next-cursor` header:

```http
HTTP/1.1 200 OK
x-next-cursor: {{X_NEXT_CURSOR}}
```
{% endstep %}

{% step %}
##### Request the next page

Send the value of the `x-next-cursor` header in the `next` query parameter. Send the same `q` and `size` as in the first request, because a cursor is bound to the tenant, `q`, and `size` it was issued for.

```bash
curl -i -G 'https://api.emporix.io/changelog/{tenant}/changelogs' \
  --data-urlencode 'pagination=cursor' \
  --data-urlencode 'size=50' \
  --data-urlencode 'q=occurredAt:(>"2026-06-01T00:00:00.000Z" AND <"2026-06-07T23:59:59.999Z")' \
  --data-urlencode 'next={{X_NEXT_CURSOR}}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

The response contains the next, older entries. When the page is not empty, the response also contains the `x-prev-cursor` header, which leads back to newer entries.
{% endstep %}

{% step %}
##### Stop at the last page

Repeat the previous step with the `x-next-cursor` value of each response. When a response has no `x-next-cursor` header, you have reached the oldest entries of the window.
{% endstep %}
{% endstepper %}

To go back to newer entries, send the value of the `x-prev-cursor` header in the `prev` query parameter instead of `next`, with the same `q` and `size`. You cannot send `next` and `prev` in the same request. The first page never has an `x-prev-cursor` header. When a `prev` response has no `x-prev-cursor` header, you have reached the newest entries of the window. A page with no entries has neither cursor header.

A cursor pages inside the time window fixed by the first page. The window starts at the `occurredAt` lower bound in `q`, or 7 days before the first request if `q` has no `occurredAt` lower bound outside an `OR` condition. The window ends at the `occurredAt` upper bound in `q`. If `q` has no upper bound, the window ends at the time of the first request, and entries that occurred after it do not appear on later pages. To include them, request a new first page.

If a request with a cursor fails with `400`, for example because `q` or `size` changed, request the first page again without a cursor. For all error cases, see [Retrieving logs](https://developer.emporix.io/api-documentation/api-guides/utilities/audit-logs-changelog/api-reference/changelogs#get-changelog-tenant-changelogs).

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

Find changed entries that reference another entity, for example group-assignment entries related to a group:

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

{% hint style="info" %}
For general `q` syntax, see [Query Parameter](../../standard-practices/q-param.md).
{% endhint %}
