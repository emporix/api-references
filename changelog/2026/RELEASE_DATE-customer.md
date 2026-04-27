---
icon: sliders-up
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

# RELEASE_DATE: Customer Service - partial update - contactEmail field cannot be unset once a value is present

## Overview

The Customer Service has been updated so that the `contactEmail` field can no longer be unset through the customer profile partial update (PATCH) endpoints if it already contains a value.
This restriction applies to both the customer-managed and tenant-managed API. 

## Updated endpoints

| Endpoint                                                                                                                                                                            | Description                                                              |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| [Updating a customer profile (by customer)](https://developer.emporix.io/api-references-1/readme/api-reference-12/account-and-profile#patch-customer-tenant-me)                     | The `contactEmail` field can no longer be unset once a value is present. |
| [Updating a customer profile (by tenant)](https://developer.emporix.io/api-references-1/readme/api-reference-11/account-and-profile#patch-customer-tenant-customers-customernumber) | The `contactEmail` field can no longer be unset once a value is present. |

## Known problems

There are no known problems.
