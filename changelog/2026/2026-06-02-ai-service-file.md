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

# 2026-06-02: AI Service - Supports file upload

## Overview

The AI Service has been enhanced with a new endpoint that allows you to upload a file and attach it to the agent. Then, when calling chat
endpoints it is possible to reference this file.

## New endpoints

| Endpoint                                                                                                                                                                                      | Description                  |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|
| [Uploading attachment](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-agentId-attachments) | Attaches a file to the agent |

## Updated endpoints

| Endpoint                                                                                                                                                                                  | Description                                     |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| [Starting agent chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat)             | Request body extended with `attachments` field. |
| [Starting agent async chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat-async) | Request body extended with `attachments` field. |

## Known problems

There are no known problems.
