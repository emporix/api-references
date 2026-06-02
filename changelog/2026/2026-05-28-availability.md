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

# 2026-05-28: Availability Service - deprecated endpoints

## Overview

The Availability Service endpoints for managing availabilities that accept `site` as a query parameter, which were [marked as deprecated on 2025-01-13](https://developer.emporix.io/changelog/archive/changelog-2025/2025-01-13-availability), will be removed on **2026-09-01**. They have been replaced with new endpoints that accept `site` as a path parameter.
<br>
The Availability Service endpoints for managing locations have been marked as deprecated and will be removed on **2026-09-01** due to the planned sunset of the related functionalities.

## Deprecated endpoints

### Availability endpoints accepting `site` as query parameter

| Endpoint                                                                                                                                                                          | Description                                                                                                                                                                                                                               |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `[GET] /{tenant}/availability/{productId}?site`                                                                                                                                   | Deprecated. Use [Retrieving a product availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-productid-site) instead.                 |
| `[POST] /{tenant}/availability/{productId}?site`                                                                                                                                  | Deprecated. Use [Creating a new availability for a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site) instead.        |
| `[PUT] /{tenant}/availability/{productId}?site`                                                                                                                                   | Deprecated. Use [Upserting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#put-availability-tenant-availability-productid-site) instead.   |
| `[DELETE] /{tenant}/availability/{productId}?site`                                                                                                                                | Deprecated. Use [Deleting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#delete-availability-tenant-availability-productid-site) instead. |
| `[GET] /{tenant}/availability?site`                                                                                                                                               | Deprecated. Use [Retrieving all availability information for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site) instead.     |
| `[POST] /{tenant}/availability?site`                                                                                                                                              | Deprecated. Use [Retrieving product availabilities](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site) instead.                |
| [Retrieving all locations for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#get-availability-tenant-locations-site)  | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Adding a new location to a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#post-availability-tenant-locations-site)     | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Updating locations](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#put-availability-tenant-locations-site)                   | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Deleting a location](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#delete-availability-tenant-locations-location)           | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Retrieving product locations](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#post-availability-tenant-search-locations)      | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |

## Known problems

There are no known problems.
