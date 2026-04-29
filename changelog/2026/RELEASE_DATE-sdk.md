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

# RELEASE_DATE: Emporix SDK - Multi-tenant support

## Overview

A new `1.2.4` version of the Emporix SDK has been released with multi-tenant support.

The SDK now supports running **multiple Emporix tenants within a single JVM**. This is useful when your application needs to communicate with different Emporix environments (for example, QA, staging, production) or different tenant accounts simultaneously.

When additional tenants are configured, the SDK automatically creates a full bean stack for each tenant — including `EmporixProperties`, `EmporixClientFactory`, `EmporixTokenService`, and all API clients. These beans are injected using Spring's `@Qualifier` annotation with the tenant key as the qualifier value.

## New features

| Feature | Description |
|---|---|
| Multi-tenant configuration | Define additional tenants under `emporix.tenants.<key>` in `application.yml`. Each `<key>` becomes the `@Qualifier` value for injection. |
| Property inheritance | Each tenant inherits shared settings (timeouts, cache) from the default configuration. Only differing properties need to be specified. |
| Custom credentials per tenant | Custom OAuth2 credentials can be defined per tenant, with fallback to the default custom credentials. |
| Startup validation | The SDK validates multi-tenant configuration at startup and fails fast with descriptive error messages if rules are violated. |
| Non-intrusive design | Tenant-specific beans are non-default candidates, so they never interfere with unqualified injection or user-provided `@Primary` overrides. |

## Known problems

There are no known problems.