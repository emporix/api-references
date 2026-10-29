---
description: Learn how to create a search index, control text matching with analyzers, index lists of objects, search custom instances, reuse saved searches, and copy index configuration.
icon: graduation-cap
layout:
  width: wide
---

# Search Service Tutorials

Use the Search Service to index custom instances, search them with text and filters, and save reusable search definitions. This tutorial follows one custom schema type from index creation to direct and saved searches. It also explains how analyzers control text comparison, how to index a list of objects, how index jobs work, and how to copy index configuration between tenants.

{% hint style="danger" %}
This functionality is in preview mode - some of the features may not be fully operational yet.
{% endhint %}

## Prerequisites

Make sure you have the following:

* A tenant where you can create a custom schema type and custom instances. The next section prepares sample data for the examples.
* A service OAuth2 token with the `schema.schema_manage` and `schema.custominstance_manage` scopes to prepare that data, and with the `search.search_manage` and `search.search_read` scopes for the Search Service steps. For more information, see [Tokens and Scopes](../../quickstart/authentication-and-authorization/tokens-and-scopes.md).
* A scope that permits reading the custom instances. Use `schema.custominstance_read` for broad custom-instance access, or a type-specific scope such as `custom.vehicle_read` or `custom.vehicle_read_own` for the sample `VEHICLE` type in the examples. Replace `vehicle` with the lowercase form of your own type id when you use a different type.
* For cross-tenant import, a destination tenant with the same custom schema types and fields, and a token with `search.search_manage` access to that tenant.

## How to prepare sample data

{% hint style="info" %}
The examples use a sample `VEHICLE` custom schema type and three custom instances. Schema Service custom type IDs use uppercase letters, digits, and underscores. You can replace this type and its fields with your own; update the paths in later examples to match.
{% endhint %}

Prepare a custom entity package, encode it, import it, and create sample instances before you build a search index.

{% stepper %}
{% step %}
#### Build the custom entity JSON

Create a package that defines the custom schema type and its mixin. The sample type id is `VEHICLE`. Its custom attributes belong to the `vehicleSearchAttributes` mixin:

```json
{
  "customSchemaTypes": [
    {
      "id": "VEHICLE",
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
            "VEHICLE"
          ]
        }
      ]
    }
  ]
}
```
{% endstep %}

{% step %}
#### Encode the package as base64

Encode the JSON package as a single-line base64 `data` value:

{% tabs %}
{% tab title="macOS / Linux" %}
```bash
base64 -i vehicle-schema.json | tr -d '\n'
```
{% endtab %}

{% tab title="Windows PowerShell" %}
```powershell
[Convert]::ToBase64String([IO.File]::ReadAllBytes("vehicle-schema.json"))
```
{% endtab %}
{% endtabs %}

The encoded value for the sample package above is:

```text
eyJjdXN0b21TY2hlbWFUeXBlcyI6W3siaWQiOiJWRUhJQ0xFIiwibmFtZSI6eyJlbiI6IlZlaGljbGUifSwic2NoZW1hcyI6W3siaWQiOiJ2ZWhpY2xlU2VhcmNoQXR0cmlidXRlcyIsIm5hbWUiOnsiZW4iOiJWZWhpY2xlIHNlYXJjaCBhdHRyaWJ1dGVzIn0sImF0dHJpYnV0ZXMiOlt7ImtleSI6ImNvZGUiLCJuYW1lIjp7ImVuIjoiQ29kZSJ9LCJ0eXBlIjoiVEVYVCIsIm1ldGFkYXRhIjp7InJlYWRPbmx5IjpmYWxzZSwibG9jYWxpemVkIjpmYWxzZSwicmVxdWlyZWQiOmZhbHNlLCJudWxsYWJsZSI6ZmFsc2V9fSx7ImtleSI6InN0YXR1cyIsIm5hbWUiOnsiZW4iOiJTdGF0dXMifSwidHlwZSI6IlRFWFQiLCJtZXRhZGF0YSI6eyJyZWFkT25seSI6ZmFsc2UsImxvY2FsaXplZCI6ZmFsc2UsInJlcXVpcmVkIjpmYWxzZSwibnVsbGFibGUiOmZhbHNlfX0seyJrZXkiOiJob3JzZXBvd2VyIiwibmFtZSI6eyJlbiI6IkhvcnNlcG93ZXIifSwidHlwZSI6Ik5VTUJFUiIsIm1ldGFkYXRhIjp7InJlYWRPbmx5IjpmYWxzZSwibG9jYWxpemVkIjpmYWxzZSwicmVxdWlyZWQiOmZhbHNlLCJudWxsYWJsZSI6ZmFsc2V9fV0sInR5cGVzIjpbIlZFSElDTEUiXX1dfV19
```
{% endstep %}

