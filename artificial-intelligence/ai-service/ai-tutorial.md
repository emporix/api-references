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

* If you know the agent's ID, you can use the [Retrieving the agent by ID]() endpoint.

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/mytenant/agentic/agents/invoice-complaint' \
  --header 'Accept: */*'
```

You can use the retrieved details to establish the required connections and triggers for the AI Agent.

## How to communicate with an Agent 

For some Agents, it is convenient to trigger their actions by API calls. To allow communication with the selected agent, you can use the dedicated endpoints.

* When instant responses are required from the agent, send the request to the [Starting agent chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent/chat)

```bash
curl -L 'https://api.emporix.io/ai-service/{tenant}/agentic/chat' \
-H 'tenant: {tenant}' \
-H 'scopes: ai.completion_manage' \
-H 'Content-Type: application/json' \
-H 'Authorization: Basic {token}' \
-d '{
    "agentId": "de-agent",
    "message": "{\"id\":\"delightCoffee\",\"name\":{\"en\":\"Delight Coffee\"},\"yrn\":\"urn:yaas:saasag:caasproduct:product:{tenant};delightCoffee\",\"code\":\"delightCoffee\",\"description\":{\"en\":\"Awaken your senses with our hand-selected Gourmet Coffee, crafted for true coffee lovers who crave depth, aroma, and sophistication in every sip. Sourced from the world’s finest high-altitude farms, each bean is carefully harvested at peak ripeness, then small-batch roasted to unlock its natural sweetness and complex flavor notes.\"},\"media\":[],\"productType\":\"BASIC\",\"template\":{},\"published\":false,\"metadata\":{\"version\":1,\"createdAt\":\"2025-09-25T04:42:42.607Z\",\"modifiedAt\":\"2025-09-25T04:42:42.607Z\"}}"
}'
```

Trigger the specific agent providing its `agentId`. In the `message`, type in your query or data you want the agent to process.

In the above example, the German Translation Agent is triggered. The Agent acts according to its defined prompt - here, the agent is programmed to find the product `name` and `description` in the request message and translate the fields into German language. As a result, the Agent gets back with the following response:

```
{
    "agentId": "de-agent",
    "agentType": "generic",
    "message": "{
        "id":"delightCoffee",
        "name":{
            "en":"Delight Coffee",
            "de":"Delight Kaffee"
        },
        "yrn":"urn:yaas:saasag:caasproduct:product:mytenant;delightCoffee",
        "code":"delightCoffee",
        "description":{
            "en":"Awaken your senses with our hand-selected Gourmet Coffee, crafted for true coffee lovers who crave depth, aroma, and sophistication in every sip. Sourced from the world’s finest high-altitude farms, each bean is carefully harvested at peak ripeness, then small-batch roasted to unlock its natural sweetness and complex flavor notes.",
            "de":"Wecken Sie Ihre Sinne mit unserem handverlesenen Gourmetkaffee, kreiert für wahre Kaffeeliebhaber, die Tiefe, Aroma und Raffinesse in jedem Schluck suchen. Aus den besten Hochlandfarmen der Welt bezogen, wird jede Bohne sorgfältig zum Höhepunkt ihrer Reife geerntet und dann in kleinen Chargen geröstet, um ihre natürliche Süße und komplexen Geschmacksnoten freizusetzen."
        },
        "media":[],
        "productType":"BASIC",
        "template":{},
        "published":false,"metadata":{
            "version":1,
            "createdAt":"2025-09-25T04:42:42.607Z",
            "modifiedAt":"2025-09-25T04:42:42.607Z"
        }
    }",
    "sessionId": "33a550d0-d812-4fb2-bb0d-d50dbfe3627b"
}
```

* When it is more pragmatic to wait for the agent's response, for example, when the agent needs to process more data which takes more time, or the agent needs to wait for another task to be completed, use the asynchronous communication. 
Send the request to the agent using the [Starting agent async chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent/chat-async).

```bash
curl -L 'https://api.emporix.io/ai-service/{tenant}/agentic/chat-async' \
-H 'tenant: {tenant}' \
-H 'Content-Type: application/json' \
-H 'Authorization: Basic {token}' \
-d '{
    "agentId": "complaint-agent",
    "message": Find the details of the customer order \"EON1243\"."
}'
```

Similarly, provide the relevant `agentId` and pass your query in the `message`.

In async requests, the response contains the `jobId` parameter, for example:

```
{
    "jobId": "68e3a593b2cb061e36630849"
}
```
Use the `jobId` to check details of the job through the [Retrieving agent job by its ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent/jobs) endpoint. For example:

```bash
curl -X 'GET' \
  'https://api.emporix.io/ai-service/{tenant}/jobs/68e3a593b2cb061e36630849' \
  -H 'accept: application/json'
```

The job entity contains information about the request and response from the agent.

## How to export and import AI agents

Exporting lets you back up or migrate enabled agents (together with their dependent tools and MCP servers). Importing restores those exports in another tenant or environment.

{% stepper %}
{% step %}
### Export agents
Collect the `agentIds` you want to export, then call the [Exporting agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent/export) endpoint.

curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/export' \
  --header 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  --header 'Content-Type: application/json' \
  --data '{
    "agentIds": [
      "complaint-agent-id"
    ]
  }'The response contains:

* `data`: a Base64-encoded JSON payload with the exported agents, tools, and MCP servers.
* `checksum`: a hash of the decoded `data` string.
* `jobId`: the export job identifier (you can poll the [Retrieving agent job by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent/jobs) endpoint if you need job status updates).

Store both `data` and `checksum`. You will need them when importing.
{% endstep %}

{% step %}
### Import agents
Use the payload obtained during export and call the [Importing agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent/import) endpoint. Import requires the `ai.agent_manage` scope.

curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/import' \
  --header 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  --header 'Content-Type: application/json' \
  --data '{
    "data": "<BASE64_PAYLOAD_FROM_EXPORT>",
    "checksum": "<CHECKSUM_FROM_EXPORT>"
  }'The response summarizes what was imported and returns a `jobId`. If the imported entities rely on tools or MCP servers that already exist, the service resolves them automatically; otherwise, new instances are created in the disabled state so that you can review and enable them after import.
{% endstep %}
{% endstepper %}

