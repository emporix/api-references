---
seo:
  title: Indexing Service events
  description: Webhooks, indexing service events
---

# Index events

## Overview

Webhook events related to indexing data.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
  <tr>
    <td>index-item.updated</td>
<td>

```json
{
  "availability": "Object",
  "available": "Boolean",
  "categoryAssignments": ["Object"],
  "code": "String",
  "id": "String",
  "medias": [
    {"Object"}
  ],
  "mixins": "Object",
  "popularity": "Number",
  "prices": [
    {
      "currency": "String",
      "effectiveAmount": "Number",
      "id": "String",
      "itemId": {
        "id": "String",
        "itemType": "String",
        "name": {"Object"}
      },
      "location": {
        "countryCode": "String"
      }
      "originalAmount": "Number",
      "priceModel": {
        "description": {"Map"},
        "id": "String",
        "includesTax": "Boolean",
        "measurementUnit": {
          "quantity": "Integer",
          "unitCode": "String"
        },
        "name": {"Object"},
        "tierDefinition":{
          "tierType": "String",
          "tiers": [
            {
              "id": "String",
              "minQuantity": {
                "quantity": "Integer",
                "unitCode": "String"
              }
            }
          ]
        }
      },
      "priceModelId": "String",
      "restrictions": {
        "siteCodes": ["String"]
      },
      "siteCode": "String",
      "tierValues": [
        {
          "id": "String",
          priceValue": "Number"
        }
      ]
    }
  ],
  "published": "Boolean",
  "siteCode": "String",
  "tags": ["String"]
}
```
</td>
</tr>

<tr>
    <td>index-item.deleted</td>
<td>

```json
{
  "id": "String",
  "siteCode": "String"
}
```
</td>
</tr>
</table>

:::note

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
:::