---
seo:
  title: Checkout Service Tutorials
  description: checkout setup
icon: graduation-cap
layout:
  width: wide
---

# Checkout Tutorial

As the checkout functionality is the core of your commerce operations, make sure it works properly in your online store.

The checkout service validates data that comes from different points in the system: cart, order, payment, delivery zone, shipping method, tax, and customer. Therefore, you need proper configuration of these services to make checkout work as expected.\
This tutorial guides you through the basic setup of the checkout service.

## How to configure the Checkout Service

Gather information about a customer's session on the storefront - you need details about the customer's access and session tokens as these details influence the checkout process.

{% stepper %}
{% step %}
### Anonymous session start
When a user enters your storefront, before they choose to log in, an anonymous user session is created.

Get an anonymous access token by sending a request to the [Requesting an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-login) endpoint.

```bash
curl -i -X GET 
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id={client_id}'
```
{% endstep %}
{% step %}
### Log the customer in
Send an authorization request to the [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/customer/{tenant}/login' 
  -H 'Authorization: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "email": "customer@emporix.com",
    "password": "Qwurmdch673;'\''"
  }'
```

{% hint style="warning" %}
You can skip this step and continue with the checkout process as a guest customer without the need to log in.
{% endhint %}

This operation returns the customer's access token and Saas token, which convey information about the customer and their activities on the storefront. You might need these details in subsequent steps to get a proper authorization when a customer is logged in.
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-management/api-reference" %}
[api-reference](../../companies-and-customers/customer-management/api-reference)
{% endcontent-ref %}


### Add tax configuration

Each country that you operate in may have different tax rules for different products and services. Add relevant configuration to calculate taxes accordingly.

{% stepper %}
{% step %}
### Add tax configuration 
Send a request to the [Creating a new tax configuration](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/tax-service/api-reference/taxes#post-tax-tenant-taxes) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/tax/{tenant}/taxes' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "location": {
      "countryCode": "DE"
    },
    "taxClasses": [
      {
        "code": "STANDARD",
        "name": {
          "en": "Standard"
        },
        "order": 0,
        "rate": 19,
        "isDefault": true
      },
      {
        "code": "REDUCED",
        "name": {
          "en": "Reduced"
        },
        "order": 1,
        "rate": 7
      },
      {
        "code": "ZERO",
        "name": {
          "en": "Zero"
        },
        "order": 2,
        "rate": 0
      }
    ]
  }'
```

