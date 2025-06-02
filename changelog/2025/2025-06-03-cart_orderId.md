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

# 2025-06-03: Cart Service - orderId added

## Overview

A new attribute `orderId` has been added to the cart object. The new field will have orderId of the order associated with the cart. 

## Modified endpoints

| Endpoint                                                                                                                                                                                   | Description                     |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------|
| [Retrieving cart details by ID](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)                      | New attribute `orderId` added.  |
| [Retrieving cart details by criteria](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/carts#get-cart-tenant-carts)                       | New attribute `orderId` added.  |

## Known problems

There are no known problems.
