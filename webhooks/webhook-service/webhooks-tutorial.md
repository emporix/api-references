---
layout:
  width: wide
icon: graduation-cap
---

# Webhooks Tutorial

The Emporix Webhook Event publishing works in the following way:

1. When an event takes place and you subscribed to receiving notifications about this event, a message is sent to the Webhook Service.
2. The Webhook Service forwards the message to the Event Gateway.
3. The Event Gateway matches the event to your configured endpoints. For the HTTP strategy with Multiple Webhooks, optional JsonPath filters are evaluated against the sanitized payload.

{% hint style="warning" %}
For example, if you create a catalog in the Emporix environment, a notification is sent to the Webhook service. The service passes the message to the Event Gateway. If you configured an endpoint for catalog creation beforehand, you receive the notification that a new catalog has been created.

For HTTP Multiple Webhooks, you can store multiple `eventsConfiguration` entries for the same event type. Until the follow-up delivery change is released, delivery still uses the **first matching** event-type entry.
{% endhint %}

## How to configure webhook notifications

At any time, a tenant can have only one webhook configuration of each type: `svix`, `svix_shared`, and `http`. To switch strategy or change provider settings, update or delete the existing configuration of that type before creating a new one.

To receive notifications from Emporix API services, you need to subscribe to specific events by following the process below:

