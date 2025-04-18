# Table of contents

* [Getting started with Emporix API](README.md)
* [OpenAPI Generator](openapi-generator.md)

## Standard Practices

* [General Info](standard-practices/general-info.md)
* [Mixins](standard-practices/mixins.md)
* [Query Parameter](standard-practices/q-param.md)
* [Translations](standard-practices/translations.md)
* [Custom ID](standard-practices/custom-id.md)
* [Upsert](standard-practices/upsert.md)
* [B2B Token](standard-practices/b2btoken.md)

## API Guides and References

* [Authorization](api-guides-and-references/authorization/README.md)
  * [API Reference](api-guides-and-references/authorization/api-reference/README.md)
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
* [Artificial Intelligence](api-guides-and-references/artificial-intelligence/README.md)
  * [AI Tutorials](api-guides-and-references/artificial-intelligence/ai-tutorials.md)
  * [API Reference](api-guides-and-references/artificial-intelligence/api-reference/README.md)
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
* [Configuration](api-guides-and-references/configuration/README.md)
  * [Configuration Service](api-guides-and-references/configuration/configuration-service/README.md)
    * [API Reference](api-guides-and-references/configuration/configuration-service/api-reference/README.md)
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
  * [Country Service](api-guides-and-references/configuration/country-service/README.md)
    * [Country Tutorial](api-guides-and-references/configuration/country-service/country-tutorial.md)
    * [API Reference](api-guides-and-references/configuration/country-service/api-reference/README.md)
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
  * [Currency Service](api-guides-and-references/configuration/currency-service/README.md)
    * [API Reference](api-guides-and-references/configuration/currency-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: currency-api
        ```
  * [Tax Service](api-guides-and-references/configuration/tax-service/README.md)
    * [API Reference](api-guides-and-references/configuration/tax-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: tax-api
        ```
  * [Unit Handling Service](api-guides-and-references/configuration/unit-handling-service/README.md)
    * [API Reference](api-guides-and-references/configuration/unit-handling-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: unit-handling-api
        ```
  * [Site Settings Service](api-guides-and-references/configuration/site-settings-service/README.md)
    * [Site Settings Tutorial](api-guides-and-references/configuration/site-settings-service/site-settings-tutorial.md)
    * [API Reference](api-guides-and-references/configuration/site-settings-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: site-settings-api
        ```
  * [Indexing Service](api-guides-and-references/configuration/indexing-service/README.md)
    * [Indexing Tutorial](api-guides-and-references/configuration/indexing-service/indexing-tutorial.md)
    * [API Reference](api-guides-and-references/configuration/indexing-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: indexing-api
        ```

***

* [Catalogs and Categories](catalogs-and-categories/README.md)
  * [Catalog Service](catalogs-and-categories/catalog/README.md)
    * [Catalog Tutorials](catalogs-and-categories/catalog/catalog.md)
    * [API Reference](catalogs-and-categories/catalog/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: catalog-api
        ```
  * [Category Service](catalogs-and-categories/category-tree/README.md)
    * [Category Tutorials](catalogs-and-categories/category-tree/category.md)
    * [API Reference](catalogs-and-categories/category-tree/api-reference/README.md)
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
* [Products, Labels and Brands](products-labels-and-brands/README.md)
  * [product-v2](products-labels-and-brands/product-v2/README.md)
    * [product](products-labels-and-brands/product-v2/product.md)
    * [API Reference](products-labels-and-brands/product-v2/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: product-api
        ```
  * [Label Service](products-labels-and-brands/label-service/README.md)
    * [API Reference](products-labels-and-brands/label-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: label-api
        ```
  * [Brand Service](products-labels-and-brands/brand-service/README.md)
    * [API Reference](products-labels-and-brands/brand-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: brand-api
        ```
* [Prices, Currencies and Taxes](price-v2/README.md)
  * [Price Service](price-v2/price-service/README.md)
    * [Price Tutorials](price-v2/price-service/price.md)
    * [API Reference](price-v2/price-service/api-reference/README.md)
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
  * [Currency Service](price-v2/currency-service/README.md)
    * [API Reference](price-v2/currency-service/api-reference/README.md)
      * ```yaml
        props:
          models: true
        type: builtin:openapi
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: currency
        ```
  * [Tax Service](price-v2/tax-service/README.md)
    * [API Reference](price-v2/tax-service/api-reference/README.md)
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
* [Users and Permissions](users-and-permissions/README.md)
  * [iam](users-and-permissions/iam/README.md)
    * [iam](users-and-permissions/iam/iam.md)
    * [API Reference](users-and-permissions/iam/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: iam-api
        ```
  * [session-context](users-and-permissions/session-context/README.md)
    * [session-context](users-and-permissions/session-context/session-context.md)
    * [API Reference](users-and-permissions/session-context/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: session-context-api
        ```
* [Companies and Customers](companies-and-customers/README.md)
  * [Customer Management](companies-and-customers/customer-management/README.md)
    * [API Reference](companies-and-customers/customer-management/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: customer-client-management-api
        ```
  * [Customer Service](companies-and-customers/customer-management-1/README.md)
    * [API Reference](companies-and-customers/customer-management-1/api-reference.md)
    * ```yaml
      type: builtin:openapi
      props:
        models: true
      dependencies:
        spec:
          ref:
            kind: openapi
            spec: customer-managed
      ```
  * [Customer Service](companies-and-customers/customer-service/README.md)
    * [API Reference](companies-and-customers/customer-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: customer-tenant-api
        ```
  * [Customer Segments](companies-and-customers/customer-segments/README.md)
    * [API Reference](companies-and-customers/customer-segments/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: segments-api
        ```
  * [approval-service](companies-and-customers/approval-service/README.md)
    * [Approval Tutorials](companies-and-customers/approval-service/approval.md)
    * [Approval API Reference](companies-and-customers/approval-service/approval-api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: approval-api
        ```
* [Delivery and Shipping](delivery-and-shipping/README.md)
  * [shipping](delivery-and-shipping/shipping/README.md)
    * [shipping](delivery-and-shipping/shipping/shipping.md)
    * [API Reference](delivery-and-shipping/shipping/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: shipping-api
        ```
  * [Delivery Providers Service](delivery-and-shipping/delivery-providers-service/README.md)
    * [API Reference](delivery-and-shipping/delivery-providers-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: delivery-api
        ```
* [Rewards and Promotions](rewards-and-promotions/README.md)
  * [coupon](rewards-and-promotions/coupon/README.md)
    * [coupon](rewards-and-promotions/coupon/coupon.md)
    * [API Reference](rewards-and-promotions/coupon/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: coupon-api
        ```
  * [reward-points](rewards-and-promotions/reward-points/README.md)
    * [reward-points](rewards-and-promotions/reward-points/reward-points.md)
    * [API Reference](rewards-and-promotions/reward-points/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: reward-points-api
        ```
* [Quotes](quotes/README.md)
  * [quote](quotes/quote/README.md)
    * [quote](quotes/quote/quote.md)
  * [API Reference](quotes/api-reference/README.md)
    * ```yaml
      type: builtin:openapi
      props:
        models: true
      dependencies:
        spec:
          ref:
            kind: openapi
            spec: quote-api
      ```
* [Checkout](checkout/README.md)
  * [cart](checkout/cart/README.md)
    * [cart](checkout/cart/cart.md)
    * [API Reference](checkout/cart/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: cart-api
        ```
  * [payment-gateway](checkout/payment-gateway/README.md)
    * [payment-gateway](checkout/payment-gateway/payment-gateway.md)
    * [API Reference](checkout/payment-gateway/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: payment-gateway-api
        ```
  * [checkout](checkout/checkout/README.md)
    * [checkout](checkout/checkout/checkout.md)
    * [API Reference](checkout/checkout/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: checkout-api
        ```
  * [fee](checkout/fee/README.md)
    * [fee](checkout/fee/fee.md)
    * [API Reference](checkout/fee/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: fee-api
        ```
  * [Shopping List](checkout/shopping-list/README.md)
    * [API Reference](checkout/shopping-list/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: shopping-list-api
        ```
* [Orders](orders/README.md)
  * [availability](orders/availability/README.md)
    * [availability](orders/availability/availability.md)
    * [API Reference](orders/availability/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: availability-api
        ```
  * [order](orders/order/README.md)
    * [order](orders/order/order.md)
    * [API Reference](orders/order/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: order-api
        ```
  * [Pick Pack](orders/pick-pack/README.md)
    * [API Reference](orders/pick-pack/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: pick-pack-api
        ```
  * [invoice](orders/invoice/README.md)
    * [invoice](orders/invoice/invoice.md)
    * [API Reference](orders/invoice/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: invoice-api
        ```
  * [returns](orders/returns/README.md)
    * [returns](orders/returns/returns.md)
    * [API Reference](orders/returns/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: returns-api
        ```
  * [SEPA Export](orders/sepa-export/README.md)
    * [API Reference](orders/sepa-export/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: sepa-export-api
        ```
* [Utilities](utilities/README.md)
  * [schema](utilities/schema/README.md)
    * [schema](utilities/schema/schema.md)
    * [API Reference](utilities/schema/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: schema-api
        ```
  * [sequential-id](utilities/sequential-id/README.md)
    * [sequentialid](utilities/sequential-id/sequentialid.md)
    * [API Reference](utilities/sequential-id/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: sequential-id
        ```
* [Media](media/README.md)
  * [media](media/media/README.md)
    * [media](media/media/media.md)
    * [API Reference](media/media/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: media-api
        ```
* [Webhooks](webhooks/README.md)
  * [Events-Availability](webhooks/events-availability.md)
  * [Events-Cart](webhooks/events-cart.md)
  * [Events-Catalog](webhooks/events-catalog.md)
  * [Events-Category](webhooks/events-category.md)
  * [Events-Client Management](webhooks/events-client-management.md)
  * [Events-Customer](webhooks/events-customer.md)
  * [Events-Index](webhooks/events-index.md)
  * [Events-Order](webhooks/events-order.md)
  * [Events-Price](webhooks/events-price.md)
  * [Events-Product](webhooks/events-product.md)
  * [Events-Quote](webhooks/events-quote.md)
  * [Events-Product](webhooks/events-return.md)
  * [API Reference](webhooks/api-reference/README.md)
    * ```yaml
      type: builtin:openapi
      props:
        models: true
      dependencies:
        spec:
          ref:
            kind: openapi
            spec: webhook-api
      ```
* [Integrations](integrations/README.md)
  * [Emporix and Make](Integrations/Emporix-make.md)
  * [Identity Providers](Integrations/identity-providers.md)
  * [Workflow Automation](Integrations/workflow-automation.md)
