---
seo:
  title: Coupon Service Tutorials
  description: >-
    coupon, coupons, free shipping, fixed discount, percentage discount,
    discount, discounts, referral, referrals
icon: graduation-cap
layout:
  width: wide
---

# Coupon Tutorial

## How to create a new coupon

To create a new coupon, you need to send a request to the [Creating a new coupon](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons) endpoint.

{% hint style="success" %}
To test the endpoint, open the API reference or check the examples of the curl requests below that refer to different configs.
{% endhint %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

### Creating a free shipping coupon with minimum order value and 1 usage per customer

{% hint style="warning" %}
When creating a free shipping coupon, set `categoryRestricted` to `false`. Do not include `discountAbsolute` or `discountPercentage`. Those fields apply only to `ABSOLUTE` and `PERCENT` discount types.
{% endhint %}

```bash
curl -i -X POST 
  'https://api.emporix.io/coupon/{tenant}/coupons' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
  "code": "ENG2OC0",
  "name": "Winter Sale 2022",
  "description": "Free shipping coupon",
  "discountType": "FREE_SHIPPING",
  "allowAnonymous": false,
  "maxRedemptions": -1,
  "maxRedemptionsPerCustomer": 1,
  "categoryRestricted": false,
  "segmentRestricted": false,
  "restrictions": {
    "validFor": [],
    "validFrom": "2022-02-16T09:04:35.446Z",
    "validUntil": "2022-03-31T10:04:35.446Z",
    "minOrderValue": {
      "amount": 50,
      "currency": "EUR"
    }
  },
  "issuedTo": ""
}'
```

### Creating a coupon with a fixed discount amount for a specific customer

To limit a coupon to a specific customer, you need to provide the customer ID in the `restrictions.validFor` array and `issuedTo` field.

```bash
curl -i -X POST 
 'https://api.emporix.io/coupon/{tenant}/coupons' 
 -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
 -H 'Content-Type: application/json' 
 -d '{
   "code": "ENG2OC0",
   "name": "Winter Sale 2022",
   "description": "Absolute coupon",
   "discountType": "ABSOLUTE",
   "discountAbsolute": {
     "amount": 10,
     "currency": "EUR"
   },
   "allowAnonymous": false,
   "maxRedemptions": -1,
   "maxRedemptionsPerCustomer": -1,
   "categoryRestricted": false,
   "segmentRestricted": false,
   "restrictions": {
     "validFor": [
       "{customerId}"
     ],
     "validFrom": "2021-02-21T09:04:35.446Z",
     "validUntil": "2023-03-31T10:04:35.446Z",
     "minOrderValue": {
       "amount": 50,
       "currency": "EUR"
     }
   },
   "issuedTo": "{customerId}"
 }'
```

### Creating a category coupon with percentage discount

To limit a coupon to a specific category, you need to set the `categoryRestricted` parameter to `true` and provide the category ID in the `restrictions.includedCategories` array.

```bash
curl -i -X POST 
 'https://api.emporix.io/coupon/{tenant}/coupons' 
 -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
 -H 'Content-Type: application/json' 
 -d '{
   "code": "ENG2OC0",
   "name": "Winter Sale 2022",
   "description": "Percentage category coupon",
   "discountType": "PERCENT",
   "discountPercentage": 10,
   "allowAnonymous": false,
   "maxRedemptions": -1,
   "maxRedemptionsPerCustomer": -1,
   "categoryRestricted": true,
   "segmentRestricted": false,
   "restrictions": {
     "validFor": [],
     "validFrom": "2022-02-21T09:04:35.446Z",
     "validUntil": "2022-04-28T10:04:35.446Z",
     "minOrderValue": {
       "amount": 50,
       "currency": "EUR"
     },
     "includedCategories": [
       "{categoryId}"
     ]
   },
   "issuedTo": ""
 }'
```

### Creating a vendor-restricted coupon with a percentage discount

To limit a coupon to products from selected vendors, set `vendorRestricted` to `true` and provide the vendor IDs in the `restrictions.vendors` array. You can combine a vendor restriction with other restriction types.

If you specify `restrictions.minOrderValue`, the Cart Service checks the minimum value against the total of the cart items from the selected vendors.

Use an OAuth2 access token with the `coupon.coupon_manage` scope.

```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/coupons' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "VENDOR10",
    "name": "Vendor sale",
    "description": "10 percent off products from selected vendors",
    "discountType": "PERCENT",
    "discountPercentage": 10,
    "discountCalculationType": "TOTAL",
    "allowAnonymous": false,
    "maxRedemptions": -1,
    "maxRedemptionsPerCustomer": -1,
    "categoryRestricted": false,
    "segmentRestricted": false,
    "vendorRestricted": true,
    "restrictions": {
      "vendors": [
        "5f6a1c2b3d4e5f6789012345"
      ],
      "minOrderValue": {
        "amount": 50,
        "currency": "EUR"
      }
    }
  }'
```

The endpoint returns `201 Created` when the coupon is created.

## How to update an existing coupon

To update an existing coupon, you need to send a request to the [Partially updating a coupon](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#patch-coupon-tenant-coupons-code) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH 
  'https://api.emporix.io/coupon/{tenant}/coupons/{code}' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "Winter Sale 2022",
    "description": "",
    "discountType": "ABSOLUTE",
    "discountAbsolute": {
      "amount": 7,
      "currency": "EUR"
    },
    "allowAnonymous": true,
    "maxRedemptionsPerCustomer": -1,
    "categoryRestricted": false,
    "segmentRestricted": false,
    "metadata": {
      "version": 1,
      "mixins": {}
    },
    "maxRedemptions": -1,
    "restrictions": {
      "validFrom": "2022-03-26T07:41:29.878Z",
      "validUntil": "2023-07-31T05:45:25.934Z",
      "minOrderValue": {
        "amount": 100,
        "currency": "EUR"
      },
      "validFor": []
    },
    "status": "VALID",
    "deleted": false,
    "issuedTo": ""
  }'
```

## How to apply coupons to a cart

You can apply one or more coupons to a cart. Coupons of different types can be applied all at once.

### Specify the number of coupons per cart

If you want to specify how many coupons can be added to a cart, first you need to send a request to the [Updating a configuration](https://developer.emporix.io/api-documentation/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint in the Configuration Service.

In the following example, we are changing the maximum number of coupons that can be applied to a single cart to 3.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference//" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT 
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "key": "maxNumberOfCouponsPerCart",
    "secured": false,
    "value": "3",
    "version": 1
  }'
```

### Apply a coupon to a cart

To apply a coupon to a cart, you need to send a request to the [Applying a discount to cart](https://developer.emporix.io/api-documentation/api-guides/checkout/cart/api-reference/discounts#post-cart-tenant-carts-cartid-discounts) endpoint.

{% hint style="warning" %}
If you want to apply more than one coupon to a cart, you need to send a separate request for each discount coupon.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../checkout/cart/api-reference/" %}
[api-reference](../../checkout/cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/discounts' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "code": "CVMTRE"
  }'
```

{% hint style="warning" %}
Keep the following points in mind when you apply a coupon to a cart:

* Applying a coupon to a cart does not redeem it automatically. For more information, see [How to redeem a coupon](coupon.md#how-to-redeem-a-coupon).
* For cart management, see the [Carts guide](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/core-commerce/carts).
{% endhint %}

## When a coupon is rejected

Coupon eligibility can fail when you create a coupon, validate redeemability, create a redemption, or apply a discount to a cart. Different failures return different HTTP status codes.

#### Coupon Service create failures

| Scenario | Status | Response `type` | Detail / message |
| --- | --- | --- | --- |
| `FREE_SHIPPING` with `discountAbsolute` or `discountPercentage` | `400` | `validation_violation` | `discountAbsolute` / `discountPercentage` must not be provided for a `FREE_SHIPPING` discount |

#### Coupon Service validation and redemption failures

These status codes apply to [Validating redeemability of a coupon](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/coupon-validation) and [Redeeming the coupon by creating a redemption](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/coupon-redemption). Validation and redemption use the same checks. A successful validation returns `200`; a successful redemption returns `201`. Failures return a `business_error` payload with `message` set to `Coupon cannot be redeemed` and a `details[].type` value from the table below.

| Scenario | Status | `details[].type` | `details[].message` |
| --- | --- | --- | --- |
| Coupon expired | `400` | `coupon_expired` | Coupon has expired. |
| Coupon inactive | `400` | `coupon_not_active` | Coupon is not active. |
| Maximum redemptions exceeded | `400` | `coupon_redemptions_exceeded` | Coupon has reached maximum number of redemptions. |
| Minimum order value not met | `400` | `coupon_order_total_too_low` | The order value is too low for this coupon. |
| Order currency does not match the coupon | `400` | `coupon_currency_incorrect` | Currency inconsistent with coupon. |
| Customer is not in a required segment | `400` | `coupon_segment_customer_not_assigned` | The given customer is not a member of a segment for given segment-restricted coupon. |
| Anonymous customer when `allowAnonymous` is `false`, or customer not in `restrictions.validFor` | `403` | `coupon_redemption_forbidden` | This customer is not allowed to redeem this coupon. |
| Seller / service client token (without redeeming on behalf of a customer identity) | `403` | `Forbidden` | Sellers are not allowed to redeem coupons. |
| Missing or insufficient OAuth scopes | `403` | — | Access forbidden for the caller. |
| Invalid or expired access token | `401` | — | Unauthorized. |

{% hint style="info" %}
Use a customer or anonymous access token to validate or redeem, or a service token with `coupon.coupon_redeem_on_behalf` together with a customer identity that the Coupon Service accepts. A plain seller client-credentials token returns `403` before business-rule checks run.
{% endhint %}

#### Cart Service apply-discount failures

| Scenario | Status | Message pattern |
| --- | --- | --- |
| Coupon code not found | `404` | Coupon with code … not found. |
| Coupon not valid for the cart (for example expired) | `400` | Discount with code … is not valid. Please remove your discount with code … |
| Missing or insufficient OAuth scopes | `403` | Access forbidden for the caller. |

Applying a coupon to a cart is not the same as redeeming it. Cart apply can succeed in cases where a later validation or redemption would still return `403` (for example when `allowAnonymous` is `false`). Always validate or complete checkout to confirm redeemability.

## How to redeem a coupon

A coupon can be redeemed in the following ways:

* When a coupon is added to a cart and the order is completed at checkout, the coupon is automatically redeemed by the Checkout Service.
* When you send a request to the [Redeeming the coupon by creating a redemption](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/coupon-redemption) endpoint. This process is independent of the checkout, so a coupon can be used even after an order is created and processed at checkout. This can be done by a merchant on behalf of a customer.

In the following example, we are redeeming a coupon on behalf of a customer.

Redeem a coupon on behalf of a customer by sending a request to the [Redeeming the coupon by creating a redemption](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/coupon-redemption) endpoint. The following scope is required: `coupon.coupon_redeem_on_behalf`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/coupon/{tenant}/coupons/{code}/redemptions' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "customerNumber": "CustomerId",
    "orderTotal": {
      "amount": 1090,
      "currency": "EUR"
    },
    "discount": {
      "amount": 5,
      "currency": "EUR"
    }
  }'
```

{% hint style="warning" %}
The redeemed coupon cannot be used again during checkout.
{% endhint %}

## How to enable referral coupons

### Configure your main site's referral coupon settings

Referral coupon settings are stored in your main site's `couponSettings` mixin.

First, check if your `couponSettings` mixin has already been configured by sending a request to the [Retrieving a site mixin](https://developer.emporix.io/api-documentation/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/site-settings-service/api-reference/" %}
[api-reference](../../configuration/site-settings-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

If your site's `couponSettings` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to configure referral coupons, you need to send a request to the [Creating a site mixin](https://developer.emporix.io/api-documentation/api-guides/configuration/site-settings-service/api-reference/mixins#post-site-tenant-sites-sitecode-mixins) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/site-settings-service/api-reference/" %}
[api-reference](../../configuration/site-settings-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "testMixin": {
      "active": true,
      "metadata": {
        "schema": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/695388d813fd4242de135807_testMixin_v1.json"
      }
    },
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
        "schema": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/couponSettingsSiteMixIn_2.v4"
      }
    }
  }'
```

If your site's `couponSettings` have already been configured, you will receive them in the response body.

In this case, to configure referral coupons, you need to send a request to the [Partially updating a site mixin](https://developer.emporix.io/api-documentation/api-guides/configuration/site-settings-service/api-reference/mixins#patch-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/site-settings-service/api-reference/" %}
[api-reference](../../configuration/site-settings-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH 
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "active": true
  }'
```

### Configure referral email templates

Referral email templates are referenced in the `emailTemplates` configuration in the [Configuration Service](../../configuration/configuration-service/README.md).

First, check if your `emailTemplates` have already been configured by sending a request to the [Retrieving a configuration](https://developer.emporix.io/api-documentation/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

If your `emailTemplates` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to configure referral email templates, you need to send a request to the [Creating configurations](https://developer.emporix.io/api-documentation/api-guides/configuration/configuration-service/api-reference/tenant-configurations#post-configuration-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/configuration/{tenant}/configurations' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
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
}'
```

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

To add referral email templates to an existing `emailTemplates` configuration, you need to send a request to the [Updating a configuration](https://developer.emporix.io/api-documentation/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT 
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
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
  }'
```

## How to generate a referral coupon for a specific customer

To manually generate a referral coupon for a specific customer, you need to send a request to the [Creating a referral coupon code for a specific customer](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/referral-coupon-management#post-coupon-tenant-referral-coupons-customernumber) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/coupon/{tenant}/referral-coupons/{customerNumber}' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

## How to retrieve a specific customer's referral coupon

To retrieve referral coupon information for a specific customer, you need to send a request to the [Retrieving customer's referral coupon code](https://developer.emporix.io/api-documentation/api-guides/rewards-and-promotions/coupon/api-reference/referral-coupon-management#get-coupon-tenant-referral-coupons-customernumber) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/coupon/{tenant}/referral-coupons/{customerNumber}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```
 
