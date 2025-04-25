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
  * [OAuth Service](api-guides-and-references/authorization/oauth-service/README.md)
    * [API Reference](api-guides-and-references/authorization/oauth-service/api-reference/README.md)
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
  * [AI Service](api-guides-and-references/artificial-intelligence/ai-service/README.md)
    * [AI Tutorials](api-guides-and-references/artificial-intelligence/ai-service/ai-tutorial.md)
    * [API Reference](api-guides-and-references/artificial-intelligence/ai-service/api-reference/README.md)
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
* [Configuration](configuration/README.md)
  * [Configuration Service](configuration/configuration-service/README.md)
    * [Language Tutorials](configuration/configuration-service/language.md)
    * [API Reference](configuration/configuration-service/api-reference/README.md)
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
  * [Country Service](configuration/country-service/README.md)
    * [Country Tutorial](configuration/country-service/country.md)
    * [API Reference](configuration/country-service/api-reference/README.md)
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
  * [Currency Service](configuration/currency-service/README.md)
    * [Currency Tutorial](configuration/currency-service/currency.md)
    * [API Reference](configuration/currency-service/api-reference/README.md)
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
  * [Unit Handling Service](configuration/unit-handling-service/README.md)
    * [Unit Handling Tutorial](configuration/unit-handling-service/unit-handling.md)
    * [API Reference](configuration/unit-handling-service/api-reference/README.md)
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
  * [Site Settings Service](configuration/site-settings-service/README.md)
    * [Site Settings Tutorial](configuration/site-settings-service/site-settings.md)
    * [API Reference](configuration/site-settings-service/api-reference/README.md)
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
  * [Indexing Service](configuration/indexing-service/README.md)
    * [Indexing Tutorial](configuration/indexing-service/indexing.md)
    * [API Reference](configuration/indexing-service/api-reference/README.md)
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

***

