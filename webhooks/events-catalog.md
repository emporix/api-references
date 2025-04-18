---
seo:
  title: Catalog Service events
  description: Webhooks, catalog events
---

# Catalog Service events

## Overview

Webhook events related to the creation, update, and deletion of a catalog.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
  <tr>
    <td>catalog.created</td>
<td>

```json
{
  "categoryIds": [
    "String"
  ],
  "description": "Map",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "name": "Map",
  "publishedSites": [
    "String"
  ],
  "status": "String",
  "visibility": {
    "from": "String",
    "to": "String",
    "visible": "Boolean"
  }  
}
```
</td>
  </tr>
  <tr>
    <td>catalog.updated</td>
<td>

```json
{
  "categoryIds": [
    "String"
  ],
  "description": "Map",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "name": "Map",
  "publishedSites": [
    "String"
  ],
  "status": "String",
  "visibility": {
    "from": "String",
    "to": "String",
    "visible": "Boolean"
  }  
}
```
</td>
  </tr>
  <tr>
    <td>catalog.deleted</td>
  <td>

  ```json
  {
    "id": "String"
  }
  ```
  </td>
  </tr>
</table>

