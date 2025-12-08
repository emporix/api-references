---
seo:
  title: Quote Service events
  description: Webhooks, Quote events
icon: webhook
description: Webhook events related to the creation, update, and deletion of a quote.
---

# Events - Quote

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>quote.created</td><td><pre class="language-json"><code class="lang-json">{
  "quote": {
    "id": "string",
    "customer:": {
      "customerId": "String",
      "firstName": "String",
      "lastName": "String",
      "contactEmail" : "String"
    },
    "employee:": {
      "employeeId": "String",
      "firstName": "String",
      "lastName": "String"
    },
    "cartId": "String",
    "orderId": "String",
    "siteCode": "String",
    "currency": "String",
    "status": {
      "value": "String",
      "comment": "String",
      "quoteReason": {
        "id": "String",
        "code": "String",
        "message": "Map",
        "type": "String"
      }
    },
    "validTo": "String",
    "totalPrice": {
      "currency": "String",
      "netValue": "Number",
      "grossValue": "Number",
      "taxValue": "Number"
    },
    "subTotalPrice": {
      "currency": "String",
      "netValue": "Number",
      "grossValue": "Number",
      "taxValue": "Number"
    },
    "taxAggregate": {
      "lines": [
        {
          "name": "String",
          "amount": "Number",
          "rate": "Number",
          "taxable": "Number"
        }
      ]
    },
    "shippingCost": {
      "value": "Number",
      "methodId": "String",
      "zoneId": "String",
      "methodName": "String",
      "shippingCode": "String"
    },
    "items": [
      {
        "itemId": "String",
        "quantity": {
          "quantity": "Number",
          "unitCode": "String"
        },
        "price": {
          "currency": "String",
          "priceId": "String",
          "unitPrice": "Number",
          "newUnitPrice": "Number",
          "totalNetValue": "Number",
          "discount": "Number",
          "includesTax": "Boolean",
          "tax": {
            "taxClass": "String",
            "taxRate": "String",
            "prices": {
              "grossValue": "Number",
              "netValue": "Number"
            }
          }
        },
        "product": {
          "productId": "String",
          "name": "String",
          "media": "Map",
          "taxClasses" : "Object"
        }
      }
    ],
    "metadata": {
      "version": "Integer",
      "createdAt": "String",
      "modifiedAt": "String",
      "schema" : "String",
      "mixins" : "Object"
    },
    "mixins" : "Object",
    "comment": {
      "employeeComment": "String"
    },
    "billingAddress": {
      "id": "String",
      "name": "String",
      "addressLine1": "String",
      "addressLine2": "String",
      "city": "String",
      "countryCode": "String",
      "postcode": "String",
      "state": "String"
    },
    "shippingAddress": {
      "id": "String",
      "name": "String",
      "addressLine1": "String",
      "addressLine2": "String",
      "city": "String",
      "countryCode": "String",
      "postcode": "String",
      "state": "String"
    },
    "company": "String"
  }
}
</code></pre></td></tr><tr><td>quote.updated</td><td><pre class="language-json"><code class="lang-json">{
  "previousStatus": "String",
  "quote": {
    "id": "string",
    "customer:": {
      "customerId": "String",
      "firstName": "String",
      "lastName": "String"
    },
    "employee:": {
      "employeeId": "String",
      "firstName": "String",
      "lastName": "String"
    },
    "cartId": "String",
    "orderId": "String",
    "siteCode": "String",
    "currency": "String",
    "status": {
      "value": "String",
      "comment": "String",
      "quoteReason": {
        "id": "String",
        "code": "String",
        "message": "Map",
        "type": "String"
      }
    },
    "validTo": "String",
    "totalPrice": {
      "currency": "String",
      "netValue": "Number",
      "grossValue": "Number",
      "taxValue": "Number"
    },
    "subTotalPrice": {
      "currency": "String",
      "netValue": "Number",
      "grossValue": "Number",
      "taxValue": "Number"
    },
    "taxAggregate": {
      "lines": [
        {
          "name": "String",
          "amount": "Number",
          "rate": "Number",
          "taxable": "Number"
        }
      ]
    },
    "shippingCost": {
      "value": "Number",
      "methodId": "String",
      "zoneId": "String",
      "methodName": "String",
      "shippingCode": "String"
    },
    "items": [
      {
        "itemId": "String",
        "quantity": {
          "quantity": "Number",
          "unitCode": "String"
        },
        "price": {
          "currency": "String",
          "priceId": "String",
          "unitPrice": "Number",
          "newUnitPrice": "Number",
          "totalNetValue": "Number",
          "discount": "Number",
          "includesTax": "Boolean",
          "tax": {
            "taxClass": "String",
            "taxRate": "String",
            "prices": {
              "grossValue": "Number",
              "netValue": "Number"
            }
          }
        },
        "product": {
          "productId": "String",
          "name": "String",
          "media": "Map"
        }
      }
    ],
    "metadata": {
      "version": "Integer",
      "createdAt": "String",
      "modifiedAt": "String"
    },
    "mixins" : "Object",
    "comment": {
      "employeeComment": "String"
    },
    "billingAddress": {
      "id": "String",
      "name": "String",
      "addressLine1": "String",
      "addressLine2": "String",
      "city": "String",
      "countryCode": "String",
      "postcode": "String",
      "state": "String"
    },
    "shippingAddress": {
      "id": "String",
      "name": "String",
      "addressLine1": "String",
      "addressLine2": "String",
      "city": "String",
      "countryCode": "String",
      "postcode": "String",
      "state": "String"
    },
    "company": "String"
  }
}
</code></pre></td></tr><tr><td>quote.deleted</td><td><pre class="language-json"><code class="lang-json">{
 "quoteId": "String"
}
</code></pre></td></tr></tbody></table>
 
