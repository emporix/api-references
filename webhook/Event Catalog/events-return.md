---
seo:
  title: Return Service events
  description: Webhooks, return service events
---

# Return events

## Overview

Webhook events the creation, update, and deletion of a return.

## Available events

| Event type     | Event schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| return.created | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| return.deleted | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| return.updated | <pre class="language-json"><code class="lang-json">{
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
</code></pre>  |
