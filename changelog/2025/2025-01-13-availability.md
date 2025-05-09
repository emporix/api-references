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

# 2025-01-13: Availability Service - availability endpoints replacement

## Overview

The availability endpoints that accept `site` as a query parameter, are now deprecated. They have been replaced with new endpoints that use `site` as a path parameter.

## New endpoints

| Endpoint                                                                                                                           | Description                                                                   |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| [Retrieving a products availability](https://emporix.gitbook.io/documentation-portal/api-references/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)                           | New endpoint that takes `site` as a path parameter is now available.           |
| [Creating a new availability for a product](/openapi/availability/#operation/POST-availability-add-product)                        | New endpoint that takes `site` as a path parameter is now available.           |
| [Upserting availability information of a product](/openapi/availability/#operation/PUT-availability-update-product)                | New endpoint that takes `site` as a path parameter is now available.           |
| [Deleting availability information of a product](/openapi/availability/#operation/DELETE-availability-remove-product)              | New endpoint that takes `site` as a path parameter is now available.          |
| [Retrieving all availability information for a site](/openapi/availability/#operation/GET-availability-retrieve-availability-site) | New endpoint that takes `site` as a path parameter is now available.           |
| [Retrieving product availabilities for a site](/openapi/availability/#operation/POST-availability-search-products-site)            | New endpoint that takes `site` as an optional query parameter is now available.|

## Deprecated endpoints

| Endpoint                                                                                                                           | Description                                                                  |
| ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Retrieving a products availability](https://emporix.gitbook.io/documentation-portal/api-references/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)                           | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Creating a new availability for a product](/openapi/availability/#operation/POST-availability-add-product)                        | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Upserting availability information of a product](/openapi/availability/#operation/PUT-availability-update-product)                | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Deleting availability information of a product](/openapi/availability/#operation/DELETE-availability-remove-product)              | Endpoint that takes `site` as a query parameter is now deprecated.           |
| [Retrieving all availability information for a site](/openapi/availability/#operation/GET-availability-retrieve-availability-site) | Endpoint that takes `site` as a query parameter is now deprecated.           |
| [Retrieving product availabilities for a site](/openapi/availability/#operation/POST-availability-search-products-site)            | Endpoint that takes `site` as a mandatory query parameter is now deprecated.  |


## Known problems

There are no known problems.