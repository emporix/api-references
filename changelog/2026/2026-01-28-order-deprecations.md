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
    visible: false
  pagination:
    visible: true
---

# 2026-01-28: Order Service - Deprecation of `deliveryWindowId` and `orderCycle`

## Overview

Two order-level fields have been deprecated. Use the other properties instead.

### Deprecated fields

| Deprecated field     | Use instead                    |
|----------------------|--------------------------------|
| `orderCycle`         | `deliveryWindow.deliveryCycle` |
| `deliveryWindowId`   | `deliveryWindow.id`            |

## Updated endpoints

| Endpoint                                                                                                                                 | Description                                                                                          |
|------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| [Creating a new order as employee](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders)         | Deprecated `orderCycle` and `deliveryWindowId` in request and response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead. |
| [Creating a new order as customer](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#post-order-v2-tenant-orders)                 | Deprecated `orderCycle` and `deliveryWindowId` in request and response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead. |
| [Retrieving order details](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders-orderid)             | Deprecated `orderCycle` and `deliveryWindowId` in response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead.             |
| [Retrieving a list of orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders)                  | Deprecated `orderCycle` and `deliveryWindowId` in response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead.             |
| [Retrieving orders](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders)                         | Deprecated `orderCycle` and `deliveryWindowId` in response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead.             |
| [Retrieving a specific order by ID](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid)      | Deprecated `orderCycle` and `deliveryWindowId` in response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead.             |
| [Updating an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#put-order-v2-tenant-salesorders-orderid)                   | Deprecated `orderCycle` and `deliveryWindowId` in request and response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead. |
| [Partially updating an order](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-tenant-managed#patch-order-v2-tenant-salesorders-orderid)       | Deprecated `orderCycle` and `deliveryWindowId` in request and response; use `deliveryWindow.deliveryCycle` and `deliveryWindow.id` instead. |

## Known problems

There are no known problems.