* [Retrieve all subscriptions](webhooks-tutorial.md#retrieve-all-subscriptions)
* [Subscribe to events](webhooks-tutorial.md#subscribe-to-events)
* [Connect to the Event Gateway](webhooks-tutorial.md#connect-to-the-event-gateway)
* [Configure your endpoints](webhooks-tutorial.md#configure-your-endpoints)
* [Multiple Webhooks (HTTP strategy)](webhooks-tutorial.md#multiple-webhooks-http-strategy)

{% hint style="warning" %}
By default, the maximum number of events per tenant is limited to 5000/month. The limit resets on the first day of each month. If you want to publish more events, contact Emporix Support.
{% endhint %}

### Retrieve all subscriptions

Before you subscribe to events, you need to check for any active subscriptions by sending a request to the Retrieving all subscriptions endpoint.

{% hint style="warning" %}
If the subscription to the event of your choice already exists and you want to update it, note down the `metadata.version` value. You will need it to call the [Subscribing and unsubscribing from events](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/events#patch-webhook-tenant-event-subscriptions) endpoint further in the tutorial.

If there is no prior subscription to the event of your choice, the `metadata.version` is empty. It is automatically set to `1` when you send a request to the [Subscribing and unsubscribing from events](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/events#patch-webhook-tenant-event-subscriptions) endpoint.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/webhook/{tenant}/event-subscriptions' 
  -H 'Accept-Language: fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

### Subscribe to events

To receive notifications about events, for example creating or updating a catalog in the **Catalog Service**, you need to subscribe to them by using the Webhook Service.

To subscribe to an event, you need to send a request to the [Subscribing and unsubscribing from events](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/events#patch-webhook-tenant-event-subscriptions) endpoint.

In this example, you will subscribe to the following events: `catalog.created` and `catalog.updated`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH 
  'https://api.emporix.io/webhook/{tenant}/event-subscriptions' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "eventType": "catalog.created",
    "action": "SUBSCRIBE",
    "fieldsToSubscribe": [
      "name"
    ],
    "fieldsToUnsubscribe": [
      "description"
    ],
    "metadata": {
      "version": 1
    }
  },
  {
    "eventType": "catalog.updated",
    "action": "SUBSCRIBE",
    "metadata": {
      "version": 1
    }
  }'
```

**Learn about the `index.item-updated` event's specific behavior:**

The `index.item-updated` webhook event is emitted whenever there is a change on an item in the system - the index is updated with the new information.\
For the event to be triggered, a product must have at least one defined **price**, as it is the price that determines products indexing on a specific site.\
Bear in mind all the events are site-specific, which means that they are linked to activities happening on particular sites.\
The prices are also site-specific, and a single price can be associated with multiple sites.\
The number of events triggered in the system depends on **the number of sites** assigned to a specific product’s prices, with one event emitted per each site.

Example:

| productid | price with associated sites       | number of emitted events | sites the event was emitted to |
| --------- | --------------------------------- | ------------------------ | ------------------------------ |
| 123       | $10 - sites A, B                  | 2                        | A, B                           |
| 234       | $10 - site A, $15 - sites A, B, C | 3                        | A, B, C                        |
| 345       | no price                          | 0                        | none                           |

* A product _123_ has one assigned price of _$10_, associated with two sites _A_ and _B_. When you update the product _123_, the number of emitted `index.item-updated` events is **2** as there are two sites associated with the product price.
* A product _234_ has two assigned prices: _$10_ associated with site _A_ and _$15_ associated with site _A_, _B_, and _C_. So when you update the product _234_, the `index.item-updated` event runs **3** times, as there are three sites affected.
* A product _345_ has no defined price. So when you update the _345_ product, the `index.item-updated` is not emitted as no site is associated with the product.

#### Subscribe to custom entity events

You can subscribe to Schema custom entity events the same way as other event types:

* `schema.custom-instance-created`
* `schema.custom-instance-updated`
* `schema.custom-instance-deleted`

```bash
curl -i -X PATCH \
  'https://api.emporix.io/webhook/{tenant}/event-subscriptions' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
  {
    "eventType": "schema.custom-instance-updated",
    "action": "SUBSCRIBE"
  }
]'
```

With the HTTP strategy, pair the subscription with an optional JsonPath `filter` on an endpoint (for example `$[?(@.type == 'contract')]`) when you only want specific custom entity types delivered. If no filter is configured, all events of the subscribed custom-instance type are candidates for delivery. See [Multiple Webhooks (HTTP strategy)](webhooks-tutorial.md#multiple-webhooks-http-strategy).

### Connect to the Event Gateway

You need to have access to the Event Gateway to connect the tenant with their consumer application.

When you subscribe to events, you will receive an email with an automatically generated link to the application portal.

To generate the login link with the authentication token needed to connect a tenant to their consumer application portal, you need to send a request to the [Retrieving a dashboard access URL](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/svix-emporix-shared-account) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/webhook/{tenant}/dashboard-access' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

{% hint style="warning" %}
You can use your Emporix tenant ID as application ID in Svix.
{% endhint %}

### Configure your endpoints

To receive notifications about the events you subscribed to in [_Subscribe to events_](webhooks-tutorial.md#subscribe-to-events), configure endpoints that relate to those events.

* **Svix strategies:** On the Event Gateway, configure endpoints that relate to those events. To configure endpoints by using the APIs, check out the "Add webhook endpoints/Using the API" section in the [official Svix documentation](https://docs.svix.com/quickstart).
* **HTTP strategy:** Configure a global destination URL and optional per-event `eventsConfiguration` entries through the Webhook Service config API, as described in [Multiple Webhooks (HTTP strategy)](webhooks-tutorial.md#multiple-webhooks-http-strategy).

## Multiple Webhooks (HTTP strategy)

Multiple Webhooks lets you register several HTTP targets for the same `eventType`. Each entry in `eventsConfiguration` can define its own `destinationUrl`, `secretKey`, `headers`, optional Jayway JsonPath `filter`, `excludedFields`, `name`, and `active` flag.

{% hint style="warning" %}
This release updates the **configuration model and API**. Webhook delivery still uses the **first matching** event-type entry until the follow-up delivery change is released. Existing single-target configurations remain backward compatible.
{% endhint %}

### JsonPath filter structure and validation

| Rule | Details |
| ---- | ------- |
| Field | `filter` (string) on an `eventsConfiguration` entry |
| Form | Jayway JsonPath predicate, typically `$[?(@.<path> <op> <value>)]` |
| Evaluation | Against the sanitized event payload |
| Empty / omitted | Matches every event of the given `eventType` |
| Invalid expression | Rejected with HTTP `400` and not stored |
| Inactive entry (`active: false`) | Skipped without filter evaluation, delivery, or retries |

Examples:

* Match by status: `$[?(@.status == 'DECLINED')]`
* Nested path: `$[?(@.status.value == 'DECLINED')]`
* Custom entity type: `$[?(@.type == 'contract')]`
* AND: `$[?(@.status == 'DECLINED' && @.channel == 'web')]`
* OR: `$[?(@.status == 'DECLINED' || @.status == 'CANCELLED')]`

Related validation rules:

* Entry `id` is server-generated. Client-supplied ids on create are rejected with `400`.
* Duplicate entry ids are rejected with `400`.
* `excludedFields: null` or omit inherits subscription exclusions; `[]` means no exclusions for that target.
* Legacy PATCH paths by `{eventType}` return `409` when multiple entries exist for that type. Prefer `/configuration/http/eventsConfigurationEntry/{entryId}`.

### Valid configuration: multiple targets for one event type

```bash
curl -i -X PUT \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
  "active": true,
  "provider": "HTTP",
  "configuration": {
    "destinationUrl": "https://fallback.example/hooks",
    "secretKey": "global-secret",
    "eventsConfiguration": [
      {
        "name": "Declined quotes",
        "eventType": "quote.updated",
        "destinationUrl": "https://crm.example/quotes",
        "filter": "$[?(@.status.value == '\''DECLINED'\'')]",
        "excludedFields": null,
        "active": true
      },
      {
        "name": "All quote updates",
        "eventType": "quote.updated",
        "destinationUrl": "https://analytics.example/quotes",
        "active": true
      }
    ]
  }
}'
```

Example successful response body (shape) when retrieving the config:

```json
{
  "code": "http",
  "active": true,
  "provider": "HTTP",
  "configuration": {
    "destinationUrl": "https://fallback.example/hooks",
    "secretKeyExists": true,
    "eventsConfiguration": [
      {
        "id": "3f2a1c9e-8b4d-4e2a-9f1c-7a6b5d4e3c2b",
        "name": "Declined quotes",
        "eventType": "quote.updated",
        "destinationUrl": "https://crm.example/quotes",
        "secretKeyExists": false,
        "filter": "$[?(@.status.value == 'DECLINED')]",
        "excludedFields": null,
        "active": true
      },
      {
        "id": "9c8b7a6d-5e4f-3a2b-1c0d-9e8f7a6b5c4d",
        "name": "All quote updates",
        "eventType": "quote.updated",
        "destinationUrl": "https://analytics.example/quotes",
        "secretKeyExists": false,
        "active": true
      }
    ]
  }
}
```

### Valid configuration: custom entity filter

```bash
curl -i -X PUT \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
  "active": true,
  "provider": "HTTP",
  "configuration": {
    "destinationUrl": "https://fallback.example/hooks",
    "eventsConfiguration": [
      {
        "name": "Contract updates",
        "eventType": "schema.custom-instance-updated",
        "destinationUrl": "https://erp.example/contracts",
        "filter": "$[?(@.type == '\''contract'\'')]",
        "active": true
      }
    ]
  }
}'
```

With this setup, only `schema.custom-instance-updated` payloads where `type` is `contract` match the endpoint filter. Other custom entity types are not candidates for this entry.

### Valid PATCH by entry id

```bash
curl -i -X PATCH \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
  {
    "op": "UPSERT",
    "path": "/configuration/http/eventsConfigurationEntry/3f2a1c9e-8b4d-4e2a-9f1c-7a6b5d4e3c2b/filter",
    "value": "$[?(@.status.value == '\''CANCELLED'\'')]"
  }
]'
```

### Invalid configuration: malformed JsonPath (`400`)

```bash
curl -i -X PUT \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
  "active": true,
  "provider": "HTTP",
  "configuration": {
    "destinationUrl": "https://fallback.example/hooks",
    "eventsConfiguration": [
      {
        "name": "Broken filter",
        "eventType": "quote.updated",
        "destinationUrl": "https://crm.example/quotes",
        "filter": "$[?(invalid"
      }
    ]
  }
}'
```

Example error response:

```json
{
  "code": 400,
  "status": "Bad Request",
  "message": "Invalid JsonPath filter expression",
  "details": [
    "filter is not a valid Jayway JsonPath predicate"
  ]
}
```

### Invalid configuration: client-supplied entry id (`400`)

```bash
curl -i -X PUT \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
  "active": true,
  "provider": "HTTP",
  "configuration": {
    "destinationUrl": "https://fallback.example/hooks",
    "eventsConfiguration": [
      {
        "id": "client-supplied-id",
        "eventType": "quote.updated",
        "destinationUrl": "https://crm.example/quotes"
      }
    ]
  }
}'
```

Example error response:

```json
{
  "code": 400,
  "status": "Bad Request",
  "message": "Client-supplied entry id is not allowed",
  "details": [
    "eventsConfiguration[].id must be omitted on create; ids are server-generated"
  ]
}
```

### Invalid PATCH by event type when multiple entries exist (`409`)

When more than one entry shares `quote.updated`, a legacy path returns conflict:

```bash
curl -i -X PATCH \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
  {
    "op": "UPSERT",
    "path": "/configuration/http/eventsConfiguration/quote.updated/destinationUrl",
    "value": "https://crm.example/quotes-v2"
  }
]'
```

Example error response:

```json
{
  "code": 409,
  "status": "Conflict",
  "message": "Multiple eventsConfiguration entries exist for event type",
  "details": [
    "Use /configuration/http/eventsConfigurationEntry/{entryId} when more than one entry exists for quote.updated"
  ]
}
```
