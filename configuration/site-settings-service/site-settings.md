---
seo:
  title: Site Settings Service Tutorials
  description: site settings, site, sites
---



# Site Settings Service Tutorials

## How to create a new site

To create a new site, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/POST-site-settings-create-site" size="small">Creating a site</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="POST-site-settings-create-site"
  properties={{
    "code":"example",
    "name": "Example Site",
    "active": true,
    "default": false,
    "defaultLanguage": "en",
    "languages": [
        "en",
        "de"
    ],
    "currency": "EUR",
    "homeBase": {
        "address": {
            "zipCode" : "10115",
            "country": "DE"
        }
    },
    "shipToCountries": [
        "DE"
    ],
    "schema": "https://api.emporix.io/hybris/schema/v1/saasstructure/site-1.12.14"
  }}
/>

## How to set a list of countries to which a site ships products

Countries that a site ships products to are stored as [ISO 3166-1 alpha-2 codes](https://www.iso.org/obp/ui/#iso:pub:PUB500001:en) in the `shipToCountries` list.


To update the `shipToCountries` list, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site" size="small">Partially updating a site</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site"
  properties={{
    "shipToCountries": [ "AT", "CH", "DE" ]
  }}
/>

## How to enable payment methods

Payment methods are configured per site. Emporix Commerce Engine supports the following payment methods: 
* Cash
* Credit card
* Direct debit
* Invoice

Information on whether specific payment methods are enabled or disabled is stored in the form of boolean flags in the `orderProcessSettings` mixin. To enable a payment method, you need to set its flag to `true`.

First, check if the `orderProcessSettings` mixin has already been configured by sending a request to the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-retrieve-site-mixin" size="small">Retrieving a site mixin</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="GET-site-settings-retrieve-site-mixin"
  parameters={{
    path: {
        "mixinName": "orderProcessSettings"
    }
  }}
/>

If your site's `orderProcessSettings` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to enable specific payment methods, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/POST-site-settings-create-site-mixin" size="small">Creating a site mixin</Button></nobr> endpoint and set desired flags to `true`.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="POST-site-settings-create-site-mixin"
  properties={{
    "orderProcessSettings": {
        "paymentSettings": {
            "paymentByInvoice": true,
            "paymentByDebit": true,
            "paymentByCash": true,
            "paymentByCredit": false
        },
        "metadata": {
        }
    }
  }}
/>

If your site's `orderProcessSettings` have already been configured, you will receive them in the response body. 

In this case, to enable specific payment methods, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site-mixin" size="small">Partially updating a site mixin</Button></nobr> endpoint and set desired flags to `true`.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site-mixin"
  parameters={{
    path: {
        "mixinName": "orderProcessSettings"
    }
  }}
  properties={{
    "paymentSettings": {
        "paymentByInvoice": true,
        "paymentByDebit": true,
        "paymentByCash": true,
        "paymentByCredit": false
    }
  }}
/>

## How to set up direct debit payments

### Before you start

Make sure you have already finished the [How to enable payment methods](#how-to-enable-payment-methods) tutorial.

### Configure your business bank account information

Your business bank account information is stored in the `merchantInfo` mixin.

First, check if the `merchantInfo` mixin has already been configured by sending a request to the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-retrieve-site-mixin" size="small">Retrieving a site mixin</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="GET-site-settings-retrieve-site-mixin"
  parameters={{
    path: {
        "mixinName": "merchantInfo"
    }
  }}
/>

If your site's `merchantInfo` has never been configured before or has been deleted, you will receive a `404` error in the response body. In this case, to set up your business's bank account information, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/POST-site-settings-create-site-mixin" size="small">Creating a site mixin</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="POST-site-settings-create-site-mixin"
  properties={{
    "merchantInfo": {
        "merchantName": " ",
        "merchantId": " ",
        "merchantFinanceInfo": {
            "merchantSalesTaxId": " ",
            "merchantIban": " ",
            "merchantBic": " ",
            "sepaCreditorId": " "
        },
        "metadata": {
            "schema": "https://res.cloudinary.com/saas-ag/raw/upload/hybris_schema/merchantAddressMixin.v10"
        }
    }
  }}
/>

If your site's `merchantInfo` has already been configured, you will receive it in the response body. 

{% hint style="warning" %}
    
Check if all of the following fields are filled out with correct information:

* `merchantName`
* `merchantId`
* `merchantFinanceInfo`

{% endhint %}

If you need to update your `merchantInfo`, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site-mixin" size="small">Partially updating a site mixin</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site-mixin"
  parameters={{
    path: {
        "mixinName": "merchantInfo"
    }
  }}
  properties={{
    "merchantName": " ",
    "merchantId": " ",
    "merchantFinanceInfo": {
        "merchantSalesTaxId": " ",
        "merchantIban": " ",
        "merchantBic": " ",
        "sepaCreditorId": " "
  }
  }}
/>

### Configure settings for direct debit payments

Settings for direct debit payments are stored in the `debitSettings` mixin. To configure them, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/POST-site-settings-create-site-mixin" size="small">Creating a site mixin</Button></nobr> endpoint with a set of standard values in the request body.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="POST-site-settings-create-site-mixin"
  properties={{
    "debitSettings": {
        "orderInformation": {
            "paymentMethod": "paymentByDebit",
            "status": "80",
            "postExportOrderStatus": "90"
        },
        "transactionType": {
            "serviceLevel": "SEPA",
            "sequenceType": "FRST",
            "debitArt": "COR1"
        },
        "debitInformation": {
            "paymentMethod": "DD",
            "batchBooking": true,
            "chargeBearer": "SLEV",
            "usage": "{merchantName}",
            "pmtInfId": "PMT-IDO-"
        },
        "metadata": {
            "schema": "https://res.cloudinary.com/saas-ag/raw/upload/hybris_schema/debitSettingsSiteMixIn.v3"
        }
    }
  }}
/>


### Specify your business's SEPA Creditor ID

Your business's SEPA Creditor ID is stored in your tenant's `sepaCreditor` configuration. To set up a `sepaCreditor` configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/POST-configuration-create-config" size="small">Creating configurations</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="POST-configuration-create-config"
  properties={{
        "key": "sepaCreditor",
        "value": " ",
        "secured": false
  }}
/>

## How to add custom attributes to a site

Custom site attributes are stored in a site's `mixins`.

{% hint style="warning" %}

To learn more about mixins in the Emporix Commerce Engine, check out the [Standard Practices in the Emporix API](/content/standard-practices.mdx).

{% endhint %}

### Define a JSON schema

To be able to apply mixins to your site's settings, you first need to define your custom attributes in the form of a JSON schema.

```json
{
  "name": "customerSettings",
  "description": "Mixin schema for site-specific customer settings.",
  "properties": {
    "regExSettings": {
      "type": "object",
      "description": "Regular expressions for input validation.",
      "properties": {
        "bic": {
          "type": "string"
        },
        "mail": {
          "type": "string"
        },
        "accountOwner": {
          "type": "string"
        },
        "phone": {
          "type": "string"
        },
        "password": {
          "type": "string"
        }
      }
    }
  },
  "type": "object",
  "$schema": "http://json-schema.org/draft-04/schema#"
}
```

Next, upload your schema to a hosting service and save its URL.

### Apply custom attributes to a site

Once your schema is ready, send a request to the <nobr><Button to="/openapi/site-settings/#operation/POST-site-settings-create-site-mixin" size="small">Creating a site mixin</Button></nobr> endpoint with the site's custom attributes in the request body.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="POST-site-settings-create-site-mixin"
  properties={{
    "customerSettings": {
        "regExSettings": {
            "mail": "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$",
            "phone": "^[0-9\\+][0-9]{7,}$",
            "password": ".{6,}",
            "bic": "^((.{8})|(.{11}))$",
            "accountOwner": "^[a-zA-Z0-9'\'':?,()\\-. +/ÄäÜüÖöß&]{0,70}$"
        },
        "metadata": {
            "schema": "{schemaURL}"
        }
    }
  }}
/>
