---
layout:
  width: wide
icon: graduation-cap
---

# AI RAG Indexer Tutorial

You can use the AI RAG Indexer Service to keep your vector database in sync with Emporix product data and to understand which attributes are available for Retrieval-Augmented Generation (RAG) and filtering.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../artificial-intelligence/ai-rag-indexer/api-reference/" %}
[api-reference](../../artificial-intelligence/ai-rag-indexer/api-reference/)
{% endcontent-ref %}

## How to prepare RAG indexing

{% stepper %}
{% step %}
### Discover RAG fields
Call the [Listing fields for RAG search](https://developer.emporix.io/api-references/api-guides/api-guides-and-references/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-rag-metadata) endpoint to list the fields that can be embedded for RAG search results. The request requires the `ai.agent_read` scope. This helps you align your prompts and downstream ranking logic.

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/{type}/rag-metadata' \
  --header 'Authorization: Bearer <ACCESS_TOKEN>' \
  --header 'Accept: application/json'
```

Sample response:

```bash
[
  "code",
  "name.en",
  "labels.description.de",
  "mixins.additionalattributes.temperature",
  "segmentIds"
]
```
The returned values are the field paths that match your product schema. Use the list to decide which attributes to embed or exclude before reindexing. 

{% endstep %}

{% step %}
### Create an AI tool using RAG functionality

When you already know which fields you can index, call the [Listing fields for vector search filtering](https://developer.emporix.io/api-references/api-guides/api-guides-and-references/artificial-intelligence/ai-service/api-reference/tool#put-ai-service-tenant-agentic-tools-toolid) endpoint to create a RAG AI tool.

```bash
curl --location --globoff --request PUT 'https://api.emporix.io/ai-service/{tenant}/agentic/tools/{toolId}' \
--header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' \
--header 'Content-Type: application/json' \
--data '{
  "id": "rag-product",
  "name": "Product Search RAG Tool",
  "type": "rag_emporix",
  "config": {
    "entityType": "product",
    "prompt": "You are a search tool for searching products.",
    "indexedFields": [
      {
        "name": "",
        "key": "code"
      },
      {
        "name": "",
        "key": "name.en"
      },
      {
        "name": "",
        "key": "description.en"
      }
    ]
  },
  "enabled": true
}'
```

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../artificial-intelligence/ai-service/api-reference/" %}
[api-reference](../../artificial-intelligence/ai-service/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Trigger a reindex job
When the tool is ready, call the [Reindexing the entities of given type](https://developer.emporix.io/api-references/api-guides/api-guides-and-references/artificial-intelligence/ai-rag-indexer/api-reference/reindex#POST-ai-rag-indexer-tenant-type-reindex) endpoint to regenerate embeddings for the selected entity type. The reindex endpoint currently performs a full rebuild.

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-rag-indexer/{tenant}/{type}/reindex' \
  --header 'Authorization: Bearer <ACCESS_TOKEN>' \
  --header 'Accept: */*'
```

The service fetches every entity of the specified type (currently `PRODUCT`). Embeddings are generated per entity using Emporix defaults and the vector database records are updated. You receive the `204 No Content` response once the job is scheduled successfully.

{% hint style="danger" %}
Reindexing is a computationally expensive and time-consuming operation, especially for large catalogs. It may significantly increase infrastructure costs, processing time, and overall system load.
For this reason, perform reindexing only when truly necessary - for example, after major configuration changes, embedding model updates, or structural schema modifications. Avoid triggering it frequently or without clear intent.
{% endhint %}

{% endstep %}
{% endstepper %}