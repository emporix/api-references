---
seo:
  title: Reward Points Service Tutorials
  description: Reward Points Management
icon: graduation-cap
layout:
  width: wide
---

# Reward-points Tutorial

With the Emporix API Reward Points Service, you can allow your customers to gather reward points for every completed order, or grant points to customers irrespective of the orders they made. Later on, the customers can exchange the collected points for coupons, which are managed through the Coupon Service, and can be added to a cart.

## How to manage the reward points settings for a site

To start using the reward points functionality, first you need to update the reward points configuration for your site.

### Retrieve the current reward points configuration for a site

Check the current reward points mixin configuration for your site by calling the [Retrieving site mixins](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

The following scope is required:

```
site.site_manage
```

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/indexing-service/api-reference/" %}
[api-reference](../../configuration/indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

### Update the reward points settings for a site

The reward points settings are stored in a site's `mixins`, within the coupon settings.

{% hint style="warning" %}
To learn more about mixins in the Emporix Commerce Engine, check out the [_Standard practices_](../standard-practices/mixins.md).
{% endhint %}

The parameters that need to be configured for the reward points are as follows:

* `enable` toggle - a boolean that indicates if the reward points feature is enabled
* `orderValueToRewardPointsFactor` - allows to calculate the number of reward points assigned to a customer after a purchase is made
* `validityInMonths` - specifies the lifespan of reward points
* `couponPrefix` - used to begin the coupon code generated at the moment of the reward points redemption, where the full coupon code with prefix is presented in the following format: `prefix-coupon_code`, for example `L-232394`

To update the reward points settings, send a request to the [Partially updating a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#patch-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

The following scope is required:

```
site.site_manage
```

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../configuration/indexing-service/api-reference/" %}
[api-reference](../../configuration/indexing-service/api-reference/)
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

## How to manage reward points by an employee

As a merchant employee, you can manage your customers' reward points and redemption options.

### Add reward points for a customer

If the reward points functionality is enabled, the reward points entry is created or updated for a customer automatically every time an order is completed.

{% hint style="warning" %}
The communication between reward points and site settings is cached. The cache is invalidated every 15 minutes. It has to be considered after modifying the configuration of reward points in site's mixins.
{% endhint %}

You can also manually add reward points for a customer by sending a request to the [Adding reward points for a customer](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/reward-points/api-reference/reward-points-management#post-reward-points-customer-customerid-addpoints) endpoint.

The following scope is required:

```
rewardspoints.rewardpoints_manage
```

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/reward-points/customer/{customerId}/addPoints?siteCode=main' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "12345fee-0b83-48aa-95dc-11e3dcf84aaa",
    "reference-id": "123456",
    "description": "points added",
    "points": 123,
    "createdAt": "2023-10-24T14:15:22Z",
    "allPointsAfterCreation": 56778,
    "usedPoints": 5,
    "validUntil": "2029-08-24T14:15:22Z",
    "usedWith": [
      "5237bcac-c548-4e49-8626-03dab65376d6"
    ]
  }'
```

### Create reward points redemption options

As a merchant's employee, you can create a list of options for the customers to choose from when redeeming the collected reward points. For example, different types of coupons can be specified.\
To achieve that, you must send a request to the [Creating redemption options](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/reward-points/api-reference/redeem-options-management#post-reward-points-tenant-redeemoptions) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/reward-points/{tenant}/redeemOptions' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "type": "coupon",
    "name": "10 Euro Gutschein",
    "description": "Für 90 Punkte können Sie sich einen Gutschein über 10 Euro generieren lassen. Diesen Gutschein können Sie auch an Freunde und Bekannte weitergeben.",
    "points": 90,
    "coupon": {
      "name": "Gutschein über 10 Euro (eingelöste Bonuspunkte)",
      "description": "Gutschein über 10 Euro aus 1000 Bonuspunkte",
      "discountType": "ABSOLUTE",
      "discountAbsolute": {
        "amount": 10,
        "currency": "EUR"
      },
      "allowAnonymous": true,
      "maxRedemptions": 1,
      "status": "VALID"
    }
  }'
```

## How to manage the reward points by a logged-in customer

Your customers can redeem the collected reward points by paying with coupons that are generated based on the number of collected points.

### Check the available reward points redemption options

If the customer wants to redeem reward points in exchange for a coupon, first they need to check the available coupon options offered by the merchant. To achieve that, they need to send a request to the [Retrieving redemption options](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/reward-points/api-reference/redeem-options-management#get-reward-points-tenant-redeemoptions) endpoint on the storefront.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/reward-points/{tenant}/redeemOptions' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

### Redeem reward points for a coupon code

To create a coupon based on a certain amount of reward points, the customer sends a request to the[Redeeming a logged-in customer's reward points for a coupon code](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/reward-points/api-reference/signed-in-customer-reward-points#post-reward-points-public-customer-redeem) endpoint on the storefront.

{% hint style="warning" %}
Reward points can only be exchanged for percentage and absolute coupons.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/reward-points/public/customer/redeem?siteCode=main' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "575937654bf757001d8496c9"
  }'
```

{% hint style="warning" %}
For more information on applying coupons to cart, check out [_How to apply coupons to a cart_](../coupon/coupon.md#how-to-apply-coupons-to-a-cart) in the Coupon Service guide.
{% endhint %}

### Check the reward points balance and history

Customers can view how many points they have left, and see the history of redeemed reward points.

To check the reward points balance and history, the customer sends a request to the [Retrieving a reward points summary of a signed-in customer](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/reward-points/api-reference/signed-in-customer-reward-points#get-reward-points-public-customer-summary) endpoint on the storefront.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  https://api.emporix.io/reward-points/public/customer/summary \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```
