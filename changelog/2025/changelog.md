---
seo:
  title: 2025 Changelog
  description: Changelog
toc:
  enable: true
tocMaxDepth: 1
disableLastModified: true
editPage:
  disable: true
  label: Changelog

---
<!-- import { Badge } from '../components/Badge.tsx'

# Changelog

Learn more about any recent changes in the Emporix API. -->

<!-- BEFORE YOU START CREATING A NEW ENTRY, SEE HOW TO KEEP THE CHANGELOG CONSISTENT:

    ## **Changelog rules:**

    * Add a new changelog entry just after the comments
    * Finish entry with a line: ---

    ### Badge
    * Start with a <Badge/> with proper tag and date
    * Use one of the following tags: major, minor, deprecated, newFeature, improvement. Or, add any text or custom color using label="" and color="".
    Badges can be stacked together
    * Use date format YYYY-MM-DD
    * If the feature is not fully operational, also include: label=”in progress”

    ** EXAMPLE:
    <Badge tag="minor" date="YYYY-MM-DD"/>


    ### Title
    * Use sentence case
    * Use the format: Name of the Service (Title Case) - {short phrase indicating the main change}
    * Convention for {description}: short noun phrase / key words indicating the main change
    * For code-phrases, use backticks (``) and not quotation marks etc.
    * Keep it quite general, details come in Overview

     ** EXAMPLES:
    Availability Service - support for mixins
    Schema Service - support for `customer.address` type
    Availability Service - removal of scopes
    Webhook Service - custom headers

    ### Note - optional section
    * If the feature is in preview mode, add a note:
    ```
    :::attention
    This functionality is in preview mode — some of the features may not be fully operational yet.
    :::
    ```
    * If the feature is now operational, but wasn't fully before, add a note:
    ```
    :::attention
    This functionality is updated and now is fully operational.
    :::
    ```

    ### Overview
    * Provide a short description with details of what has been changed and what effect it brings - one or a few sentences
    * Use full sentences, try to use active voice, present or past simple tense
    * For names of settings, code-phrases etc. use backticks (``)

     ** EXAMPLE:
    Availability Service from now on supports the mixins feature. There are two new properties in the model - `mixins` and `metadata.mixins`.


    ### Updated/Added endpoints
    * Use the table format
    * Provide links to the changed endpoints
    * For displayed link names, use the verb in gerund form (updating, deleting etc) - this should be consistent with the endpoint title in API reference
    * Provide a description for each changed endpoint:
      * keep it brief and simple
      * use present simple tense if possible
      * try to use active voice, avoid passive if possible
      * use full sentences with a full stop at the end
      * focus on explaining the outcomes or the purpose of the change
    * For code-phrases, use backticks (``)


    ** EXAMPLE:
    | Endpoint                                                                 | Description                                                    |
    | ----------------------------------------------------------------------   | ---------------------------------------------------------------|
    | [Creating a config](/openapi/indexing/#operation/POST-indexing-create-config) | It creates a new index config.                                     |
    | [Retrieving configs](/openapi/indexing/#operation/GET-indexing-list-configs)  | You can save the `code` property in both upper and lower case. |


    ## Known problems
    * Indicate if there are any problems at the time of release.

    ** EXAMPLE:
    There are no known problems.

    NEED A TEMPLATE? See [Template](/content/changelogTEMPLATE).
-->

<!-- <Badge
    tag="deprecated"
    date=""
/> -->


# 2025-04-04: Sequential-ID Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01.

## Deprecated endpoints

| Endpoint                                                                                        | Description                                                                                                                                                                               |
|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving all schemas](/openapi/sequential-id/#operation/GET-sequential-id-retrieve-schemas)  | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas](/openapi/sequential-id/#operation/GET-sequential-id-retrieve-tenant-schemas) instead.                              |
| [Creating a schema](/openapi/sequential-id/#operation/POST-sequential-id-create-schema)         | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas](/openapi/sequential-id/#operation/POST-sequential-id-create-tenant-schema) instead.                                |
| [Creating a nextId](/openapi/sequential-id/#operation/POST-sequential-id-create-nextId)         | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas/types/{schemaType}/nextId](/openapi/sequential-id/#operation/POST-sequential-id-create-schema-type-nextId) instead. |

## Known problems

There are no known problems.

---

<Badge
    tag="newFeature"
    date="2025-04-03"
/>

# 2025-04-03: Schema Service - endpoints for managing custom entities and instances

## Overview

We added new API for managing custom schema types and custom instances. Custom schema types are custom entitities on which you can build custom instances.

## Added endpoints

| Endpoint                                                                                                   | Description                             |
|------------------------------------------------------------------------------------------------------------|-----------------------------------------|
| [Creating a custom schema type](/openapi/schema/#operation/POST-schema-create-custom-schema-type)          | It creates a new schema type.           |
| [Retrieving all custom schema types](/openapi/schema/#operation/GET-schema-retrieve-custom-schema-types)   | It retrieves all custom schema types.   |
| [Retrieving a custom schema type](/openapi/schema/#operation/GET-schema-retrieve-custom-schema-type)       | It retrieves a custom schema type.      |
| [Deleting a custom schema type](/openapi/schema/#operation/DELETE-schema-remove-custom-schema-type)        | It deletes a custom schema type.        |
| [Upserting a custom schema type](/openapi/schema/#operation/PUT-schema-upsert-custom-schema-type)          | It upserts custom schema type.          |
| [Creating a custom instance](/openapi/schema/#operation/POST-schema-create-custom-instance)                | It creates a custom instance.           |
| [Retrieving all custom instances](/openapi/schema/#operation/GET-schema-retrieve-custom-instances)         | It retrieves all custom instances.      |
| [Retrieving a custom instance](/openapi/schema/#operation/GET-schema-retrieve-custom-instance)             | It retrieves a custom instance.         |
| [Deleting a custom instance](/openapi/schema/#operation/DELETE-schema-remove-custom-instance)              | It deletes a custom instance.           |
| [Upserting a custom instance](/openapi/schema/#operation/PUT-schema-upsert-custom-instance)                | It upserts a custom instance.           |
| [Patching a custom instance](/openapi/schema/#operation/PATCH-schema-patch-custom-instance)                | It partially updates a custom instance. |
| [Searching for custom instances](/openapi/schema/#operation/POST-schema-search-custom-instances)           | It searches for custom instances.       |
| [Creating custom instances in bulk](/openapi/schema/#operation/POST-schema-create-custom-instances-bulk)   | It creates custom instances in bulk.    |
| [Upserting custom instances in bulk](/openapi/schema/#operation/PUT-schema-create-custom-instances-bulk)   | It upserts custom instances in bulk.    |
| [Deleting custom instances in bulk](/openapi/schema/#operation/DELETE-schema-create-custom-instances-bulk) | It deletes custom instances in bulk.    |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-04-03"
/>

# 2025-04-03: OAuth Service - new endpoint

## Overview

A new `validate a customer token` endpoint has been created.
The endpoint checks whether a token is valid.
If the token is invalid, it returns a 401 status code.
If the token is valid, it provides the token details.

## New endpoints

| Endpoint                                                                                   | Description                  |
|--------------------------------------------------------------------------------------------|------------------------------|
| [Validate a customer token](/openapi/oauth/#operation/GET-oauth-validate-token)            | New endpoint has been added. |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-04-07"
/>

# IAM Service - new query parameter

## Overview

Query parameter `q` has been added to `GET` all groups endpoint. The new query parameter allows you to filter groups.

## Updated endpoints

| Endpoint                                                                           | Description                                  |
| ---------------------------------------------------------------------------------  | -------------------------------------------  |
| [Retrieving all groups](/openapi/iam/#operation/GET-iam-list-tenant-user-groups)   | The new query parameter `q` has been added.  |

## Known problems

There are no known problems.
---

<Badge
    tag="deprecated"
    date="2025-03-28"
/>

# Customer Service - removed `couponMixin` mixin

## Overview

The `couponMixin` mixin has been removed from the customer model. The mixin was used to store `referralCouponCode` of the customer. The information about referral coupon is now stored in the `Coupon` model.

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-03-28"
/>

# Coupon Service - new `referralCoupon` field in the coupon model

## Overview

A new `referralCoupon` field has been added to the endpoint. This field indicates if the coupon is of a referral coupon type.

## Updated endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-03-28"
/>

# Coupon Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01. From now, use the `/coupon/` base path for all the [coupons endpoints](/openapi/coupon) to manage coupons and referral coupons.


## Deprecated endpoints

| Endpoint                                                                                                        | Description                                                         |
|-----------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)          | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Creating a new coupon](/openapi/coupon/#operation/POST-coupon-create-coupon)                                   | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon) | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Updating the coupon by code](/openapi/coupon/#operation/PUT-coupon-update-coupon)                              | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Partially updating the coupon by code](/openapi/coupon/#operation/PATCH-coupon-update-coupon)                  | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Deleting a coupon by code](/openapi/coupon/#operation/DELETE-coupon-remove-coupon)                             | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Validating redeemability of a coupon](/openapi/coupon/#operation/POST-coupon-validate-coupon)                  | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving a list of redemptions by criteria](/openapi/coupon/#operation/GET-coupon-list-coupon-redemptions)   | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Redeeming the coupon by creating a redemption](/openapi/coupon/#operation/POST-coupon-invalidate-coupon)       | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Retrieving a coupon redemption](/openapi/coupon/#operation/GET-coupon-retrieve-coupon-redemption)              | Endpoint will be removed and moved under the `/coupon/` base path.  |
| [Deleting a coupon redemption](/openapi/coupon/#operation/DELETE-coupon-remove-coupon-redemption)               | Endpoint will be removed and moved under the `/coupon/` base path.  |

## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-03-28"
/>

#  Referral Coupon Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01. From now, use the new [referral coupons endpoints](/openapi/coupon/#tag/Referral-Coupon-Management) to referral coupons.


## Deprecated endpoints

| Endpoint                                                                                                                      | Description                                                                                   |
|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| [Retrieving customer's referral coupon code](/openapi/coupon/#operation/GET-coupon-retrieve-referral-coupon)                  | Endpoint will be removed and moved under <code>/coupon/{tenant}/referral-coupons/{customerNumber}</code>. |
| [Creating a referral coupon code for a specific customer](/openapi/coupon/#operation/POST-coupon-create-referral-coupon-code) | Endpoint will be removed and moved under <code>/coupon/{tenant}/referral-coupons/{customerNumber}</code>. |


## Known problems

There are no known problems.

---
<Badge
    tag="minor"
    date="2025-03-27"
/>

# Quote Service - `businessModel` field added to the responses

## Overview

The `GET` endpoints for the Quote Service have been extended with the `businessModel` field. It provides information whether quote has been created for B2B or B2C customer.

## Updated endpoints

| Endpoint                                                                        | Description                                  |
|---------------------------------------------------------------------------------|----------------------------------------------|
| [Retrieving quotes](/openapi/quote/#operation/GET-quote-list-quotes)            | Field `businessModel` added to the response. |
| [Retrieving a single quote](/openapi/quote/#operation/GET-quote-retrieve-quote) | Field `businessModel` added to the response. |

## Known problems

There are no known problems.

---

<Badge
    tag="minor"
    date="2025-03-21"
/>

# Sequential ID Service - `siteCode` query param

## Overview

Query param `siteCode` has been added to endpoints responsible for generating next ids. The `siteCode` is used to resolve certain placeholders.
Placeholders such as `__year__`, `__month__`, `__day__`, `__hour__`, `__minute__`, `__second__` and `__country__`, which are defined in the schema, can have some default values computed when their counterparts are missing in the request body.
The default values are derived from the site. Specifically:
- All date-related placeholders are computed based on the `site.homeBase.timezone` field.
- The country placeholder is replaced with the value of the `site.homeBase.address.country` field.


If these values are missing in a site configuration, the following defaults are used:
- `UTC` for timezone
- `DE` for country

## Updated endpoints

| Endpoint                                                                                                               | Description                   |
|------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| [Creating a nextId](/openapi/sequential-id/#operation/POST-sequential-id-create-nextId)                                | Query param `siteCode` added. |
| [Creating a nextId for schema type](/openapi/sequential-id/#operation/POST-sequential-id-create-schema-type-nextId)    | Query param `siteCode` added. |
| [Creating a nextId for schema types](/openapi/sequential-id/#operation/POST-sequential-id-create-schema-types-nextIds) | Query param `siteCode` added. |

## Known problems

There are no known problems.

---

<Badge
    tag="minor"
    date="2025-03-21"
/>

# Site Settings Service - `timezone` field added

## Overview

The `timezone` field has been added to the `site.homeBase` request and response body. For now, this field is used by the Sequential ID Service to generate fallback values for placeholders such as:
- `__year__`
- `__month__`
- `__day__`
- `__hour__`
- `__minute__`
- `__second__`

## Updated endpoints

| Endpoint                                                                                          | Description                                                 |
|---------------------------------------------------------------------------------------------------|-------------------------------------------------------------|
| [Retrieving sites](/openapi/site-settings/#operation/GET-site-settings-list-site-configurations)  | The `homeBase.timezone` field added to the response body. |
| [Retrieving a site](/openapi/site-settings/#operation/GET-site-settings-retrieve-site-config)     | The `homeBase.timezone` field added to the response body. |
| [Creating a site](/openapi/site-settings/#operation/POST-site-settings-create-site)               | The `homeBase.timezone` field added to the request body.  |
| [Fully updating a site](/openapi/site-settings/#operation/PUT-site-settings-update-site-config)   | The `homeBase.timezone` field added to the request body.  |
| [Partially updating a site](/openapi/site-settings/#operation/PATCH-site-settings-update-site)    | The `homeBase.timezone` field added to the request body.  |

## Known problems

There are no known problems.

---

<Badge
    tag="newFeature"
    date="2025-03-17"
/>

# Order service - new endpoints to fetch orders for a legal entity

## Overview

New endpoints have been introduced to retrieve orders for a legal entity.
These endpoints allow fetching multiple orders or a specific order associated with a legal entity.
The response structure remains identical to the existing order retrieval endpoints for tenants and customer-managed orders.

## New endpoints

| Endpoint                                                                                            | Description                                                                                                                    |
|-----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving legal entity orders](/openapi/order/#operation/GET-order-retrieve-legal-entity-orders)  | Retrieves a list of orders related to a particular legal entity for a customer. To be used by B2B customers on the storefront. |
| [Retrieving legal entity order](/openapi/order/#operation/GET-order-retrieve-legal-entity-order)    | Retrieves an order related to a particular legal entity for a customer. To be used by B2B customers on the storefront.         |

## Known problems

There are no known problems.

---
<Badge
    tag="deprecated"
    date="2025-03-07"
/>

# Order service - calculated prices

## Overview

The Order Service has transitioned to using new calculated price attributes at both order and entry levels. The following changes have been implemented:

* New mandatory attributes: `calculatedPrice` (order level), `calculatedPrice` and `calculatedUnitPrice` (entry level).
* Previously used price attributes (`totalPrice`, `unitPrice`) are now marked as deprecated and optional.
* Backward compatibility is maintained - the API will continue to work if deprecated price attributes are provided without the new calculated price attributes.

These changes streamline price handling while ensuring existing integrations continue to function without disruption.


## Updated endpoints

| Endpoint                                                                                          | Description                                                                                     |
|---------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| [Creating a new order (tenant-managed)](/openapi/order/#operation/POST-order-create-order-employee) | Order level `calculatedPrice` marked as mandatory and `totalPrice` marked as optional.          |
| [Creating a new order (tenant-managed)](/openapi/order/#operation/POST-order-create-order-employee) | Order entry level `calculatedPrice` marked as mandatory and `totalPrice` marked as optional.    |
| [Creating a new order (tenant-managed)](/openapi/order/#operation/POST-order-create-order-employee) | Order entry level `calculatedUnitPrice` marked as mandatory and `unitPrice` marked as optional. |
| [Creating a new order (customer-managed)](/openapi/order/#operation/POST-order-create-order)        | Order level `calculatedPrice` marked as mandatory and `totalPrice` marked as optional.          |
| [Creating a new order (customer-managed)](/openapi/order/#operation/POST-order-create-order)        | Order entry level `calculatedPrice` marked as mandatory and `totalPrice` marked as optional.    |
| [Creating a new order (customer-managed)](/openapi/order/#operation/POST-order-create-order)        | Order entry level `calculatedUnitPrice` marked as mandatory and `unitPrice` marked as optional. |


## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-03-05"
/>

# Order service - Legal Entity information in the order model

## Overview

A new optional `legalEntityId` field has been added to the endpoint.
This field is intended exclusively for B2B cases and specifies the legal entity for which the order was created.

## Updated endpoints

| Endpoint                                                                                            | Description                                     |
|-----------------------------------------------------------------------------------------------------|-------------------------------------------------|
| [Creating a new order](/openapi/order/#operation/POST-order-create-order-employee)                  | New request attribute `legalEntityId` added.  |
| [Updating an order](/openapi/order/#operation/PUT-order-update-order)                               | New request attribute `legalEntityId` added.  |
| [Partially updating an order](/openapi/order/#operation/PATCH-order-partial-update-order)           | New request attribute `legalEntityId` added.  |
| [Retrieving orders](/openapi/order/#operation/GET-order-retrieve-tenant-orders)                     | New response attribute `legalEntityId` added.  |
| [Retrieving a specific order by ID](/openapi/order/#operation/GET-order-retrieve-order-employee)    | New response attribute `legalEntityId` added.  |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-03-05"
/>

# Weight dependent products

## Overview

A new boolean attribute `weightDependent` has been added to the product model. It allows to mark the product as weight-dependent if the line item price can change after packaging. This is necessary to ensure that credit card payments can be authorized.
Having the attribute available directly on the product level, the corresponding attribute `weightDependent` in `Adding a product to cart` API has been deprecated. The cart services checks the value specified on a product model and sets the `weightDependent` value on the cart item.

## Updated endpoints

| Endpoint                                                                                          | Description                                     |
|---------------------------------------------------------------------------------------------------|-------------------------------------------------|
| [Adding a product to cart](/openapi/cart/#operation/POST-cart-add-item-to-cart)                   | Deprecated request attribute `weightDependent`. |
| [Adding multiple products to cart](/openapi/cart/#operation/POST-cart-add-multiple-items-to-cart) | Deprecated request attribute `weightDependent`. |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product)                 | New request attribute `weightDependent` added.  |
| [Creating multiple products](/openapi/product/#operation/POST-product-create-bulk-products)       | New request attribute `weightDependent` added.  |
| [Upserting a product](openapi/product/#operation/PUT-product-update-product)                      | New request attribute `weightDependent` added.   |
| [Upserting multiple products](/openapi/product/#operation/PUT-product-update-bulk-products)       | New request attribute `weightDependent` added.   |
| [Partially updating a product](/openapi/product/#operation/PATCH-product-update-product)          | New request attribute `weightDependent` added.   |
| [Retrieving a product](/openapi/product/#operation/GET-product-retrieve-product)                  | New response attribute `weightDependent` added.  |
| [Retrieving all of products](/openapi/product/#operation/GET-product-list-products)               | New response attribute `weightDependent` added.  |

## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-03-04"
/>

# Important Security Update – Discontinuation of Weak Cipher Support

## Overview
We are committed to ensuring the highest level of security for our API services. As part of this commitment, we are discontinuing support for weak cryptographic ciphers (api.emporix.io).

This update is essential to maintain the security and integrity of the data exchanged between your systems and our API.

<u>**Effective 24th of March, we will no longer support the following cipher suites:**</u>

* TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA

* TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA

These cipher suites rely on older encryption methods that are vulnerable to modern security threats. To ensure the highest level of security and compatibility, we will continue supporting strong ciphers, including TLS 1.2 and TLS 1.3 protocols.

## What do you need to do:
Ensure that your systems and applications are configured to use the following ciphers:

* TLSv1.2:
&emsp;ciphers:
&emsp;&emsp;&emsp;TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519)

* TLSv1.3:
&emsp;ciphers:
&emsp;&emsp;&emsp;TLS_AKE_WITH_AES_128_GCM_SHA256 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_AKE_WITH_AES_256_GCM_SHA384 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_AKE_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519)
---

<Badge
    tag="improvement"
    date="2025-03-04"
/>

# Media Service - support for brands

## Overview

Request body for creating or updating assets has been extended with new reference type - `BRAND` - which should be used to assign media to the brands.

## Updated endpoints

| Endpoint                                                               | Description                                                      |
|------------------------------------------------------------------------|------------------------------------------------------------------|
| [Creating a media](/openapi/media/#operation/POST-media-create-asset)  | Request body's `refIds.type` field has a new enum value - `BRAND`. |
| [Updating a media](/openapi/media/#operation/PUT-media-update-asset)   | Request body's `refIds.type` field has a new enum value - `BRAND`. |

## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-03-04"
/>

# Brand Service - deprecations

## Overview

All deprecations will be removed on 2025-09-01. From now on, use the [media-service endpoints](/openapi/media/#operation/POST-media-create-asset) to manage media for brands.

## Deprecated endpoints

| Endpoint                                                                          | Description                                                               |
|-----------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| [Creating a media](/openapi/brand/#operation/POST-brand-add-media)                | Endpoint will be removed.                                                 |
| [Deleting a media](/openapi/brand/#operation/DELETE-brand-remove-media)           | Endpoint will be removed.                                                 |
| [Creating a brand](/openapi/brand/#operation/POST-brand-create-brand)              | The `image` and `cloudinaryUrl` fields will be removed from request body. |
| [Updating a brand](/openapi/brand/#operation/PUT-brand-update-brand)              | The `image` and `cloudinaryUrl` fields will be removed from request body. |
| [Partially updating a brand](/openapi/brand/#operation/PATCH-brand-update-brand)  | The `image` and `cloudinaryUrl` fields will be removed from request body. |

## Known problems

There are no known problems.

---


<Badge
    tag="minor"
    date="2025-03-04"
/>

# Shopping List Service - `metadata` field changes

## Overview

The `metadata` field at root level is now deprecated in GET responses, as each shopping list now maintains its own independent `metadata` field. This field will be fully removed on September 1st, 2025. Additionally we have added version validation for update operation where you can provide `version` in the update payload to validate it against the current entity version, preventing unintentional overriding when multiple updates occur simultaneously.

## Updated endpoints

| Endpoint                                                                                                                     | Description                                                                                 |
|------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| [Retrieving a shopping list](/openapi/shopping-list/#operation/GET-shopping-list-retrieve-shopping-list)                     | Deprecated `metadata` field on root level and added `metadata` field to each shopping list. |
| [Retrieving a customer shopping list](/openapi/shopping-list/#operation/GET-shopping-list-retrieve-customer-shopping-list)   | Deprecated `metadata` field on root level and added `metadata` field to each shopping list. |
| [Updating a customer shopping list](/openapi/shopping-list/#operation/PUT-shopping-list-update-customer-shopping-list)       | Added `metadata.version` to request payload which allows for version validation             |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-02-26"
/>

# OAuth service - Legal Entity information in the auth token

## Overview

An optional `legalEntityId` query parameter has been introduced to the endpoint.
This is the recommended way to store information about the selected legal entity in the system.
Upon logging in, users should select a legal entity they want to act on behalf of. It invokes the refresh token endpoint with the chosen entity.
If the value is provided in the request, the validation process ensures that the customer is assigned to the specified legal entity.

## Updated endpoints

| Endpoint                                                               | Description                                                      |
|------------------------------------------------------------------------|------------------------------------------------------------------|
| [Refreshing a token](/openapi/oauth/#operation/GET-oauth-refresh-token)  | The endpoint extended with an optional `legalEntityId` query param. |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-02-24"
/>

# Media Service - support for labels

## Overview

Request body for creating or updating assets has been extended with new reference type - `LABEL` - which should be used to assign media to the labels.

## Updated endpoints

| Endpoint                                                               | Description                                                      |
|------------------------------------------------------------------------|------------------------------------------------------------------|
| [Creating a media](/openapi/media/#operation/POST-media-create-asset)  | Request body's `refIds.type` field has a new enum value - `LABEL`. |
| [Updating a media](/openapi/media/#operation/PUT-media-update-asset)   | Request body's `refIds.type` field has a new enum value - `LABEL`. |

## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-02-24"
/>

# Label Service - deprecations

## Overview

All deprecations will be removed on 2025-09-01. From now on, use the [media-service endpoints](/openapi/media/#operation/POST-media-create-asset) to manage media for labels.

## Deprecated endpoints

| Endpoint                                                                          | Description                                                           |
|-----------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [Creating a media](/openapi/label/#operation/POST-label-create-media)             | Endpoint will be removed.                                             |
| [Deleting a media](/openapi/label/#operation/DELETE-label-remove-media)           | Endpoint will be removed.                                             |
| [Creating a label](/openapi/label/#operation/POST-label-create-label)             | The `image` and `cloudinaryUrl` fields will be removed from request body. |
| [Updating a label](/openapi/label/#operation/PUT-label-update-label)              | The `image` and `cloudinaryUrl` fields will be removed from request body. |
| [Partially updating a label](/openapi/label/#operation/PATCH-label-update-label)  | The `image` and `cloudinaryUrl` fields will be removed from request body. |

## Known problems

There are no known problems.

---


<Badge
    tag="improvement"
    date="2025-02-19"
/>

# Customer Segments Service - expanded response for retrieving category trees for a customer segments endpoint

## Overview

From now on, the response of the "Retrieving category trees for a customer segments" endpoint includes new fields: `localizedDescription`, `localizedSlug`, `ecn`, `validity`, `position`, and `published`, which allows fetching complete category tree information in a single request.

## Updated endpoints

| Endpoint                                                                                                                               | Description                                                                                                            |
|----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| [Retrieving category trees for a customer segments](/openapi/customer-segment/#operation/GET-customer-segment-retrieve-category-trees) | Added `localizedDescription`, `localizedSlug`, `ecn`, `validity`, `position`, and `published` fields to the responses. |

## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-02-18"
/>

# Cart Service - deprecated fields

## Overview

Several fields in cart's response have been deprecated and are now replaced by `calculatedPrice` and `unitPrice` fields. The new fields provide a more comprehensive and consistent way to access price calculations.

### Deprecated cart-level fields:
- `totalPrice` - use `calculatedPrice.finalPrice` instead
- `subTotalPrice` - use `calculatedPrice.price` or `calculatedPrice.discountedPrice` instead
- `taxAggregate` - use `calculatedPrice.finalPrice.taxAggregate` instead
- `subtotalAggregate` - use `calculatedPrice.price` instead
- `totalDiscount` - use `calculatedPrice.totalDiscount` instead
- `feeYrnAggregate` - use `calculatedPrice.totalFees` and `items[].calculatedPrice.fees` instead
- `shipping` - use `calculatedPrice.totalShipping` instead
- `itemFeesTotal` - use `calculatedPrice.totalFee` instead
- `paymentFeesTotal` - use `calculatedPrice.paymentFees` instead
- `totalAuthorizedAmount` - use `calculatedPrice.upliftValue` instead

### Deprecated cart item-level fields:
- `price` - use `unitPrice` instead
- `itemPrice` - use `unitPrice` instead
- `itemTaxInfo` - use `calculatedPrice.price` instead
- `fees` - use `calculatedPrice.fees` instead
- `authorizedAmount` - use `calculatedPrice.upliftValue` instead
- `totalDiscount` - use `calculatedPrice.totalDiscount` instead
- `externalFees` - use `calculatedPrice.fees` instead
- `couponDiscounts` - use `calculatedPrice.totalDiscounts.appliedDiscounts` instead

## Updated endpoints

| Endpoint                                                                                               | Description                                                              |
|--------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| [Retrieving cart details by ID](/openapi/cart/#operation/GET-cart-retrieve-cart-by-cartId)         | Deprecated response fields are replaced by `calculatedPrice` and `unitPrice`. |
| [Retrieving cart details by criteria](/openapi/cart/#operation/GET-cart-retrieve-cart-by-criteria) | Deprecated response fields are replaced by `calculatedPrice` and `unitPrice`. |
| [Retrieving all products added to a cart](/openapi/cart/#operation/GET-cart-list-cart-items)           | Deprecated response fields are replaced by `calculatedPrice` and `unitPrice`. |

## Known problems

There are no known problems.

<Badge
    tag="deprecated"
    date="2025-02-18"
/>

# Cart Service - deprecated field

## Overview

When applying discount on a cart, the request allows to specify `calculationType` with following values: `ApplyDiscountBeforeTax`, `ApplyDiscountAfterTax`
The field has been deprecated, cart's calculatedPrice relays on site's configuration `includesTax` which defines whether the discount should be applied on net or gross prices.

## Updated endpoints

| Endpoint                                                                         | Description                                    |
|----------------------------------------------------------------------------------|------------------------------------------------|
| [Applying a discount to cart](/openapi/cart/#operation/POST-cart-apply-discount) | Deprecated request attribute `calculationType` |

## Known problems

There are no known problems.
---

<Badge
    tag="improvement"
    date="2025-02-18"
/>

# Fee management - new validation added

## Overview

A validation rule ensures fee data consistency by requiring a `taxCode` when creating or updating fees with `taxable=true`. This enforces the logical dependency between taxation status and tax code identification.

## Updated endpoints

| Endpoint                                                             | Description                                                     |
|----------------------------------------------------------------------|-----------------------------------------------------------------|
| [Creating fee](/openapi/fee/#operation/POST-fee-create-fee)          | Added validation of `taxCode` fee is marked with `taxable=true` |
| [Retrieving fee by id](/openapi/fee/#operation/GET-fee-retrieve-fee) | Added validation of `taxCode` fee is marked with `taxable=true` |

## Known problems

There are no known problems.
---

<Badge
    tag="improvement"
    date="2025-02-18"
/>

# Site Settings - new field

## Overview

A new `cartCalculationScale` field has been added to the site setting. The field allows to control the number of decimal points in cart's calculatedPrice attributes.

## Updated endpoints

| Endpoint                                                                                        | Description                                          |
|-------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Creating a site](/openapi/site-settings/#operation/POST-site-settings-create-site)             | Added `cartCalculationScale` field to the request.   |
| [Fully updating a site](/openapi/site-settings/#operation/PUT-site-settings-update-site-config) | Added `cartCalculationScale` field to the request.   |
| [Partially updating a site](/openapi/site-settings/#operation/PATCH-site-settings-update-site)  | Added `cartCalculationScale` field to the request.   |
| [Retrieving a site](/openapi/site-settings/#operation/GET-site-settings-retrieve-site-config)   | Added `cartCalculationScale` field to the responses. |

## Known problems

There are no known problems.
---

<Badge
    tag="improvement"
    date="2025-02-14"
/>

# Customer Service - new field

## Overview

A new `lastLogin` field has been added to the customer response, returning a date-time string. If the value is null, it indicates that the customer has not logged in since the field was introduced (14-02-2025).

## Updated endpoints

| Endpoint | Description |
|----------|-------------|
| [Retrieving a customer's profile](/openapi/customer-customer/#operation/GET-customer-retrieve-customer-profile) | Added `lastLogin` field to the responses. |
| [Retrieving a customer profile](/openapi/customer-tenant/#operation/GET-customer-tenant-retrieve-customer) | Added `lastLogin` field to the responses. |
| [Retrieving a list of customers](/openapi/customer-tenant/#operation/GET-customer-tenant-list-customers) | Added `lastLogin` field to the responses. |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-02-05"
/>

# Cart Service - enhanced price calculation details

## Overview

The Cart Service now provides detailed price calculation information through the `calculatedPrice` field. This enhancement gives a comprehensive breakdown of prices including net values, gross values, tax details, fees, and discounts for both the entire cart and individual line items.

## Updated endpoints

| Endpoint | Description |
|----------|-------------|
| [Retrieving cart details by criteria](/openapi/cart/#operation/GET-cart-retrieve-cart-by-criteria) | Added `calculatedPrice` field to cart and cart items responses. |
| [Retrieving cart details by ID](/openapi/cart/#operation/GET-cart-retrieve-cart-by-cartId) | Added `calculatedPrice` field to cart and cart items responses. |
| [Retrieving all products added to a cart](/openapi/cart/#operation/GET-cart-list-cart-items) | Added `calculatedPrice` field to cart items responses. |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-02-05"
/>

# Order Service - enhanced price calculation details

## Overview

The Order Service now provides detailed price calculation information through the `calculatedPrice` field. This enhancement gives a comprehensive breakdown of prices including net values, gross values, tax details, fees, and discounts for both the entire order and individual line items.

## Updated endpoints

| Endpoint | Description |
|----------|-------------|
| [Creating a new order as employee](/openapi/order/#operation/POST-order-create-order-employee) | Added `calculatedPrice` field to order and order entries. |
| [Creating a new order as customer](/openapi/order/#operation/POST-order-create-order) | Added `calculatedPrice` field to order and order entries. |
| [Retrieving order details](/openapi/order/#operation/GET-order-retrieve-order-storefront) | Added `calculatedPrice` field to order and order entries responses. |
| [Retrieving a specific order by ID](/openapi/order/#operation/GET-order-retrieve-order-employee) | Added `calculatedPrice` field to order and order entries responses. |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-01-30"
/>

# Order Service - new `priceListId` field

## Overview

The `priceListId` field  has been added to the create order endpoint.

## Updated endpoints

| Endpoint                                                                 | Description                                                    |
| ----------------------------------------------------------------------   | ---------------------------------------------------------------|
| [Creating a new order](/openapi/order/#operation/POST-order-create-order-employee) | Added a new `priceListId` field to the request body.                                     |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-01-30"
/>

# Cart Service - new `priceListId` field added.

## Overview

The `priceListId` field  has been added to the get a cart endpoint. The field is populated only in the case when a returned price belongs to any price list. Otherwise the field is not returned.

## Updated endpoints

| Endpoint                                                                 | Description                                                    |
| ----------------------------------------------------------------------   | ---------------------------------------------------------------|
| [Retrieving cart details by ID](/openapi/cart/#operation/GET-cart-retrieve-cart-by-cartId) | Added a new `priceListId` (items.price.priceListId) field to the response.                                     |

## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-01-29"
/>

# Price Match - new `priceListId` field added.

## Overview

The `priceListId` field  has been added to the price match endpoints. The field is populated only in the case when a returned prices belongs to any price list. Otherwise the field is not returned.

## Updated endpoints

| Endpoint                                                                 | Description                                                    |
| ----------------------------------------------------------------------   | ---------------------------------------------------------------|
| [Matching price for a specific attributes](/openapi/price/#operation/POST-price-match-prices) | Added a new `priceListId` field to the response.                                     |
| [Matching price for session context](/openapi/price/#operation/POST-price-match-prices-by-context)  | Added a new `priceListId` field to the response. |


## Known problems

There are no known problems.

---

<Badge
    tag="improvement"
    date="2025-01-24"
/>

# Algolia - added information about segments

## Overview

The indexed products have a new field - `segment_ids` - which informs to which segments the given product is assigned.

## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-01-13"
/>

# Availability Service - availability endpoints replacement

## Overview

The availability endpoints that accept `site` as a query parameter, are now deprecated. They have been replaced with new endpoints that use `site` as a path parameter.

## New endpoints

| Endpoint                                                                                                                           | Description                                                                   |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| [Retrieving a products availability](/openapi/availability/#operation/GET-availability-retrieve-product)                           | New endpoint that takes `site` as a path parameter is now available.           |
| [Creating a new availability for a product](/openapi/availability/#operation/POST-availability-add-product)                        | New endpoint that takes `site` as a path parameter is now available.           |
| [Upserting availability information of a product](/openapi/availability/#operation/PUT-availability-update-product)                | New endpoint that takes `site` as a path parameter is now available.           |
| [Deleting availability information of a product](/openapi/availability/#operation/DELETE-availability-remove-product)              | New endpoint that takes `site` as a path parameter is now available.          |
| [Retrieving all availability information for a site](/openapi/availability/#operation/GET-availability-retrieve-availability-site) | New endpoint that takes `site` as a path parameter is now available.           |
| [Retrieving product availabilities for a site](/openapi/availability/#operation/POST-availability-search-products-site)            | New endpoint that takes `site` as an optional query parameter is now available.|

## Deprecated endpoints

| Endpoint                                                                                                                           | Description                                                                  |
| ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Retrieving a products availability](/openapi/availability/#operation/GET-availability-retrieve-product)                           | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Creating a new availability for a product](/openapi/availability/#operation/POST-availability-add-product)                        | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Upserting availability information of a product](/openapi/availability/#operation/PUT-availability-update-product)                | Endpoint that takes `site` as a query parameter is now deprecated.            |
| [Deleting availability information of a product](/openapi/availability/#operation/DELETE-availability-remove-product)              | Endpoint that takes `site` as a query parameter is now deprecated.           |
| [Retrieving all availability information for a site](/openapi/availability/#operation/GET-availability-retrieve-availability-site) | Endpoint that takes `site` as a query parameter is now deprecated.           |
| [Retrieving product availabilities for a site](/openapi/availability/#operation/POST-availability-search-products-site)            | Endpoint that takes `site` as a mandatory query parameter is now deprecated.  |


## Known problems

There are no known problems.

---

<Badge
    tag="deprecated"
    date="2025-02-18"
/>

# Order Service - deprecated fields

## Overview

Several fields in order's response have been deprecated in favor of new `calculatedPrice` and `unitPrice` fields. The new fields provide a more comprehensive and consistent way to access price calculations.

### Deprecated order-level fields:
- `totalPrice` - use `calculatedPrice.finalPrice` instead
- `subTotalPrice` - use `calculatedPrice.price` or `calculatedPrice.discountedPrice` instead
- `taxAggregate` - use `calculatedPrice.finalPrice.taxAggregate` instead
- `subtotalAggregate` - use `calculatedPrice.price` instead
- `totalDiscount` - use `calculatedPrice.totalDiscount` instead
- `feeYrnAggregate` - use `calculatedPrice.totalFees` and `items[].calculatedPrice.fees` instead
- `shipping` - use `calculatedPrice.totalShipping` instead
- `itemFeesTotal` - use `calculatedPrice.totalFee` instead
- `paymentFeesTotal` - use `calculatedPrice.paymentFees` instead
- `totalAuthorizedAmount` - use `calculatedPrice.upliftValue` instead

### Deprecated order item-level fields:
- `price` - use `unitPrice` instead
- `itemPrice` - use `unitPrice` instead
- `itemTaxInfo` - use `calculatedPrice.price` instead
- `fees` - use `calculatedPrice.fees` instead
- `authorizedAmount` - use `calculatedPrice.upliftValue` instead
- `totalDiscount` - use `calculatedPrice.totalDiscount` instead
- `externalFees` - use `calculatedPrice.fees` instead
- `couponDiscounts` - use `calculatedPrice.totalDiscounts.appliedDiscounts` instead

## Updated endpoints

| Endpoint                                                                                               | Description                                                              |
|--------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| [Creating a new order as employee](/openapi/order/#operation/POST-order-create-order-employee)         | Deprecated response fields in favor of `calculatedPrice` and `unitPrice` |
| [Creating a new order as customer](/openapi/order/#operation/POST-order-create-order)                 | Deprecated response fields in favor of `calculatedPrice` and `unitPrice` |
| [Retrieving order details](/openapi/order/#operation/GET-order-retrieve-order-storefront)             | Deprecated response fields in favor of `calculatedPrice` and `unitPrice` |
| [Retrieving a specific order by ID](/openapi/order/#operation/GET-order-retrieve-order-employee)      | Deprecated response fields in favor of `calculatedPrice` and `unitPrice` |

## Known problems

There are no known problems.

---

