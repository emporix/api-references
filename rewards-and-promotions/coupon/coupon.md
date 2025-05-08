---
seo:
  title: Coupon Service Tutorials
  description: coupon, coupons, free shipping, fixed discount, percentage discount, discount, discounts, referral, referrals
---


# How to create a new coupon

To create a new coupon, you need to send a request to the [Creating a new coupon](https://emporix.gitbook.io/documentation-portal/api-references/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons) endpoint.

## Creating a free shipping coupon with minimum order value and 1 usage per customer

{% hint style="warning" %}

When creating a free shipping coupon, ensure that the `categoryRestricted` parameter is set to `false`.

{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../coupon/api-reference/" %}
[api-reference](../coupon/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/coupons' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
  "code": "ENG2OC0",
  "name": "Winter Sale 2022",
  "description": "Free shipping coupon",
  "discountType": "FREE_SHIPPING",
  "discountAbsolute": {
    "amount": 24.99,
    "currency": "USD"
  },
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

## Creating a coupon with a fixed discount amount for a specific customer

To limit a coupon to a specific customer, you need to provide the customer ID in the `restrictions.validFor` array and `issuedTo` field.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../coupon/api-reference/" %}
[api-reference](../coupon/api-reference/)
{% endcontent-ref %}

 ```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/coupons' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

## Creating a category coupon with percentage discount

To limit a coupon to a specific category, you need to set the `categoryRestricted` parameter to `true` and provide the category ID in the `restrictions.includedCategories` array.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../coupon/api-reference/" %}
[api-reference](../coupon/api-reference/)
{% endcontent-ref %}

 ```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/coupons' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "ENG2OC0",
    "name": "Winter Sale 2022",
    "description": "Percentage category coupon",
    "discountType": "PERCENT",
    "discountAbsolute": {
      "amount": 24.99,
      "currency": "USD"
    },
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
    "issuedTo": "",
    "discountPercentage": 10
  }'
```


# How to update an existing coupon

To update an existing coupon, you need to send a request to the <nobr><Button to="/openapi/coupon/#operation/PATCH-coupon-update-coupon" size="small">Partially updating a coupon] endpoint.

{% hint style="warning" %}

For more information on managing carts, check out the [*Carts guide*](ce/core-commerce/carts).

{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../coupon/api-reference/" %}
[api-reference](../coupon/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/coupon/{tenant}/coupons/{code}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Winter Sale 2022",
    "description": "",
    "discountType": "ABSOLUTE",
    "discountPercentage": 7,
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

# How to apply coupons to a cart

You can apply one or more coupons to a cart. Coupons of different types can be applied all at once.

## Specify the number of coupons per cart

If you want to specify how many coupons can be added to a cart, first you need to send a request to the [Updating a configuration](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint in the Configuration Service.

In the following example, we are changing the maximum number of coupons that can be applied to a single cart to 3.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "key": "maxNumberOfCouponsPerCart",
    "secured": false,
    "value": "3",
    "version": 1
  }'
```

## Apply a coupon to a cart

To apply a coupon to a cart, you need to send a request to the [Applying a discount to cart](https://emporix.gitbook.io/documentation-portal/api-references/checkout/cart/api-reference/discounts#post-cart-tenant-carts-cartid-discounts) endpoint.

{% hint style="warning" %}

If you want to apply more than one coupon to a cart, you need to send a separate request for each discount coupon.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../checkout/cart/api-reference/" %}
[api-reference](../../checkout/cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/discounts' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "CVMTRE"
  }'
  ```

{% hint style="warning" %}
Applying the coupon to cart does not mean that the coupon is automatically redeemed. For more information, check out [How to redeem a coupon](./coupon.md#how-to-redeem-a-coupon).
{% endhint %}

# How to redeem a coupon

A coupon can be redeemed in the following ways:

* When a coupon is added to a cart and the order is completed at checkout, the coupon is automatically redeemed by the Checkout Service.
* When you send a request to the [Redeeming the coupon by creating a redemption](https://emporix.gitbook.io/documentation-portal/api-references/rewards-and-promotions/coupon/api-reference/coupon-redemption#post-coupon-tenant-coupons-code-redemptions) endpoint. This process is independent of the checkout, so a coupon can be used even after an order is created and processed at checkout. This can be done by a merchant on behalf of a customer.

In the following example, we are redeeming a coupon on behalf of a customer.

Redeem a coupon on behalf of a customer by sending a request to the [Redeeming the coupon by creating a redemption](https://emporix.gitbook.io/documentation-portal/api-references/rewards-and-promotions/coupon/api-reference/coupon-redemption#post-coupon-tenant-coupons-code-redemptions) endpoint. The following scope is required:

```
coupon.coupon_redeem_on_behalf
```

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../coupon/api-reference/" %}
[api-reference](../coupon/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/coupons/{code}/redemptions' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

The redeemed coupon cannot be used used again during checkout.
{% endhint %}

# How to enable referral coupons

## Configure your main site's referral coupon settings

Referral coupon settings are stored in your main site's `couponSettings` mixin.


First, check if your `couponSettings` mixin has already been configured by sending a request to the [Retrieving a site mixin](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/site-settings-service/api-reference/" %}
[api-reference](../../configuration/site-settings-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

If your site's `couponSettings` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to configure referral coupons, you need to send a request to the [Creating a site mixin](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/mixins#post-site-tenant-sites-sitecode-mixins) endpoint.


{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/site-settings-service/api-reference/" %}
[api-reference](../../configuration/site-settings-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "testMixin": {
      "active": true,
      "metadata": {
        "schema": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/testMixin.json"
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
        "schema": "https://res.cloudinary.com/saas-ag/raw/upload/hybris_schema/couponSettingsSiteMixIn.v4"
      }
    }
  }'
```

If your site's `couponSettings` have already been configured, you will receive them in the response body.

In this case, to configure referral coupons, you need to send a request to the [Partially updating a site mixin](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/mixins#patch-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/site-settings-service/api-reference/" %}
[api-reference](../../configuration/site-settings-service/api-reference/)
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

## Configure referral email templates

Referral email templates are referenced in the `emailTemplates` configuration in the [Configuration Service](/openapi/configuration/).

First,  check if your `emailTemplates` have already been configured by sending a request to the [Retrieving a configuration](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

If your `emailTemplates` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to configure referral email templates, you need to send a request to the [Creating configurations](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#post-configuration-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/configuration/{tenant}/configurations' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

To add referral email templates to an existing `emailTemplates` configuration, you need to send a request to the [Updating a configuration](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/configuration-service/api-reference/" %}
[api-reference](../../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

# How to generate a referral coupon for a specific customer

To manually generate a referral coupon for a specific customer, you need to send a request to the [Creating a referral coupon code for a specific customer](https://emporix.gitbook.io/documentation-portal/api-references/rewards-and-promotions/coupon/api-reference/referral-coupon-management#post-coupon-tenant-referral-coupons-customernumber) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../coupon/api-reference/" %}
[api-reference](../coupon/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/referral-coupons/{customerNumber}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

# How to retrieve a specific customer's referral coupon

To retrieve referral coupon information for a specific customer, you need to send a request to the [Retrieving customer's referral coupon code](https://emporix.gitbook.io/documentation-portal/api-references/rewards-and-promotions/coupon/api-reference/referral-coupon-management#get-coupon-tenant-referral-coupons-customernumber) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../coupon/api-reference/" %}
[api-reference](../coupon/api-reference/)
{% endcontent-ref %}
```bash
curl -i -X GET \
  'https://api.emporix.io/coupon/{tenant}/referral-coupons/{customerNumber}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```