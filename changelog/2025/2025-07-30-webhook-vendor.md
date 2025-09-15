---
layout:
  width: wide
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

# 2025-07-30: Webhook Service - update order event schema

## Overview

Order event schema was updated.

## Added new fields

| Event                  | Description                                                                           |
|------------------------|---------------------------------------------------------------------------------------|
| `schema.order-created` | New fields `vendor`,`masterOrder`,`splitInfo` added                                   |
| `schema.order-updated` | New fields `vendor`,`masterOrder`,`orderType`,`splitInfo`,`subOrders`,`splitBy` added |

## Known problems

There are no known problems.