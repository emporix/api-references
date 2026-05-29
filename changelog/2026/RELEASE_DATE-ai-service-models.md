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

# RELEASE_DATE: AI Service - LLM models from supported providers

## Overview

The AI Service has been enhanced with a new endpoint that lists available LLM models from supported LLM providers: OpenAI, Anthropic, and Google.

The service retrieves models directly from each provider's models API.

Each model entry includes an identifier, display name, optional description, and a `thinking` flag indicating whether the model supports thinking capabilities.

## New endpoints

| Endpoint                                                                                                                                                                                          | Description                                                                                    |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------|
| [Listing LLM models from supported providers](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/model#GET-ai-list-models) | Returns models grouped by provider (`openai`, `anthropic`, `google`). Requires `ai.agent_read`. |

## Known problems

There are no known problems.
