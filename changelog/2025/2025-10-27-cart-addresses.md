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

# 2025-10-27: Cart Service - address management

## Overview

Cart Service now supports comprehensive address management directly on the cart object. This enhancement allows you to specify billing and shipping addresses that are used for tax determination and shipping cost calculation.

New attribute added to cart:

* `addresses` - an array of addresses associated with the cart

Each address can include the following properties:

* `type` - address type: `BILLING` or `SHIPPING`
* `contactName` - contact name for the address
* `companyName` - company name
* `street` - street name
* `streetNumber` - street number
* `streetAppendix` - additional street information
* `zipCode` - postal/zip code
* `city` - city name
* `country` - two-letter country code (ISO 3166)

## Address auto-population

When addresses are not explicitly provided in the request, the Cart Service automatically populates them based on the following priority order:

1. **Legal Entity Address** - If the cart is associated with a legal entity, the first location with both `country`,`zip-code` and required address type is used (origin: `LEGAL_ENTITY`)
2. **Customer Address** - If the cart has a logged-in customer, the default address matching the required type is used (origin: `CUSTOMER`)
3. **Site Homebase Address** - If neither of the above is available, the site's homebase address is used (origin: `SITE`)

Addresses provided in the request are marked with origin `REQUEST` in the response.

For backward compatibility the legal entity address population has to be enabled in the tenant settings: enableLegalEntityAddressFallbackInCart. It is enabled by default for all new tenants.

## Address usage

The addresses specified on the cart are used for:

* **Tax determination** - The appropriate tax country is determined based on the billing or shipping address, as configured in the site's `taxDeterminationBasedOn` setting
* **Shipping cost calculation** - The shipping address is used to calculate accurate shipping costs based on the destination

For more details, see:
* [How to determine a tax country at cart level](https://developer.emporix.io/api-references/api-guides/checkout/cart/cart#how-to-determine-a-tax-country-at-cart-level)
* [How to calculate shipping cost at cart level](https://developer.emporix.io/api-references/api-guides/checkout/cart/cart#how-to-calculate-shipping-cost-at-cart-level)

## Backward compatibility

The existing `countryCode` and `zipCode` parameters at the cart level are still supported for backward compatibility. However, the new `addresses` array provides a more comprehensive and flexible approach to address management.

## Updated endpoints

| Endpoint                                                                                                                                                                   | Description                                                            |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| [Creating a new cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts)                    | The `addresses` attribute has been added to the request body.  |
| [Updating a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid)                    | The `addresses` attribute has been added to the request body.  |
| [Retrieving cart details by ID](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)                      | The `addresses` attribute with origin information is included in the response.  |

## Known problems

There are no known problems.

