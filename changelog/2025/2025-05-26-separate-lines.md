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

# 2025-05-12: Cart Service - add items as separate lines to a cart

## Overview

The cart service now allows adding items to cart as separate lines. This means the same product can appear in the cart multiple times, enabling you to apply external discounts or fees to individual items.
To add item as a separate line, specify `keepAsSeparateLine` property in the `Adding a product to cart` request.

## Added endpoints

| Endpoint                                                                                          | Description                               |
|---------------------------------------------------------------------------------------------------|-------------------------------------------|
| [Adding a product to cart](https://developer.emporix.io/api-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items)               | Added the `keepAsSeparateLine` attribute. |
| [Adding multiple products to cart](https://developer.emporix.io/api-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-itemsbatch) | Added the `keepAsSeparateLine` attribute. |

## Known problems

Quotes do not support separate line items yet.