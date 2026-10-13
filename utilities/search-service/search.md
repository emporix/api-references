---
description: Learn how to create a search index, monitor its job, search custom instances, reuse saved searches, and copy index configuration.
icon: graduation-cap
layout:
  width: wide
---

# How to Set Up and Use Search

Use the Search Service to index custom instances, search them with text and filters, and save reusable search definitions. This tutorial follows one `vehicle` custom schema type from index creation to direct and saved searches. It also explains index jobs and how to copy index configuration between tenants.

{% hint style="danger" %}
This functionality is in preview mode - some of the features may not be fully operational yet.
{% endhint %}

## How to prepare sample vehicle data

The tutorial uses a `vehicle` custom schema type. Its custom attributes belong to the `vehicleSearchAttributes` mixin:

```json
{
  "customSchemaTypes": [
    {
      "id": "vehicle",
      "name": {
        "en": "Vehicle"
      },
      "schemas": [
        {
          "id": "vehicleSearchAttributes",
          "name": {
            "en": "Vehicle search attributes"
          },
          "attributes": [
            {
              "key": "code",
              "name": {
                "en": "Code"
              },
              "type": "TEXT",
              "metadata": {
                "readOnly": false,
                "localized": false,
                "required": false,
                "nullable": false
              }
            },
            {
              "key": "status",
              "name": {
                "en": "Status"
              },
              "type": "TEXT",
              "metadata": {
                "readOnly": false,
                "localized": false,
                "required": false,
                "nullable": false
              }
            },
            {
              "key": "horsepower",
              "name": {
                "en": "Horsepower"
              },
              "type": "NUMBER",
              "metadata": {
                "readOnly": false,
                "localized": false,
                "required": false,
                "nullable": false
              }
            }
          ],
          "types": [
            "vehicle"
          ]
        }
      ]
    }
  ]
}
```

{% stepper %}
{% step %}
#### Import the vehicle schema

The import endpoint accepts this package as a base64-encoded `data` value. Use a service OAuth2 token with the `schema.schema_manage` scope and call [Importing Custom Entities](https://developer.emporix.io/api-documentation/api-guides/utilities/schema/api-reference/export-import#post-schema-tenant-custom-entities-import):

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/schema/{tenant}/custom-entities/import' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "data": "eyJjdXN0b21TY2hlbWFUeXBlcyI6W3siaWQiOiJ2ZWhpY2xlIiwibmFtZSI6eyJlbiI6IlZlaGljbGUifSwic2NoZW1hcyI6W3siaWQiOiJ2ZWhpY2xlU2VhcmNoQXR0cmlidXRlcyIsIm5hbWUiOnsiZW4iOiJWZWhpY2xlIHNlYXJjaCBhdHRyaWJ1dGVzIn0sImF0dHJpYnV0ZXMiOlt7ImtleSI6ImNvZGUiLCJuYW1lIjp7ImVuIjoiQ29kZSJ9LCJ0eXBlIjoiVEVYVCIsIm1ldGFkYXRhIjp7InJlYWRPbmx5IjpmYWxzZSwibG9jYWxpemVkIjpmYWxzZSwicmVxdWlyZWQiOmZhbHNlLCJudWxsYWJsZSI6ZmFsc2V9fSx7ImtleSI6InN0YXR1cyIsIm5hbWUiOnsiZW4iOiJTdGF0dXMifSwidHlwZSI6IlRFWFQiLCJtZXRhZGF0YSI6eyJyZWFkT25seSI6ZmFsc2UsImxvY2FsaXplZCI6ZmFsc2UsInJlcXVpcmVkIjpmYWxzZSwibnVsbGFibGUiOmZhbHNlfX0seyJrZXkiOiJob3JzZXBvd2VyIiwibmFtZSI6eyJlbiI6IkhvcnNlcG93ZXIifSwidHlwZSI6Ik5VTUJFUiIsIm1ldGFkYXRhIjp7InJlYWRPbmx5IjpmYWxzZSwibG9jYWxpemVkIjpmYWxzZSwicmVxdWlyZWQiOmZhbHNlLCJudWxsYWJsZSI6ZmFsc2V9fV0sInR5cGVzIjpbInZlaGljbGUiXX1dfV19"
  }'
