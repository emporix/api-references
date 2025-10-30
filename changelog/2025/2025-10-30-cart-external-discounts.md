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

# 2025-10-30: Cart Service - external discounts on cart level

## Overview

Cart Service now supports applying external discounts directly at the cart level. This enables external systems (such as ERP systems) to apply cart-wide discounts that are calculated outside of Commerce Engine.

New attribute added to cart:

* `externalDiscounts` - an array of external discounts that can be applied to the entire cart, similar to how external discounts can be applied at the item level

Each external discount includes:

* `id` - unique identifier of the external discount
* `discountType` - type of discount: `PERCENT`, `ABSOLUTE`, or `FREE_SHIPPING`
* `value` - the discount value (percentage for PERCENT type, or monetary amount for ABSOLUTE type)
* `discountCalculationType` - determines how the discount is applied:
  * `TOTAL` - discount is spread across products, product fees, and shipping cost
  * `SUBTOTAL` - discount is spread across products only, without fees or shipping
* `sequence` - defines the order in which multiple discounts are applied

{% hint style="warning" %}
Applying external discounts to a cart requires the `cart.cart_manage_external_prices` scope.
{% endhint %}

## Updated endpoints

| Endpoint                                                                                                                                                                   | Description                                                            |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| [Updating a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid)                    | The `externalDiscounts` attribute has been added.  |
| [Retrieving cart details by ID](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)                      | The `externalDiscounts` attribute is included in the response.  |

## Known problems

There are no known problems.

