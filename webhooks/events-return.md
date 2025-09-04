---
seo:
  title: Return Service events
  description: Webhooks, return service events
icon: webhook
---

# Events - Return

## Overview

Webhook events the creation, update, and deletion of a return.

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>return.created</td><td><pre class="language-json"><code class="lang-json">{
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
</code></pre></td></tr><tr><td>return.deleted</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre></td></tr><tr><td>return.updated</td><td><pre class="language-json"><code class="lang-json">{
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
</code></pre></td></tr></tbody></table>
