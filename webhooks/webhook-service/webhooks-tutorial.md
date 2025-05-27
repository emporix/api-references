---
icon: graduation-cap
---

# Webhooks Tutorial

The Emporix Webhook Event Publishing works in the following way:

1. When an event takes place and you subscribed to receiving notifications about this event, a message is sent to the Webhook Service.
2. The Webhook Service forwards the message to the Event Gateway.
3. The Event Gateway passes the event to your earlier configured endpoint for this particular event.

{% hint style="warning" %}
For example, if you create a catalog in the Emporix environment, a notification is sent to the Webhook service. The service passes the message to the Event Gateway. If you configured the "Create a new catalog" endpoint beforehand, you will receive the notification that a new catalog has been created.
{% endhint %}

## How to configure webhook notifications

To receive notifications from Emporix API services, you need to subscribe to specific events by following the process below:

* [Webhooks Tutorial](webhooks-tutorial.md#webhooks-tutorial)
  * [description: webhooks, webhook, events, event](webhooks-tutorial.md#description-webhooks-webhook-events-event)
* [Webhook Service Tutorials](webhooks-tutorial.md#webhook-service-tutorials)
  * [How to configure webhook notifications](webhooks-tutorial.md#how-to-configure-webhook-notifications)
    * [Retrieve all subscriptions](webhooks-tutorial.md#retrieve-all-subscriptions)
    * [Subscribe to events](webhooks-tutorial.md#subscribe-to-events)
  * [Connect to the Event Gateway](webhooks-tutorial.md#connect-to-the-event-gateway)
  * [Configure your endpoints](webhooks-tutorial.md#configure-your-endpoints)

{% hint style="warning" %}
By default, the maximum number of events per tenant is limited to 5000/month. The limit resets on the first day of each month. If you want to publish more events, contact Emporix Support.
{% endhint %}

### Retrieve all subscriptions

Before you subscribe to events, you need to check for any active subscriptions by sending a request to the Retrieving all subscriptions endpoint.

{% hint style="warning" %}
If the subscription to the event of your choice already exists and you want to update it, note down the `metadata.version` value. You will need it to call the [Subscribing and unsubscribing from events](https://developer.emporix.io/documentation-portal/api-references/webhooks/webhook-service/api-reference/events#patch-webhook-tenant-event-subscriptions) endpoint further in the tutorial.

If there is no prior subscription to the event of your choice, the `metadata.version` is empty. It is automatically set to `1` when you send a request to the [Subscribing and unsubscribing from events](https://developer.emporix.io/documentation-portal/api-references/webhooks/webhook-service/api-reference/events#patch-webhook-tenant-event-subscriptions) endpoint.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/webhook/{tenant}/event-subscriptions' \
  -H 'Accept-Language: fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

### Subscribe to events

To receive notifications about events, for example creating or updating a catalog in the **Catalog Service**, you need to subscribe to them by using the Webhook Service.

To subscribe to an event, you need to send a request to the [Subscribing and unsubscribing from events](https://developer.emporix.io/documentation-portal/api-references/webhooks/webhook-service/api-reference/events#patch-webhook-tenant-event-subscriptions) endpoint.

In this example, you will subscribe to the following events: `catalog.created` and `catalog.updated`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/webhook/{tenant}/event-subscriptions' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

### Connect to the Event Gateway

You need to have access to the Event Gateway to connect the tenant with their consumer application.

When you subscribe to events, you will receive an email with an automatically generated link to the application portal.

To generate the login link with the authentication token needed to connect a tenant to their consumer application portal, you need to send a request to the [Retrieving a dashboard access URL](https://developer.emporix.io/documentation-portal/api-references/webhooks/webhook-service/api-reference/svix-emporix-shared-account) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/webhook/{tenant}/dashboard-access' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

{% hint style="warning" %}
You can use your Emporix tenant ID as application ID in Svix.
{% endhint %}

### Configure your endpoints

To receive notifications about the events you subscribed to in [_Subscribe to events_](webhooks-tutorial.md#subscribe-to-events), on the Event Gateway, you need to configure endpoints that relate to those events.

To configure endpoints by using the APIs, since we are currently using the Svix platform for this purpose, check out the "Add webhook endpoints/Using the API" section in the [official Svix documentation](https://docs.svix.com/quickstart).