```

A successful import returns `204 No Content`. The import creates the custom type and schema, but it does not create custom instances.

{% hint style="warning" %}
If the `vehicle` type or `vehicleSearchAttributes` schema already exists, the Schema Service imports a copy with an `_COPY` suffix. Use a tenant where these identifiers do not exist, or verify that the existing schema defines the fields shown above before continuing. The remaining examples use the original identifiers.
{% endhint %}
{% endstep %}

{% step %}
#### Create sample vehicle instances

Use a service OAuth2 token with the `schema.custominstance_manage` scope and call [Creating custom instances in bulk](https://developer.emporix.io/api-documentation/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances-bulk):

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/schema/{tenant}/custom-entities/vehicle/instances/bulk' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
    {
      "id": "vehicle-a",
      "name": {
        "en": "Red diesel engine"
      },
      "mixins": {
        "vehicleSearchAttributes": {
          "code": "VH-900",
          "status": "ACTIVE",
          "horsepower": 180
        }
      }
    },
    {
      "id": "vehicle-b",
      "name": {
        "en": "Electric city car"
      },
      "mixins": {
        "vehicleSearchAttributes": {
          "code": "EV-100",
          "status": "DRAFT",
          "horsepower": 120
        }
      }
    },
    {
      "id": "vehicle-c",
      "name": {
        "en": "Très Long Description"
      },
      "mixins": {
        "vehicleSearchAttributes": {
          "code": "TR-300",
          "status": "ACTIVE",
          "horsepower": 180
        }
      }
    }
  ]'
```

The bulk endpoint returns `207 Multi-Status`. Inspect every response item. A created item has `code` set to `201`. A failed item includes its own status and message. Repeating the request with the same IDs returns item-level `409 Conflict` results for the existing instances.
{% endstep %}
{% endstepper %}

## Prerequisites

Make sure you have the following:

* A tenant with a custom schema type whose URL type identifier is `vehicle`.
* The sample custom instances created above, or equivalent instances with the built-in `name.en` field and the `mixins.vehicleSearchAttributes.code`, `mixins.vehicleSearchAttributes.status`, and `mixins.vehicleSearchAttributes.horsepower` fields. If your schema uses different fields, replace these paths throughout the examples.
* A service OAuth2 token with the `search.search_manage` and `search.search_read` scopes. For more information, see [Tokens and Scopes](../../quickstart/authentication-and-authorization/tokens-and-scopes.md).
* A scope that permits reading the custom instances. Use `schema.custominstance_read` for broad custom-instance access, `custom.vehicle_read` for this type, or `custom.vehicle_read_own` to restrict results to instances owned by the caller.
* For cross-tenant import, a destination tenant with the same custom schema types and fields, and a token with `search.search_manage` access to that tenant.

The examples use `vehicles` as the index ID. Replace `{tenant}` with your tenant name.

## How to create an index and run a search

An index defines which custom-instance fields support text matching, autocomplete, filters, and sorting. Creating an index starts an asynchronous job. Wait for the job to succeed before you search the index.

{% stepper %}
{% step %}
#### Create the search index

Send a request to [Upserting a search index](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search-indexes#put-search-tenant-search-type-indexes-id).

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/search/{tenant}/search/vehicle/indexes/vehicles' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Language: en' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": {
      "en": "Vehicles"
    },
    "description": {
      "en": "Search vehicles by name, code, status, and horsepower"
    },
    "fields": [
      {
        "path": "name.en",
        "text": true,
        "autocomplete": "PREFIX"
      },
      {
        "path": "mixins.vehicleSearchAttributes.code",
        "text": true,
        "exact": true
      },
      {
        "path": "mixins.vehicleSearchAttributes.status",
        "exact": true
      },
      {
        "path": "mixins.vehicleSearchAttributes.horsepower",
        "exact": true
      }
    ]
  }'
