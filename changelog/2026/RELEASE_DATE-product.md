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

# RELEASE_DATE: Product Service – dynamic variant product type and recalculation

## Overview

A new product type `DYNAMIC_VARIANT` has been introduced, enabling flexible multi-level variant hierarchies of up to 4 levels.

Unlike `PARENT_VARIANT` products, which use a fixed attribute template, `DYNAMIC_VARIANT` products form a tree where each variant stores its own `ownVariantAttributes` - these are the attributes that distinguish it from its parent. The root product maintains a denormalized flat map of all descendants in its `variants` field, with accumulated attributes computed at response time.

Key features of `DYNAMIC_VARIANT` products:

- Variants can be created in any order — a child variant may exist before its parent, simplifying bulk data imports.
- Each variant stores only delta attributes, which are the attributes introduced at its own level. The accumulated, fully merged, attributes are computed by the API at response time by following the `parentVariantId` chain.
- Variant responses expose `ownVariantAttributes` (modifiable, stored in the database) and `inheritedVariantAttributes` (read-only, derived from ancestors at response time).
- Every variant carries a `parentVariantPath` array (ancestor IDs, root-first) enabling efficient tree traversal without database graph lookups.
- A `dynamicVariantType` label (for example: `H1_L1`, `H1_L2`) identifies the variant's level in the hierarchy.
- The `sellable` flag indicates whether a variant can be sold directly.

For single product writes, the variant tree on ancestor products is updated synchronously and inline. For bulk imports, a dedicated asynchronous recalculation mechanism is provided by the new `/recalculate` endpoints.

## New endpoints

| Endpoint | Description |
| --- | --- |
| [Triggering dynamic variant recalculation](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-trigger-dynamic-variant-recalculation) | Accepts up to 1000 product IDs at any hierarchy level and triggers asynchronous recalculation of the variant tree. The system resolves the root for each submitted ID and creates one recalculation job per unique root product. Returns `202 Accepted` with the list of created jobs. If a job for a given root is already `PENDING` or `PROCESSING`, the affected IDs are returned in `skippedProductIds`. Intended to be called after a full batch import, not per individual product write. |
| [Listing recalculation jobs](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-list-recalculation-jobs) | Retrieves all dynamic variant recalculation jobs for the tenant. Supports optional filtering by job `status` (`PENDING`, `PROCESSING`, `FINISHED`, `FAILED`, `FAILED_PERMANENT`). Jobs are retained for approximately 30 days after reaching a terminal state and then automatically removed. |
| [Retrieving a recalculation job](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-get-recalculation-job) | Retrieves the current status and details of a specific recalculation job by its ID. Use this endpoint to poll for job completion. Returns `404` if the job does not exist or has been removed after 30 days. |

## Modified endpoints

| Endpoint | Description |
| --- | --- |
| [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) | Now accepts `DYNAMIC_VARIANT` as a valid `productType`. New fields: `parentVariantId`, `dynamicVariantType`, `sellable`, `ownVariantAttributes`. |
| [Upserting a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid) | Now accepts `DYNAMIC_VARIANT` product creation and update payloads. |
| [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) | Now accepts partial updates for `DYNAMIC_VARIANT` products. |
| [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk) | Now accepts `DYNAMIC_VARIANT` products in bulk creation payloads. |
| [Upserting multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk) | Now accepts `DYNAMIC_VARIANT` products in bulk upsert payloads. |
| [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid) | Response now includes `DYNAMIC_VARIANT`-specific fields: `variants` (root product, accumulated attributes), `ownVariantAttributes`, `inheritedVariantAttributes`, `parentVariantId`, `parentVariantPath`, `dynamicVariantType`, `sellable`, and extended `metadata` with hierarchy integrity information. |

## New schemas

| Schema | Description |
| --- | --- |
| `dynamicVariantProductBase` | Base schema for `DYNAMIC_VARIANT` products. Includes `parentVariantId`, `parentVariantPath`, `dynamicVariantType`, `sellable`, `ownVariantAttributes`, and `inheritedVariantAttributes`. |
| `dynamicVariantProductCreation` | Schema for creating `DYNAMIC_VARIANT` products. |
| `dynamicVariantProductsArray` | Schema for arrays of `DYNAMIC_VARIANT` products (used in bulk endpoints). |
| `dynamicVariantProductUpdate` | Schema for updating `DYNAMIC_VARIANT` products. |
| `dynamicVariantProductBulkUpdate` | Schema for bulk-updating `DYNAMIC_VARIANT` products. |
| `variantAttribute` | Structured variant attribute object with localized `name`, `value.type` (`STRING`, `BOOLEAN`, `NUMBER`, `DECIMAL`), `value.qualifier` (canonical matching value), `value.name` (localized display label), and optional `value.unit` (unit code). |
| `dynamicVariantRecalculationRequest` | Request body for the recalculation endpoint. Contains a `productIds` array (up to 1000 IDs). |
| `dynamicVariantRecalculationResponse` | Response from the recalculation endpoint. Contains a `jobs` array and a `skippedProductIds` array. |
| `dynamicVariantRecalculationJobResponse` | Represents a single recalculation job with `id`, `parentRoot`, `requestedByIds`, `status`, `createdAt`, `processingStartedAt`, `finishedAt`, `error`, and `attempts`. |
| `dynamicVariantRecalculationJobStatus` | Enum of job statuses: `PENDING`, `PROCESSING`, `FINISHED`, `FAILED`, `FAILED_PERMANENT`. |

## Known problems

There are no known problems.
