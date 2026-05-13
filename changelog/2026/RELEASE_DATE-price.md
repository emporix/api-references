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

# RELEASE_DATE: Price Service - siteCodes support in price search

## Overview

The Price Service search endpoint now supports a new `siteCodes` field, which allows searching for prices across multiple site codes in a single request. If the existing `siteCode` field is specified, `siteCodes` is ignored.

## Updated endpoints

| Endpoint                                                                 | Description                                                    |
| ----------------------------------------------------------------------   | ---------------------------------------------------------------|
| [Searching for prices](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#post-price-tenant-prices-search) | New attribute `siteCodes` added to request payload. Accepts an array of site codes for which the prices should be retrieved. |

## Known problems

There are no known problems.
