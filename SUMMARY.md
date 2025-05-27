# Table of contents

* [Emporix API](README.md)
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
  * [OAuth Service](authorization/oauth-service/README.md)
    * [API Reference](authorization/oauth-service/api-reference/README.md)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/authorization/oauth-service/api-reference/api.yml)
* [Artificial Intelligence](artificial-intelligence/README.md)
  * [AI Service](artificial-intelligence/ai-service/README.md)
    * [AI Tutorials](artificial-intelligence/ai-service/ai-tutorial.md)
    * [API Reference](artificial-intelligence/ai-service/api-reference/README.md)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/artificial-intelligence/ai-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/configuration/configuration-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/configuration/country-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/configuration/currency-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/configuration/unit-handling-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/configuration/site-settings-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/configuration/indexing-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/catalogs-and-categories/catalog/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/catalogs-and-categories/category-tree/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/products-labels-and-brands/product-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/products-labels-and-brands/label-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/products-labels-and-brands/brand-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/prices-and-taxes/price-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/prices-and-taxes/tax-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/users-and-permissions/iam/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/users-and-permissions/session-context/api-reference/api.yaml)
* [Companies and Customers](companies-and-customers/README.md)
  * [Customer Management](companies-and-customers/client-management/README.md)
    * [Customer Management Tutorial](companies-and-customers/customer-service/customer-management.md)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/companies-and-customers/client-management/api-reference/api.yml)
  * [Customer Service (Customer Managed)](companies-and-customers/customer-management/README.md)
    * [API Reference](companies-and-customers/customer-management/api-reference/README.md)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/companies-and-customers/customer-management/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/companies-and-customers/customer-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/companies-and-customers/customer-segments/api-reference/api.yml)
  * [Approval Service](companies-and-customers/approval-service/README.md)
    * [Approval Tutorials](companies-and-customers/approval-service/approval.md)
    * [API Reference](companies-and-customers/approval-service/approval-api-reference/README.md)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/companies-and-customers/approval-service/approval-api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/delivery-and-shipping/shipping/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/delivery-and-shipping/delivery-providers-service/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/rewards-and-promotions/coupon/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/rewards-and-promotions/reward-points/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/quotes/quote/api-reference/api.yaml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/checkout/cart/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/checkout/payment-gateway/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/checkout/checkout/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/checkout/fee/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/checkout/shopping-list/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/orders/availability/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/orders/order/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/orders/pick-pack/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/orders/invoice/api-reference/api.yaml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/orders/returns/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/orders/sepa-export/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/utilities/schema/api-reference/api.yml)
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
              spec: sequential-id-api
        ```
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/utilities/sequential-id/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/media/media/api-reference/api.yml)
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
    * [Download API Specification](https://raw.githubusercontent.com/emporix/api-references/refs/heads/main/webhooks/webhook-service/api-reference/api.yml)
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
