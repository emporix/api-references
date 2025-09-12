---
icon: hourglass-half
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

# 2025-03-28: Coupon Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01. From now, use the `/coupon/` base path for all the [coupons endpoints](/openapi/coupon) to manage coupons and referral coupons.


## Deprecated endpoints

| Endpoint                                                                                                        | Description                                                         |
|-----------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| [Retrieving list of coupons by criteria](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management)          | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Creating a new coupon](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons)                                   | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving information about particular coupon by code](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management#get-coupon-tenant-coupons-code) | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Updating the coupon by code](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management#put-coupon-tenant-coupons-code)                              | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Partially updating the coupon by code](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management#patch-coupon-tenant-coupons-code)                  | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Deleting a coupon by code](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management#delete-coupon-tenant-coupons-code)                             | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Validating redeemability of a coupon](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-validation)                  | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving a list of redemptions by criteria](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-redemption)   | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Redeeming the coupon by creating a redemption](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-redemption#post-coupon-tenant-coupons-code-redemptions)       | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving a coupon redemption](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management#get-coupon-tenant-coupons-code-redemption)              | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Deleting a coupon redemption](https://developer.emporix.io/api-references/api-guides//rewards-and-promotions/coupon/api-reference/coupon-management#delete-coupon-tenant-coupons-code-redemption)               | Endpoint will be removed and moved under the `/coupon/` base path.  |

## Known problems

There are no known problems.