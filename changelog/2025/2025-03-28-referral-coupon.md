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

All deprecations will be removed on 2025-10-01. From now, use the new [referral coupons endpoints](/openapi/coupon/#tag/Referral-Coupon-Management) to referral coupons.


## Deprecated endpoints

| Endpoint                                                                                                                      | Description                                                                                   |
|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| [Retrieving customer's referral coupon code](/openapi/coupon/#operation/GET-coupon-retrieve-referral-coupon)                  | Endpoint will be removed and moved under <code>/coupon/{tenant}/referral-coupons/{customerNumber}</code>. |
| [Creating a referral coupon code for a specific customer](/openapi/coupon/#operation/POST-coupon-create-referral-coupon-code) | Endpoint will be removed and moved under <code>/coupon/{tenant}/referral-coupons/{customerNumber}</code>. |


## Known problems

There are no known problems.