---
seo:
  title: Coupon Service Tutorials
  description: coupon, coupons, free shipping, fixed discount, percentage discount, discount, discounts, referral, referrals
toc:
  enable: true
tocMaxDepth: 3
editPage:
  disable: true
label: Tutorials
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Coupon Service Tutorials

## How to create a new coupon

To create a new coupon, you need to send a request to the <nobr><Button to="/openapi/coupon/#operation/POST-coupon-create-coupon" size="small">Creating a new coupon</Button></nobr> endpoint.

### Creating a free shipping coupon with minimum order value and 1 usage per customer

{% hint style="warning" %}

When creating a free shipping coupon, ensure that the `categoryRestricted` parameter is set to `false`.

{% endhint %}

<OpenApiTryIt
  definitionId="coupon"
  operationId="POST-coupon-create-coupon"
  properties={{
    "name": "Winter Sale 2022",
    "code": "ENG2OC0",
    "description": "Free shipping coupon",
    "discountType": "FREE_SHIPPING",
    "categoryRestricted": false,
    "maxRedemptionsPerCustomer": 1,
    "restrictions": {
        "validFor": [],
        "minOrderValue": {
        "amount": 50,
        "currency": "EUR"
        },
        "validFrom": "2022-02-16T09:04:35.446Z",
        "validUntil": "2022-03-31T10:04:35.446Z"
        },
    "allowAnonymous": false,
    "issuedTo": ""
  }}
/>

### Creating a coupon with a fixed discount amount for a specific customer

To limit a coupon to a specific customer, you need to provide the customer ID in the `restrictions.validFor` array and `issuedTo` field.

<OpenApiTryIt
  definitionId="coupon"
  operationId="POST-coupon-create-coupon"
  properties={{
    "name": "Winter Sale 2022",
    "code": "ENG2OC0",
    "description": "Absolute coupon",
    "discountType": "ABSOLUTE",
    "categoryRestricted": false,
    "discountAbsolute": {
        "amount": 10,
        "currency": "EUR"
    },
    "restrictions": {
        "validFor": [
            "{customerId}"
            ],
        "minOrderValue": {
        "amount": 50,
        "currency": "EUR"
        },
        "validFrom": "2021-02-21T09:04:35.446Z",
        "validUntil": "2023-03-31T10:04:35.446Z"
    },
    "issuedTo": "{customerId}",
    "allowAnonymous": false
    }}
/>

### Creating a category coupon with percentage discount

To limit a coupon to a specific category, you need to set the `categoryRestricted` parameter to `true` and provide the category ID in the `restrictions.includedCategories` array.

<OpenApiTryIt
  definitionId="coupon"
  operationId="POST-coupon-create-coupon"
  properties={{
    "name": "Winter Sale 2022",
    "code": "ENG2OC0",
    "description": "Percentage category coupon",
    "discountType": "PERCENT",
    "categoryRestricted": true,
    "discountPercentage": 10,
    "restrictions": {
        "validFor": [],
        "minOrderValue": {
        "amount": 50,
        "currency": "EUR"
        },
        "validFrom": "2022-02-21T09:04:35.446Z",
        "validUntil": "2022-04-28T10:04:35.446Z",
        "includedCategories": [
            "{categoryId}"
        ]
    },
    "allowAnonymous": false,
    "issuedTo": ""
  }}
/>


## How to update an existing coupon

To update an existing coupon, you need to send a request to the <nobr><Button to="/openapi/coupon/#operation/PATCH-coupon-update-coupon" size="small">Partially updating a coupon</Button></nobr> endpoint.

{% endhint %}info