{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../prices-and-taxes/tax-service/api-reference/" %}
[api-reference](../../prices-and-taxes/tax-service/api-reference/)
{% endcontent-ref %}

## How to determine a tax country at checkout level

The Checkout Service uses a priority-based approach to determine the correct tax country code for accurate tax calculations. Understanding this logic ensures that the correct tax rules are applied to your orders.

The tax country determination follows a specific order, checking multiple sources until a valid country code is found.

### Tax determination priority order

#### Step 1: Check site settings for address type

First, the system checks your site's `taxDeterminationBasedOn` setting to determine which address type should be used for tax determination:

* `SHIPPING_ADDRESS` - use the shipping address for tax calculations
* `BILLING_ADDRESS` - use the billing address for tax calculations

This setting is configured in your site settings and determines which address will be prioritized for tax country determination.

#### Step 2: Check checkout request addresses

The system looks for an address with the matching type in the `addresses` array provided in your checkout request:

* If the configured address type (e.g., `SHIPPING`) is found in the checkout request, its `country` field is used
* **Important fallback**: If the primary address type is not found and `SHIPPING_ADDRESS` was configured, the system automatically falls back to checking for a `BILLING` address
* This ensures tax calculation can proceed even if only one address type is provided

#### Step 3: Check legal entity addresses

If no matching address is found in the checkout request:

* The system checks if the cart has a `legalEntityId` associated with it
* If a legal entity is found, the system retrieves all addresses associated with that legal entity
* The system searches for an address matching the type specified in the site settings
* If found, the legal entity's address country code is used for tax determination

#### Step 4: Check customer addresses

If no legal entity address is found and the checkout is done for a known customer:

* The system retrieves the customer's saved addresses
* The system looks for the default address with the matching type
* If no default address exists with the required type, the first address of that type is used
* If found, the customer address's country code is used

### Example: Tax determination with checkout addresses

When you provide addresses in your checkout request, ensure you include the correct country codes:

```json
{
  "cartId": "9b36757a-5ea1-4689-9ed3-fb630eb5048c",
  "addresses": [
    {
      "contactName": "John Doe",
      "street": "Fritz-Elsaas",
      "streetNumber": "20",
      "zipCode": "70173",
      "city": "Stuttgart",
      "country": "DE",
      "type": "SHIPPING"
    },
    {
      "contactName": "John Doe",
      "street": "Main Street",
      "streetNumber": "100",
      "zipCode": "10001",
      "city": "New York",
      "country": "US",
      "type": "BILLING"
    }
  ],
  "paymentMethods": [...],
  "shipping": {...}
}
```

**Tax determination examples:**

* If your site's `taxDeterminationBasedOn` is set to `SHIPPING_ADDRESS`, the system uses `DE` (Germany) for tax calculations
* If set to `BILLING_ADDRESS`, the system uses `US` (United States) for tax calculations
* If only a billing address is provided but `SHIPPING_ADDRESS` is configured, the system falls back to the billing address country

### Best practices

1. **Always provide both address types** - Include both `SHIPPING` and `BILLING` addresses in your checkout request when possible
2. **Ensure country codes are correct** - Use valid ISO 3166-1 alpha-2 country codes (e.g., "DE", "US", "FR")
3. **Configure tax rules for all markets** - Make sure you have tax configurations for all countries you operate in
4. **Test fallback scenarios** - Verify that tax calculation works correctly when only one address type is provided

### Comparison with Cart tax determination

While both Cart and Checkout services determine tax country, they use different approaches:

**Checkout Service** checks addresses in this order:
1. Checkout request addresses
2. Legal entity addresses
3. Customer addresses

**Cart Service** has a more complex priority with origin tracking:
1. Cart's address with origin `REQUEST`
2. Cart's `countryCode` (backward compatibility)
3. Legal entity addresses
4. Customer addresses
5. Site homebase address

For more information about cart tax determination, see [How to determine a tax country at cart level](https://developer.emporix.io/api-references/api-guides/checkout/cart/cart#how-to-determine-a-tax-country-at-cart-level).

### Define the delivery zone, method, and time

Delivery zone is the area where you ship your goods to. You can define a country, or a zip code that you operate within.
Delivery method is dependant on a specific site and delivery zone.

{% stepper %}
{% step %}
### Define the delivery zone 
Send a request to the [Creating a shipping zone](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping/api-reference/shipping-zones#post-shipping-tenant-site-zones) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/shipping/{tenant}/{site}/zones' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: fr' 
  -H 'Content-Type: application/json' 
  -d '{
    "shipTo": [
      {
        "country": "DE",
        "postalCode": "70190"
      }
    ],
    "name": "Zone 1",
    "id": "zone1",
    "default": true
  }'
```
{% endstep %}
{% step %}
### Specify how the goods can be shipped to a customer
Send a request to the [Creating a shipping method](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping/api-reference/shipping-methods#post-shipping-tenant-site-zones-zoneid-methods) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/shipping/{tenant}/{site}/zones/{zoneId}/methods' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: fr' 
  -H 'Content-Type: application/json' 
  -d '{
    "id": "fedex-2dayground",
    "name": "FedEx 2Day",
    "active": true,
    "maxOrderValue": {
      "amount": 5000,
      "currency": "EUR"
    },
    "fees": [
      {
        "minOrderValue": {
          "amount": 0,
          "currency": "EUR"
        },
        "cost": {
          "amount": 10,
          "currency": "EUR"
        }
      },
      {
        "minOrderValue": {
          "amount": 50,
          "currency": "EUR"
        },
        "cost": {
          "amount": 9,
          "currency": "EUR"
        },
        "shippingGroupId": "group1"
      },
      {
        "minOrderValue": {
          "amount": 200,
          "currency": "EUR"
        },
        "cost": {
          "amount": 8,
          "currency": "EUR"
        },
        "shippingGroupId": "group2"
      }
    ]
  }'
```

{% endstep %}
{% step %}
### Define the delivery time 

The delivery time is matched with the delivery method and zone by sending the request to the [Creating a delivery time](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping/api-reference/delivery-times-management#post-shipping-tenant-delivery-times) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/shipping/{tenant}/delivery-times?validateOverlap=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "siteCode": "main",
    "name": "deliverytime1",
    "isDeliveryDay": true,
    "zoneId": "zone1",
    "day": {
      "weekday": "FRIDAY"
    },
    "isForAllZones": false,
    "timeZoneId": "Europe/Warsaw",
    "deliveryDayShift": 0,
    "slots": [
      {
        "shippingMethod": "method1",
        "deliveryTimeRange": {
          "timeFrom": "10:00",
          "timeTo": "12:00"
        },
        "cutOffTime": {
          "time": "2023-06-12T06:00:00.000Z",
          "deliveryCycleName": "morning"
        },
        "capacity": 100
      }
    ]
  }'
```
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../delivery-and-shipping/shipping/api-reference/" %}
[api-reference](../../delivery-and-shipping/shipping/api-reference/)
{% endcontent-ref %}


### Add products to your store

{% stepper %}
{% step %}
### Create and add multiple products to your store
Send the request to the [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/products/bulk?skipVariantGeneration=false&doIndex=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{}'
```
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../products-labels-and-brands/product-service/api-reference/" %}
[api-reference](../../products-labels-and-brands/product-service/api-reference/)
{% endcontent-ref %}

### Create a price model and connect it to products

Price model defines your pricing strategy. You can specify how you want to go about price tiers and selling volumes.

{% stepper %}
{% step %}
### Define a price model 
Send a request to the [Creating a new price model](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/price-models#post-price-tenant-pricemodels) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/price/{tenant}/priceModels' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "includesTax": true,
    "includesMarkup": true,
    "name": "Piece price model",
    "description": "Sample description",
    "tierDefinition": {
      "tierType": "BASIC",
      "tiers": [
        {
          "minQuantity": {
            "quantity": 0,
            "unitCode": "pc"
          }
        }
      ]
    },
    "measurementUnit": {
      "quantity": 0,
      "unitCode": "pc"
    }
  }'
```
{% endstep %}

{% step %}
### Create a price for a specific product
Send a request to the [Creating a new price](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#post-price-tenant-prices) endpoint.

```bash
url -i -X POST 
  'https://api.emporix.io/price/{tenant}/prices' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "id": "6245aa0a78a8576e338fa9c4",
    "itemId": {
      "itemType": "PRODUCT",
      "id": "5f5a3a365bac380024b93c45"
    },
    "currency": "EUR",
    "location": {
      "countryCode": "DE"
    },
    "priceModelId": "6245a8f578a8576e338fa9c3",
    "restrictions": {
      "siteCodes": [
        "1111"
      ]
    },
    "tierValues": [
      {
        "priceValue": 15.99
      },
      {
        "priceValue": 14.99
      },
      {
        "priceValue": 13.99
      }
    ]
  }'
```
{% endstep %}
{% step %}
### Match the price by session context 
Allow your customers find the best price based on information retrieved from the session context.
Send the request to the [Matching prices for session context](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/price-matching#post-price-tenant-match-prices-by-context) endpoint.


```bash
curl -i -X POST 
  'https://api.emporix.io/price/{tenant}/match-prices-by-context' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "items": [
      {
        "itemId": {
          "itemType": "PRODUCT",
          "id": "5f5a39d95bac380024b93c24"
        },
        "quantity": {
          "quantity": 1,
          "unitCode": "kg"
        }
      }
    ]
  }'