```

A new index returns `202 Accepted` with the ID of the job that builds it:

```json
{
  "id": "66f1a2b3c4d5e6f708192a3b"
}
```

Choose the field options according to how you want to search:

| Option | Use |
| --- | --- |
| `text: true` | Match a string with `TEXT`, `PHRASE`, or `WILDCARD`. |
| `autocomplete: PREFIX` | Match the beginning of a word with `AUTOCOMPLETE`. |
| `autocomplete: NGRAM` | Match a character sequence inside a word with `AUTOCOMPLETE`. |
| `exact: true` | Filter, sort, or check ranges and existence. Number, Boolean, and date fields support only this option. |

Use full stored paths such as `name.en` and `mixins.vehicleSearchAttributes.code`. A path must exist on the custom schema type.
{% endstep %}

{% step %}
#### Monitor the index job

Use the job ID from the `202 Accepted` response with [Retrieving an index job](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/index-jobs#get-search-tenant-jobs-id).

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X GET \
  'https://api.emporix.io/search/{tenant}/jobs/66f1a2b3c4d5e6f708192a3b' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

Poll the job until `status` is `success` or `failure`. A successful create job looks like this:

```json
{
  "id": "66f1a2b3c4d5e6f708192a3b",
  "status": "success",
  "type": "create_index",
  "indexId": "vehicles",
  "message": "Creating index vehicles--vehicle for type vehicle",
  "response": "Index created.",
  "metadata": {
    "version": 1,
    "createdAt": "2026-03-12T10:00:00.000Z",
    "modifiedAt": "2026-03-12T10:04:00.000Z"
  }
}
```

If the job fails, inspect `response` and use [Retrieving a search index](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search-indexes#get-search-tenant-search-type-indexes-id) to check the index. An index can be `building`, `ready`, or `failed`. Continue polling the active job while it is `building`. For a `failed` index, correct the field definition or the reported cause and send the index `PUT` request again.
{% endstep %}

{% step %}
#### Search the indexed custom instances

Send a request to [Searching documents](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search#post-search-tenant-search-type).

This example matches `diesel engine` in `name.en` or a code that starts with `VH-`. It then keeps active vehicles with at least 150 horsepower. The response is sorted by horsepower.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/search/{tenant}/search/vehicle?pageNumber=1&pageSize=20&sort=mixins.vehicleSearchAttributes.horsepower:DESC' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Accept-Language: en' \
  -H 'Content-Type: application/json' \
  -H 'X-Total-Count: true' \
  -d '{
    "index": "vehicles",
    "queries": [
      {
        "type": "TEXT",
        "query": "diesel engine",
        "field": "name.en",
        "boost": 3
      },
      {
        "type": "WILDCARD",
        "query": "VH-*",
        "field": "mixins.vehicleSearchAttributes.code"
      }
    ],
    "filters": {
      "and": [
        {
          "field": "mixins.vehicleSearchAttributes.status",
          "operator": "EQ",
          "value": "ACTIVE"
        },
        {
          "field": "mixins.vehicleSearchAttributes.horsepower",
          "operator": "GTE",
          "value": 150
        }
      ]
    }
  }'
```

The response body is an array of matching custom instances. When the `X-Total-Count` request header is `true`, the response also includes the `X-Total-Count` header. Filters and sort fields must use fields that have `exact: true` in the index.
{% endstep %}
{% endstepper %}

## How to choose search criteria

A direct search must provide `index` and at least one of `queries` or `filters`. `queries` can contain one query object, a list of query objects, or an `and` or `or` group. A top-level list matches when any item matches.

The following query types are available:

| Type | Behavior | Index requirement |
| --- | --- | --- |
| `TEXT` | Matches analyzed query tokens. It also supports fuzzy matching with one or two edits. | `text: true` |
| `PHRASE` | Matches adjacent words in the same order. | `text: true` |
| `AUTOCOMPLETE` | Matches according to the configured `PREFIX` or `NGRAM` mode. | `autocomplete` |
| `WILDCARD` | Matches a case-sensitive pattern. `*` matches any number of characters and `?` matches one character. | `text: true` |

### Query examples

Assume the index contains the following values:

* Vehicle A – `name.en` is `Red diesel engine` and `code` is `VH-900`.
* Vehicle B – `name.en` is `Electric city car` and `code` is `EV-100`.

Place one of the following objects in `queries`:

* `{"type":"TEXT","query":"diesel","field":"name.en"}` matches Vehicle A because `diesel` is an analyzed word in its name.
* `{"type":"PHRASE","query":"diesel engine","field":"name.en"}` matches Vehicle A because both words are adjacent and in that order. A value such as `Diesel-powered engine` does not match this phrase.
* `{"type":"AUTOCOMPLETE","query":"elec","field":"name.en"}` matches Vehicle B when `name.en` uses `autocomplete: PREFIX`. The same query does not match `Bioelectric car` because `elec` is not at the start of that word.
* `{"type":"WILDCARD","query":"VH-?00","field":"mixins.vehicleSearchAttributes.code"}` matches Vehicle A because `?` replaces the single character `9`. It does not match `vh-900` because wildcard matching is case-sensitive, or `PRE-VH-900` because the pattern evaluates the whole stored value.
* `{"type":"TEXT","query":"deisel","field":"name.en","fuzzy":{"enabled":true,"maxEdits":1}}` matches Vehicle A because swapping the adjacent `i` and `e` counts as one edit.
* `{"type":"TEXT","query":"dieselxx","field":"name.en","fuzzy":{"enabled":true,"maxEdits":2}}` matches Vehicle A by allowing the two extra characters. It does not match with `maxEdits` set to `1`.


