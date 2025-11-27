---
icon: sparkles
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: false
  pagination:
    visible: true
---

# 2025-11-27: Product Service - classification mixins support

## Overview

The Product Service now exposes classification mixins for products that are assigned to classification categories. When a product is assigned to one or more classification categories, the product response includes a `classificationMixins` field in its metadata, providing information about all applicable classification mixins inherited from the category hierarchy.

This enhancement works in conjunction with the Category Service's classification categories feature, enabling better product classification and attribute management.

## What's new

### Classification mixins in product metadata

When retrieving product details, the product metadata now includes a `classificationMixins` field that contains:

| Field | Description |
|-------|-------------|
| `name` | Name of the mixin (pattern: `^[a-zA-Z0-9]\S*$`) |
| `mixinPath` | The mixins path that should be used when defining attributes on a product. It's built based on the following pattern: `class_<sourceCategory.code>_<name>` |
| `schemaUrl` | URL of the mixin schema defined on the category level (pattern: `^https?://[^\s/$.?#].\S*$`) |
| `usedSchemaUrl` | If the mixin has been already used in the product, this field contains the URL of the used mixin schema |
| `obsoleteSchemaUrlUsed` | Boolean indicating whether the used mixin schema is obsolete (when `usedSchemaUrl` differs from `schemaUrl`) |
| `required` | Boolean indicating whether the mixin is required |
| `sourceCategoryId` | Unique identifier of the category from which the mixin originates (can be the product's category or one of its parent categories) |

The `classificationMixins` array aggregates all classification mixins from:
- The category to which the product is directly assigned
- All parent categories in the category hierarchy that are classification categories

## Affected endpoints

All product retrieval endpoints now include the `classificationMixins` field in the product metadata:

| Endpoint | Description |
|----------|-------------|
| [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-resources#get-product-tenant-products-productid) | Response now includes `classificationMixins` in the metadata for products assigned to classification categories |
| [Retrieving all products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-resources#get-product-tenant-products) | Response now includes `classificationMixins` in the metadata for products assigned to classification categories |
| [Searching for products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-resources#post-product-search-products) | Response now includes `classificationMixins` in the metadata for products assigned to classification categories |

## Example usage

### Product response with classification mixins

When retrieving a product that is assigned to a classification category, the response includes the `classificationMixins` field:

```json
{
  "id": "product-123",
  "name": "Cordless Drill",
  "code": "DRILL-001",
  "productType": "BASIC",
  "published": true,
  "categoryIds": ["0720b75e-ee1c-4d76-9f53-eb3af3927e13"],
   "mixins": {
    "productCustomAttributes": {
      "orderUnit": "H87",
      "minOrderQuantity": 1
    },
    "class_EA673_toolsClassification": {
      "powerSource": "battery",
      "voltage": "18V"
    },
    "class_EA677_cordedToolsClassification": {
      "chuckSize": "13mm",
      "maxTorque": "50Nm"
    }
  },
  "metadata": {
    "version": 1,
    "createdAt": "2024-11-27T10:00:00.000Z",
    "modifiedAt": "2024-11-27T10:00:00.000Z",
    "classificationMixins": [
      {
        "name": "toolsClassification",
        "mixinPath": "class_EA673_toolsClassification",
        "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
        "required": false,
        "sourceCategoryId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb"
      },
      {
        "name": "cordedToolsClassification",
        "mixinPath": "class_EA677_cordedToolsClassification",
        "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json",
        "required": false,
        "sourceCategoryId": "0720b75e-ee1c-4d76-9f53-eb3af3927e13"
      }
    ],
    "mixins": {
      "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/productCustomAttributesMixIn-v38.json",
      "class_EA673_toolsClassification": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
      "class_EA677_cordedToolsClassification": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json"
    }
  } 
}
```

### Using classification mixins for product attributes

The `classificationMixins` field helps you understand:
1. Which classification schemas are available for the product based on its category assignment
2. The correct `mixinPath` to use when defining classification attributes
3. Whether a classification mixin is required
4. Which category in the hierarchy each classification mixin originates from
5. If the product is using an outdated version of a classification schema

## Known problems

There are no known problems.

