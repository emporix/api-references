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
* [Integrations](integrations/README.md)
  * [Emporix-make](Integrations/Emporix-make.md)
  * [identity-providers](Integrations/identity-providers.md)
  * [workflow-automation](Integrations/workflow-automation.md)
* [approval-service](approval-service/README.md)
  * [Approval Tutorials](approval-service/approval.md)
  * [Approval API Reference](approval-service/approval-api-reference/README.md)
* [availability](availability/README.md)
  * [availability](availability/availability.md)
* [cart](cart/README.md)
  * [cart](cart/cart.md)
* [catalog](catalog/README.md)
  * [catalog](catalog/catalog.md)
* [category-tree](category-tree/README.md)
  * [category](category-tree/category.md)
* [checkout](checkout/README.md)
  * [checkout](checkout/checkout.md)
* [coupon](coupon/README.md)
  * [coupon](coupon/coupon.md)
* [fee](fee/README.md)
  * [fee](fee/fee.md)
* [iam](iam/README.md)
  * [iam](iam/iam.md)
* [invoice](invoice/README.md)
  * [invoice](invoice/invoice.md)
* [media](media/README.md)
  * [media](media/media.md)
* [order](order/README.md)
  * [order](order/order.md)
* [payment-gateway](payment-gateway/README.md)
  * [payment-gateway](payment-gateway/payment-gateway.md)
* [price-v2](price-v2/README.md)
  * [price](price-v2/price.md)
* [product-v2](product-v2/README.md)
  * [product](product-v2/product.md)
* [quote](quote/README.md)
  * [quote](quote/quote.md)
* [returns](returns/README.md)
  * [returns](returns/returns.md)
* [reward-points](reward-points/README.md)
  * [reward-points](reward-points/reward-points.md)
* [schema](schema/README.md)
  * [schema](schema/schema.md)
* [sequential-id](sequential-id/README.md)
  * [sequentialid](sequential-id/sequentialid.md)
* [session-context](session-context/README.md)
  * [session-context](session-context/session-context.md)
* [shipping](shipping/README.md)
  * [shipping](shipping/shipping.md)
* [webhook](webhook/README.md)
  * [webhook](webhook/webhook.md)
  * [Event Catalog](webhook/event-catalog/README.md)
    * [Availability Service events](<webhook/Event Catalog/events-availability.md>)
    * [Cart Service events](<webhook/Event Catalog/events-cart.md>)
    * [Catalog Service events](<webhook/Event Catalog/events-catalog.md>)
    * [Category Service events](<webhook/Event Catalog/events-category.md>)
    * [Client Management Service events](<webhook/Event Catalog/events-client-management.md>)
    * [Customer Service events](<webhook/Event Catalog/events-customer.md>)
    * [events-index](<webhook/Event Catalog/events-index.md>)
    * [Order Service events](<webhook/Event Catalog/events-order.md>)
    * [Price Service events](<webhook/Event Catalog/events-price.md>)
    * [Product Service events](<webhook/Event Catalog/events-product.md>)
    * [Quote Service events](<webhook/Event Catalog/events-quote.md>)
    * [Return events](<webhook/Event Catalog/events-return.md>)

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

## Configuration

* [Configuration](configuration/configuration/README.md)
  * [API Reference](configuration/configuration/api-reference/README.md)
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
* [country-v2](configuration/country-v2/README.md)
  * [Country Service Tutorial](configuration/country-v2/country.md)
  * [API Reference](configuration/country-v2/api-reference/README.md)
    * ```yaml
      type: builtin:openapi
      props:
        models: true
      dependencies:
        spec:
          ref:
            kind: openapi
            spec: country-api
      ```
* [site-settings](configuration/site-settings/README.md)
  * [site-settings](configuration/site-settings/site-settings.md)
* [indexing](configuration/indexing/README.md)
  * [indexing](configuration/indexing/indexing.md)
