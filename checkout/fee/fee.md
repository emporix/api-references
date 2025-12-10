---
seo:
  title: Fee Service Tutorials
  description: fee management
icon: graduation-cap
layout:
  width: wide
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
---

# Fee Tutorial

The Fee Service allows you to manage additional fees that you want to connect to specific items. For example, you can add a fee and link it to a product or a payment type.

**Fee types**:

The Fee Service supports multiple fee types. Each type determines how the fee is calculated and applied:

* **ABSOLUTE** - A fixed amount fee applied regardless of the item’s price, for example, €3 packaging fee per product.
* **PERCENTAGE** - A fee calculated as a percentage of the item’s price, for example, 5% of the product price as a handling fee.
* **ABSOLUTE\_MULTIPLY\_ITEMQUANTITY** - Monetary amount multiplied by the item quantity and assigned to the item line.

{% hint style="info" %}
If you're looking for information about fees and cart calculations, see [How to calculate a payment fee at cart level](../cart/cart.md#how-to-calculate-a-payment-fee-at-cart-level) and [How is price calculated](../cart/cart.md#how-is-price-calculated).
{% endhint %}

## How to create a product fee

Follow these steps to create a fee and connect it to a product.

{% stepper %}
{% step %}
#### Create a fee

Send the request to the [Creating a fee](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/fee-management#post-fee-tenant-fees) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/fee/{tenant}/fees' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": {
      "de": "Sixpack PET",
      "en": "Sixpack PET"
    },
    "code": "apple_picking_fee",
    "feeType": "ABSOLUTE",
    "siteCode": "main",
    "feeAbsolute": {
      "amount": 3.5,
      "currency": "EUR"
    },
    "active": true,
    "taxable": false
  }'
```

{% hint style="danger" %}
Make sure you provide the relevant `siteCode` of a site that you want to apply the fee to.
{% endhint %}
{% endstep %}

{% step %}
#### Copy the `feeId` of the created fee

To add the fee to the specific product, send the request to the [Adding a list of fees to a product](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/product-fees-management#put-fee-tenant-productfees-productid-fees) endpoint. You need to add the `feeId` in the request.

```bash
curl -i -X PUT 
  'https://api.emporix.io/fee/{tenant}/productFees/{productId}/fees?siteCode=main&partial=false' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "feeIds": [
      "57b30fd2289c48001daf5486",
      "96b30fd4586c48001daf1752"
    ]
  }'
```

In the request path parameter, provide the `productId` to add the fee to. The `siteCode` in the query parameter must correspond to the site you've created the fee for.
{% endstep %}

{% step %}
#### Review the fee

To make sure the fee has been added properly, you can send the request to the [Retrieving all fees with the given productId](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/product-fees-management#get-fee-tenant-productfees-productid-fees) endpoint.

```bash
curl -i -X GET 
  'https://api.emporix.io/fee/{tenant}/productFees/{productId}/fees?siteCode=main&expand=false' 
  -H 'Accept-Language: *' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

In the query parameter, provide the `siteCode` of the specific site the fee was applied to, for example `?siteCode=DE`.

Or, you can check if the fee was applied by sending the request to the [Searching itemFees by productId](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/item-fee-search#post-fee-tenant-itemfees-searchbyproductid) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/fee/{tenant}/itemFees/searchByProductId' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "productId": "Apple_A_productId",
    "siteCodes": [
      "example_site_code"
    ],
    "pageNumber": 1,
    "pageSize": 10
  }'
```
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

## How to create a payment fee

The Fee Service supports adding fees to payments methods. See the example of creating a fee for a payment type.

{% stepper %}
{% step %}
#### Create a fee

Send the request to the [Creating a fee](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/fee-management#post-fee-tenant-fees) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/fee/{tenant}/fees' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": {
      "de": "Sixpack PET",
      "en": "Sixpack PET"
    },
    "code": "apple_picking_fee",
    "feeType": "ABSOLUTE",
    "siteCode": "main",
    "feeAbsolute": {
      "amount": 3.5,
      "currency": "EUR"
    },
    "active": true,
    "taxable": false
  }'
```

When creating a payment fee, the fee `code` has to be identical with the payment mode `code`. To check the available payment modes for a given site, make a call to the [Retrieving all the payment modes](https://developer.emporix.io/api-references/api-guides/checkout/payment-gateway/api-reference/payment-mode-frontend#get-payment-gateway-tenant-paymentmodes-frontend) endpoint first.

Notice the `code` in the above payload corresponds to the payment mode `code` we want ta apply the fee to.
{% endstep %}

{% step %}
#### Copy the `feeId` of the created fee

To connect the fee to the specific payment type, create the item fee by sending the request to the [Creating itemFee](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/item-fee-management#post-fee-tenant-itemfees) endpoint and specify the `itemYrn` of the chosen payment type in the request body.

```bash
curl -i -X POST 
  'https://api.emporix.io/fee/{tenant}/itemFees' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application:json' 
  -d '[object Object]'
```

Note that the part of `itemYrn` contains the payment mode `code` which is identical with the fee `code`.
{% endstep %}

{% step %}
#### Apply the fee to the payment mode

Send a request to the [Adding a list of fees to an item](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/item-fee-management#put-fee-tenant-itemfees-itemyrn-fees) endpoint. You need to specify the `itemYrn` of the chosen payment type in the request path and pass the `feeId` in the body.

```bash
curl -i -X PUT 
  'https://api.emporix.io/fee/{tenant}/itemFees/{itemYRN}/fees?partial=false' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "feeIds": [
      "57b30fd2289c48001daf5486",
      "96b30fd4586c48001daf1752"
    ]
  }'
```

{% hint style="danger" %}
This operation overwrites the item's fees. For each payment mode you can create and connect one fee only.
{% endhint %}
{% endstep %}

{% step %}
#### Review the fee

Send the request to the [Checking of a fee has been applied](https://developer.emporix.io/api-references/api-guides/checkout/fee/api-reference/item-fee-search#post-fee-tenant-itemfees-search) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/fee/{tenant}/itemFees/search?siteCode=main' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "itemYrns": [
      "urn:yaas:saasag:caasproduct:product:tenantName;5c2e4957a46b0e0008491095",
      "urn:yaas:saasag:caasproduct:product:tenantName;5c2e4957a46b0e0008491096"
    ],
    "siteCode": "main"
  }'
```

The response contains the details of the fee applied to the payment for a given site.
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}
 
