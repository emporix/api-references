---
layout:
  width: wide
icon: graduation-cap
---

# AI Tutorials

With Emporix support for AI, you can enhance text for product descriptions and generate AI completions.

## Before you start

Make sure to configure your API token. To do that, you can use the [Configuration Service](../../configuration/configuration-service/api-reference/) and store the token under `openAiApiToken` key.

Send the request to the [Creating Configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#post-configuration-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations' 
  --header 'Content-Type: application/json' 
  --data '[
    {
      "_id": "openAiApiToken",
      "value": "mc-ZtG7zOY9lywNv2539383fLeJr34444",
      "version": 1,
      "secured": false
    }
]
```

## How to generate an AI supported text for a product

You can generate the text by sending a request based on a provided prompt. To send the request, use the [Text Generation](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/text-generation) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../artificial-intelligence/ai-service/api-reference/" %}
[api-reference](../../artificial-intelligence/ai-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'http://api.emporix.io/ai-service/{tenant}/texts' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "id": "en",
    "prompt": "Generate a long description for product '\''pipe cutter'\'' in language EN ",
    "maxTokens": 2048
  }'
```

## How to generate an AI completion

Completion is generated based on chat history. It's a generated response or continuation of a conversation, crafted by the AI to address the given input in context.
It can include answering questions, providing suggestions, or completing a sentence or thought.
The currently supported AI engine for the completion is [OpenAI](https://platform.openai.com/).
To generate the AI completion, send the request using the [AI Completions](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/ai-completions) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../artificial-intelligence/ai-service/api-reference/" %}
[api-reference](../../artificial-intelligence/ai-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'http://api.emporix.io/ai-service/{tenant}/completions' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
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
To see some more examples of using AI at Emporix, check our guides for Management Dashboard - [Powered by AI](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/ai-intro/ai-config).
{% endhint %}

## How to create an AI agent using a template

Create an AI agent using one of Emporix agent template.

{% stepper %}
{% step %}
### Get the agent template ID 
To create an agent, you'll need a template ID.
* Either, retrieve all the available agent templates by calling the [Listing available agent templates](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template) endpoint.

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/templates' \
  --header 'Accept: */*'
```
* Use the [Searching agent templates](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template) endpoint to find the specific agent template.

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/templates/search' \
  --header 'Content-Type: application/json' \
  --data '{
    "q": "name:~Support"
  }'
```
Copy and note down the template ID of your interest.
{% endstep %}

{% step %}
### Create an agent
Call the [Creating agent instance based on the template](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template) endpoint to add an agent to your system. In the path parameter, provide the `templateID` you have copied.

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/mytenant/agentic/templates/123/agent' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": {
      "en": "Complaint Agent"
    },
    "description": {
      "de": "Agent which is responsible for reading emails and base on that resolve the customer's complaints"
    },
    "id": "a81bc81b-dead-4e5d-abff-90865d1e13b1"
  }'
```

{% endstep %}

## How to search for the AI Agents

When you want to add a trigger for an enabled AI agent through API, for example as a part of a digital process or from an external system, you need to fetch the specific agent details.

* Use the [Searching agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent/search) endpoint to pass a query parameter against the agents in your system. 

For example, to find agents of `Complaint` type:

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/mytenant/agentic/agents/search' \
  --header 'Content-Type: application/json' \
  --data '{
    "q": "name:~Complaint"
  }'
```

* If you know the agent's ID, you can use the [Retrieving the agent by ID]()endpoint.

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/mytenant/agentic/agents/invoice-complaint' \
  --header 'Accept: */*'
```

You can use the retrieved details to establish the required connections and triggers for the AI Agent.