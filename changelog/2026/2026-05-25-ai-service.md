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

# 2026-05-25: AI Service - RAG_EMPORIX filter fields

## Overview

The tool of `RAG_EMPORIX` type has been enhanced with a `filterFields` field, which allows specifying which fields are available for filtering in the vector index.

## Updated endpoints

| Endpoint                                                                                                                                                     | Description                                      |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------|
| [Listing tools](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#GET-ai-list-tools)              | Response enhanced with `filterFields` field.     |
| [Searching tools](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#POST-ai-search-tools)         | Response enhanced with `filterFields` field.     |
| [Retrieving tool by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#GET-ai-retrieve-tool)   | Response enhanced with `filterFields` field.     |
| [Upserting tool](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#PUT-ai-upsert-tool)            | Request body enhanced with `filterFields` field. |
| [Partially updating tool](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#PATCH-ai-update-tool) | Request body enhanced with `filterFields` field. |

## Known problems

There are no known problems.
