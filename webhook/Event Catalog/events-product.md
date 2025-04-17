---
seo:
  title: Product Service events
  description: Webhooks, product events

---

# Product Service events

## Overview

Webhook events related to the creation, update, and deletion of a product.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
  <tr>
    <td>product.created</td>
<td>

```json
{
  "id": "String",
  "code": "String",
  "name": "Map",
  "description": "Map",
  "productType": "String",
  "taxClasses": "Map",
  "published": "Boolean",
  "template": {
    "id": "String",
    "version": "Integer"
  },
  "media": [
    {
      "id": "String",
      "mediaId": "String",
      "url": "String",
      "commitLink": "String",
      "contentType": "String",
      "stored": "Boolean",
      "createdAt": "String",
      "customAttributes": "Map",
      "tags": [
        "String"
      ],
      "uncommittedMedia": "Boolean",
      "uploadLink": "String"
    }
  ],
  "bundledProducts": [
    {
      "productId": "String",
      "amount": "Integer"
    }
  ],
  "relatedItems": [
    {
      "refId": "String",
      "type": "String"
    }
  ],
  "mixins": "Map",
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
```
</td>
  </tr>
  <tr>
    <td>product.updated</td>
<td>

```json
{
  "id": "String",
  "code": "String",
  "name": "Map",
  "description": "Map",
  "productType": "String",
  "taxClasses": "Map",
  "published": "Boolean",
  "template": {
    "id": "String",
    "version": "Integer"
  },
  "media": [
    {
      "id": "String",
      "mediaId": "String",
      "url": "String",
      "commitLink": "String",
      "contentType": "String",
      "stored": "Boolean",
      "createdAt": "String",
      "customAttributes": "Map",
      "tags": [
        "String"
      ],
      "uncommittedMedia": "Boolean",
      "uploadLink": "String"
    }
  ],
  "bundledProducts": [
    {
      "productId": "String",
      "amount": "Integer"
    }
  ],
  "relatedItems": [
    {
      "refId": "String",
      "type": "String"
    }
  ],
  "mixins": "Map",
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
```
</td>
  </tr>
  <tr>
    <td>product.deleted</td>
  <td>

  ```json
  {
    "id": "String"
  }
  ```
  </td>
  </tr>
</table>

