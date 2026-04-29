---
icon: circle-plus
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

# RELEASE_DATE: Product Service - code on dynamic variant variants map entries

## Overview

For `DYNAMIC_VARIANT` root products, each entry in the denormalized `variants` map now includes **`code`**: the business code of the corresponding variant product (the same value as on the variant product itself). This lets storefronts and integrations read SKU-style identifiers from the root response without an extra lookup.

Webhook event documentation for payloads that include the dynamic variant `variants` structure has been aligned with this field.

## Modified behavior

When you retrieve a dynamic variant **root** product, every key under `variants` includes:

- `code` — string, code of the source variant product

Existing fields such as `version`, `name`, `parentVariantId`, `sellable`, `dynamicVariantType`, and `variantAttributes` are unchanged.

## Known problems

There are no known problems.

## Links

* [How to work with dynamic variant products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/product#how-to-work-with-dynamic-variant-products)
* [Events - Index Item](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-events/events-index)