The following filter operators are available:

* `EQ`, `NEQ`, `GT`, `GTE`, `LT`, and `LTE` compare one value.
* `BETWEEN` compares an inclusive range supplied as an array of two values.
* `IN` and `NOT_IN` compare a non-empty array of values.
* `EXISTS` takes a Boolean and checks whether the field is present.
* `CONTAINS` takes a non-blank string and performs a case- and diacritic-insensitive substring match. The field must have `text: true` in the index. The service treats `\`, `*`, and `?` in the value as literal characters.

### Filter examples

Assume Vehicle C has `status` set to `ACTIVE`, `horsepower` set to `180`, `code` set to `TR-300`, and `name.en` set to `Très Long Description`. The equality, list, range, and existence examples use fields configured with `exact: true`. The `CONTAINS` example uses a field configured with `text: true`.

Place one of the following objects in `filters`:

* `{"field":"mixins.vehicleSearchAttributes.status","operator":"EQ","value":"ACTIVE"}` matches the vehicle.
* `{"field":"mixins.vehicleSearchAttributes.status","operator":"NEQ","value":"ARCHIVED"}` matches the vehicle.
* `{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"GT","value":150}` and `{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"GTE","value":180}` match the vehicle.
* `{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"LT","value":200}` and `{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"LTE","value":180}` match the vehicle.
* `{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"BETWEEN","value":[150,200]}` matches the vehicle because the range is inclusive.
* `{"field":"mixins.vehicleSearchAttributes.status","operator":"IN","value":["ACTIVE","DRAFT"]}` matches the vehicle.
* `{"field":"mixins.vehicleSearchAttributes.status","operator":"NOT_IN","value":["ARCHIVED","DELETED"]}` matches the vehicle.
* `{"field":"mixins.vehicleSearchAttributes.code","operator":"EXISTS","value":true}` matches the vehicle because `code` is present.
* `{"field":"name.en","operator":"CONTAINS","value":"tres long"}` matches `Très Long Description` because `CONTAINS` ignores case and diacritics.
* `{"field":"name.en","operator":"CONTAINS","value":"*"}` matches a value such as `Model * Special`, but not `Model X Special`, because `CONTAINS` treats `*` as a literal character.

For example, this filter matches values such as `Hybrid-999`:

```json
{
  "index": "vehicles",
  "filters": {
    "field": "name.en",
    "operator": "CONTAINS",
    "value": "hybrid-9"
  }
}
```

You can submit filters without a text query. For example:

```json
{
  "index": "vehicles",
  "filters": {
    "or": [
      {
        "field": "mixins.vehicleSearchAttributes.status",
        "operator": "EQ",
        "value": "ACTIVE"
      },
      {
        "field": "mixins.vehicleSearchAttributes.status",
        "operator": "EQ",
        "value": "DRAFT"
      }
    ]
  }
}
```

## How to save and reuse a search

A saved search stores its index, query shape, and filters. Running it requires only its ID and new query text. Saving, updating, or deleting a saved search does not start an index job.

{% stepper %}
{% step %}
#### Save the search

Send a request to [Upserting a saved search](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/saved-searches#put-search-tenant-search-type-queries-id).

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/search/{tenant}/search/vehicle/queries/active-vehicles' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Language: en' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": {
      "en": "Active vehicles"
    },
    "description": {
      "en": "Search active vehicles by name"
    },
    "index": "vehicles",
    "queries": {
      "type": "TEXT",
      "query": "diesel",
      "field": "name.en"
    },
    "filters": {
      "field": "mixins.vehicleSearchAttributes.status",
      "operator": "EQ",
      "value": "ACTIVE"
    }
  }'
```

A new saved search returns `201 Created` and its ID. Replacing an existing saved search returns `204 No Content`.
{% endstep %}

{% step %}
#### Run the saved search with new text

Call [Searching documents](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search#post-search-tenant-search-type) with `searchQueryId` and `query`:

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/search/{tenant}/search/vehicle?pageNumber=1&pageSize=20' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Accept-Language: en' \
  -H 'Content-Type: application/json' \
  -d '{
    "searchQueryId": "active-vehicles",
    "query": "red"
  }'
