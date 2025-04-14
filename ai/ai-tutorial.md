---
seo:
  title: Artificial Intelligence Tutorials
  description: ai, text for descriptions
toc:
  enable: true
tocMaxDepth: 3
editPage:
  disable: true
label: Tutorials
---

# AI Tutorials

 With Emporix support for AI, you can enhance text for product descriptions and generate AI completions.

 ## Before you start

 Make sure to configure your API token. To do that, you can use the [Configuration Service](https://developer.emporix.io/docs/openapi/configuration/) and store the token under `openAiApiToken` key.

 ## How to generate an AI supported text for a product

You can generate the text by sending a request based on a provided prompt. To send the request, use the [ Generating text for an object description](/openapi/ai/#operation/POST-ai-generate-description) endpoint.

<OpenApiTryIt
  definitionId="ai"
  operationId="POST-ai-generate-description"
  defaultExample="Text generation request"
/>

## How to generate an AI completion

Completion is generated based on chat history. It's a generated response or continuation of a conversation, crafted by the AI to address the given input in context. 
It can include answering questions, providing suggestions, or completing a sentence or thought. 
The currently supported AI engine for the completion is [OpenAI](https://platform.openai.com/). 
To generate the AI completion, send the request using the [ AI Completion](/openapi/ai/#operation/POST-ai-completion) endpoint.

<OpenApiTryIt
  definitionId="ai"
  operationId="POST-ai-completions"
  defaultExample="Completion request"
/>

:::note

To see some more examples of using AI at Emporix, check our guides for Management Dashboard - [Powered by AI](https://developer.emporix.io/user-guides/extensibility-and-integrations/ai/ai-intro).

:::