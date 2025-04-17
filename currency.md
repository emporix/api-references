---
seo:
  title: Currency Service Tutorials
  description: currency, currencies
---
import {
  Button,
  OpenApiTryIt,
  ExplainStep
} from '@redocly/developer-portal/ui';

# Currency Service Tutorials


## Supported currencies

The Emporix e-commerce system supports all existing currencies.

When creating a tenant on the Emporix Developer Portal, you can choose one of the following currencies:

* EUR — Euro
* GBP — Pound sterling
* NOK — Norwegian krone
* USD — United States dollar

:::info

*What if my business operates in a currency that's not on the list?*

If your business operates in a currency that's not listed on the Emporix Developer Portal, you need to perform the following steps:

1. Choose one of the available currencies and finish creating your tenant.
2. Get your Emporix API keys from the Emporix Developer Portal.
3. Change your tenant's currency configuration.
:::

## Currency configurations

Currencies are configured both tenant-wide and independently for particular sites.

:::info

*What's the difference between a tenant's currency configuration and a site's currency configuration?*

Currency configured for a particular site needs to be one of the currencies configured for the whole tenant. In other words, your tenant's currency configuration must include all currencies configured for all of the sites.
:::

Currency codes defined in currency configurations must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).

Your tenant's currency configuration is stored under the `project_curr` key in the Emporix API [Configuration Service](/openapi/configuration). Check out the following example:

```json
{
  "key": "project_curr",
  "value": "[{\"id\":\"EUR\",\"label\":\"Euro\",\"default\":true,\"required\":true},{\"id\":\"GBP\",\"label\":\"Pound sterling\",\"default\":false,\"required\":false}]"
}
```

Site-specific currency configuration is stored in the `currency` field, inside the `Site` object. Check out the following example:

```json
{
  "currency": "EUR"
}
```

:::info
For more information on the `Site` object, check out the [*Site Settings Service guide*](/content/site-settings).
:::

## Managing currency configurations through Emporix API

Check out the following tutorials to learn more about currency configuration with Emporix API.

### How to check which currencies are configured for your tenant

To retrieve your tenant's currency configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/GET-configuration-retrieve-config" size="small">Retrieving a configuration</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="GET-configuration-retrieve-config"
  parameters={{
    path:{
         "propertyKey": "project_curr"
    }
  }}
/>

### How to change your tenant's currency configuration

To change your tenant's currency configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/PUT-configuration-update-config" size="small">Updating a configuration</Button></nobr> endpoint with updated currency information in the request body.

:::attention
The id in the request body must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
:::

<OpenApiTryIt
  definitionId="configuration"
  operationId="PUT-configuration-update-config"
  parameters={{
    path:{
         "propertyKey": "project_curr"
    }
  }}
  properties={{
      key: "project_curr",
      value: [
        {   id: "PLN",
            label: "Polish zloty",
            default: "true",
            required: "true"
        }
          ]
  }}
/>

### How to check which currency is configured for a particular site

To retrieve a particular site's currency configuration, you need to call the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-retrieve-site-config" size="small">Retrieving a site</Button></nobr> endpoint. The currency configuration will be returned under the `currency` field in the response body.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="GET-site-settings-retrieve-site-config"
  parameters={{
    query: {
      expand: {
          "payment": "all",
          "shipping": "active",
          "tax": "none"
            }
    } 
  }}
/>

### How to change a particular site's currency configuration

To change a particular site's currency configuration, you need to call the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site" size="small">Partially updating a site</Button></nobr> endpoint with the currency code of your choice in the request body.

:::attention

The currency code must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
:::

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site"
  properties={{
        currency: "PLN"
  }}
/>



