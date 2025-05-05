# AI Tutorials

With Emporix support for AI, you can enhance text for product descriptions and generate AI completions.

## Before you start

Make sure to configure your API token. To do that, you can use the [Configuration Service](https://developer.emporix.io/docs/openapi/configuration/) and store the token under `openAiApiToken` key.

## How to generate an AI supported text for a product

You can generate the text by sending a request based on a provided prompt. To send the request, use the [Text Generation](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/artificial-intelligence/ai-service/api-reference/text-generation) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/text-generation)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'http://api.emporix.io/ai-service/{tenant}/texts' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "en",
    "prompt": "Generate a long description for product '\''pipe cutter'\'' in language EN ",
    "maxTokens": 2048
  }'
```

## How to generate an AI completion

Completion is generated based on chat history. It's a generated response or continuation of a conversation, crafted by the AI to address the given input in context.\
It can include answering questions, providing suggestions, or completing a sentence or thought.\
The currently supported AI engine for the completion is [OpenAI](https://platform.openai.com/).\
To generate the AI completion, send the request using the

{% content-ref url="artificial-intelligence/ai-service/api-reference/ai-completions/" %}
[ai-completions](artificial-intelligence/ai-service/api-reference/ai-completions/)
{% endcontent-ref %}

endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'http://api.emporix.io/ai-service/{tenant}/completions' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "abc-123",
    "messages": [
      {
        "role": "SYSTEM",
        "content": "You are an assistant responsible for creating a configuration based on information provided by user."
      }
    ]
  }'
```

{% hint style="info" %}
To see some more examples of using AI at Emporix, check our guides for Management Dashboard - [Powered by AI](https://developer.emporix.io/user-guides/extensibility-and-integrations/ai/ai-intro).
{% endhint %}
