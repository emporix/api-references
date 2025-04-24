---
seo:
  title: Customer Segment Service Tutorials
  description: customer segments
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Customer Segment Service Tutorials

Customer Segment Service allows you to group your customers in many convenient ways that suit different purposes. 
You can assign products or categories to create targeted marketing campaigns and display the relevant items on the storefront.
The flexible service's API facilitates configuring and managing customer segments.

## How to add a customer segment

{% endhint %}info

To create and configure a segment, you need the `customersegment.segment_manage` scope.
{% endhint %}

### Create a customer segment

Create a customer segment by sending a request to the the <nobr><Button to="/openapi/customer-segment/#operation/POST-customer-segment-create-segment" size="small">Creating a customer segment</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="POST-customer-segment-create-segment"
  defaultExample="Segment Creation"
/>

### Add products/categories to a segment 

Connect the segment with specific products and/or categories for more customized content. 

* To add an individual product or a category, call the <nobr><Button to="/openapi/customer-segment/#operation/PUT-customer-segment-update-item" size="small">Updating an item assignment</Button></nobr> 
endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="PUT-customer-segment-update-item"
  defaultExample="Item Assignment Update"
/>

* To assign multiple products or categories to the segment, call the <nobr><Button to="/openapi/customer-segment/#operation/PUT-customer-segment-update-items-bulk" size="small">Updating multiple item assignments</Button></nobr> 
endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="PUT-customer-segment-update-items-bulk"
  defaultExample="Item Assignment Update"
/>

{% hint style="warning" %}
Note that this operation performs an `UPSERT` operation. The `UPSERT` means that if an item is already assigned to a segment, the assignment gets updated. If not, the new one is created in the system.
{% endhint %}

### Add segment members

Now, add customers to the segment. Depending on your setup and purpose, you can add B2B or B2C customers.

* To add a B2B customer, send the request to the <nobr><Button to="/openapi/customer-segment/#operation/PUT-customer-segment-update-customer" size="small">[B2B] Updating a customer assignment</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="PUT-customer-segment-update-customer"
  defaultExample="Customer Assignment Update"
/>

* To add a B2C customer, send the request to the <nobr><Button to="/openapi/customer-segment/#operation/PUT-customer-segment-update-customer-by-customerId" size="small">[B2C] Updating a customer assignment</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="PUT-customer-segment-update-customer-by-customerId"
  defaultExample="Customer Assignment Update"
/>

* To add multiple customers at once, send the request to the <nobr><Button to="/openapi/customer-segment/#operation/PUT-customer-segment-update-customers-bulk" size="small">Updating multiple customer assignments</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="PUT-customer-segment-update-customers-bulk"
  defaultExample="Customer Assignment Update"
/>

{% hint style="warning" %}
Note that this operation performs an `UPSERT` operation. The `UPSERT` means that if a customer is already assigned to a segment, the assignment gets updated. If not, the customer assignment is created in the system.
{% endhint %}

## How to find a specific segment using search parameters

{% endhint %}info

To search for a segment, you need the `customersegment.segment_read` scope to retrieve all customer segments.
{% endhint %}

You can use the search API to find a segment of your interest that match a specific criteria. Send the request to the <nobr><Button to="/openapi/customer-segment/#operation/POST-customer-segment-search-segments" size="small">Searching with parameters for customer segments</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="POST-customer-segment-search-segments"
  defaultExample="Search Segments"
/>

In the request body, pass the criteria you're looking for in the `q` parameter.

## How to apply a coupon to a segment

Optionally, you can offer a discount coupon to a customer segment. The coupon then applies only to the assigned products/categories and is valid only for the customers that are the segment members.
To create a coupon that is valid only for a specific segment, send the request to the <nobr><Button to="/openapi/coupon/#operation/POST-coupon-create-coupon" size="small">Creating a new coupon</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="coupon"
  operationId="POST-coupon-create-coupon"
  defaultExample="CreateSegmentRestrictedCoupon"
/>

Set the `segmentRestricted` parameter as `true` and specify the segments you want to apply the coupon to.

## How to use customer segments on a storefront

Having segments in place, you can use that functionality on your storefront. 
Depending on your business goals, you can utilize the segments differently. Decide whether you'd like to extend the assortment with the products/categories assigned to a given segment to, for example, promote certain items on your site.
Or, you'd rather limit products/categories visibility to only those that a segment defines for segment members, to be able to sell specified products through a channel that targets the right group of people.


### Retrieve all products and/or categories 

To display the content you want, first retrieve all the products/categories assigned to all segments that a customer is a member of.
Send the request to the <nobr><Button to="/openapi/customer-segment/#operation/GET-customer-segment-retrieve-segments-items" size="small">Retrieving all items assignments for all customer segments</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="GET-customer-segment-retrieve-segments-items"
/>

Depending on your needs, you can limit the search using the `q` parameter, for example, `q=type:PRODUCT` or `q=type:CATEGORY`. 

### Use the segment information

If you want to use segments to restrict the content on your storefront, to display only the product and categories assigned to a segment for segment customers, use the endpoint to build a segment-based category tree. 
Send the request to the <nobr><Button to="/openapi/customer-segment/#operation/GET-customer-segment-retrieve-category-trees" size="small">Retrieving category trees for a customer segments</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-segment"
  operationId="GET-customer-segment-retrieve-category-trees"
/>

The request generates a category tree with categories assigned to a segment and their parent categories, if applicable. If a segment specifies a subcategory only, the customer of that segment is able to see the parent category label, but content-wise, only the products from the subcategory are available.

To filter products that belong to a category that is assigned to a particular segment, send the request to the <nobr><Button to="/openapi/customer-segment/#operation/GET-category-tree-retrieve-category-assignments" size="small">Retrieving resources assigned to a category</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="category"
  operationId="GET-category-tree-retrieve-category-assignments"
/>

Specify the segment id in the request.