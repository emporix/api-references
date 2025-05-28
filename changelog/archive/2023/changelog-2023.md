---
icon: folder-open
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

<Badge
tag="minor"
date="2023-12-14"
/>

# 2023-12-14: Availability Service - removal of scopes from `GET` endpoint

**Overview**

The endpoint for getting product availability does not require any scopes anymore.

**Updated endpoints**

| Endpoint                                                                                            | Description                    |
| --------------------------------------------------------------------------------------------------- | ------------------------------ |
| [Retrieving product availability]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search) | The endpoint doesn't require scopes.   |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-12-14"
/>

# 2023-12-14: Shopping-list Service - new endpoints

We introduced new endpoints for shopping-list. They allow for managing a shopping-list either by an employee or by a customer (so far, only a customer was able to manage it).

**Added endpoints**

| Endpoint                                                                                              | Description                                                                                     |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| [Fetching all shopping lists]https://developer.emporix.io/api-references/api-guides-and-references/api-references/checkout/shopping-list/api-reference/shopping-lists)             | It fetches all shopping lists. The endpoint requires the `shoppinglist.shoppinglist_read` scope by an employee.  |
| [Creating a shopping list](/openapi/shopping-list/#operation/POST-shopping-list-create-shopping-list)               | It creates a shopping list. The endpoint requires the `shoppinglist.shoppinglist_manage` scope by an employee.   |
| [Updating a shopping list]https://developer.emporix.io/api-references/api-guides-and-references/api-references/checkout/shopping-list/api-reference/shopping-lists#put-shoppinglist-tenant-shopping-lists-customerid)     | It updates a shopping list. The endpoint requires the `shoppinglist.shoppinglist_manage` scope by an employee.   |
| [Removing a shopping list](/openapi/shopping-list/#operation/DELETE-shopping-list-remove-customer-shopping-list)  | It removes a shopping list. The endpoint requires the `shoppinglist.shoppinglist_manage` scope by an employee.   |
| [Fetching a shopping list]https://developer.emporix.io/api-references/api-guides-and-references/api-references/checkout/shopping-list/api-reference/shopping-lists#get-shoppinglist-tenant-shopping-lists-customerid)    | It fetches a shopping list. The endpoint requires the `shoppinglist.shoppinglist_read` scope by an employee.     |


---

<Badge
tag="deprecated"
date="2023-12-14"
/>

# 2023-12-14: Shopping-list Service - deprecation of endpoints

All deprecated endpoints will be removed on 2024/07/01.

**Deprecated endpoints**

| Endpoint                                                                            |
| ----------------------------------------------------------------------------------- |
| [Fetching all shopping lists](/openapi/shopping-list/#operation/GET_shopping-list)  |
| [Creating a shopping list](/openapi/shopping-list/#operation/POST_shopping-list)    |
| [Updating a shopping list](/openapi/shopping-list/#operation/PUT_shopping-list)     |
| [Removing a shopping list](/openapi/shopping-list/#operation/DELETE_shopping-list)  |
| [Fetching a shopping list](/openapi/shopping-list/#operation/GET_shopping-lists)    |


---

<Badge
tag="minor"
date="2023-12-07"
/>

# 2023-12-07: Coupon Service - creation of coupons after hard deletion

**Overview**

After a hard deletion of a coupon, it is now possible to create a new coupon with the same code and to reset redemptions count.

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-12-01"
/>

# 2023-12-01: Coupon Service - support for mixins

**Overview**

Coupon Service from now on supports the mixins feature. There are two new properties available - `mixins` and `metadata.mixins`, which allow you to work with custom fields.

**Updated endpoints**

| Endpoint                                                                            | Description                                     |
| ----------------------------------------------------------------------------------- | ----------------------------------------------- |
| [Retrieving coupons]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/coupon-management    | We added `mixins` and `metadata.mixins` properties. |
| [Creating a coupon]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons)                   | We added `mixins` and `metadata.mixins` properties. |
| [Retrieving a coupon]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/coupon-management#get-coupon-tenant-coupons-code)             | We added `mixins` and `metadata.mixins` properties. |
| [Updating a coupon]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/coupon-management#put-coupon-tenant-coupons-code)               | We added `mixins` and `metadata.mixins` properties. |
| [Partially updating a coupon]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/coupon-management#patch-coupon-tenant-coupons-code)   | We added `mixins` and `metadata.mixins` properties. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-11-23"
/>

# 2023-11-23: Cart Service - making cart item properties optional

**Overview**

Properties `price.originalAmount` and `price.effectiveAmount` for a cart item can be optional. There are new system preferences that allow you to disable validation of these properties.

**Updated endpoints**

| Endpoint                                                                                          | Description                                                                                                                          |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| [Adding multiple products to cart]https://developer.emporix.io/api-references/api-guides-and-references/api-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-itemsbatch)  | Properties `price.originalAmount` and `price.effectiveAmount` can be optional. Validation is configurable by the system preferences. |
| [Adding a product to cart]https://developer.emporix.io/api-references/api-guides-and-references/api-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items)               | Properties `price.originalAmount` and `price.effectiveAmount` can be optional. Validation is configurable by the system preferences. |
| [Updating a cart item](/openapi/cart/#operation/PUT-cart-update-item-details)             | Properties `price.originalAmount` and `price.effectiveAmount` can be optional. Validation is configurable by the system preferences. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-11-23"
/>

# 2023-11-23: Returns Service - `metadata.mixins` field

**Overview**

There is a new property added to return model - `metadata.mixins`. It allows for validation of mixins against a provided schema.

**Updated endpoints**

| Endpoint                                                                | Description                      |
| ----------------------------------------------------------------------- | -------------------------------- |
| [Creating a return](/openapi/returns/#operation/POST-returns-create-return)           | We added `metadata.mixins` property. |
| [Retrieving returns](/openapi/returns/#operation/GET-returns-list-returns)             | We added `metadata.mixins` property. |
| [Retrieving a return](/openapi/returns/#operation/GET-returns-retrieve-return)             | We added `metadata.mixins` property. |
| [Updating a return](/openapi/returns/#operation/PUT-returns-update-return)               | We added `metadata.mixins` property. |
| [Partially updating a return](/openapi/returns/#operation/PATCH-returns-update-return)   | We added `metadata.mixins` property. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-11-17"
/>

# 2023-11-17: Coupon Service - permanent deletion of coupons

**Overview**

There is new property in system preferences, which allows you to permanently delete coupons.
If the property is not set or is set to `false`, the delete coupon endpoint just flags the coupon as deleted.
If set to true, the endpoint permanently removes the coupon from the database.

**Updated endpoints**

| Endpoint                                                                           | Description                                                                                             |
| ---------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------|
| [Deleting a coupon]https://developer.emporix.io/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/coupon-management#delete-coupon-tenant-coupons-code)         | Depending on the configuration, it flags coupon as deleted or performs permanent deletion from database. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-11-14"
/>

# 2023-11-14: Webhook Service - new event types for Client Management Service

**Overview**

There are four new events which are emitted during: legal entity creation, legal entity update, legal entity deletion and when user is assigned to a legal entity.
For more information, check out [Client Management Service events](/content/events-client-management).

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-11-08"
/>

# 2023-11-08: Schema Service - new service

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

We released the Schema Service that provides validation of custom mixin fields.

**New endpoints**

| Endpoint                                                                  | Description                                                                                                     |
| ------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
|[Creating a schema](/openapi/schema/#operation/POST-schema-create-schema)          | It creates a new schema. The endpoint requires `schema.schema_manage` scope.                         |
|[Retrieving schemas](/openapi/schema/#operation/GET-schema-retrieve-schemas)                | It returns all schemas. The endpoint requires `schema.schema_read` scope.                            |
|[Retrieving a schema](/openapi/schema/#operation/GET-schema-retrieve-schema)                | It returns a schema. The endpoint requires `schema.schema_read` scope.                               |
|[Deleting a schema](/openapi/schema/#operation/DELETE-schema-remove-schema)               | It deletes a schema. The endpoint requires `schema.schema_manage` scope.                             |
|[Updating a schema](/openapi/schema/#operation/PUT-schema-update-schema)               | It updates a schema. The endpoint requires `schema.schema_manage` scope.                             |
|[Updating types of a schema](/openapi/schema/#operation/PUT-schema-update-schema-types)| It updates types of a schema. The endpoint requires `schema.schema_manage` scope.                    |
|[Retrieving types](/openapi/schema/#operation/GET-schema-retrieve-schema-types)                    | It returns types. The endpoint requires `schema.schema_read` scope.                                  |
|[Providing a file](/openapi/schema/#operation/POST-schema-parse-schema-file)      | It parses json schema and returns parsing results. The endpoint requires `schema.schema_read` scope. |
|[Creating a reference](/openapi/schema/#operation/POST-schema-create-reference)    | It creates a new reference. The endpoint requires `schema.schema_manage` scope.                      |
|[Retrieving references](/openapi/schema/#operation/GET-schema-retrieve-references)          | It returns all references. The endpoint requires `schema.schema_read` scope.                         |
|[Retrieving a reference](/openapi/schema/#operation/GET-schema-retrieve-reference)          | It returns a reference. The endpoint requires `schema.schema_read` scope.                            |
|[Deleting a reference](/openapi/schema/#operation/DELETE-schema-remove-reference)         | It deletes a reference. The endpoint requires `schema.schema_manage` scope.                          |
|[Updating a reference](/openapi/schema/#operation/PUT-schema-update-reference)         | It updates a reference. The endpoint requires `schema.schema_manage` scope.                          |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-11-08"
/>

# 2023-11-08: Product Service - update of multiple products

**Overview**

The Product Service API has a new endpoint to update multiple products in bulk.
Response for a particular product is returned at the same position (index) at which that product is located in the request body.

**New endpoints**

| Endpoint                                                                           | Description               |
| ---------------------------------------------------------------------------------- | --------------------------|
| [Upserting multiple products]https://developer.emporix.io/api-references/api-guides-and-references/api-references/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk) | It updates products in bulk. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-11-07"
/>

# 2023-11-07: Customer Service (customer-managed) - `type` property

**Overview**

There is a new property in the Customer object. The property is related to the Customer and Contact functionality.
It indicates that a particular customer is a standard customer that has access to a storefront, or that the customer is a contact person.
If the `type` field is not provided, the customer is recognized as a standard customer with a storefront access.

**Updated endpoints**

| Endpoint | Description |
| --- | --- |
| [Updating a customer profile](/openapi/customer-customer/#operation/PATCH-customer-update-customer)| We added `type` property. |
| [Retrieving a customer profile]https://developer.emporix.io/api-references/api-guides-and-references/api-references/companies-and-customers/customer-management/account-and-profile)| We added `type` property. |
| [Creating a new customer](/openapi/customer-customer/#operation/POST-customer-create-customer-account)| We added `type` property. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-11-07"
/>

# 2023-11-07: Customer Service (customer-managed) - company registration ID property

**Overview**

A new property is available in the Customer object. The property is related to the Customer Rights and Roles functionality.
It indicates if a particular customer is assigned to a particular company. If you provide the company registration ID during the customer sign up,
such customer is assigned to existing company straight away. If the company does not exist, it will be created.

**Updated endpoints**

| Endpoint | Description |
| --- | --- |
| [Patch a customer profile](/openapi/customer-customer/#operation/PATCH-customer-update-customer)| Company registration ID property has been added. |
| [Get a customer profile]https://developer.emporix.io/api-references/api-guides-and-references/api-references/companies-and-customers/customer-management/account-and-profile)|  Company registration ID property has been added. |
| [Post a new customer](/openapi/customer-customer/#operation/POST-customer-create-customer-account)| Company registration ID property has been added. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-11-07"
/>

# 2023-11-07: Customer Service (tenant-managed) - company registration ID property and new scopes

**Overview**

The Customer object has a new property. The property is related to the Customer Rights and Roles functionality.

We added a new scope `customer.customer_read_own` to the GET customers endpoints. The scope allows users to read customers, who are assigned to the same company.
We added a new scope `customer.customer_manage_own` to the endpoints. The scope allows users to manage customers who are assigned to the same company.

**Updated endpoints**

| Endpoint | Description |
| --- | --- |
| [Getting customers]https://developer.emporix.io/api-references/api-guides-and-references/api-references/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers)| We added the company registration ID property and the `customer.customer_read_own` scope. |
| [Creating a customer](/openapi/customer-tenant/#operation/POST-customer-tenant-create-customer)| We added the company registration ID property and the `customer.customer_manage_own` scope. |
| [Patching a customer](/openapi/customer-tenant/#operation/PATCH-customer-tenant-update-customer)| We added the company registration ID property and the `customer.customer_manage_own` scope. |
| [Getting a single customer]https://developer.emporix.io/api-references/api-guides-and-references/api-references/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers-customernumber)| We added the company registration ID property and the `customer.customer_read_own` scope. |
| [Deleting a customer](/openapi/customer-tenant/#operation/DELETE-customer-tenant-remove-customer)| We added the `customer.customer_read_own` scope. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-11-07"
/>

# 2023-11-07: IAM service - new endpoint and scopes

**Overview**

IAM service is enhanced with new scopes to give customers more access rights.
A new endpoint was added for retrieving customer scopes.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Retrieving own scopes](/openapi/iam/#operation/GET-iam-retrieve-own-user-scopes)| It allows the customer to get their own scopes. |

**Updated endpoints**

| Endpoint | Description |
| --- | --- |
| [Retrieving all groups](/openapi/iam/#operation/GET-iam-list-tenant-user-groups)| The added `iam.group_read_own` scope allows customers to read the groups of customer types. |
| [Retrieving users assigned to a group](/openapi/iam/#operation/GET-iam-list-group-users)| The added `iam.user_read_own` scope allows customers to read user assignments. The users have to be from the same company. |
| [Adding a user to a group](/openapi/iam/#operation/POST-iam-add-user-to-group)| The added `iam.assignment_create_own` scope allows customers to assign other users to the group. The users have to be from the same company. |
| [Removing a user from a group](/openapi/iam/#operation/DELETE-iam-remove-user-from-group)| The added `iam.assignment_delete_own` scope allows customers to unassign users from the group. The users have to be from the same company. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-11-07"
/>

# 2023-11-07: Approval Service - new service

**Overview**

We released the Approval Service.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Creating an approval](/openapi/approval/#operation/POST-approval-create-approval)| It creates a new approval. The endpoint requires the `approval.approval_manage_own` scope. |
| [Retrieving a list of approvals](/openapi/approval/#operation/GET-approval-list-approvals)| It gets all the approvals assigned to the user. The endpoint requires the `approval.approval_read_own` scope. |
| [Retrieving an approval](/openapi/approval/#operation/GET-approval-retrieve-approval)| It gets a single approval by ID assigned to the user. The endpoint requires the `approval.approval_read_own` scope. |
| [Updating an approval](/openapi/approval/#operation/PATCH-approval-update-approval)| It updates an approval by ID. The endpoint requires the `approval.approval_manage_own` scope. |
| [Deleting an approval](/openapi/approval/#operation/DELETE-approval-remove-approval)| It deletes an approval by ID. The endpoint requires the `approval.approval_manage_own` scope. |
| [Checking the resource approval](/openapi/approval/#operation/POST-approval-check-approval)| It checks if the user has permission to perform given action on the resource. The endpoint requires the `approval.approval_read_own` scope. |
| [Searching for approver users](/openapi/approval/#operation/POST-approval-search-users)| It retrieves all the users who can approve the approval for a given action on the resource. The endpoint requires the `approval.approval_read_own` scope. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-10-30"
/>

# 2023-10-30: Returns Service - assisted buying property

**Overview**

The Return object was expanded with a new property. The property is related to Assisted Buying functionality and it indicates that a particular action has been performed by an employee on behalf of a customer.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Retrieving a list of returns](/openapi/returns/#operation/GET-returns-list-returns)| We added assisted buying property. |
| [Retrieving a single return](/openapi/returns/#operation/GET-returns-retrieve-return)| We added assisted buying property. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-10-26"
/>

# 2023-10-26: Order Service - assisted buying property

**Overview**

Order object was expanded with a new property. The property is related to Assisted Buying functionality and it indicates that a particular action has been performed by an employee on behalf of a customer.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Retrieving orders]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)| We added assisted buying property. |
| [Retrieving a specific order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid)| We added assisted buying property. |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-10-26"
/>

# 2023-10-26: Site Setting Service - assisted buying property

**Overview**

The Site object was expanded with a new property. The property is related to Assisted Buying functionality and it provides an information about the storefront URL that should be opened when the action is triggered.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Retrieving sites]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings)| We added assisted buying property. |
| [Retrieving a site]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode)| We added assisted buying property. |
| [Creating a site]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#post-site-tenant-sites)| We added assisted buying property. |
| [Updating a site]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#put-site-tenant-sites-sitecode)| We added assisted buying property. |
| [Partially updating a site]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#patch-site-tenant-sites-sitecode)| We added assisted buying property. |

**Known problems**

There are no known problems.

---
<!-- hidden assisted buying
<Badge
tag="newFeature"
date="2023-10-26"
/>

# Customer Service (tenant-managed) - assisted buying login endpoint


**Overview**

The functionality provides a possibility to generate an auth token by an employee on behalf of a customer.
Only the employees that belong to the support group, meaning they have `customer.assistedBuying_manage` scope assigned, can perform the action.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Generating a customer token](/openapi/customer-tenant/#operation/POST-customer-tenant-assisted-buying-login)| It generates an auth token on behalf of a customer. |

**Known problems**

There are no known problems.

---
-->

<Badge
tag="minor"
date="2023-10-27"
/>

# 2023-10-27: Webhook Service - new event types for customer service

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

There are five new events which are emitted during: customer creation, customer update, customer deletion, sending a request to reset a customer's password and resending an account activation link to a customer.
For more information, check out [Customer Service events](/content/events-customer).

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-09-06"
/>

# 2023-09-06: AI Service - new service

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The service facilitates and streamlines e-commerce processes of product marketing.

**Key Features**

* Integration with https://platform.openai.com/ platform
* Possibility to generate product descriptions

**New endpoints**

| Endpoint                                                                 | Description                                    |
| ------------------------------------------------------------------------ | ---------------------------------------------- |
| [Generating text for an object description](/openapi/ai/#operation/POST-ai-generate-description)       | It generates a text based on a prompt. Currently supported AI engines for text generation: https://platform.openai.com/.  |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-08-07"
/>

# 2023-08-07: Reward Points Service - redeem option

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Reward Points Service is enhanced with the new endpoint, which allows employees to update redeem options. We also added metadata to redeem options and from now on when you create a redeem option, metadata is added to it. When retrieving redeem options, the ones without metadata are decorated with metadata version 1.

**New endpoints**

| Endpoint                                                                 | Description                                    |
| ------------------------------------------------------------------------ | ---------------------------------------------- |
| [Updating redemption option](/openapi/reward-points/#operation/PUT-reward-points-update-redeem-option)       | It updates redeem option with given information. |

**Updated endpoints**

| Endpoint                                          | Description                               |
| ------------------------------------------------- | ----------------------------------------- |
| [Creating redemption option](/openapi/reward-points/#operation/POST-reward-points-create-redeem-options) | It creates a redeem option for a given tenant.  |
| [Retrieving redemption options](/openapi/reward-points/#operation/GET-reward-points-list-redeem-options) | It gets a redeem option for a given tenant.     |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-08-07"
/>

# 2023-08-07: Reward Points Service - deleting redeem option

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Reward Points Service was enhanced with the new endpoint, which allows employees to delete redeem options by id.

**New endpoints**

| Endpoint                                                                 | Description                                    |
| ------------------------------------------------------------------------ | ---------------------------------------------- |
| [Deleting redemption options](/openapi/reward-points/#operation/DELETE-reward-points-remove-redeem-option) | It deletes redeem option by id for a given tenant. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-08-02"
/>

# 2023-08-02: Shipping Service - delivery day shift and time zones support

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Delivery Cycle Management functionality was updated with several new features to enhance user experience and efficiency. It now includes the `Delivery Day Shift` attribute, which offers users control over the delay period between the cut-off day and the delivery day. To make delivery timings more comprehensible, the functionality now supports timezone specifications, making it clear for which timezone the delivery time is defined.


**Updated endpoints**

| Endpoint                                                                                                                        | Description                                                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [Retrieving all delivery times](/openapi/shipping/#operation/GET-shipping-list-delivery-times)                                           | It returns all the delivery times defined for the given tenant.          |
| [Creating a delivery time](/openapi/shipping/#operation/POST-shipping-create-delivery-time)                                               | It creates a single delivery time.                                       |
| [Creating multiple delivery times](/openapi/shipping/#operation/POST-shipping-create-delivery-times-bulk)                                  | It creates multiple delivery times in a single request.                  |
| [Getting a delivery time](/openapi/shipping/#operation/GET-shipping-retrieve-delivery-time)                                                   | It retrieves a specific delivery time.                                   |
| [Updating a delivery time](/openapi/shipping/#operation/PUT-shipping-update-delivery-time)                                 | It updates a single delivery time with a given information.              |
| [Partial updating of a delivery time](/openapi/shipping/#operation/PATCH-shipping-update-delivery-time)                    | It partially updates a single delivery time with a given information.    |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-07-11"
/>

# 2023-07-11: Shipping Service - delivery cycle management

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Delivery Cycle Management functionality allows for more detailed way of controlling delivery process. It includes creating multiple slots for a single delivery time each with different cut-off times.

**New endpoints**

| Endpoint                                                                                                                          | Description                                                           |
| -------------------------------------------------------------------------------------------------------------------------------   | --------------------------------------------------------------------- |
| [Retrieving all delivery times](/openapi/shipping/#operation/GET-shipping-list-delivery-times)                                           | It returns all the delivery times defined for the given tenant.          |
| [Creating a delivery time](/openapi/shipping/#operation/POST-shipping-create-delivery-time)                                               | It creates a single delivery time.                                       |
| [Creating multiple delivery times](/openapi/shipping/#operation/POST-shipping-create-delivery-times-bulk)                                  | It creates multiple delivery times in a single request.                  |
| [Getting a delivery time](/openapi/shipping/#operation/GET-shipping-retrieve-delivery-time)                                                   | It retrieves a specific delivery time.                                   |
| [Updating a delivery time](/openapi/shipping/#operation/PUT-shipping-update-delivery-time)                                 | It updates a single delivery time with a given information.              |
| [Partial updating of a delivery time](/openapi/shipping/#operation/PATCH-shipping-update-delivery-time)                    | It partially updates a single delivery time with a given information.    |
| [Deleting a delivery time](/openapi/shipping/#operation/DELETE-shipping-remove-delivery-time)                              | It deletes a specific delivery time with all slots that it had created.  |
| [Getting all the delivery time slots](/openapi/shipping/#operation/GET-shipping-retrieve-delivery-time-slots)                                 | It retrieves all the slots for a given delivery time.                    |
| [Creating a delivery time slot](/openapi/shipping/#operation/POST-shipping-create-delivery-time-slot)                     | It creates a new time slot for the given delivery time.                  |
| [Deleting all the delivery time slots](/openapi/shipping/#operation/DELETE-shipping-remove-all-delivery-times-slots)            | It deletes all the time slots for the given delivery time.               |
| [Getting a delivery time slot](/openapi/shipping/#operation/PATCH-shipping-update-delivery-time-slot)              | It retrieves the given delivery time slot's details.                     |
| [Updating a delivery time slot](/openapi/shipping/#operation/PUT-shipping-update-delivery-time-slot)               | It updates a single delivery time slot with given information.           |
| [Partial updating of a delivery time slot](/openapi/shipping/#operation/PATCH-shipping-update-delivery-time-slot)  | It partially updates a single delivery time slot with given information. |
| [Deleting a delivery time slot](/openapi/shipping/#operation/DELETE-shipping-remove-delivery-times-slot)            | It deletes a single delivery time slot.                                  |
| [Generating a delivery cycle](/openapi/shipping/#operation/POST-shipping-generate-delivery-cycle)                                  | It generates a delivery cycle.                                           |

**Updated endpoints**

| Endpoint                                                                                                                        | Description                                                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [Increasing the delivery window counter](/openapi/quote/#operation/POST-shipping-increase-orders-number-in-delivery-window)             | Request body contains one new property - `slotId`.                                                                                                                                                            |
| [Retrieving delivery windows by cart](/openapi/shipping/#operation/GET-shipping-retrieve-actual-delivery-window)                     | Response contains new properties - `slotId`, `deliveryMethod`, `cutOffTime`, `cutOfDay`, `deliveryCycle`.                                                                                                    |
| [Retrieving delivery windows by delivery area](/openapi/shipping/#operation/GET-shipping-retrieve-delivery-times-for-delivery-area) | Endpoint was deprecated.                                                                                                                                                                                      |
| [Finding sites by postal code](/openapi/shipping/#operation/POST-shipping-find-sites)                                               | Response contains new properties - `zones.actualDeliveryWindows.deliveryCycle`, `zones.actualDeliveryWindows.deliveryMethod`, `zones.actualDeliveryWindows.cutOffTime`, `zones.actualDeliveryWindows.slotId`. |
| [Retrieving orders](/openapi/order/#operation/GET_tenant-salesorders)                                                           | Response contains a new property - `deliveryWindow`.                                                                                                                                                         |
| [Creating a new order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)                                                       | Request body contains a new property - `deliveryWindow`.                                                                                                                                                     |
| [Retrieving a specific order by ID]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid)                                   | Response contains a new property - `deliveryWindow`.                                                                                                                                                         |
| [Updating an order](/openapi/order/#operation/PUT-order-update-order)                                                   | Request body contains a new property - `deliveryWindow`.                                                                                                                                                     |
| [Partially updating an order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#put-order-v2-tenant-salesorders-orderid)                                       | Request body contains a new property - `deliveryWindow`.                                                                                                                                                     |
| [Retrieving a list of orders](/openapi/order/#operation/GET-order-list-orders)                                                      | Response contains a new property - `deliveryWindow`.                                                                                                                                                         |
| [Creating a new order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-customer-managed#post-order-v2-tenant-orders)                                                            | Request body contains a new property - `deliveryWindow`.                                                                                                                                                     |
| [Retrieving order details]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders-orderid)                                                 | Response contains a new property - `deliveryWindow`.                                                                                                                                                         |
| [Creating a new cart](/openapi/cart/#operation/POST-cart-create-cart)                                                               | Request body contains a new property - `deliveryWindow`.                                                                                                                                                     |
| [Retrieving a cart's details by criteria]https://developer.emporix.io/api-references/api-guides-and-references/api-references/checkout/cart/api-reference/carts#get-cart-tenant-carts)                                            | Response contains a new property - `deliveryWindow`.                                                                                                                                                         |
| [Retrieving a cart's details by ID]https://developer.emporix.io/api-references/api-guides-and-references/api-references/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid)                                           | Response contains a new property - `deliveryWindow`.                                                                                                                                                         |
| [Updating a cart](/openapi/cart/#operation/PUT-cart-update-cart)                                                             | Request body contains a new property - `deliveryWindow`.                                                                                                                                                     |

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-07-11"
/>

# 2023-07-11: Payment Gateway Service - new service

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

We released the Payment Gateway Service.

**New endpoints**

| Endpoint                                                                     | Description                                                                        |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
|[Creating a new payment mode](/openapi/payment-gateway/#tag/Payment-mode)| It creates a new payment mode. The endpoint requires `payment-gateway.paymentmodes_manage` scope. |
|[Updating an existing payment mode](/openapi/payment-gateway/#operation/PUT-payment-gateway-update-payment-mode)| It updates an existing payment mode. The endpoint requires `payment-gateway.paymentmodes_manage` scope. |
|[Deleting an existing payment mode](/openapi/payment-gateway/#operation/DELETE-payment-gateway-remove-payment-mode)| It deletes an existing payment mode. The endpoint requires `payment-gateway.paymentmodes_manage` scope.|
|[Fetching payment modes](/openapi/payment-gateway/#operation/GET-payment-gateway-list-payment-modes)| It fetches a list of configured payment modes. The endpoint requires `payment-gateway.paymentmodes_read` scope.|
|[Fetching payment mode](/openapi/payment-gateway/#operation/GET-payment-gateway-retrieve-payment-mode)| It fetches a single, configured payment mode. The endpoint requires `payment-gateway.paymentmodes_read` scope.|
|[Fetching payment modes publicly](/openapi/payment-gateway/#operation/GET-payment-gateway-retrieve-payment-modes-frontend)| It fetches a list of configured payment modes. The endpoint does not require any scope to be invoked and it returns properties that can be considered as publicly available. It can be used on a frontend.|
|[Fetching payment modes publicly](/openapi/payment-gateway/#operation/GET-payment-gateway-retrieve-payment-mode-frontend)| It fetches a single, configured payment mode. The endpoint does not require any scope to be invoked and it returns properties that can be considered as publicly available. It can be used on a frontend.|
|[Authorizing a payment](/openapi/payment-gateway/#tag/Payment)| It authorizes a given payment. The endpoint requires `payment-gateway.authorize_manage` scope.|
|[Capturing a payment](/openapi/payment-gateway/#operation/POST-payment-gateway-capture-payment)| It captures a given payment. The endpoint requires `payment-gateway.capture_manage` scope.|
|[Refunding a payment](/openapi/payment-gateway/#operation/POST-payment-gateway-refund-payment)| It refunds a given payment. The endpoint requires `payment-gateway.refund_manage` scope.|
|[Cancelling a payment](/openapi/payment-gateway/#operation/POST-payment-gateway-cancel-payment)| It captures a given payment. The endpoint requires `payment-gateway.cancel_manage` scope.|
|[Fetching transactions](/openapi/payment-gateway/#operation/GET-payment-gateway-list-transactions)| It fetches a list of payment transactions. The endpoint requires `payment-gateway.paymenttransactions_read` scope.|
|[Fetching transaction](/openapi/payment-gateway/#operation/GET-payment-gateway-retrieve-transaction-by-transactionId)| It fetches a single payment transaction. The endpoint requires `payment-gateway.paymenttransactions_read` scope.|

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-06-01"
/>

# 2023-06-01: Webhook Service - new event `order.deleted` type

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The event is emitted when an order is being deleted. For more information, check out [Order Service events](/content/events-order).

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-05-30"
/>

# 2023-05-30: Category Service - new `code` property

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Category Service API has been enhanced with the new property - `code`.

**New endpoints**

No new endpoints have been introduced.

**Updated endpoints**

| Endpoint                                                                     | Description                                                                        |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
|[Creating a new category](/openapi/category/#operation/create)| The category resource now contains the `code` property. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-05-26"
/>

# 2023-05-26: Product Service - creation of multiple products

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Product Service API has been enhanced with the new endpoint to create multiple products in bulk.
The endpoint accepts a list of products. Recommended size of a particular batch is up to 500 products.
Response for a particular product is returned at the same position (index) at which that product is located in the request body.

**New endpoints**

| Endpoint                                                                     | Description                                                                        |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| [Creating multiple products]https://developer.emporix.io/api-references/api-guides-and-references/api-references/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk)| It creates products in bulk. Recommended size of a particular batch is up to 500 products. |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-05-25"
/>

# 2023-05-25: IAM Service - new `b2b` property

{% hint style="warning" %}
This functionality is now fully operational.
{% endhint %}

**Overview**

The IAM Service API contains a new property - `b2b`. Users are now able to link the identifier of legal entity with the tenant group.

**Updated endpoints**

| Endpoint                                                                     | Description                                                                        |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| [Retrieving all groups](/openapi/iam/#operation/GET-iam-list-tenant-user-groups) | The `b2b.legalEntityId` property indicates the legal entity for which the group has been created.|
| [Retrieving a group](/openapi/iam/#operation/GET-iam-retrieve-user-group)| The `b2b.legalEntityId` property indicates the legal entity for which the group has been created. |
| [Creating a new group](/openapi/iam/#operation/POST-iam-create-user-group) | The `b2b.legalEntityId` property indicates the legal entity for which the group has been created.|
| [Upserting a group](/openapi/iam/#operation/PUT-iam-update-user-group) | The `b2b.legalEntityId` property indicates the legal entity for which the group has been created.|
**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-05-25"
/>

# 2023-05-25: Customer-Management Service - new `customermanagement.legalentity_read_own` scope

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Customer-Management Service API has been enhanced with the new scope - `customermanagement.legalentity_read_own`.
Customers are now able to retrieve all their legal entities with the `customermanagement.legalentity_read_own` scope.

**Updated endpoints**

| Endpoint                                                                                        | Description                                                                                                                |
| ----------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| [Retrieving all legal entities](/openapi/customer-management/#operation/GET-customer-mgmt-list-legal-entities) | There is a possibility to retrieve legal entities of the customer using new `customermanagement.legalentity_read_own` scope.|

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-05-24"
/>

# 2023-05-24: Quote Service - quote reasons

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The quote reason functionality enables the creation and management of quote reasons. Quote reasons contain information why a given quote was declined or a change was requested. They are defined as separate entities through dedicated API and can be used as a reference during status change of the quote.

**New endpoints**

| Endpoint                                                                                              | Description                         |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------- |
| [Creating a quote reason](/openapi/quote/#operation/POST-quote-create-quote-reason)                        | It creates a new quote reason.         |
| [Updating a quote reason](/openapi/quote/#operation/PUT-quote-update-reason)                         | It updates an existing quote reason.   |
| [Deleting a quote reason](/openapi/quote/#operation/DELETE-quote-remove-reason)        | It deletes an existing quote reason.   |
| [Retrieving quote reasons](/openapi/quote/#operation/GET-quote-list-reasons)                               | It gets a list of quote reasons.       |
| [Retrieving a single quote reason](/openapi/quote/#operation/GET-quote-retrieve-reason)  | It gets a single quote reason.         |

**Updated endpoints**

| Endpoint                                                                                 | Description                                                                                                                                                                              |
| ---------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Partially updating a quote](/openapi/quote/#operation/PATCH-quote-update-quote)              | The quote has the `quoteReasonId` property as part of the status which should be provided when changing status of the quote to `DECLINED`, `DECLINED_BY_MERCHANT` or `IN_PROGRESS`.  |
| [Retrieving a single quote]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid)        | The quote can contain `quoteReason` object as part of the `status` field.                                                                                                                |
| [Retrieving quotes]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes)                         | The quote can contain `quoteReason` object as part of the `status` field.                                                                                                                |
| [Retrieving quote history]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid-history) | Changelogs contain changes of the quotes containing quote reasons reference.                                                                                                             |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-05-23"
/>

# 2023-05-23: Quote Service - shipping information in a quote

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Quote Service API has been enhanced with `shipping` object. Users are now able to specify shipping of the quote.

**Updated endpoints**

| Endpoint                                                                                 | Description                                                                 |
| ---------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| [Retrieving quotes]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes)                         | The quote has the `shipping` object required to the checkout process. |
| [Retrieving a single quote]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid)        | The quote has the `shipping` object required to the checkout process. |
| [Partially updating a quote](/openapi/quote/#operation/PATCH-quote-update-quote)              | The `shipping` object can be updated by the PATCH endpoint.                 |
| [Creating a quote](/openapi/quote/#operation/POST-quote-create-quote)                          | A new optional field `shipping` was added for quote creation.        |
| [Retrieving quote history]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid-history) | Changelogs contain changes of the shipping.                                 |

**Known problems**

There are no known problems.

---

<Badge
tag="major"
date="2023-05-23"
/>

# 2023-05-23: Order Service - tax of the shipping cost

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Order Service now contains the tax of the shipping costs. Previously, the order did not store the information about the tax or the tax rate of the shipping costs.

**Updated endpoints**


| Endpoint                                                                                    | Description                                                                         |
| ------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| [Creating a sales order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)                 | The shipping line of the response body contains the optional `tax` object. |
| [Retrieving a single sales order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid) | The shipping line of the response body contains the `tax` object.          |
| [Retrieving sales order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)                  | The shipping line of the response body contains the `tax` object.          |
| [Creating an order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-customer-managed#post-order-v2-tenant-orders)                           | The shipping line of the response body contains the optional `tax` object. |
| [Retrieving a single order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders-orderid)            | The shipping line of the response body contains the `tax` object.          |
| [Retrieving orders](/openapi/order/#operation/GET-order-list-orders)                            | The shipping line of the response body contains the `tax` object.          |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-05-23"
/>

# 2023-05-23: Checkout Service - quote checkout process

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Checkout Service API has been enhanced with the checkout process of the quote. When the request contains `quoteId` field, the checkout is triggered for the given quote.

**Updated endpoints**

| Endpoint                                                                          | Description                                                                                                                                                                                                                    |
| --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [Triggering a checkout](/openapi/checkout/#operation/POST-checkout-trigger-checkout) | The `triggering a checkout` request contains the optional `quoteId` field. In case of triggering a checkout of the quote, the `shipping`, `addresses`, and `customer` information is fetched directly from the quote. |

**Known problems**

There are no known problems.

---

<Badge
tag="major"
date="2023-05-23"
/>

# 2023-05-23: Quote Service - new `orderId` property

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Quote Service API has been enhanced with the new property - `orderId`. Users are now able to see the order id from an order created based on the quote.

**Updated endpoints**

| Endpoint                                                                          | Description                                                           |
| --------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| [Retrieving quotes]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes)                  | It gets the order id from an order that was created basing on the quote. |
| [Retrieving a single quote]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid) | It gets the order id from an order that was created basing on the quote. |

**Known problems**

There are no known problems.

---

<Badge
tag="major"
date="2023-05-17"
/>

# 2023-05-17: Quote Service - mixins feature

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Quote Service API has been enhanced with mixins feature. Users are now able to add, manage and read the mixins custom properties.

**Updated endpoints**

| Endpoint                                                                                 | Description                                                             |
| ---------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| [Retrieving quotes]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes)                         | New properties provide support for mixins and mixins metadata.     |
| [Retrieving a single quote]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid)        | New properties provide support for mixins and mixins metadata.     |
| [Partially updating a quote](/openapi/quote/#operation/PATCH-quote-update-quote)              | New paths provide support for updating mixins and mixins metadata. |
| [Creating a quote](/openapi/quote/#operation/POST-quote-create-quote)                          | New properties provide support for mixins and mixins metadata.     |
| [Retrieving quote history]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid-history) | Changelogs contain changes in the mixins and mixins metadata.           |

**Known problems**

There are no known problems.

---

<Badge
tag="minor"
date="2023-05-12"
/>

# 2023-05-12: Order Service - new `quoteId` property

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Order Service API has been enhanced with the new property - `quoteId`. Merchants are now able to see the id of the quote from which the order has been created.

**Updated endpoints**

| Endpoint                                                                         | Description                                                          |
| -------------------------------------------------------------------------------- | -------------------------------------------------------------------- |
| [Creating an order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)           | This property indicates from which quote the order has been created. |
| [Getting a list of the orders]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders) | This property indicates from which quote the order has been created. |
| [Getting an order]https://developer.emporix.io/api-references/api-guides-and-references/api-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid)     | This property indicates from which quote the order has been created. |

**Known problems**

There are no known problems.

---

<Badge
tag="major"
date="2023-04-04"
/>

# 2023-04-04: Reward Points Service - order status changes

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Reward Points Service reacts now on the order status changes. When the order status is changed to `COMPLETED`, the reward points are added to the customer account.

**New endpoints**

No new endpoints have been introduced.

**Known problems**

There are no known problems.

---

<Badge
tag="newFeature"
date="2023-03-31"
/>

# 2023-03-31:Quote Service - management of quotations

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The quote management functionality enables the creation and management of quotations. Both the customer flow (accessible from the storefront) and the merchant flow (accessible from the Management Dashboard) are supported.

**New endpoints**

| Endpoint | Description |
| --- | --- |
| [Creating a quote](/openapi/quote/#operation/POST-quote-create-quote)| It creates a new quote. |
| [Partially updating a quote](/openapi/quote/#operation/PATCH-quote-update-quote) | It updates an existing quote. |
| [Deleting a quote](/openapi/quote/#operation/DELETE-quote-remove-quote) | It deletes an existing quote. |
| [Retrieving quotes]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes) | It gets a list of quotes. |
| [Retrieving a single quote]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid) | It gets a single quote. |
| [Retrieving quote history]https://developer.emporix.io/api-references/api-guides-and-references/api-references/quotes/quote/api-reference/quote-management#get-quote-tenant-quotes-quoteid-history) | It gets a single quote changelog. |
| [Creating a quote PDF](/openapi/quote/#operation/POST-quote-generate-quote-pdf) | It generates a quote PDF.|

**Known problems**

There are no known problems.

---

<Badge
tag="major"
date="2023-03-03"
/>

# 2023-03-03: Price Service (v2) - validation of mixins

{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}

**Overview**

The Price Service (v2) API has been enhanced with the validation of mixins. Before that, price mixins were not validated against any schema.

**New endpoints**

No new endpoints have been introduced.

**Known problems**

There are no known problems.

---