```
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}

### Create a cart

{% hint style="danger" %}
The following requests require using the customer's access token for authorization, either anonymous or logged in, as the response contains the bearer's information.
{% endhint %}

{% stepper %}
{% step %}
### Enable an option to create a cart on your site while a customer is browsing through your products
Creating a cart takes care of things like gathering customer's session details, even anonymous, or setting up a proper cart's currency for final calculations at checkout.
There are two options to create carts using API:

* Create a cart by sending a request to the [Creating a new cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/cart/{tenant}/carts' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2MTQ0MzU2MyIsImV4cCI6MTY5Nzk3MDUyOH0.F0b5jr6KeSoBCj-suTLuasmydaJEudc1ZrESkQXSCGk' 
  -H 'session-id: string' 
  -d '{
    "customerId": "87413250",
    "siteCode": "main",
    "type": "shopping",
    "deliveryWindow": {
      "id": "5b5572a61cf31a000f31eee4",
      "deliveryDate": "2023-06-06T12:00:00.000Z",
      "slotId": "5678-8756-3321-1234"
    },
    "channel": {
      "name": "storefront",
      "source": "https://your-storefront.com/"
    },
    "currency": "EUR"
  }'
```

* Create a cart by sending a `GET` request with `create=true` parameter to the [Retrieving a cart's details by criteria](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/cart/{tenant}/carts' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: string' 
  -H 'session-id: string' 
  -d '{
    "siteCode": "main",
    "currency": "EUR",
    "type": "shopping",
    "channel": {
      "name": "storefront",
      "source": "https://your-storefront.com/"
    },
    "sessionValidated": true
  }'
