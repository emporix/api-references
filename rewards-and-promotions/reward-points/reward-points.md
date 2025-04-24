---
seo:
  title: Reward Points Service Tutorials
  description: Reward Points Management
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';


# Reward Points Service Tutorials

With the Emporix API Reward Points Service, you can allow your customers to gather reward points for every completed order, or grant points to customers irrespective of the orders they made. Later on, the customers can exchange the collected points for coupons, which are managed through the Coupon Service, and can be added to a cart.
 
## How to manage the reward points settings for a site

To start using the reward points functionality, first you need to update the reward points configuration for your site.

### Retrieve the current reward points configuration for a site

Check the current reward points mixin configuration for your site by calling the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-list-site-mixins" size="small">Retrieving site mixins</Button></nobr> endpoint.

The following scope is required: 

```
site.site_manage
```

<OpenApiTryIt
  definitionId="site-settings"
  operationId="GET-site-settings-list-site-mixins"
/>

### Update the reward points settings for a site

The reward points settings are stored in a site's `mixins`, within the coupon settings.

{% hint style="warning" %}

To learn more about mixins in the Emporix Commerce Engine, check out the [Standard Practices in the Emporix API](/content/standard-practices.mdx).

{% endhint %}

The parameters that need to be configured for the reward points are as follows:

* `enable` toggle - a boolean that indicates if the reward points feature is enabled
* `orderValueToRewardPointsFactor` - allows to calculate the number of reward points assigned to a customer after a purchase is made
* `validityInMonths` - specifies the lifespan of reward points
* `couponPrefix` - used to begin the coupon code generated at the moment of the reward points redemption, where the full coupon code with prefix is presented in the following format: `prefix-coupon_code`, for example `L-232394`

To update the reward points settings, send a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site-mixin" size="small">Partially updating a site mixin</Button></nobr> endpoint.

The following scope is required: 

```
site.site_manage
```

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site-mixin"
  defaultExample="Reward points update"
/>


## How to manage reward points by an employee

As a merchant employee, you can manage your customers' reward points and redemption options.

### Add reward points for a customer

If the reward points functionality is enabled, the reward points entry is created or updated for a customer automatically every time an order is completed.

{% hint style="warning" %}

The communication between reward points and site settings is cached. The cache is invalidated every 15 minutes. It has to be considered after modifying the configuration of reward points in site's mixins.
{% endhint %}

You can also manually add reward points for a customer by sending a request to the <nobr><Button to="/openapi/reward-points/#operation/POST-reward-points-add-customer-reward-points" size="small">Adding reward points for a customer</Button></nobr> endpoint.

The following scope is required: 

```
rewardspoints.rewardpoints_manage
```

<OpenApiTryIt
  definitionId="reward-points"
  operationId="POST-reward-points-add-customer-reward-points"
/>

### Create reward points redemption options

As a merchant's employee, you can create a list of options for the customers to choose from when redeeming the collected reward points. For example, different types of coupons can be specified.
To achieve that, you must send a request to the <nobr><Button to="/openapi/reward-points/#operation/POST-reward-points-create-redeem-options" size="small">Creating redemption options</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="reward-points"
  operationId="POST-reward-points-create-redeem-options"
/>


## How to manage the reward points by a logged-in customer

Your customers can redeem the collected reward points by paying with coupons that are generated based on the number of collected points.

### Check the available reward points redemption options

If the customer wants to redeem reward points in exchange for a coupon, first they need to check the available coupon options offered by the merchant. To achieve that, they need to send a request to the <nobr><Button to="/openapi/reward-points/#operation/GET-reward-points-list-redeem-options" size="small">Retrieving redemption options</Button></nobr> endpoint on the storefront.

<OpenApiTryIt
  definitionId="reward-points"
  operationId="GET-reward-points-list-redeem-options"
/>

### Redeem reward points for a coupon code 

To create a coupon based on a certain amount of reward points, the customer sends a request to the <nobr><Button to="/openapi/reward-points/#operation/POST-reward-points-redeem-logged-customer-reward-points-coupon" size="small">Redeeming a logged-in customer's reward points for a coupon code</Button></nobr> endpoint on the storefront.

{% hint style="warning" %}

Reward points can only be exchanged for percentage and absolute coupons.
{% endhint %}

<OpenApiTryIt
  definitionId="reward-points"
  operationId="POST-reward-points-redeem-logged-customer-reward-points-coupon"
/>


{% hint style="warning" %}
For more information on applying coupons to cart, check out [*How to apply coupons to a cart*](/content/coupon/#how-to-apply-coupons-to-a-cart) in the Coupon Service guide.
{% endhint %}

### Check the reward points balance and history

Customers can view how many points they have left, and see the history of redeemed reward points.

To check the reward points balance and history, the customer sends a request to the <nobr><Button to="/openapi/reward-points/#operation/GET-reward-points-retrieve-logged-customer-reward-summary" size="small">Retrieving a reward points summary of a signed-in customer</Button></nobr> endpoint on the storefront.

<OpenApiTryIt
  definitionId="reward-points"
  operationId="GET-reward-points-retrieve-logged-customer-reward-summary"
/>