---
seo:
  title: Mixins
  description: Standard practices
toc:
  enable: true
tocMaxDepth: 3
editPage:
  disable: true
label: Mixins
icon: diamonds-4
layout:
  width: wide
description: Mixins let you extend business resources with custom properties by defining JSON schemas, hosting them, and referencing them in resource metadata for flexible, schema-driven data enrichment.
---

# Mixins

Mixins are custom properties that you can use to describe your business resources in more details. Mixins can be applied to most objects in the Emporix API.\
Learn more about mixin schemas in [Schema Service](../utilities/schema/).

## APIs that support mixins

The following APIs and services support mixins in their data models:

### Core entities (with Schema Service support)
These entities support mixin schema creation through the [Schema Service API](../utilities/schema/):
- **Cart** - Cart Service
- **Category** - Category Tree Service
- **Company** - Client Management Service  
- **Coupon** - Coupon Service
- **Custom Entities** and **Custom Instances**
- **Customer** - Customer Service / Customer Management Service
- **Media** - Media Service
- **Customer Address** - Customer Service
- **Location** - Vendor Service
- **Order** - Order Service
- **Availability** - Availability Service
- **Price List** - Price Service
- **Product** - Product Service
- **Quote** - Quote Service
- **Return** - Returns Service
- **Site** - Site Settings Service
- **Vendor** - Vendor Service

### Additional mixin support 
These services accept mixins in their API requests and responses, but require manually created JSON schemas (not supported through Schema Service schema creation):
- **Customer and Item Assignments** - Customer Segments Service
- **Customer Segments** - Customer Segments Service
- **Groups** - IAM Service (supports `mixins` field directly, without `metadata.mixins`)
- **Locations and Contact Assignment** - Client Management Service 
- **Prices** - Price Service
- **Returns** - Returns Service
- **Shopping List** - Shopping List Service


{% hint style="warning" %}
**Note:** For services that don't support schema creation through the Schema Service API, you need to manually create and host your JSON schema, then reference it in the `metadata.mixins` field when using mixins with those APIs. See the [Schema Service tutorial](../utilities/schema/schema.md#how-to-create-a-more-complex-schema) for details on creating references with manually defined JSON schemas.
{% endhint %}

## Schemas

To apply a mixin to a resource, you need to define the mixin schema in the form of a JSON Schema object. Mixin schemas need to be uploaded to a hosting service and then referenced in a resource's mixin metadata.

Here's an example of a JSON schema that defines custom delivery options for customers:

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "description": "Mixin schema for delivery options.",
  "properties": {
    "packaging": {
      "type": ["string", "null"],
      "description": "Delivery packaging."
    },
    "hint": {
      "type": ["string", "null"],
      "description": "Additional information from the customer."
    },
    "substituteProduct": {
      "type": ["boolean"],
      "default": false,
      "description": "Flag indicating whether products that are out of stock can be substituted."
    }
  }
}
```

## Usage example

Here's an example of custom delivery options applied inside a `Customer` object with the schema referenced in mixin metadata:

```json
{
  "mixins": {
    "deliveryOptions": {
      "packaging": "Paper",
      "hint": "If we are not home, the package can be left in front of the door.",
      "substituteProduct": true
    }
  },
  "metadata": {
    "mixinMetadata": {
      "mixins": {
        "deliveryOptions": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/deliveryOptionsMixIn.v6.json"
      }
    }
  }
}
```

## How to add mixins to an object

{% hint style="warning" %}
The procedure below presents applying mixins to a `Customer` object.
{% endhint %}

1. Define your mixin schema.

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "description": "Mixin schema for delivery options.",
  "properties": {
    "packaging": {
      "type": ["string", "null"],
      "description": "Delivery packaging."
    },
    "hint": {
      "type": ["string", "null"],
      "description": "Additional information from the customer."
    },
    "substituteProduct": {
      "type": ["boolean"],
      "default": false,
      "description": "Flag indicating whether products that are out of stock can be substituted."
    }
  }
}
```

2. Upload your schema to a hosting service and save its URL.
3. Update an object with mixins and the mixin schema.

```bash
curl -i -X PATCH \
  'https://api.emporix.io/customer/{tenant}/customers/{customerNumber}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "contactEmail": "example@customer.com",
    "active": true,
    "mixins": {
      "deliveryOptions": {
        "packaging": "Paper",
        "hint": "If we are not home, the package can be left in front of the door.",
        "substituteProduct": true
      }
    },
    "metadata": {
      "mixins": {
        "deliveryOptions": "{{schemaURL}}"
      }
    }
  }
```

## Updating and removing mixins

How you update or remove mixins depends on the API.

### Product Service

The [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) endpoint keeps mixin names that you omit from the request. It merges sent mixin fields recursively. A `null` value does not remove a mixin.

To remove a mixin, retrieve the product and send a full replacement to the [Upserting a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid) endpoint with `partial=false`. Omit the mixin from `mixins` and `metadata.mixins`. For the full procedure, see [How to update product mixins](../products-labels-and-brands/product-service/product.md#how-to-update-product-mixins).

### Quote Service and Schema Service

The [Partially updating a quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#patch-quote-tenant-quotes-quoteid) and [Patching a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#patch-schema-tenant-custom-entities-type-instances-id) endpoints use `add`, `replace`, and `remove` operations on mixin paths. You can send the operation names in lowercase or uppercase. Both endpoints can remove a mixin without replacing the entire resource.
