---
icon: sparkles
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

# 2026-04-28: Availability Service - Q-param support, total count header and search improvements

## Overview

The Availability Service has been updated with support for the standard Q-param query parameter on the site-specific endpoint, a Q-param request body option for the search endpoint, and `X-Total-Count` response header on search endpoints.

## Updated endpoints

| Endpoint                                                                                                                                                                                                     | Description                                                                                                                                         |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving all availability information for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site) | The response now includes the `X-Total-Count` header. Added support for the standard `q` query parameter.                                           |
| [Retrieving product availabilities](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)                                        | The response now includes the `X-Total-Count` header. Added support for the standard `q` request body attribute as an alternative filtering method. |

## Known problems

There are no known problems.
