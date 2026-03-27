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

# 2026-03-19: Availability Service - new bulk processing endpoints

## Overview

The Availability Service has been enhanced with bulk processing endpoints allowing for creating, upserting and deleting product availabilities in bulk up to 200 elements.

## New endpoints

| Endpoint                                                                                                                                                              | Description                                                              |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| [Creating new product availabilities](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#post-availability-tenant-availability-bulk) | Creates new product availabilities specified by product ID and site.     |
| [Upserting product availabilities](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#put-availability-tenant-availability-bulk)     | Creates/updates product availabilities specified by product ID and site. |
| [Deleting product availabilities](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#delete-availability-tenant-availability-bulk)   | Deletes product availabilities specified by product ID and site.         |

## Known problems

There are no known problems.

