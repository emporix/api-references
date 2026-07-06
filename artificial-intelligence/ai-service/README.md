---
layout:
  width: wide
icon: robot-astromech
---

# AI Service

The service facilitates and streamlines e-commerce processes of product marketing.

### Key features and benefits

* Provides seamless integration with the [OpenAI platform](https://platform.openai.com/)
* Generates compelling product descriptions
* Empowers product managers to streamline the creation and updating of product content
* Creates attention-grabbing descriptions using diverse writing styles
* Ensures consistency in tone and language across all content
* Increases visibility through search engine optimization
 
## Streaming chat responses

AI Service supports streaming LLM output for endpoint-triggered agents through a dedicated Server-Sent Events (SSE) endpoint.

### New endpoint

- **POST** `/{tenant}/agentic/chat-stream`
- **Response content type:** `text/event-stream`
- **Request body:** `AgenticRequest` JSON payload

This endpoint is additive. Existing non-streaming chat flows remain unchanged.

### Request headers

The streaming endpoint accepts the same request context headers used for endpoint chat, including:

- `session-id`
- `request-id`
- `scopes`
- `Hybris-User`
- `Hybris-User-Id`
- `Hybris-Session-Id`
- `Client-Id`
- `Legal-Entity-Id`
- `saas-token`

### Behavior

Before the stream starts, AI Service validates the request in the same way as the existing endpoint chat flow:

- validates the target agent
- requires an enabled agent with `TriggerType.ENDPOINT`
- validates required scopes
- validates LLM token usage
- validates attachments referenced by the request

After validation, AI Service proxies the SSE response from the downstream runtime.

### Compatibility notes

- Clients must support SSE and consume `text/event-stream` responses.
- The implementation uses a dedicated streaming endpoint instead of switching behavior on the existing chat endpoint.
- Attachment validation is preserved on the streaming path, but the exact downstream SSE event taxonomy and payload shape are not documented in this file.