```
{% endstep %}

{% step %}
### Add items to the cart 
Send a request to the [Creating a new cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/items?siteCode=string' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "itemYrn": "{productYrn}",
    "price": {
      "priceId": "{priceId}",
      "effectiveAmount": 0.3582,
      "originalAmount": 0.3582,
      "currency": "EUR"
    },
    "quantity": 6
  }'
```
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

### Define payment methods

{% stepper %}
{% step %}
### Configure the payment methods

There are several options to configure your payment methods. Check all the available ones in the [Payment Systems](https://developer.emporix.io/user-guides/system-management/payment-gateway/payments) documentation.

{% endstep %}
{% endstepper %}

### Trigger the checkout

{% hint style="warning" %}
To complete the checkout, there are two options:

* The customer has to be logged in to the storefront and then the following request requires using the customer's access token for authorization.
* The customer continues as a guest without logging in - the `customer:guest` field has to be set to `true`.
{% endhint %}

Once a customer places the product in a cart, they can proceed with the checkout process.

The checkout service validates the data that come from customer's session token, the cart, and tiered prices, and then proceeds with the delivery and payment details.
Then, it handles the payment and creates an order in the system, closing the cart.

{% stepper %}
{% step %}
### Start the checkout
Send a request to the [Triggering a checkout](https://developer.emporix.io/api-references/api-guides/checkout/checkout/api-reference/checkouts) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/checkout/{tenant}/checkouts/order' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2MTQ0MzU2MyIsImV4cCI6MTY5Nzk3MDUyOH0.F0b5jr6KeSoBCj-suTLuasmydaJEudc1ZrESkQXSCGk' \
  -d '{
    "cartId": "9b36757a-5ea1-4689-9ed3-fb630eb5048c",
    "paymentMethods": [
      {
        "provider": "payment-gateway",
        "customAttributes": {
          "customer": "635544345",
          "modeId": "9a33c7a5-9535-42af-a936-2fa6ece27579"
        },
        "method": "invoice"
      }
    ],
    "currency": "EUR",
    "shipping": {
      "methodId": "4-more_hours_timeframe",
      "zoneId": "deliveryarea",
      "methodName": "Delivery method name",
      "amount": 10,
      "shippingTaxCode": "STANDARD"
    },
    "deliveryWindowId": "cbda2a28-f0cc-11ed-a05b-0242ac120003",
    "addresses": [
      {
        "contactName": "John Doe",
        "companyName": "Emporix",
        "street": "Fritz-Elsaas",
        "streetNumber": "20",
        "streetAppendix": "",
        "zipCode": "70173",
        "city": "Stuttgart",
        "country": "DE",
        "state": "",
        "contactPhone": "123456789",
        "type": "SHIPPING",
        "metadata": {
          "mixins": {}
        },
        "mixins": {}
      },
      {
        "contactName": "John Doe",
        "companyName": "Emporix",
        "street": "Fritz-Elsaas",
        "streetNumber": "20",
        "streetAppendix": "",
        "zipCode": "70173",
        "city": "Stuttgart",
        "country": "DE",
        "state": "",
        "contactPhone": "123456789",
        "type": "BILLING",
        "metadata": {
          "mixins": {}
        },
        "mixins": {}
      }
    ],
    "customer": {
      "id": "8765472",
      "title": "MR",
      "firstName": "John",
      "middleName": "",
      "lastName": "Doe",
      "contactPhone": "56432245",
      "email": "test@doc.com",
      "company": "Emporix",
      "metadata": {
        "mixins": {}
      },
      "mixins": {}
    }
  }'
```

{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}