{% step %}
#### Import the custom entity package

Use a service OAuth2 token with the `schema.schema_manage` scope and call [Importing Custom Entities](https://developer.emporix.io/api-documentation/api-guides/utilities/schema/api-reference/export-import#post-schema-tenant-custom-entities-import):

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/schema/{tenant}/custom-entities/import' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "data": "eyJjdXN0b21TY2hlbWFUeXBlcyI6W3siaWQiOiJWRUhJQ0xFIiwibmFtZSI6eyJlbiI6IlZlaGljbGUifSwic2NoZW1hcyI6W3siaWQiOiJ2ZWhpY2xlU2VhcmNoQXR0cmlidXRlcyIsIm5hbWUiOnsiZW4iOiJWZWhpY2xlIHNlYXJjaCBhdHRyaWJ1dGVzIn0sImF0dHJpYnV0ZXMiOlt7ImtleSI6ImNvZGUiLCJuYW1lIjp7ImVuIjoiQ29kZSJ9LCJ0eXBlIjoiVEVYVCIsIm1ldGFkYXRhIjp7InJlYWRPbmx5IjpmYWxzZSwibG9jYWxpemVkIjpmYWxzZSwicmVxdWlyZWQiOmZhbHNlLCJudWxsYWJsZSI6ZmFsc2V9fSx7ImtleSI6InN0YXR1cyIsIm5hbWUiOnsiZW4iOiJTdGF0dXMifSwidHlwZSI6IlRFWFQiLCJtZXRhZGF0YSI6eyJyZWFkT25seSI6ZmFsc2UsImxvY2FsaXplZCI6ZmFsc2UsInJlcXVpcmVkIjpmYWxzZSwibnVsbGFibGUiOmZhbHNlfX0seyJrZXkiOiJob3JzZXBvd2VyIiwibmFtZSI6eyJlbiI6IkhvcnNlcG93ZXIifSwidHlwZSI6Ik5VTUJFUiIsIm1ldGFkYXRhIjp7InJlYWRPbmx5IjpmYWxzZSwibG9jYWxpemVkIjpmYWxzZSwicmVxdWlyZWQiOmZhbHNlLCJudWxsYWJsZSI6ZmFsc2V9fV0sInR5cGVzIjpbIlZFSElDTEUiXX1dfV19"
  }'
