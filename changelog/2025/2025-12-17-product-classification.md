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

# 2025-12-17: Product Service - classification mixins support

## Overview

The Product Service now exposes classification mixins for products that are assigned to classification categories. When a product is assigned to one or more classification categories, the product response includes a `classificationMixins` field in its metadata, providing information about all applicable classification mixins inherited from the category hierarchy.

This enhancement works in conjunction with the Category Service's classification categories feature, enabling better product classification and attribute management.

## What's new

### Classification mixins in product metadata

When retrieving product details, the product metadata now includes a `classificationMixins` field that contains:

| Field | Description                                                                                                                                                |
|-------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name` | Name of the mixin (pattern: `^[a-zA-Z0-9_]\S*$`)                                                                                                           |
| `mixinPath` | The mixins path that should be used when defining attributes on a product. It's built based on the following pattern: `class_<sourceCategory.code>_<name>` |
| `schemaUrl` | URL of the mixin schema defined on the category level (pattern: `^https?://[^\s/$.?#].\S*$`)                                                               |
| `usedSchemaUrl` | If the mixin has been already used in the product, this field contains the URL of the used mixin schema                                                    |
| `obsoleteSchemaUrlUsed` | Boolean indicating whether the used mixin schema is obsolete (when `usedSchemaUrl` differs from `schemaUrl`)                                               |
| `required` | Boolean indicating whether the mixin is required                                                                                                           |
| `sourceCategoryId` | Unique identifier of the category from which the mixin originates (can be the product's category or one of its parent categories)                          |

The `classificationMixins` array aggregates all classification mixins from:
- The category to which the product is directly assigned
- All parent categories in the category hierarchy that are classification categories

## Modified endpoints

All product retrieval endpoints now include the `classificationMixins` field in the product metadata:

| Endpoint | Description |
|----------|-------------|
| [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-resources#get-product-tenant-products-productid) | Response now includes `classificationMixins` in the metadata for products assigned to classification categories. |
| [Retrieving all products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-resources#get-product-tenant-products) | Response now includes `classificationMixins` in the metadata for products assigned to classification categories. |
| [Searching for products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-resources#post-product-search-products) | Response now includes `classificationMixins` in the metadata for products assigned to classification categories. |

## Known problems

There are no known problems.

## Links

- [Product Tutorial](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/product-labels-and-brands/product-service/product)
- [Classification Tutorial](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/catalogs-and-categories/category-tree/classification)

