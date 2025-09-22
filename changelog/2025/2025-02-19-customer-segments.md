---
icon: wand-sparkles
layout:
   width: wide
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

# 2025-02-19: Customer Segments Service - expanded response for retrieving category trees for a customer segments endpoint

## Overview

From now on, the response of the "Retrieving category trees for a customer segments" endpoint includes new fields: `localizedDescription`, `localizedSlug`, `ecn`, `validity`, `position`, and `published`, which allows fetching complete category tree information in a single request.

## Updated endpoints

| Endpoint                                                                                                                               | Description                                                                                                            |
|----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| [Retrieving category trees for a customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-items-category-trees) | Added `localizedDescription`, `localizedSlug`, `ecn`, `validity`, `position`, and `published` fields to the responses. |

## Known problems

There are no known problems.