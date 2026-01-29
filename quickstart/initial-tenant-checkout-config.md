---
description: Start configuring a fresh tenant to enable your online store quickly and efficiently.
icon: store
layout:
  width: wide
---

# Tenant Configuration Tutorial

This tutorial guides developers through configuration steps of a fresh Emporix tenant with the aim of enabling checkout functionality in the storefront. Start with a brand new tenant to set up and enable all the required features from scratch.

The steps take you through the following paths:

* **Tenant setup** - Basic tenant and site settings
* **Data import** - Catalog, products, and pricing setup
* **Customer setup** - Test customer and address configuration
* **Storefront checkout flow** - The scenario to make a purchase and complete checkout on the storefront as a customer

After completing the steps you will understand the minimum configuration needed for checkout and how to successfully complete a checkout in the [Emporix B2B Commerce Frontend](https://app.gitbook.com/s/OgeoK7nW6gEh0q1ceUZP/), or a custom storefront solution. The described steps help you achieve a working configuration for the whole checkout flow with simple examples, but you can further extend this configuration for your specific business needs. Consider configuring multiple delivery times (for scheduled deliveries), multiple shipping methods (for different delivery options), multiple payment methods (for customer choice), enhancing product with images and media, as well as brand and label setup.

## Prerequisites

To get started, make sure you have:

* **Emporix Account** - an active Emporix tenant created
* **API keys** - credentials to make relevant API calls

{% hint style="info" %}

We recommend you to be prepared to collect these values as you go. Each step lists where to copy them from.

| Placeholder | Description | Where it comes from |
| --- | --- | --- |
| `{{tenant}}` | Tenant identifier | Your tenant id |
| `{{client_id}}`, `{{client_secret}}` | Service credentials | Emporix Developer Portal |
| `{{storefront_client_id}}` | Storefront client id | Emporix Developer Portal |
| `{{category_id}}` | Category id | Create a category response |
| `{{product_id}}` | Product id | Create a product response |
| `{{priceModelId}}` | Price model id | Create a price model response |
| `{{priceId}}` | Price id | Create a price response |
| `{{zoneId}}` | Shipping zone id | Create a shipping zone response |
| `{{shipping_method_id}}` | Shipping method id | Create a shipping method response |
| `{{cartId}}` | Cart id | Create a cart response |

{% endhint %}

### Authorization and headers

Use a service access token for configuration steps (tenant setup, data import). For storefront flow, use:

* **Anonymous Access Token** - for anonymous session and cart creation before login.
* **Customer Access Token** - after login, for cart updates and checkout.

Some checkout endpoints also require `saas-token` and `session-id` headers, which you obtain from the login/anonymous session response and should pass through your storefront.

{% stepper %}
{% step %}
### Get authorization token
To obtain proper access, send the authorization request to the [Requesting a service access token](https://developer.emporix.io/api-references/api-guides/authorization/oauth-service/api-reference/service-access-token) endpoint.

```bash
curl --location 'https://api.emporix.io/oauth/token' 
--header 'Content-Type: application/x-www-form-urlencoded' 
--data-urlencode 'grant_type=client_credentials' 
--data-urlencode 'client_id={{client_id}}' 
--data-urlencode 'client_secret={{client_secret}}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../authorization/oauth-service/api-reference/" %}
[api-reference](../authorization/oauth-service/api-reference/)
{% endcontent-ref %}
{% endstep %}
{% endstepper %}

## How to enable checkout functionality

### Configure a fresh tenant

Follow these steps to provide basic configuration for your tenant, such as payment, site, language, currency, tax, and shipping zones and methods. 

{% hint style="success" %}
There is also a convenient alternative way for initial tenant configuration. You can use the [Emporix Terraform Provider](/quickstart/emporix-terraform-provider.md) to automate the process. 
{% endhint %}

{% stepper %}
{% step %}
### Configure payment method
Create `invoice` for a minimal setup of payments. To create a new payment method, call the [Creating a single payment mode entity](https://developer.emporix.io/api-references/api-guides/checkout/payment-gateway/api-reference/payment-mode#post-payment-gateway-tenant-paymentmodes-config) endpoint.
For real payments, configure a provider-specific mode with its required credentials.

```bash
curl 'https://api.emporix.io/payment-gateway/{{tenant}}/paymentmodes/config' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
  "code": "invoice",
  "active": true,
  "provider": "INVOICE",
  "configuration": {
      
    }
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../checkout/payment-gateway/api-reference/" %}
[api-reference](../checkout/payment-gateway/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Activate a country, currency and language
You need to activate countries where you want to operate, as well as add relevant currency and language.

* Activate a country with the [Updating a country](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#patch-country-tenant-countries-countrycode) request, for example Poland:

```bash
curl 'https://api.emporix.io/country/{{tenant}}/countries/PL' \
  --request PATCH \
  --header 'X-Version: v2' \
  --header 'Content-Type: application/json' \
  --data '{
  "active": true,
  "metadata": {
    "version": 1
  }
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../configuration/country-service/api-reference/" %}
[api-reference](../configuration/country-service/api-reference/)
{% endcontent-ref %}

* You need to activate currencies relevant for the countries where your business operates or relevant to your business model. Ensure currency codes are ISO 4217 compliant.
Create a `Polish Zloty` currency with the [Creating a new currency](https://developer.emporix.io/api-references/api-guides/configuration/currency-service/api-reference/currencies#post-currency-tenant-currencies) endpoint:

```bash
curl 'https://api.emporix.io/currency/{{tenant}}/currencies' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
  "code": "PLN",
  "name": {
    "en": "Polish Zloty"
  }
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../configuration/currency-service/api-reference/" %}
[api-reference](../configuration/currency-service/api-reference/)
{% endcontent-ref %}

* Specify the languages that your business communicates with suppliers and customers. Emporix supports all existing languages, including regional language variants. The tenant's language configuration is stored under the `project_lang` key, while site-specific language configuration is stored in the `defaultLanguage` and `languages` fields, inside the `Site` object.
To set `Polish` and `English` as project languages, use the [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint:

```bash
curl 'https://api.emporix.io/configuration/{{tenant}}/configurations/project_lang' \
  --request PUT \
  --header 'Content-Type: application/json' \
  --data '{
    "key": "project_lang",
    "value": "[{\"id\":\"en\",\"label\":\"English\",\"default\":true,\"required\":true},{\"id\":\"pl\",\"label\":\"Polish\",\"default\":false}]"
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../configuration/configuration-service/api-reference/" %}
[api-reference](../configuration/configuration-service/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Add relevant tax calculation configuration
Tax rates define the checkout calculations relevant to a given country.
Create tax classes with rates applicable in Poland using the [Creating a new tax configuration](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/tax-service/api-reference/taxes#post-tax-tenant-taxes) endpoint.
Ensure your rates reflect the desired gross/net calculation strategy for your storefront.

```bash
curl 'https://api.emporix.io/tax/{{tenant}}/taxes' \
  --request POST \
  --header 'Content-Language: ' \
  --header 'Content-Type: application/json' \
  --data '{
    "location": {
        "countryCode": "PL"
    },
    "taxClasses": [
        {
            "rate": 23,
            "code": "STANDARD",
            "name": {
                "en": "STANDARD"
            },
            "description": {
                "en": "STANDARD"
            }
        },
        {
            "rate": 8,
            "code": "REDUCED_8",
            "name": {
                "en": "REDUCED_8"
            },
            "description": {
                "en": "REDUCED_8"
            }
        },
        {
            "rate": 5,
            "code": "REDUCED_5",
            "name": {
                "en": "REDUCED_5"
            },
            "description": {
                "en": "REDUCED_5"
            }
        },
        {
            "rate": 0,
            "code": "ZERO",
            "name": {
                "en": "ZERO"
            },
            "description": {
                "en": "ZERO"
            }
        }
    ]
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../prices-and-taxes/tax-service/api-reference/" %}
[api-reference](../prices-and-taxes/tax-service/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Create a site
Determine a site by a country you operate in or by a brand you want to sell in your store. 
Create a `PL` site for the Polish market by sending a request to the [Creating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#post-site-tenant-sites) endpoint. Include the `homeBase` address country, which is required for shipping calculations. Keep site, country, currency, tax, and shipping zone aligned.

```bash
curl 'https://api.emporix.io/site/{{tenant}}/sites' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "active": true,
    "name": {
        "en": "Inpost",
        "pl": "Inpost"
    },
    "id": "inpost",
    "fees": [
        {
            "minOrderValue": {
                "amount": 0,
                "currency": "PLN"
            },
            "cost": {
                "amount": 0,
                "currency": "PLN"
            }
        }
    ],
    "shippingTaxCode": "STANDARD",
    "maxOrderValue": {
        "amount": 999999,
        "currency": "PLN"
    },
    "homeBase": {
        "country": "PL"
    }
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../configuration/site-settings-service/api-reference/" %}
[api-reference](../configuration/site-settings-service/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Configure a shipping zone, method and delivery times
Define where you want to ship your goods and how. 

* First, set the ship-to location for the site using the [Creating a shipping zone](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping-1/api-reference/shipping-zones#post-shipping-tenant-site-zones). Set as the default zone if needed.
Save the `id` from the response for the next step.

```bash
curl 'https://api.emporix.io/shipping/{{tenant}}/PL/zones' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "default": true,
    "shipTo": [
        {
            "country": "PL",
            "postalCode": "*"
        }
    ],
    "name": {
        "en": "Inpost Poland",
        "pl": "Inpost Poland"
    },
    "id": "inpost-poland"
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../delivery-and-shipping/shipping/api-reference/" %}
[api-reference](../delivery-and-shipping/shipping/api-reference/)
{% endcontent-ref %}

* Then, configure a shipping method with the [Creating a shipping method](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping-1/api-reference/shipping-methods#post-shipping-tenant-site-zones-zoneid-methods) endpoint.
Save the `id` from the response for the checkout step.

```bash
curl 'https://api.emporix.io/shipping/{{tenant}}/PL/zones/{{zoneId}}/methods' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "active": true,
    "name": {
        "en": "Inpost",
        "pl": "Inpost"
    },
    "id": "inpost",
    "fees": [
        {
            "minOrderValue": {
                "amount": 0,
                "currency": "PLN"
            },
            "cost": {
                "amount": 0,
                "currency": "PLN"
            }
        }
    ],
    "shippingTaxCode": "STANDARD",
    "maxOrderValue": {
        "amount": 999999,
        "currency": "PLN"
    }
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../delivery-and-shipping/shipping/api-reference/" %}
[api-reference](../delivery-and-shipping/shipping/api-reference/)
{% endcontent-ref %}

* Define the delivery times and connect them with the shipping information. Use the [Creating a delivery time](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping-1/api-reference/delivery-times-management#post-shipping-tenant-delivery-times) endpoint. The `validateOverlap` flag enables checks to see whether delivery time ranges for slots of the same shipping method overlap each other.
The `deliveryWindowId` and `slotId` used later in cart creation come from this response.

```bash
curl 'https://api.emporix.io/shipping/{{tenant}}/delivery-times/bulk?validateOverlap=true' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '[
    {
        "name": "inpost-weekday",
        "siteCode": "PL",
        "isDeliveryDay": true,
        "day": {
            "weekday": "SUNDAY"
        },
        "isForAllZones": false,
        "timeZoneId": "Europe/Warsaw",
        "deliveryDayShift": 0,
        "zoneId": "inpost-poland",
        "slots": [
            {
                "shippingMethod": "inpost",
                "deliveryTimeRange": {
                    "timeFrom": "08:00",
                    "timeTo": "16:00"
                },
                "cutOffTime": {
                    "deliveryCycleName": "inpost-weekday",
                    "time": "2025-12-09T05:00:00.000Z",
                    "cutOffDayShift": 0
                },
                "capacity": 100,
                "id": "88d8ea13-2751-40cd-82b1-6478cc8e4139"
            }
        ]
    }
]'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../delivery-and-shipping/shipping/api-reference/" %}
[api-reference](../delivery-and-shipping/shipping/api-reference/)
{% endcontent-ref %}

{% endstep %}
{% endstepper %}

### Import data

Once your tenant and site are ready, it's time to import and organize the project data. Follow the steps to create a basic structure for your products that are to be visible in your store.

{% stepper %}
{% step %}
### Create a category
Define a category or a category hierarchy to make it easier for customers to find the products.
Create a `Tools` category by sending a request to the [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories) endpoint.
Copy the returned `id` for catalog assignment.

```bash
curl https://api.emporix.io/category/{{tenant}}/categories?publish=true \
  --request POST \
  --header 'X-Version: v2' \
  --header 'Content-Type: application/json' \
  --data '{
    "published": true,
    "navigation": false,
    "index": false,
    "metadata": {
        "version": 0
    },
    "id": "heatingboilers",
    "code": "HeatingBoilers",
    "localizedName": {
        "en": "Heating Boilers",
        "pl": "Kotły Grzewcze"
    },
    "localizedSlug": {
        "en": "Heating Boilers",
        "pl": "Kotły Grzewcze"
    },
    "localizedDescription": {
        "en": "Heating Boilers",
        "pl": "NarzędzKotły Grzewczeia"
    },
    "ecn": [
        "heatingboilers"
    ]
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Create a catalog
A catalog determines which categories and category trees are available on your site or sites.
Create a `Home` catalog and publish it on the `PL` site. Use the [Creating a catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/catalog-management#post-catalog-tenant-catalogs) request.
Use the category `id` from the previous step.

```bash
curl https://api.emporix.io/catalog/{{tenant}}/catalogs \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "visibility": {
        "visible": true
    },
    "id": "Home",
    "name": {
        "en": "Home",
        "pl": "Home"
    },
    "description": {
        "en": "Home",
        "pl": "Home"
    },
    "categoryIds": [
        "{{category_id}}"
    ],
    "publishedSites": [
        "PL"
    ]
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../catalogs-and-categories/catalog/api-reference/" %}
[api-reference](../catalogs-and-categories/catalog/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Create a product
Add a product to the database with the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.
Copy the product `id` and `yrn` from the response for the price and cart steps.

```bash 
curl 'https://api.emporix.io/product/{{tenant}}/products' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "productType": "BASIC",
    "mixins": {},
    "metadata": {
        "mixins": {}
    },
    "published": true,
    "id": "heat123",
    "code": "heat123",
    "name": {
        "en": "ThermoBrand Heater X200",
        "pl": "ThermoBrand Heater X200"
    },
    "description": {
        "en": "ThermoBrand Heater X200 sample description",
        "pl": "ThermoBrand Heater X200 opis"
    },
    "template": {},
    "taxClasses": {
        "PL": "STANDARD"
    }
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../products-labels-and-brands/product-service/api-reference/" %}
[api-reference](../products-labels-and-brands/product-service/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Configure a price
Prices are associated with a particular site, so you can set different price configurations for the same product for each site it is visible at. Setting a price allows you to define a tier structure (BASIC, QUANTITY, etc.).

* Create a price model using the [Creating a new price model](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/price-models#post-price-tenant-pricemodels) endpoint.
Save the returned price model `id`.

```bash
curl 'https://api.emporix.io/price/{{tenant}}/priceModels' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "includesTax": true,
    "includesMarkup": true,
    "name": "Piece price model",
    "description": "Basic price model for prices calculated by piece units.",
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
      "quantity": 1,
      "unitCode": "pc"
    }
  }'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}

* Create a price for the product on the `PL` site and connect it with the price model by sending a request to the [Creating a new price](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/prices#post-price-tenant-prices) endpoint.
Save the returned price `id`.

```bash
curl 'https://api.emporix.io/price/{{tenant}}/prices' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "itemId": {
        "id": "{{product_id}}",
        "itemType": "PRODUCT"
    },
    "currency": "PLN",
    "location": {
        "countryCode": "PL"
    },
    "restrictions": {
        "siteCodes": [
            "PL"
        ]
    },
    "tierValues": [
        {
            "id": "{{priceModelId}}",
            "priceValue": "3500.00"
        }
    ]
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Assign a category
Add the product to a category tree for its better searchability. Call the [Assigning a resource to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#post-category-tenant-categories-categoryid-assignments).

```bash
curl 'https://api.emporix.io/category/{{tenant}}/categories/{{categoryId}}/assignments' \
  --request POST \
  --header 'X-Version: v2' \
  --header 'Content-Type: application/json' \
  --data '{
    "ref": {
        "id": "{{product_id}}",
        "type": "PRODUCT"
    }
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Define availability
Availability determines stock level of a product for a given site. Define the availability by calling the [Creating a new availability for a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site).

```bash
curl https://api.emporix.io/availability/{{tenant}}/availability/{{productId}}/PL \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "stockLevel": 50,
    "available": true
  }'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../orders/availability/api-reference/" %}
[api-reference](../orders/availability/api-reference/)
{% endcontent-ref %}

{% endstep %}
{% endstepper %}

### Set up a customer

The tenant and products are ready, so it's time to add customers who can test out the checkout functionality.

{% stepper %}
{% step %}
### Create a customer
Create a B2B customer with the [Creating a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers) request, providing basic customer's details.
Set `active` to `true` if you plan to log in with this account.

```bash
curl 'https://api.emporix.io/customer/{{tenant}}/customers' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "customerNumber": "C0001",
    "firstName": "Julia",
    "lastName": "Nowak",
    "businessModel": "B2B",
    "b2b": {
        "legalEntities": [
            {
                "id": "thermo",
                "name": "ThermoBrand",
                "contactAssignmentId": null
            }
        ],
        "companyRegistrationId": 123456789
    },
    "active": true,
    "contactEmail": "j.nowak@thermo.com",
    "contactPhone": "03212323415",
    "onHold": false,
    "preferredCurrency": "PLN",
    "preferredLanguage": "",
    "preferredSite": "PL",
    "title": "MRS",
    "metadata": {
        "mixins": {},
        "version": 1
    },
    "addresses": [],
    "id": "C0001",
    "password": "P@ssword123"
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../companies-and-customers/customer-service/api-reference/" %}
[api-reference](../companies-and-customers/customer-service/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Specify a customer's address
Add and assign an address to the customer's profile. You can define separate addresses for shipping and billing purposes, marking them with relevant tags. Use the [Adding a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses) endpoint.

```bash
curl 'https://api.emporix.io/customer/{{tenant}}/customers/{{customerNumber}}/addresses' \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{
    "contactName": "Julia Nowak",
    "companyName": "ThermoBrand",
    "street": "Kaczyniec",
    "streetNumber": "9",
    "streetAppendix": "",
    "zipCode": "42-500",
    "city": "Gliwice",
    "country": "PL",
    "isDefault": true,
    "contactPhone": "03214323412",
    "tags": [
        "shipping",
        "billing"
    ],
    "state": "",
    "mixins": {},
    "metadata": {
        "mixins": {}
    },
    "id": "A0001"
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../companies-and-customers/customer-service/api-reference/" %}
[api-reference](../companies-and-customers/customer-service/api-reference/)
{% endcontent-ref %}
{% endstep %}
{% endstepper %}

## Storefront checkout flow

The tenant setup is prepared to handle checkout functionality. Now, ensure that your storefront setup (or the Emporix B2B Commerce Frontend) is able to process the data and pass it to the relevant API endpoints. The example checkout flow on the storefront side includes the following steps.

{% stepper %}
{% step %}
### Start an anonymous session
An anonymous session begins when a user enters your storefront, before they choose to log in. 
Get an anonymous access token with the [Requesting an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-login) endpoint. Pass the `Storefront Client ID`.

```bash
curl -i -X GET \
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={{tenant}}&client_id={{storefront_client_id}}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../companies-and-customers/customer-management/api-reference/" %}
[api-reference](../companies-and-customers/customer-management/api-reference/)
{% endcontent-ref %}

This request creates a new session-context document. The anonymous token is valid for one hour. After that time, refresh it to keep the same session ID associated.

{% endstep %}

{% step %}
### Enable customer login
To allow your customers to authorize themselves, enable the [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) endpoint on the storefront. Authorize the request with the `anonymous_token`.

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/customer/{{tenant}}/login' \
  --header 'Authorization: Bearer {{ANONYMOUS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "email": "j.nowak@thermo.com",
    "password": "P@ssword123"
  }'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../companies-and-customers/customer-management/api-reference/" %}
[api-reference](../companies-and-customers/customer-management/api-reference/)
{% endcontent-ref %}

{% hint style="warning" %}
It is also possible for customers to continue to checkout as guest customers, without logging in, so this step can be optional.
{% endhint %}

This operation returns `Customer access token` and `Customer SaaS token`, which convey information about the customer and their activities on the storefront. Use these values for `Authorization` and `saas-token` headers in the next steps.

{% endstep %}

{% step %}
### Create a cart
Creating a cart operation gathers the customer's session details, including for anonymous customers. Enable cart creation on the storefront using the [Creating a new cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts) endpoint. The request needs to be authorized with the `Customer Access Token` or `Anonymous Access Token`, depending on whether a customer is already logged in.
Use the `deliveryWindow` values from the delivery times response.

```bash
curl -i -X POST 
  'https://api.emporix.io/cart/{{tenant}}/carts' 
  -H 'Authorization: Bearer <CUSTOMER_TOKEN>' 
  -H 'Content-Type: application/json' 
  -H 'saas-token: string' 
  -H 'session-id: string' 
  -d '{
    "customerId": "C0001",
    "siteCode": "PL",
    "type": "shopping",
    "deliveryWindow": {
      "id": "inpost-weekday",
      "deliveryDate": "2026-01-27T12:00:00.000Z",
      "slotId": "Slot-1"
    },
    "channel": {
      "name": "storefront",
      "source": "https://develop-storefront.emporix.io/thermodev/"
    },
    "currency": "PLN"
  }'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../checkout/cart/api-reference/" %}
[api-reference](../checkout/cart/api-reference/)
{% endcontent-ref %}

{% endstep %}

{% step %}
### Add items to the cart
To allow customers to place some items in the cart, use the [Adding a product to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) endpoint.
Use the product `yrn` and price `id` created earlier.

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{{tenant}}/carts/{{cartId}}/items?siteCode=PL' \
  -H 'Authorization: Bearer <CUSTOMER_TOKEN>' \
  -H 'Content-Type: application/json' \
  -d '{
    "itemYrn": "{{productYrn}}",
    "price": {
      "priceId": "{{priceId}}",
      "effectiveAmount": 3500.00,
      "originalAmount": 3500.00,
      "currency": "PLN"
    },
    "quantity": 10
  }'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../checkout/cart/api-reference/" %}
[api-reference](../checkout/cart/api-reference/)
{% endcontent-ref %}
{% endstep %}

{% step %}
### Enable the price matching mechanism
Price matching allows your customers to find the best price calculated on the fly during their session, including discounts, offers, segments or similar information. To that end, use the [Matching prices for session context](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/price-service/api-reference/price-matching#post-price-tenant-match-prices-by-context) endpoint in our storefront setup. The request is authorized with the `CustomerAccessToken`, so make sure you pass that data from the customer entering your store.
Call this before checkout when you need to recalculate prices based on session context.

```bash
curl 'https://api.emporix.io/price/{{tenant}}/match-prices-by-context' \
  --request POST \
  --data '{
  "items": [
    {
      "itemId": {
        "itemType": "PRODUCT",
        "id": "heat123"
      },
      "quantity": {
        "quantity": 10,
        "unitCode": "pc"
      }
    }
  ]
}'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}
{% endstep %}

{% step %}
### Proceed to checkout
Once the customer wants to finalize the purchase, enable the checkout option. The checkout does several validation checks on the provided data, including cart details, product availability, customer details, payment method, price calculations, shipping information and delivery. The operation creates an order, handles the payment, and closes the cart. 
To enable checkout operation on your storefront, use the [Triggering a checkout](https://developer.emporix.io/api-references/api-guides/checkout/checkout/api-reference/checkouts) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/checkout/{{tenant}}/checkouts/order?siteCode=PL' \
  -H 'Authorization: Bearer <CUSTOMER_TOKEN>' \
  -H 'Content-Type: application/json' \
  -H 'saas-token: string' \
  -d '{
    "cartId": "{{cartId}}",
    "paymentMethods": [
      {
        "provider": "INVOICE",
        "method": "invoice"
      }
    ],
    "currency": "PLN",
    "shipping": {
      "methodId": "{{shipping_method_id}}",
      "zoneId": "{{shipping_zone_id}}",
      "methodName": "Inpost",
      "amount": 0,
      "shippingTaxCode": "STANDARD"
    },
    "deliveryWindowId": "inpost-weekday",
    "addresses": [
      {
        "contactName": "Julia Nowak",
        "companyName": "ThermoBrand",
        "street": "Kaczyniec",
        "streetNumber": "9",
        "streetAppendix": "",
        "zipCode": "42-500",
        "city": "Gliwice",
        "country": "PL",
        "isDefault": true,
        "contactPhone": "03214323412",
        "type": "BILLING",
        "state": "",
        "mixins": {},
        "metadata": {
            "mixins": {}
        },
        "id": "A0001"
      },
      {
        "contactName": "Julia Nowak",
        "companyName": "ThermoBrand",
        "street": "Kaczyniec",
        "streetNumber": "9",
        "streetAppendix": "",
        "zipCode": "42-500",
        "city": "Gliwice",
        "country": "PL",
        "isDefault": true,
        "contactPhone": "03214323412",
        "type": "SHIPPING",
        "state": "",
        "mixins": {},
        "metadata": {
            "mixins": {}
        },
        "id": "A0001"
      }
    ],
    "customer": {
      "id": "{{customerId}}",
      "title": "MRS",
      "firstName": "Julia",
      "middleName": "",
      "lastName": "Nowak",
      "contactPhone": "56432245",
      "email": "j.nowak@thermo.com",
      "company": "ThermoBrand",
      "metadata": {
        "mixins": {}
      },
      "mixins": {}
    }
  }'
```

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../checkout/checkout/api-reference/" %}
[api-reference](../checkout/checkout/api-reference/)
{% endcontent-ref %}
{% endstep %}

{% step %}
### Verify order creation
As a last step, verify if the order placed by a customer is created accordingly. 
To display the order details to the customer on the storefront, use the [Retrieving order details](https://developer.emporix.io/api-references/api-guides/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders-orderid) endpoint. Authorize the request with the `customer access token`.

```bash
curl -L \
  --url 'https://api.emporix.io/order-v2/{{tenant}}/orders/{{orderId}}' \
  --header 'Authorization: Bearer <CUSTOMER_ACCESS_TOKEN>' \
  --header 'saas-token: text' \
  --header 'Accept: */*'
```
To obtain the order details and later send tem to the ERP/CRM system, use the [Retrieving sales order details](). Authorize the request with the `OAuth access token`.

```bash
curl -L \
  --url 'https://api.emporix.io/order-v2/{{tenant}}/salesorders/{{orderId}}' \
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' \
  --header 'Accept: */*'
```

As a result, you retrieve all the details related to the placed order, which you can display in the UI.

<details>
<summary>Example response</summary>

```json
{
    "id": "EON1001",
    "status": "CREATED",
    "created": "2026-01-28T08:24:27.161Z",
    "lastStatusChange": "2026-01-28T08:24:27.161Z",
    "cartId": "6979c71f1f08eb1365990995",
    "entries": [
        {
            "id": "heat123",
            "itemYrn": "urn:yaas:saasag:caasproduct:product:thermodev;heat123",
            "keepAsSeparateLineItem": false,
            "type": "INTERNAL",
            "amount": 10,
            "orderedAmount": 10,
            "effectiveQuantity": 10.0,
            "originalAmount": 3500,
            "originalPrice": 3500,
            "unitPrice": 3500,
            "calculatedUnitPrice": {
                "netValue": 3500.0,
                "grossValue": 4305.0,
                "taxValue": 805.0,
                "taxCode": "STANDARD",
                "taxRate": 23.0
            },
            "totalPrice": 35000.0,
            "product": {
                "id": "heat123",
                "sku": "heat123",
                "name": "ThermoBrand Heater X200",
                "localizedName": {
                    "en": "ThermoBrand Heater X200",
                    "pl": "ThermoBrand Heater X200"
                },
                "description": "[en:ThermoBrand Heater X200 sample description, pl:ThermoBrand Heater X200 opis]",
                "published": true,
                "images": [],
                "productType": "BASIC"
            },
            "tax": {
                "lines": [
                    {
                        "amount": 8050.0,
                        "currency": "PLN",
                        "code": "STANDARD",
                        "name": "STANDARD",
                        "rate": 23.0,
                        "sequenceId": 0,
                        "inclusive": false
                    }
                ],
                "total": {
                    "amount": 0,
                    "currency": "PLN",
                    "inclusive": false
                }
            },
            "price": {
                "priceId": "69735d30318b654a97e882fe",
                "currency": "PLN",
                "originalAmount": 3500.0,
                "effectiveAmount": 3500.0,
                "basePrice": {},
                "presentationPrice": {},
                "metadata": {
                    "createdAt": "2026-01-23T11:36:16.644Z",
                    "modifiedAt": "2026-01-23T11:36:16.644Z",
                    "version": 1
                }
            },
            "totalDiscount": {
                "amount": 0,
                "currency": "PLN"
            },
            "fees": {
                "total": {
                    "subTotal": 0,
                    "totalTax": 0,
                    "total": 0
                }
            },
            "metadata": {
                "mixins": {
                    "fees": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/fees_checkout-mashup.json"
                }
            },
            "mixins": {
                "fees": {
                    "total": {
                        "subTotal": 0,
                        "totalTax": 0,
                        "total": 0,
                        "discount": 0
                    }
                }
            },
            "calculatedPrice": {
                "price": {
                    "netValue": 35000.0,
                    "grossValue": 43050.0,
                    "taxValue": 8050.0,
                    "taxCode": "STANDARD",
                    "taxRate": 23.0
                },
                "finalPrice": {
                    "netValue": 35000.0,
                    "grossValue": 43050.0,
                    "taxValue": 8050.0,
                    "taxCode": "STANDARD",
                    "taxRate": 23.0
                }
            },
            "priceMatchDetails": {
                "netValue": 3500.0,
                "grossValue": 4305.0,
                "taxValue": 805.0,
                "taxCode": "STANDARD",
                "taxRate": 23,
                "taxCountry": "PL"
            }
        }
    ],
    "discounts": [],
    "customer": {
        "id": "C0001",
        "name": "Julia Nowak",
        "title": "Mrs",
        "firstName": "Julia",
        "lastName": "Nowak",
        "company": "ThermoBrand",
        "email": "j.nowak@thermo.com"
    },
    "siteCode": "PL",
    "countryCode": "PL",
    "billingAddress": {
        "contactName": "Julia Nowak",
        "companyName": "ThermoBrand",
        "street": "Kaczyniec",
        "streetNumber": "9",
        "streetAppendix": "",
        "zipCode": "42-500",
        "city": "Gliwice",
        "country": "PL",
        "state": "",
        "contactPhone": "03214323412"
    },
    "shippingAddress": {
        "contactName": "Julia Nowak",
        "companyName": "ThermoBrand",
        "street": "Kaczyniec",
        "streetNumber": "9",
        "streetAppendix": "",
        "zipCode": "42-500",
        "city": "Gliwice",
        "country": "PL",
        "state": "",
        "contactPhone": "03214323412"
    },
    "payments": [
        {
            "status": "PENDING",
            "method": "invoice",
            "paidAmount": 0,
            "currency": "PLN",
            "provider": "INVOICE"
        }
    ],
    "shipping": {
        "total": {
            "amount": 0,
            "currency": "PLN"
        },
        "lines": [
            {
                "amount": 0,
                "currency": "PLN",
                "code": "inpost",
                "name": "Inpost",
                "localizedName": {
                    "en": "Inpost",
                    "pl": "Inpost"
                },
                "tax": {
                    "total": {
                        "amount": 0.0,
                        "currency": "PLN",
                        "inclusive": false
                    },
                    "rate": 23.0
                },
                "shippingTaxCode": "STANDARD"
            }
        ]
    },
    "tax": {
        "lines": [
            {
                "amount": 8050.0,
                "currency": "PLN",
                "code": "STANDARD",
                "name": "STANDARD",
                "rate": 23.0,
                "sequenceId": 0,
                "inclusive": false
            }
        ],
        "total": {
            "amount": 0,
            "currency": "PLN",
            "inclusive": false
        }
    },
    "subTotalPrice": 35000.0,
    "totalPrice": 35000.0,
    "totalAuthorizedAmount": 43050.0,
    "currency": "PLN",
    "metadata": {
        "mixins": {
            "payments": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/fees_checkout-mashup.json",
            "generalAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/orderGeneralAttributesMixIn.v9.json"
        },
        "version": 1
    },
    "mixins": {
        "payments": {
            "elements": [
                {
                    "paymentMethodYrn": "urn:yaas:hybris:payments:payment-method:thermodev;invoice",
                    "total": {
                        "subTotal": 0.0,
                        "totalTax": 0.0,
                        "total": 0.0,
                        "discount": 0.0
                    }
                }
            ],
            "total": {
                "subTotal": 0.0,
                "totalTax": 0.0,
                "total": 0.0,
                "discount": 0.0
            }
        },
        "generalAttributes": {
            "extendedOrderStatus": "10",
            "customerFirstOrder": false,
            "orderNumber": "EON1001"
        }
    },
    "feeYrnAggregate": {
        "total": {
            "subTotal": 0.0,
            "totalTax": 0.0,
            "total": 0.0
        }
    },
    "calculatedPrice": {
        "price": {
            "netValue": 35000.0,
            "grossValue": 43050.0,
            "taxValue": 8050.0,
            "taxCode": "STANDARD",
            "taxRate": 23.0
        },
        "shipping": {
            "netValue": 0.0,
            "grossValue": 0.0,
            "taxValue": 0.0,
            "taxCode": "STANDARD",
            "taxRate": 23.0
        },
        "totalShipping": {
            "netValue": 0.0,
            "grossValue": 0.0,
            "taxValue": 0.0,
            "taxCode": "STANDARD",
            "taxRate": 23.0
        },
        "finalPrice": {
            "netValue": 35000.0,
            "grossValue": 43050.0,
            "taxValue": 8050.0,
            "taxCode": "STANDARD",
            "taxRate": 23.0,
            "taxAggregate": {
                "lines": [
                    {
                        "netValue": 35000.0,
                        "grossValue": 43050.0,
                        "taxValue": 8050.0,
                        "taxCode": "STANDARD",
                        "taxRate": 23.0
                    }
                ]
            }
        }
    },
    "restriction": "PL"
}
```
</details>

From there, you can process the order.

{% include "../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../orders/order/api-reference/" %}
[api-reference](../orders/order/api-reference/)
{% endcontent-ref %}
{% endstep %}
{% endstepper %}

## Troubleshooting
| Problem | Recommendation |
| --- | --- |
| Missing home base address | Set `homeBase.country` on the site to match the site country so shipping calculations succeed. |
| Currency mismatch between tenant and site | Ensure the site currency is active and matches the currency used in prices and carts. |
| Tax configuration missing for target country | Create a tax configuration for the target country and use matching tax class codes on products and shipping. |
| Shipping zone not matching customer address | Add the customer’s country/postal range to the shipping zone or set the correct default zone. |
| Products without prices | Create a price model and price for each product and site before checkout. |
| Sites not linked to catalogs | Publish the catalog to the site and include the relevant category ids. |


{% hint style="info" %}
For more information, see the following documentation and API references:

- [Emporix Terraform Provider](./emporix-terraform-provider.md) 
- [Availability Service API Reference](../orders/availability/api-reference/)
- [Cart Service API Reference](../checkout/cart/api-reference/)
- [Catalog Service API Reference](../catalogs-and-categories/catalog/api-reference/)
- [Category Service API Reference](../catalogs-and-categories/category-tree/api-reference/)
- [Checkout Service API Reference](../checkout/checkout/api-reference/) 
- [Configuration Service API Reference](../configuration/configuration-service/api-reference/)
- [Price Service API Reference](../prices-and-taxes/price-service/api-reference/)
- [Product Service API Reference](../products-labels-and-brands/product-service/api-reference/)
- [Shipping API Reference](../delivery-and-shipping/shipping/api-reference/)
- [Site Settings API Reference](../configuration/site-settings-service/api-reference/)
- [Tax Service API Reference](../prices-and-taxes/tax-service/api-reference/)

{% endhint %}
