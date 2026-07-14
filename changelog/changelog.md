---
icon: arrows-rotate-reverse
layout:
  width: default
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
  tags:
    visible: true
  actions:
    visible: true
---

# 2026

{% updates format="full" %}
{% update date="RELEASE_DATE" tags="improvement" %}

## Webhook Events - `restriction` on `order.created` and `order.updated`

#### Overview

The `order.created` and `order.updated` webhook event payloads were extended with `restriction`.

#### Updated events

| Event           | Description                                        |
|-----------------|----------------------------------------------------|
| `order.created` | Event schema extended with `restriction` property. |
| `order.updated` | Event schema extended with `restriction` property. |

#### Known problems

There are no known problems.

#### Links

* [Events - Order](https://developer.emporix.io/api-references-1/readme/webhook-events/events-order)
{% endupdate %}

{% update date="RELEASE_DATE" tags="new-feature" %}

## AI Rag Indexer - support for `ORDER` type in `/filter-metadata` and `/rag-metadata` endpoints

#### Overview

The endpoints `/filter-metadata` and `/rag-metadata` of AI Rag Indexer have been enhanced to support `ORDER` type.

#### Updated endpoints

| Endpoint                                                                                                                                                                                                          | Description               |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|
| [Listing fields for vector search filtering](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-filter-metadata) | Support for `ORDER` type. |
| [Listing fields for RAG search](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-retrieve-rag-metadata)                    | Support for `ORDER` type. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-07-09" tags="new-feature" %}
## Indexing Service - mixin path allowlist for BatteryIncluded

#### Overview

The `IndexConfiguration` object has been extended with a new optional `includedMixinPaths` property for the `BATTERY_INCLUDED` provider. It is a glob-based allowlist of product mixin paths (matched against full dot-notation paths rooted at the mixin key), where `*` matches within a single path segment and `**` matches across one or more segments. When `includedMixinPaths` is non-empty, only matching mixin paths are indexed, and it must not be combined with `excludedMixinKeys`. Malformed glob patterns are rejected with a validation error.

#### Updated endpoints

| Endpoint | Description |
|---|---|
| [Creating a new configuration](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#post-indexing-tenant-configurations) | Property `includedMixinPaths` can be provided for the `BATTERY_INCLUDED` provider. |
| [Getting all configurations](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#get-indexing-tenant-configurations) | Property `includedMixinPaths` is returned. |
| [Getting configuration by provider name](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#get-indexing-tenant-configurations-provider) | Property `includedMixinPaths` is returned. |
| [Updating configuration by provider name](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#put-indexing-tenant-configurations-provider) | Property `includedMixinPaths` can be updated. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-07-08" tags="new-feature" %}

## Schema Service - bulk patching of custom instances

#### Overview

The Schema Service now supports partially updating multiple custom instances in a single request. Each item provides the custom instance `id` and a list of patch operations to apply. The maximum batch size is 200, and each item returns its own result status.

#### New endpoints

| Endpoint                                                                                                                                                                                     | Description                                                                                              |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [Patching custom instances in bulk](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#patch-schema-tenant-custom-entities-type-instances-bulk) | Partially updates up to 200 custom instances in one request by applying patch operations to each item. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-07-07" tags="new-feature" %}
## Quote Service - customerReference and customerComment properties

#### Overview

The `Quote` object has been extended with two new properties that allow customers to provide additional information on their quotes:

- `customerReference` - A customer-provided reference stored on the quote (e.g., a purchase order number like "PO-12345")
- `customerComment` - A customer-provided comment stored on the quote (e.g., "Please deliver before Friday")

These properties can be set when creating a quote, creating a quote from a cart, or when updating a quote.

#### Updated endpoints

| Endpoint                                                                                                                                                            | Description                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| [Creating a quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#post-quote-tenant-quotes)                     | Properties `customerReference` and `customerComment` can be provided.                                         |
| [Creating a quote from a cart](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#post-quote-tenant-quotes-from-cart) | Properties `customerReference` and `customerComment` can be provided.                                         |
| [Retrieving quotes](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes)                     | Properties `customerReference` and `customerComment` are returned.                                            |
| [Retrieving a single quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid)     | Properties `customerReference` and `customerComment` are returned.                                            |
| [Partially updating a quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#patch-quote-tenant-quotes-quoteid)  | Properties `customerReference` and `customerComment` can be updated. Customers can update these on own quotes. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-07-06" tags="new-feature" %}
## AI Service - streaming chat responses

#### Overview

AI Service now supports streaming LLM responses for endpoint-triggered agents through a new Server-Sent Events endpoint. This lets clients receive incremental output over `text/event-stream`.

#### New endpoints

| Endpoint                                                                                                                                                                                      | Description                                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| [Starting agent chat stream](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agentic-chat#post-ai-service-tenant-agentic-chat-stream) | Adds `POST /ai-service/{tenant}/agentic/chat-stream` for streaming chat responses over `text/event-stream`. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-07-01" tags="improvement" %}
## Schema and IAM Services - digits now supported in custom entity and scope IDs

#### Overview

Custom entity IDs in the Schema Service and scope IDs in the IAM Service now accept digits alongside letters and other allowed characters, giving more flexibility when naming custom types and scopes.

#### Updated endpoints

| Endpoint                                                                                                                                                                        | Description                                      |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| [Creating a custom schema type](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-schema-type#post-schema-tenant-custom-entities)    | The `id` field now accepts digits.               |
| [Upserting a custom schema type](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-schema-type#put-schema-tenant-custom-entities-id) | The `id` field now accepts digits.               |
| [Upserting a custom scope](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/scopes#put-iam-tenant-scopes-scopeid)                 | The `scopeId` path parameter now accepts digits. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-30" tags="improvement" %}
## AI Service - introduction of 'outputFormat' field

#### Overview

The AI Service API now accepts a JSON Schema (as a JSON string) in the `outputFormat` field to constrain the structure of the agent response. This enables clients to request predictable, machine-readable output for easier integration with downstream workflows.

#### Updated endpoints

| Endpoint                                                                                                                                                                                            | Description                                     |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| [Retrieving agent by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#get-ai-service-tenant-agentic-agents-agentid)                | Response now includes the `outputFormat` field. |
| [Listing agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#get-ai-service-tenant-agentic-agents)                                | Response now includes the `outputFormat` field. |
| [Searching agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#post-ai-service-tenant-agentic-agents-search)                      | Response now includes the `outputFormat` field. |
| [Upserting an agent](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#put-ai-service-tenant-agentic-agents-agentid)                    | Request now includes the `outputFormat` field.  |
| [Partially updating an agent](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#patch-ai-service-tenant-agentic-agents-agentid)         | Request now includes the `outputFormat` field.  |
| [Listing available agent templates](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template#get-ai-service-tenant-agentic-templates) | Response now includes the `outputFormat` field. |
| [Searching agent templates](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-template#post-ai-service-tenant-agentic-templates-search) | Response now includes the `outputFormat` field. |
{% endupdate %}

{% update date="2026-06-30" tags="improvement" %}
## Country Service - X-Version header no longer required

#### Overview

The `X-Version` header is no longer required for Country Service endpoints.

#### Updated endpoints

| Endpoint                                                                                                                                                                      | Description                                   |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| [Retrieving all countries](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#get-country-tenant-countries)         | The `X-Version` header is no longer required. |
| [Retrieving a country](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#get-country-tenant-countries-countrycode) | The `X-Version` header is no longer required. |
| [Updating a country](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#patch-country-tenant-countries-countrycode) | The `X-Version` header is no longer required. |
| [Get all regions](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/regions#get-country-tenant-regions)                      | The `X-Version` header is no longer required. |
| [Retrieving a region](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/regions#get-country-tenant-regions-regioncode)       | The `X-Version` header is no longer required. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-23" tags="improvement" %}
## Media, Schema, and Product Services - mixin support for media assets

#### Overview

Media assets now support mixins, consistent with other Emporix entities. The Schema Service supports a new `MEDIA` schema type for defining mixin schemas, but custom attribute values must still be provided in the asset payload through `mixins` and `metadata.mixins` when creating or updating assets through the Media Service. Category and Product Service endpoints do not accept `media` in requests; when media is created and linked to a category or product, the `media` items in responses include the corresponding mixin values.

#### Updated endpoints

| Endpoint                                                                                                                                                                                                 | Description                                       |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------- |
| [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets)                                                                    | Request accepts `mixins` and `metadata.mixins`.   |
| [Updating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#put-media-tenant-assets-assetid)                                                             | Request accepts `mixins` and `metadata.mixins`.   |
| [Retrieving all assets](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets)                                                                 | Response includes `mixins` and `metadata.mixins`. |
| [Retrieving an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets-assetid)                                                           | Response includes `mixins` and `metadata.mixins`. |
| [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas)                                                             | `MEDIA` added to supported schema types.          |
| [Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id)                                                           | `MEDIA` added to supported schema types.          |
| [Retrieving a list of categories](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories)          | Response `media` items include a `mixins` field.  |
| [Retrieving a category details](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories-categoryid) | Response `media` items include a `mixins` field.  |
| [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid)                   | Response `media` items include a `mixins` field.  |
| [Retrieving all products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products)                          | Response `media` items include a `mixins` field.  |
| [Searching for products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-search)                   | Response `media` items include a `mixins` field.  |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-18" tags="deprecated" %}
## AI Rag Indexer Service - deprecated endpoint

#### Overview

The AI Rag Indexer Service endpoint for reindexing has been marked as deprecated and will be removed on **2026-12-01**. Instead, use the [Creating reindex job](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#post-indexing-tenant-reindex-jobs) endpoint.

#### Deprecated endpoints

| Endpoint                                                                                                                                                                                             | Description                                                                                                                                                                                     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Reindexing the entities of given type](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/reindex#post-ai-rag-indexer-tenant-type-reindex) | Use the [Creating reindex job](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#post-indexing-tenant-reindex-jobs) endpoint instead. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-18" tags="deprecated" %}
## Indexing Service - deprecated endpoint

#### Overview

The Indexing Service endpoint for reindexing has been marked as deprecated and will be removed on **2026-12-01**. Use the [Creating reindex job](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#post-indexing-tenant-reindex-jobs) endpoint instead.

#### Deprecated endpoints

| Endpoint                                                                                                                                               | Description                                                                                                                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Reindexing](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#post-indexing-tenant-reindex) | Use the [Creating reindex job](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#post-indexing-tenant-reindex-jobs) endpoint instead. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-18" tags="new-feature,improvement" %}
## Indexing Service - Reindex Jobs

#### Overview

The Indexing Service was extended with new endpoints for creating and fetching reindex jobs. For now, reindexing supports `PRODUCT` and custom schema entity types.

#### New endpoints

| Endpoint                                                                                                                                                                          | Description                         |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| [Creating reindex job](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#post-indexing-tenant-reindex-jobs)             | Endpoint for creating reindex job.  |
| [Fetching reindex jobs](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#get-indexing-tenant-reindex-jobs)             | Endpoint for fetching reindex jobs. |
| [Fetching reindex job](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/reindex#get-indexing-tenant-reindex-jobs-reindexjobid) | Endpoint for fetching reindex job.  |
{% endupdate %}

{% update date="2026-06-10" tags="improvement" %}
## AI Service - commerce event trigger filter support and job status update

#### Overview

The AI Service API now supports payload-level filtering for `commerce_events` agent triggers. You can define filter expressions so an agent is triggered only when an incoming commerce event payload matches the configured criteria. Additionally, jobs now support the `skipped` status value.

#### Updated types

| Type         | Description                                                              |
| ------------ | ------------------------------------------------------------------------ |
| AgentTrigger | Added optional `filter` field for the `commerce_events` trigger variant. |
| JobStatus    | Added `skipped` enum value.                                              |

#### Updated endpoints

| Endpoint                                                                                                                                                                                 | Description                                                                   |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| [Retrieving agent by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#get-ai-service-tenant-agentic-agents-agentid)     | Response can now include `trigger.filter` for `commerce_events` triggers.     |
| [Listing Agents](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#get-ai-service-tenant-agentic-agents)                     | Response can now include `trigger.filter` for `commerce_events` triggers.     |
| [Upserting agent](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#put-ai-service-tenant-agentic-agents-agentid)            | Request payload now supports `trigger.filter` for `commerce_events` triggers. |
| [Partially updating agent](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent#patch-ai-service-tenant-agentic-agents-agentid) | Request payload now supports `trigger.filter` for `commerce_events` triggers. |
| [Listing available jobs](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/job#get-ai-service-tenant-jobs)                         | Job responses can now return `status: skipped`.                               |
| [Searching jobs](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/job#post-ai-service-tenant-jobs-search)                         | Job responses can now return `status: skipped`.                               |
| [Retrieving available job](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/job#get-ai-service-tenant-jobs-jobid)                 | Job response can now return `status: skipped`.                                |
{% endupdate %}

{% update date="2026-06-10" tags="improvement" %}
## Category Service - `X-Version` header no longer required

#### Overview

The Category Service no longer requires the `X-Version` header to be passed in requests. Existing integrations that still send the `X-Version` header will continue to work without any changes.

#### Affected endpoints

All Category Service endpoints are affected. The `X-Version` request header is no longer required and can be safely omitted.

| Endpoint                                                                                                                           | Description                                                                        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| [Category Service API](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference) | The `X-Version` request header is no longer required and is ignored when provided. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-09" tags="improvement" %}
## Webhook Events - `cartId` and `quoteId` on `order.created` and `order.updated`

#### Overview

The `order.created` and `order.updated` webhook event payloads were extended with `cartId` and `quoteId`. These fields link an order to its source cart or quote and are populated when the order was created from checkout.

* `cartId` — identifier of the cart used to create the order (cart checkout).
* `quoteId` — identifier of the quote from which the order was created (quote checkout).

Either field may be omitted when it does not apply to the order.

#### Updated events

| Event           | Description                                                            |
| --------------- | ---------------------------------------------------------------------- |
| `order.created` | Event schema extended with optional `cartId` and `quoteId` properties. |
| `order.updated` | Event schema extended with optional `cartId` and `quoteId` properties. |

#### Known problems

There are no known problems.

#### Links

* [Events - Order](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/api-guides/webhooks/webhook-events/events-order)
{% endupdate %}

{% update date="2026-06-09" tags="major-change" %}
## Approval Service - legal entity scoping and approval response fields

#### Overview

The Approval Service now scopes approvals to the B2B legal entity from the customer token. Previously, customers could see approvals created for other companies because the `Legal-Entity-Id` has not been stored on the `Approval` model.

New and updated approvals store `legalEntity` on the document and are filtered by `legalEntity.id`. GET responses also expose `createdResource` when a downstream resource (for checkout, typically an order) exists after the approval flow completes.

#### Behavior change (not backward compatible)

When the `Legal-Entity-Id` request header is sent (injected for B2B customer tokens — see [B2B token and legal entity](https://developer.emporix.io/api-references/api-guides/quickstart/authentication-and-authorization/tokens-and-scopes#b2b-token)), the service:

* **Creates** approvals for that legal entity only (requestor and approver contact assignments are resolved for the given entity).
* **Returns** only approvals whose stored `legalEntity.id` matches the `legal-entity-id` from token.

**Existing approvals created before this release do not have `legalEntity` stored.** They are **not** returned when `Legal-Entity-Id` is present in token, because they cannot match the legal-entity filter. This is intentional and **not backward compatible**: tenants will not see historical approvals through the scoped B2B API.

#### Updated endpoints

| Endpoint                                                                                                                                                                                                  | Description                                                                                                 |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| [Creating an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#post-approval-tenant-approvals)                   | Respects `Legal-Entity-Id`; persists `legalEntity` on the approval.                                         |
| [Retrieving a list of approvals](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#get-approval-tenant-approvals)          | Filtered by `Legal-Entity-Id` when present; response includes `legalEntity` and optional `createdResource`. |
| [Retrieving an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#get-approval-tenant-approvals-approvalid)       | Filtered by `Legal-Entity-Id` when present; response includes `legalEntity` and optional `createdResource`. |
| [Updating an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#patch-approval-tenant-approvals-approvalid)       | Filtered by `Legal-Entity-Id` when present.                                                                 |
| [Deleting an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#delete-approval-tenant-approvals-approvalid)      | Filtered by `Legal-Entity-Id` when present.                                                                 |
| [Checking the resource approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approval#post-approval-tenant-approval-permitted) | Respects `Legal-Entity-Id` when checking existing approvals.                                                |
| [Searching for approver users](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/search#post-approval-tenant-search-users)           | Respects `Legal-Entity-Id` for contact assignment and approver resolution.                                  |

#### Schema updates

The `getApprovalResponse` schema was extended with:

* `legalEntity` — object with `id` (legal entity identifier); set when the approval is created
* `createdResource` — object with `id` (identifier of the created resource; for checkout, typically an order ID); omitted until the approved action produces a linked resource

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-08" tags="new-feature,improvement" %}
## Emporix SDK - Batch cart item update and removal of X-Version header from category clients

#### Overview

A new version `1.3.1` of the Emporix SDK has been released with the following changes:

* support for batch updating cart items via `PUT /cart/{tenant}/carts/{cartId}/itemsBatch`
* removal of the `X-Version` header from Category Service clients (`CategoryClient`, `CategoryAssignmentClient`, `CategoryTreeClient`)

#### New methods

| Method                                      | Description                                                                                                                                                  |
| ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `CartItemsClient.updateMultipleItemsToCart` | Updates multiple cart items in a single batch operation (maximum 50 items). Returns HTTP 207 (Multi-Status) with per-item outcomes aligned to request order. |

#### New types

| Type                                | Description                                                                                  |
| ----------------------------------- | -------------------------------------------------------------------------------------------- |
| `UpdateCartItemsBatchRequest`       | Batch cart item update request. Each entry must include a cart item `id`.                    |
| `UpdateCartItemsBatchEntryResponse` | Per-item outcome for a batch update (`index`, `id`, `code`, `status`, `message`, `details`). |

#### Updated types

| Type                | Description                                                                |
| ------------------- | -------------------------------------------------------------------------- |
| `BatchItemResponse` | Added `index` field matching the position of the item in the request body. |

#### Updated clients

| Client                     | Description                                         |
| -------------------------- | --------------------------------------------------- |
| `CategoryClient`           | No longer sends the `X-Version` header on requests. |
| `CategoryAssignmentClient` | No longer sends the `X-Version` header on requests. |
| `CategoryTreeClient`       | No longer sends the `X-Version` header on requests. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-06-02" tags="new-feature" %}
## AI Service - Support for file upload

#### Overview

The AI Service has been enhanced with a new endpoint that allows you to upload a file and attach it to the agent. Then, when calling chat endpoints it is possible to reference this file.

#### New endpoints

| Endpoint                                                                                                                                                                                      | Description                  |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------- |
| [Uploading attachment](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-agentId-attachments) | Attaches a file to the agent |

#### Updated endpoints

| Endpoint                                                                                                                                                                                  | Description                                     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| [Starting agent chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat)             | Request body extended with `attachments` field. |
| [Starting agent async chat](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/agent-chat#post-ai-service-tenant-agentic-chat-async) | Request body extended with `attachments` field. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-29" tags="new-feature" %}
## AI Service - LLM models from supported providers

#### Overview

The AI Service has been enhanced with a new endpoint that lists available LLM models from supported LLM providers: OpenAI, Anthropic, and Google.

The service retrieves models directly from each provider's models API.

Each model entry includes an identifier, display name, optional description, and a `thinking` flag indicating whether the model supports thinking capabilities.

#### New endpoints

| Endpoint                                                                                                                                                                        | Description                                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [Listing LLM models from supported providers](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/model#GET-ai-list-models) | Returns models grouped by provider (`openai`, `anthropic`, `google`). Requires `ai.agent_read`. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-29" tags="new-feature" %}
## Indexing Service - Battery Included provider support

#### Overview

The Indexing Service now supports **Battery Included** as a new index provider alongside Algolia. Only one provider can be active per tenant at a time. Battery Included only supports the `MERGE` site-aware fields strategy; tenants configured with the `SPLIT` strategy will have Battery Included indexing silently skipped.

This feature is in a `preview` state and payload sent to battery included is subject to change.

#### Updated endpoints

| Endpoint                                                                                                                                                                                      | Description                                                                                                                         |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| [Creating a new configuration](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#post-indexing-create-config)                               | Added `BATTERY_INCLUDED` provider support with new `excludedMixinKeys` field. Only one provider can be active per tenant at a time. |
| [Retrieving all configurations](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-list-configs)                                | Response may include Battery Included configurations with `excludedMixinKeys`.                                                      |
| [Retrieving a configuration by provider name](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-retrieve-config)               | `provider` path parameter now accepts `BATTERY_INCLUDED`.                                                                           |
| [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#put-indexing-update-config)                                    | Supports updating Battery Included configurations with `excludedMixinKeys`.                                                         |
| [Retrieving all public configurations](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-list-public-configs)                  | Response may include Battery Included public configurations.                                                                        |
| [Retrieving a public configuration by provider name](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference#get-indexing-retrieve-public-config) | `provider` path parameter now accepts `BATTERY_INCLUDED`.                                                                           |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-28" tags="deprecated" %}
## Availability Service - deprecated endpoints

#### Overview

The Availability Service endpoints for managing availabilities that accept `site` as a query parameter, which were [marked as deprecated on 2025-01-13](https://developer.emporix.io/changelog/archive/changelog-2025/2025-01-13-availability), will be removed on **2026-09-01**. They have been replaced with new endpoints that accept `site` as a path parameter.\
The Availability Service endpoints for managing locations have been marked as deprecated and will be removed on **2026-09-01** due to the planned sunset of the related functionalities.

#### Deprecated endpoints

**Availability endpoints accepting `site` as query parameter**

| Endpoint                                                                                                                                                                         | Description                                                                                                                                                                                                                               |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `[GET] /{tenant}/availability/{productId}?site`                                                                                                                                  | Deprecated. Use [Retrieving a product availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-productid-site) instead.                 |
| `[POST] /{tenant}/availability/{productId}?site`                                                                                                                                 | Deprecated. Use [Creating a new availability for a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site) instead.        |
| `[PUT] /{tenant}/availability/{productId}?site`                                                                                                                                  | Deprecated. Use [Upserting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#put-availability-tenant-availability-productid-site) instead.   |
| `[DELETE] /{tenant}/availability/{productId}?site`                                                                                                                               | Deprecated. Use [Deleting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#delete-availability-tenant-availability-productid-site) instead. |
| `[GET] /{tenant}/availability?site`                                                                                                                                              | Deprecated. Use [Retrieving all availability information for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site) instead.     |
| `[POST] /{tenant}/availability?site`                                                                                                                                             | Deprecated. Use [Retrieving product availabilities](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site) instead.                |
| [Retrieving all locations for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#get-availability-tenant-locations-site) | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Adding a new location to a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#post-availability-tenant-locations-site)    | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Updating locations](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#put-availability-tenant-locations-site)                  | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Deleting a location](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#delete-availability-tenant-locations-location)          | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |
| [Retrieving product locations](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/locations#post-availability-tenant-search-locations)     | Deprecated due to planned sunset of related functionalities.                                                                                                                                                                              |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-28" tags="deprecated" %}
## Supplier Service - deprecation

#### Overview

The Supplier Service has been deprecated and will be removed on **2026-09-01**.

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-27" tags="improvement" %}
## Schema Service — explicit `owner` on custom instance creation

#### Overview

The Schema Service now accepts an optional `owner` field in the request body when creating a custom instance, so clients can assign ownership explicitly instead of relying on the platform to derive it from the calling principal.

The `owner` field can be set explicitly only by clients authorized with a `manage` scope (`schema.custominstance_manage` or `custom.{lowerCaseType}_manage`). When the request is authorized with a `manage_own` scope, the field is ignored and ownership is set automatically to the user who created the custom instance. When a `manage` scope is granted but the field is omitted, ownership is likewise set automatically to the user who created the custom instance.

The following limitations apply when providing `owner`:

* `type` can only be set to `CUSTOMER` or `EMPLOYEE`. The `SERVICE` type cannot be assigned explicitly.
* `legalEntityId` can be provided only when `type` is `CUSTOMER`.
* The `owner` field is immutable. It can only be set during creation.

#### Updated endpoints

| Endpoint                                                                                                                                                                                 | Description                                             |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [Creating a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances)    | The request body now accepts an optional `owner`.       |
| [Upserting a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#put-schema-tenant-custom-entities-type-instances-id) | The request body now accepts an optional `owner` field. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-27" tags="new-feature" %}
## AI Service - RAG\_EMPORIX support for custom entity types

#### Overview

The tool of `RAG_EMPORIX` type allow specifying the custom entity type by using `entityType` field.

#### Updated endpoints

| Endpoint                                                                                                                                                     | Description                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------- |
| [Listing tools](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#GET-ai-list-tools)              | Field `entityType` of `RAG_EMPORIX` tool type supports custom entity types. |
| [Searching tools](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#POST-ai-search-tools)         | Field `entityType` of `RAG_EMPORIX` tool type supports custom entity types. |
| [Retrieving tool by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#GET-ai-retrieve-tool)   | Field `entityType` of `RAG_EMPORIX` tool type supports custom entity types. |
| [Upserting tool](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#PUT-ai-upsert-tool)            | Field `entityType` of `RAG_EMPORIX` tool type supports custom entity types. |
| [Partially updating tool](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#PATCH-ai-update-tool) | Field `entityType` of `RAG_EMPORIX` tool type supports custom entity types. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-27" tags="improvement" %}
## Webhook Events - updated `schema.custom-instance-updated` and `schema.custom-instance-created` events schema

#### Overview

The `schema.custom-instance-updated` and `schema.custom-instance-created` webhook events documentation has been updated to reflect the current payload structure.

#### Updated event

| Event                            | Description                                                    |
| -------------------------------- | -------------------------------------------------------------- |
| `schema.custom-instance-updated` | Updated event schema by including nested media and owner data. |
| `schema.custom-instance-created` | Updated event schema by including nested media and owner data. |

#### Known problems

There are no known problems.

#### Links

* [Events - Custom Instance](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/api-guides/webhooks/webhook-events/events-index)
{% endupdate %}

{% update date="2026-05-26" tags="improvement" %}
## Approval Service - quote approval process

#### Overview

The Approval Service supports quote checkout approvals alongside cart approvals. For `resourceType: QUOTE`, the client sends the quote ID in `resourceId` and does not send `details`. The service loads quote line and price data from the quote integration. For `resourceType: CART`, `details` remains required as before.

#### Updated endpoints

| Endpoint                                                                                                                                                       | Description                                                           |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| [Creating an approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#post-approval-tenant-approvals)                   | Supports `resourceType: QUOTE` with quote `resourceId`.               |
| [Retrieving a list of approvals](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals)          | Response resource payloads align with updated item and price schemas. |
| [Retrieving an approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals-approvalid)       | Response resource payloads align with updated item and price schemas. |
| [Checking the resource approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approval#post-approval-tenant-approval-permitted) | Request may use `resourceType: QUOTE` and a quote `resourceId`.       |
| [Searching for approver users](https://developer.emporix.io/api-references-1/readme/approval-api-reference/search#post-approval-tenant-search-users)           | Request may use `resourceType: QUOTE` and a quote `resourceId`.       |

#### Schema updates

The Approval Service API reference schemas were extended with:

* `resourceType` value `QUOTE`
* `resourceItem`: `itemId`; `itemPrice` as line-level price (`unitPrice`, `newUnitPrice`, `calculatedPrice`)
* `price` (totals): `netValue`, `grossValue`, `taxValue`

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-26" tags="deprecated" %}
## Approval Service - deprecated fields

#### Overview

All deprecations will be removed on 2026-11-30. Several fields in the approval response have been deprecated in favor of new, more descriptive fields. The new fields provide a more comprehensive and consistent way to access price calculations.

**Deprecated approval resource level fields:**

* `totalPrice.amount` - use `totalPrice.netValue`, `totalPrice.grossValue` and `totalPrice.taxValue` instead
* `subTotalPrice.amount` - use `subTotalPrice.netValue`, `subTotalPrice.grossValue` and `subTotalPrice.taxValue` instead

**Deprecated approval resource-item level fields:**

* `itemYrn` - use `itemId` instead
* `itemPrice.amount` - use `calculatedPrice` and `unitPrice` instead

#### Updated endpoints

| Endpoint                                                                                                                                                 | Description                                                                            |
| -------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| [Retrieving a list of approvals](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals)    | Deprecated response fields in favor of new more comprehensive way to represent prices. |
| [Retrieving an approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals-approvalid) | Deprecated response fields in favor of new more comprehensive way to represent prices. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-25" tags="new-feature" %}
## AI Rag Indexer - support for custom entity types in `/filter-metadata` and `/rag-metadata` endpoints

#### Overview

The endpoints `/filter-metadata` and `/rag-metadata` of AI Rag Indexer have been enhanced to support custom entity types.

#### Updated endpoints

| Endpoint                                                                                                                                                                                                          | Description                      |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------- |
| [Listing fields for vector search filtering](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-filter-metadata) | Support for custom entity types. |
| [Listing fields for RAG search](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-retrieve-rag-metadata)                    | Support for custom entity types. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-25" tags="deprecated" %}
## AI Rag Indexer - `name` and `description` fields from `/filter-metadata` endpoint deprecated

#### Overview

The fields `name` and `description` from the response of `/filter-metadata` endpoint of AI Rag Indexer have been deprecated. These fields were previously used to provide additional information about the filters, but they are no longer necessary for the functionality of the service. They will be removed on **2026-12-01**.

#### Affected endpoint

| Endpoint                                                                                                                                                                                                          | Description                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| [Listing fields for vector search filtering](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-rag-indexer/api-reference/metadata#GET-ai-rag-indexer-tenant-type-filter-metadata) | Fields `name` and `description` from the response are marked as deprecated. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-25" tags="new-feature" %}
## AI Service - RAG\_EMPORIX filter fields

#### Overview

The tool of `RAG_EMPORIX` type has been enhanced with a `filterFields` field, which allows specifying which fields are available for filtering in the vector index.

#### Updated endpoints

| Endpoint                                                                                                                                                     | Description                                      |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------ |
| [Listing tools](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#GET-ai-list-tools)              | Response enhanced with `filterFields` field.     |
| [Searching tools](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#POST-ai-search-tools)         | Response enhanced with `filterFields` field.     |
| [Retrieving tool by ID](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#GET-ai-retrieve-tool)   | Response enhanced with `filterFields` field.     |
| [Upserting tool](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#PUT-ai-upsert-tool)            | Request body enhanced with `filterFields` field. |
| [Partially updating tool](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/tool#PATCH-ai-update-tool) | Request body enhanced with `filterFields` field. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-25" tags="deprecated" %}
## SEPA Export Service - deprecation

#### Overview

The SEPA Export Service has been deprecated and will be removed on 2026-08-24.

#### Known problems

There are no known problems.

#### Overview

The SEPA Export Service is now deprecated in its entirety. All endpoints exposed by the service are deprecated and the service is scheduled to be officially removed on **2026-08-24**.

{% hint style="warning" %}
The SEPA Export Service and all of its endpoints are no longer maintained and will be officially removed on **2026-08-24**. Make sure to migrate any integrations that still rely on the service before that date.
{% endhint %}

#### Deprecated endpoints

All endpoints under the `/sepa-export/{tenant}/` base path are deprecated. For the full list of affected endpoints, refer to the [SEPA Export Service API Reference](https://developer.emporix.io/api-references/api-guides/orders/sepa-export/api-reference).

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-25" tags="deprecated" %}
## Pick-pack Service - service deprecation

#### Overview

The [Pick-pack Service](https://developer.emporix.io/api-references/api-guides/orders/pick-pack) is now deprecated in its entirety. All endpoints exposed by the service are deprecated and the service is scheduled to be officially removed on **2026-08-24**.

{% hint style="warning" %}
The Pick-pack Service and all of its endpoints are no longer maintained and will be officially removed on **2026-08-24**. Make sure to migrate any integrations that still rely on the service before that date.
{% endhint %}

#### Deprecated endpoints

All endpoints under the `/pick-pack/{tenant}` base path are deprecated, including those used to manage pick-pack orders, order cycles, assignees, recalculations, and events. For the full list of affected endpoints, refer to the [Pick-pack Service API Reference](https://developer.emporix.io/api-references/api-guides/orders/pick-pack/api-reference).

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-18" tags="new-feature" %}
## Price Service - siteCodes support in price search

#### Overview

The Price Service search endpoint now supports a new `siteCodes` field, which allows searching for prices across multiple site codes in a single request. If the existing `siteCode` field is specified, `siteCodes` is ignored.

#### Updated endpoints

| Endpoint                                                                                                                                                           | Description                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| [Searching for prices](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#post-price-tenant-prices-search) | New attribute `siteCodes` added to request payload. Accepts an array of site codes for which the prices should be retrieved. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-13" tags="new-feature" %}
## Emporix SDK - Dynamic variants support and recalculation jobs

#### Overview

A new version `1.3.0` of the Emporix SDK adds support for `DYNAMIC_VARIANT` products and introduces a dedicated client for asynchronous dynamic variant recalculation jobs.

Dynamic variants form a flexible hierarchy (up to 4 levels). Each variant stores its own distinguishing attributes (`ownVariantAttributes`) and a root dynamic variant contains a denormalized `variants` map of all descendants. For bulk imports, the variant tree can be rebuilt asynchronously using the recalculation job endpoints.

#### New client

| Client                 | Description                                                                                                                |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| RecalculationJobClient | Declarative HTTP client for Product Service dynamic variant recalculation jobs. Automatically registered as a Spring bean. |

#### New methods

| Method                                                     | Description                                                                |
| ---------------------------------------------------------- | -------------------------------------------------------------------------- |
| RecalculationJobClient.triggerDynamicVariantRecalculation  | Triggers asynchronous recalculation jobs for one or more dynamic variants. |
| RecalculationJobClient.listDynamicVariantRecalculationJobs | Lists recalculation jobs, optionally filtered by status.                   |
| RecalculationJobClient.getDynamicVariantRecalculationJob   | Retrieves a single recalculation job by ID.                                |

#### New types

**Dynamic variant recalculation**

| Type                                   | Description                                                                         |
| -------------------------------------- | ----------------------------------------------------------------------------------- |
| DynamicVariantRecalculationRequest     | Request body for triggering recalculation. Contains up to 1000 `productIds`.        |
| DynamicVariantRecalculationResponse    | Response containing `jobs` and `skippedProductIds`.                                 |
| DynamicVariantRecalculationJobResponse | Represents a single recalculation job (id, root, status, timestamps, error).        |
| DynamicVariantRecalculationJobStatus   | Job status enum: `PENDING`, `PROCESSING`, `FINISHED`, `FAILED`, `FAILED_PERMANENT`. |

**Dynamic variant attributes and variant map**

| Type                         | Description                                                                                      |
| ---------------------------- | ------------------------------------------------------------------------------------------------ |
| DynamicVariantAttribute      | Attribute entry with localized `name` and typed `value`.                                         |
| DynamicVariantAttributeValue | Typed value containing `type`, `qualifier`, optional `unit`, and localized display `name`.       |
| DynamicVariantAttributeType  | Attribute value type enum (e.g. `STRING`, `BOOLEAN`, `NUMBER`, `DECIMAL`).                       |
| VariantAttributeQualifier    | Qualifier value with custom serializer/deserializer for stable JSON representation.              |
| VariantMapEntry              | Entry stored in a root product’s `variants` map with accumulated attributes for a descendant.    |
| DynamicVariantInfo           | Metadata information for dynamic variant trees (for example, missing ancestor, cycle detection). |

**Requests for `DYNAMIC_VARIANT` products**

| Type                        | Description                                                                      |
| --------------------------- | -------------------------------------------------------------------------------- |
| DynamicVariantCreateRequest | Create request for `DYNAMIC_VARIANT` products, including `ownVariantAttributes`. |
| DynamicVariantUpdateRequest | Update request for `DYNAMIC_VARIANT` products, including `ownVariantAttributes`. |

**Product presentation - brand & labels**

| Type  | Description                                                                             |
| ----- | --------------------------------------------------------------------------------------- |
| Brand | Brand representation embedded in `ProductResponse` (resolved when expanded by the API). |
| Label | Label representation embedded in `ProductResponse` (resolved when expanded by the API). |

#### Updated types

| Type                        | Change summary                                                                                                                                                                                                                                          |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ProductResponse             | Added dynamic variant support (`dynamicVariantType`, `parentVariantId`, `parentVariantPath`, `sellable`, `ownVariantAttributes`, `inheritedVariantAttributes`, root `variants` map) and presentation fields (`labelIds`, `labels`, `brandId`, `brand`). |
| ProductMetadataResponse     | Added `dynamicVariantInfo` for dynamic-variant tree diagnostics.                                                                                                                                                                                        |
| GenericProductCreateRequest | Added dynamic variant fields (`productType`, `parentVariantId`, `dynamicVariantType`, `sellable`, `ownVariantAttributes`).                                                                                                                              |
| GenericProductUpdateRequest | Added dynamic variant fields (`sellable`, `dynamicVariantType`, `parentVariantId`, `ownVariantAttributes`).                                                                                                                                             |
| ProductPartialUpdateRequest | Added dynamic variant fields (`dynamicVariantType`, `sellable`, `ownVariantAttributes`) and additional partial-update fields (`labelIds`, `brandId`).                                                                                                   |

#### Known problems

**Constructor signature changes (compile-time breaking for some usages)**

The all-args constructors generated by Lombok changed due to newly added fields in:

* `ProductResponse`
* `GenericProductCreateRequest`
* `GenericProductUpdateRequest`
* `ProductPartialUpdateRequest`

If your code instantiates these classes using constructors, you may hit compilation errors after upgrading.

**Recommended fix**: use the Lombok builder (`.builder()...build()`) instead of constructors.

Class `GenericProductUpdateRequest` is now using `MetadataRequest` instead of `VariantProductMetadataRequest` for the `metadata` field.

The following classes were updated to contain `productType` field that is necessary for upserting and creating products:

* `BundledProductCreateRequest`
* `DynamicVariantCreateRequest`
* `ParentVariantCreateRequest`
* `ProductVariantCreateRequest`
* `BundledProductUpdateRequest`
* `ParentVariantUpdateRequest`
* `ProductVariantUpdateRequest`
{% endupdate %}

{% update date="2026-05-13" tags="improvement" %}
## IAM Service - access control restrictions, predefined scopes, and deprecations

#### Overview

The IAM Service has been extended in three main areas, and the legacy roles/permissions/resources object model is being phased out.

**Access control assignment restrictions**

Access controls now expose a `restrictedTo` property that limits the type of group an access control can be assigned to:

* `CUSTOMER` - the access control can be assigned only to groups of `CUSTOMER` user type.
* `EMPLOYEE` - the access control can be assigned only to groups of `EMPLOYEE` user type.

If `restrictedTo` is not present on an access control, it can be assigned to any group regardless of its user type.

**Multiple domains per access control**

The `domain` property on access controls has been replaced with `domains` - a list of domain identifiers.

**Predefined scopes**

The endpoints for listing and retrieving scopes now also return predefined scopes and scopes responses now include a read-only `predefined` flag indicating whether a scope is system-defined or user-created. Moreover, predefined scopes can now be referenced when creating or updating access controls.

**Deprecation of the roles, permissions, and resources model**

The legacy roles, permissions, and resources object model is being phased out. The endpoints that retrieve these objects, as well as the `roleId` and `resourceId` properties on access controls and the `expand`, `roleId`, and `resourceId` query parameters that resolved them, are now deprecated. The endpoints for retrieving user access controls and user permissions for a specific resource - which are also tied to the legacy model - are deprecated as well.

{% hint style="warning" %}
The deprecated endpoints, properties, and query parameters listed above are no longer maintained and will be removed on **October 1, 2026**. Make sure to migrate any integrations that still rely on them before that date.
{% endhint %}

#### Updated endpoints

| Endpoint                                                                                                                                                                                                    | Description                                                                                                                                                                                                                |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving all access controls](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#get-iam-tenant-access-controls)                             | Property `restrictedTo` introduced. Property `domain` replaced with `domains`. Response properties `roleId` and `resourceId` are now deprecated. Query parameters `expand`, `roleId`, and `resourceId` are now deprecated. |
| [Retrieving an access control](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#get-iam-tenant-access-controls-accesscontrolid)               | Property `restrictedTo` introduced. Property `domain` replaced with `domains`. Response properties `roleId` and `resourceId` are now deprecated. Query parameter `expand` is now deprecated.                               |
| [Upserting an access control](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#put-iam-tenant-access-controls-accesscontrolid)                | Property `restrictedTo` introduced. Property `domain` replaced with `domains`. Predefined scopes can now be used when creating or updating access controls.                                                                |
| [Retrieving all access controls assigned to a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#get-iam-tenant-groups-groupid-access-controls)   | Property `restrictedTo` introduced. Property `domain` replaced with `domains`. Response properties `roleId` and `resourceId` are now deprecated. Query parameter `expand` is now deprecated.                               |
| [Retrieving all access controls assigned to a user](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-userid-access-controls)       | Property `restrictedTo` introduced. Property `domain` replaced with `domains`. Response properties `roleId` and `resourceId` are now deprecated. Query parameter `expand` is now deprecated.                               |
| [Retrieving all access controls assigned to a requested user](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-me-access-controls) | Property `restrictedTo` introduced. Property `domain` replaced with `domains`. Response properties `roleId` and `resourceId` are now deprecated. Query parameter `expand` is now deprecated.                               |
| [Retrieving all scopes](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/custom-scopes#get-iam-tenant-scopes)                                                 | Response now includes the read-only `predefined` flag. The endpoint now also returns predefined access control scopes in addition to user-created custom scopes.                                                           |
| [Retrieving a scope](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/custom-scopes#get-iam-tenant-scopes-scopeid)                                            | Response now includes the read-only `predefined` flag. The endpoint now also returns predefined access control scopes in addition to user-created custom scopes.                                                           |

#### Deprecated endpoints

| Endpoint                                                                                                                                                                                                      | Description          |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| [Retrieving all permissions](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/permissions#get-iam-tenant-permissions)                                           | Endpoint deprecated. |
| [Retrieving a permission](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/permissions#get-iam-tenant-permissions-permissionid)                                 | Endpoint deprecated. |
| [Retrieving all resources](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/resources#get-iam-tenant-resources)                                                 | Endpoint deprecated. |
| [Retrieving a resource](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/resources#get-iam-tenant-resources-resourceid)                                         | Endpoint deprecated. |
| [Retrieving a list of roles](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/roles#get-iam-tenant-roles)                                                       | Endpoint deprecated. |
| [Retrieving a role](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/roles#get-iam-tenant-roles-roleid)                                                         | Endpoint deprecated. |
| [Retrieving user access controls for a resource](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-userid-access-controls-resourceid) | Endpoint deprecated. |
| [Retrieving user permissions for a resource](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-userid-permissions-resourceid)         | Endpoint deprecated. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-11" tags="improvement" %}
## Product Service - code on dynamic variant variants map entries

#### Overview

For `DYNAMIC_VARIANT` root products, each entry in the denormalized `variants` map now includes `code`: the business code of the corresponding variant product (the same value as on the variant product itself). This lets storefronts and integrations read SKU-style identifiers from the root response without an extra lookup.

Webhook event documentation for payloads that include the dynamic variant `variants` structure has been aligned with this field.

#### Modified behavior

When you retrieve a dynamic variant **root** product, every key under `variants` includes:

* `code` — string, code of the source variant product

Existing fields such as `version`, `name`, `parentVariantId`, `sellable`, `dynamicVariantType`, and `variantAttributes` are unchanged.

#### Known problems

There are no known problems.

#### Links

* [How to work with dynamic variant products](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/api-guides/products-labels-and-brands/product-service/product#how-to-work-with-dynamic-variant-products)
* [Events - Index Item](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/api-guides/webhooks/webhook-events/events-index)
{% endupdate %}

{% update date="2026-05-11" tags="improvement" %}
## Product Service - expand brand and labels in product responses

#### Overview

Product responses can now be enriched with expanded brand and label data using the `expand` query parameter.

#### Modified behavior

When requesting product data, you can now use:

* `expand=brand` to include a `brand` object expanded from `brandId`
* `expand=labels` to include a `labels` array expanded from `labelIds`
* multiple values can be combined, for example: `expand=template,parentVariant,brand,labels`

#### Schema updates

The product response schemas were extended with:

* `brand` (expanded object)
* `labels` (expanded array)

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-11" tags="improvement" %}
## Webhook Events - updated `index-item.updated` event schema

#### Overview

The `index-item.updated` webhook event documentation has been updated to reflect the current payload structure used by staging changes.

#### Updated event

| Event                | Description                                                                                                                        |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `index-item.updated` | Updated event schema for index item update payload, including nested product, variant, site-specific price, and availability data. |

#### Known problems

There are no known problems.

#### Links

* [Events - Index Item](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/api-guides/webhooks/webhook-events/events-index)
{% endupdate %}

{% update date="2026-05-11" tags="new-feature" %}
## Cart Service - batch update endpoint for cart items

#### Overview

The Cart Service API reference now documents a new batch update endpoint for cart items. You can update multiple items in a cart in a single request using `PUT /cart/{tenant}/carts/{cartId}/itemsBatch`. The response for `POST /cart/{tenant}/carts/{cartId}/itemsBatch` was extended with the `index` property in each batch entry.

#### New endpoints

| Endpoint                                                                                                                                                                   | Description                                                                                                                                |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| [Updating multiple products in cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#put-cart-update-multiple-items-in-cart) | New endpoint for updating multiple cart items in one request. The number of cart items that can be edited in one request is limited to 50. |

#### Updated endpoints

| Endpoint                                                                                                                                                               | Description                                                                                                               |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| [Adding multiple products to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-add-multiple-items-to-cart) | Response for `POST /cart/{tenant}/carts/{cartId}/itemsBatch` was extended with the `index` property for each batch entry. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-08" tags="new-feature" %}
## Schema Service - Export and Import functionality for custom schema types

#### Overview

The Schema Service has been extended with endpoints for exporting and importing custom schema types.

#### Updated endpoints

| Endpoint                                                                                                                                                                   | Description                                 |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| [Exporting custom entities](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/export-import#post-schema-tenant-custom-entities-export) | New endpoint for exporting custom entities. |
| [Importing custom entities](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/export-import#post-schema-tenant-custom-entities-import) | New endpoint for importing custom entities. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-05-07" tags="improvement" %}
## Emporix SDK - Availability Service Q-param support, total count header and search improvements

#### Overview

A new `1.2.5` version of the Emporix SDK has been released with the following changes:

* support for the `X-Total-Count` response header on availability search endpoints
* support for the standard `q` query parameter on the site-specific availability endpoint
* support for the `q` request body attribute on the availability search endpoint
* support for the standard `sort` parameter on both availability retrieval and search endpoints

#### Updated methods

| Method                                        | Description                                                                                                                                                              |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `AvailabilityClient.getAvailabilitiesForSite` | The response now includes the `X-Total-Count` header. Added support for the standard `q` query parameter and `sort` parameter.                                           |
| `AvailabilityClient.searchAvailability`       | The response now includes the `X-Total-Count` header. Added support for the standard `q` request body attribute as an alternative filtering method and `sort` parameter. |

#### New types

| Type      | Description                                                                                                                                                                                                   |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| SearchDto | Request body for the availability search endpoint. Accepts either a set of `productIds` for filtering by specific products, or a `q` string for query-based filtering. The two fields are mutually exclusive. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-29" tags="new-feature" %}
## Emporix SDK - Multi-tenant support

#### Overview

A new `1.2.4` version of the Emporix SDK has been released with multi-tenant support.

The SDK now supports running **multiple Emporix tenants within a single JVM**. This is useful when your application needs to communicate with different Emporix environments (e.g., QA, staging, production) or different tenant accounts simultaneously.

When additional tenants are configured, the SDK automatically creates a full bean stack for each tenant — including `EmporixProperties`, `EmporixClientFactory`, `EmporixTokenService`, and all API clients. These beans are injected using Spring's `@Qualifier` annotation with the tenant key as the qualifier value.

#### New features

| Feature                       | Description                                                                                                                                 |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| Multi-tenant configuration    | Define additional tenants under `emporix.tenants.<key>` in `application.yml`. Each `<key>` becomes the `@Qualifier` value for injection.    |
| Property inheritance          | Each tenant inherits shared settings (timeouts, cache) from the default configuration. Only differing properties need to be specified.      |
| Custom credentials per tenant | Custom OAuth2 credentials can be defined per tenant, with fallback to the default custom credentials.                                       |
| Startup validation            | The SDK validates multi-tenant configuration at startup and fails fast with descriptive error messages if rules are violated.               |
| Non-intrusive design          | Tenant-specific beans are non-default candidates, so they never interfere with unqualified injection or user-provided `@Primary` overrides. |
{% endupdate %}

{% update date="2026-04-28" tags="new-feature" %}
## Availability Service - Q-param support, total count header and search improvements

#### Overview

The Availability Service has been updated with support for the standard Q-param query parameter on the site-specific endpoint, a Q-param request body option for the search endpoint, and `X-Total-Count` response header on search endpoints.

#### Updated endpoints

| Endpoint                                                                                                                                                                                                     | Description                                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving all availability information for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site) | The response now includes the `X-Total-Count` header. Added support for the standard `q` query parameter.                                           |
| [Retrieving product availabilities](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)                    | The response now includes the `X-Total-Count` header. Added support for the standard `q` request body attribute as an alternative filtering method. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-27" tags="improvement" %}
## Product Service – dynamic variant product type and recalculation

#### Overview

A new product type `DYNAMIC_VARIANT` has been introduced, enabling flexible multi-level variant hierarchies of up to 4 levels.

Unlike `PARENT_VARIANT` products, which use a fixed attribute template, `DYNAMIC_VARIANT` products form a tree where each variant stores its own `ownVariantAttributes` - these are the attributes that distinguish it from its parent. The root product maintains a denormalized flat map of all descendants in its `variants` field, with accumulated attributes.

Key features of `DYNAMIC_VARIANT` products:

* Variants can be created in any order — a child variant may exist before its parent, simplifying bulk data imports.
* Each variant stores only delta attributes, which are the attributes introduced at its own level. The accumulated, fully merged, attributes are computed by the API at response time by following the `parentVariantId` chain.
* Variant responses expose `ownVariantAttributes` (modifiable, stored in the database) and `inheritedVariantAttributes` (read-only, inherited from ancestors).
* Every variant carries a `parentVariantPath` array (ancestor IDs, direct-parent-first) enabling efficient tree traversal without database graph lookups.
* A `dynamicVariantType` label (for example: `H1_L1`, `H1_L2`) identifies the variant's level in the hierarchy.
* The `sellable` flag indicates whether a variant can be sold directly.

For single product writes, the variant tree on ancestor products is updated synchronously and inline. For bulk imports, a dedicated asynchronous recalculation mechanism is provided by the new `/recalculate` endpoints.

{% hint style="info" %}
See the tutorial section [How to work with dynamic variant products](https://app.gitbook.com/s/d4POTWomuSS7d3dnh4Dg/api-guides/products-labels-and-brands/product-service/product#how-to-work-with-dynamic-variant-products).
{% endhint %}

#### New endpoints

| Endpoint                                                                                                                                                                                                                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Triggering dynamic variant recalculation](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-trigger-dynamic-variant-recalculation) | Accepts up to 1000 product IDs at any hierarchy level and triggers asynchronous recalculation of the variant tree. The system resolves the root for each submitted ID and creates one recalculation job per unique root product. Returns `202 Accepted` with the list of created jobs. If a job for a given root is already `PENDING` or `PROCESSING`, the affected IDs are returned in `skippedProductIds`. Intended to be called after a full batch import, not per individual product write. |
| [Listing recalculation jobs](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-list-recalculation-jobs)                              | Retrieves all dynamic variant recalculation jobs for the tenant. Supports optional filtering by job `status` (`PENDING`, `PROCESSING`, `FINISHED`, `FAILED`, `FAILED_PERMANENT`). Jobs are retained for approximately 30 days after reaching a terminal state and then automatically removed.                                                                                                                                                                                                   |
| [Retrieving a recalculation job](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-get-recalculation-job)                            | Retrieves the current status and details of a specific recalculation job by its ID. Use this endpoint to poll for job completion. Returns `404` if the job does not exist or has been removed after 30 days.                                                                                                                                                                                                                                                                                    |

#### Modified endpoints

| Endpoint                                                                                                                                                                                         | Description                                                                                                                                                                                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products)                  | Now accepts `DYNAMIC_VARIANT` as a valid `productType`. New fields: `parentVariantId`, `dynamicVariantType`, `sellable`, `ownVariantAttributes`.                                                                                                                                                          |
| [Upserting a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid)            | Now accepts `DYNAMIC_VARIANT` product creation and update payloads.                                                                                                                                                                                                                                       |
| [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) | Now accepts partial updates for `DYNAMIC_VARIANT` products.                                                                                                                                                                                                                                               |
| [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk)         | Now accepts `DYNAMIC_VARIANT` products in bulk creation payloads.                                                                                                                                                                                                                                         |
| [Upserting multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk)         | Now accepts `DYNAMIC_VARIANT` products in bulk upsert payloads.                                                                                                                                                                                                                                           |
| [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid)           | Response now includes `DYNAMIC_VARIANT`-specific fields: `variants` (root product, accumulated attributes), `ownVariantAttributes`, `inheritedVariantAttributes`, `parentVariantId`, `parentVariantPath`, `dynamicVariantType`, `sellable`, and extended `metadata` with hierarchy integrity information. |

#### New schemas

| Schema                                   | Description                                                                                                                                                                                                                                      |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `dynamicVariantProductBase`              | Base schema for `DYNAMIC_VARIANT` products. Includes `parentVariantId`, `parentVariantPath`, `dynamicVariantType`, `sellable`, `ownVariantAttributes`, and `inheritedVariantAttributes`.                                                         |
| `dynamicVariantProductCreation`          | Schema for creating `DYNAMIC_VARIANT` products.                                                                                                                                                                                                  |
| `dynamicVariantProductsArray`            | Schema for arrays of `DYNAMIC_VARIANT` products (used in bulk endpoints).                                                                                                                                                                        |
| `dynamicVariantProductUpdate`            | Schema for updating `DYNAMIC_VARIANT` products.                                                                                                                                                                                                  |
| `dynamicVariantProductBulkUpdate`        | Schema for bulk-updating `DYNAMIC_VARIANT` products.                                                                                                                                                                                             |
| `variantAttribute`                       | Structured variant attribute object with localized `name`, `value.type` (`STRING`, `BOOLEAN`, `NUMBER`, `DECIMAL`), `value.qualifier` (canonical matching value), `value.name` (localized display label), and optional `value.unit` (unit code). |
| `dynamicVariantRecalculationRequest`     | Request body for the recalculation endpoint. Contains a `productIds` array (up to 1000 IDs).                                                                                                                                                     |
| `dynamicVariantRecalculationResponse`    | Response from the recalculation endpoint. Contains a `jobs` array and a `skippedProductIds` array.                                                                                                                                               |
| `dynamicVariantRecalculationJobResponse` | Represents a single recalculation job with `id`, `parentRoot`, `requestedByIds`, `status`, `createdAt`, `processingStartedAt`, `finishedAt`, `error`, and `attempts`.                                                                            |
| `dynamicVariantRecalculationJobStatus`   | Enum of job statuses: `PENDING`, `PROCESSING`, `FINISHED`, `FAILED`, `FAILED_PERMANENT`.                                                                                                                                                         |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-27" tags="major-change" %}
## Customer Service - contactEmail field cannot be unset once a value is present

#### Overview

The Customer Service has been updated so that the `contactEmail` field can no longer be unset through the customer profile **partial update (PATCH)** endpoints if it already contains a value. This restriction applies to both the customer-managed and tenant-managed API.

#### Updated endpoints

| Endpoint                                                                                                                                                                            | Description                                                              |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| [Updating a customer profile (by customer)](https://developer.emporix.io/api-references-1/readme/api-reference-12/account-and-profile#patch-customer-tenant-me)                     | The `contactEmail` field can no longer be unset once a value is present. |
| [Updating a customer profile (by tenant)](https://developer.emporix.io/api-references-1/readme/api-reference-11/account-and-profile#patch-customer-tenant-customers-customernumber) | The `contactEmail` field can no longer be unset once a value is present. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-27" tags="new-feature" %}
## Client Management Service - customer group role in Legal Entities

#### Overview

The `customerGroups` object in Legal Entity responses now includes an optional `role` property. This field represents the customer group role and is returned for GET endpoints.

#### Updated endpoints

| Endpoint                                                                                                                                                                                                                                                      | Description                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| [Retrieving all legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities)                                                  | Property `customerGroups.role` is now returned in the response. |
| [Searching with parameters for legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-customer-management-tenant-legal-entities-search)                           | Property `customerGroups.role` is now returned in the response. |
| [Retrieving a legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid)                                        | Property `customerGroups.role` is now returned in the response. |
| [Retrieving a legal entity with parent hierarchy](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid-parent-hierarchy) | Property `customerGroups.role` is now returned in the response. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-24" tags="new-feature" %}
## Cart Service - `cart.updated` event on any cart modification

#### Overview

The Cart Service now emits the `cart.updated` event whenever a cart is modified. This standardizes event behavior so downstream consumers can reliably react to all cart changes.

#### Updated endpoints

| Endpoint                                                                                                                                                                           | Description                                             |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [Updating a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid)                                           | Emits `cart.updated` when cart-level data is changed.   |
| [Changing a cart site](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts-cartid-changesite)                          | Emits `cart.updated` when the cart site is changed.     |
| [Changing a cart currency](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts-cartid-changecurrency)                  | Emits `cart.updated` when the cart currency is changed. |
| [Refreshing a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid-refresh)                                 | Emits `cart.updated` when the cart is refreshed.        |
| [Merging carts](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts-cartid-merge)                                      | Emits `cart.updated` when carts are merged.             |
| [Adding a cart item to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items)                    | Emits `cart.updated` when a new item is added.          |
| [Adding multiple cart items to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-itemsbatch)       | Emits `cart.updated` when items are added in batch.     |
| [Updating a cart item](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#put-cart-tenant-carts-cartid-items-itemid)                    | Emits `cart.updated` when an item is updated.           |
| [Deleting a cart item](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#delete-cart-tenant-carts-cartid-items-itemid)                 | Emits `cart.updated` when an item is removed.           |
| [Deleting all items from cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#delete-cart-tenant-carts-cartid-items)                | Emits `cart.updated` when cart items are cleared.       |
| [Applying a discount to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/discounts#post-cart-tenant-carts-cartid-discounts)                | Emits `cart.updated` when a discount is applied.        |
| [Removing all discounts from cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/discounts#delete-cart-tenant-carts-cartid-discounts)         | Emits `cart.updated` when all discounts are removed.    |
| [Removing a discount from cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/discounts#delete-cart-tenant-carts-cartid-discounts-discountid) | Emits `cart.updated` when a single discount is removed. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-23" tags="new-feature" %}
## AI Service - Agent Analytics

#### Overview

The AI Service has been enhanced with new analytics capabilities for agents. New endpoints are now available to retrieve per-agent execution counts and a comprehensive analytics bundle for the last four weeks, allowing for better tracking of agent usage and performance over time.

#### New endpoints

| Endpoint                                                                                                                                                                                                           | Description                                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving agent analytics bundle for last four weeks](https://developer.emporix.io/api-references/artificial-intelligence/ai-service/api-reference/agent-analytics#get-ai-service-tenant-agentic-analytics)      | Returns a single bundle of analytics for dashboards including request and session aggregates, resolution efficiency, and weekly trends. |
| [Retrieving per-agent execution counts by period](https://developer.emporix.io/api-references/artificial-intelligence/ai-service/api-reference/agent-analytics#get-ai-service-tenant-agentic-analytics-executions) | Returns execution counts per agent for each calendar period (quarter, month, or week).                                                  |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-21" tags="improvement" %}
## Session Context Service - language attribute added to session context model

#### Overview

The Session Context Service has been updated with a new `language` attribute in the session context model. This attribute is now returned in session context GET responses and accepted in session context update requests.

#### Updated endpoints

| Endpoint                                                                                                                                                                       | Description                                                                |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------- |
| [Retrieving a session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/session-management#get-session-context-tenant-context-sessionid)          | The response now includes the `language` attribute in the session context. |
| [Retrieving own session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/own-session-management#get-session-context-tenant-me-context)           | The response now includes the `language` attribute in the session context. |
| [Partially updating own session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/own-session-management#patch-session-context-tenant-me-context) | The `language` attribute is now accepted as an updatable field.            |
| [Updating a session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/session-management#put-session-context-tenant-context-sessionid)            | The `language` attribute is now accepted as an updatable field.            |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-21" tags="improvement" %}
## Customer Service - session context attributes on anonymous login

#### Overview

The Customer Service has been updated to support passing optional session attributes — `currency`, `siteCode`, `language`, and `targetLocation` — when requesting an anonymous token. These attributes are set directly in the session context upon creation.

#### Updated endpoints

| Endpoint                                                                                                                                                                       | Description                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| [Requesting an anonymous token](https://developer.emporix.io/api-references-1/readme/api-reference-12/authentication-and-authorization#get-customerlogin-auth-anonymous-login) | New optional parameters, updating session context upon anonymous token acquisition: `currency`, `siteCode`, `language`, `targetLocation`. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-13" tags="new-feature" %}
## Schema Service — custom instance scopes, owner, and type-scoped access

#### Overview

{% hint style="info" %}
This functionality is still under development and not yet fully complete. Updates to the Management Dashboard for this area are currently in progress.
{% endhint %}

The Schema Service now exposes finer-grained access for custom instances, returns ownership metadata on custom instances, and automatically provisions type-specific scopes when a custom entity type is created.

When a new custom schema type is created the platform provisions scopes for that type so clients can read and manage custom instances of that type using the `custom.{lowerCaseType}_*` pattern.

Custom instance APIs accept **one** of several scopes:

* **Read**:
  * `schema.custominstance_read`
  * `custom.{lowerCaseType}_read`
  * `custom.{lowerCaseType}_read_own`
* **Manage**:
  * `schema.custominstance_manage`
  * `custom.{lowerCaseType}_manage`
  * `custom.{lowerCaseType}_manage_own`

Tenant-wide scopes apply to all custom types, while type-specific scopes restrict access to a single custom entity type.

Custom instance responses include a read-only `owner` object indicating who created the instance: `type` (`EMPLOYEE`, `CUSTOMER`, or `SERVICE`), `userId`, and for customer owners an optional `legalEntityId`.

#### Updated Endpoints

| Endpoint                                                                                                                                                                                          | Description                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| [Creating a custom schema type](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-schema-type#post-schema-tenant-custom-entities)                      | Creating a new type provisions scopes for reading and managing custom instances of that type.               |
| [Upserting a custom schema type](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-schema-type#put-schema-tenant-custom-entities-id)                   | When the upsert creates a new type, scopes are provisioned for that type’s custom instances.                |
| [Retrieving all custom instances](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#get-schema-tenant-custom-entities-type-instances)         | Authorization now accepts type-specific `read` / `read_own` scopes; each item includes an `owner` property. |
| [Retrieving a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#get-schema-tenant-custom-entities-type-instances-id)         | Authorization now accepts type-specific `read` / `read_own` scopes; each item includes an `owner` property. |
| [Searching for custom instances](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances-search)  | Authorization now accepts type-specific `read` / `read_own` scopes; each item includes an `owner` property. |
| [Creating a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances)             | Authorization now accepts type-specific `manage` / `manage_own` scopes.                                     |
| [Upserting a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#put-schema-tenant-custom-entities-type-instances-id)          | Authorization now accepts type-specific `manage` / `manage_own` scopes.                                     |
| [Patching a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#patch-schema-tenant-custom-entities-type-instances-id)         | Authorization now accepts type-specific `manage` / `manage_own` scopes.                                     |
| [Deleting a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#delete-schema-tenant-custom-entities-type-instances-id)        | Authorization now accepts type-specific `manage` / `manage_own` scopes.                                     |
| [Creating custom instances in bulk](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances-bulk) | Authorization now accepts type-specific `manage` / `manage_own` scopes.                                     |
| [Upserting custom instances in bulk](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#put-schema-tenant-custom-entities-type-instances-bulk) | Authorization now accepts type-specific `manage` / `manage_own` scopes.                                     |
| [Deleting custom instances in bulk](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#delete-schema-tenant-custom-entities-type-instances-bulk)        | Authorization now accepts type-specific `manage` / `manage_own` scopes.                                     |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-13" tags="new-feature" %}
## IAM Service — custom scopes and access controls

#### Overview

{% hint style="info" %}
This functionality is still under development and not yet fully complete. Updates to the Management Dashboard for this area are currently in progress.
{% endhint %}

The IAM Service lets tenants define **custom scopes** and manage them over dedicated APIs.

**Access control** responses now include the following properties:

* `domain` property
* `predefined` property - tells if the access control is system-defined or user-created
* `vendorAware` - tells if the access control is associated with vendor scopes

The endpoint for listing access controls supports the `q` search parameter. Additionally, it's now possible to create, update, and delete custom access controls.

#### New Endpoints

| Endpoint                                                                                                                                                                                       | Description                                 |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| [Retrieving all scopes](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/scopes#get-iam-tenant-scopes)                                           | New endpoint for retrieving scopes.         |
| [Retrieving a scope](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/scopes#get-iam-tenant-scopes-scopeid)                                      | New endpoint for retrieving a scope.        |
| [Upserting a custom scope](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/scopes#put-iam-tenant-scopes-scopeid)                                | New endpoint for upserting custom scopes.   |
| [Deleting a custom scope](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/scopes#delete-iam-tenant-scopes-scopeid)                              | New endpoint for deleting custom scopes.    |
| [Upserting an access control](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#put-iam-tenant-access-controls-accesscontrolid)   | New endpoint for upserting access controls. |
| [Deleting an access control](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#delete-iam-tenant-access-controls-accesscontrolid) | New endpoint for deleting access controls.  |

#### Updated Endpoints

| Endpoint                                                                                                                                                                                      | Description                                                                                                                                   |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving all access controls](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#get-iam-tenant-access-controls)               | Access control response now includes `domain`, `predefined`, and `vendorAware` properties; the endpoint now supports the `q` query parameter. |
| [Retrieving an access control](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#get-iam-tenant-access-controls-accesscontrolid) | Access control response now includes `domain`, `predefined`, and `vendorAware`.                                                               |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-07" tags="new-feature" %}
## Order Service - historical transitions endpoint for tenant-managed orders

#### Overview

Order Service has been enhanced by exposing information about history of order status changes.

#### Updated endpoints

| Endpoint                                                                                                                                                                                                                                | Description                                                              |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| [Retrieving historical status transitions for a specific order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid-historical-transitions) | New endpoint returning historical order status transitions and metadata. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-07" tags="new-feature" %}
## Emporix SDK - Availability Service support

#### Overview

A new `1.2.2` version of the Emporix SDK has been released with support for the Availability Service.

A new `AvailabilityClient` has been introduced, providing full access to the Availability Service API. It enables managing product availability information including stock levels, availability flags, distribution channels, and popularity scores. Both single-product and bulk operations are supported.

#### New client

| Client             | Description                                                                                                                |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------- |
| AvailabilityClient | Declarative HTTP client for the Availability Service. Automatically registered as a Spring bean when tenant is configured. |

#### New methods

| Method                                      | Description                                                                                   |
| ------------------------------------------- | --------------------------------------------------------------------------------------------- |
| AvailabilityClient.createAvailability       | Creates a new availability entry for a specific product and site.                             |
| AvailabilityClient.bulkCreateAvailability   | Creates availability entries for multiple products in a single bulk operation.                |
| AvailabilityClient.upsertAvailability       | Creates or fully replaces the availability entry for a specific product and site.             |
| AvailabilityClient.bulkUpsertAvailability   | Creates or fully replaces availability entries for multiple products in a single bulk upsert. |
| AvailabilityClient.deleteAvailability       | Deletes the availability entry for a specific product and site.                               |
| AvailabilityClient.bulkDeleteAvailability   | Deletes availability entries for multiple products in a single bulk operation.                |
| AvailabilityClient.searchAvailability       | Searches for availability information across multiple products on a given site.               |
| AvailabilityClient.getAvailabilitiesForSite | Retrieves all availability entries for a specific site.                                       |
| AvailabilityClient.getAvailability          | Retrieves the availability details for a specific product on a specific site.                 |

#### New types

| Type                      | Description                                                                                                                                                                                    |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AvailabilityDto           | Request body for creating or upserting a single availability entry. Contains `stockLevel`, `available`, `popularity`, `distributionChannel`, `mixins`, `metadata`, and `bundleAvailabilities`. |
| AvailabilityBulkDto       | Extends `AvailabilityDto` with `productId` and `site` fields for use in bulk create and upsert operations.                                                                                     |
| AvailabilityDeleteBulkDto | Identifies an availability entry by `productId` and `site` for use in bulk delete operations.                                                                                                  |
| AvailabilityResponse      | Extends `AvailabilityDto` with `id`, `site`, `productId`, and `vendorId` fields returned by read operations.                                                                                   |
| DistributionChannel       | Enum representing the distribution channel of an availability entry. Possible values: `ASSORTMENT`, `HOME_DELIVERY`, `PICKUP`.                                                                 |

#### Known problems

We recommend to avoid creating new availabilities for the site `main`. More details in [API Reference](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#post-availability-tenant-availability-productid-site).
{% endupdate %}

{% update date="2026-04-02" tags="new-feature" %}
## Availability Service - new bulk processing endpoints

#### Overview

The Availability Service has been enhanced with bulk processing endpoints allowing for creating, upserting and deleting product availabilities in bulk up to 200 elements.

#### New endpoints

| Endpoint                                                                                                                                                                                    | Description                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| [Creating multiple product availabilities](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#post-availability-tenant-availability-bulk)                  | Creates new product availabilities specified by product ID and site.     |
| [Upserting multiple product availabilities](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#put-availability-tenant-availability-bulk)                  | Creates/updates product availabilities specified by product ID and site. |
| [Deleting multiple availability information of a product](https://developer.emporix.io/api-references-1/readme/api-reference-2/availabilities#delete-availability-tenant-availability-bulk) | Deletes product availabilities specified by product ID and site.         |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-04-01" tags="improvement" %}
## IAM Service - last login information exposed in user GET endpoints

#### Overview

IAM Service has been enhanced by exposing information about user's last login in selected user GET endpoints.

#### Updated Endpoints

| Endpoint                                                                                                                                                                 | Description                                             |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------- |
| [Retrieving a list of users](https://developer.emporix.io/api-references-1/readme/api-reference-17/management-dashboard-users#get-iam-tenant-users)                      | The `lastLogin` field has been added the response body. |
| [Retrieving a user of the `EMPLOYEE` type](https://developer.emporix.io/api-references-1/readme/api-reference-17/management-dashboard-users#get-iam-tenant-users-userid) | The `lastLogin` field has been added the response body. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-03-27" tags="new-feature" %}
## Schema Service - support for `CART_ITEM` and `ORDER_ENTRY` type

#### Overview

Schema Service has been extended with new schema types - `CART_ITEM`, `ORDER_ENTRY`.

#### Updated Endpoints

| Endpoint                                                                                                                                       | Description                                                                                           |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas)   | The `CART_ITEM` and `ORDER_ENTRY` schema type has been added and can now be used in the request body. |
| [Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id) | The `CART_ITEM` and `ORDER_ENTRY` schema type has been added and can now be used in the request body. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-03-23" tags="improvement" %}
## Emporix SDK cartItem type replacement

#### Overview

A new version `1.2.1` of the Emporix SDK has been released, introducing the following change:

* The `type` field has been removed from the `UpdateCartItem` DTO and replaced with `itemType`.

#### Updated DTO

| DTO                 | Description                                                                           |
| ------------------- | ------------------------------------------------------------------------------------- |
| UpdateCartItem.java | The `type` field has been removed and replaced with `itemType` to align with the API. |

#### Known Issues

If your code previously relied on the `type` field, it will no longer compile. Note, however, that this field was ignored by the Emporix API in earlier versions.
{% endupdate %}

{% update date="2026-03-20" tags="new-feature" %}
## Returns Service - calculated price properties for returns

#### Overview

The `Return` object has been extended with new calculated price properties that provide a detailed net, gross, and tax breakdown derived from the order entry's `calculatedPrice.finalPrice`.

The following new properties have been introduced:

* **`calculatedUnitPrice`** on return items — unit price derived from the order entry's `calculatedPrice.finalPrice` divided by the order entry amount. Includes discounts and fees.
* **`calculatedPrice`** on return items — total calculated price for the returned quantity of the item, computed as `calculatedUnitPrice` multiplied by the returned quantity.
* **`calculatedPrice`** on the return level — aggregated calculated price across all returned items.

Each calculated price object contains `netValue`, `grossValue`, `taxValue`, `taxCode`, and `taxRate` fields.

#### Updated endpoints

| Endpoint                                                                                                                                                     | Description                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------- |
| [Retrieving a list of returns](https://developer.emporix.io/api-references/api-guides/orders/returns/api-reference/returns#get-return-tenant-returns)        | New properties `calculatedUnitPrice` and `calculatedPrice` on return items, and `calculatedPrice` on the return level. |
| [Retrieving a single return](https://developer.emporix.io/api-references/api-guides/orders/returns/api-reference/returns#get-return-tenant-returns-returnid) | New properties `calculatedUnitPrice` and `calculatedPrice` on return items, and `calculatedPrice` on the return level. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-03-19" tags="new-feature" %}
## Sequential ID Service - new schema removal endpoint

#### Overview

The Sequential ID Service has been enhanced with a new delete endpoint that allows for removing schemas by ID.

#### New endpoints

| Endpoint                                                                                                                                                              | Description                                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| [Removing schema by ID](https://developer.emporix.io/api-references-1/readme/api-reference-33/sequential-ids-management#delete-sequential-id-tenant-schemas-schemaid) | New endpoint that allows for schema removal by ID. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-03-16" tags="new-feature" %}
## Order Service - checkout property for sales orders

#### Overview

The sales order resource has been extended with a new `checkout` boolean field.

* This field can be provided only when creating an order.
* It is included only in tenant-managed order responses (not in customer-managed order responses).
* When set to `true`, it enforces that only one order can be created per cart ID.
* Orders created through the checkout flow have this flag set to `true` by default.

#### Updated endpoints

| Endpoint                                                                                                                                                                             | Description                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------- |
| [Creating a new order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)                     | Property `checkout` has been introduced. |
| [Retrieving orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)                         | Property `checkout` has been introduced. |
| [Searching for orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders-search)              | Property `checkout` has been introduced. |
| [Retrieving a specific order by ID](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid) | Property `checkout` has been introduced. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-03-12" tags="deprecated" %}
## Order Service - hybris-count header deprecated

#### Overview

The `hybris-count` response header is deprecated as the same information is provided by the `X-Total-Count` header. The `hybris-count` will be removed on **2026-09-14**

The `hybris-count` respnse header:

* Returns the order count in a number of GET endpoints
* Information provided by the header duplicates the information already provided by the `X-Total-Count` header

#### Affected endpoints

| Endpoint                                                                                                                                                                    | Description                                                                           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| [Retrieving a list of orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders)         | Response header `hybris-count` is deprecated, `X-Total-Count` should be used instead. |
| [Retrieving orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)                | Response header `hybris-count` is deprecated, `X-Total-Count` should be used instead. |
| [Retrieving the number of orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#head-order-v2-tenant-salesorders) | Response header `hybris-count` is deprecated, `X-Total-Count` should be used instead. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-03-10" tags="new-feature" %}
## Customer Service - SSO customer authentication based on token exchange

#### Overview

The Customer Service exposes a new endpoint that provides the possibility to authenticate customers using token exchange approach. It allows you to exchange an external access token from a chosen identity provider for an Emporix customer access token.

#### New endpoints

| Endpoint                                                                                                                                                                                                                                                    | Description                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------- |
| [Exchanging an external access token for an Emporix customer token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/authentication-and-authorization#post-customer--tenant-exchangeauthtoken) | A new endpoint for token exchange authentication mechanism. |

#### Known problems

There are no known problems.

#### Documentation

For more information, refer to the [SSO with Token Exchange](../quickstart/authentication-and-authorization/token-exchange.md).
{% endupdate %}

{% update date="2026-03-09" tags="improvement" %}
## Emporix SDK - Product API skipRelatedItemsValidation support

#### Overview

A new `1.2.0` version of the Emporix SDK has been released with support for the `skipRelatedItemsValidation` query parameter in product create, update, partial update, and bulk operations.

When set to `true`, the validation that checks whether related products exist is skipped. This is useful during data loading scenarios where related products may not yet exist and will be created later.

**Important:** The `skipRelatedItemsValidation` parameter is only respected when the `allowToSkipRelatedProductsValidation` system setting is set to `true`. Otherwise, it is disregarded.

#### Updated methods

| Method                               | Description                                         |
| ------------------------------------ | --------------------------------------------------- |
| ProductClient.createProduct          | Added `skipRelatedItemsValidation` query parameter. |
| ProductClient.bulkCreateProducts     | Added `skipRelatedItemsValidation` query parameter. |
| ProductClient.upsertProduct          | Added `skipRelatedItemsValidation` query parameter. |
| ProductClient.bulkUpsertProduct      | Added `skipRelatedItemsValidation` query parameter. |
| ProductClient.partiallyUpdateProduct | Added `skipRelatedItemsValidation` query parameter. |

#### Known problems

A new `skipRelatedItemsValidation` parameter has been added to the method signatures of `createProduct`, `bulkCreateProducts`, `upsertProduct`, `bulkUpsertProduct`, and `partiallyUpdateProduct`. This is a breaking change — existing callers of these methods will need to be updated to pass the additional parameter (use `null` to preserve the previous default behavior).
{% endupdate %}

{% update date="2026-03-09" tags="improvement" %}
## Product Service – skip related items validation

#### Overview

A new query parameter `skipRelatedItemsValidation` has been added to product creation and update endpoints. When set to `true`, the validation that checks whether related products exist is skipped. This is useful during data loading scenarios where related products may not yet exist and will be created later.

**Important:** The `skipRelatedItemsValidation` parameter is only respected when the `allowToSkipRelatedProductsValidation` system setting is set to `true`. Otherwise, it is disregarded.

#### Modified endpoints

| Endpoint                                                                                                                                                                                         | Description                                             |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------- |
| [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products)                  | New query parameter `skipRelatedItemsValidation` added. |
| [Upserting a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid)            | New query parameter `skipRelatedItemsValidation` added. |
| [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) | New query parameter `skipRelatedItemsValidation` added. |
| [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk)         | New query parameter `skipRelatedItemsValidation` added. |
| [Upserting multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk)         | New query parameter `skipRelatedItemsValidation` added. |

#### New system setting

| Setting                                | Description                                                                                                                                                                      |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `allowToSkipRelatedProductsValidation` | When set to `true`, it allows the `skipRelatedItemsValidation` query parameter to take effect. If this setting is `false` or not configured, the query parameter is disregarded. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-24" tags="improvement" %}
## Emporix SDK - price list prices q param search support

#### Overview

A new version of the Emporix SDK has been released with the following changes:

* support for the `q` query parameter in the price list prices retrieval endpoint
* support for the new price list prices search endpoint

#### New methods

| Method                            | Description                                                                 |
| --------------------------------- | --------------------------------------------------------------------------- |
| PriceListPriceClient.searchPrices | New method that allows searching for price list prices with a request body. |

#### Updated methods

| Method                         | Description                                                                     |
| ------------------------------ | ------------------------------------------------------------------------------- |
| PriceListPriceClient.getPrices | Added support for the standard `q` query parameter to filter price list prices. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-20" tags="improvement" %}
## Price Service - new search endpoint and query parameter for price list prices

#### Overview

The Price Service has been enhanced with a new search endpoint that allows searching for prices assigned to a price list using a request body. Additionally, the existing GET prices endpoint now supports the `q` query parameter for filtering results.

#### New endpoints

| Endpoint                                                                                                                                                                                                                                    | Description                                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| [Searching for prices assigned to a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices-assigned-to-price-lists#post-price-tenant-price-lists-pricelistid-prices-search) | New endpoint that allows searching for price list prices with a request body. |

#### Updated endpoints

| Endpoint                                                                                                                                                                                                                             | Description                                                                     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------- |
| [Retrieving all prices assigned to a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices-assigned-to-price-lists#get-price-tenant-price-lists-pricelistid-prices) | Added support for the standard `q` query parameter to filter price list prices. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-12" tags="new-feature" %}
## Emporix SDK - restrictions support

#### Overview

A new `1.1.1` version of the Emporix SDK has been released with the following changes:

* support for the `restrictions`
* fixes to the `deliveryWindowValidations` client path

#### Updated types

| Type                               | Description                                  |
| ---------------------------------- | -------------------------------------------- |
| CartResponse                       | Property `restriction` has been introduced.  |
| CreateCart                         | Property `restriction` has been introduced.  |
| UpdateCart                         | Property `restriction` has been introduced.  |
| OrderCommon                        | Property `restriction` has been introduced.  |
| OrderPartialUpdateRequest          | Property `restriction` has been introduced.  |
| CustomerCommon                     | Property `restriction` has been introduced.  |
| CommonCustomerPartialUpdateRequest | Property `restriction` has been introduced.  |
| LegalEntityCommonDto               | Property `restrictions` has been introduced. |

#### Known problems

All args constructors require the new parameters. Use the builders to avoid breaking changes in the future.
{% endupdate %}

{% update date="2026-02-11" tags="new-feature" %}
## Quote Service - restriction property for quotes

#### Overview

The `Quote` object was extended with a new `restriction` property. This property is an access control identifier that determines who can view or manage the quote.

The `restriction` field:

* Restricts quote visibility based on scope permissions
* Users can only query and view quotes whose `restriction` value matches one of their authorized restrictions

#### Updated endpoints

| Endpoint                                                                                                                                                            | Description                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| [Creating a quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#post-quote-tenant-quotes)                     | Property `restriction` has been introduced. |
| [Retrieving quotes](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes)                     | Property `restriction` has been introduced. |
| [Retrieving a single quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid)     | Property `restriction` has been introduced. |
| [Partially updating a quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#patch-quote-tenant-quotes-quoteid)  | Property `restriction` has been introduced. |
| [Partially updating a quote](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-management#patch-quote-tenant-quotes-quoteid)  | Property `restriction` has been introduced. |
| [Retrieving quote history](https://developer.emporix.io/api-references/api-guides/quotes/quote/api-reference/quote-history#get-quote-tenant-quotes-quoteid-history) | Property `restriction` has been introduced. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-11" tags="new-feature" %}
## Customer Service - restriction property for customers

#### Overview

The `Customer` object was extended with a new `restriction` property. This property is an access control identifier that determines who can view or manage the customer.

The `restriction` field:

* Restricts customer visibility based on scope permissions
* Users can only query and view customers whose `restriction` value matches one of their authorized restrictions

#### Updated endpoints

| Endpoint                                                                                                                                                                                                        | Description                                 |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| [Creating a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers)                         | Property `restriction` has been introduced. |
| [Retrieving all customers](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers)                     | Property `restriction` has been introduced. |
| [Searching for customers](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers-search)              | Property `restriction` has been introduced. |
| [Retrieving a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers-customernumber)         | Property `restriction` has been introduced. |
| [Upserting a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#put-customer-tenant-customers-customernumber)  | Property `restriction` has been introduced. |
| [Updating a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber) | Property `restriction` has been introduced. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-11" tags="new-feature" %}
## Order Service - restriction property for orders

#### Overview

The `Order` object was extended with a new `restriction` property. This property is an access control identifier that determines who can view or manage the order.

The `restriction` field:

* Restricts order visibility based on scope permissions
* Users can only query and view orders whose `restriction` value matches one of their authorized restrictions

#### Updated endpoints

| Endpoint                                                                                                                                                                             | Description                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------- |
| [Creating a new order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)                     | Property `restriction` has been introduced. |
| [Retrieving orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)                         | Property `restriction` has been introduced. |
| [Searching for orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders-search)              | Property `restriction` has been introduced. |
| [Retrieving a specific order by ID](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid) | Property `restriction` has been introduced. |
| [Updating an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#put-order-v2-tenant-salesorders-orderid)                 | Property `restriction` has been introduced. |
| [Partially updating an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#patch-order-v2-tenant-salesorders-orderid)     | Property `restriction` has been introduced. |
| [Retrieving a list of orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders)                  | Property `restriction` has been introduced. |
| [Retrieving order details](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders-orderid)             | Property `restriction` has been introduced. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-11" tags="new-feature" %}
## Cart Service - restriction property for carts

#### Overview

The `Cart` object was extended with a new `restriction` property. This property is an access control identifier that determines who can view or manage the cart.

The `restriction` field:

* Restricts cart visibility based on scope permissions
* Users can only query and view carts whose `restriction` value matches one of their authorized restrictions

#### Updated endpoints

| Endpoint                                                                                                                                      | Description                                 |
| --------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- |
| [Creating a new cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts)        | Property `restriction` has been introduced. |
| [Updating a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid)      | Property `restriction` has been introduced. |
| [Retrieving all carts](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts)        | Property `restriction` has been introduced. |
| [Retrieving a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)    | Property `restriction` has been introduced. |
| [Searching for carts](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts-search) | Property `restriction` has been introduced. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-11" tags="new-feature" %}
## Client Management Service - restrictions property for Legal Entities

#### Overview

The `LegalEntity` object was extended with a new `restrictions` property. This property is an access control identifier that determines who can view or manage the LegalEntity.

The `restrictions` field:

* Restricts Legal Entities visibility based on scope permissions
* Users can only query and view Legal Entities and Contact Assignments whose `restrictions` value matches one of their authorized restrictions

#### Updated endpoints

| Endpoint                                                                                                                                                                                                                                                      | Description                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| [Retrieving all legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities)                                                  | Property `restrictions` has been introduced.             |
| [Creating legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-customer-management-tenant-legal-entities)                                                         | Property `restrictions` has been introduced.             |
| [Searching with parameters for legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-customer-management-tenant-legal-entities-search)                           | Property `restrictions` has been introduced.             |
| [Retrieving a legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid)                                        | Property `restrictions` has been introduced.             |
| [Upserting a legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#put-customer-management-tenant-legal-entities-legalentityid)                                         | Property `restrictions` has been introduced.             |
| [Retrieving a legal entity with parent hierarchy](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid-parent-hierarchy) | Property `restrictions` has been introduced.             |
| [Retrieving all contact assignments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/contact-assignments#get-customer-management-tenant-contact-assignments)                                   | Property `legalEntity.restrictions` has been introduced. |
| [Retrieving a contact assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/contact-assignments#get-customer-management-tenant-contact-assignments-contactassignmentid)                  | Property `legalEntity.restrictions` has been introduced. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-11" tags="new-feature" %}
## IAM Service - restrictions and restrictionAware properties

#### Overview

**restrictions property for groups**

The `Group` object was extended with a new `restrictions` property. This property limits the visibility of permission-aware entities for users based on scope permissions.

**restrictionAware property for access controls**

The `AccessControl` object was extended with a new `restrictionAware` property. This property determines whether an access control generates scopes with restriction suffixes when assigned to a group that has restrictions defined.

When `restrictionAware` is set to `true`, the generated scopes will include restrictions (e.g., `order.order_manage--DE`) based on the group's restrictions list. When `false`, scopes are generated without restriction suffixes regardless of the group's restrictions.

#### Updated endpoints

**Groups**

| Endpoint                                                                                                                                                  | Description                                  |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| [Creating a new group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups)      | Property `restrictions` has been introduced. |
| [Upserting a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#put-iam-tenant-groups-groupid)  | Property `restrictions` has been introduced. |
| [Retrieving all groups](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#get-iam-tenant-groups)      | Property `restrictions` has been introduced. |
| [Retrieving a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#get-iam-tenant-groups-groupid) | Property `restrictions` has been introduced. |

**Access Controls**

| Endpoint                                                                                                                                                                                                      | Description                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Retrieving all access controls](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#get-iam-tenant-access-controls)                               | Property `restrictionAware` has been introduced.                             |
| [Retrieving an access control](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#get-iam-tenant-access-controls-accesscontrolid)                 | Property `restrictionAware` has been introduced.                             |
| [Retrieving all access controls assigned to a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#get-iam-tenant-groups-groupid-access-controls)     | Property `restrictionAware` has been introduced.                             |
| [Retrieving all access controls assigned to a user](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-userid-access-controls)         | Property `restrictionAware` has been introduced.                             |
| [Retrieving user access controls for a resource](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-userid-access-controls-resourceid) | Property `restrictionAware` has been introduced.                             |
| [Retrieving all access controls assigned to the current user](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-me-access-controls)   | Property `restrictionAware` has been introduced.                             |
| [Retrieving all access control templates](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-control-templates#get-iam-tenant-templates)                   | Property `restrictionAware` has been introduced in expanded access controls. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-06" tags="new-feature" %}
## IAM Service – new endpoint for retrieving own user

#### Overview

A new endpoint has been added to allow users to retrieve their own user information.

#### New endpoints

| Endpoint                                                                                                                                                                 | Description                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| [Retrieving own user](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/management-dashboard-users#get-iam-tenant-users-me) | Retrieves the currently authenticated user along with the groups this user belongs to. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-02-04" tags="improvement" %}
## Product Service – category and customer segment IDs no longer in preview

#### Overview

The `customerSegmentIds` and `categoryIds` fields in product retrieval responses are now fully operational and no longer in preview mode.

#### Modified endpoints

| Endpoint                                                                                                                                                                               | Description                                                                      |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| [Searching for products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-search) | The `customerSegmentIds` and `categoryIds` attributes are now fully operational. |
| [Retrieving all products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products)        | The `customerSegmentIds` and `categoryIds` attributes are now fully operational. |
| [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid) | The `customerSegmentIds` and `categoryIds` attributes are now fully operational. |

#### Known problems

There are no known problems.
{% endupdate %}

{% update date="2026-01-08" tags="new-feature" %}
## Configuration Service - New properties for configurations

#### Overview

The `Configuration` and `Client Configuration` objects were extended with following properties:

* `readOnly`
* `restricted`
* `description`
* `schemaUrl`

#### Updated endpoints

| Endpoint                                                                                                                                                                                                                               | Description                                                                              |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| [Retrieving configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations)                                    | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Creating configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#post-configuration-tenant-configurations)                                     | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey)                       | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey)                         | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving client configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#get-configuration-tenant-clients-client-configurations)              | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Creating client configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#post-configuration-tenant-clients-client-configurations)               | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving a client configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#get-configuration-tenant-clients-client-configurations-propertykey) | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Updating a client configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#put-configuration-tenant-clients-client-configurations-propertykey)   | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving global configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/global-configurations)                                                                     | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |

#### Known problems

There are no known problems.
{% endupdate %}
{% endupdates %}
