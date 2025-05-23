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
| [Adding a product to cart](/openapi/cart/#operation/POST-cart-add-item-to-cart)                   | Added the `keepAsSeparateLine` attribute. |
| [Adding multiple products to cart](/openapi/cart/#operation/POST-cart-add-multiple-items-to-cart) | Added the `keepAsSeparateLine` attribute. |

## Known problems

Quotes do not support separate line items yet.