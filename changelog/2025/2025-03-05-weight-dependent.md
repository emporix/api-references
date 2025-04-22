---
---
# 2025-03-05: Weight dependent products

## Overview

A new boolean attribute `weightDependent` has been added to the product model. It allows to mark the product as weight-dependent if the line item price can change after packaging. This is necessary to ensure that credit card payments can be authorized.
Having the attribute available directly on the product level, the corresponding attribute `weightDependent` in `Adding a product to cart` API has been deprecated. The cart services checks the value specified on a product model and sets the `weightDependent` value on the cart item.

## Updated endpoints

| Endpoint                                                                                          | Description                                     |
|---------------------------------------------------------------------------------------------------|-------------------------------------------------|
| [Adding a product to cart](/openapi/cart/#operation/POST-cart-add-item-to-cart)                   | Deprecated request attribute `weightDependent`. |
| [Adding multiple products to cart](/openapi/cart/#operation/POST-cart-add-multiple-items-to-cart) | Deprecated request attribute `weightDependent`. |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product)                 | New request attribute `weightDependent` added.  |
| [Creating multiple products](/openapi/product/#operation/POST-product-create-bulk-products)       | New request attribute `weightDependent` added.  |
| [Upserting a product](openapi/product/#operation/PUT-product-update-product)                      | New request attribute `weightDependent` added.   |
| [Upserting multiple products](/openapi/product/#operation/PUT-product-update-bulk-products)       | New request attribute `weightDependent` added.   |
| [Partially updating a product](/openapi/product/#operation/PATCH-product-update-product)          | New request attribute `weightDependent` added.   |
| [Retrieving a product](/openapi/product/#operation/GET-product-retrieve-product)                  | New response attribute `weightDependent` added.  |
| [Retrieving all of products](/openapi/product/#operation/GET-product-list-products)               | New response attribute `weightDependent` added.  |

## Known problems

There are no known problems.