---
description: Start configuring a fresh tenant to enable your online store quickly and efficiently.
icon: 
layout:
  width: wide
---

# Tenant Configuration Tutorial

This tutorial guides developers through configuration steps of a fresh Emporix tenant with the aim to enable checkout functionality in the storefront. Start with a brand new tenant to set up and enable all the required features from scratch.

The steps take you through the following paths:

* **Tenant setup** - Basic tenant and site settings
* **Data import** - Catalog, products, and pricing setup
* **Customer setup** - Test customer and address configuration

## Prerequisites

To get started, make sure you have:

* **Emporix Account** - an active Emporix tenant created
* **API keys** - credentials to make relevant API calls

{% stepper %}
{% step %}
### Get authorisation token
To obtain proper access, send the quthorization request to the [Requesting a service access token](https://developer.emporix.io/api-references/api-guides/authorization/oauth-service/api-reference/service-access-token) endpoint.

```bash
curl --location 'https://api.emporix.io/oauth/token' 
--header 'Content-Type: application/x-www-form-urlencoded' 
--data-urlencode 'grant_type=client_credentials' 
--data-urlencode 'client_id={{client_id}}' 
--data-urlencode 'client_secret={{client_secret}}'
```
{% endstep %}
{% endstepper %}

## How to configure a fresh tenant

Follow these steps to provide basic configuration for your tenant, such as payment, site, language, currency, tax, and shipping zones & method. 

{% hint style="success" %}
There is also a convenient alternative way for initial tenant configuration. You can use the [Emporix Terraform Provider](/quickstart/emporix-terraform-provider.md) to automate the process. 
{% endhint %}

{% stepper %}
{% step %}
### Configure payment method
To create an `invoice` payment method, call the [Creating a single payment mode entity](https://developer.emporix.io/api-references/api-guides/checkout/payment-gateway/api-reference/payment-mode#post-payment-gateway-tenant-paymentmodes-config) endpoint.

```bash
curl 'https://api.emporix.io/payment-gateway/{tenant}/paymentmodes/config' 
  --request POST 
  --header 'Content-Type: application/json' 
  --data '{
  "code": "invoice",
  "active": true,
  "provider": "INVOICE",
  "configuration": {
      
    }
}'
```

{% endstep %}

{% step %}
### Activate a country, currency and language
You need to activate countries where you want to operate, as well as add relevant currency and language.

* Activate a country with the [Updating a country](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#patch-country-tenant-countries-countrycode) request, for example Poland:

```bash
curl 'https://api.emporix.io/country/{tenant}/countries/PL' 
  --request PATCH 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
  "active": true,
  "metadata": {
    "version": 1
  }
}'
```

* You need to activate currencies relevant for the countries where your business operates or relevant to your business model. Ensure currency codes are ISO 4217 compliant. 
Create a `Polish Zloty` currency with the [Creating a new currency](https://developer.emporix.io/api-references/api-guides/configuration/currency-service/api-reference/currencies#post-currency-tenant-currencies) endpoint:

```bash
curl 'https://api.emporix.io/currency/{tenant}/currencies' 
  --request POST 
  --header 'Content-Type: application/json' 
  --data '{
  "code": "PLN",
  "name": {
    "en": "Polish Zloty"
  }
}'
```

* Specify the languages that your business communicates with suppliers and customers. Emporix supports all existing languages, including regional language variants. The tenant's language configuration is stored under the `project_lang` key, while site-specific language configuration is stored in the `defaultLanguage` and `languages` fields, inside the `Site` object.
To set `Polish` and `English` as project languages, use the [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint:

```bash
curl 'https://api.emporix.io/configuration/{tenant}/configurations/project_lang' 
  --request PUT 
  --header 'Content-Type: application/json' 
  --data '{
    "key": "project_lang",
    "value": "[{\"id\":\"en\",\"label\":\"English\",\"default\":true,\"required\":true},{\"id\":\"pl\",\"label\":\"Polish\",\"default\":false}]"
}'
```

{% endstep %}

{% step %}
### Add relevant tax calculation configuration
Tax rates define proper checkout calculation relevant for a given country.
Create tax classes with rates applicable in Poland using the [Creating a new tax configuration](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/tax-service/api-reference/taxes#post-tax-tenant-taxes) endpoint.

```bash
curl 'https://api.emporix.io/tax/{tenant}/taxes' 
  --request POST 
  --header 'Content-Language: ' 
  --header 'Content-Type: application/json' 
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

{% endstep %}

{% step %}
### Create a site
A site can be determined by a country or a brand you want to sell in your store. 
Create a `PL` site for Polish market by sending a requst to the [Creating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#post-site-tenant-sites) endpoint. Include the `homeBase` address country which is required for shipping calculations.

```bash
curl 'https://api.emporix.io/site/{tenant}/sites' 
  --request POST 
  --header 'Content-Type: application/json' 
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

{% endstep %}

{% step %}
### Configure a shipping zone, method and delivery times
Define where you want to ship your goods and how. 

* First, set the ship-to location for the site using the [Creating a shipping zone](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping-1/api-reference/shipping-zones#post-shipping-tenant-site-zones). Set as the default zone if needed.

```bash
curl 'https://api.emporix.io/shipping/{tenant}/PL/zones' 
  --request POST 
  --header 'Content-Type: application/json' 
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

* Then, configure a shipping method with the [Creating a shipping method](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping-1/api-reference/shipping-methods#post-shipping-tenant-site-zones-zoneid-methods) endpoint.

```bash
curl 'https://api.emporix.io/shipping/{tenant}/PL/zones/{zoneId}/methods' 
  --request POST 
  --header 'Content-Type: application/json' 
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

* Define the delivery times and connect them with the shipping information. Use the [Creating a delivery time](https://developer.emporix.io/api-references/api-guides/delivery-and-shipping/shipping-1/api-reference/delivery-times-management#post-shipping-tenant-delivery-times) endpoint. The `validateOverlap` flag enables checks if the delivery time ranges from slots of the same shipping method overlap each other.

```bash
curl 'https://api.emporix.io/shipping/{tenant}/delivery-times/bulk?validateOverlap=true' 
  --request POST 
  --header 'Content-Type: application/json' 
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

{% endstep %}

## How to import data

Once your tenant and site are ready, it's time to import and organize the project data. Follow the steps to create a structure for your products that are to be visible in your store.

{% stepper %}
{% step %}
### Create a category
Define a category or a category hierarchy to make it easier for customers to find the products.
Create a `Tools` category by sending a request to the [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories) endpoint.

```bash
curl https://api.emporix.io/category/{tenant}/categories?publish=true 
  --request POST 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "published": true,
    "navigation": false,
    "index": false,
    "metadata": {
        "version": 0
    },
    "id": "tools",
    "code": "Tools",
    "localizedName": {
        "en": "Tools",
        "pl": "Narzedzia"
    },
    "localizedSlug": {
        "en": "Tools",
        "pl": "Narzedzia"
    },
    "localizedDescription": {
        "en": "Tools",
        "pl": "Narzedzia"
    },
    "ecn": [
        "tools"
    ]
}'
```

{% endstep %}

{% step %}
### Create a catalog
Catalog determines which categories are available on your site or sites.
Create a `Home` catalog and pubish it on the `PL` site. Use the [Creating a catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/catalog-management#post-catalog-tenant-catalogs) request.

```bash
curl https://api.emporix.io/catalog/{tenant}/catalogs 
  --request POST 
  --header 'Content-Type: application/json' 
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

{% endstep %}

{% step %}
### Create a product
Add a product to the database [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products)

{% endstep %}

{% step %}
### Configure a price

{% endstep %}

{% step %}
### Assign a category

{% endstep %}
{% endstepper %}


### 2.1 Catalog Setup
- **Objective**: Create a catalog to organize products
- **Steps**:
  1. Create a catalog
  2. Configure catalog settings
  3. Link catalog to site

### 2.2 Category Tree Setup
- **Objective**: Organize products into categories
- **Steps**:
  1. Create category tree
  2. Create root category
  3. Create subcategories (if needed)
  4. Link category tree to catalog

### 2.3 Product Import
- **Objective**: Add products to the catalog
- **Steps**:
  1. Create products (single or bulk)
     - Product ID, code, name
     - Product type (BASIC, VARIANT, etc.)
  2. Assign products to categories
  3. Verify products are available in catalog

### 2.4 Price Model Configuration
- **Objective**: Define pricing strategy
- **Steps**:
  1. Create price model
     - Define tier structure (BASIC, QUANTITY, etc.)
     - Set measurement unit
     - Configure includesTax setting
  2. Understand price model structure

### 2.5 Price Configuration
- **Objective**: Set prices for products
- **Steps**:
  1. Create prices for products
     - Link to price model
     - Set currency and location (country)
     - Configure tier values
     - Set site restrictions
  2. Verify price matching works

---

## Part 3: Customer Setup

### 3.1 Customer Creation
- **Objective**: Create a test customer for checkout
- **Steps**:
  1. Create a customer account
     - Basic information (name, email, etc.)
     - Set password
  2. Verify customer creation

### 3.2 Customer Address Configuration
- **Objective**: Add shipping and billing addresses
- **Steps**:
  1. Add shipping address
     - Full address details
     - Country, postal code, city
  2. Add billing address
     - Can be same as shipping or different
  3. Set default addresses

### 3.3 Customer Authentication Setup
- **Objective**: Prepare for customer login in storefront
- **Steps**:
  1. Understand anonymous session flow
  2. Understand customer login flow
  3. Note: Customer login is optional for guest checkout

---

## Verification and Testing

### Final Verification Steps
- **Objective**: Ensure all configuration is correct
- **Checklist**:
  - [ ] Site is created and active
  - [ ] Currency and country are configured
  - [ ] Tax configuration exists for target country
  - [ ] Shipping zone and method are configured
  - [ ] Payment methods are enabled
  - [ ] At least one product exists with price
  - [ ] Test customer exists with address
  - [ ] Catalog and categories are set up

### Testing Checkout Flow
- **Objective**: Verify checkout works end-to-end
- **Steps**:
  1. Create anonymous session
  2. Create cart
  3. Add product to cart
  4. Verify cart calculations (price, tax, shipping)
  5. Proceed to checkout (as guest or logged-in customer)
  6. Verify order creation

---

## Additional Considerations

### Optional but Recommended
- Delivery times configuration (for scheduled deliveries)
- Multiple shipping methods (for different delivery options)
- Multiple payment methods (for customer choice)
- Product images and media
- Brand and label setup

### Terraform Alternative
- **Note**: Configuration steps can be automated using the Emporix Terraform Provider
- Reference to Terraform documentation for infrastructure-as-code approach

### Common Pitfalls
- Missing home base address (breaks shipping calculations)
- Currency mismatch between tenant and site
- Tax configuration missing for target country
- Shipping zone not matching customer address
- Products without prices
- Site not linked to catalog

---

## Tutorial Format

Each section will follow this structure:
- **Introduction**: Brief explanation of what this section covers and why it's needed
- **Prerequisites**: What needs to be done before this step
- **Step-by-step instructions**: Using GitBook stepper components
- **Code examples**: curl commands with placeholders
- **Verification**: How to verify the step was successful
- **Troubleshooting**: Common issues and solutions
- **Links**: References to detailed API documentation

---

## Estimated Completion Time

- Part 1 (Configuration): 30-45 minutes
- Part 2 (Data Import): 20-30 minutes
- Part 3 (Customer Setup): 10-15 minutes
- **Total**: ~60-90 minutes for complete setup

---

## Next Steps After Tutorial

After completing this tutorial, users should be able to:
1. Understand the minimum configuration needed for checkout
2. Successfully complete a checkout in Emporix Showcase
3. Extend configuration for their specific business needs
4. Reference detailed API documentation for advanced scenarios

---

## Related Documentation

- [Checkout Tutorial](../checkout/checkout/checkout.md) - Detailed checkout flow
- [Emporix Terraform Provider](./emporix-terraform-provider.md) - Infrastructure as Code approach
- [Site Settings API Reference](../configuration/site-settings-service/api-reference/)
- [Tax Service API Reference](../prices-and-taxes/tax-service/api-reference/)
- [Shipping API Reference](../delivery-and-shipping/shipping/api-reference/)
