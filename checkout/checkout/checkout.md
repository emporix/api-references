---
seo:
  title: Checkout Service Tutorials
  description: checkout setup
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

 # Checkout Service Tutorials

As the checkout functionality is the core of your commerce operations, make sure it works properly in your online store. 

The checkout service validates data that comes from different points in the system: cart, order, payment, delivery zone, shipping method, tax, and customer. Therefore, you need proper configuration of these services to make checkout work as expected.
This tutorial guides you through the basic setup of the checkout service.

## How to configure the Checkout Service

### Gather information about a customer's session on the storefront

You need details about the customer's access and session tokens as these details influence the checkout process.

1. When a user enters your storefront, before they choose to log in, an anonymous user session is created.


  Get an anonymous access token by sending a request to the <nobr><Button to="/openapi/oauth/#operation/GET-oauth-generate-anonymous-access-token" size="small">Requesting an anonymous token</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="oauth"
  operationId="GET-oauth-generate-anonymous-access-token"
  />

2. Log the customer in and send an authorization request to the <nobr><Button to="/openapi/oauth/#operation/POST-oauth-authorize-customer" size="small">Requesting a customer token</Button></nobr> endpoint.

:::attention
You can skip this step and continue with the checkout process as a guest customer without the need to log in.
:::

<OpenApiTryIt
  definitionId="oauth"
  operationId="POST-oauth-authorize-customer"
  id="step-1"
  />

This operation returns the customer's access token and Saas token, which convey information about the customer and their activities on the storefront. You might need these details in subsequent steps to get a proper authorization when a customer is logged in.

### Add tax configuration

Each country that you operate in may have different tax rules for different products and services. Add relevant configuration to calculate taxes accordingly.

Add tax configuration by sending a request to the <nobr><Button to="/openapi/tax/#operation/POST-tax-create-configuration" size="small">Creating a new tax configuration</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="tax"
  operationId="POST-tax-create-configuration"
  defaultExample="Tax configuration with a map of localized attributes"
  />

### Define the delivery zone, method, and time

Delivery zone is the area where you ship your goods to. You can define a country, or a zip code that you operate within.
Delivery method is dependant on a specific site and delivery zone. 

1. Define the delivery zone by sending a request to the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-zone" size="small">Creating a shipping zone</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-shipping-zone"
  defaultExample="Zone create payload with name as a Map"
  />

2. Specify how the goods can be shipped to a customer by sending a request to the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-method" size="small">Creating a shipping method</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-shipping-method"
  defaultExample="Method with name as a Map"
  /> 

3. Define delivery time that will be matched with the delivery method and zone by sending the request to the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-delivery-time" size="small">Creating a delivery time</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-delivery-time"
  defaultExample="sample payload for weekday delivery time"
  /> 

### Add products to your store

To create and add multiple products to your store, send the request to the <nobr><Button to="/openapi/product/#operation/POST-product-create-bulk-products" size="small">Creating multiple products</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="product"
  operationId="POST-product-create-bulk-products"
  defaultExample="Create multiple products in bulk"
  /> 

### Create a price model and connect it to products
 
Price model defines your pricing strategy. You can specify how you want to go about price tiers and selling volumes.

1. To define a price model send a request to the <nobr><Button to="/openapi/price/#operation/POST-price-create-price-model" size="small">Creating a new price model</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="price"
  operationId="POST-price-create-price-model"
  defaultExample="Volume price model with a map of localized attributes"
  /> 

2. Create a price for a specific product by sending a request to the <nobr><Button to="/openapi/price/#operation/POST-price-create-price" size="small">Creating a new price</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="price"
  operationId="POST-price-create-price"
  defaultExample="Tiered/volume price (V2)"
  /> 

3. Match the price by session context to allow your customers find the best price based on information retrieved from the session context.

:::warning

The following request requires using the customer's access token for authorization, either anonymous or logged in, as the response contains the bearer's information. 
:::

Send the request to the <nobr><Button to="/openapi/price/#operation/POST-price-match-prices-by-context" size="small">Matching prices for session context</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="price"
  operationId="POST-price-match-prices-by-context"
  defaultExample="Request example"
  /> 

### Create a cart

:::warning

The following requests require using the customer's access token for authorization, either anonymous or logged in, as the response contains the bearer's information. 
:::

1. You have to enable an option to create a cart on your site while a customer is browsing through your products. Creating a cart takes care of things like gathering customer's session details, even anonymous, or setting up a proper cart's currency for final calculations at checkout.
There are two options to create carts using API:

* Create a cart by sending a request to the <nobr><Button to="/openapi/cart/#operation/POST-cart-create-cart" size="small">Creating a new cart</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="cart"
  operationId="POST-cart-create-cart"
  defaultExample="Logged in customer's cart"
  /> 

* Create a cart by sending a `GET` request with `create=true` parameter to the <nobr><Button to="/openapi/cart/#operation/GET-cart-retrieve-cart-by-criteria" size="small">Retrieving a cart's details by criteria</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="cart"
  operationId="GET-cart-retrieve-cart-by-criteria"
  /> 

2. Add items to the cart by sending the request to the <nobr><Button to="/openapi/cart/#operation/POST-cart-add-item-to-cart" size="small">Creating a new cart</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="cart"
  operationId="POST-cart-add-item-to-cart"
  defaultExample="Payload example"
  /> 

### Define payment methods

You can configure payment methods in the Payment Gateway Service. Check the available options in the [Payment Systems](https://developer.emporix.io/user-guides/system-management/payment-gateway/payments) documentation.

### Trigger the checkout 

:::attention
To complete the checkout, there are two options:
* The customer has to be logged in to the storefront and then the following request requires using the customer's access token for authorization - see [Gather information about a customer's session on the storefront
](#Gather-information-about-a-customer's-session-on-the-storefront).
* The customer continues as a guest without logging in - the `customer:guest` field has to be set to `true`.
:::

Once a customer places the product in a cart, they can proceed with the checkout process.

The checkout service validates the data that come from customer's session token, the cart, and tiered prices, and then proceeds with the delivery and payment details. 
Then, it handles the payment and creates an order in the system, closing the cart. 

You can trigger a checkout process through API as well by sending a request to the <nobr><Button to="/openapi/checkout/#operation/POST-checkout-trigger-checkout" size="small">Triggering a checkout</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="checkout"
  operationId="POST-checkout-trigger-checkout"
  defaultExample="Request checkout example"
  /> 