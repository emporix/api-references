---
icon: hourglass-half
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

# 2025-12-04: AI Service - Deprecation of SSE transport protocol

## Overview

Since the official deprecation of the SSE transport in the Model Context Protocol
spec [details here](https://github.com/modelcontextprotocol/modelcontextprotocol/pull/665?ref=changelog.keboola.com), MCP clients have been
moving away from SSE.
Based on the official deprecation, we are deprecating the `sse` transport protocol in the AI Service as well.

## Modified endpoints

| Endpoint                                                                                                                                                                                                    | Description                                 |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------|
| [Searching MCP servers](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/mcp-server#post-ai-service-tenant-agentic-mcp-servers-search)               | The `SSE` transport protocol is deprecated. |
| [Retrieving MCP server by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/mcp-server#get-ai-service-tenant-agentic-mcp-servers-mcpserverid)     | The `SSE` transport protocol is deprecated. |
| [Upserting MCP server](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/mcp-server#put-ai-service-tenant-agentic-mcp-servers-mcpserverid)            | The `SSE` transport protocol is deprecated. |
| [Partially updating MCP server](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/mcp-server#patch-ai-service-tenant-agentic-mcp-servers-mcpserverid) | The `SSE` transport protocol is deprecated. |

## Known problems

There are no known problems.

