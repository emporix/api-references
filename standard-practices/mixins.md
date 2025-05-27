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
---

# Mixins

Mixins are custom properties that you can use to describe your business resources in more details. Mixins can be applied to most objects in the Emporix API.\
Learn more about mixin schemas in [Schema Service](https://developer.emporix.io/docs/openapi/schema/).

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
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
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
