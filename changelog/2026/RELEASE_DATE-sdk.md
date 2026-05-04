---
icon: wand-sparkles
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

# RELEASE_DATE: Emporix SDK - Availability Service Q-param support, total count header and search improvements

## Overview

A new `1.2.5` version of the Emporix SDK has been released with the following changes:

* support for the `X-Total-Count` response header on availability search endpoints
* support for the standard `q` query parameter on the site-specific availability endpoint
* support for the `q` request body attribute on the availability search endpoint
* support for the standard `sort` parameter on both availability retrieval and search endpoints

## Updated methods

| Method                                      | Description                                                                                                                                                              |
|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| AvailabilityClient.getAvailabilitiesForSite | The response now includes the `X-Total-Count` header. Added support for the standard `q` query parameter and `sort` parameter.                                           |
| AvailabilityClient.searchAvailability       | The response now includes the `X-Total-Count` header. Added support for the standard `q` request body attribute as an alternative filtering method and `sort` parameter. |

## New types

| Type       | Description                                                                                                                                                                                                   |
|------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SearchDto  | Request body for the availability search endpoint. Accepts either a set of `productIds` for filtering by specific products, or a `q` string for query-based filtering. The two fields are mutually exclusive. |

## Known problems

There are no known problems.

