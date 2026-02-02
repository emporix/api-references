---
layout:
  width: wide
icon: user-graduate
description: Step-by-step technical training for developers - split into focused sessions.
---

# Emporix Developer Quick Start Training

A technical, step-by-step training program for developers integrating with the Emporix Commerce Orchestration Platform. Each session is designed to be completed in 30–60 minutes and builds on the previous one.

**Prerequisites:** Basic REST API knowledge, familiarity with OAuth 2.0 concepts, and an account on the [Emporix Developer Portal](https://app.emporix.io).

**Reference:** [developer.emporix.io](https://developer.emporix.io) | [Postman Collection](https://www.postman.com/emporix/emporix-commerce-orchestration-platform/overview)

---

## Training Overview

| Session | Topic | Duration | Level |
|---------|-------|----------|-------|
| 1 | API fundamentals & first request | 45 min | Beginner |
| 2 | Authentication & authorization | 45 min | Beginner |
| 3 | Standard practices & data formats | 30 min | Beginner |
| 4 | Configuration & foundation | 45 min | Intermediate |
| 5 | Product catalog & commerce setup | 60 min | Intermediate |
| 6 | Customers & checkout flow | 60 min | Intermediate |
| 7 | Orders & fulfillment | 45 min | Intermediate |
| 8 | Webhooks & integrations | 45 min | Advanced |

---

## Session 1: API Fundamentals & First Request
**Duration:** 45 min

### Objectives
- Create and access Emporix Developer Portal account
- Retrieve API credentials
- Send the first authenticated request
- Understand base URL and allowlisting

### Hands-on steps

1. **Create an Emporix account**
   - Go to [Emporix Developer Portal](https://app.emporix.io)
   - Sign up or log in

2. **Retrieve API credentials**
   - Navigate to **Manage API Keys**
   - Copy **Client ID** and **Secret** from the Emporix API row
   - Store them securely (never commit to version control)

3. **Allowlist the API IP**
   - Add `34.128.182.253` (api.emporix.io) to your firewall/allowlist
   - See: [API Quickstart](../quickstart/api-intro.md)

4. **Obtain a service access token**
   - Use OAuth 2.0 client credentials flow against the OAuth Service
   - Endpoint: `POST https://api.emporix.io/oauth/{tenant}/token`
   - See: [Requesting a service access token](https://developer.emporix.io/api-references/api-guides/authorization/oauth-service/api-reference/service-access-token)

5. **Send your first request**
   - Call the sites endpoint: `GET https://api.emporix.io/site/{tenant}/sites`
   - Include header: `Authorization: Bearer <YOUR_TOKEN>`
   - Replace `{tenant}` with your tenant identifier

### Key concepts
- **Base URL:** `https://api.emporix.io`
- **Tenant:** Your organization identifier in the URL path
- **Emporix API vs Storefront API:** Emporix API = business owner perspective; Storefront API = customer perspective

### Reference
- [Emporix API Introduction](../quickstart/api-intro.md)
- [List of API Services](../quickstart/list-of-api-services.md)

---

## Session 2: Authentication & Authorization
**Duration:** 45 min

### Objectives
- Understand all four token types
- Know when to use each token
- Use scopes correctly
- Apply B2B token concepts (if relevant)

### Token types

| Token | Use case | Obtained from |
|-------|----------|---------------|
| **Service access token** | Admin operations (products, prices, orders) | OAuth Service |
| **Anonymous token** | Public storefront (browse, add to cart) | Customer Service |
| **Customer token** | Logged-in customer actions | Customer Service |
| **Refresh token** | Refresh customer token | Customer Service |

### Hands-on steps

1. **Request a service access token with specific scopes**
   - Identify the scopes needed for your operation (e.g. `product.product_create`)
   - Request token with `scope` parameter in the OAuth token request

2. **Understand scope naming**
   - Format: `[service_name].[resource_name]_[action_name]`
   - Example: `order.order_post`, `cart.cart_read`

3. **B2B scenarios (optional)**
   - Learn how `legalEntityId` is embedded in the token for multi-legal-entity customers
   - See: [B2B Token](../standard-practices/b2btoken.md)

### Reference
- [OAuth Service](../authorization/oauth-service/README.md)
- [Customer Service - Authentication](../companies-and-customers/customer-management/customer-management-tutorial.md)

---

## Session 3: Standard Practices & Data Formats
**Duration:** 30 min

### Objectives
- Use standardized data formats (ISO codes)
- Apply mixins, translations, and q-param
- Understand Custom ID and Upsert patterns

### Data standards
| Type | Standard | Example |
|------|----------|---------|
| Countries | ISO 3166-1 alpha-2 | `DE`, `US` |
| Currencies | ISO 4217 | `EUR`, `USD` |
| Dates/times | ISO 8601 (UTC) | `2025-02-02T12:00:00.000Z` |
| Languages | IETF BCP-47 | `en`, `de-CH` |

### Hands-on steps

1. **Use translations**
   - Localized fields use maps: `{"en": "Name", "de": "Name"}` 
   - Use `Content-Language` and `Accept-Language` headers

2. **Query with q-param**
   - Filter by field: `q=name:apple_logo`
   - Number comparison: `q=price:>100`
   - Date range: `q=metadataCreatedAt:(>="2025-01-01" AND <"2025-02-01")`
   - See: [Query Parameter](../standard-practices/q-param.md)

3. **Use mixins**
   - Extend resources with custom attributes via mixins
   - See: [Mixins](../standard-practices/mixins.md)

4. **Apply Upsert**
   - Use `id` in request body for create-or-update behavior
   - See: [Upsert](../standard-practices/upsert.md)

### Reference
- [General Info](../standard-practices/general-info.md)
- [Custom ID](../standard-practices/custom-id.md)

---

## Session 4: Configuration & Foundation
**Duration:** 45 min

### Objectives
- Configure tax, currency, and country
- Understand site and multi-site architecture
- Set up basic tenant configuration

### Hands-on steps

1. **Define tax configuration**
   - Create tax classes (e.g. STANDARD, REDUCED) via [Tax Service](../prices-and-taxes/tax-service/tax.md)
   - Endpoint: `POST /tax/{tenant}/taxes`

2. **Add currencies**
   - Add accepted currencies via [Currency Service](../configuration/currency-service/currency.md)
   - Endpoint: `POST /currency/{tenant}/currencies`

3. **Check countries/regions**
   - Countries and regions are predefined
   - Retrieve via [Country Service](../configuration/country-service/country.md)

4. **Understand multi-site**
   - Sites = web stores per country/brand
   - Catalogs are site-aware; products and categories are global
   - See: [Multi-Site Architecture](../quickstart/multisites.md)

5. **Retrieve site settings**
   - `GET /site/{tenant}/sites` to list sites and configuration

### Reference
- [Configuration Service](../configuration/configuration-service/configuration-service-tutorial.md)
- [Site Settings Service](../configuration/site-settings-service/site-settings.md)

---

## Session 5: Product Catalog & Commerce Setup
**Duration:** 60 min

### Objectives
- Create products, categories, and catalogs
- Define price models and product prices
- Add media to products

### Hands-on steps

1. **Create tax configuration** (if not done in Session 4)
   - Required before creating products
   - See: [Product Tutorial - Define sales tax](../products-labels-and-brands/product-service/product.md)

2. **Create a product**
   - `POST /product/{tenant}/products` – basic product
   - Include: `name`, `code`, `productType`, `taxClasses`

3. **Create category and catalog**
   - Category: `POST /category/{tenant}/categories`
   - Catalog: `POST /catalog/{tenant}/catalogs` with `publishedSites` and `categoryIds`
   - See: [Catalog Tutorial](../catalogs-and-categories/catalog/catalog.md)

4. **Set up pricing**
   - Create price model: `POST /price/{tenant}/priceModels`
   - Define price: link product, site, currency
   - See: [Price Tutorial](../prices-and-taxes/price-service/price.md)

5. **Add media**
   - Upload via [Media Service](../media/media/media.md)
   - Associate with product

### Product types
- `BASIC` – single product
- Product variants and bundles – see [Product Tutorial](../products-labels-and-brands/product-service/product.md)

### Reference
- [Product Service](../products-labels-and-brands/product-service/README.md)
- [Catalog Service](../catalogs-and-categories/catalog/README.md)
- [Price Service](../prices-and-taxes/price-service/README.md)

---

## Session 6: Customers & Checkout Flow
**Duration:** 60 min

### Objectives
- Understand tenant-managed vs customer-managed customers
- Use Cart and Checkout services
- Work with fees and payment gateways

### Hands-on steps

1. **Customer Service types**
   - **Tenant-managed:** Emporix stores customer data
   - **Customer-managed:** Your system stores customers; Emporix validates via Customer Management API
   - See: [Customer Management Tutorial](../companies-and-customers/customer-management/customer-management-tutorial.md)

2. **Anonymous token for storefront**
   - Request anonymous token from Customer Service for public browsing
   - Use for cart operations before login

3. **Cart operations**
   - Add items: `POST /cart/{tenant}/carts/{cartId}/lineItems`
   - Get cart: `GET /cart/{tenant}/carts/{cartId}` with expand params
   - See: [Cart Tutorial](../checkout/cart/cart.md)

4. **Checkout**
   - Start checkout using Checkout Service
   - Requires cart with valid line items, shipping, payment
   - See: [Checkout Tutorial](../checkout/checkout/checkout.md)

5. **Fees and payment**
   - [Fee Service](../checkout/fee/fee.md) – surcharges, handling fees
   - [Payment Gateway Service](../checkout/payment-gateway/payment-gateway.md) – payment methods

### Reference
- [Checkout Overview](../checkout/README.md)
- [Shopping List](../checkout/shopping-list/shopping-list-tutorial.md)

---

## Session 7: Orders & Fulfillment
**Duration:** 45 min

### Objectives
- Create and manage orders
- Understand async vs sync calculation
- Use availability, invoice, and returns

### Order calculation models
- **Async:** Emporix calculates at checkout; webhook sends order to ERP
- **Sync:** BFF/ERP calculates in real time; order sent to Emporix
- **ERP-calculated:** Full ERP control

### Hands-on steps

1. **Order scopes**
   - `order.order_post` – create as customer
   - `order.order_create` – create as merchant
   - `order.order_read`, `order.order_update`, etc.

2. **Create order**
   - Via Checkout Service (typical storefront flow)
   - Or directly: `POST /order/v2/{tenant}/salesorders` (tenant-managed)

3. **Webhooks for order.created**
   - Subscribe to `order.created` to push orders to ERP
   - See: [Order Tutorial - Asynchronous calculation](../orders/order/order.md)

4. **Availability**
   - [Availability Service](../orders/availability/availability.md) – stock, ATP

5. **Invoice and returns**
   - [Invoice Service](../orders/invoice/invoice.md)
   - [Returns Service](../orders/returns/returns.md)

### Reference
- [Order Tutorial](../orders/order/order.md)
- [Webhook Events - Order](../webhooks/events-order.md)

---

## Session 8: Webhooks & Integrations
**Duration:** 45 min

### Objectives
- Configure webhook subscriptions
- Connect to Event Gateway
- Use OpenAPI Generator, Java SDK, Terraform

### Hands-on steps

1. **Retrieve subscriptions**
   - `GET /webhook/{tenant}/event-subscriptions`

2. **Subscribe to events**
   - `PATCH /webhook/{tenant}/event-subscriptions`
   - Example: `catalog.created`, `order.created`, `product.updated`
   - See: [Webhooks Tutorial](../webhooks/webhook-service/webhooks-tutorial.md)

3. **Event Gateway**
   - Connect your endpoint to receive events
   - Configure callback URL

4. **Generate SDK**
   - Download API specs: [api-references.zip](https://github.com/emporix/api-references/releases/latest/download/api-references.zip)
   - Use [OpenAPI Generator](../quickstart/openapi-generator.md) or [Emporix Java SDK](../quickstart/emporix-java-sdk.md)

5. **Infrastructure as Code**
   - [Emporix Terraform Provider](../quickstart/emporix-terraform-provider.md)

6. **Testing**
   - [Postman Collection](https://www.postman.com/emporix/emporix-commerce-orchestration-platform/overview)

### Reference
- [Webhook Service](../webhooks/webhook-service/README.md)
- [Webhook Events Index](../webhooks/events-index.md)
- [Integrations](../integrations/README.md) (Identity Providers, Make)

---

## Quick Reference Card

| Resource | Base path | Docs |
|----------|-----------|------|
| OAuth | `/oauth/{tenant}/token` | [Authorization](../authorization/oauth-service/) |
| Products | `/product/{tenant}/products` | [Product Service](../products-labels-and-brands/product-service/) |
| Categories | `/category/{tenant}/categories` | [Category Service](../catalogs-and-categories/category-tree/) |
| Catalogs | `/catalog/{tenant}/catalogs` | [Catalog Service](../catalogs-and-categories/catalog/) |
| Prices | `/price/{tenant}/...` | [Price Service](../prices-and-taxes/price-service/) |
| Cart | `/cart/{tenant}/carts` | [Cart Service](../checkout/cart/) |
| Checkout | `/checkout/{tenant}/...` | [Checkout Service](../checkout/checkout/) |
| Orders | `/order/v2/{tenant}/salesorders` | [Order Service](../orders/order/) |
| Webhooks | `/webhook/{tenant}/event-subscriptions` | [Webhook Service](../webhooks/webhook-service/) |

---

## Additional Resources

- **Status page:** [status.emporix.io](https://status.emporix.io)
- **Support:** [support@emporix.com](mailto:support@emporix.com)
- **Changelog:** [changelog/](../changelog/)
