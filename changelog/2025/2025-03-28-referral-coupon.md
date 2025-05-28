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
#  2025-03-28: Referral Coupon Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01. From now, use the new [referral coupons endpoints]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/referral-coupon-management) to referral coupons.


## Deprecated endpoints

| Endpoint                                                                                                                      | Description                                                                                   |
|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| [Retrieving customer's referral coupon code]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/referral-coupon-management)                  | Endpoint will be removed and moved under <code>/coupon/{tenant}/referral-coupons/{customerNumber}</code>. |
| [Creating a referral coupon code for a specific customer]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/referral-coupon-management#post-coupon-tenant-referral-coupons-customernumber) | Endpoint will be removed and moved under <code>/coupon/{tenant}/referral-coupons/{customerNumber}</code>. |


## Known problems

There are no known problems.