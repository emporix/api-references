---
seo:
  title: Bulk Request Limits
  description: Limits for bulk and batch API endpoints
icon: list-check
layout:
  width: wide
description: Bulk request limits for Emporix API endpoints that support multiple changes in a single request.
---

# Bulk Request Limits

## Overview

Endpoints that allow multiple changes in a single request (bulk or batch operations) are subject to **batch size limits**. These limits ensure stable performance.

In addition to per-endpoint batch size limits, Apigee applies:

- **Request/response size for buffered (non-streamed) requests**: 30 MB  
- **Request URL size**: 10 KB  
- **Request header size**: 60 KB  

Exceeding the maximum batch size for an endpoint typically results in a **400 Bad Request** with a message indicating the payload or array size limit.

## Bulk endpoints and limits

| Service | Endpoint / operation | Maximum batch size |
|--------|-----------------------|--------------------|
| [Product Service](../products-labels-and-brands/product-service/README.md) | [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk) | 500 |
| [Product Service](../products-labels-and-brands/product-service/README.md) | [Upserting multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk) | 500 |
| [Price Service](../prices-and-taxes/price-service/README.md) | [Creating multiple prices](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#post-price-tenant-prices-bulk) | 200 |
| [Price Service](../prices-and-taxes/price-service/README.md) | [Upserting multiple prices](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#put-price-tenant-prices-bulk) | 200 |
| [Price Service](../prices-and-taxes/price-service/README.md) | [Deleting multiple prices from a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices-assigned-to-price-lists#delete-price-remove-multiple-prices-from-price-list) | 200 |
| [Price Service](../prices-and-taxes/price-service/README.md) | [Creating multiple prices for a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices-assigned-to-price-lists#post-price-create-multiple-prices-for-price-list) | 200 |
| [Price Service](../prices-and-taxes/price-service/README.md) | [Upserting multiple prices in a price list](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices-assigned-to-price-lists#put-price-update-multiple-prices-in-price-list) | 200 |
| [Cart Service](../checkout/cart/README.md) | [Adding multiple items to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-add-multiple-items-to-cart) | 200 |
| [Category Tree Service](../catalogs-and-categories/category-tree/README.md) | [Updating assignment of resources to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#put-category-tenant-categories-categoryid-assignments-references-bulk) | 200 |
| [Category Tree Service](../catalogs-and-categories/category-tree/README.md) | [Assigning resources to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#post-category-tenant-categories-categoryid-assignments-bulk) | 200 |
| [Customer Segment Service](../companies-and-customers/customer-segments/README.md) | [Creating segments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments-bulk) / [Upserting segments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#put-customer-segment-tenant-segments-bulk) / [Deleting segments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#delete-customer-segment-tenant-segments-bulk) | 200 |
| [Customer Segment Service](../companies-and-customers/customer-segments/README.md) | [Updating customer assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-bulk) / [Removing customer assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#delete-customer-segment-tenant-segments-segmentid-customers-bulk) | 200 |
| [Customer Segment Service](../companies-and-customers/customer-segments/README.md) | [Updating item assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#put-customer-segment-tenant-segments-segmentid-items-type-bulk) / [Removing item assignments in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#delete-customer-segment-tenant-segments-segmentid-items-type-bulk) | 200 |
| [Schema Service](../utilities/schema/README.md) | [Creating custom instances in bulk](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances-bulk) / [Upserting custom instances in bulk](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#put-schema-tenant-custom-entities-type-instances-bulk) | 200 |
| [Shipping Service](../delivery-and-shipping/shipping/README.md) | [Creating multiple delivery times](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping/api-reference/delivery-times-management#post-shipping-create-delivery-times-bulk) | 200 |

If a service uses a different limit, the API reference for that endpoint states the exact value. By default, keep batch sizes at or below **200** items unless the endpoint documentation specifies a higher limit (such as 500 for product bulk).

## Best practices

* Split large datasets into multiple requests if you exceed the limit (for example, 201–500 products in two calls for product bulk).
* Stay within the 30 MB request size (Apigee) for the entire request body, including JSON structure.
* Handle 207 Multi-Status responses for bulk operations; each item in the response array corresponds to the same index in the request and may have a different status code.
