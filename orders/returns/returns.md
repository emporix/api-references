---
seo:
  title: Returns Service Tutorials
  description: returns
icon: graduation-cap
layout:
  width: wide
---

# Returns Tutorial

## How to configure the Returns Service

By default, the expiration date offset for a return request is set to 30 days.

### Update the expiration date settings

You can update the expiration date offset for a tenant by sending a request to the [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint in the Configuration Service.

In the following example, we are changing the expiration date offset to 14 days.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/country-service/api-reference/" %}
[api-reference](../../configuration/country-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT 
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "key": "return.defaultExpiryDate",
    "secured": false,
    "value": "14",
    "version": 1
  }'
  
```

## How to manage return requests

A return can be created both by a customer directly on your business' website, or by an employee on behalf of a customer.

{% hint style="warning" %}
If you want the return-service-specific events to trigger any actions of your choice, configure webhook subscriptions. See the [_Webhook Service Tutorials_](../../webhooks/webhook-service/webhooks-tutorial.md) for more information.
{% endhint %}

First, ensure that the orders that you want to return (along with their `order_Id` values) exist in the system.

### Create a return by a customer

On the storefront, a customer fills in the applicable fields in the return request:

* `orders`
* `reason`
* `mixins`

Based on your tenant's configuration settings and customer's oauth token, the remaining fields are populated automatically.

When a customer sends a return request, the [Creating a single return entity](https://developer.emporix.io/api-references/api-guides/orders/returns/api-reference/returns#post-return-tenant-returns) endpoint is called.

{% hint style="warning" %}
The following set of scopes is granted to a customer group:

```
returns.returns_read_own returns.returns_manage_own
 
```

The `returns.returns_read` and `returns.returns_manage` scopes are only required for employee groups.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/return/{tenant}/returns' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: string' 
  -d '{
    "orders": [
      {
        "id": "B1LMYY52",
        "items": [
          {
            "id": "32090",
            "quantity": 2,
            "reason": {
              "code": "001"
            }
          },
          {
            "id": "32102",
            "quantity": 15,
            "reason": {
              "details": "It'\''s too small."
            }
          }
        ]
      }
    ],
    "reason": {
      "code": "001",
      "details": "The items do not work."
    },
    "mixins": {
      "customAttributes": {
        "attr1": "value1"
      }
    },
    "metadata": {
      "mixins": {
        "customAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"
      }
    }
  }'
```

### Create a return on behalf of a customer

To create a return on behalf of a customer, you need to send a request to the [Creating a single return entity](https://developer.emporix.io/api-references/api-guides/orders/returns/api-reference/returns#post-return-tenant-returns) endpoint.

{% hint style="warning" %}
The following set of scopes is required for an employee group:

```
returns.returns_read returns.returns_manage
 
```

The `returns.returns_read_own` and `returns.returns_manage_own` scopes are only required for customer groups.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/return/{tenant}/returns' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: string' 
  -d '{
    "orders": [
      {
        "id": "B1LMYY52",
        "items": [
          {
            "id": "32090",
            "quantity": 2,
            "reason": {
              "code": "001"
            }
          },
          {
            "id": "32102",
            "quantity": 15,
            "reason": {
              "details": "It'\''s too small."
            }
          }
        ]
      }
    ],
    "reason": {
      "code": "001",
      "details": "The items do not work."
    },
    "mixins": {
      "customAttributes": {
        "attr1": "value1"
      }
    },
    "metadata": {
      "mixins": {
        "customAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"
      }
    }
  }'
```

{% hint style="warning" %}
The `approvalStatus` field is automatically populated during the creation of a return and is always set to `PENDING`.
{% endhint %}

### Update the return request by a customer

Customers can update their return request only when the approval status of the request is `PENDING`. When a customer updates a return, the [Updating a single return](https://developer.emporix.io/api-references/api-guides/orders/returns/api-reference/returns#post-return-tenant-returns) endpoint is called.

{% hint style="warning" %}
The following set of scopes is granted to a customer group:


* `returns.returns_read_own` 
* `returns.returns_manage_own`


The `returns.returns_read` and `returns.returns_manage` scopes are only required for employee groups.
{% endhint %}

In this scenario, the customer updates the reason for the return.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT 
  'https://api.emporix.io/return/{tenant}/returns/{returnId}' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: string' 
  -d '{
    "id": "6369140c5c6de75d9e84c97f",
    "orders": [
      {
        "id": "B1LMYY52",
        "items": [
          {
            "id": "32090",
            "quantity": 2,
            "reason": {
              "code": "001"
            }
          },
          {
            "id": "32102",
            "quantity": 15
          }
        ]
      }
    ],
    "reason": {
      "code": "001",
      "details": "The items do not work."
    },
    "mixins": {
      "customAttributes": {
        "attr1": "value1"
      }
    },
    "metadata": {
      "version": 1
    }
  }'
```

### Update the return status

As an employee, you can update all the fields available during the return creation, as well as the `approvalStatus` and `received` fields, by sending a request to the [Updating a single return](https://developer.emporix.io/api-references/api-guides/orders/returns/api-reference/returns#put-return-tenant-returns-returnid) endpoint.

{% hint style="warning" %}
The following set of scopes is required for an employee group:

```
returns.returns_read returns.returns_manage
 
```

The `returns.returns_read_own` and `returns.returns_manage_own` scopes are only required for customer groups.
{% endhint %}

In this scenario, the employee updates the approval status of the return request.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT 
  'https://api.emporix.io/return/{tenant}/returns/{returnId}' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: string' 
  -d '{
    "id": "6369140c5c6de75d9e84c97f",
    "orders": [
      {
        "id": "B1LMYY52",
        "items": [
          {
            "id": "32090",
            "quantity": 2,
            "reason": {
              "code": "001"
            }
          },
          {
            "id": "32102",
            "quantity": 15
          }
        ]
      }
    ],
    "reason": {
      "code": "001",
      "details": "The items do not work."
    },
    "mixins": {
      "customAttributes": {
        "attr1": "value1"
      }
    },
    "metadata": {
      "version": 1
    }
  }'
```
