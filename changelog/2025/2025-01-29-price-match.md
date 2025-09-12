---
icon: wand-sparkles
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

# 2025-01-29: Price Match - new `priceListId` field added

## Overview

The `priceListId` field  has been added to the price match endpoints. The field is populated only in the case when a returned prices belongs to any price list. Otherwise the field is not returned.

## Updated endpoints

| Endpoint                                                                 | Description                                                    |
| ----------------------------------------------------------------------   | ---------------------------------------------------------------|
| [Matching price for a specific attributes](https://developer.emporix.io/api-references/api-guides//prices-and-taxes/price-service/api-reference/price-matching#post-price-tenant-match-prices) | Added a new `priceListId` field to the response.                                     |
| [Matching price for session context](https://developer.emporix.io/api-references/api-guides//prices-and-taxes/price-service/api-reference/price-matching#post-price-tenant-match-prices-by-context)  | Added a new `priceListId` field to the response. |


## Known problems

There are no known problems.
