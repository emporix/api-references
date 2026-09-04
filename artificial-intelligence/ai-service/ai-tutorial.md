---
icon: graduation-cap
layout:
  width: wide
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
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
curl -L \
  --request POST \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
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

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/ai-service/{tenant}/texts' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "en",
    "prompt": "Generate a long description for product '\''pipe cutter'\'' in language EN ",
    "maxTokens": 2048
  }'
```

## How to generate an AI completion

Completion is generated based on chat history. It's a generated response or continuation of a conversation, crafted by the AI to address the given input in context. It can include answering questions, providing suggestions, or completing a sentence or thought. The currently supported AI engine for the completion is [OpenAI](https://platform.openai.com/). To generate the AI completion, send the request using the [AI Completions](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/ai-completions) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/ai-service/{tenant}/completions' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
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

## How to create an AI agent using a template

Create an AI agent using one of Emporix agent template.

#### Get the agent template ID

To create an agent, you'll need a template ID.

* Either, retrieve all the available agent templates by calling the [Listing available agent templates](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template#get-ai-service-tenant-agentic-templates) endpoint.

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/templates' \
  --header 'Accept: */*'
```

* Use the [Searching agent templates](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template#post-ai-service-tenant-agentic-templates-search) endpoint to find the specific agent template.

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/templates/search' \
  --header 'Content-Type: application/json' \
  --data '{
    "q": "name:~Complaint"
  }'
```

Copy and note down the template ID of your interest.

#### Create an agent

Call the [Creating agent instance based on the template](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template#post-ai-service-tenant-agentic-templates-templateid-agent) endpoint to add an agent to your system. In the path parameter, provide the `templateID` you have copied.

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

## How to search for the AI Agents

When you want to add a trigger for an enabled AI agent through API, for example as a part of a digital process or from an external system, you need to fetch the specific agent details.

* Use the [Searching agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#post-ai-service-tenant-agentic-agents-search) endpoint to pass a query parameter against the agents in your system.

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

* If you know the agent's ID, you can use the [Retrieving the agent by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#get-ai-service-tenant-agentic-agents-agentid) endpoint.

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/mytenant/agentic/agents/invoice-complaint' \
  --header 'Accept: */*'
```

You can use the retrieved details to establish the required connections and triggers for the AI Agent.

## How to create an MCP server and attach it to an agent

You can manage two types of tenant MCP servers through the API:

* **Custom** (`type: custom`) – points at your own MCP implementation with a URL and transport. Use this to connect agents to an external system, such as an ERP.
* **Dynamic** (`type: dynamic`) – defines `tools` inline. Each tool invokes an Emporix Cloud Function (`config.invocation.functionId`).

The workflow is the same for both types: create the server, attach it to an agent, then verify. The examples below show requests for custom and dynamic MCP management.

{% hint style="info" %}
Emporix also provides predefined domain MCP servers (`type: predefined`) that you can attach to an agent. These domain MCP servers cannot be created through the API.
{% endhint %}

{% hint style="danger" %}
**Dynamic MCP servers**
This functionality is in preview mode - some of the features may not be fully operational yet.

Hosting of cloud functions and use of dynamic MCP servers is not included in standard billing plans and is billed separately on a pay-as-you-go basis. If you're interested in getting access to these features, contact the [Sales Team](mailto:support@emporix.com).

For more details, see [Hosting](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/management-dashboard/administration/hosting) and [Extension and Cloud Function Hosting](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/extension-hosting).
{% endhint %}

To follow this workflow:

* The OAuth2 access token must include the `ai.agent_manage` scope to create and attach the server, and `ai.agent_read` to retrieve the results.
* For a custom MCP server, you need a reachable MCP endpoint. Use `streamable_http` as the transport type. If the server requires authorization, create an AI token first with the [Upserting token](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/token#put-ai-service-tenant-agentic-tokens-tokenid) endpoint and pass its ID as `config.authorizationHeaderToken.id`.
* For a dynamic MCP server, a Cloud Function must already exist on the tenant. See [Extension and Cloud Function Hosting](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/extension-hosting) and [Hosting](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/management-dashboard/administration/hosting) in the Management Dashboard. Use that function's ID as `functionId`. When the server is enabled, the API validates each `functionId`. The request returns `400` if a referenced function does not exist on the tenant.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

{% stepper %}
{% step %}
#### Create the MCP server

Call the [Upserting MCP server](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/mcp-server#put-ai-service-tenant-agentic-mcp-servers-mcpserverid) endpoint. The request replaces all existing data for that server ID. A successful create returns `201` with the server ID. A successful update returns `204`.

{% tabs %}
{% tab title="Custom" %}

Set the `type` to `custom` (if omitted, it defaults to `custom`). Provide the values for `name`, `transport`, and `config.url`. The `config.authorizationHeaderName` and `config.authorizationHeaderToken` fields are optional. The created MCP server stays disabled at first (`enabled` defaults to `false` if omitted). To enable it, set `enabled` to `true`.

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/mcp-servers/mcp-custom' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "Custom MCP Server",
    "type": "custom",
    "transport": "streamable_http",
    "enabled": true,
    "config": {
      "url": "http://localhost:7900/mcp",
      "authorizationHeaderName": "Authorization",
      "authorizationHeaderToken": {
        "id": "token-id"
      }
    }
  }'
```

```
{
    "id": "mcp-custom"
}
```

{% endtab %}

{% tab title="Dynamic" %}

Set the `type` to `dynamic` and provide the inline `tools`. The created MCP server stays disabled at first (`enabled` defaults to `false` if omitted). To enable it, set `enabled` to `true`.

Each tool needs a unique `name` with no whitespace, a `prompt` that tells the agent when to call it, and a `config` with:

* `inputSchema` – a JSON Schema document provided as a JSON string
* `invocation.functionId` and `invocation.method` – the Cloud Function to call and the HTTP method
* `invocation.argsLocation` – `query` or `body`. Defaults to `body` when omitted.
* `requiredScopes` – optional OAuth scopes required to invoke the tool

Each tool also stays disabled at first (`enabled` defaults to `false` if omitted). To enable a tool so the agent can call it, set `enabled` to `true`.

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/mcp-servers/mcp-dynamic' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "Dynamic MCP Server",
    "type": "dynamic",
    "enabled": true,
    "tools": [
      {
        "name": "get-order",
        "description": "Retrieves an order by ID.",
        "prompt": "Use this tool when the user asks for order details.",
        "enabled": true,
        "config": {
          "requiredScopes": [
            "order.order_read"
          ],
          "inputSchema": "{\"type\":\"object\",\"properties\":{\"orderId\":{\"type\":\"string\"}},\"required\":[\"orderId\"]}",
          "invocation": {
            "functionId": "fn-get-order",
            "method": "GET",
            "argsLocation": "query"
          }
        }
      }
    ]
  }'
```

```
{
    "id": "mcp-dynamic"
}
```

{% endtab %}
{% endtabs %}

{% endstep %}

{% step %}
#### Attach the server to an agent

Call the [Partially updating agent](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#patch-ai-service-tenant-agentic-agents-agentid) endpoint to add the MCP server to an existing agent, for example an agent you created from a template. A successful request returns `204`.

Use the same endpoint if you want to attach Emporix domain MCP servers (`type: predefined`) to an AI agent.

{% tabs %}
{% tab title="Custom" %}

Set `type` to `custom` and pass the managed server ID in `mcpServer.id`.

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/complaint-agent' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '[
    {
      "op": "ADD",
      "path": "/mcpServers",
      "value": {
        "type": "custom",
        "mcpServer": {
          "id": "mcp-custom"
        }
      }
    }
  ]'
```

{% endtab %}

{% tab title="Dynamic" %}

Set `type` to `dynamic` and pass the managed server ID in `mcpServer.id`. The `tools` array on the attachment is an optional allow-list of tool names from the dynamic MCP server. Omit `tools` to grant the agent all enabled tools on that server.

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/complaint-agent' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '[
    {
      "op": "ADD",
      "path": "/mcpServers",
      "value": {
        "type": "dynamic",
        "mcpServer": {
          "id": "mcp-dynamic"
        },
        "tools": [
          "get-order"
        ]
      }
    }
  ]'
```

{% endtab %}

{% tab title="Predefined" %}

Set the `type` to `predefined` and pass the Emporix domain. The `tools` array lists the tools from that domain MCP server that the agent uses.

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/complaint-agent' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '[
    {
      "op": "ADD",
      "path": "/mcpServers",
      "value": {
        "type": "predefined",
        "domain": "order",
        "tools": [
          "get-order",
          "get-orders"
        ]
      }
    }
  ]'
```

The available `domain` values are `customer`, `extensibility`, `order`, `product`, or `frontend`.

{% endtab %}
{% endtabs %}

If you replace the whole `mcpServers` array (`op: REPLACE` on `/mcpServers`), include any existing `predefined`, `custom`, or `dynamic` attachments you still need.

You can also attach servers with the [Upserting agent](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#put-ai-service-tenant-agentic-agents-agentid) endpoint. That `PUT` replaces the whole agent document. The body must include all required agent fields, including `userPrompt`, `triggers`, `llmConfig`, and `mcpServers`.
{% endstep %}

{% step %}
#### Verify the attachment

Call the [Retrieving agent by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#get-ai-service-tenant-agentic-agents-agentid) endpoint with `expand=mcpServers` to return the full `mcpServer` object for `custom` and `dynamic` attachments. Without `expand`, `mcpServer` typically contains only the `id`.

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/complaint-agent?expand=mcpServers' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: application/json'
```

Listing and searching agents return the same `mcpServers` attachments, including `predefined`, and also support `expand=mcpServers`.

To inspect the server itself, call the [Retrieving MCP server by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/mcp-server#get-ai-service-tenant-agentic-mcp-servers-mcpserverid) endpoint:

{% tabs %}
{% tab title="Custom" %}

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/mcp-servers/mcp-custom' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: application/json'
```

{% endtab %}

{% tab title="Dynamic" %}

```bash
curl -L \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/mcp-servers/mcp-dynamic' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Accept: application/json'
```

The response includes the inline `tools`.

{% endtab %}
{% endtabs %}

{% endstep %}

{% step %}
#### Update the MCP server

Call the [Partially updating MCP server](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/mcp-server#patch-ai-service-tenant-agentic-mcp-servers-mcpserverid) endpoint. A successful request returns `204`.

{% tabs %}
{% tab title="Custom" %}

For example, replace the server name:

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/mcp-servers/mcp-custom' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '[
    {
      "op": "REPLACE",
      "path": "/name",
      "value": "New Custom MCP Server"
    }
  ]'
```

You can also replace `config.url` in the same way.

{% endtab %}

{% tab title="Dynamic" %}

For example, replace the tool list:

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/mcp-servers/mcp-dynamic' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '[
    {
      "op": "REPLACE",
      "path": "/tools",
      "value": [
        {
          "name": "get-order",
          "prompt": "Use this tool to retrieve an order by ID.",
          "enabled": true,
          "config": {
            "inputSchema": "{\"type\":\"object\",\"properties\":{\"orderId\":{\"type\":\"string\"}},\"required\":[\"orderId\"]}",
            "invocation": {
              "functionId": "fn-get-order",
              "method": "GET",
              "argsLocation": "query"
            }
          }
        }
      ]
    }
  ]'
```

{% endtab %}
{% endtabs %}

To set `enabled` to `false` when an enabled agent uses this MCP server, send `force=true` as a query parameter. The API then disables both the agent and the MCP server.

{% endstep %}
{% endstepper %}

## How to communicate with an Agent

For some Agents, it is convenient to trigger their actions by API calls. To allow communication with the selected agent, you can use the dedicated endpoints. If the agent has a custom, dynamic, or predefined MCP server attached, it can invoke those tools during the chat without extra fields in the request body.

{% hint style="info" %}
Choose the chat endpoint based on how you want to receive the agent's response:

* [Starting agent chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat) – when you need a single complete JSON response right away.
* [Starting agent chat stream](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat-stream) – when you build interactive experiences, such as chat UIs, storefront assistants, or backoffice tools, that display the agent's reply as it is written and benefit from improved responsiveness.
* [Starting agent async chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat-async) – when the agent may take longer to process data or wait for another task, and you want to poll the result using the `jobId`.
{% endhint %}

* When instant responses are required from the agent, send the request to the [Starting agent chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat)

  ```bash
  curl -L 'https://api.emporix.io/ai-service/{tenant}/agentic/chat' \
  -H 'tenant: {tenant}' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
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

* When you want progressive output as the agent's response is generated, stream the request to the [Starting agent chat stream](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat-stream) endpoint.

  ```bash
  curl -N -L 'https://api.emporix.io/ai-service/{tenant}/agentic/chat-stream' \
  -H 'Content-Type: application/json' \
  -H 'Accept: text/event-stream' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -d '{
      "agentId": "generic-agent",
      "message": "Summarize the delivery options available for order EON1243."
  }'
  ```

  The request body uses the same `agentId` and `message` fields as the synchronous chat request. The endpoint returns the response as a Server-Sent Events stream (`text/event-stream`), so clients receive incremental output instead of waiting for the full message.

* When it is more pragmatic to wait for the agent's response, for example, when the agent needs to process more data which takes more time, or the agent needs to wait for another task to be completed, use the asynchronous communication. Send the request to the agent using the [Starting agent async chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat-async).

  ```bash
  curl -L 'https://api.emporix.io/ai-service/{tenant}/agentic/chat-async' \
  -H 'tenant: {tenant}' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
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

  Use the `jobId` to check details of the job through the [Retrieving agent job by its ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/job#get-ai-service-tenant-jobs-jobid) endpoint. For example:

  ```bash
  curl -X 'GET' \
    'https://api.emporix.io/ai-service/{tenant}/jobs/68e3a593b2cb061e36630849' \
    -H 'accept: application/json'
  ```

  The job entity contains information about the request and response from the agent.

## How to pass a media file for the agents to process

Agents are able to retrieve data from media attachments and use that data to execute some steps or pass it over to other agents to process. You can attach media files and then use them in the agent chat. 

The following MIME types are supported:
* image/jpeg
* image/png
* application/pdf
* text/csv
* text/plain

Media file size can be up to 10 MB.

{% stepper %}
{% step %}
### Upload a file to an agent
To upload a file to an agent, use the dedicated [Uploading attachments to agent chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-agentId-attachments)

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/{agentId}/attachments' \
  --header 'Content-Type: multipart/form-data' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --form 'attachment=@"order_request.pdf"'

```

The successful response returns an attachment `id` and a `sessionId` that scopes the upload to your chat session. Save both values as you need them when you call agent chat in the subsequent step. 

How the `sessionId` in the response is set:
* If you send a `session-id` header on the upload request (optional), the response returns the exact same value.
* If you omit the header, the API generates a new `sessionId` for you.

Example response:

```
{
    "id": "6a1d5961a8c0af22364a2c54",
    "sessionId": "bdec151b-303f-4344-b41d-ccf307fb7907"
}
```

Attaching a media file of an unsupported type results in the `400` error, for example:

```
{
    "resourceId": null,
    "message": "The provided 'image/svg+xml' content type is not supported for agent chat",
    "code": 400,
    "status": "Bad Request",
    "details": []
}
```

{% endstep %}

{% step %}
### Refer to the attachment in agent chat
The agent already has access to the attached file. Now you can point to it and give additional instructions in the agent chat request. Call the agent, for example with the [Starting agent chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat) endpoint. Include the upload `id` as the `attachmentId` parameter in the request body and provide the `session-id` in the header to ensure secure access to the attachment:

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/chat' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --header 'session-id: bdec151b-303f-4344-b41d-ccf307fb7907' \
  --data '{
    "agentId": "order-assistant-agent",
    "message": "Find products or equivalents from the attached order request and create an order for the customer",
    "attachments": [
      {
        "attachmentId": "6a1d5961a8c0af22364a2c54",
        "caption": "Order Request",
        "purpose": "Serves as basis to create an order with the data, customer and products mentioned in the file."
      }
    ]
  }'
```

The agent now can process the data according to its rules and code of conduct.
{% endstep %}
{% endstepper %}

## How to export and import AI agents

Exporting AI agents lets you migrate your agents configuration together with their dependent tools and MCP servers.

You can use the export and import to:

* Back up agents for disaster recovery
* Migrate agents from development to production
* Share agents across different tenants
* Clone agents for testing

{% stepper %}
{% step %}
#### Export agents

Collect the `agentIds` you want to export, then call the [Exporting agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/import-export#post-ai-service-tenant-agentic-agents-export) endpoint.

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/export' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "agentIds": [
      "complaint-agent-id"
    ]
  }'
```

The response contains:

* `data`: a Base64-encoded JSON payload with the exported agents, tools, and MCP servers.
* `checksum`: a hash of the decoded `data` string.
* `jobId`: the export job identifier (you can poll the [Retrieving agent job by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/job#get-ai-service-tenant-jobs-jobid) endpoint if you need job status updates).

Store both `data` and `checksum`. You will need them when importing.
{% endstep %}

{% step %}
#### Import agents

Use the payload obtained during export and call the [Importing agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/import-export#post-ai-service-tenant-agentic-agents-import) endpoint. Import requires the `ai.agent_manage` scope.

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/ai-service/{tenant}/agentic/agents/import' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "data": "<BASE64_PAYLOAD_FROM_EXPORT>",
    "checksum": "<CHECKSUM_FROM_EXPORT>"
  }'
```

The response summarizes what was imported and returns a `jobId`.

* If imported tools or MCP servers already exist in the target tenant, they're reused.
* If they don't exist, new instances are created. If a token is required, they get a **disabled state** for your review, if no token is required, they get **enabled** state.
* Imported agents are also disabled by default as a safety measure.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
After importing the agent, review the entities in the response summary and check if any required API tokens or credentials need to be configured before enabling the agent.
{% endhint %}
 
