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

# 2025-11-13: Referral Coupon Service - removal of deprecated endpoints

## Overview

All previously deprecated endpoints are now
removed ([2025-03-28: Referral Coupon Service - deprecations](../2025/2025-03-28-referral-coupon.md)).

## Removed endpoints & fields

| Endpoint                                                                                                                                                                                                                                    | Description                                                                                                                                                      |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving customer's referral coupon code](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/referral-coupon-management)                                                                 | Endpoint previously available under the `/coupon/ReferralCouponCode/{customerId}` is now available only on `/coupon/{tenant}/referral-coupons/{customerNumber}`. |
| [Creating a referral coupon code for a specific customer](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/referral-coupon-management#post-coupon-tenant-referral-coupons-customernumber) | Endpoint previously available under the `/coupon/ReferralCouponCode/{customerId}` is now available only on `/coupon/{tenant}/referral-coupons/{customerNumber}`. |

## Known problems

There are no known problems.
 
