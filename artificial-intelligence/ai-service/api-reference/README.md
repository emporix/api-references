---
layout:
  width: wide
icon: rectangle-terminal
---

# API Reference

## Streaming chat responses

AI Service supports streaming LLM responses for endpoint-triggered agents through a dedicated Server-Sent Events (SSE) endpoint.

### POST `/{tenant}/agentic/chat-stream`

Streams chat output as `text/event-stream` instead of returning a single JSON response.

#### Request

- **Path parameter:** `tenant`
- **Content-Type:** `application/json`
- **Accept:** `text/event-stream`
- **Request body:** `AgenticRequest`

The endpoint accepts the same request-context headers as the existing endpoint chat flow and forwards them to the downstream runtime when present:

- `session-id`
- `request-id`
- `scopes`
- `Hybris-User`
- `Hybris-User-Id`
- `Hybris-Session-Id`
- `Client-Id`
- `Legal-Entity-Id`
- `saas-token`

#### Response

- **200 OK**
- **Content-Type:** `text/event-stream`
- **Body:** SSE stream of string payload events

The endpoint can also return a client error before the stream starts if request validation fails or the target agent cannot be used.

#### Behavior

This endpoint is additive and does not replace the existing non-streaming chat endpoints.

The streaming flow follows the same endpoint-agent validation rules as the synchronous chat flow:

- the agent must exist and be enabled,
- the agent must support endpoint triggering,
- required scopes must be satisfied before the stream starts.

Attachment validation is also performed before the stream starts, so requests that reference existing uploaded attachments follow the same validation path as non-streaming endpoint chat.

> Event names and payload shapes are proxied from the downstream AI Agentic streaming endpoint and are not further specified in this reference.


 
