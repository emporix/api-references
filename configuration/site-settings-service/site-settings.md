---
seo:
  title: Site Settings Service Tutorials
  description: site settings, site, sites
icon: graduation-cap
layout:
  width: wide
---

# Site Settings Tutorial

## How to create a new site

To create a new site, you need to send a request to the [Creating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#post-site-tenant-sites) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/site/{tenant}/sites' \
  --header 'Content-Type: application/json' \
  --data '{
    "code": "example",
    "name": "ExampleName",
    "active": false,
    "default": false,
    "defaultLanguage": "en",
    "languages": [
      "en"
    ],
    "currency": "GBP",
    "homeBase": {
      "address": {
        "country": "GB",
        "zipCode": "12345"
      }
    },
    "shipToCountries": [
      "GB"
    ],
    "mixins": {},
    "metadata": {}
  }'
```

## How to set a list of countries to which a site ships products

Countries that a site ships products to are stored as [ISO 3166-1 alpha-2 codes](https://www.iso.org/obp/ui/#iso:pub:PUB500001:en) in the `shipToCountries` list.

To update the `shipToCountries` list, you need to send a request to the [Partially updating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#patch-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}' \
  --header 'Content-Type: application/json' \
  --data '{
    "defaultLanguage": "en"
    "shipToCountries": [
      "AT",
      "CH",
      "DE"
    ]
  }'
```

## How to enable payment methods

Payment methods are configured per site. Emporix Commerce Engine supports the following payment methods:

* Cash
* Credit card
* Direct debit
* Invoice

Information on whether specific payment methods are enabled or disabled is stored in the form of boolean flags in the `orderProcessSettings` mixin. To enable a payment method, you need to set its flag to `true`.

First, check if the `orderProcessSettings` mixin has already been configured by sending a request to the [Retrieving a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins-mixinname) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' \
  --header 'Accept: */*'
```

If your site's `orderProcessSettings` have never been configured before or have been deleted, you will receive a `404` error in the response body.

In this case, to enable specific payment methods, you need to send a request to the [Creating a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#post-site-tenant-sites-sitecode-mixins) endpoint and set desired flags to `true`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' \
  --header 'Content-Type: application/json' \
  --data '{
    "testMixin": {
    "active": true,
    "metadata": {
      "schema": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/testMixin.json"
    }
  },
  "orderProcessSettings": {
    "paymentSettings": {
      "paymentByInvoice": true,
      "paymentByDebit": true,
      "paymentByCash": true,
      "paymentByCredit": false
    },
    "metadata": {}
    }
  }'
```

If your site's `orderProcessSettings` have already been configured, you will receive them in the response body.

In this case, to enable specific payment methods, you need to send a request to the [Partially updating a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#patch-site-tenant-sites-sitecode-mixins-mixinname) endpoint and set desired flags to `true`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' \
  --header 'Content-Type: application/json' \
  --data '{
    "active": true,
  "paymentSettings": {
    "paymentByInvoice": true,
    "paymentByDebit": true,
    "paymentByCash": true,
    "paymentByCredit": false
  }
}
```

## How to set up direct debit payments

### Before you start

Make sure you have already finished the [How to enable payment methods](site-settings.md#how-to-enable-payment-methods) tutorial.

### Configure your business bank account information

Your business bank account information is stored in the `merchantInfo` mixin.

First, check if the `merchantInfo` mixin has already been configured by sending a request to the [Retrieving a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' \
  --header 'Accept: */*'
```

If your site's `merchantInfo` has never been configured before or has been deleted, you will receive a `404` error in the response body. In this case, to set up your business's bank account information, you need to send a request to the [Creating a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#post-site-tenant-sites-sitecode-mixins) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' \
  --header 'Content-Type: application/json' \
  --data '{
    "testMixin": {
    "active": true,
    "metadata": {
      "schema": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/testMixin.json"
    }
  },
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
}
```

If your site's `merchantInfo` has already been configured, you will receive it in the response body.

{% hint style="warning" %}
Check if all of the following fields are filled out with correct information:

* `merchantName`
* `merchantId`
* `merchantFinanceInfo`
{% endhint %}

If you need to update your `merchantInfo`, you need to send a request to the [Partially updating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#patch-site-tenant-sites-sitecode-mixins-mixinname) mixin endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins/{mixinName}' \
  --header 'Content-Type: application/json' \
  --data '{
    "active": true,
  "merchantName": " ",
  "merchantId": " ",
  "merchantFinanceInfo": {
    "merchantSalesTaxId": " ",
    "merchantIban": " ",
    "merchantBic": " ",
    "sepaCreditorId": " "
  }
}
```

### Configure settings for direct debit payments

Settings for direct debit payments are stored in the `debitSettings` mixin. To configure them, you need to send a request to the [Creating a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#post-site-tenant-sites-sitecode-mixins) endpoint with a set of standard values in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/catalog/api-reference/" %}
[api-reference](../../catalogs-and-categories/catalog/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' \
  --header 'Content-Type: application/json' \
  --data '{
    "testMixin": {
    "active": true,
    "metadata": {
      "schema": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/testMixin.json"
    }
  },
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
}
```

### Specify your business's SEPA Creditor ID

Your business's SEPA Creditor ID is stored in your tenant's `sepaCreditor` configuration. To set up a `sepaCreditor` configuration, you need to send a request to the [Creating configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#post-configuration-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../country-service/api-reference/" %}
[api-reference](../country-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations' \
  --header 'Content-Type: application/json' \
  --data '[
    {
      "key": "sepaCreditor",
      "secured": false,
      "value": "",
      "version": 1
    },
  ]'
```

## How to add custom attributes to a site

Custom site attributes are stored in a site's `mixins`.

{% hint style="warning" %}
To learn more about mixins in the Emporix Commerce Engine, check out the [Standard Practices in the Emporix API](../../standard-practices/mixins.md).
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

Once your schema is ready, send a request to the [Creating a site mixin](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#post-site-tenant-sites-sitecode-mixins) endpoint with the site's custom attributes in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}/mixins' \
  --header 'Content-Type: application/json' \
  --data '{
    "testMixin": {
    "active": true,
    "metadata": {
      "schema": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/testMixin.json"
    }
  },
  "customerSettings": {
    "regExSettings": {
      "mail": "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$",
      "phone": "^[0-9\\+][0-9]{7,}$",
      "password": ".{6,}",
      "bic": "^((.{8})|(.{11}))$",
      "accountOwner": "^[a-zA-Z0-9''':?,()\\-. +/ÄäÜüÖöß&]{0,70}$"
    },
    "metadata": {
      "schema": "{schemaURL}"
    }
  }
}'
```
