---
seo:
  title: Return Service events
  description: Webhooks, return service events
---

# Return events

## Overview

Webhook events the creation, update, and deletion of a return.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
  <tr>
    <td>return.created</td>
<td>

```json
{
  "approvalStatus": "String",
  "approver": {
    "id": "String",
    "type": "String"
  },
  "expiryDate": "String",
  "id": "String",
  "metadata" : {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "mixins": "Object",
  "orders": [
    {
        "id": "String",
        "item": [
            "id": "String",
            "name": "String",
            "quantity": "Number",
            "reason": {
                "code": "String",
                "details": "String"
            },
            "total": {
                "currency": "String",
                "value": "Number"
            },
            "unitPrice": {
                "currency": "String",
                "value": "Number"
            }
        ]
    }
  ],
  "reason": {
    "code": "String",
    "details": "String"
  },
  "received": "Boolean",
  "requestor": {
    "customerId": "String",
    "email": "String",
    "firstName": "String",
    "lastName": "String"
  },
  "submitter": {
    "email": "String",
    "firstName": "String",
    "lastName": "String",
    "userType": "String"
  },
  "total": {
    "currency": "String",
    "value": "Number"
  }
}
```
</td>
</tr>

<tr>
    <td>return.deleted</td>
<td>

```json
{
  "id": "String"
}
```
</td>
</tr>
<tr>
    <td>return.updated</td>
<td>

```json
{
  "approvalStatus": "String",
  "approver": {
    "id": "String",
    "type": "String"
  },
  "expiryDate": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "mixins": "Object",
  "orders": [
    {
        "id": "String",
        "item": [
            "id": "String",
            "name": "String",
            "quantity": "Number",
            "reason": {
                "code": "String",
                "details": "String"
            },
            "total": {
                "currency": "String",
                "value": "Number"
            },
            "unitPrice": {
                "currency": "String",
                "value": "Number"
            }
        ]
    }
  ],
  "reason": {
    "code": "String",
    "details": "String"
  },
  "received": "Boolean",
  "requestor": {
    "customerId": "String",
    "email": "String",
    "firstName": "String",
    "lastName": "String"
  },
  "submitter": {
    "email": "String",
    "firstName": "String",
    "lastName": "String",
    "userType": "String"
  },
  "total": {
    "currency": "String",
    "value": "Number"
  }
}
```
</td>
</tr>
</table>