```

The saved search supplies the index, filters, and query shape. The request `query` replaces the `query` value in every stored query node, including nodes in `and` or `or` groups. The stored query types, fields, boosts, and filters remain unchanged. This request matches Vehicle A because its name contains `red` and its status is `ACTIVE`.
{% endstep %}
{% endstepper %}

## How to monitor index jobs

Jobs track asynchronous index creation, mapping changes, and deletion. They do not track saved-search changes.

The following job types and statuses are available:

| Field | Values | Meaning |
| --- | --- | --- |
| `type` | `create_index`, `update_index`, `delete_index` | Operation that started the job. |
| `status` | `in_progress`, `success`, `failure` | Current result of the asynchronous operation. |

Use [Retrieving index jobs](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/index-jobs#get-search-tenant-jobs) to inspect recent jobs:

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X GET \
  'https://api.emporix.io/search/{tenant}/jobs?pageNumber=1&pageSize=20&sort=metadata.createdAt:DESC' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'X-Total-Count: true'
```

The job list supports `pageNumber`, `pageSize`, `sort`, `q`, and `fields`. Set `X-Total-Count` to `true` when you also need the number of matching jobs.

Creating an index, changing its field definition, or sending the index `PUT` request again for an index in the `building` or `failed` status returns `202 Accepted` and starts a job. Updating only `name` or `description` on a `ready` index with unchanged fields returns `204 No Content` and does not start a job. A job already in progress for the index returns `409 Conflict`.

## How to update or delete an index

Use [Upserting a search index](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search-indexes#put-search-tenant-search-type-indexes-id) to replace its definition. `metadata.version` is optional. When you send it, it acts as an optimistic lock. A stale value returns `409 Conflict`.

Use [Deleting a search index](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search-indexes#delete-search-tenant-search-type-indexes-id) to start an asynchronous deletion job:

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X DELETE \
  'https://api.emporix.io/search/{tenant}/search/vehicle/indexes/vehicles' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

The response is `202 Accepted` with a job ID. Monitor that job in the same way as an index creation or update job.

## How to copy index configuration between tenants

Export and import copy index definitions without copying saved searches, index status, or existing jobs.

{% stepper %}
{% step %}
#### Export the selected indexes

Send a non-empty list to [Exporting search indexes](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/export-import#post-search-tenant-search-indexes-export):

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/search/{tenant}/search/indexes/export' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
    {
      "type": "vehicle",
      "id": "vehicles"
    }
  ]'
```

The response contains `exportedAt` and `data`. The `data` value is a base64-encoded JSON array. Exported items include `id`, `type`, `fields`, and optional localized `name` and `description`. They do not include `status` or `metadata`.
{% endstep %}

{% step %}
#### Import the package on the destination tenant

Pass the complete export response to [Importing search indexes](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/export-import#post-search-tenant-search-indexes-import):

Use a token authorized for `{destinationTenant}`. The destination tenant must contain the custom schema type and every field path used by each imported index.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/search/{destinationTenant}/search/indexes/import' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Language: *' \
  -H 'Content-Type: application/json' \
  -d '{
    "exportedAt": "2026-03-12T10:00:00.000Z",
    "data": "W3siaWQiOiJ2ZWhpY2xlcyIsInR5cGUiOiJ2ZWhpY2xlIiwibmFtZSI6eyJlbiI6IlZlaGljbGVzIn0sImRlc2NyaXB0aW9uIjp7ImVuIjoiU2VhcmNoIHZlaGljbGVzIGJ5IG5hbWUsIGNvZGUsIHN0YXR1cywgYW5kIGhvcnNlcG93ZXIifSwiZmllbGRzIjpbeyJwYXRoIjoibmFtZS5lbiIsInRleHQiOnRydWUsImF1dG9jb21wbGV0ZSI6IlBSRUZJWCJ9LHsicGF0aCI6Im1peGlucy52ZWhpY2xlU2VhcmNoQXR0cmlidXRlcy5jb2RlIiwidGV4dCI6dHJ1ZSwiZXhhY3QiOnRydWV9LHsicGF0aCI6Im1peGlucy52ZWhpY2xlU2VhcmNoQXR0cmlidXRlcy5zdGF0dXMiLCJleGFjdCI6dHJ1ZX0seyJwYXRoIjoibWl4aW5zLnZlaGljbGVTZWFyY2hBdHRyaWJ1dGVzLmhvcnNlcG93ZXIiLCJleGFjdCI6dHJ1ZX1dfV0="
  }'
```

Import returns one result per index. A result includes `jobId` and `jobType` when a create or update job starts. Those fields are absent when a ready index keeps the same field definition. Import is not atomic. If one index fails, indexes processed before it remain created or updated. Review those indexes before retrying the package.

Monitor every returned job under `{destinationTenant}` before searching the imported indexes.
{% endstep %}
{% endstepper %}