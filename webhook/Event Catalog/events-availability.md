---
seo:
  title: Availability Service events
  description: Webhooks, availability events
toc:
  enable: true
tocMaxDepth: 2
editPage:
  disable: true
---

# Availability Service events

## Overview

Webhook events related to the creation, update, and deletion of an availability.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
  <tr>
    <td>availability.created</td>
<td>

```json
{
  "available": "Boolean",
  "distributionChannel": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "mixins": "Object"
  },
  "mixins": "Object",
  "popularity": "Number",
  "productId": "String",
  "site": "String",
  "stockLevel": "Number"
}
```
</td>
  </tr>
  <tr>
    <td>availability.updated</td>
<td>

```json
{
  "available": "Boolean",
  "distributionChannel": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "mixins": "Object",
    "modifiedAt": "String"
  },
  "mixins": "Object",
  "popularity": "Number",
  "productId": "String",
  "site": "String",
  "stockLevel": "Number"  
}
```
</td>
  </tr>
  <tr>
    <td>availability.deleted</td>
  <td>

  ```json
  {
    "id": "String"
  }
  ```
  </td>
  </tr>
</table>

