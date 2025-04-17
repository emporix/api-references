# Table of contents

* [Getting started with Emporix API](README.md)
* [openapi-generator](openapi-generator.md)

## Standard Practices

* [Table of contents](<Standard Practices/SUMMARY.MD>)

***

* [b2btoken](b2btoken.md)
* [mixins](mixins.md)
* [custom-id](custom-id.md)
* [q-param](q-param.md)
* [translations](translations.md)
* [upsert](upsert.md)

## API Guides and References

* [Authorization](api-guides-and-references/authorization/README.md)
  * ```yaml
    type: builtin:openapi
    props:
      models: true
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: oauth-api
    ```
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
* [Artificial Intelligence](api-guides-and-references/ai/README.md)
  * [AI Tutorials](api-guides-and-references/ai/ai-tutorial.md)
  * ```yaml
    type: builtin:openapi
    props:
      models: true
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: ai-api
    ```
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
        type: builtin:openapi
        props:
          models: true
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
              spec: country-api
        ```
  * [Country Service](api-guides-and-references/configuration/country-v2/README.md)
    * [Country Tutorial](api-guides-and-references/configuration/country-v2/country.md)
  * [Currency Service](api-guides-and-references/configuration/currency-service.md)
  * [Tax Service](api-guides-and-references/configuration/tax-service.md)
  * [Unit Handling Service](api-guides-and-references/configuration/unit-handling-service.md)
  * [Site Settings Service](api-guides-and-references/configuration/site-settings/README.md)
    * [Site Settings Tutorial](api-guides-and-references/configuration/site-settings/site-settings.md)
  * [Indexing Service](api-guides-and-references/configuration/indexing/README.md)
    * [Indexing Tutorial](api-guides-and-references/configuration/indexing/indexing.md)

***

* [Catalogs and Categories](catalogs-and-categories/README.md)
  * [Catalog Service](catalogs-and-categories/catalog/README.md)
    * [Catalog Tutorials](catalogs-and-categories/catalog/catalog.md)
    * [API Reference](catalogs-and-categories/catalog/api-reference.md)
  * [Category Service](catalogs-and-categories/category-tree/README.md)
    * [Category Tutorials](catalogs-and-categories/category-tree/category.md)
    * [API Reference](catalogs-and-categories/category-tree/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: category-api
        ```
* [Products, Labels and Brands](products-labels-and-brands/README.md)
  * [Product Service](products-labels-and-brands/product-service.md)
  * [product-v2](products-labels-and-brands/product-v2/README.md)
    * [product](products-labels-and-brands/product-v2/product.md)
  * [Label Service](products-labels-and-brands/label-service.md)
  * [Brand Service](products-labels-and-brands/brand-service.md)
* [Prices, Currencies and Taxes](price-v2/README.md)
  * [Price Service](price-v2/price-service/README.md)
    * [Price Tutorials](price-v2/price-service/price.md)
    * [API Reference](price-v2/price-service/api-reference/README.md)
      * ```yaml
        type: builtin:openapi
        props:
          models: true
        dependencies:
          spec:
            ref:
              kind: openapi
              spec: price-api
        ```
  * [Currency Service](price-v2/currency-service.md)
  * [Tax Service](price-v2/tax-service.md)
* [Users and Permissions](users-and-permissions/README.md)
  * [iam](users-and-permissions/iam/README.md)
    * [iam](users-and-permissions/iam/iam.md)
  * [session-context](users-and-permissions/session-context/README.md)
    * [session-context](users-and-permissions/session-context/session-context.md)
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
* [Webhooks](webhooks.md)
* [Integrations](integrations/README.md)
  * [Emporix-make](Integrations/Emporix-make.md)
  * [identity-providers](Integrations/identity-providers.md)
  * [workflow-automation](Integrations/workflow-automation.md)
