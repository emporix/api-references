---
---

# 2025-03-28: Coupon Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01. From now, use the `/coupon/` base path for all the [coupons endpoints](/openapi/coupon) to manage coupons and referral coupons.


## Deprecated endpoints

| Endpoint                                                                                                        | Description                                                         |
|-----------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)          | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Creating a new coupon](/openapi/coupon/#operation/POST-coupon-create-coupon)                                   | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon) | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Updating the coupon by code](/openapi/coupon/#operation/PUT-coupon-update-coupon)                              | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Partially updating the coupon by code](/openapi/coupon/#operation/PATCH-coupon-update-coupon)                  | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Deleting a coupon by code](/openapi/coupon/#operation/DELETE-coupon-remove-coupon)                             | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Validating redeemability of a coupon](/openapi/coupon/#operation/POST-coupon-validate-coupon)                  | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving a list of redemptions by criteria](/openapi/coupon/#operation/GET-coupon-list-coupon-redemptions)   | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Redeeming the coupon by creating a redemption](/openapi/coupon/#operation/POST-coupon-invalidate-coupon)       | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving a coupon redemption](/openapi/coupon/#operation/GET-coupon-retrieve-coupon-redemption)              | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Deleting a coupon redemption](/openapi/coupon/#operation/DELETE-coupon-remove-coupon-redemption)               | Endpoint will be removed and moved under the `/coupon/` base path.  |

## Known problems

There are no known problems.