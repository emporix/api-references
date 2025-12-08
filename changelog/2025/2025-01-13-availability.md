---
icon: hourglass-half
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
| [Retrieving a products availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)                           | New endpoint that takes `site` as a path parameter is now available.           |
| [Creating a new availability for a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site)                        | New endpoint that takes `site` as a path parameter is now available.           |
| [Upserting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#put-availability-tenant-availability-productid-site)                | New endpoint that takes `site` as a path parameter is now available.           |
| [Deleting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#delete-availability-tenant-availability-productid-site)              | New endpoint that takes `site` as a path parameter is now available.          |
| [Retrieving all availability information for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site) | New endpoint that takes `site` as a path parameter is now available.           |
| [Retrieving product availabilities for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)            | New endpoint that takes `site` as an optional query parameter is now available.|

## Deprecated endpoints

| Endpoint                                                                                                                           | Description                                                                  |
| ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Retrieving a products availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)                           | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Creating a new availability for a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site)                        | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Upserting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#put-availability-tenant-availability-productid-site)                | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Deleting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#delete-availability-tenant-availability-productid-site)              | Endpoint that takes `site` as a query parameter is now deprecated.           |
| [Retrieving all availability information for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site) | Endpoint that takes `site` as a query parameter is now deprecated.           |
| [Retrieving product availabilities for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)            | Endpoint that takes `site` as a mandatory query parameter is now deprecated.  |


## Known problems

There are no known problems. 
