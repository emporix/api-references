---
seo:
  title: Pagination
  description: Offset-based and cursor-based pagination for Emporix APIs
icon: list-ol
layout:
  width: wide
description: Emporix APIs support offset-based and cursor-based pagination for retrieving large collections in smaller chunks.
---

# Pagination

Emporix APIs support two pagination approaches for retrieving collections: offset-based pagination and cursor-based pagination.

Both approaches allow clients to retrieve large result sets in smaller chunks, but they are designed for different use cases. Offset-based pagination is convenient for conventional page navigation, while cursor-based pagination is optimized for efficiently processing large datasets.

{% hint style="info" %}
Cursor-based pagination is currently available for the following services and endpoints:

* Schema Service:
  * [Retrieving all custom instances](https://developer.emporix.io/api-documentation/api-guides/utilities/schema/api-reference/custom-instance#get-schema-tenant-custom-entities-type-instances)
  * [Searching for custom instances](https://developer.emporix.io/api-documentation/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances-search)
* Audit Logs (Changelog) Service:
  * [Retrieving logs](https://developer.emporix.io/api-documentation/api-guides/utilities/audit-logs-changelog/api-reference/changelogs#get-changelog-tenant-changelogs)

The parameters and the cursor mode rules differ between the services. The cursor-based pagination examples and rules on this page describe the Schema Service, unless stated otherwise. For the Audit Logs (Changelog) Service, see [Cursor mode in the Audit Logs (Changelog) Service](#cursor-mode-in-the-audit-logs-changelog-service).
{% endhint %}

## Offset-based pagination

Offset-based pagination uses the `pageNumber` and `pageSize` query parameters.

It is well suited for use cases where users need to navigate directly between individual pages, for example in administrative user interfaces, or when working with smaller datasets.

Example:

```bash
curl -L -X GET 'https://api.emporix.io/schema/{tenant}/custom-entities/{type}/instances?pageNumber=1&pageSize=20' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'X-Total-Count: true'
```

Depending on the endpoint, clients can also request the total number of matching records using the `X-Total-Count` request header. When requested, the total is returned in the `X-Total-Count` response header.

### When to use offset-based pagination

Use offset-based pagination when:

* the dataset is relatively small or medium-sized
* direct access to a specific page is required
* the total number of results needs to be displayed
* pagination is primarily used for user-facing page navigation

{% hint style="warning" %}
For very large datasets, retrieving pages with high `pageNumber` values can become increasingly expensive because the service has to process the records preceding the requested page.
{% endhint %}

## Cursor-based pagination

Cursor-based pagination is designed for efficiently navigating large result sets without relying on page offsets.

Instead of requesting a specific page, the client continues from the position returned by the previous request.

Navigation uses these query parameters:

* `next` – retrieves the next set of results
* `prev` – retrieves the previous set of results

Responses can return these headers with opaque cursor values:

* `X-Next-Cursor` – cursor for the next set of results
* `X-Prev-Cursor` – cursor for the previous set of results

A typical flow looks like this:

```text
Initial request
        ↓
Result set
+ X-Next-Cursor
        ↓
Request using next=<cursor>
        ↓
Next result set
+ X-Next-Cursor
+ X-Prev-Cursor
```

For example, start with an initial request:

```bash
curl -L -X GET 'https://api.emporix.io/schema/{tenant}/custom-entities/{type}/instances?pageSize=20' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

The response can contain the following header:

```http
X-Next-Cursor: eyJpZCI6IjEyMyJ9
```

The client uses this value for the subsequent request:

```bash
curl -L -X GET 'https://api.emporix.io/schema/{tenant}/custom-entities/{type}/instances?pageSize=20&next=eyJpZCI6IjEyMyJ9' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

### When to use cursor-based pagination

Use cursor-based pagination when:

* you need to iterate through very large collections
* pagination is used by integrations, background jobs, or export processes
* stable forward/backward traversal matters more than jumping to an arbitrary page number

### Cursor mode behavior

In the Schema Service, cursor-based pagination works in the following way:

* Cursor pagination is active when `next` or `prev` is provided.
* `pageNumber` is ignored.
* The `X-Total-Count` request header is ignored, and the `X-Total-Count` response header is not returned.
* `next` and `prev` cannot be used in the same request. A request containing both returns `400 Bad Request`.
* Clients must treat cursor values as opaque and return them unchanged in subsequent requests.

{% hint style="info" %}
Not calculating the total record count is intentional. For very large datasets, counting every matching record can itself become an expensive operation and would reduce the performance benefits of cursor pagination.
{% endhint %}

### Stable sorting

Cursor-based pagination requires a deterministic result order. Otherwise, records with identical sort values could move between result pages.

Therefore, supported custom instance queries use `_id` as a deterministic sorting criterion:

* If no sorting is provided, the service uses `_id:ASC`.
* If another sort field is provided, the service appends `_id:ASC` as a tie-breaker when `_id` is not already part of the sort.

For example:

```text
createdAt:DESC
```

is effectively processed as:

```text
createdAt:DESC,_id:ASC
```

This ensures that every record has a stable position within the result set and helps prevent records from being skipped or returned more than once while navigating through the collection.

### Cursor mode in the Audit Logs (Changelog) Service

The [Retrieving logs](https://developer.emporix.io/api-documentation/api-guides/utilities/audit-logs-changelog/api-reference/changelogs#get-changelog-tenant-changelogs) endpoint of the Audit Logs (Changelog) Service uses offset-based pagination by default and supports cursor-based pagination as an option. It differs from the Schema Service in the following ways:

* Parameters – offset-based pagination uses `page` and `size` instead of `pageNumber` and `pageSize`. Cursor mode uses `next` or `prev` for every page after the first one. The `size` parameter is optional in both modes, defaults to `20`, and has a maximum of `100`.
* Activation – the first request must contain `pagination=cursor`. Without it, the endpoint uses offset-based pagination and returns no cursor headers. When `pagination` is omitted, a `next` or `prev` parameter also selects cursor mode. A request with `next` or `prev` and `pagination=offset` fails with `400 Bad Request`.
* Page number – a request that contains `page` in cursor mode fails with `400 Bad Request`. The Schema Service ignores `pageNumber` instead.
* Response – in cursor mode, the response body contains only `items`, with no totals. The cursors are returned in the `x-next-cursor` and `x-prev-cursor` response headers. In offset-based pagination, the totals are returned in the `totalElements` and `totalPages` fields of the response body.
* Query binding – a cursor is valid only for the tenant, `q`, and `size` of the request that returned it. A request that sends a cursor with a different `q` or `size` fails with `400 Bad Request`.
* Sorting – entries are always ordered newest first, and entries with the same timestamp keep a stable order across pages. The `_id` rules in [Stable sorting](#stable-sorting) do not apply.

As in the Schema Service, `next` and `prev` cannot be used in the same request, and cursor values are opaque.

For example, request the first page in cursor mode:

```bash
curl -i -X GET 'https://api.emporix.io/changelog/{tenant}/changelogs?pagination=cursor&size=20' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

This request has no `occurredAt` lower bound in `q`, so the walk covers the 7 days before the first request. To cover a different period, add an `occurredAt` range to `q`. For the full walk through the pages, and the time window that a cursor covers, see [How to page with cursors](../utilities/audit-logs-changelog/audit-logs-changelog.md#how-to-page-with-cursors).
