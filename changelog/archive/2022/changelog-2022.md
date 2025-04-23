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
    visible: true
  pagination:
    visible: true
---

# 2022 Changelog

<Badge
tag="newFeature"
label="In progress"
date="2022-12-15"
/>

# 2022-12-15: Media Service - public and private assets

**Overview**

The media assets functionality makes it possible to manage public and private assets.

**New endpoints**

| Endpoint                                                               | Description                      |
| ---------------------------------------------------------------------- | -------------------------------- |
| [Creating a new asset](/openapi/media/#operation/POST-media-create-asset)         | It creates a new media asset.       |
| [Updating an existing asset](/openapi/media/#operation/PUT-media-update-asset)        | It updates an existing media asset. |
| [Deleting an existing asset](/openapi/media/#operation/DELETE-media-remove-asset)     | It deletes an existing media asset. |
| [Getting list of asset entities](/openapi/media/#operation/GET-media-list-assets) | It gets a list of media assets.     |
| [Getting single asset entity](/openapi/media/#operation/GET-media-retrieve-asset)         | It gets a single media asset.       |
| [Downloading an asset](/openapi/media/#operation/GET-media-download-asset)          | It downloads a single media asset.  |

**Known problems**

When particular endpoints become available, they will be announced in the [Release Notes](https://developer.emporix.io/releases?tag=all).

---

<Badge
tag="minor"
date="2022-12-13"
/>

# 2022-12-13: Order Service - new recalculate parameter

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Order Service API has been enhanced with the possibility of recalculating all entries from the order. Users are now able to recalculate prices and coupons of entries.

**Updated endpoints**

| Endpoint                                                                                 | Description                                                                                                                                                                                          |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Updating an order](/openapi/order/#operation/PUT-order-update-order)            | This parameter allows for recalculation of all entries from the order. If set to `true`, the prices and coupons of the entries are recalculated. By default, the `recalculate` parameter is set to `false`. |
| [Partially updating an order](/openapi/order/#operation/PATCH-order-partial-update-order) | This parameter allows for recalculation of all entries from the order. If set to `true`, the prices and coupons of the entries are recalculated. By default, the `recalculate` parameter is set to `false`. |

**Known problems**

There are no known problems.

---

<Badge
tag="major"
date="2022-12-12"
/>

# 2022-12-12: Price Service - custom ID support

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Price Service API has been enhanced with the possibility of specifying custom IDs for prices. Users are now able to specify price IDs during price creation. In this case, the IDs are no longer generated automatically.

**Updated endpoints**

| Endpoint | Description |
| --- | --- |
|[Creating a new price model](/openapi/price/#operation/POST-price-create-model)| It creates a new price model.|
|[Creating a new price](/openapi/price/#operation/POST-price-create-price)| It creates a new price.|
|[Creating new prices in bulk](/openapi/price/#operation/POST-price-create-multiple-prices)| It creates new prices in bulk.|
|[Creating a new price list](/openapi/price/#operation/POST-price-create-price-list)| It creates a new price list.|
|[Creating a new price list price](/openapi/price/#operation/POST-price-create-price-in-price-list)| It creates a new price list price.|
|[Creating new price list prices in bulk](/openapi/price/#operation/POST-price-create-multiple-prices-for-price-list)| It creates new price list prices in bulk.|

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2022-11-30"
/>

# 2022-11-30: Session Context Service - session context

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Session Context Service provides the ability to manage a customer's browser session context, enabling the application of contextual pricing based on the user's session.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Retrieving a session context](/openapi/session-context/#operation/GET-session-context-retrieve-session-context)| It retrieves a session context. |
| [Updating a session context](/openapi/session-context/#operation/PUT-session-context-update-session-context) | It updates a session context. |
| [Adding a new attribute to a session context](/openapi/session-context/#operation/POST-session-context-add-attribute-sessionId) | It adds a new attribute to session context. |
| [Deleting an attribute from a session context](/openapi/session-context/#operation/DELETE-session-context-remove-attribute) | It deletes an attribute from a session context. |
| [Retrieving own session context](/openapi/session-context/#operation/GET-session-context-retrieve-session-context-by-sessionId) | It retrieves own session context. |
| [Partially updating own session context](/openapi/session-context/#operation/PATCH-session-context-update-attribute-sessionId-storefront) | It updates own session context. |
| [Adding a new attribute to own session context](/openapi/session-context/#operation/POST-session-context-add-attribute-sessionId) | It adds a new attribute to own session context. |
| [Deleting an attribute from own session context](/openapi/session-context/#operation/DELETE-session-context-remove-attribute-sessionId) | It deletes an attribute from own session context. |

---

<Badge
tag="newFeature"
label="In progress"
date="2022-11-17"
/>

# 2022-11-17: Returns Service - returns lifecycle

**Overview**

The order return functionality makes it possible to manage a lifecycle of an order return. A return can be managed by a customer or by an employee (on behalf of a customer).

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Creating a new return entity](/openapi/returns/#operation/POST-returns-create-return)| It creates a new order return. |
| [Updating an existing return entity](/openapi/returns/#operation/PUT-returns-update-return) | It updates an existing order return. |
| [Deleting an existing return entity](/openapi/returns/#operation/DELETE-returns-remove-return) | It deletes an existing order return. |
| [Getting list of return entities](/openapi/returns/#operation/GET-returns-list-returns) | It gets a list of order returns. |
| [Getting single return entities](/openapi/returns/#operation/GET-returns-retrieve-return) | It gets a single order return. |

**Known problems**

When particular endpoints become available, they will be announced in the [*Release Notes*](https://developer.emporix.io/releases?tag=all).

---

<Badge
tag="major"
date="2022-11-09"
/>

# 2022-11-09: Brands Service - localization and filtering

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The names and descriptions of brands present in the system can now be localized.

The `q` param notation was introduced to the `Retrieving all brands` endpoint, so it is now possible to filter the results by every field.

{% hint style="info" %}

For more detailed information, check out the API Reference documentation for the
[Retrieving all brands](/openapi/brand/#operation/GET-brand-list-brands) endpoint.

{% endhint %}

**Updated endpoints**

| Endpoint                                                                                             | Description                                                                                                                                                    |
|------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving all brands](/openapi/brand/#operation/GET-brand-list-brands)                                        | The response body contains two new fields `localizedName` and `localizedDescription`. Filtering is now supported using the `q` query parameter. |
| [Adding a new brand](/openapi/brand/#operation/POST-brand-create-brand)                                          | The response body contains two new optional fields — `localizedName` and `localizedDescription`.                                                        |
| [Retrieving a brand](/openapi/brand/#operation/GET-brand-retrieve-brand)                                   | The response body contains two new fields `localizedName` and `localizedDescription`.                                                                |
| [Updating a brand](/openapi/brand/#operation/PUT-brand-update-brand)                                     | The response body contains two new optional fields `localizedName` and `localizedDescription`.                                                        |

---

<Badge
tag="major"
date="2022-11-08"
/>

# 2022-11-08: Product Service - product bundles

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The product variants functionality makes it possible to create many variants of a product based on variant attributes.

The original product model is now extended with two optional fields:

* `variantAttributes` — can only be set to a product of the `PARENT_VARIANT` type. It defines the combination of variants to be created.
* `parentVariantId` — can only be set to a product of the  `VARIANT` type. It indicates the id of the `PARENT_VARIANT` product.

The `productType` field can be set to the following new values:

* `productType` — can be set to either `BASIC`, `BUNDLE`, `PARENT_VARIANT` or`VARIANT`. The productType value is immutable - once set, it
  cannot be changed during the product update.

**New endpoints**

No new endpoints have been introduced.

**Updated endpoints**

| Endpoint                                                                                              | Description |
|-------------------------------------------------------------------------------------------------------| --- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product)                            | The request body schema contains two new fields `variantAttributes` and `parentVariantId`. |
| [Retrieving a product's details](/openapi/product/#operation/GET-product-retrieve-product)           | The request body schema contains two new fields `variantAttributes` and `parentVariantId`. |
| [Retrieving a list of products](/openapi/product/#operation/GET-product-list-products)                      | The request body schema contains two new fields `variantAttributes` and `parentVariantId`. |
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product)             | The request body schema contains one new field `variantAttributes`. |
| [Partially updating a product's details](/openapi/product/#operation/PATCH-product-update-product) | The request body schema contains one new optional field `variantAttributes`. |

---

<Badge
tag="major"
date="2022-10-04"
/>

# 2022-10-04: Webhooks Service - subscription to events

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The webhooks functionality makes it possible to subscribe to events that are broadcast by the Emporix e-commerce system.

**New endpoints**

| Endpoint                                                                                                  | Description                                                                                                                                              |
| --------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving all subscriptions](/openapi/webhook/#operation/GET-webhook-list-all-event-subscriptions)                | It retrieves all events with associated subscription details.                                                                                               |
| [Subscribing and unsubscribing from events](/openapi/webhook/#operation/PATCH-webhook-manage-event-subscriptions) | It updates the subscriptions list by either subscribing or unsubscribing from specified events.                                                             |
| [Retrieving a dashboard access URL](/openapi/webhook/#operation/GET-webhook-access-tenant-svix)              | It retrieves a Svix magic login link (authentication embedded) and an authentication token needed to connect a tenant to their consumer application portal. |
| [Retrieving webhook statistics](/openapi/webhook/#operation/GET-webhook-retrieve-statistics)                        | It retrieves statistics on the number of emitted events and provides information on the limit of webhook notifications configured for a specific tenant.    |

---

<Badge
tag="major"
date="2022-09-23"
/>

# 2022-09-23: Product Service - product accessories / consumables

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The product accessories / consumables functionality makes it possible to define information about related items, like accessories.


The original product model is now extended with an optional field:

* `relatedItems` — array of `relatedItem` objects.


The `relatedItem` object consists of the following mandatory fields:

* `refId` — identifier of a product that is related to the main product. The product identifier has to exist.
* `type` — relation type. The type has to exist in the system. All relation types are defined in configuration service under the `relation_types` key. There are two relation types available out of the box: `ACCESSORY` and `CONSUMABLE`.

**New endpoints**

No new endpoints have been introduced.

**Updated endpoints**

| Endpoint | Description |
|---| --- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product) | The request body schema contains a new optional field `relatedItems`. |
| [Retrieving a product's details](/openapi/product/#operation/GET-product-retrieve-product) | The request body schema contains a new optional field `relatedItems`. |
| [Retrieving a list of products](/openapi/product/#operation/GET-product-list-products) | The request body schema contains a new optional field `relatedItems`. |
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product) | The request body schema contains a new optional field `relatedItems`. |

---

<Badge
tag="major"
date="2022-09-19"
/>

# 2022-09-19: Product Service - product bundles

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The product bundles functionality makes it possible to create products that consist of other products.

The original product model is now extended with two optional fields:

* `productType` — can be set to either `BASIC` or `BUNDLE`. The productType value is immutable - once set, it cannot be changed during product update.
* `bundledProducts` — a list containing IDs of products that are included in the bundle.

**New endpoints**

No new endpoints have been introduced.

**Updated endpoints**

| Endpoint | Description |
|---| --- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product) | The request body schema contains two optional fields `productType` and `bundledProducts`. |
| [Retrieving a product's details](/openapi/product/#operation/GET-product-retrieve-product) | The request body schema contains two optional fields `productType` and `bundledProducts`.  |
| [Retrieving a list of products](/openapi/product/#operation/GET-product-list-products) | The request body schema contains two optional fields `productType` and `bundledProducts`. |
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product) | The request body schema contains one optional field `bundledProducts`. |

---

<Badge
tag="major"
date="2022-09-19"
/>

# 2022-09-19: Order Service - PDF-mashup for product bundles

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The `pdf-mashup` service allows you to define product bundles in a new way. When the `product` is of the BUNDLE type (`productType: BUNDLE`)
and contains products' ids in the `bundledProducts` fields, the `pdf-mashup` service generates the packlist.pdf and picklist.pdf files that
list all products constituting the bundle.

To support this feature, the `Order Service` has been extended with the `order.entries.product` model by introducing two new fields:

* `productType` — provides information about the product's type. Possible values: `BASIC`, `BUNDLE`, `PARENT_VARIANT`, `VARIANT`.
* `bundledProducts` — lists the `productId` and `amount` pairs that contain information about products assigned to a given bundle.

**New endpoints**

No new endpoints have been introduced.

**Updated endpoints**

| Endpoint                                                                                                 | Description                                                                                                                                   |
| -------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving details about an order (by a customer)](/openapi/order/#operation/GET-order-retrieve-order-storefront) | The response body schema of the `order.entries.product` model contains two optional fields `productType` and `bundledProducts`. |
| [Retrieving a list of orders (for customer)](/openapi/order/#operation/GET-order-list-orders)                | The response body schema of the `order.entries.product` model contains two optional fields `productType` and `bundledProducts`. |
| [Creating new order (by a merchant)](/openapi/order/#operation/POST-order-create-order-employee)                  | The request body schema of the `order.entries.product` model contains two optional fields `productType` and `bundledProducts`.  |
| [Updating order (by a merchant)](/openapi/order/#operation/PUT-order-update-order)               | The request body schema of the `order.entries.product` model contains two optional fields `productType` and `bundledProducts`.  |

---

<Badge
tag="major"
date="2022-09-15"
/>

# 2022-09-15: Product Service - product templates

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The product template functionality makes it possible to define a set of attributes that are common for all product instances based on a particular product template.

**New endpoints**

| Endpoint                                                                                 | Description                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Creating a new product template](/openapi/product/#operation/POST-product-create-template)   | It creates a new product template.                                                                                                                                                                                                                                                                                                                                                       |
| [Getting a product template](/openapi/product/#operation/PUT-product-update-template)           | It retrieves a single product template.                                                                                                                                                                                                                                                                                                                                                  |
| [Getting a list of product templates](/openapi/product/#operation/GET-product-list-templates) | It retrieves a list of product templates.                                                                                                                                                                                                                                                                                                                                                |
| [Updating a product template](/openapi/product/#operation/PUT-product-update-template)       | It updates an existing product template. Each update creates a new version of the template. Products based on earlier versions of the template are not updated automatically. In order to see the changes (such as new attributes) on the product level, you need to update the product template's `version` in a relevant `Product` object.|
| [Deleting a product template](/openapi/product/#operation/DELETE-product-remove-template)       | It deletes a product template. All products based on a deleted template will be unassigned from the template, but not deleted in a cascade way.                                                                                                                                                                                             |

**Updated endpoints**

| Endpoint                                                                                 | Description                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|
| [Retrieving a product's details](/openapi/product/#operation/GET-product-retrieve-product) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|
| [Retrieving a list of products](/openapi/product/#operation/GET-product-list-products) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|

---

<Badge
tag="newFeature"
label="In progress"
date="2022-09-13"
/>

# 2022-09-13: Product Service - product accessories / consumables

**Overview**

The product accessories / consumables functionality makes it possible to define information about related items, like accessories.

The original product model is now extended with an optional field:

* `relatedItems` — array of `relatedItem` objects.

The `relatedItem` object consists of the following mandatory fields:

* `refId` — identifier of a product that is related to the main product. The product identifier has to exist.
* `type` — relation type. The type has to exist in the system. All relation types are defined in configuration service under the `relation_types` key. There are two relation types available out of the box: `ACCESSORY` and `CONSUMABLE`.

**New endpoints**

No new endpoints have been introduced.

**Updated endpoints**

| Endpoint                                                                                    | Description                                                                         |
| ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product)                  | The request body schema contains a new optional field `relatedItems`. |
| [Retrieving a product's details](/openapi/product/#operation/GET-product-retrieve-product) | The request body schema contains a new optional field `relatedItems`. |
| [Retrieving a list of products](/openapi/product/#operation/GET-product-list-products)            | The request body schema contains a new optional field `relatedItems`. |
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product)   | The request body schema contains a new optional field `relatedItems`. |

**Known problems**

When particular endpoints become available, they will be announced in [Release Notes](/releases?tag=all).

---

<Badge
tag="newFeature"
label="In progress"
date="2022-09-06"
/>

# 2022-09-06: Customer Management Service - business customers

**Overview**

The customer management functionality makes it possible to manage information about your business customers.

**New endpoints**

| Endpoint| Description |
| --- | --- |
| [Legal entities management](/openapi/customer-management/#operation/Legal-Entities) | CRUD[^1] operations for managing legal entities. A legal entity is a representation of a company or its subsidiary. |
| [Location management](/openapi/customer-management/#operation/Locations) | CRUD operations for managing locations. A location is a physical address where a company operates, such as its headquarters, office, or warehouse. |
| [Contact management](/openapi/customer-management/#operation/Contacts) | CRUD operations for contact management. A contact is an employee of one or more legal entities who can be contacted regarding business matters. |
| [Contact assignments](/openapi/customer-management/#operation/Contact-Assignments) | CRUD operations for assignments of contacts to legal entities. A contact can be assigned to a company or a subsidiary. |

[^1]: CRUD — create, read, update, delete.

**Known problems**

When particular endpoints become available, they will be announced in [Release Notes](https://developer.emporix.io/releases?tag=all).

---

<Badge
tag="minor"
date="2022-08-26"
/>

# 2022-08-26: Product Service - improvements

The following changes have been introduced to the Emporix Product Service:

| Endpoint | Description |
| --- | --- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product) | <ul> <li>Localized fields have been introduced.</li><li> The `Content-Language` header has been introduced. It can be set to one of the following values:</li><ul><li>`*` — localized fields should provided in the form of a map, where each key is a language code (compliant with the ISO 639-1 standard) and each value represents a translation in the specified language.</li><li>`en` — localized fields should be provided in the form of strings, where values represent translations in the specified language.</li> <li>` ` — when the value is empty or the header is not specified, localized fields should be provided in the form of strings, where values represent translations in the tenant's default language.</li> </ul></ul> |
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product) | <ul><li>In case of a successful product update, a `204` status code is now returned. Before the changes, the status code was `200`.</li><li>Optimistic locking has been introduced. The `metadata.version` field is required during update.</li></ul> |
| [Deleting a product](/openapi/product/#operation/DELETE-product-remove-product) | The `204` status code is now returned in two cases: <ul><li>A successful product removal.</li> <li>Removal of a product that does not exist.</li></ul> |

---

<Badge
tag="newFeature"
label="In progress"
date="2022-08-05"
/>

# 2022-08-05: Webhooks Service - subscription to events

**Overview**

The webhooks functionality makes it possible to subscribe to events that are broadcast by the Emporix e-commerce system.

**New endpoints**

| Endpoint                                                                                                  | Description                                                                                                                                              |
| --------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving all subscriptions](/openapi/webhook/#operation/GET-webhook-list-all-event-subscriptions)                | It retrieves all events with associated subscription details.                                                                                               |
| [Subscribing and unsubscribing from events](/openapi/webhook/#operation/PATCH-webhook-manage-event-subscriptions) | It updates the subscriptions list by either subscribing or unsubscribing from specified events.                                                             |
| [Retrieving a dashboard access URL](/openapi/webhook/#operation/GET-webhook-access-tenant-svix)              | It retrieves a Svix magic login link (authentication embedded) and an authentication token needed to connect a tenant to their consumer application portal. |

**Known problems**

When particular endpoints become available, they will be announced in [Release Notes](https://developer.emporix.io/releases?tag=all).

---

<Badge tag="deprecated" date="2022-08-02" />

# 2022-08-02: Product Service - removal of a deprecated endpoint

Deprecated endpoint for deleting all products assigned to the tenant has been removed from the Emporix API Product Service Reference.

**Removed endpoints**

| Endpoint                                                                    | Description                                  |
| --------------------------------------------------------------------------- | -------------------------------------------- |
| [Deleting all products](/openapi/product/#operation/DELETE_tenant-products) | It deletes all products assigned to the tenant. |

---

<Badge tag="newFeature" date="2022-07-28" />

# 2022-07-28: Product Service - product bundles

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

The product bundles functionality makes it possible to create products that consist of other products.

The original product model is now extended with two optional fields:

* `productType` — can be set to either `BASIC` or `BUNDLE`. The productType value is immutable - once set, it cannot be changed during product update.
* `bundledProducts` — a list containing IDs of products that are included in the bundle.

**New endpoints**

No new endpoints have been introduced.

**Updated endpoints**

| Endpoint                                                                                    | Description                                                                                             |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product)                  | The request body schema contains two optional fields `productType` and `bundledProducts`. |
| [Retrieving a product's details](/openapi/product/#operation/GET-product-retrieve-product) | The request body schema contains two optional fields `productType` and `bundledProducts`. |
| [Retrieving a list of products](/openapi/product/#operation/GET-product-list-products)            | The request body schema contains two optional fields `productType` and `bundledProducts`. |
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product)   | The request body schema contains one optional field `bundledProducts`.                     |

**Known problems**

The product bundles functionality is in preview mode, which means the new endpoints may not be fully operational yet. When particular endpoints become available, they will be announced in [Release Notes](https://developer.emporix.io/releases?tag=all).

---

<Badge tag="newFeature" label="In progress" date="2022-07-27" />


# 2022-07-27: Product Service - product templates

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

The product template functionality makes it possible to define a set of attributes that are common for all product instances based on a particular product template.

**New endpoints**

| Endpoint                                                                                 | Description                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Creating a new product template](/openapi/product/#operation/POST-product-create-template)   | It creates a new product template.                                                                                                                                                                                                                                                                                                                                                       |
| [Getting a product template](/openapi/product/#operation/PUT-product-update-template)           | It retrieves a single product template.                                                                                                                                                                                                                                                                                                                                                  |
| [Getting a list of product templates](/openapi/product/#operation/GET-product-list-templates) | It retrieves a list of product templates.                                                                                                                                                                                                                                                                                                                                                |
| [Updating a product template](/openapi/product/#operation/PUT-product-update-template)       | It updates an existing product template. Each update creates a new version of the template. Products based on earlier versions of the template are not updated automatically. In order to see the changes (such as new attributes) on the product level, you need to update the product template's `version` in a relevant `Product` object.|
| [Deleting a product template](/openapi/product/#operation/DELETE-product-remove-template)       | It deletes a product template. All products based on a deleted template will be unassigned from the template, but not deleted in a cascade way.                                                                                                                                                                                             |

**Updated endpoints**

| Endpoint                                                                                 | Description                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Creating a new product](/openapi/product/#operation/POST-product-create-product) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|
| [Retrieving a product's details](/openapi/product/#operation/GET-product-retrieve-product) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|
| [Retrieving a list of products](/openapi/product/#operation/GET-product-list-products) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|
| [Upserting a product](/openapi/product/#operation/PUT-product-update-product) | The request body schema contains a new optional field called `template`. The `template` field consists of two fields: `id` and `version`.|


**Known problems**

The product templates functionality is in preview mode, which means the new endpoints may not be fully operational yet. When particular endpoints become available, they will be announced in [Release Notes](https://developer.emporix.io/releases?tag=all).
