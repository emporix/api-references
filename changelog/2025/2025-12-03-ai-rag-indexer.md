---
icon: sparkles
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: false
  pagination:
    visible: true
---

# 2025-12-03: AI Rag Indexer - New endpoints for configuring RAG Search Functionality

## Overview

Introduced new endpoints in `ai-rag-indexer` service which are necessary for configuring and performing RAG Search.

## Added endpoints

| Endpoint                                                                                                                                                                            | Description                                                                |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|
| [Reindexing the entities of given type](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/reindex#GET-ai-rag-indexer-tenant-type-reindex)                           | Endpoint for triggering reindexing process.                                |
| [Listing fields for RAG search](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-rag-metadata)       | Endpoint for retrieving possible fields destined for computing embeddings. |
| [Listing fields for vector search filtering](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-filter-metadata) | Endpoint for retrieving fields destined to filtering database entries.     |

## Known problems

There are no known problems.

 
