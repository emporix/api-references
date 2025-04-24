---
seo:
  title: Quote Service Tutorials
  description: Quote Management
---
import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Quote Service Tutorials

{% hint style="danger" %}

The Emporix API Quote Service is only available to tenants that use the Price v2 API Service.
{% endhint %}

## How to configure the Quote Service

The Quote Service allows you to send email notifications to customers every time a new quote is created or updated by the customers themselves or by an employee on their behalf. 

The following merchant information is necessary for the pdf file with quote to be generated:

  * `merchantName`
  * `merchantAddress`
    * `merchantCity`
    * `merchantStreet`  
    * `merchantStreetNo`
    * `merchantZipCode`

{% hint style="warning" %}

The pdf with quote will be sent to the customer in the notification email upon the quote's creation or change. It will also be available for the customer on the storefront.
{% endhint %}

### Retrieve your site's mixins

First, you need to check the current site mixin configuration for the `merchantInfo` parameter by sending a request to the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-list-site-mixins" size="small">Retrieving site mixins</Button></nobr> endpoint.

{% hint style="warning" %}

The following scope is required:

`site.site_manage`

{% endhint %}

<OpenApiTryIt
  definitionId="site-settings"
  operationId="GET-site-settings-list-site-mixins"
  />

### Update merchant information

Update the merchant information for your tenant's site by sending a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site-mixin" size="small">Partially updating a site mixin</Button></nobr> endpoint.

{% hint style="warning" %}

The following scope is required:

`site.site_manage`

{% endhint %}

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site-mixin"
  defaultExample="Merchant info update"
  />

### Update available quote status change reasons

When a customer changes the quote status to `DECLINED` or `IN_PROGRESS`, or when an employee changes the quote status to `DECLINED_BY_MERCHANT`, they can provide a reason why they performed that action. 

There are four default reasons that your customers and employees can select for the `DECLINED` or `CHANGED` quote statuses:

|Quote status|Reason code|
|---|---|
|**DECLINE**|<ul><li>PRICE_TOO_HIGH</li><li>NO_LONGER_NEEDED</li><li>DELIVERY_TIME_LATE</li><li>OTHER</li></ul>|
|**CHANGE**|<ul><li>WRONG_MATERIAL</li><li>PROVIDED_PRICE_TO_HIGH</li><li>DELIVERY_TIME_LATE</li><li>OTHER</li></ul>|


{% hint style="warning" %}

The quote reason of the `DECLINE` type can only be used for the `DECLINED` or `DECLINED_BY_MERCHANT` actions, while the `CHANGE` type can only be used for the `IN_PROGRESS` change of status.
{% endhint %}


By sending a request to the <nobr><Button to="/openapi/site-settings/#operation/POST-quote-create-quote-reason" size="small">Creating a reason for changing the quote status</Button></nobr> endpoint, you can create new quote status change reasons.

<OpenApiTryIt
  definitionId="quote"
  operationId="POST-quote-create-quote-reason"
  properties={
  {
    code: "WRONG_COLOR",
    type: "CHANGE",
    message: {
      en: "The color is wrong",
      de: "Die Farbe ist falsch"
      }
      }}
/>

## How to manage quote requests

A quote request can be created both by a customer directly on your business' storefront, or by an employee on behalf of a customer.

### Create a quote by a customer

On the storefront, a customer adds selected products to cart. At checkout, they can proceed to purchasing the items, or requesting a quote. 
If a customer places a quote request, the <nobr><Button to="/openapi/quote/#operation/POST-quote-create-quote" size="small">Creating a quote</Button></nobr> endpoint is called.

{% hint style="warning" %}

The following scope is granted to a customer group:

`quote.quote_manage_own`

{% endhint %}

The customer can place a quote request on the storefront only if they have created a cart with the requested items beforehand.

<OpenApiTryIt
  definitionId="quote"
  operationId="POST-quote-create-quote"
  defaultExample="Create quote from cart"
  />

{% hint style="warning" %}

The initial status of a quote request created by a customer is always set to `AWAITING`.
{% endhint %}

### Create a quote on behalf of a customer

To create a quote request on behalf of a customer, you need to call the <nobr><Button to="/openapi/quote/#operation/POST-quote-create-quote" size="small">Creating a quote</Button></nobr> endpoint.

{% hint style="warning" %}

The following scope is required:

`quote.quote_manage`

{% endhint %}

<OpenApiTryIt
  definitionId="quote"
  operationId="POST-quote-create-quote"
  defaultExample="Full quote creation definition."
  />

{% hint style="warning" %}

The initial status of a quote request being created by an employee is always set to `CREATING`, and, subsequently, `OPEN` when the quote is created.
{% endhint %}

### Update a quote by an employee

There are two scenarios when an employee may need to update a quote: 
* A customer can contact your Customer Service so that an employee updates the quote request on their behalf
* Employee updates the quote request with new information for the customer to review, such as price or status change

To achieve that, the employee needs to send a request to the <nobr><Button to="/openapi/quote/#operation/PATCH-quote-update-quote" size="small">Partially updating a quote</Button></nobr> endpoint.

{% hint style="warning" %}

The following scope is required:

`quote.quote_manage`

{% endhint %}

In this example, an employee updates multiple fields:

<OpenApiTryIt
  definitionId="quote"
  operationId="PATCH-quote-update-quote"
  defaultExample="Multiple update list"
  />

In the following example, an employee updates only the price of requested items:

<OpenApiTryIt
  definitionId="quote"
  operationId="PATCH-quote-update-quote"
  defaultExample="Change price of the item"
  />

### Accept a quote by a customer

When a customer accepts a quote on the storefront, the following endpoint is called: <nobr><Button to="/openapi/quote/#operation/PATCH-quote-update-quote" size="small">Partially updating a quote</Button></nobr>.

{% hint style="warning" %}

The following scope is granted to the customer group:

`quote.quote_manage_own`

{% endhint %}

<OpenApiTryIt
  definitionId="quote"
  operationId="PATCH-quote-update-quote"
  defaultExample="Accept quote"
  properties={[
  {
    op: "replace",
    value: {
      value: "ACCEPTED"
      }
  }
  ]}
  />


### Decline a quote by a customer

When a customer changes the quote status to `DECLINED` or `IN_PROGRESS`, or when an employee changes the quote status to `DECLINED_BY_MERCHANT`, they can provide a reason why they performed that action.  
On the storefront, when a customer declines the quote, a request to the following endpoint is sent: <nobr><Button to="/openapi/quote/#operation/PATCH-quote-update-quote" size="small">Partially updating a quote</Button></nobr>.  

{% hint style="warning" %}

The following scope is granted to the customer group:

`quote.quote_manage_own`

{% endhint %}

If the customer wants to provide a reason for declining a quote, they can choose one of the provided reasons from a list of available reasons and/or add comments.

In this example, a customer receives a quote and decides to decline it because the proposed price is too high. They also add a comment to negotiate the price.

<OpenApiTryIt
  definitionId="quote"
  operationId="PATCH-quote-update-quote"
  defaultExample="Change quote status"
  properties={[
  {
    op: "replace",
    path: "/status",
    value: {
      value: "DECLINED",
      comment: "Can you make the price 50$ cheaper?",
      quoteReasonId: "6437ed5dc0dc2925289a5bbd"
    }
  }
]}
  />




