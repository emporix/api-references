---
layout:
  width: wide
icon: graduation-cap
---

# Handling Failed Webhook Deliveries

When a webhook target keeps rejecting events, the Webhook Service stops sending to it and stores the events instead. This tutorial shows how to find out that a target is failing, switch it back on, and then resend, restart, or delete the stored events.

To set up webhooks and endpoints first, see the [Webhooks Tutorial](webhooks-tutorial.md). The examples use the HTTP provider. If you prefer a visual interface, see the [Webhooks](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/management-dashboard/administration/webhooks#handling-failed-deliveries) user guide for Management Dashboard.

## How failure handling works

The following concepts explain how failure handling works:

* **Delivery target** – the place that receives your events: an HTTP endpoint (an `eventsConfiguration` entry), the global HTTP destination, a Svix configuration, or the shared Svix configuration.
* **Failure threshold** – the number of failed deliveries in a row after which the service gives up on a target. The default is 100 (minimum 10, maximum 1000). A successful delivery resets the counter. To change the threshold, see [Tune failure handling](handling-failed-webhook-deliveries.md#tune-failure-handling).
* **What does not count as a failure** – Svix `409` and `413` responses, reaching the webhook limit, a payload that is empty after field exclusion, and timeouts.
* **Failing target** – while deliveries fail and the number of failed deliveries in a row is below the threshold, the target is `FAILING`. Events are still sent, but the deliveries fail.
* **What happens at the threshold**
  * The owner of the target is switched off and gets a `suspendedAt` date. For an endpoint, only that endpoint is switched off. For the global HTTP destination or a Svix configuration, the whole configuration is switched off.
  * Events for the target are no longer sent. They are stored as failed messages.
* **No automatic recovery** – a suspended target never comes back on its own. You have to switch it on again.

{% hint style="warning" %}
**Keep in mind**

* **Retention** – failed messages are kept for 14 days on production and 1 day on preprod. After that, they are deleted automatically.
* **Payload** – a failed message stores the event as it was before field exclusion. When you resend or restart a message, the current field exclusions and the current target settings are applied. The endpoint `filter` is not evaluated again.
* **At-least-once delivery** – a resent or restarted message can reach your system twice. Deduplicate events in your receiver by the event ID.
{% endhint %}

## Required scopes

| Scope                            | Used for                                                          |
| -------------------------------- | ----------------------------------------------------------------- |
| `webhook.subscription_read`      | Reading the configuration, failed messages, and jobs              |
| `webhook.subscription_manage`    | Reactivating targets, resending, restarting, and deleting messages |

## How to handle failed deliveries

The following sections describe how to handle failed deliveries:

* [Check delivery health](handling-failed-webhook-deliveries.md#check-delivery-health)
* [Reactivate a target](handling-failed-webhook-deliveries.md#reactivate-a-target)
* [List failed messages](handling-failed-webhook-deliveries.md#list-failed-messages)
* [Inspect a failed message](handling-failed-webhook-deliveries.md#inspect-a-failed-message)
* [Resend a message](handling-failed-webhook-deliveries.md#resend-a-message)
* [Restart messages in bulk](handling-failed-webhook-deliveries.md#restart-messages-in-bulk)
* [Follow the restart job](handling-failed-webhook-deliveries.md#follow-the-restart-job)
* [Delete failed messages](handling-failed-webhook-deliveries.md#delete-failed-messages)
* [Tune failure handling](handling-failed-webhook-deliveries.md#tune-failure-handling)

### Check delivery health

To see which targets are failing, send a request to the [Retrieving a list of webhook configs](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/config#get-webhook-tenant-config) endpoint with the `expand` query parameter set to `deliveryStatus`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/webhook/{tenant}/config?expand=deliveryStatus' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

In the response, the `deliveryStatus` object is returned for each `eventsConfiguration` entry, for the global destination in `configuration`, and at the top level of Svix configurations. In the following example, one endpoint was switched off after repeated failures:

```json
{
  "code": "http",
  "provider": "HTTP",
  "active": true,
  "configuration": {
    "destinationUrl": "https://gcp.cloudfunctions.net/webhook?name=General",
    "deliveryStatus": {
      "status": "ACTIVE",
      "consecutiveFailures": 0
    },
    "eventsConfiguration": [
      {
        "id": "3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708",
        "eventType": "product.created",
        "destinationUrl": "https://gcp.cloudfunctions.net/webhook?name=Detailed",
        "active": false,
        "suspendedAt": "2026-11-17T09:58:40.512Z",
        "deliveryStatus": {
          "status": "FAILING",
          "consecutiveFailures": 100,
          "lastErrorMessage": "Service Unavailable",
          "lastErrorStatusCode": 503,
          "lastFailureAt": "2026-11-17T09:58:40.497Z",
          "failingSince": "2026-11-17T09:58:40.497Z"
        }
      }
    ]
  }
}
```

| Field                 | Description                                                                                          |
| --------------------- | ---------------------------------------------------------------------------------------------------- |
| `status`              | `ACTIVE` when events are delivered, `FAILING` when deliveries fail                                   |
| `consecutiveFailures` | The number of failed deliveries in a row. It is reset to `0` after a successful delivery             |
| `lastErrorMessage`    | The error message of the last failed delivery                                                        |
| `lastErrorStatusCode` | The HTTP status code returned by the target on the last failed delivery                              |
| `lastFailureAt`       | The time of the last failed delivery                                                                 |
| `failingSince`        | The time when the target became `FAILING`                                                            |

A switched-off configuration or endpoint returns `active: false` and a `suspendedAt` date. This is returned on the configuration itself and on each of its `eventsConfiguration` entries, with or without `expand=deliveryStatus`.

### Reactivate a target

After you fix the cause of the failures, switch the target back on. Do this before you resend any messages, because messages of a switched-off target cannot be delivered.

To reactivate a whole configuration, for example the global HTTP destination, send a request to the [Partially updating a webhook config](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/config#patch-webhook-tenant-config-code) endpoint:

```bash
curl -i -X PATCH \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
  {
    "op": "UPSERT",
    "path": "/active",
    "value": true
  }
]'
```

To reactivate a single endpoint, use the path of its `eventsConfiguration` entry:

```bash
curl -i -X PATCH \
  'https://api.emporix.io/webhook/{tenant}/config/http' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
  {
    "op": "UPSERT",
    "path": "/configuration/http/eventsConfigurationEntry/3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708/active",
    "value": true
  }
]'
```

A successful request returns `204`. It removes `suspendedAt` and resets the delivery status of the target.

{% hint style="warning" %}
Reactivating a target resumes live traffic only. The stored messages stay stored until you resend or restart them.
{% endhint %}

### List failed messages

To see the stored messages, send a request to the [Retrieving failed messages](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/failed-messages#get-webhook-tenant-failed-messages) endpoint. The list does not return the payload of the messages. To get the payload, [inspect a single message](handling-failed-webhook-deliveries.md#inspect-a-failed-message).

```bash
curl -i -X GET \
  'https://api.emporix.io/webhook/{tenant}/failed-messages?pageSize=20' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

```json
[
  {
    "id": "12052814953937469:http:3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708",
    "targetId": "http:3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708",
    "targetType": "ENTRY",
    "configCode": "http",
    "entryId": "3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708",
    "eventType": "product.created",
    "originalMessageId": "12052814953937469",
    "publishTime": "2026-11-17T09:41:12.204Z",
    "errorMessage": "Service Unavailable",
    "errorStatusCode": 503,
    "retryCount": 100,
    "failedAt": "2026-11-17T09:58:40.512Z"
  }
]
```

**Filter the list**

Use the following query parameters to narrow down the results:

| Parameter    | Description                                                                                  |
| ------------ | -------------------------------------------------------------------------------------------- |
| `targetType` | `ENTRY`, `HTTP_GLOBAL`, `SVIX`, or `SVIX_SHARED`                                             |
| `configCode` | The code of the webhook configuration, for example `http`                                    |
| `entryId`    | The ID of an `eventsConfiguration` entry                                                     |
| `eventType`  | The event type, for example `product.created`                                                |
| `q`          | A query in the standard Emporix syntax, for example `errorStatusCode:503`                    |
| `sort`       | The sorting order, for example `failedAt:asc`. The default is `failedAt:desc`                |
| `fields`     | A comma-separated list of the fields to return. `id` is always returned                      |

The following request returns the messages of one endpoint that failed with the `503` status after a given date. Put date values in quotation marks.

```bash
curl -i -G 'https://api.emporix.io/webhook/{tenant}/failed-messages' \
  --data-urlencode 'entryId=3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708' \
  --data-urlencode 'q=errorStatusCode:503 failedAt:>"2026-11-10T11:30:00.000Z"' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

**Page through the results**

You can page through the list in one of two ways:

* **By offset** – use `pageNumber` and `pageSize`. The first page has the number `1`.
* **By cursor** – use `next` or `prev` with the values returned in the `X-Next-Cursor` and `X-Prev-Cursor` response headers. The `X-Next-Cursor` header is missing on the last page. Keep the same `sort` value for all requests in a cursor series.

```bash
curl -i -G 'https://api.emporix.io/webhook/{tenant}/failed-messages' \
  --data-urlencode 'pageSize=20' \
  --data-urlencode 'next={{X_NEXT_CURSOR}}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

To get the total number of messages, add the `X-Total-Count: true` request header. The total is returned in the `X-Total-Count` response header.

{% hint style="info" %}
Counting is expensive. Ask for the total only when you need it. It is never returned in cursor mode.
{% endhint %}

### Inspect a failed message

To see the payload and the error of a message, send a request to the [Retrieving a failed message](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/failed-messages#get-webhook-tenant-failed-messages-failedmessageid) endpoint. This is the only call that returns the `payload`.

```bash
curl -i -X GET \
  'https://api.emporix.io/webhook/{tenant}/failed-messages/{failedMessageId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

The response contains the same fields as the list item, plus the stored `payload`. Remember that the payload is the event as it was before field exclusion.

### Resend a message

To deliver a single message again, send a request to the [Resending a failed message](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/failed-messages#post-webhook-tenant-failed-messages-failedmessageid-resend) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/webhook/{tenant}/failed-messages/{failedMessageId}/resend' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

* The service returns `202` with no body. The message is removed from the stored messages and queued for delivery.
* Resending is fire-and-forget. The response does not tell you whether the delivery succeeded, so check the result on the target. If the delivery fails again, it counts towards the failure threshold, and the event can be stored again.
* The service returns `409` when the configuration or the endpoint that owns the target is not active. [Reactivate](handling-failed-webhook-deliveries.md#reactivate-a-target) it first.

### Restart messages in bulk

To deliver many messages again, send a request to the [Restarting failed messages](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/failed-messages#post-webhook-tenant-failed-messages-restart) endpoint. The body is a selection of messages. All its fields are optional and are combined with `AND`:

| Field        | Description                                              |
| ------------ | -------------------------------------------------------- |
| `ids`        | Up to 100 failed message IDs                             |
| `targetType` | `ENTRY`, `HTTP_GLOBAL`, `SVIX`, or `SVIX_SHARED`         |
| `configCode` | The code of the webhook configuration                    |
| `entryId`    | The ID of an `eventsConfiguration` entry                 |
| `eventType`  | The event type                                           |

The following request restarts all stored messages of one endpoint:

```bash
curl -i -X POST \
  'https://api.emporix.io/webhook/{tenant}/failed-messages/restart' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
  "configCode": "http",
  "entryId": "3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708"
}'
```

{% hint style="danger" %}
An empty body or an empty object selects **every** stored message of the tenant.
{% endhint %}

The service returns `202` with the ID of the restart job:

```json
{
  "id": "6a1f0c2e9b3d4a5f8e7c6b5a"
}
```

* Only one restart job per tenant can run at a time. While another restart is running, the service returns `409`.
* The job restarts only the messages stored before it started.
* The job skips the messages whose target is still switched off, and they stay stored. [Reactivate](handling-failed-webhook-deliveries.md#reactivate-a-target) the targets before you start the job.

### Follow the restart job

To check the progress of the job, send a request to the [Retrieving a job](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/jobs#get-webhook-tenant-jobs-jobid) endpoint with the job ID.

```bash
curl -i -X GET \
  'https://api.emporix.io/webhook/{tenant}/jobs/{jobId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

```json
{
  "id": "6a1f0c2e9b3d4a5f8e7c6b5a",
  "type": "failed_message_restart",
  "status": "in_progress",
  "selection": {
    "configCode": "http",
    "entryId": "3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708"
  },
  "republished": 1000,
  "skipped": 2,
  "response": "Republished 1000, skipped 2",
  "metadata": {
    "createdAt": "2026-11-17T10:15:02.118Z",
    "modifiedAt": "2026-11-17T10:16:01.442Z"
  }
}
```

* `status` is `in_progress`, `success`, or `failure`.
* `republished` and `skipped` are counters that grow while the job runs. The job has no total, so you cannot calculate the percentage of progress.

To list the recent jobs of the tenant, use the [Retrieving jobs](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/jobs#get-webhook-tenant-jobs) endpoint.

### Delete failed messages

If you do not want to deliver a message, delete it. Deleting is permanent.

To delete a single message, send a request to the [Deleting a failed message](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/failed-messages#delete-webhook-tenant-failed-messages-failedmessageid) endpoint. The service returns `204`.

```bash
curl -i -X DELETE \
  'https://api.emporix.io/webhook/{tenant}/failed-messages/{failedMessageId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

To delete many messages, send a request to the [Deleting failed messages](https://developer.emporix.io/api-documentation/api-guides/webhooks/webhook-service/api-reference/failed-messages#post-webhook-tenant-failed-messages-delete) endpoint with the same selection body as for restart. The service returns `204`.

```bash
curl -i -X POST \
  'https://api.emporix.io/webhook/{tenant}/failed-messages/delete' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
  "configCode": "http",
  "eventType": "product.created"
}'
```

{% hint style="danger" %}
An empty body or an empty object deletes **every** stored message of the tenant.
{% endhint %}

### Tune failure handling

You can adjust the failure handling of your tenant with the following keys of the [Configuration Service](../../configuration/configuration-service/README.md):

| Key                          | Description                                                                                                                                        |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `webhookFailureThreshold`    | The number of failed deliveries in a row after which a target is switched off. It must be a positive integer. The default is 100 (minimum 10, maximum 1000) |
| `webhookNotificationEmails`  | The email addresses notified when a target is switched off. When the list is empty, the default employee is notified                              |

## Use the API Calls library

If you work with TypeScript, the `@emporix/api-calls/next` package provides the matching calls, for example `listWebhookConfigsWithDeliveryStatusCall`, `listWebhookFailedMessagesWithCursorCall`, `sendWebhookFailedMessageCall`, `createWebhookFailedMessagesRestartJobCall`, and `getWebhookJobCall`.

```typescript
import {
  createWebhookFailedMessagesRestartJobCall,
  getWebhookJobCall,
  listWebhookFailedMessagesWithCursorCall,
} from '@emporix/api-calls/next'

const tenant = 'your-tenant'

// List one page of failed messages of an endpoint
const { values, nextCursor } = await listWebhookFailedMessagesWithCursorCall(
  { entryId: '3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708', pageSize: 20 },
  { tenant }
)

// Restart all stored messages of the endpoint and read the job
const { id } = await createWebhookFailedMessagesRestartJobCall(
  { entryId: '3f1a2b4c-5d6e-7f80-91a2-b3c4d5e6f708' },
  { tenant }
)
const job = await getWebhookJobCall(id, { tenant })
```
