# Table of contents

* [API Reference](README.md)
* [List of API Services](../list-of-api-services.md)

## API Reference

* [AI](../artificial-intelligence/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: ai-api
    ```
* [Approval](../companies-and-customers/approval-service/approval-api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: approval-api
    ```
* [Availability](../orders/availability/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: availability-api
    ```
* [Brand](../products-labels-and-brands/brand-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: brand-api
    ```
* [Cart](../checkout/cart/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: cart-api
    ```
* [Catalog](../catalogs-and-categories/catalog/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: catalog-api
    ```
* [Category](../catalogs-and-categories/category-tree/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: category-api
    ```
* [Checkout](../checkout/checkout/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: checkout-api
    ```
* [Configuration](../configuration/configuration-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: configuration-api
    ```
* [Country](../configuration/country-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: country-api
    ```
* [Coupon](../rewards-and-promotions/coupon/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: coupon-api
    ```
* [Currency](../configuration/currency-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: currency-api
    ```
* [Customer (Customer Managed)](../companies-and-customers/customer-management/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: customer-managed-api
    ```
* [Customer (Tenant Managed)](../companies-and-customers/customer-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: customer-tenant-api
    ```
* [Customer Management](../companies-and-customers/client-management/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: customer-client-management-api
    ```
* [Customer Segment](../companies-and-customers/customer-segments/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: segments-api
    ```
* [Delivery Providers](../delivery-and-shipping/delivery-providers-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: delivery-api
    ```
* [Fee](../checkout/fee/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: fee-api
    ```
* [IAM](../users-and-permissions/iam/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: iam-api
    ```
* [Indexing](../configuration/indexing-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: indexing-api
    ```
* [Invoice](../orders/invoice/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: invoice-api
    ```
* [Label](../products-labels-and-brands/label-service/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: label-api
    ```
* [Media](../media/media/api-reference/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: media-api
    ```
* [OAuth](reference/oauth/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: oauth-api
    ```
* [Order](reference/order/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: order-api
    ```
* [Payment Gateway](reference/payment-gateway/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: payment-gateway-api
    ```
* [Pick Pack](reference/pick-pack/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: pick-pack-api
    ```
* [Price](reference/price/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: price-api
    ```
* [Product](reference/product/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: product-api
    ```
* [Quote](reference/quote/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: quote-api
    ```
* [Return](reference/return/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: returns-api
    ```
* [Reward Points](reference/reward-points/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: reward-points-api
    ```
* [Schema](reference/schema/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: schema-api
    ```
* [SEPA Export](reference/sepa-export/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: sepa-export-api
    ```
* [Sequential ID](reference/sequential-id/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: sequential-id-api
    ```
* [Session Context](reference/session-context/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: session-context-api
    ```
* [Shipping](reference/shipping/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: shipping-api
    ```
* [Shopping List](reference/shopping-list/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: shopping-list-api
    ```
* [Site Settings](reference/site-settings/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: site-settings-api
    ```
* [Tax](reference/tax/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: tax-api
    ```
* [Unit Handling](reference/unit-handling/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: unit-handling-api
    ```
* [Vendor](reference/vendor/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: vendor-api
    ```
* [Webhook](reference/webhook/README.md)
  * ```yaml
    props:
      models: true
    type: builtin:openapi
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: webhook-api
    ```
