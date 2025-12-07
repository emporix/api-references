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

# 2025-12-09: Customer Segments Service - customerId query parameter

## Overview

A new `customerId` query parameter has been added to the customer segments retrieval endpoints. This parameter allows you to retrieve customer segments for a specific customer. The parameter can only be used with the `customersegment.segment_read` scope.

## Modified endpoints

| Endpoint | Description |
| --- | --- |
| [Retrieving all customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#get-customer-segment-tenant-segments) | Added `customerId` query parameter. |
| [Searching with parameters for customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments-search) | Added `customerId` query parameter. |

## Known problems

There are no known problems.

