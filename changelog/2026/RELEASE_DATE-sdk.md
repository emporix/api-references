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

# RELEASE_DATE: Emporix SDK - Dynamic variants support and recalculation jobs

## Overview

A new version of the Emporix SDK adds support for `DYNAMIC_VARIANT` products and introduces a dedicated client for asynchronous dynamic
variant recalculation jobs.

Dynamic variants form a flexible hierarchy (up to 4 levels). Each variant stores its own distinguishing attributes (`ownVariantAttributes`)
and a root dynamic variant contains a denormalized `variants` map of all descendants. For bulk imports, the variant tree can be rebuilt
asynchronously via the recalculation job endpoints.

## New client

| Client                  | Description                                                                                                                |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------|
| RecalculationJobClient  | Declarative HTTP client for Product Service dynamic variant recalculation jobs. Automatically registered as a Spring bean. |

## New methods

| Method                                                     | Description                                                                |
|------------------------------------------------------------|----------------------------------------------------------------------------|
| RecalculationJobClient.triggerDynamicVariantRecalculation  | Triggers asynchronous recalculation jobs for one or more dynamic variants. |
| RecalculationJobClient.listDynamicVariantRecalculationJobs | Lists recalculation jobs, optionally filtered by status.                   |
| RecalculationJobClient.getDynamicVariantRecalculationJob   | Retrieves a single recalculation job by ID.                                |

## New types

### Dynamic variant recalculation

| Type                                   | Description                                                                         |
|----------------------------------------|-------------------------------------------------------------------------------------|
| DynamicVariantRecalculationRequest     | Request body for triggering recalculation. Contains up to 1000 `productIds`.        |
| DynamicVariantRecalculationResponse    | Response containing `jobs` and `skippedProductIds`.                                 |
| DynamicVariantRecalculationJobResponse | Represents a single recalculation job (id, root, status, timestamps, error).        |
| DynamicVariantRecalculationJobStatus   | Job status enum: `PENDING`, `PROCESSING`, `FINISHED`, `FAILED`, `FAILED_PERMANENT`. |

### Dynamic variant attributes and variant map

| Type                         | Description                                                                                   |
|------------------------------|-----------------------------------------------------------------------------------------------|
| DynamicVariantAttribute      | Attribute entry with localized `name` and typed `value`.                                      |
| DynamicVariantAttributeValue | Typed value containing `type`, `qualifier`, optional `unit`, and localized display `name`.    |
| DynamicVariantAttributeType  | Attribute value type enum (e.g. `STRING`, `BOOLEAN`, `NUMBER`, `DECIMAL`).                    |
| VariantAttributeQualifier    | Qualifier value with custom serializer/deserializer for stable JSON representation.           |
| VariantMapEntry              | Entry stored in a root product’s `variants` map with accumulated attributes for a descendant. |
| DynamicVariantInfo           | Metadata information for dynamic variant trees (e.g. missing ancestor, cycle detection).      |

### Requests for `DYNAMIC_VARIANT` products

| Type                        | Description                                                                      |
|-----------------------------|----------------------------------------------------------------------------------|
| DynamicVariantCreateRequest | Create request for `DYNAMIC_VARIANT` products, including `ownVariantAttributes`. |
| DynamicVariantUpdateRequest | Update request for `DYNAMIC_VARIANT` products, including `ownVariantAttributes`. |

## Updated types

| Type                        | Change summary                                                                                                                                                         |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ProductResponse             | Added `dynamicVariantType`, `parentVariantId`, `parentVariantPath`, `sellable`, `ownVariantAttributes`, `inheritedVariantAttributes`, and root `variants` map support. |
| ProductMetadataResponse     | Added `dynamicVariantInfo` for dynamic-variant tree diagnostics.                                                                                                       |
| GenericProductUpdateRequest | Added dynamic variant fields (`sellable`, `dynamicVariantType`, `parentVariantId`, `ownVariantAttributes`).                                                            |

# Known problems
There are no known problems
