---
seo:
  title: Checkout Service Tutorials
  description: checkout setup
icon: graduation-cap
---

# Checkout Tutorial

As the checkout functionality is the core of your commerce operations, make sure it works properly in your online store.

The checkout service validates data that comes from different points in the system: cart, order, payment, delivery zone, shipping method, tax, and customer. Therefore, you need proper configuration of these services to make checkout work as expected.\
This tutorial guides you through the basic setup of the checkout service.

## How to configure the Checkout Service

### Gather information about a customer's session on the storefront

You need details about the customer's access and session tokens as these details influence the checkout process.

1. When a user enters your storefront, before they choose to log in, an anonymous user session is created.

Get an anonymous access token by sending a request to the [Requesting an anonymous token](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/authorization/oauth-service/api-reference/anonymous-token) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id={client_id}'
```

2. Log the customer in and send an authorization request to the [Requesting a customer token](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token) endpoint.

{% hint style="warning" %}
You can skip this step and continue with the checkout process as a guest customer without the need to log in.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer/{tenant}/login' \
  -H 'Authorization: string' \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "customer@emporix.com",
    "password": "Qwurmdch673;'\''"
  }'
```

This operation returns the customer's access token and Saas token, which convey information about the customer and their activities on the storefront. You might need these details in subsequent steps to get a proper authorization when a customer is logged in.

### Add tax configuration

Each country that you operate in may have different tax rules for different products and services. Add relevant configuration to calculate taxes accordingly.

Add tax configuration by sending a request to the [Creating a new tax configuration](https://developer.emporix.io/documentation-portal/api-references/prices-and-taxes/tax-service/api-reference/taxes#post-tax-tenant-taxes) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../prices-and-taxes/tax-service/api-reference/" %}
[api-reference](../../prices-and-taxes/tax-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/tax/{tenant}/taxes' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
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

### Define the delivery zone, method, and time

Delivery zone is the area where you ship your goods to. You can define a country, or a zip code that you operate within.\
Delivery method is dependant on a specific site and delivery zone.

1. Define the delivery zone by sending a request to the [Creating a shipping zone](https://developer.emporix.io/documentation-portal/api-references/delivery-and-shipping/shipping/api-reference/shipping-zones#post-shipping-tenant-site-zones) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../delivery-and-shipping/shipping/api-reference/" %}
[api-reference](../../delivery-and-shipping/shipping/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/{site}/zones' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: fr' \
  -H 'Content-Type: application/json' \
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

2. Specify how the goods can be shipped to a customer by sending a request to the [Creating a shipping method](https://developer.emporix.io/documentation-portal/api-references/delivery-and-shipping/shipping/api-reference/shipping-methods#post-shipping-tenant-site-zones-zoneid-methods) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../delivery-and-shipping/shipping/api-reference/" %}
[api-reference](../../delivery-and-shipping/shipping/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/{site}/zones/{zoneId}/methods' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: fr' \
  -H 'Content-Type: application/json' \
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

3. Define delivery time that will be matched with the delivery method and zone by sending the request to the [Creating a delivery time](https://developer.emporix.io/documentation-portal/api-references/delivery-and-shipping/shipping/api-reference/delivery-times-management#post-shipping-tenant-delivery-times) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../delivery-and-shipping/shipping/api-reference/" %}
[api-reference](../../delivery-and-shipping/shipping/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/delivery-times?validateOverlap=true' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

### Add products to your store

To create and add multiple products to your store, send the request to the [Creating multiple products](https://developer.emporix.io/documentation-portal/api-references/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../products-labels-and-brands/product-service/api-reference/" %}
[api-reference](../../products-labels-and-brands/product-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/product/{tenant}/products/bulk?skipVariantGeneration=false&doIndex=true' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

### Create a price model and connect it to products

Price model defines your pricing strategy. You can specify how you want to go about price tiers and selling volumes.

1. To define a price model send a request to the [Creating a new price model](https://developer.emporix.io/documentation-portal/api-references/prices-and-taxes/price-service/api-reference/price-models#post-price-tenant-pricemodels) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/price/{tenant}/priceModels' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
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

2. Create a price for a specific product by sending a request to the [Creating a new price](https://developer.emporix.io/documentation-portal/api-references/prices-and-taxes/price-service/api-reference/prices#post-price-tenant-prices) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}

```bash
url -i -X POST \
  'https://api.emporix.io/price/{tenant}/prices' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
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

3. Match the price by session context to allow your customers find the best price based on information retrieved from the session context.

{% hint style="danger" %}
The following request requires using the customer's access token for authorization, either anonymous or logged in, as the response contains the bearer's information.
{% endhint %}

Send the request to the [Matching prices for session context](https://developer.emporix.io/documentation-portal/api-references/prices-and-taxes/price-service/api-reference/price-matching#post-price-tenant-match-prices-by-context) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/price/{tenant}/match-prices-by-context' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

### Create a cart

{% hint style="danger" %}
The following requests require using the customer's access token for authorization, either anonymous or logged in, as the response contains the bearer's information.
{% endhint %}

1. You have to enable an option to create a cart on your site while a customer is browsing through your products. Creating a cart takes care of things like gathering customer's session details, even anonymous, or setting up a proper cart's currency for final calculations at checkout.\
   There are two options to create carts using API:

* Create a cart by sending a request to the [Creating a new cart](https://developer.emporix.io/documentation-portal/api-references/checkout/cart/api-reference/carts#post-cart-tenant-carts) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -H 'saas-token: eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2MTQ0MzU2MyIsImV4cCI6MTY5Nzk3MDUyOH0.F0b5jr6KeSoBCj-suTLuasmydaJEudc1ZrESkQXSCGk' \
  -H 'session-id: string' \
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

* Create a cart by sending a `GET` request with `create=true` parameter to the [Retrieving a cart's details by criteria](https://developer.emporix.io/documentation-portal/api-references/checkout/cart/api-reference/carts#get-cart-tenant-carts) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -H 'saas-token: string' \
  -H 'session-id: string' \
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

2. Add items to the cart by sending the request to the [Creating a new cart](https://developer.emporix.io/documentation-portal/api-references/checkout/cart/api-reference/carts#post-cart-tenant-carts) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/items?siteCode=string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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

### Define payment methods

You can configure payment methods in the Payment Gateway Service. Check the available options in the [Payment Systems](https://developer.emporix.io/user-guides/system-management/payment-gateway/payments) documentation.

### Trigger the checkout

{% hint style="warning" %}
To complete the checkout, there are two options:

* The customer has to be logged in to the storefront and then the following request requires using the customer's access token for authorization - see [Gather information about a customer's session on the storefront](checkout.md#Gather-information-about-a-customer's-session-on-the-storefront).
* The customer continues as a guest without logging in - the `customer:guest` field has to be set to `true`.
{% endhint %}

Once a customer places the product in a cart, they can proceed with the checkout process.

The checkout service validates the data that come from customer's session token, the cart, and tiered prices, and then proceeds with the delivery and payment details.\
Then, it handles the payment and creates an order in the system, closing the cart.

You can trigger a checkout process through API as well by sending a request to the [Triggering a checkout](https://developer.emporix.io/documentation-portal/api-references/checkout/checkout/api-reference/checkouts) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/checkout/{tenant}/checkouts/order' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
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
