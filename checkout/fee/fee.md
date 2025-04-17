---
seo:
  title: Fee Service Tutorials
  description: fee management
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Fee Service Tutorials


## How to create fees in Emporix system

The Fee Service allows you to manage additional fees that you want to connect to specific items. For example, you can add a fee and link it to a product or a payment type. 

### How to create a product fee

Follow these steps to create a fee and connect it to a product.

1. Create a fee

To create a fee in the system, send the request to the <nobr><Button to="/openapi/fee/#operation/POST-fee-create-fee" size="small">Creating fee</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="fee"
  operationId="POST-fee-create-fee"
  defaultExample="Create fee"
  properties={{
    "name": {
        "de": "Recyclinggebühr",
        "en": "Recycling Fee"
    },
    "code": "recycling_fee",
    "feeType": "ABSOLUTE",
    "siteCode": "DE",
    "feeAbsolute": {
        "amount": 10,
        "currency": "EUR"
    },
    "itemType": "PRODUCT",
    "active": true,
    "taxable": "true",
    "taxCode": "STANDARD"
}}
/>

:::warning

Make sure you provide the relevant `siteCode` of a site that you want to apply the fee to. 
:::


2. Copy the `feeId` of the created fee. To add the fee to the specific product, send the request to the <nobr><Button to="/openapi/fee/#operation/PUT-fee-add-product-fees" size="small">Adding a list of fees to a product</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="fee"
  operationId="PUT-fee-add-product-fees"
/>

In the request path parameter, provide the `productId` to add the fee to.
The `siteCode` in the query parameter must correspond to the site you've created the fee for.


3. To make sure the fee has been added properly, you can send the request to the <nobr><Button to="/openapi/fee/#operation/GET-fee-list-product-fees" size="small">Retrieving all fees with the given productId</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="fee"
  operationId="GET-fee-list-product-fees"
/>

In the query parameter, provide the `siteCode` of the specific site the fee was applied to, for example `?siteCode=DE`.  
Or, you can check if the fee was applied by sending the request to the <nobr><Button to="/openapi/fee/#operation/POST-fee-search-item-fee-by-ProductId" size="small">Searching itemFees by productId</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="fee"
  operationId="POST-fee-search-item-fee-by-ProductId"
/>

### How to create a payment fee

The Fee Service supports adding fees to payments methods. See the example of creating a fee for a payment type.

1. First, create a fee by sending the request to the <nobr><Button to="/openapi/fee/#operation/POST-fee-create-fee" size="small">Creating fee</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="fee"
  operationId="POST-fee-create-fee"
  defaultExample="Create fee"
  properties={{
    "name": {
        "de": "Transaktionsgebühr",
        "en": "Transaction Fee"
    },
    "code": "credit_card",
    "siteCode": "DE",
    "feeType": "ABSOLUTE",
    "feeAbsolute": {
      "amount": 5,
      "currency": "EUR"
    },
    "itemType": "PAYMENTTYPE",
    "active": true,
    "taxable": true,
    "taxCode": "STANDARD"
}}
/>

When creating a payment fee, the fee `code` has to be identical with the payment mode `code`. To check the available payment modes for a given site, make a call to the <nobr><Button to="/openapi/payment-gateway/#operation/GET-payment-gateway-list-payment-modes-frontend" size="small">Retrieving all the payment modes</Button></nobr> endpoint first.
Notice the `code` in the above payload corresponds to the payment mode `code` we want ta apply the fee to.


2. Copy the `feeId`. To connect the fee to the specific payment type, create the item fee by sending the request to the <nobr><Button to="/openapi/fee/#operation/POST-fee-create-item-fee" size="small">Creating itemFee</Button></nobr> endpoint 
and specify the `itemYrn` of the chosen payment type in the request body.


<OpenApiTryIt
  definitionId="fee"
  operationId="POST-fee-create-item-fee"
  defaultExample="ItemFee creation payload"
  properties={{
    "siteCode": "DE",
    "itemYrn": "urn:yaas:hybris:payments:payment-method:mytenant;credit_card",
    "feeIds": [
        "67a4b22bd5fcbe785f74e391"
    ]
}}
/>

Notice the part of `itemYrn` contains the payment mode `code` which is identical with the fee `code`.

3. Apply the fee to the payment mode. Make a call to the <nobr><Button to="/openapi/fee/#operation/PUT-fee-add-item-fees-itemYRN" size="small">Adding a list of fees to an item</Button></nobr> endpoint. 
You need to specify the `itemYrn` of the chosen payment type in the request path and pass the `feeId` in the body.


<OpenApiTryIt
  definitionId="fee"
  operationId="PUT-fee-add-item-fees-itemYRN"
/>

:::warning

This operation overwrites the item's fees. 
For each payment mode you can create and connect one fee only.

:::

4. To make sure the fee has been applied to the payment, send the request to the <nobr><Button to="/openapi/fee/#operation/POST-fee-check-item-fee" size="small">Checking of a fee has been applied</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="fee"
  operationId="POST-fee-check-item-fee"
  properties={{
  "itemYrns": [
    "{{itemYrn}}"
   
  ],
  "siteCode": "DE"
}}
/>

The response contains the details of the fee applied to the payment for a given site.

