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

# 2026-05-29: Indexing Service - Battery Included provider support

## Overview

The Indexing Service now supports **Battery Included** as a new index provider alongside Algolia. Only one provider can be active per tenant at a time. Battery Included only supports the `MERGE` site-aware fields strategy; tenants configured with the `SPLIT` strategy will have Battery Included indexing silently skipped.

This feature is in a `preview` state and payload sent to battery included is subject to change. 
## Updated endpoints

| Endpoint | Description |
|---|---|
| [Creating a new configuration](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#post-indexing-create-config) | Added `BATTERY_INCLUDED` provider support with new `excludedMixinKeys` field. Only one provider can be active per tenant at a time. |
| [Retrieving all configurations](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-list-configs) | Response may include Battery Included configurations with `excludedMixinKeys`. |
| [Retrieving a configuration by provider name](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-retrieve-config) | `provider` path parameter now accepts `BATTERY_INCLUDED`. |
| [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#put-indexing-update-config) | Supports updating Battery Included configurations with `excludedMixinKeys`. |
| [Retrieving all public configurations](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-list-public-configs) | Response may include Battery Included public configurations. |
| [Retrieving a public configuration by provider name](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-retrieve-public-config) | `provider` path parameter now accepts `BATTERY_INCLUDED`. |

## Known problems

There are no known problems.