For more information on managing carts, check out the [*Carts guide*](https://developer.emporix.io/user-guides/core-commerce/carts/carts).

{% endhint %}

<OpenApiTryIt
  definitionId="coupon"
  operationId="PATCH-coupon-update-coupon"
  properties={{
    "name":"Winter Sale 2022",
    "description":"",
    "discountType":"ABSOLUTE",
    "allowAnonymous":true,
    "categoryRestricted":false,
    "metadata":{
        "mixins":{
        },
        "version":1
    },
    "status":"VALID",
    "deleted":false,
    "restrictions":{
        "validFor": [],
        "validFrom":"2022-03-26T07:41:29.878Z",
        "minOrderValue":{
            "amount": 100,
            "currency":"EUR"
        }
    },
    "issuedTo": ""
  }}
/>

## How to apply coupons to a cart

You can apply one or more coupons to a cart. Coupons of different types can be applied all at once.

### Specify the number of coupons per cart

If you want to specify how many coupons can be added to a cart, first you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/PUT-configuration-update-config" size="small">Updating a configuration</Button></nobr> endpoint in the Configuration Service.

In the following example, we are changing the maximum number of coupons that can be applied to a single cart to 3.

<OpenApiTryIt
  definitionId="configuration"
  operationId="PUT-configuration-update-config"
    parameters={{
    path:{
         "propertyKey": "maxNumberOfCouponsPerCart"
    }
  }}
    properties={{
      key: "maxNumberOfCouponsPerCart",
      value: "3"
  }}
  />

### Apply a coupon to a cart

To apply a coupon to a cart, you need to send a request to the <nobr><Button to="/openapi/cart/#operation/POST-cart-apply-discount" size="small">Applying a discount to cart</Button></nobr> endpoint.

{% endhint %}info

If you want to apply more than one coupon to a cart, you need to send a separate request for each discount coupon.
{% endhint %}

<OpenApiTryIt
  definitionId="cart"
  operationId="POST-cart-apply-discount"
  defaultExample="Coupon-code-only payload example"
/>


{% hint style="warning" %}
Applying the coupon to cart does not mean that the coupon is automatically redeemed. For more information, check out [How to redeem a coupon](#how-to-redeem-a-coupon).
{% endhint %}

## How to redeem a coupon

A coupon can be redeemed in the following ways:

* When a coupon is added to a cart and the order is completed at checkout, the coupon is automatically redeemed by the Checkout Service.
* When you send a request to the <nobr><Button to="/openapi/coupon/#operation/POST-coupon-invalidate-coupon" size="small">Redeeming the coupon by creating a redemption</Button></nobr> endpoint. This process is independent of the checkout, so a coupon can be used even after an order is created and processed at checkout. This can be done by a merchant on behalf of a customer.

In the following example, we are redeeming a coupon on behalf of a customer.

Redeem a coupon on behalf of a customer by sending a request to the <nobr><Button to="/openapi/coupon/#operation/POST-coupon-invalidate-coupon" size="small">Redeeming the coupon by creating a redemption</Button></nobr> endpoint. The following scope is required:

```
coupon.coupon_redeem_on_behalf
```

<OpenApiTryIt
  definitionId="coupon"
  operationId="POST-coupon-invalidate-coupon"
  properties={{
    "orderTotal": {
      "currency": "EUR"
      },
    "discount": {
      "currency": "EUR"
      }
    }}
/>

{% endhint %}info

The redeemed coupon cannot be used used again during checkout.
{% endhint %}

## How to enable referral coupons

### Configure your main site's referral coupon settings

Referral coupon settings are stored in your main site's `couponSettings` mixin.


First, check if your `couponSettings` mixin has already been configured by sending a request to the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-retrieve-site-mixin" size="small">Retrieving a site mixin</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="GET-site-settings-retrieve-site-mixin"
  parameters={{
    path: {
        "mixinName": "couponSettings"
    }
  }}
/>

If your site's `couponSettings` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to configure referral coupons, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/POST-site-settings-create-site-mixin" size="small">Creating a site mixin</Button></nobr> endpoint.


<OpenApiTryIt
  definitionId="site-settings"
  operationId="POST-site-settings-create-site-mixin"
  properties={{
    "couponSettings": {
        "codePrefix": "XYZ",
        "length": 3,
        "sendReferralCoupon": true,
        "referral": {
            "codePrefix": "REF",
            "value": 5,
            "redemptionCodeValue": 5
        },
        "metadata": {
            "schema": "https://res.cloudinary.com/saas-ag/raw/upload/hybris_schema/couponSettingsSiteMixIn.v4"
        }
    }
  }}
/>

If your site's `couponSettings` have already been configured, you will receive them in the response body.

In this case, to configure referral coupons, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site-mixin" size="small">Partially updating a site mixin</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site-mixin"
  properties={{
    "codePrefix": "XYZ",
    "length": 3,
    "sendReferralCoupon": true,
    "referral": {
        "codePrefix": "REF",
        "value": 5,
        "redemptionCodeValue": 5
    }
  }}
/>

### Configure referral email templates

Referral email templates are referenced in the `emailTemplates` configuration in the [Configuration Service](/openapi/configuration/).

First,  check if your `emailTemplates` have already been configured by sending a request to the <nobr><Button to="/openapi/configuration/#operation/GET-configuration-retrieve-config" size="small">Retrieving a configuration</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="GET-configuration-retrieve-config"
/>


If your `emailTemplates` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to configure referral email templates, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/POST-configuration-create-config" size="small">Creating configurations</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="POST-configuration-create-config"
  properties={{
    "key": "emailTemplates",
    "secured": false,
    "value": [
        {
            "name": "referralCouponMailTemplate",
            "languages": {
                "de": 604558,
                "en": 604608,
                "pt": 1694106,
                "nb": 855168
            }
        },
        {
            "name": "referralCouponRedemptionMailTemplate",
            "languages": {
                "de": 605150,
                "en": 605211,
                "pt": 1694130,
                "nb": 858154
            }
        }
    ],
    "version": 0
  }}
/>

If your `emailTemplates` have already been configured, you will receive them in the response body.

In this case, you need to copy the response body and add the following objects to the `value` array:

```json
{
    "name": "referralCouponMailTemplate",
    "languages": {
        "de": 604558,
        "en": 604608,
        "pt": 1694106,
        "nb": 855168
    }
},
{
    "name": "referralCouponRedemptionMailTemplate",
    "languages": {
        "de": 605150,
        "en": 605211,
        "pt": 1694130,
        "nb": 858154
    }
}
```

To add referral email templates to an existing `emailTemplates` configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/PUT-configuration-update-config" size="small">Updating a configuration</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="PUT-configuration-update-config"
  parameters={{
    path: {
        "propertyKey": "emailTemplates"
    }
  }}
  properties={{
    "key": "emailTemplates",
        "secured": false,
        "value": [
            {
                "name": "newCustomerMailTemplate",
                "languages": {
                    "de": 603821,
                    "en": 603701,
                    "pt": 1694076,
                    "nb": 858273
                }
            },
            {
                "name": "referralCouponMailTemplate",
                "languages": {
                    "de": 604558,
                    "en": 604608
                }
            },
            {
                "name": "referralCouponRedemptionMailTemplate",
                "languages": {
                    "de": 605150,
                    "en": 605211
                }
            }
        ],
        "version": 0
  }}
/>

## How to generate a referral coupon for a specific customer

To manually generate a referral coupon for a specific customer, you need to send a request to the <nobr><Button to="/openapi/coupon/#operation/POST-coupon-create-referral-coupon-code" size="small">Creating a referral coupon code for a specific customer</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="coupon"
  operationId="POST-coupon-create-referral-coupon-code"
/>

## How to retrieve a specific customer's referral coupon

To retrieve referral coupon information for a specific customer, you need to send a request to the <nobr><Button to="/openapi/coupon/#operation/GET-coupon-retrieve-referral-coupon" size="small">Retrieving customer's referral coupon code</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="coupon"
  operationId="GET-coupon-retrieve-referral-coupon"
/>
