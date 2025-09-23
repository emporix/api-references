---
icon: sliders
layout:
<<<<<<< HEAD
  width: wide
=======
>>>>>>> parent of 31b07a6 (changelog width)
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
# 2025-03-04: Shopping List Service - `metadata` field changes

## Overview

The `metadata` field at root level is now deprecated in GET responses, as each shopping list now maintains its own independent `metadata` field. This field will be fully removed on September 1st, 2025. Additionally we have added version validation for update operation where you can provide `version` in the update payload to validate it against the current entity version, preventing unintentional overriding when multiple updates occur simultaneously.

## Updated endpoints

| Endpoint                                                                                                                     | Description                                                                                 |
|------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| [Retrieving a shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-lists)                     | Deprecated `metadata` field on root level and added `metadata` field to each shopping list. |
| [Retrieving a customer shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-lists#get-shoppinglist-tenant-shopping-lists-customerid)   | Deprecated `metadata` field on root level and added `metadata` field to each shopping list. |
| [Updating a customer shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-lists#put-shoppinglist-tenant-shopping-lists-customerid)       | Added `metadata.version` to request payload which allows for version validation             |

## Known problems

There are no known problems.
