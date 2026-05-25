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

# RELEASE_DATE: AI Rag Indexer - `name` and `description` fields from `/filter-metadata` endpoint deprecated

## Overview

The fields `name` and `description` from the response of `/filter-metadata` endpoint of AI Rag Indexer have been deprecated. These fields
were previously used to provide additional information about the filters, but they are no longer necessary for the functionality of the
service. They will be removed on **2026-12-01**.

## Affected endpoint

| Endpoint                                                                                                                                                                                                          | Description                                                                 |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------|
| [Listing fields for vector search filtering](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-filter-metadata) | Fields `name` and `description` from the response are marked as deprecated. |

## Known problems

There are no known problems.
