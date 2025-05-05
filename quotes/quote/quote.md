---
seo:
  title: Quote Service Tutorials
  description: Quote Management
---

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

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

### Update merchant information

Update the merchant information for your tenant's site by sending a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site-mixin" size="small">Partially updating a site mixin</Button></nobr> endpoint.

{% hint style="warning" %}

The following scope is required:

`site.site_manage`

{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "active": true
  }'
  ```

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

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/quote/{tenant}/quote-reasons' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: de' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "PRICE_TOO_HIGH",
    "type": "CHANGE",
    "message": {
      "en": "The price is too high",
      "de": "Der Preis ist zu hoch"
    }
  }'
```

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

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/quote/{tenant}/quotes' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "customerId": "9tt954309b06d46d3cf19fe",
    "employeeId": "9tt954309b06d46d3cf19fa",
    "billingAddressId": "64672a8f9939d331699cbe6e",
    "shippingAddressId": "64672a8f9939d331699cbe6e",
    "companyName": "ABC",
    "siteCode": "main",
    "currency": "USD",
    "validTo": "2022-04-01T04:37:04.301Z",
    "shipping": {
      "value": 10,
      "methodId": "fedex-2dayground",
      "zoneId": "63440460ceeaa26d794fcbbb",
      "shippingTaxCode": "STANDARD"
    },
    "items": [
      {
        "quantity": {
          "quantity": 1,
          "unitCode": "piece"
        },
        "price": {
          "priceId": "6245aa0a78a8576e338fa9c4",
          "unitPrice": 13,
          "totalNetValue": 13,
          "tax": {
            "taxClass": "STANDARD",
            "taxRate": 20
          }
        },
        "product": {
          "productId": "7i98542309b06d46d3cf19fe"
        }
      }
    ],
    "mixins": {
      "customAttributes": {
        "attribute": {
          "value": 1,
          "unit": "kg"
        }
      }
    },
    "metadata": {
      "mixins": {
        "customAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/customAttributes.json"
      }
    }
  }'
  ```

{% hint style="warning" %}

The initial status of a quote request created by a customer is always set to `AWAITING`.
{% endhint %}

### Create a quote on behalf of a customer

To create a quote request on behalf of a customer, you need to call the <nobr><Button to="/openapi/quote/#operation/POST-quote-create-quote" size="small">Creating a quote</Button></nobr> endpoint.

{% hint style="warning" %}

The following scope is required:

`quote.quote_manage`

{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/quote/{tenant}/quotes' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "customerId": "9tt954309b06d46d3cf19fe",
    "employeeId": "9tt954309b06d46d3cf19fa",
    "billingAddressId": "64672a8f9939d331699cbe6e",
    "shippingAddressId": "64672a8f9939d331699cbe6e",
    "companyName": "ABC",
    "siteCode": "main",
    "currency": "USD",
    "validTo": "2022-04-01T04:37:04.301Z",
    "shipping": {
      "value": 10,
      "methodId": "fedex-2dayground",
      "zoneId": "63440460ceeaa26d794fcbbb",
      "shippingTaxCode": "STANDARD"
    },
    "items": [
      {
        "quantity": {
          "quantity": 1,
          "unitCode": "piece"
        },
        "price": {
          "priceId": "6245aa0a78a8576e338fa9c4",
          "unitPrice": 13,
          "totalNetValue": 13,
          "tax": {
            "taxClass": "STANDARD",
            "taxRate": 20
          }
        },
        "product": {
          "productId": "7i98542309b06d46d3cf19fe"
        }
      }
    ],
    "mixins": {
      "customAttributes": {
        "attribute": {
          "value": 1,
          "unit": "kg"
        }
      }
    },
    "metadata": {
      "mixins": {
        "customAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/customAttributes.json"
      }
    }
  }'
  ```

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

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/quote/{tenant}/quotes/{quoteId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

In the following example, an employee updates only the price of requested items:

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/quote/{tenant}/quotes/{quoteId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

### Accept a quote by a customer

When a customer accepts a quote on the storefront, the following endpoint is called: <nobr><Button to="/openapi/quote/#operation/PATCH-quote-update-quote" size="small">Partially updating a quote</Button></nobr>.

{% hint style="warning" %}

The following scope is granted to the customer group:

`quote.quote_manage_own`

{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash

curl -i -X PATCH \
  'https://api.emporix.io/quote/{tenant}/quotes/{quoteId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "op": "replace",
    "path": "/status",
    "value": {
      "value": "ACCEPTED",
      "comment": "new comment"
    }
  }'
```


### Decline a quote by a customer

When a customer changes the quote status to `DECLINED` or `IN_PROGRESS`, or when an employee changes the quote status to `DECLINED_BY_MERCHANT`, they can provide a reason why they performed that action.  
On the storefront, when a customer declines the quote, a request to the following endpoint is sent: <nobr><Button to="/openapi/quote/#operation/PATCH-quote-update-quote" size="small">Partially updating a quote</Button></nobr>.  

{% hint style="warning" %}

The following scope is granted to the customer group:

`quote.quote_manage_own`

{% endhint %}

If the customer wants to provide a reason for declining a quote, they can choose one of the provided reasons from a list of available reasons and/or add comments.

In this example, a customer receives a quote and decides to decline it because the proposed price is too high. They also add a comment to negotiate the price.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/quote/{tenant}/quotes/{quoteId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "op": "replace",
    "path": "/status",
    "value": {
      "value": "DECLINED",
      "comment": "Can you make the price 50$ cheaper?",
      "quoteReasonId": "6437ed5dc0dc2925289a5bbd"
    }
  }'
```




