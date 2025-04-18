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
  * [Customer Management](companies-and-customers/customer-management.md)
  * [Customer Segments](companies-and-customers/customer-segments.md)
  * [approval-service](companies-and-customers/approval-service/README.md)
    * [Approval Tutorials](companies-and-customers/approval-service/approval.md)
    * [Approval API Reference](companies-and-customers/approval-service/approval-api-reference.md)
* [Delivery and Shipping](delivery-and-shipping/README.md)
  * [shipping](delivery-and-shipping/shipping/README.md)
    * [shipping](delivery-and-shipping/shipping/shipping.md)
  * [Delivery Providers Service](delivery-and-shipping/delivery-providers-service.md)
* [Rewards and Promotions](rewards-and-promotions/README.md)
  * [coupon](rewards-and-promotions/coupon/README.md)
    * [coupon](rewards-and-promotions/coupon/coupon.md)
  * [reward-points](rewards-and-promotions/reward-points/README.md)
    * [reward-points](rewards-and-promotions/reward-points/reward-points.md)
* [Quotes](quotes/README.md)
  * [quote](quotes/quote/README.md)
    * [quote](quotes/quote/quote.md)
* [Checkout](checkout/README.md)
  * [cart](checkout/cart/README.md)
    * [cart](checkout/cart/cart.md)
  * [payment-gateway](checkout/payment-gateway/README.md)
    * [payment-gateway](checkout/payment-gateway/payment-gateway.md)
  * [checkout](checkout/checkout/README.md)
    * [checkout](checkout/checkout/checkout.md)
  * [fee](checkout/fee/README.md)
    * [fee](checkout/fee/fee.md)
  * [Shopping List](checkout/shopping-list.md)
* [Orders](orders/README.md)
  * [availability](orders/availability/README.md)
    * [availability](orders/availability/availability.md)
  * [order](orders/order/README.md)
    * [order](orders/order/order.md)
  * [Pick Pack](orders/pick-pack.md)
  * [invoice](orders/invoice/README.md)
    * [invoice](orders/invoice/invoice.md)
  * [returns](orders/returns/README.md)
    * [returns](orders/returns/returns.md)
  * [SEPA Export](orders/sepa-export.md)
* [Utilities](utilities/README.md)
  * [schema](utilities/schema/README.md)
    * [schema](utilities/schema/schema.md)
  * [sequential-id](utilities/sequential-id/README.md)
    * [sequentialid](utilities/sequential-id/sequentialid.md)
* [Media](media/README.md)
  * [media](media/media/README.md)
    * [media](media/media/media.md)
* [Webhooks\
  \*](webhooks.md)
* [Integrations](integrations/README.md)
  * [Emporix-make](Integrations/Emporix-make.md)
  * [identity-providers](Integrations/identity-providers.md)
  * [workflow-automation](Integrations/workflow-automation.md)
