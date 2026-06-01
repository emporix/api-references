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

# RELEASE_DATE: Pick-pack Service - service deprecation

## Overview

The [Pick-pack Service](https://developer.emporix.io/api-references/api-guides/orders/pick-pack) is now deprecated in its entirety. All endpoints exposed by the service are deprecated and the service is scheduled to be officially removed on **2026-08-24**.

{% hint style="warning" %}
The Pick-pack Service and all of its endpoints are no longer maintained and will be officially removed on **2026-08-24**. Make sure to migrate any integrations that still rely on the service before that date.
{% endhint %}

## Deprecated endpoints

All endpoints under the `/pick-pack/{tenant}` base path are deprecated, including those used to manage pick-pack orders, order cycles, assignees, recalculations, and events. For the full list of affected endpoints, refer to the [Pick-pack Service API Reference](https://developer.emporix.io/api-references/api-guides/orders/pick-pack/api-reference).

## Known problems

There are no known problems.
