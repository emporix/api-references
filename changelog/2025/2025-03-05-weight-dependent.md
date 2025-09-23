---
icon: wand-sparkles
layout:
<<<<<<< HEAD
  width: wide
=======
>>>>>>> parent of 31b07a6 (changelog width)
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
# 2025-03-05: Weight dependent products

## Overview

A new boolean attribute `weightDependent` has been added to the product model. It allows to mark the product as weight-dependent if the line item price can change after packaging. This is necessary to ensure that credit card payments can be authorized.
Having the attribute available directly on the product level, the corresponding attribute `weightDependent` in `Adding a product to cart` API has been deprecated. The cart services checks the value specified on a product model and sets the `weightDependent` value on the cart item.

## Updated endpoints

| Endpoint                                                                                          | Description                                     |
|---------------------------------------------------------------------------------------------------|-------------------------------------------------|
| [Adding a product to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items)                   | Deprecated request attribute `weightDependent`. |
| [Adding multiple products to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-itemsbatch) | Deprecated request attribute `weightDependent`. |
| [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products)                 | New request attribute `weightDependent` added.  |
| [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk)       | New request attribute `weightDependent` added.  |
| [Upserting a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid)                      | New request attribute `weightDependent` added.   |
| [Upserting multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk)       | New request attribute `weightDependent` added.   |
| [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid)          | New request attribute `weightDependent` added.   |
| [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid)                  | New response attribute `weightDependent` added.  |
| [Retrieving all of products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products)               | New response attribute `weightDependent` added.  |

## Known problems

There are no known problems.