```

A successful import returns `204 No Content`. The import creates the custom type and schema, but it does not create custom instances.

{% hint style="warning" %}
If the `VEHICLE` type or `vehicleSearchAttributes` schema already exists, the Schema Service imports a copy with an `_COPY` suffix. Use a tenant where these identifiers do not exist, or verify that the existing schema defines the fields shown above before continuing. The remaining examples use the original identifiers.
{% endhint %}
{% endstep %}

{% step %}
#### Create sample custom instances

Use a service OAuth2 token with the `schema.custominstance_manage` scope and call [Creating custom instances in bulk](https://developer.emporix.io/api-documentation/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances-bulk):

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/schema/{tenant}/custom-entities/VEHICLE/instances/bulk' \
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

## How to create an index and run a search

An index defines which custom-instance fields support text matching, autocomplete, filters, and sorting. Creating an index starts an asynchronous job. Wait for the job to succeed before you search the index.

{% stepper %}
{% step %}
#### Create the search index

Send a request to [Upserting a search index](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search-indexes#put-search-tenant-search-type-indexes-id).

Choose the field options according to how you want to search:

| Option | Use |
| --- | --- |
| `text: true` | Match a string with `TEXT`, `PHRASE`, `WILDCARD`, or `CONTAINS`. |
| `autocomplete: PREFIX` | Match the beginning of a word with `AUTOCOMPLETE`. |
| `autocomplete: NGRAM` | Match a character sequence inside a word with `AUTOCOMPLETE`. |
| `exact: true` | Sort, or filter with equality, range, list, or existence operators. Number, Boolean, and date fields support only this option. |
| `analyzer` | Set the comparison rules for a field with `text: true`. Use a preset or the name of a custom analyzer on the index. When omitted, `STANDARD` is used. For more information, see [How to control text matching with analyzers](#how-to-control-text-matching-with-analyzers). |
| `additionalAnalyzers` | Add up to three extra comparison rules for a field with `text: true`. A query uses an additional analyzer only when it selects that analyzer. |
| `itemFields` | Index the fields inside a list of objects. For more information, see [How to index a list of objects](#how-to-index-a-list-of-objects). |

Use full stored paths such as `name.en` and `mixins.vehicleSearchAttributes.code`. A path must exist on the custom schema type.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/search/{tenant}/search/VEHICLE/indexes/vehicles' \
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
{% endstep %}

{% step %}
#### Monitor the index job

Use the job ID from the `202 Accepted` response with [Retrieving an index job](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/index-jobs#get-search-tenant-jobs-id). For job types and statuses, see [How to manage indexes and jobs](#how-to-manage-indexes-and-jobs).

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X GET \
  'https://api.emporix.io/search/{tenant}/jobs/{jobId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

Poll the job until `status` is `success` or `failure`. A successful create job looks like this:

```json
{
  "id": "66f1a2b3c4d5e6f708192a3b",
  "status": "success",
  "type": "create_index",
  "indexId": "vehicles",
  "message": "Creating index vehicles--VEHICLE for type VEHICLE",
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

Send a request to [Searching documents](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search#post-search-tenant-search-type) and define your query and filters. For query types, filter operators, and further examples, see [Available search criteria](#available-search-criteria).

This example matches `diesel engine` in `name.en` or a code that starts with `VH-`. It then keeps active vehicles with at least 150 horsepower. The response is sorted by horsepower.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/search/{tenant}/search/VEHICLE?pageNumber=1&pageSize=20&sort=mixins.vehicleSearchAttributes.horsepower:DESC' \
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

The response body is an array of matching custom instances. When the `X-Total-Count` request header is `true`, the response also includes the `X-Total-Count` header. Equality, range, list, existence, and sort fields must have `exact: true`. A `CONTAINS` filter must use a field with `text: true`.
{% endstep %}
{% endstepper %}

## How to control text matching with analyzers

An analyzer defines how the service compares text in a field with `text: true`. The service applies the same rules to the stored value and to the query text. Set the main rules with `analyzer` on the field. To offer other ways of matching the same field, list up to three more analyzers in `additionalAnalyzers`.

### Presets

The following presets are available without any index-level configuration:

| Preset | Behavior |
| --- | --- |
| `STANDARD` | Compares word by word and ignores case. This is the default when `analyzer` is omitted. |
| `FOLDED` | Works like `STANDARD` and also ignores accents, so `Très` matches `tres`. |
| `IDENTIFIER` | Compares the whole value, ignores case, and removes spaces, `-`, `.`, and `/`. Use it for codes, postal codes, and reference numbers. |
| `SOUNDS_LIKE` | Matches words that sound alike, such as different spellings of the same name. |

### Custom analyzers

When no preset fits, define custom analyzers in the index-level `analyzers` list and select them by `name` in `analyzer` or `additionalAnalyzers`. An index accepts up to 10 custom analyzers. Every custom analyzer must be selected by at least one field. Otherwise, the index request returns `400 Bad Request` with a message such as `Analyzer 'companyName' is not used.`

An analyzer `name` starts with a letter, followed by up to 39 letters, digits, underscores, or hyphens. Preset names, `keyword`, and `folded` are reserved.

A custom analyzer supports the following properties:

| Property | Description |
| --- | --- |
| `name` | Required. Name that fields use to select the analyzer. |
| `basedOn` | Preset that the analyzer starts from: `STANDARD`, `FOLDED`, `IDENTIFIER`, or `SOUNDS_LIKE`. A property you set replaces the value of that preset. |
| `split` | `WORDS` compares word by word. `WHOLE_VALUE` compares the whole value as one token. |
| `ignoreCase` | If set to `true`, upper and lower case are treated as equal. |
| `ignoreAccents` | If set to `true`, letters with and without accents are treated as equal. |
| `ignoreCharacters` | Up to 20 single characters removed before comparing, such as `.`. |
| `ignoreWords` | Up to 200 words ignored when comparing, such as the legal-form suffixes `gmbh` and `ag`. With `WORDS`, each entry must contain only letters and digits, be at most 50 characters long, and stay one word when text is split. |
| `compare` | `SPELLING` compares the letters. `SOUND` matches words that sound alike. |

For example, a company-name analyzer based on `FOLDED` that ignores the words `gmbh` and `ag` matches `Maier GmbH` and `Maier` for the same query.

Analyzers are part of the field definition. Adding, removing, or changing an analyzer starts an update job and returns `202 Accepted`. For more information, see [How to manage indexes and jobs](#how-to-manage-indexes-and-jobs).

### Select an analyzer in a query

A `TEXT` or `PHRASE` query can set `analyzer` to the field's `analyzer` or to one of its `additionalAnalyzers`. The name is not case-sensitive. When `analyzer` is omitted, the query uses the field's `analyzer`. Any other name returns `400 Bad Request` with a message such as `Analyzer 'FOLDED' is not available on field 'name'.`

{% hint style="info" %}
To catch both typos and alternative spellings, combine two clauses on the same field in an `or` group: a `TEXT` clause with fuzzy matching, and a `TEXT` clause with `analyzer` set to `SOUNDS_LIKE` and a lower `boost`. Exact spelling then ranks above matches by sound.
{% endhint %}

## How to index a list of objects

Use `itemFields` when a field holds a list of objects, such as a list of addresses. Set `path` to the list, and declare each child field in `itemFields` with its full path, for example `addresses.street` and `addresses.city`. Each child field supports the same options as a top-level field, including `analyzer` and `additionalAnalyzers`.

Follow these rules when you define a list:

* Do not set `text`, `autocomplete`, `exact`, or `analyzer` on the list itself.
* Declare child fields only inside `itemFields`. A child path declared as a top-level field returns `400 Bad Request` with a message such as `Field 'addresses.street' belongs to 'addresses'. Declare it in itemFields.`
* Search and filter child fields by their full path. The list path itself cannot be searched.

The following rules describe how conditions on a list of objects match list items:

* Conditions on the same list joined by `and` must match the same item. For example, a filter for `addresses.city` equal to `Berlin` and `addresses.zipCode` equal to `10115` matches only when one address has both values. A document with a Berlin address and a separate address with that postal code does not match.
* A lone `NEQ`, `NOT_IN`, or `EXISTS` with `false` on a list field excludes the document when any item matches the value. A document with no items in that list matches.
* When such an operator is joined by `and` with another condition on the same list, it still applies to one item. The document matches when one item meets all conditions.

## Available search criteria

A direct search must provide `index` and at least one of `queries` or `filters`. `queries` can contain one query object, a list of query objects, or an `and` or `or` group. A top-level list matches when any item matches.

The following query types are available:

| Type | Behavior | Index requirement |
| --- | --- | --- |
| `TEXT` | Matches analyzed query tokens. It also supports fuzzy matching with one or two edits. | `text: true` |
| `PHRASE` | Matches adjacent words in the same order. | `text: true` |
| `AUTOCOMPLETE` | Matches according to the configured `PREFIX` or `NGRAM` mode. | `autocomplete` |
| `WILDCARD` | Matches a case-sensitive pattern. `*` matches any number of characters and `?` matches one character. | `text: true` |

`TEXT` and `PHRASE` queries accept an optional `analyzer` that selects one of the field's analyzers. For more information, see [How to control text matching with analyzers](#how-to-control-text-matching-with-analyzers).

### Query examples

Assume the index contains the following values:

* Vehicle A – `name.en` is `Red diesel engine` and `code` is `VH-900`.
* Vehicle B – `name.en` is `Electric city car` and `code` is `EV-100`.

Place one of the following objects in `queries`:

<table>
<thead>
<tr>
<th width="110">Type</th>
<th>Example</th>
<th width="100">Matches</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>TEXT</code></td>
<td><code>{"type":"TEXT","query":"diesel","field":"name.en"}</code></td>
<td>Vehicle A</td>
<td><code>diesel</code> is an analyzed word in its name.</td>
</tr>
<tr>
<td><code>PHRASE</code></td>
<td><code>{"type":"PHRASE","query":"diesel engine","field":"name.en"}</code></td>
<td>Vehicle A</td>
<td>Both words are adjacent and in that order. A value such as <code>Diesel-powered engine</code> does not match.</td>
</tr>
<tr>
<td><code>AUTOCOMPLETE</code></td>
<td><code>{"type":"AUTOCOMPLETE","query":"elec","field":"name.en"}</code></td>
<td>Vehicle B</td>
<td>Requires <code>autocomplete: PREFIX</code> on <code>name.en</code>. Does not match <code>Bioelectric car</code> because <code>elec</code> is not at the start of that word.</td>
</tr>
<tr>
<td><code>WILDCARD</code></td>
<td><code>{"type":"WILDCARD","query":"VH-?00","field":"mixins.vehicleSearchAttributes.code"}</code></td>
<td>Vehicle A</td>
<td><code>?</code> replaces the single character <code>9</code>. Does not match <code>vh-900</code> (case-sensitive) or <code>PRE-VH-900</code> (pattern evaluates the whole stored value).</td>
</tr>
<tr>
<td><code>TEXT</code> (fuzzy)</td>
<td><code>{"type":"TEXT","query":"deisel","field":"name.en","fuzzy":{"enabled":true,"maxEdits":1}}</code></td>
<td>Vehicle A</td>
<td>Swapping the adjacent <code>i</code> and <code>e</code> counts as one edit.</td>
</tr>
<tr>
<td><code>TEXT</code> (fuzzy)</td>
<td><code>{"type":"TEXT","query":"dieselxx","field":"name.en","fuzzy":{"enabled":true,"maxEdits":2}}</code></td>
<td>Vehicle A</td>
<td>Allows the two extra characters. Does not match with <code>maxEdits</code> set to <code>1</code>.</td>
</tr>
</tbody>
</table>

The following filter operators are available:

* `EQ`, `NEQ`, `GT`, `GTE`, `LT`, and `LTE` compare one value.
* `BETWEEN` compares an inclusive range supplied as an array of two values.
* `IN` and `NOT_IN` compare a non-empty array of values.
* `EXISTS` takes a Boolean and checks whether the field is present.
* `CONTAINS` takes a non-blank string and performs a case- and diacritic-insensitive substring match. The field must have `text: true` in the index. The service treats `\`, `*`, and `?` in the value as literal characters.

Queries and filters on fields inside a list of objects follow same-item matching rules. For more information, see [How to index a list of objects](#how-to-index-a-list-of-objects).

### Filter examples

Assume Vehicle C has `status` set to `ACTIVE`, `horsepower` set to `180`, `code` set to `TR-300`, and `name.en` set to `Très Long Description`. The equality, list, range, and existence examples use fields configured with `exact: true`. The `CONTAINS` example uses a field configured with `text: true`.

Place one of the following objects in `filters`:

<table>
<thead>
<tr>
<th width="110">Operator</th>
<th>Example</th>
<th width="100">Matches</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>EQ</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.status","operator":"EQ","value":"ACTIVE"}</code></td>
<td>Vehicle C</td>
<td>Exact equality.</td>
</tr>
<tr>
<td><code>NEQ</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.status","operator":"NEQ","value":"ARCHIVED"}</code></td>
<td>Vehicle C</td>
<td>Excludes the given value.</td>
</tr>
<tr>
<td><code>GT</code> / <code>GTE</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"GT","value":150}</code> · <code>{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"GTE","value":180}</code></td>
<td>Vehicle C</td>
<td>Greater than, or greater than or equal to.</td>
</tr>
<tr>
<td><code>LT</code> / <code>LTE</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"LT","value":200}</code> · <code>{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"LTE","value":180}</code></td>
<td>Vehicle C</td>
<td>Less than, or less than or equal to.</td>
</tr>
<tr>
<td><code>BETWEEN</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.horsepower","operator":"BETWEEN","value":[150,200]}</code></td>
<td>Vehicle C</td>
<td>Inclusive range.</td>
</tr>
<tr>
<td><code>IN</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.status","operator":"IN","value":["ACTIVE","DRAFT"]}</code></td>
<td>Vehicle C</td>
<td>Value is one of the listed items.</td>
</tr>
<tr>
<td><code>NOT_IN</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.status","operator":"NOT_IN","value":["ARCHIVED","DELETED"]}</code></td>
<td>Vehicle C</td>
<td>Value is none of the listed items.</td>
</tr>
<tr>
<td><code>EXISTS</code></td>
<td><code>{"field":"mixins.vehicleSearchAttributes.code","operator":"EXISTS","value":true}</code></td>
<td>Vehicle C</td>
<td><code>code</code> is present.</td>
</tr>
<tr>
<td><code>CONTAINS</code></td>
<td><code>{"field":"name.en","operator":"CONTAINS","value":"tres long"}</code></td>
<td>Vehicle C</td>
<td>Ignores case and diacritics; matches <code>Très Long Description</code>.</td>
</tr>
<tr>
<td><code>CONTAINS</code></td>
<td><code>{"field":"name.en","operator":"CONTAINS","value":"*"}</code></td>
<td>Values such as <code>Model * Special</code></td>
<td>Treats <code>*</code> as a literal character; does not match <code>Model X Special</code>.</td>
</tr>
</tbody>
</table>

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
  'https://api.emporix.io/search/{tenant}/search/VEHICLE/queries/active-vehicles' \
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
  'https://api.emporix.io/search/{tenant}/search/VEHICLE?pageNumber=1&pageSize=20' \
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

## How to manage indexes and jobs

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

Use [Upserting a search index](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search-indexes#put-search-tenant-search-type-indexes-id) to replace an index definition. `metadata.version` is optional. When you send it, it acts as an optimistic lock. A stale value returns `409 Conflict`.

Use [Deleting a search index](https://developer.emporix.io/api-documentation/api-guides/utilities/search-service/api-reference/search-indexes#delete-search-tenant-search-type-indexes-id) to start an asynchronous deletion job:

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X DELETE \
  'https://api.emporix.io/search/{tenant}/search/VEHICLE/indexes/vehicles' \
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
      "type": "VEHICLE",
      "id": "vehicles"
    }
  ]'
```

The response contains `exportedAt` and `data`. The `data` value is a base64-encoded JSON array. Exported items include `id`, `type`, `fields`, optional `analyzers`, and optional localized `name` and `description`. They do not include `status` or `metadata`.
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
    "data": "W3siaWQiOiJ2ZWhpY2xlcyIsInR5cGUiOiJWRUhJQ0xFIiwibmFtZSI6eyJlbiI6IlZlaGljbGVzIn0sImRlc2NyaXB0aW9uIjp7ImVuIjoiU2VhcmNoIHZlaGljbGVzIGJ5IG5hbWUsIGNvZGUsIHN0YXR1cywgYW5kIGhvcnNlcG93ZXIifSwiZmllbGRzIjpbeyJwYXRoIjoibmFtZS5lbiIsInRleHQiOnRydWUsImF1dG9jb21wbGV0ZSI6IlBSRUZJWCJ9LHsicGF0aCI6Im1peGlucy52ZWhpY2xlU2VhcmNoQXR0cmlidXRlcy5jb2RlIiwidGV4dCI6dHJ1ZSwiZXhhY3QiOnRydWV9LHsicGF0aCI6Im1peGlucy52ZWhpY2xlU2VhcmNoQXR0cmlidXRlcy5zdGF0dXMiLCJleGFjdCI6dHJ1ZX0seyJwYXRoIjoibWl4aW5zLnZlaGljbGVTZWFyY2hBdHRyaWJ1dGVzLmhvcnNlcG93ZXIiLCJleGFjdCI6dHJ1ZX1dfV0="
  }'
```

Import returns one result per index. A result includes `jobId` and `jobType` when a create or update job starts. Those fields are absent when a ready index keeps the same field definition. Import is not atomic. If one index fails, indexes processed before it remain created or updated. Review those indexes before retrying the package.

Monitor every returned job under `{destinationTenant}` before searching the imported indexes.
{% endstep %}
{% endstepper %}
