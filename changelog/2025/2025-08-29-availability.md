---
icon: sparkles
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

# 2025-08-29: Availability service - vendor handling added

## Overview

New field `vendorId` was added to the availability response. Vendor employees can modify and see only availabilities for products that belong to their vendor.

## New scopes
- `availability.availability_manage_by_vendor`
- `availability.availability_view_by_vendor`

## Modified endpoints

| Endpoint                                                                                                                                                                                                                  | Description                   |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| [Retrieving all availability information for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site)                                        | New attribute `vendorId` added to response. New scope `availability.availability_view_by_vendor` added. |
| [Retrieving product availabilities for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)                                                   | New attribute `vendorId` added to response. New scope `availability.availability_view_by_vendor` added. |
| [Retrieving a product's availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-productid-site)                                                                  | New attribute `vendorId` added to response. New scope `availability.availability_view_by_vendor` added. |
| [Creating a new availability for a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site)                                                               | New scope `availability.availability_manage_by_vendor` added. |
| [Upserting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#put-availability-tenant-availability-productid-site)                                                       | New scope `availability.availability_manage_by_vendor` added. |
| [Deleting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#delete-availability-tenant-availability-productid-site)                                                     | New scope `availability.availability_manage_by_vendor` added. |

## Known problems

There are no known problems.
