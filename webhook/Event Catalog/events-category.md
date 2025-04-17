---
seo:
  title: Category Service events
  description: Webhooks, category events

---

# Category Service events

## Overview

Webhook events related to the creation, update, and deletion of a category tree and to the creation and deletion of a category assignment.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
  <tr>
    <td>category.created</td>
<td>

```json
{
  "id": "String",
  "parentId": "String",
  "name": {
    "name" : "Map"
  },
  "description": {
    "description": "Map"
  },
  "slug": {
    "code": "Map"
  },
  "ecn": {
    "externalCategoryNumbers": [
      "String"
    ]
  },
  "validity": {
    "from": "String",
    "to": "String"
  },
  "position": {
    "position": "Number"
  },
  "publish": {
    "published": "Boolean"
  },
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
    <td>category.updated</td>
<td>

```json
{
  "id": "String",
  "parentId": "String",
  "name": {
    "name" : "Map"
  },
  "description": {
    "description": "Map"
  },
  "slug": {
    "code": "Map"
  },
  "ecn": {
    "externalCategoryNumbers": [
      "String"
    ]
  },
  "validity": {
    "from": "String",
    "to": "String"
  },
  "position": {
    "position": "Number"
  },
  "publish": {
    "published": "Boolean"
  },
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
    <td>category.deleted</td>
<td>

```json
{
  "id": "String",
  "parentId": "String"
}
```
</td>
</tr>
  <tr>
    <td>assignment.created</td>
<td>

```json
{
  "categoryId": "String",
  "assignment": {
    "id": "String",
    "categoryId": "String",
    "createdAt": "String",
    "ref": {
      "id": "String",
      "type": "String"
    }
  },
  "metadata": {
    "createdAt": "String"
  }
}
```
</td>
</tr>
  <tr>
    <td>assignment.deleted</td>
<td>

```json
{
  "categoryId": "String",
  "assignments": [
    {
      "id": "String",
      "categoryId": "String",
      "createdAt": "String",
      "ref": {
        "id": "String",
        "type": "String"
      }
    }
  ]
}
```
</td>
</tr>

</table>