* [Catalogs and Categories](catalogs-and-categories/README.md)
  * [Catalog Service](catalogs-and-categories/catalog/README.md)
    * [Catalog Tutorials](catalogs-and-categories/catalog/catalog.md)
    * [API Reference](catalogs-and-categories/catalog/api-reference/README.md)
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
  * [Product Service](products-labels-and-brands/product-service/README.md)
    * [Product Tutorial](products-labels-and-brands/product-service/product.md)
    * [API Reference](products-labels-and-brands/product-service/api-reference/README.md)
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
  * [Label Service](products-labels-and-brands/label-service/README.md)
    * [Label Tutorial](products-labels-and-brands/label-service/label.md)
    * [API Reference](products-labels-and-brands/label-service/api-reference/README.md)
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
  * [Brand Service](products-labels-and-brands/brand-service/README.md)
    * [Brand Tutorial](products-labels-and-brands/brand-service/brand.md)
    * [API Reference](products-labels-and-brands/brand-service/api-reference/README.md)
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
* [Prices and Taxes](prices-and-taxes/README.md)
  * [Price Service](prices-and-taxes/price-service/README.md)
    * [Price Tutorials](prices-and-taxes/price-service/price.md)
    * [API Reference](prices-and-taxes/price-service/api-reference/README.md)
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
  * [Tax Service](prices-and-taxes/tax-service/README.md)
    * [Tax Tutorials](prices-and-taxes/tax-service/tax.md)
    * [API Reference](prices-and-taxes/tax-service/api-reference/README.md)
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
  * [IAM Service](users-and-permissions/iam/README.md)
    * [IAM Tutorial](users-and-permissions/iam/iam.md)
    * [API Reference](users-and-permissions/iam/api-reference/README.md)
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
  * [Session-context Service](users-and-permissions/session-context/README.md)
    * [Session-context Tutorial](users-and-permissions/session-context/session-context.md)
    * [API Reference](users-and-permissions/session-context/api-reference/README.md)
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
* [Companies and Customers](companies-and-customers/README.md)
  * [Customer Management](companies-and-customers/client-management/README.md)
    * [API Reference](companies-and-customers/client-management/api-reference/README.md)
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
  * [Customer Service (Customer Managed)](companies-and-customers/customer-management/README.md)
    * [API Reference](companies-and-customers/customer-management/api-reference.md)
    * ```yaml
      props:
        models: true
      type: builtin:openapi
      dependencies:
        spec:
          ref:
            kind: openapi
            spec: customer-managed
      ```
  * [Customer Service (Tenant Managed)](companies-and-customers/customer-service/README.md)
    * [API Reference](companies-and-customers/customer-service/api-reference/README.md)
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
  * [Customer Segments](companies-and-customers/customer-segments/README.md)
    * [Segments Tutorial](companies-and-customers/customer-segments/segments.md)
    * [API Reference](companies-and-customers/customer-segments/api-reference/README.md)
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
  * [Approval Service](companies-and-customers/approval-service/README.md)
    * [Approval Tutorials](companies-and-customers/approval-service/approval.md)
    * [Approval API Reference](companies-and-customers/approval-service/approval-api-reference/README.md)
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
* [Delivery and Shipping](delivery-and-shipping/README.md)
  * [Shipping Service](delivery-and-shipping/shipping/README.md)
    * [Shipping Tutorial](delivery-and-shipping/shipping/shipping.md)
    * [API Reference](delivery-and-shipping/shipping/api-reference/README.md)
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
  * [Delivery Providers Service](delivery-and-shipping/delivery-providers-service/README.md)
    * [API Reference](delivery-and-shipping/delivery-providers-service/api-reference/README.md)
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
* [Rewards and Promotions](rewards-and-promotions/README.md)
  * [Coupon Service](rewards-and-promotions/coupon/README.md)
    * [Coupon Tutorial](rewards-and-promotions/coupon/coupon.md)
    * [API Reference](rewards-and-promotions/coupon/api-reference/README.md)
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
  * [Reward-points Service](rewards-and-promotions/reward-points/README.md)
    * [Reward-points Tutorial](rewards-and-promotions/reward-points/reward-points.md)
    * [API Reference](rewards-and-promotions/reward-points/api-reference/README.md)
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
* [Quotes](quotes/README.md)
  * [Quote Service](quotes/quote/README.md)
    * [Quote Tutorial](quotes/quote/quote.md)
    * [API Reference](quotes/quote/api-reference/README.md)
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
* [Checkout](checkout/README.md)
  * [Cart Service](checkout/cart/README.md)
    * [Cart Tutorial](checkout/cart/cart.md)
    * [API Reference](checkout/cart/api-reference/README.md)
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
  * [Payment-gateway Service](checkout/payment-gateway/README.md)
    * [Payment-gateway Tutorial](checkout/payment-gateway/payment-gateway.md)
    * [API Reference](checkout/payment-gateway/api-reference/README.md)
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
  * [Checkout Service](checkout/checkout/README.md)
    * [Checkout Tutorial](checkout/checkout/checkout.md)
    * [API Reference](checkout/checkout/api-reference/README.md)
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
  * [Fee Service](checkout/fee/README.md)
    * [Fee Tutorial](checkout/fee/fee.md)
    * [API Reference](checkout/fee/api-reference/README.md)
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
  * [Shopping List](checkout/shopping-list/README.md)
    * [API Reference](checkout/shopping-list/api-reference/README.md)
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
* [Orders](orders/README.md)
  * [Availability Service](orders/availability/README.md)
    * [Availability Tutorial](orders/availability/availability.md)
    * [API Reference](orders/availability/api-reference/README.md)
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
  * [Order Service](orders/order/README.md)
    * [Order Tutorial](orders/order/order.md)
    * [API Reference](orders/order/api-reference/README.md)
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
  * [Pick-pack Service](orders/pick-pack/README.md)
    * [API Reference](orders/pick-pack/api-reference/README.md)
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
  * [Invoice Service](orders/invoice/README.md)
    * [Invoice Tutorial](orders/invoice/invoice.md)
    * [API Reference](orders/invoice/api-reference/README.md)
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
  * [Returns Service](orders/returns/README.md)
    * [Returns Tutorial](orders/returns/returns.md)
    * [API Reference](orders/returns/api-reference/README.md)
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
  * [SEPA Export Service](orders/sepa-export/README.md)
    * [API Reference](orders/sepa-export/api-reference/README.md)
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
* [Utilities](utilities/README.md)
  * [Schema Service](utilities/schema/README.md)
    * [Schema Tutorial](utilities/schema/schema.md)
    * [API Reference](utilities/schema/api-reference/README.md)
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
  * [Sequential-id Service](utilities/sequential-id/README.md)
    * [Sequential-id Tutorial](utilities/sequential-id/sequentialid.md)
    * [API Reference](utilities/sequential-id/api-reference/README.md)
      * ```yaml
        props:
          models: true
        type: builtin:openapi
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: sequential-id
        ```
      * ```yaml
        props:
          models: true
        type: builtin:openapi
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: sequential-id
        ```
* [Media](media/README.md)
  * [Media Service](media/media/README.md)
    * [Media Tutorial](media/media/media.md)
    * [API Reference](media/media/api-reference/README.md)
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
* [Webhooks](webhooks/README.md)
  * [Webhook Service](webhooks/webhook-service/README.md)
    * [Webhooks Tutorial](webhooks/webhook-service/webhooks-tutorial.md)
    * [API Reference](webhooks/webhook-service/api-reference/README.md)
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
* [Integrations](integrations/README.md)
  * [Emporix and Make](Integrations/Emporix-make.md)
  * [Identity Providers](Integrations/identity-providers.md)
  * [Workflow Automation](Integrations/workflow-automation.md)
