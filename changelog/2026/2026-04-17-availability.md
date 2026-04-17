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

# 2026-04-17: Availability Service - new endpoint, query parameter and total count header

## Overview

The Availability Service has been enhanced with a new endpoint for retrieving availabilities across all sites, support for the standard q-param (`q`) on the site-specific endpoint, and an `X-Total-Count` response header on search endpoints.

## New endpoints

| Endpoint                                                                                                                                                                | Description                                                                                |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| [Retrieving all availability information](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#get-availability-tenant-availability-all) | New endpoint with q-param filtering to retrieve availability information across any sites. |

## Updated endpoints

| Endpoint                                                                                                                                                                                 | Description                                                                                                         |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| [Retrieving all availability information for a site](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#get-availability-tenant-availability-site-site) | The response now includes the `X-Total-Count` header. Added support for the standard q-param (`q`) query parameter. |
| [Retrieving product availabilities for a site](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#post-availability-tenant-availability-search)         | The response now includes the `X-Total-Count` header.                                                               |

## Known problems

There are no known problems.
