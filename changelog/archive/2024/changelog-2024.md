---
icon: folder-open
layout:
<<<<<<< HEAD
  width: wide
=======
>>>>>>> parent of 31b07a6 (changelog width)
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

<Badge tag="newFeature"
date="2024-12-19"
/>

# 2024-12-19: Customer Segment Service - new endpoint for checking match criteria

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

We extended the service with a new endpoint for checking which items match specified criteria. This endpoint allows you to specify IDs of products and IDs of segments to check which of the products are assigned to any of the provided segments. The response includes the IDs of products that belong to one of the provided segments (directly or indirectly through a category).

**Added endpoints**

| Endpoint                                                                                                      | Description                             |
| ------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| [Checking which items match criteria](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments-match) | Checking which items belong to segment. |


**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-19"
/>

# 2024-12-19: Cart Service - added information about legalEntity

**Overview**

The request and response bodies of endpoints for managing carts were extended with `legalEntityId` field.

**Updated endpoints**

| Endpoint                                                                                               | Description                                          |
| ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------- |
| [Creating a new cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts)                                  | The request body has a new field - `legalEntityId`.  |
| [Updating a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid)                                       | The request body has a new field - `legalEntityId`.  |
| [Retrieving a cart's details by criteria](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts) | The response body has a new field - `legalEntityId`. |
| [Retrieving a cart's details by ID](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)         | The response body has a new field - `legalEntityId`. |



**Known problems**

There are no known problems.

---

<Badge tag="newFeature"
date="2024-12-19"
/>

# 2024-12-19: Customer Segment Service - endpoints for retrieving items assignments

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

We added new API for retrieving items assignments and category trees of category assignments.

**Added endpoints**

| Endpoint                                                                                                                                      | Description                                                   |
| --------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| [Retrieving category trees for a customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-items-category-trees)        | It retrieves category trees for the customer segments.        |
| [Retrieving all items assignments for a customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-items) | It retrieves all items assignments for the customer segments. |

**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-19"
/>

# 2024-12-19: Category Service - new query parameter

**Overview**

Query parameter `segmentsIds` has been added to GET category assignments endpoint. The new query parameter allows to filter the assigned resources by the segmentsIds - only category assignments will be returned which category is assigned to provided segments list.

**Updated endpoints**

| Endpoint                                                                                                                      | Description                                            |
| ----------------------------------------------------------------------------------------------------------------------------  | -----------------------------------------------------  |
| [Retrieving resources assigned to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#get-category-tenant-categories-categoryid-assignments)   | The new query parameter `segmentsIds` has been added.  |

**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-17"
/>

# 2024-12-17: AI Service - Completion functionality

**Overview**

The AI Service supports completion functionality. Generates a completion based on conversation history.

**Updated endpoints**

| Endpoint                                                                                                            | Description                                                                  |
| ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [AI Completions](https://developer.emporix.io/api-references/api-guides/artificial-intelligence/ai-service/api-reference/ai-completions) | Generates a completion based on conversation history.|


**Known problems**

There are no known problems.

---

<Badge
    tag="minor"
    date="2024-12-16"
/>

# 2024-12-16: Order Service - Q-param behaviour

**Overview**

The q-param accepts string values both with and without quotes, while number values should be provided without quotes.

**Updated endpoints**

| Endpoint                                                                                   | Description                                                                                                       |
| ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| [Retrieving orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)            | Q-param accepts `string` values both with and without quotes. `Number` values should be provided without quotes.  |
| [Retrieving a list of orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed)             | Q-param accepts `string` values both with and without quotes. `Number` values should be provided without quotes.  |

**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-11"
/>

# 2024-12-11: Availability Service - upsert operation support

**Overview**

The Availability Service supports `UPSERT` operation. The `PUT` method updates the availability for given product and site or creates a new one if such a availability does not exist yet.

**Updated endpoints**

| Endpoint                                                                                                            | Description                                                                  |
| ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Upserting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#put-availability-tenant-availability-productid-site) | Sending a request to the upsert endpoint with a non-existing product availability creates a new availability for the given product and site.|


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-12-11"
/>

# 2024-12-11: Price Service - upsert operation support

**Overview**

The Price Service supports `UPSERT` operation. The `PUT` method updates the price with the given id or creates a new one if such a price does not exist yet.

**Updated endpoints**

| Endpoint                                                                                                               | Description                                                                  |
| ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Upserting a price](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-priceid)                                                  | Sending a request to the upsert endpoint with a non-existing price id creates a new price with the given id.|
| [Upserting multiple prices](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-bulk)                                | Sending a request to the upsert endpoint with a non-existing price id creates a new price with the given id.|
| [Upserting a price model](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-priceid-model)                                      | Sending a request to the upsert endpoint with a non-existing price model id creates a new price model with the given id.|
| [Upserting a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-priceid-list)                                       | Sending a request to the upsert endpoint with a non-existing price list id creates a new price list with the given id.|
| [Upserting a price in a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-priceid-in-price-list)                             | Sending a request to the upsert endpoint with a non-existing price id creates a new price with the given id for the specified price list.|
| [Upserting multiple prices in a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-bulk-in-price-list)  | Sending a request to the upsert endpoint with a non-existing price id creates a new price with the given id for the specified price list.|


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-12-11"
/>

# 2024-12-11: Product Service - upsert operation support

**Overview**

The Product Service supports `UPSERT` operation. The `PUT` method updates the product with the given id or creates a new one if such a product does not exist yet.
The Product Service has a new `product.product_manage` was added to the product service.
The scopes `product.product_update`, `product.product_create` and `product.product_delete` have been deprecated in favour of `product.product_manage`.

**Updated endpoints**

| Endpoint                                                                                           | Description                                                                  |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products)                  | The endpoint requires a new `product.product_manage` scope, as the `product.product_create` scope is deprecated.|
| [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk)        | The endpoint requires a new `product.product_manage` scope, as the `product.product_create` scope is deprecated.|
| [Upserting a product](/https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid)                      | The endpoint requires a new `product.product_manage` scope, as the `product.product_update` scope is deprecated. Sending a request to the upsert endpoint with a non-existing product id creates a new product with the given id.|
| [Upserting multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk)        | The endpoint requires a new `product.product_manage` scope, as the `product.product_update` scope is deprecated.  Sending a request to the upsert endpoint with a non-existing product id creates a new product with the given id.|
| [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid)           | The endpoint requires a new `product.product_manage` scope, as the `product.product_update` scope is deprecated.|
| [Deleting a product](/openapi/product/#operation/DELETE-product-remove-product)                    | The endpoint requires a new `product.product_manage` scope, as the `product.product_delete` scope is deprecated.|


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-12-11"
/>

# 2024-12-11: Customer Management Service - upsert operation support

**Overview**

The Customer Management Service supports `UPSERT` operation. For LegalEntity, Location and  ContactAssignment the `PUT` method updates an entity with the given id or creates a new one if such a entity does not exist yet.

**Updated endpoints**

| Endpoint                                                                                                              | Description                                                                  |
| --------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Upserting a legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#put-tenant-legal-entities-legalentityid)              | Sending a request to the upsert endpoint with a non-existing legal entity id creates a new legal entity with the given id.|
| [Upserting a location](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#put-tenant-locations-locationid)                     | Sending a request to the upsert endpoint with a non-existing location id creates a new location with the given id.|
| [Upserting a contact assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/contact-assignments#put-tenant-contact-assignments-contactassignmentid) | Sending a request to the upsert endpoint with a non-existing contact assignment id creates a new contact assignment with the given id.|


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-12-10"
/>

# 2024-12-10: Coupon Service - new segment-related fields

**Overview**

Fields `segmentRestricted` and `restrictions.segments` were added to coupon's model. The new fields allow to keep information about segments restrictions in the coupon.

**Updated endpoints**

| Endpoint                                                                                                        | Description                                                                         |
| -------------------------------------------------------------------------------------------------------------   | ----------------------------------------------------------------------------------  |
| [Creating a new coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons)                                   | The request body has new fields - `segmentRestricted` and `restrictions.segments`.  |
| [Updating the coupon by code](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#put-coupon-tenant-coupons-code)                              | The request body has new fields - `segmentRestricted` and `restrictions.segments`.  |
| [Partially updating the coupon by code](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#patch-coupon-tenant-coupons-code)                  | The request body has new fields - `segmentRestricted` and `restrictions.segments`.  |
| [Retrieving information about particular coupon by code](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#get-coupon-tenant-coupons-code) | The response body has new fields - `segmentRestricted` and `restrictions.segments`. |
| [Retrieving list of coupons by criteria](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management          | The response body has new fields - `segmentRestricted` and `restrictions.segments`. |

**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-10"
/>

# 2024-12-10: Coupon Service - added information about legalEntity to redemption endpoints

**Overview**

The request and response bodies of endpoints for redeeming coupons were extended with `legalEntityId` field. It means that if a customer is assigned to many legal entities then he can redeem coupons separately for each of them.

**Updated endpoints**

| Endpoint                                                                                                      | Description                                          |
| ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| [Validating redeemability of a coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-validation)                | The request body has a new field - `legalEntityId`.  |
| [Redeeming the coupon by creating a redemption](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-redemption#post-coupon-tenant-coupons-code-redemptions)     | The request body has a new field - `legalEntityId`.  |
| [Retrieving a coupon redemption](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#get-coupon-tenant-coupons-code-redemption)            | The response body has a new field - `legalEntityId`. |
| [Retrieving a list of redemptions by criteria](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-redemption) | The response body has a new field - `legalEntityId`. |



**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-10"
/>

# 2024-12-10: Customer Service - added information about legalEntities and businessModel

**Overview**

Fields `legalEntities` and `businessModel` were added to customer's model. The new fields are readonly and gives instant information whether customer is of B2B or B2C business model.

**Updated endpoints**

| Endpoint                                                                                                            | Description                                                                |
| ------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| [Retrieving a customer's own profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/account-and-profile) | The response has two new fields - `b2b.legalEntities` and `businessModel`. |
| [Retrieving a customer's profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers-customernumber)        | The response has two new fields - `b2b.legalEntities` and `businessModel`. |
| [Retrieving a list of customers](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers)            | The response has two new fields - `b2b.legalEntities` and `businessModel`. |


**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-10"
/>

# 2024-12-10: IAM Service Service - upsert operation support for groups and assignments

**Overview**

The IAM Service supports `UPSERT` operation for groups and assignment. The `PUT` method updates the user group with the given id or creates a new one if such a group does not exist yet.
A new scope `iam.group_manage` was added to the IAM service.
The scopes `iam.group_update`, `iam.group_create` and `iam.group_delete` have been deprecated in favour of `iam.group_manage`.

**Updated endpoints**

| Endpoint                                                                                                            | Description                                                                  |
| ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Creating a new group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups)                                          | The endpoint requires a new `iam.group_manage` scope, as the `iam.group_create` scope is deprecated.|
| [Upserting a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#put-iam-tenant-groups-groupid)                                              | The endpoint requires a new `iam.group_manage` scope, as the `iam.group_update` scope is deprecated. Sending a request to the upsert endpoint with a non-existing group id creates a new catalog with the given id.|
| [Deleting a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#delete-iam-tenant-groups-groupid)                                            | The endpoint requires a new `iam.group_manage` scope, as the `iam.group_delete` scope is deprecated.|
| [Adding a user to a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups-groupid-users)                                      | The endpoint requires a new `iam.assignment_manage` scope, as the `iam.assignment_create` scope is deprecated.|
| [Removing all users from a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#delete-iam-tenant-groups-groupid-users)                              | The endpoint requires a new `iam.assignment_manage` scope, as the `iam.assignment_delete` scope is deprecated.|
| [Removing a user from a group](/openapi/iam/#operation/DELETE-iam-remove-user-from-group)                           | The endpoint requires a new `iam.assignment_manage` scope, as the `iam.assignment_delete` scope is deprecated.|
| [Removing a user from all groups](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/group-assignments#delete-iam-tenant-users-userid-groups)                   | The endpoint requires a new `iam.assignment_manage` scope, as the `iam.assignment_delete` scope is deprecated.|
| [Upserting user assignment to a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/group-assignments#put-iam-tenant-groups-groupid-users-usertype-userid)                        | New endpoint that allows to create or update group assignment.|


**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-09"
/>

# 2024-12-09: Catalog Service - upsert operation support

**Overview**

The Catalog Service supports `UPSERT` operation. The `PUT` method updates the catalog with the given id or creates a new one if such a catalog does not exist yet.
A new scope `catalog.catalog_manage` was added to the catalog service.
The scopes `catalog.catalog_update`, `catalog.catalog_create` and `catalog.catalog_delete` have been deprecated in favour of `catalog.catalog_manage`.

**Updated endpoints**

| Endpoint                                                                                           | Description                                                                  |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Creating a new catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/list-catalogs#post-catalog-tenant-catalogs)                    | The endpoint requires a new `catalog.catalog_manage` scope, as the `catalog.catalog_create` scope is deprecated.|
| [Upserting a catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/list-catalogs#put-catalog-tenant-catalogs-catalogid)               | The endpoint requires a new `catalog.catalog_manage` scope, as the `catalog.catalog_update` scope is deprecated. Sending a request to the upsert endpoint with a non-existing catalog id creates a new catalog with the given id.|
| [Partially updating a catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/list-catalogs#patch-catalog-tenant-catalogs-catalogid)  | The endpoint requires a new `catalog.catalog_manage` scope, as the `catalog.catalog_update` scope is deprecated.|
| [Removing a catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/list-catalogs#delete-catalog-tenant-catalogs-catalogid)                        | The endpoint requires a new `catalog.catalog_manage` scope, as the `catalog.catalog_delete` scope is deprecated.|


**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-12-09"
/>

# 2024-12-09: Customer Service - upsert operation support

**Overview**

The Customer Service support the `UPSERT` operation. The `PUT` method updates the customer with the given id or creates a new one if such a customer does not exist yet. The same applies to customer's address `PUT` method.
The field `metadata.version` is now optional to support the `UPSERT` operation. When you don't provide the value, the optimistic locking is not enabled.
The Customer Service has a new `customer.customer_manage` scope.
The scopes `customer.customer_update`, `customer.customer_create` and `customer.customer_delete` have been deprecated in favour of `customer.customer_manage`.

**Updated endpoints**

| Endpoint                                                                                                                                  | Description                                                                  |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Creating a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers)                                           | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_create` scope is deprecated.|
| [Upserting a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber)                        | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated. Sending a request to the upsert endpoint with a non-existing customer id creates a new customer with the given id.|
| [Partially updating a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber)                        | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated.|
| [Assigning an account to an existing customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers-customernumber-accounts-internal)  | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated.|
| [Deleting a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#delete-customer-tenant-customers-customernumber)                                 | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_delete` scope is deprecated.|
| [Adding a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses)                                | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated.|
| [Upserting a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber-address)                | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated. Sending a request to the upsert endpoint with a non-existing address id creates a new address with the given id.|
| [Partially updating a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber-address)       | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated.|
| [Deleting a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#delete-customer-tenant-customers-customernumber-address)                         | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated.|
| [Adding tags to a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses-addressid-tags)                            | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated.|
| [Deleting tags from a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#delete-customer-tenant-customers-customernumber-addresses-addressid-tags)                   | The endpoint requires a new `customer.customer_manage` scope, as the `customer.customer_update` scope is deprecated.|


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-12-09"
/>

# 2024-12-09: Category Service - upsert improvements

**Overview**

The field `metadata.version` is now optional to support the `UPSERT` operation. When you don't provide the value, the optimistic locking is not enabled.
The Category Service as a new `category.category_manage` scope.
The scopes `category.category_update`, `category.category_create` and `category.category_delete` have been deprecated in favour of `category.category_manage`.

**Updated endpoints**

| Endpoint                                                                                                                                       | Description                                                                  |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories)                                                     | The endpoint requires a new `category.category_manage` scope, as the `category.category_create` scope is deprecated.|
| [Upserting a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#put-category-tenant-categories-categoryid)                                                          | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated. Sending a request to the upsert endpoint with a non-existing category id creates a new category with the given id.|
| [Partially updating a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#patch-category-tenant-categories-categoryid)                                              | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated.|
| [Deleting a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#delete-category-tenant-categories-categoryid)                                                       | The endpoint requires a new `category.category_manage` scope, as the `category.category_delete` scope is deprecated.|
| [Assigning a resource to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#post-category-tenant-categories-categoryid-assignments-bulk)                                          | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated.|
| [Assigning resources to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#post-category-tenant-categories-categoryid-assignments)                                 | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated.|
| [Upserting a resource to a category assignment](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#put-category-tenant-categories-categoryid-assignments-references-referenceid)                                                       | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated. Sending a request to the upsert endpoint with a non-existing category assignment id creates a new assignment with the given id.|
| [Updating assignments](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#put-category-tenant-categories-categoryid-assignments)                                             | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated.|
| [Deleting a category assignment by reference id](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#delete-category-tenant-categories-categoryid-assignment-by-reference-id) | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated.|
| [Deleting a category assignment by id](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#delete-category-tenant-categories-categoryid-assignment)                           | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated.|
| [Deleting all category assignments](/openapi/category/#operation/DELETE-category-tree-remove-all-category-assignments)                         | The endpoint requires a new `category.category_manage` scope, as the `category.category_update` scope is deprecated.|

**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-11-21"
/>

<Badge
tag="minor"
date="2024-12-02"
/>

# 2024-11-21: Webhook Service - new events

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The new events were added to webhook-service.

**Added events**

| Event                                           | Description                                                                       |
| ----------------------------------------------- | --------------------------------------------------------------------------------- |
| `client-management.contactassignment-created`   | The event is emitted when contact assignment is created.                          |
| `client-management.contactassignment-deleted`   | The event is emitted when contact assignment is deleted.                          |
| `client-management.contactassignment-updated`   | The event is emitted when contact assignment is updated.                          |
| `customer-segment.segment-created`              | The event is emitted when a customer segment is created.                          |
| `customer-segment.segment-deleted`              | The event is emitted when a customer segment is deleted.                          |
| `customer-segment.segment-updated`              | The event is emitted when a customer segment is updated.                          |
| `customer-segment.customer-assignment-created`  | The event is emitted when a customer assignment to a customer segment is created. |
| `customer-segment.customer-assignment-updated`  | The event is emitted when a customer assignment to a customer segment is updated. |
| `customer-segment.customer-assignment-deleted`  | The event is emitted when a customer assignment to a customer segment is deleted. |
| `customer-segment.item-assignment-created`      | The event is emitted when an item is assigned to a customer segment.              |
| `customer-segment.item-assignment-deleted`      | The event is emitted when an item is unassigned from a customer segment.          |
| `customer-segment.item-assignment-updated`      | The event is emitted when an item assignment to a customer segment is updated.    |
| `site.site-created`                             | The event is emitted when site is created.                                        |
| `site.site-deleted`                             | The event is emitted when site is deleted.                                        |
| `site.site-updated`                             | The event is emitted when site is updated.                                        |

**Known problems**

There are no known problems.

---

<Badge tag="newFeature"
date="2024-12-02"
/>

# 2024-12-02: Customer Segment Service - endpoints for managing B2C customer assignments

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

We added new API for managing B2C customer assignments.

**Added endpoints**

| Endpoint                                                                                                                      | Description                                  |
| ----------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| [Retrieving a customer assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#get-customer-segment-tenant-segments-segmentid-customers-customerid) | It retrieves a customer assignment.          |
| [Upserting a customer assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-customerid)    | It creates or updates a customer assignment. |
| [Deleting a customer assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#delete-customer-segment-tenant-segments-segmentid-customers-customerid)  | It deletes a customer assignment.            |

**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-11-22"
/>

# 2024-11-22: Category Service - mixins validation

**Overview**

A new property is available in the category model - `metadata.mixins`. It allows validation of mixins against the provided schema.

**Updated endpoints**

| Endpoint                                                                                                      | Description                          |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories)                    | We added `metadata.mixins` property. |
| [Upserting a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#put-category-tenant-categories-categoryid)                         | We added `metadata.mixins` property. |
| [Partially updating a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#patch-category-tenant-categories-categoryid)             | We added `metadata.mixins` property. |
| [Retrieving a list of categories](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories)             | We added `metadata.mixins` property. |
| [Retrieving a category's details](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories-categoryid)           | We added `metadata.mixins` property. |
| [Retrieving parents for a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories-categoryid-parents) | We added `metadata.mixins` property. |
| [Retrieving subcategories for a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories-categoryid-subcategories)  | We added `metadata.mixins` property. |

**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-11-21"
/>

# 2024-11-21: IAM Service - custom ID support for groups

**Overview**

The IAM Service now supports custom IDs for group creation.
If the ID is already in use, the service returns a 409 status code.

**Updated endpoints**

| Endpoint                                                                                   | Description                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| [Creating a new group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups)                  | The `id` field added. |


**Known problems**

There are no known problems.

---

<Badge
    tag="improvement"
    date="2024-11-19"
/>

# 2024-11-19: Customer Service - custom ID support for addresses

**Overview**

The Customer Service now supports custom IDs for customer's addresses creation.
If the ID is already in use, the service returns a 409 status code.

**Updated endpoints**

| Endpoint                                                                                   | Description                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| [Adding a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses)                  | The `id` field added. |


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-11-15"
/>

# 2024-11-15: Customer Management Service - custom ID support

**Overview**

The Customer Management Service now supports custom IDs for Legal Entities, Locations, Contact Assignments creation. The `id` field can have 1 - 66 characters and must match `^[a-zA-Z0-9_-]$` regular expression.
If the ID is already in use, the service returns a 409 status code.

**Updated endpoints**

| Endpoint                                                                                   | Description                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| [Creating a new legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-tenant-legal-entities)                  | The `id` field added. |
| [Creating a new location](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#post-tenant-locations)                  | The `id` field added. |
| [Creating a new contact assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/contact-assignments#post-tenant-contact-assignments)                  | The `id` field added. |


**Known problems**

There are no known problems.

---
<Badge tag="minor"
date="2024-11-15"
/>

# 2024-11-15: Customer-Management Service - search legal entities endpoint

**Overview**

The Customer-Management Service has been enhanced with the new endpoint which allows to retrieve legal entities that match criteria provided in request payload.

**Added endpoints**

| Endpoint                                                                                                         | Description                                                                                     |
| ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [Searching for legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-tenant-legal-entities-search) | The new endpoint which allows to retrieve legal entities by criteria provided in request payload|

---

<Badge tag="newFeature"
date="2024-11-13"
/>

# 2024-11-13: Customer Segment Service - endpoints for managing segments

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

We added new API for managing customer segments, items assigned to segments and customers assigned to segments.

**Added endpoints**

| Endpoint                                                                                                                    | Description                                         |
| --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------- |
| [Creating a segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments)                             | It creates a new segment.                           |
| [Retrieving segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#get-customer-segment-tenant-segments)                          | It retrieves segments.                              |
| [Searching for segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments-search)                        | It searches for segments.                           |
| [Retrieving a segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#get-customer-segment-tenant-segments-segmentid)                          | It retrieves a segment.                             |
| [Updating a segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#put-customer-segment-tenant-segments-segmentid)                              | It updates a segment.                               |
| [Patching a segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#patch-customer-segment-tenant-segments-segmentid)                            | It partially updates a segment.                     |
| [Deleting a segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#delete-customer-segment-tenant-segments-segmentid)                           | It deletes a segment.                               |
| [Creating segments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segmentss-bulk)                | It creates segments in bulk.                        |
| [Updating segments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#put-customer-segment-tenant-segments-segmentids-bulk)                 | It updates segments in bulk.                        |
| [Deleting segments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#delete-customer-segment-tenant-segments-segmentids-bulk)              | It deletes segments in bulk.                        |
| [Retrieving customer assignments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#get-customer-segment-tenant-segments-segmentid-customers)             | It retrieves customer assignments.                  |
| [Searching for customer assignments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#post-customer-segment-tenant-segments-segmentid-customers-search)           | It searches for customer assignments.               |
| [Retrieving a customer assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#get-customer-segment-tenant-segments-segmentid-customers-customerid-legalentityid)             | It retrieves a customer assignment.                 |
| [Upserting a customer assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-customerid-legalentityid)                | It creates or updates a customer assignment.        |
| [Deleting a customer assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#delete-customer-segment-tenant-segments-segmentid-customers-customerid-legalentityid)              | It deletes a customer assignment.                   |
| [Upserting customer assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-customerid-legalentityids-bulk)   | It creates or updates customer assignments in bulk. |
| [Deleting customer assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#delete-customer-segment-tenant-segments-segmentid-customers-customerid-legalentityids-bulk) | It deletes customer assignments in bulk.            |
| [Retrieving item assignments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#get-customer-segment-tenant-segments-segmentid-items)             | It retrieves item assignments.                      |
| [Searching for item assignments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#post-customer-segment-tenant-segments-segmentid-items-search)                   | It searches for item assignments.                   |
| [Retrieving an item assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-segmentid-items-type-itemid)                    | It retrieves an item assignment.                    |
| [Updating an item assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#put-customer-segment-tenant-segments-segmentid-items-type-itemid)                        | It updates an item assignment.                      |
| [Removing an item assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#delete-customer-segment-tenant-segments-segmentid-items-type-itemid)                     | It removes an item assignment.                      |
| [Upserting item assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#put-customer-segment-tenant-segments-segmentid-items-type-itemid-bulk)           | It creates or updates item assignments in bulk.     |
| [Deleting item assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#delete-customer-segment-tenant-segments-segmentid-items-type-itemids-bulk)         | It deletes item assignments in bulk.                |

**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-11-13"
/>

# 2024-11-13: Customer Service - custom ID support

**Overview**

The Customer Service now supports custom IDs for customer creation. The `id` field can have 1 - 66 characters and must match `^[a-zA-Z0-9_-]$` regular expression.
If the ID is already in use, the service returns a 409 status code.

**Updated endpoints**

| Endpoint                                                                                   | Description                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| [Creating a new customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers)                  | The `id` field added. |


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-11-13"
/>

# 2024-11-13: Category Service - custom ID support

**Overview**

The Category Service now supports custom IDs for category creation. If the ID is already in use, the service returns a 409 status code.
Along with that upsert operation was introduced that allows to create or update a category based on the provided ID.

Category assignments support upsert operation for single and multiple assignments.

**Updated endpoints**

| Endpoint                                                                                   | Description                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories)                  | The `id` field added. |
| [Upserting a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#put-category-tenant-categories-categoryid)                  | The new endpoint that allows you to either create or update a category with a given id. |
| [Upserting a resource to a category assignment](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#put-category-tenant-categories-categoryid-assignments-references-referenceid)                  | The new endpoint that allows you to either create or update an assignment. |
| [Upserting multiple category assignments](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#put-category-tenant-categories-categoryid-assignments)                  |The new endpoint that allows you to either create or update multiple assignments. |


**Known problems**

There are no known problems.

---
<Badge
    tag="improvement"
    date="2024-11-04"
/>

# 2024-11-04: Catalog Service - custom ID support

**Overview**

The Catalog Service now supports custom IDs for catalog creation. The `id` field can have 1 - 66 characters and must match `^[a-zA-Z0-9_-]$` regular expression.
If the ID is already in use, the service will return a 409 status code.

**Updated endpoints**

| Endpoint                                                                                   | Description                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| [Creating a new catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/list-catalogs#post-catalog-tenant-catalogs)                  | The `id` field added. |


**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-10-09"
/>

# 2024-10-09: Order Service - discount calculation type

**Overview**

The discount model was expanded with a new field to include the coupon `discountCalculationType` property, which determines whether the discount is calculated based on the total or subtotal cart value.

**Updated endpoints**

| Endpoint                                                                                   | Description                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------- |
| [Retrieving all orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)                  | The `discount.discountCalculationType` field added. |
| [Creating an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)                     | The `discount.discountCalculationType` field added. |
| [Retrieving an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid)            | The `discount.discountCalculationType` field added. |
| [Updating an order](/openapi/order/#operation/PUT-order-update-order)              | The `discount.discountCalculationType` field added. |
| [Partially updating an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#put-order-v2-tenant-salesorders-orderid)  | The `discount.discountCalculationType` field added. |


**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-10-09"
/>

# 2024-10-09: Cart Service - discount calculation type

**Overview**

The discount model was expanded with a new field to include the coupon `discountCalculationType` property, which determines whether the discount is calculated based on the total or subtotal cart value.
Also `total` object was expanded with `discount` property, which holds discount amount for a given `total`.

**Updated endpoints**

| Endpoint                                                                                | Description                                                          |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| [Retrieving all carts](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts)                       | The `discount.discountCalculationType` and `total.discount` fields added. |
| [Retrieving a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)                   | The `discount.discountCalculationType` and `total.discount` fields added. |
| [Applying a discount](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/discounts#post-cart-tenant-carts-cartid-discounts)      | The `discountCalculationType` field added.                                |
| [Retrieving all discounts](/openapi/cart/#operation/GET-cart-list-all-discounts)  | The `discountCalculationType` field added.                              |


**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-10-09"
/>

# 2024-10-09: Coupon Service - discount calculation type

**Overview**

The coupon model was expanded with a `discountCalculationType` field, which determines whether the discount is calculated based on the total or subtotal order value.

**Updated endpoints**

| Endpoint                                                                            | Description                           |
| ----------------------------------------------------------------------------------- | ------------------------------------- |
| [Retrieving all coupons](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management             | The `discountCalculationType` field added. |
| [Creating a coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons)                 | The `discountCalculationType` field added. |
| [Retrieving a coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#get-coupon-tenant-coupons-code)           | The `discountCalculationType` field added. |
| [Updating a coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#put-coupon-tenant-coupons-code)             | The `discountCalculationType` field added. |
| [Partially updating a coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#patch-coupon-tenant-coupons-code) | The `discountCalculationType` field added. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-10-03"
/>

# 2024-10-03: Webhook Service - new event `customer.email-change-request` type

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The event is emitted when a customer requests changing the email. For more information, see [Customer events](/content/events-customer).

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-09-26"
/>

# 2024-09-26: Order Service - introduction of `feeYrnAggregate` and `fees` fields

**Overview**

New fields `feeYrnAggregate` and `fees` were introduced. The `feeYrnAggregate` field was added to the order model and the `fees` field was added to the order entry model. This change allows adding custom externally sources fees to the customer's order.

**Updated endpoints**

| Endpoint                                                                                      | Description                                                           |
|-----------------------------------------------------------------------------------------------| --------------------------------------------------------------------- |
| [Retrieving orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)                         | The response body schema contains `feeYrnAggregate` and `fees` fields.|
| [Creating a new order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)                     | The request body schema contains `feeYrnAggregate` and `fees` fields. |
| [Retrieving a specific order by ID](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid) | The response body schema contains `feeYrnAggregate` and `fees` fields.|
| [Updating an order](/openapi/order/#operation/PUT-order-update-orde)                 | The request body schema contains `feeYrnAggregate` and `fees` fields. |
| [Partially updating an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#put-order-v2-tenant-salesorders-orderid)     | The request body schema contains `feeYrnAggregate` and `fees` fields. |
| [Retrieving a list of orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed)                    | The response body schema contains `feeYrnAggregate` and `fees` fields.|
| [Creating a new order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#post-order-v2-tenant-orders)                          | The request body schema contains `feeYrnAggregate` and `fees` fields. |
| [Retrieving order details](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders-orderid)               | The response body schema contains `feeYrnAggregate` and `fees` fields.|

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-09-26"
/>

# 2024-09-26: Cart Service - introduction of `externalFees` field

**Overview**

New field `externalFees` was added to the cart item model. This change allows to calculate custom external fees at the customer's cart level.

**Updated endpoints**

| Endpoint                                                                                          | Description                                                                 |
|---------------------------------------------------------------------------------------------------| --------------------------------------------------------------------------- |
| [Retrieving a cart's details by criteria](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts)              | The response body schema of `items` field contains new field `externalFees`.|
| [Retrieving a cart's details by ID](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)             | The response body schema of `items` field contains new field `externalFees`.|
| [Adding multiple products to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-itemsbatch)  | The request body schema contains new field `externalFees`.                  |
| [Retrieving all products added to a cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) | The response body schema contains new field `externalFees`.                 |
| [Adding a product to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items)               | The request body schema contains new field `externalFees`.                  |
| [Retrieving a cart item](/openapi/cart/#operation/GET-cart-retrieve-item-details)           | The response body schema contains new field `externalFees`.                 |
| [Updating a cart item](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#put-cart-tenant-carts-cartid-items-itemid)             | The request body schema contains new field `externalFees`.                  |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-09-11"
/>

# 2024-09-11: Site Settings Service - `taxDeterminationBasedOn` property added

**Overview**

The Site object was expanded with the `taxDeterminationBasedOn` property, which specifies whether tax calculation is based on a customer's billing or shipping address.
Default value is `BILLING_ADDRESS`.

{% hint style="warning" %}
To determine the relevant location to calculate proper taxes, the cart and checkout services read the **Tax determination based on** setting for the site. This setting determines the proper location by the `countryCode` from the relevant address.
The default setting for a site is the **billing address**.

If you set the tax determination as **shipping address**, the country for calculating tax is determined in the following order:

1. For the cart service: <br />
  a. cart's `countryCode` <br />
  b. if the `countryCode` is not provided for a cart, a customer's default shipping address `countryCode` <br />
  c. if a customer doesn't have a default shipping address, the first customer's shipping address `countryCode` on the list <br />
  d. if a customer doesn't have any shipping addresses, the default `countryCode` from the site settings

2. For the checkout service: <br />
  a. a shipping address `countryCode`, provided during checkout <br />
  b. if a shipping address is not provided, a customer's billing address `countryCode` is taken as a fallback
{% endhint %}

**Updated endpoints**

| Endpoint                                                                                  | Description                                                                                              |
| ----------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| [Retrieving sites](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode)                    | The `taxDeterminationBasedOn` property allows you to determine the address for relevant tax calculation. |
| [Retrieving a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-siteslist)          | The `taxDeterminationBasedOn` property allows you to determine the address for relevant tax calculation. |
| [Creating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#post-site-tenant-sites)                    | The `taxDeterminationBasedOn` property allows you to determine the address for relevant tax calculation. |
| [Updating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#put-site-tenant-sites-sitecode)            | The `taxDeterminationBasedOn` property allows you to determine the address for relevant tax calculation. |
| [Partially updating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#patch-site-tenant-sites-sitecode)| The `taxDeterminationBasedOn` property allows you to determine the address for relevant tax calculation. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-09-10"
/>

# 2024-09-10: Webhook Service - new event `customer.email-change` type

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The event is emitted when a customer confirms changing the email. For more information, see [Customer events](/content/events-customer).

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-09-03"
/>

# 2024-09-03: Product Service - introduction of `brandId` and `labelIds` field

**Overview**

New fields `brandId` and `labelIds` were added to the product model. Use these fields instead of `mixins.productCustomAttributes.brand` and `mixins.productCustomAttributes.labels`.

**Updated endpoints**

| Endpoint                                                                                              | Description                                                                |
|-------------------------------------------------------------------------------------------------------| -------------------------------------------------------------------------- |
| [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products)                            | The request body schema contains two new fields `brandId` and `labelIds`.  |
| [Retrieving a product's details](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid)           | The response body schema contains two new fields `brandId` and `labelIds`. |
| [Retrieving a list of products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products)                      | The response body schema contains two new fields `brandId` and `labelIds`. |
| [Upserting a product](/https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid)             | The request body schema contains two new fields `brandId` and `labelIds`.  |
| [Partially updating a product's details](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) | The request body schema contains two new fields `brandId` and `labelIds`.  |
| [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk)                   | The request body schema contains two new fields `brandId` and `labelIds`.  |
| [Upserting multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk)                     | The request body schema contains two new fields `brandId` and `labelIds`.  |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-08-22"
/>

# 2024-08-22: Customer Management Service - `name` field not mandatory

**Overview**

From now on `name` field is no longer mandatory for creating and updating locations.

**Updated endpoints**

| Endpoint                                                      | Description                                            |
| ------------------------------------------------------------- | ------------------------------------------------------ |
| [Creating location](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#post-tenant-locations) | `name` field in request payload is no longer mandatory |
| [Upserting location](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#put-tenant-locations-locationid)    | `name` field in request payload is no longer mandatory |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-08-21"
/>

# 2024-08-21: Customer Service - `metadataCreatedAt` field in response

**Overview**

Responses from endpoints for retrieving customers were enriched with the `metadataCreatedAt` field.

**Updated endpoints**

| Endpoint                                                                               | Description                                                     |
| -------------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| [Retrieving customers](/openapi/cart/#operation/GET_tenant-customers)                  | Response payload contains the `metadataCreatedAt` field. |
| [Retrieving a customer](/openapi/cart/#operation/GET_tenant-customers-customerNumber)  | Response payload contains the `metadataCreatedAt` field. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-08-12"
/>

# 2024-08-12: Cart Service - support for external prices

**Overview**

To handle external prices, the request payload now includes the `itemType` and `tax` properties. To fetch external prices, you also need to generate the `cart.cart_manage_external_prices` scope, set the `enableExternalPrices` system preference to true, set the `price.type` to `EXTERNAL`, and provide the `tax` values.

**Updated endpoints**

| Endpoint                                                                                      | Description                           |
| --------------------------------------------------------------------------------------------- | ------------------------------------- |
| [Adding item to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items)                | The request includes the `itemType` and `tax` properties. |
| [Adding item to cart in batch](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-itemsbatch)  | The request includes the `itemType` and `tax` properties. |
| [Updating item in cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#put-cart-tenant-carts-cartid-items-itemid)        | The request includes the `itemType` and `tax` properties. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-08-08"
/>

# 2024-08-08: Order Service - introduction of add entries endpoint

**Overview**

Order Service has a new endpoint that is responsible for modifying and adding new entries to a given order.

**New endpoints**

| Endpoint                                                                         | Description                        |
| ---------------------------------------------------------------------------------| ---------------------------------- |
| [Adding entries](/openapi/order/#operation/POST-order-update-order-entries) | A new endpoint for adding entries to existing orders. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-07-23"
/>

# 2024-07-23: Configuration Service - introduction of clients endpoint

**Overview**

Configuration Service has a new endpoint that is responsible for returning list of clients for given tenant.

**New endpoints**

| Endpoint                                                                   | Description                            |
| ---------------------------------------------------------------------------| -------------------------------------- |
| [Retrieving clients](/openapi/configuration/#operation/GET-configuration-list-clients) | A new endpoint for retrieving clients. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-07-11"
/>

# 2024-07-11: Customer Service (customer-managed) - `site` field for password reset requests

**Overview**

There is a new property `site` added to password reset model and 'customer.password-reset' event message. It allows to save site from which password reset request was sent.

**Updated endpoints**

| Endpoint                                                                                      | Description                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------- |
| [Requesting password reset](/openapi/customer-customer/#operation/POST-customer-request-reset-password) | The `site` property added to password reset model. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-07-09"
/>

# 2024-07-09: Cart Service - introduction of refresh endpoint

**Overview**

Cart Service has a new endpoint that is responsible for refreshing a specified cart and its items. If the prices assigned to the items in a cart have changed, invoking the endpoint recognizes the changes and reassigns them in the cart.

**New endpoints**

| Endpoint                                                                      | Description                                                   |
| ------------------------------------------------------------------------------| ------------------------------------------------------------- |
| [Refreshing a cart](/openapi/cart/#operation/PUT-cart-refresh-cart) | A new endpoint that refreshes a specified cart and its items. |

**Known problems**

There are no known problems.

---

<Badge
tag="removed"
date="2024-07-02"
/>

# 2024-07-02: Shopping-list Service - removal of deprecated endpoints

All previously deprecated endpoints are now removed.

**Removed endpoints**

| Endpoint                                                              |
| --------------------------------------------------------------------- |
| Fetching all shopping lists - *GET* */shoppinglists*                  |
| Creating a shopping list - *POST* */shoppinglists*                    |
| Updating a shopping list - *PUT* */shoppinglists*                     |
| Removing a shopping list - *DELETE* */shoppinglists*                  |
| Fetching a shopping list - *GET* */shoppinglists/{customerNumber}*    |


---

<Badge
tag="minor"
date="2024-06-13"
/>

# 2024-06-13: Shipping Service - support for slot delivery method quote

**Overview**

Shipping Service has a new endpoint that is responsible for calculating the delivery cost for a slot delivery method. Additionally, the cart service can now calculate the shipping cost based on the selected delivery window slot if you provide the slot id and window id.

**New endpoints**

| Endpoint                                                                                                         | Description                                                                    |
| ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| [Calculating the shipping cost for a given slot](/openapi/shipping/#operation/POST-shipping-calculate-slot-shipping-cost) | A new endpoint that retrieves the minimum delivery cost for a given time slot. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-05-17"
/>

# 2024-05-17: Shopping List Service - support for shopping lists mixins

**Overview**

Shopping List Service from now on supports the mixins feature. Two new properties are available in the model - `mixins` and `metadata.mixins`.

**Updated endpoints**

| Endpoint                                                                                              | Description                                             |
| ----------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [Fetching all shopping lists](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-lists)             | We added the `mixins` and `metadata.mixins` properties. |
| [Creating a shopping list](/openapi/shopping-list/#operation/POST-shopping-list-create-shopping-list)               | We added the `mixins` and `metadata.mixins` properties. |
| [Updating a shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-lists#put-shoppinglist-tenant-shopping-lists-customerid)     | We added the `mixins` and `metadata.mixins` properties. |
| [Fetching a shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-lists#get-shoppinglist-tenant-shopping-lists-customerid)    | We added the `mixins` and `metadata.mixins` properties. |


**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-05-15"
/>

# 2024-05-15: Webhook Service - new HTTP header for HTTP Webhook Strategy

**Overview**

A new HTTP header `emporix-event-publish-time` is from now on attached to all requests sent to `destinationUrl` of HTTP Webhook Strategy. This header contains a timestamp in RFC3339 UTC "Zulu" format informing about the time at which the message was published.

**Known problems**

There are no known problems.

---


<Badge
tag="minor"
date="2024-05-06"
/>

# 2024-05-06: Schema Service - `PRICE_LIST` type support

**Overview**

We extended the schema with a new `PRICE_LIST` type.

**Updated endpoints**

| Endpoint                                                                   | Description                  |
| -------------------------------------------------------------------------- | -------------------------- |
|[Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas)          | The new type is available. |
|[Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id)               | The new type is available. |
|[Updating types of a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id-types)| The new type is available. |
|[Creating a reference](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/reference#post-schema-tenant-references)    | The new type is available. |
|[Updating a reference](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/reference#put-schema-tenant-references-id)         | The new type is available. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-04-24"
/>

# 2024-04-24: Schema Service - support for object attributes

**Overview**

Schema Service now supports object attributes. The `OBJECT` type was added to `SchemaAttribute.type` enum and `attributes` property was added to `SchemaAttribute` object. The `attributes` property contains information about the object's attributes.

**Updated endpoints**

| Endpoint                                                           | Description                                                       |
| ------------------------------------------------------------------ | ----------------------------------------------------------------- |
| [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas) | Schema attribute in the request body can now be of `OBJECT` type. |
| [Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id)      | Schema attribute in the request body can now be of `OBJECT` type. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-04-19"
/>

# 2024-04-19: Schema Service - support for array attributes

**Overview**

Schema Service now supports array attributes. `ARRAY` type was added to `SchemaAttribute.type` enum and `arrayType` property was added to `SchemaAttribute` object. `arrayType` property contains additional information about array - for example, what is the type of array items.

**Updated endpoints**

| Endpoint                                                           | Description                                                      |
| ------------------------------------------------------------------ | ---------------------------------------------------------------- |
| [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas) | Schema attribute in the request body can now be of `ARRAY` type. |
| [Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id)      | Schema attribute in the request body can now be of `ARRAY` type. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-04-15"
/>

# 2024-04-15: Cart Service - support for discount deletion by code

**Overview**

The Cart Service has been updated to enable the removal of discounts using the discount `code`.
* If no discount `code` is provided, all discounts are removed from the cart, maintaining previous functionality.
* A new endpoint has been implemented for retrieving all discounts.
* A new attribute called `discountIndex` has been introduced to allow the removal of discounts by index.

**Updated endpoints**

| Endpoint                                                                                 | Description                                                               |
| ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| [Retrieving all cart discounts](/openapi/cart/#operation/GET-cart-list-all-discounts)     | New endpoint for getting all discounts from a cart.                       |
| [Deleting discount by code](/openapi/cart/#operation/DELETE-cart-remove-all-discounts) | New query param `codes` that allows to remove discounts by provided code. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-04-15"
/>

# 2024-04-15: Price Service (v2) - support for price lists mixins

**Overview**

Price Service (v2) from now on supports the mixins feature for price lists. Two new properties are available in the model - `mixins` and `metadata.mixins`.

**Updated endpoints**

| Endpoint                                                                                    | Description                                             |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [Retrieving all price lists](/openapi/price/#operation/GET-price-retrieve-price-lists)               | We added the `mixins` and `metadata.mixins` properties. |
| [Retrieving price list by id](/openapi/price/#operation/GET-price-retrieve-price-list)  | We added the `mixins` and `metadata.mixins` properties. |
| [Creating a price list](/openapi/price/#operation/POST-price-create-price-list)                   | We added the `mixins` and `metadata.mixins` properties. |
| [Updating a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-priceid-list)         | We added the `mixins` and `metadata.mixins` properties. |


**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-04-15"
/>

# 2024-04-15: Schema Service - support for nullable attributes

**Overview**

Schema Service now supports nullable attributes. `nullable` boolean property was added to `SchemaAttribute.metadata` object and this property informs whether the attribute could accept null or not. Default value is `false`.

**Updated endpoints**

| Endpoint                                                           | Description                                               |
| ------------------------------------------------------------------ | --------------------------------------------------------- |
| [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas) | Schema attribute in the request body can now be nullable. |
| [Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id)      | Schema attribute in the request body can now be nullable. |

**Known problems**

There are no known problems.

<Badge
tag="minor"
date="2024-04-10"
/>

# 2024-04-10: Schema Service - support for `DECIMAL` type

**Overview**

Schema Service now supports `DECIMAL` type. Supported multiplicity is `0.01`.

**Updated endpoints**

| Endpoint                                                           | Description                                                               |
| ------------------------------------------------------------------ | ------------------------------------------------------------------------- |
| [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas) | Schema attribute in the request body can now be of `DECIMAL` type. |
| [Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id)      | Schema attribute in the request body can now be of `DECIMAL` type. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2024-03-29"
/>

# 2024-03-29: Category Service - new endpoint for creating category assignments in bulk

**Overview**

A new endpoint has been introduced for creating category assignments in bulk. It allows to create up to 200 assignments by one request.

**Updated endpoints**

| Endpoint                                                                            | Description                                             |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------- |
| [Assigning resources to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#get-category-tenant-categories-categoryid-assignments) | New endpoint for creating category assignments in bulk. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-03-28"
/>

# 2024-03-28: Category Service - `supercategoriesIds` in response

**Overview**

The endpoint for retrieving a list of categories for which the reference ID is assigned was enriched with `expandSupercategoriesIds` boolean query parameter. The parameter adds information about IDs of supercategories of a given category to the `supercategoriesIds` response field.

**Updated endpoints**

| Endpoint                                                                                                     | Description                                                                                        |
| ------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------- |
| [Retrieving a list of categories of the assignment](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories-by-reference-id) | New `expandSupercategoriesIds` parameter and `supercategoriesIds` field in response are available. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-03-22"
/>

# 2024-03-22: Webhook Service - new event `customer.opt-in` type

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The event is emitted when a customer opts in. For more information, see [Customer events](/content/events-customer).

**Known problems**

There are no known problems.



<Badge
tag="newFeature"
date="2024-03-15"
/>

# 2024-03-15: Checkout Service - guest checkout

**Overview**

We introduce the guest checkout functionality that makes it possible to complete a purchase without a customer account. The `customer` object in the request now contains the `guest` field that indicates if a purchase is made by an anonymous or logged in customer.

**Updated endpoints**

| Endpoint                                                                  | Description                                                                                                    |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [Triggering a checkout](/openapi/checkout/#operation/POST-checkout-trigger-checkout) | The `customer` object contains the `guest` field. If set to `true`, the checkout process proceeds for a guest customer without the need for registering or logging in. |

**Known problems**

There are no known problems.

---
<Badge
tag="minor"
date="2024-03-15"
/>

# 2024-03-15: Returns Service - returns for anonymous orders

**Overview**

The new `requestor.anonymous` and `requestor.email` parameters allow creating returns for orders that were created by guest users without a customer account.

**Updated endpoints**

| Endpoint                                                                      | Description                                                                       |
| ----------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| [Creating a single return entity](/openapi/returns/#operation/POST-returns-create-return) | New `requestor.anonymous` and `requestor.email` parameters are available. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-03-15"
/>

# 2024-03-15: Cart Service - `couponDiscounts` field in response

**Overview**

Responses from endpoints for retrieving cart details were enriched with the `couponDiscounts` field. The `couponDiscounts` is an array which contains pairs of `couponId` and `value` parameters that indicate how much the item's price was lowered by the given coupon.

**Updated endpoints**

| Endpoint                                                          | Description                                      |
| ----------------------------------------------------------------- | ------------------------------------------------ |
| [Getting Carts](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts)        | Response contains the `couponDiscounts` field.   |
| [Getting Cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)  | Response contains the `couponDiscounts` field.   |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-03-07"
/>

# 2024-03-07: OAuth Service - deprecation of `anonymous_token` parameter

**Overview**

The `anonymous_token` parameter is now deprecated when refreshing an anonymous token. We recommend using the `refresh_token` parameter instead. The deprecated parameter will be removed in 6 months.

**Updated endpoints**

| Endpoint                                                                  | Description                                                                                                    |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [Refreshing an anonymous token](/openapi/oauth/#operation/refreshAnonymousAccessToken) | The `anonymous_token` parameter is now deprecated. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-03-07"
/>

# 2024-03-07: Quote Service - generation of quotes using the customer's email and usage of service tokens possibility

**Overview**

We introduced a new attribute `customerEmail` for the quote creation schema that allows you to create a quote using the customer's email address.

We updated the Quote Service so that it allows for using a service token (generated from the API Keys in Developer Portal), which is not linked to any specific user.
You can perform all Quote Service API operations using the service token. The merchant and customer access tokens can still be used with the Quote API.
For more information, see [Developer Portal](https://developer.emporix.io/user-guides/getting-started/developer-portal/manage-apikeys).

**Updated endpoints**

| Endpoint                                                                  | Description                                                                                                    |
| ------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [Creating a new quote](/openapi/quote/#operation/POST-quote-create-quote)         | Use the `customerEmail` property to generate a quote for a user's contact email address instead of the customer ID.  |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-02-26"
/>

# 2024-02-26: Coupon Service - coupon code in both upper and lower cases

**Overview**

A new system preference `enableCouponCodeCaseSensitivity` is available. It allows you to save the coupon code both in upper and lower case.

**Updated endpoints**

| Endpoint                                                                  | Description                                                     |
| ------------------------------------------------------------------------- | --------------------------------------------------------------- |
| [Creating a new coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons)     | You can save the `code` property in both upper and lower case.  |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-02-26"
/>

# 2024-02-26: Webhook Service - custom headers

**Overview**

Config for HTTP provider is now enriched with the `headers` property. It allows you to define a list of custom headers which are added to the HTTP request.

**Updated endpoints**

| Endpoint                                                                      | Description                              |
| ----------------------------------------------------------------------------- | ---------------------------------------- |
| [Creating a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#post-webhook-tenant-config)                  | You can define custom `headers` in the request body. |
| [Updating a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#put-webhook-tenant-config-code)             | You can define custom `headers` in the request body. |
| [Partially updating a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#patch-webhook-tenant-config-code)   | You can define custom `headers` in the request body. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-02-22"
/>

# 2024-02-22: Invoice Service - invoice API

**Overview**

There is a new API for generating and verifying invoice creation tasks.

**New endpoints**

| Endpoint                                                                              | Description                      |
| ------------------------------------------------------------------------------------- | -------------------------------- |
| [Creating invoice job](/openapi/invoice/#operation/POST-invoice-create-job)          | It creates a new invoice job.     |
| [Retrieving invoice job](/openapi/invoice/#operation/GET-invoice-retrieve-job-and-order) | It retrieves invoice job details. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-02-09"
/>

# 2024-02-09: Category Service - `published` field for assignments

**Overview**

There is a new property `published` added to assignment model that is updated automatically based on product `published` attribute. It allows you to filter out assignments with unpublished products.

**Updated endpoints**

| Endpoint                                                                              | Description                                                                                                                                                    |
| ------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving category assignments](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#get-category-tenant-categories-categoryid-assignments)        | We introduced the `hideUnpublishedProducts` parameter. Additionally, we added the `published` attribute into the category assignment model. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-02-06"
/>

# 2024-02-06: Customer Management Service - contact to customer transformation

**Overview**

We introduced a new functionality for transforming a contact to a customer.
The transformation happens when `type` property is changed from `CONTACT` to `CUSTOMER`.
The action causes sending two emails (if the emails are configured):
* reset password email
* account activation confirmation email

**Updated endpoints**

| Endpoint                                                                                      | Description                                                                                        |
| --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| [Updating customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber)  | We introduced logic for changing a type from `CONTACT` to `CUSTOMER`. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-02-05"
/>

# 2024-02-05: Customer Management Service - `contactDetails.tags` field

**Overview**

The location model has a new `contactDetails.tags` property. It allows for labeling the location.

**Updated endpoints**

| Endpoint                                                                              | Description                                         |
| ------------------------------------------------------------------------------------- | --------------------------------------------------- |
| [Creating a location](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#post-tenant-locations)          | Type property `contactDetails.tags` added. |
| [Retrieving all locations](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#get-tenant-locations)   | Type property `contactDetails.tags` added. |
| [Retrieving a location](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#get-tenant-locations-locationid)           | Type property `contactDetails.tags` added. |
| [Upserting a location](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/locations#put-tenant-locations-locationid)             | Type property `contactDetails.tags` added. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-02-05"
/>

# 2024-02-05: Cart Service - making cart item properties optional

**Overview**

Property `price.currency` for a cart item can be set as optional. There are new system preferences that allow you to disable validation for the property.

**Updated endpoints**

| Endpoint                                                                                          | Description                                                                                      |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| [Adding multiple products to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-itemsbatch)  | Property `price.currency` can be optional. Validation is configurable by the system preferences. |
| [Adding a product to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items)               | Property `price.currency` can be optional. Validation is configurable by the system preferences. |
| [Updating a cart item](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#put-cart-tenant-carts-cartid-items-itemid)             | Property `price.currency` can be optional. Validation is configurable by the system preferences. |

**Known problems**

There are no known problems.

---

<Badge tag="minor"
date="2024-01-23"
/>

# 2024-01-23: Webhook Service - configuration API update

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

We extended `config` API. `PATCH` operation is now available and `DELETE` endpoint now includes the `force` flag.

**Updated endpoints**

| Endpoint                                                                      | Description                                         |
| ----------------------------------------------------------------------------- | --------------------------------------------------- |
| [Removing a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#delete-webhook-tenant-config-code)            | We added the `force` flag, which allows you to remove active configs.  |

**Added endpoints**

| Endpoint                                                                      | Description                                         |
| ----------------------------------------------------------------------------- | --------------------------------------------------- |
| [Partially updating a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#patch-webhook-tenant-config-code)   | It partially updates a webhook config.                  |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-01-22"
/>

# 2024-01-22: Availability Service - support for mixins

**Overview**

Availability Service from now on supports the mixins feature. Two new properties are available in the model - `mixins` and `metadata.mixins`.

**Updated endpoints**

| Endpoint                                                                                                 | Description                                     |
| -------------------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| [Retrieving all availabilities for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-site-site)       | We added the `mixins` and `metadata.mixins` properties. |
| [Retrieving an availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)           | We added the `mixins` and `metadata.mixins` properties. |
| [Creating an availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site)            | We added the `mixins` and `metadata.mixins` properties. |
| [Upserting availability information of a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#put-availability-tenant-availability-productid-site) | We added the `mixins` and `metadata.mixins` properties. |
| [Retrieving product availabilities for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search)  | We added the `mixins` and `metadata.mixins` properties. |


**Known problems**

There are no known problems.

---

<Badge tag="newFeature"
date="2024-01-22"
/>

# 2024-01-22: Indexing Service - configuration API

**Overview**

We released new API for configuring indexing providers.
The functionality allows you to configure custom Algolia subscription and trigger reindexing the index.

**Added endpoints**

| Endpoint                                                                             | Description                          |
| ------------------------------------------------------------------------------------ | ------------------------------------ |
| [Creating a config](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#post-indexing-tenant-configurations)        | It creates a new index config.           |
| [Retrieving configs](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#get-indexing-tenant-configurations)    | It retrieves all index configs.          |
| [Updating a config](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#put-indexing-tenant-configurations-provider)           | It updates an index config.              |
| [Retrieving a config](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#get-indexing-tenant-configurations-provider)       | It retrieves an index config.            |
| [Removing a config](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/configuration#delete-indexing-tenant-configurations-provider)        | It removes an index config.              |
| [Retrieving public configs](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/public-configuration#get-indexing-tenant-public-configurations)| It retrieves all index public configs.   |
| [Retrieving a public config](https://developer.emporix.io/api-references/api-guides/configuration/indexing-service/api-reference/public-configuration#get-indexing-tenant-public-configurations-provider)| It retrieves an index public config.     |
| [Reindexing](/openapi/indexing/#operation/POST-indexing-reindex)                       | It triggers reindex operation.           |

**Known problems**

There are no known problems.

---

<Badge tag="newFeature"
date="2024-01-11"
/>

# 2024-01-11: Webhook Service - configuration API

{% hint style="warning" %}

This functionality is in preview mode — some of the features may not be fully operational yet.
{% endhint %}

**Overview**

We added new API for configuring webhook providers.

**Added endpoints**

| Endpoint                                                            | Description                     |
| ------------------------------------------------------------------- | ------------------------------- |
| [Creating a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#post-webhook-tenant-config)        | It creates a new webhook config.    |
| [Retrieving configs](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#get-webhook-tenant-config)         | It retrieves webhook configs.       |
| [Updating a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#put-webhook-tenant-config-code)   | It updates a webhook config.        |
| [Retrieving a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#get-webhook-tenant-config-code)   | It retrieves a webhook config.      |
| [Removing a config](https://developer.emporix.io/api-references/api-guides/webhooks/webhook-service/api-reference/config#delete-webhook-tenant-config-code)  | It removes a webhook config.        |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2024-01-02"
/>

# 2024-01-02: Schema Service - `CUSTOMER.ADDRESS` type support

**Overview**

We extended the schema with a new `CUSTOMER.ADDRESS` type.

**Updated endpoints**

| Endpoint                                                                 | Description                  |
| ------------------------------------------------------------------------ | ---------------------------- |
|[Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas)          | The new type is available. |
|[Updating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id)               | The new type is available. |
|[Updating types of a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#put-schema-tenant-schemas-id-types)| The new type is available. |
|[Creating a reference](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/reference#post-schema-tenant-references)    | The new type is available. |
|[Updating a reference](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/reference#put-schema-tenant-references-id)         | The new type is available. |

**Known problems**

There are no known problems.

---

