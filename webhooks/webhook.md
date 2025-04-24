---
seo:
  title: Webhook Service Tutorials
  description: webhooks, webhook, events, event
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';


# Webhook Service Tutorials

The Emporix Webhook Event Publishing works in the following way:

1. When an event takes place and you subscribed to receiving notifications about this event, a message is sent to the Webhook Service. 
2. The Webhook Service forwards the message to the Event Gateway.
3. The Event Gateway passes the event to your earlier configured endpoint for this particular event.

{% endhint %}info
    
For example, if you create a catalog in the Emporix environment, a notification is sent to the Webhook service. The service passes the message to the Event Gateway. If you configured the "Create a new catalog" endpoint beforehand, you will receive the notification that a new catalog has been created.

{% endhint %}

## How to configure webhook notifications

To receive notifications from Emporix API services, you need to subscribe to specific events by following the process below: 

- [Webhook Service Tutorials](#webhook-service-tutorials)
  - [How to configure webhook notifications](#how-to-configure-webhook-notifications)
    - [Retrieve all subscriptions](#retrieve-all-subscriptions)
    - [Subscribe to events](#subscribe-to-events)
- [](#)
    - [Connect to the Event Gateway](#connect-to-the-event-gateway)
    - [Configure your endpoints](#configure-your-endpoints)

{% hint style="warning" %}

By default, the maximum number of events per tenant is limited to 5000/month. The limit resets on the first day of each month. If you want to publish more events, contact Emporix Support.

{% endhint %}

### Retrieve all subscriptions

Before you subscribe to events, you need to check for any active subscriptions by sending a request to the <nobr><Button to="/openapi/webhook/#operation/GET-webhook-list-all-event-subscriptions" size="small">Retrieving all subscriptions</Button></nobr> endpoint.

{% hint style="warning" %}

If the subscription to the event of your choice already exists and you want to update it, note down the `metadata.version` value. You will need it to call the `Subscribing and unsubscribing from events` endpoint further in the tutorial.

If there is no prior subscription to the event of your choice, the `metadata.version` is empty. It is automatically set to `1` when you send a request to the <nobr><Button to="/openapi/webhook/#operation/PATCH-webhook-manage-event-subscriptions" size="small">Subscribing and unsubscribing from events</Button></nobr> endpoint.

{% endhint %}


<OpenApiTryIt
  definitionId="webhook"
  operationId="GET-webhook-list-all-event-subscriptions"
/>


### Subscribe to events

To receive notifications about events, for example creating or updating a catalog in the **Catalog Service**, you need to subscribe to them by using the Webhook Service. 

To subscribe to an event, you need to send a request to the <nobr><Button to="/openapi/webhook/#operation/PATCH-webhook-manage-event-subscriptions" size="small">Subscribing and unsubscribing from events</Button></nobr> endpoint.

In this example, you will subscribe to the following events: `catalog.created` and `catalog.updated`.

<OpenApiTryIt
  definitionId="webhook"
  operationId="PATCH-webhook-manage-event-subscriptions"
  properties={[
  {
        eventType: "catalog.created",
        action: "SUBSCRIBE",
        metadata: {
          version: 1
        }
  },
  {
    "eventType": "catalog.updated",
    "action": "SUBSCRIBE",
    "metadata": {
      "version": 1
      }
    }
  ]
  }
/>

{% hint style="info" %}

**Learn about the `index.item-updated` event's specific behavior** 
#
The `index.item-updated` webhook event is emitted whenever there is a change on an item in the system - the index is updated with the new information. 
For the event to be triggered, a product must have at least one defined **price**, as it is the price that determines products indexing on a specific site.
Bear in mind all the events are site-specific, which means that they are linked to activities happening on particular sites. 
The prices are also site-specific, and a single price can be associated with multiple sites. 
The number of events triggered in the system depends on **the number of sites** assigned to a specific product’s prices, with one event emitted per each site. 

Example:
<table>
  <tr>
    <td><b>productid</b></td>
    <td><b>price with associated sites</b></td>
    <td><b>number of emitted events</b></td>
    <td><b>sites the event was emitted to</b></td>
  </tr>
  <tr>
    <td>123</td>
    <td>$10 - sites A, B</td>
    <td>2</td>
    <td>A, B</td>
  </tr>
  <tr>
    <td>234</td>
    <td>$10 - site A, $15 - sites A, B, C</td>
    <td>3</td>
    <td>A, B, C</td>
  </tr>
  <tr>
    <td>345</td>
    <td>no price</td>
    <td>0</td>
    <td>none</td>
  </tr>
</table>

* A product *123* has one assigned price of *$10*, associated with two sites *A* and *B*. When you update the product *123*, the number of emitted `index.item-updated` events is **2** as there are two sites associated with the product price.

* A product *234* has two assigned prices: *$10* associated with site *A* and *$15* associated with site *A*, *B*, and *C*. So when you update the product *234*, the `index.item-updated` event runs **3** times, as there are three sites affected.

* A product *345* has no defined price. So when you update the *345* product, the `index.item-updated` is not emitted as no site is associated with the product.
{% endhint %}

### Connect to the Event Gateway

You need to have access to the Event Gateway to connect the tenant with their consumer application. 

When you subscribe to events, you will receive an email with an automatically generated link to the application portal.


To generate the login link with the authentication token needed to connect a tenant to their consumer application portal, you need to send a request to the <nobr><Button to="/openapi/webhook/#operation/GET-webhook-access-tenant-svix" size="small">Retrieving a dashboard access URL</Button></nobr>
 endpoint. 


<OpenApiTryIt
  definitionId="webhook"
  operationId="GET-webhook-access-tenant-svix"
/>

{% endhint %}info

You can use your Emporix tenant ID as application ID in Svix.
{% endhint %}

### Configure your endpoints

To receive notifications about the events you subscribed to in [*Subscribe to events*](#subscribe-to-events), on the Event Gateway, you need to configure endpoints that relate to those events. 

To configure endpoints by using the APIs, since we are currently using the Svix platform for this purpose, check out the "Add webhook endpoints/Using the API" section in the [official Svix documentation](https://docs.svix.com/quickstart).
