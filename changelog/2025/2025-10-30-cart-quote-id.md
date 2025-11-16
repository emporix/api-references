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

# 2025-10-30: Cart Service - quoteId added

## Overview

New attribute added to cart:

  * `quoteId` - this field contains the ID of the quote associated with the cart

When a quote is created from a cart using the [Creating a quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#post-quote-tenant-quotes) endpoint, the cart is automatically closed and the `quoteId` is set on that cart. This ensures proper traceability between carts and their corresponding quotes.

## Modified endpoints

| Endpoint                                                                                                                                                                   | Description                    |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| [Updating a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid)                                  | New attribute `quoteId` added. |
| [Retrieving cart details by ID](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)                    | New attribute `quoteId` added. |
| [Retrieving cart details by criteria](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts)                     | New attribute `quoteId` added. |
| [Searching for carts](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts-search)                             | New attribute `quoteId` added. |

## Known problems

There are no known problems.

