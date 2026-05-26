---
icon: graduation-cap
layout:
  width: wide
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
---

# AI RAG Indexer Tutorial

You can use the AI RAG Indexer Service to keep your vector database in sync with Emporix data and to discover which attributes are available for Retrieval-Augmented Generation (RAG) and filtering. The service supports the built-in **product** entity type and **custom entity types** created in the [Schema Service](https://developer.emporix.io/api-references/api-guides/utilities/schema/).

Follow this tutorial to learn how to create a RAG tool with indexable and filterable fields that you can use in an AI agent.

## Prerequisites

* The OAuth2 access token must include the `ai.agent_read` and `ai.agent_manage` scopes.
* For custom entities, the custom type must exist in Schema Service. The `{type}` in indexer URLs must match the `config.entityType`.

## How to prepare RAG indexing

{% stepper %}
{% step %}
#### Discover indexable fields

Before creating a RAG tool, call the AI RAG Indexer metadata endpoints for your entity type.

Call the [Listing fields for RAG search](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-retrieve-rag-metadata) endpoint to get the RAG fields. 

{% tabs %}
{% tab title="Product" %}

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/product/rag-metadata' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: application/json'
```

Sample response:

```json
[
  "code",
  "name.en",
  "labels.description.de",
  "mixins.additionalattributes.temperature",
  "segmentIds"
]
```

{% endtab %}

{% tab title="Custom Entity" %}

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/car-parts/rag-metadata' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: application/json'
```

Sample response (field paths depend on your custom schema):

```json
[
  "code",
  "name.en",
  "description.en",
  "mixins.carparts.brand",
  "mixins.carparts.oemNumber",
  "mixins.carparts.vehicleCompatibility",
  "mixins.carparts.specifications"
]
```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
Replace the sample paths with the values returned by `rag-metadata` for your tenant. Mixin keys must match your Schema Service attribute definitions.
{% endhint %}

Use the response paths in the `indexedFields[].key` when you 
create a RAG tool in the upcoming step.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
#### Discover filterable fields

Call the [Listing fields for vector search filtering](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-filter-metadata) endpoint to retrieve the field paths for filtering search.

{% tabs %}
{% tab title="Product" %}

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/product/filter-metadata' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: application/json'
```

Sample response:

```json
[
  { "key": "code", "type": "string" },
  { "key": "id", "type": "string" },
  { "key": "published", "type": "boolean" },
  { "key": "segmentIds", "type": "list" }
]
```

{% endtab %}

{% tab title="Custom Entity" %}

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/car-parts/filter-metadata' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: application/json'
```

Sample response (field paths depend on your custom schema):

```json
[
  { "key": "id", "type": "string" },
  { "key": "code", "type": "string" },
  { "key": "mixins.carparts.brand", "type": "string" },
  { "key": "mixins.carparts.category", "type": "string" },
  { "key": "mixins.carparts.vehicleMake", "type": "string" },
  { "key": "published", "type": "boolean" },
  { "key": "mixins.carparts.inStock", "type": "boolean" }
]
```

{% endtab %}
{% endtabs %}

Use the returned field paths in `filterFields[].key` when creating the tool in the upcoming step. 

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
#### Create an AI tool using RAG functionality

When you know which fields to index and filter, call the [Upserting tool](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#put-ai-service-tenant-agentic-tools-toolid) endpoint to create or update a `rag_emporix` tool. 

Set the `toolId` in the URL path (for example, `rag-product` or `rag-car-parts`). The `indexedFields` and `filterFields` are required for `rag_emporix` tools – specify the paths from the responses returned in previous steps:
* The `indexedFields` can use optional name aliases. 
* For the `filterFields`, add relevant descriptions so that the agent knows when to apply the filters.

{% tabs %}
{% tab title="Product" %}

```bash
curl --request PUT \
  'https://api.emporix.io/ai-service/{tenant}/agentic/tools/rag-product' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "Product Search RAG Tool",
    "type": "rag_emporix",
    "enabled": true,
    "config": {
      "prompt": "Use this tool when the user asks to find, compare, or look up products in the catalog.",
      "entityType": "product",
      "embeddingConfig": {
        "provider": "emporix_openai"
      },
      "indexedFields": [
        { "key": "code", "name": "Product code" },
        { "key": "name.en", "name": "English name" },
        { "key": "description.en", "name": "English description" }
      ],
      "filterFields": [
        {
          "key": "code",
          "name": "Product code",
          "description": "Exact product SKU or catalog code. Use when the user provides a specific product code."
        },
        {
          "key": "published",
          "name": "Published",
          "description": "Set to true when the user should only see products visible in the catalog."
        },
        {
          "key": "segmentIds",
          "name": "Customer segments",
          "description": "List of segment IDs. Use when results must be limited to products available for specific customer segments."
        }
      ]
    }
  }'
```

{% endtab %}

{% tab title="Custom Entity" %}

```bash
curl --request PUT \
  'https://api.emporix.io/ai-service/{tenant}/agentic/tools/rag-car-parts' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "Car Parts Search",
    "type": "rag_emporix",
    "enabled": true,
    "config": {
      "prompt": "Use this tool when the user asks to find automotive parts by name, part number, OEM reference, or vehicle fitment (make, model, year).",
      "entityType": "car-parts",
      "embeddingConfig": {
        "provider": "emporix_openai"
      },
      "indexedFields": [
        { "key": "code", "name": "Part number" },
        { "key": "name.en", "name": "English part name" },
        { "key": "description.en", "name": "English description" },
        { "key": "mixins.carparts.brand", "name": "Brand" },
        { "key": "mixins.carparts.oemNumber", "name": "OEM number" },
        { "key": "mixins.carparts.vehicleCompatibility", "name": "Vehicle compatibility" },
        { "key": "mixins.carparts.specifications", "name": "Technical specifications" }
      ],
      "filterFields": [
        {
          "key": "code",
          "name": "Part number",
          "description": "SKU or catalog part number. Use when the user provides an exact part number."
        },
        {
          "key": "mixins.carparts.oemNumber",
          "name": "OEM number",
          "description": "Original equipment manufacturer part number. Use when the user searches by OEM reference."
        },
        {
          "key": "mixins.carparts.brand",
          "name": "Brand",
          "description": "Manufacturer or aftermarket brand (for example Bosch, Brembo, Mann)."
        },
        {
          "key": "mixins.carparts.category",
          "name": "Category",
          "description": "Part category such as brakes, filters, engine, suspension, or electrical."
        },
        {
          "key": "mixins.carparts.vehicleMake",
          "name": "Vehicle make",
          "description": "Vehicle manufacturer (for example Volkswagen, BMW, Ford). Use for fitment filtering."
        },
        {
          "key": "mixins.carparts.vehicleModel",
          "name": "Vehicle model",
          "description": "Vehicle model (for example Golf, 3 Series). Use together with make and year."
        },
        {
          "key": "mixins.carparts.vehicleYear",
          "name": "Model year",
          "description": "Production or model year (for example 2018). Use for fitment filtering."
        },
        {
          "key": "mixins.carparts.condition",
          "name": "Condition",
          "description": "Part condition. Possible values: NEW, REFURBISHED, USED."
        },
        {
          "key": "published",
          "name": "Published",
          "description": "Set to true when the user should only see parts available in the catalog."
        },
        {
          "key": "mixins.carparts.inStock",
          "name": "In stock",
          "description": "Set to true when the user asks for parts that can be ordered now."
        }
      ]
    }
  }'
```

{% endtab %}
{% endtabs %}

{% hint style="info" %}
Align `indexedFields` and `filterFields` with the output of `rag-metadata` and `filter-metadata` for your tenant. 
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../ai-service/api-reference/" %}
[api-reference](../ai-service/api-reference/)
{% endcontent-ref %}
{% endstep %}

{% step %}
#### Trigger a reindex job

When the tool is configured, call the [Reindexing the entities of given type](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/reindex#GET-ai-rag-indexer-tenant-type-reindex) endpoint to regenerate embeddings for the selected entity type. The reindex endpoint currently performs a full rebuild.

{% tabs %}
{% tab title="Product" %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/product/reindex' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: */*'
```

{% endtab %}

{% tab title="Custom Entity" %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/car-parts/reindex' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: */*'
```

{% endtab %}
{% endtabs %}

The service fetches every entity of the specified type (`product` or custom entity type). Embeddings are generated per entity and vector database records are updated. You receive the `204 No Content` response once the job is scheduled successfully.

{% hint style="danger" %}
Reindexing is a computationally expensive and time-consuming operation, especially for large catalogs. It may significantly increase infrastructure costs, processing time, and overall system load. For this reason, perform reindexing only when truly necessary — for example, after major configuration changes, embedding model updates, or structural schema modifications. Avoid triggering it frequently or without clear intent.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
#### Attach the tool to an agent

Assign the tool ID (for example, `rag-product`, `rag-car-parts`) to an AI agent so it can be invoked during agentic chat. Use the [Upserting agent](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#put-ai-service-tenant-agentic-agents-agentid) endpoint or configure the agent in Management Dashboard.

{% hint style="info" %}
For broader agent setup and chat flows, see the [AI Service Tutorial](../ai-service/ai-tutorial.md).
{% endhint %}

{% endstep %}
{% endstepper %}
