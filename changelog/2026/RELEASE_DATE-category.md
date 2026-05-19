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

# RELEASE_DATE: Category Service - `X-Version` header no longer required

## Overview

The Category Service no longer requires the `X-Version` header to be passed in requests. Existing integrations that still send the `X-Version` header will continue to work without any changes.

## Affected endpoints

All Category Service endpoints are affected. The `X-Version` request header is no longer required and can be safely omitted.

| Endpoint | Description |
|---|---|
| [Category Service API](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference) | The `X-Version` request header is no longer required and is ignored when provided. |

## Known problems

There are no known problems.
