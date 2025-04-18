---
seo:
  title: Country Service Tutorials
  description: country, countries
---
import {
  Button,
  OpenApiTryIt,
  ExplainStep
} from '@redocly/developer-portal/ui';

# Country Service Tutorials


## Supported countries

The Emporix e-commerce system does not impose any restrictions as to which countries can be configured as your business's locations.

## Country configurations

The countries where your business is located are specified both tenant-wide and independently for particular sites.

:::info

***What's the difference between a tenant's country configuration and a site's country configuration?***

A tenant's country configuration specifies where your business's headquarters are located.

A particular site's country configuration specifies where that site is located.
:::

Country codes defined in country configurations must be compliant with the [ISO 3166-1 alpha-2 standard](https://www.iso.org/obp/ui/#iso:pub:PUB500001:en).

Your tenant's country configuration is stored under the project_country key in the [Emporix API Configuration Service](/openapi/configuration).

```json
{
  "key": "project_country",
  "value": "DE"
}
```
Site-specific country configuration is stored in the `homeBase` field, inside the `Site` object.

```json
{
  "homeBase": {
    "address": {
      "zipCode": "10115",
      "country": "DE"
    }
  }
}
```

:::info

For more information on the Site object, check out the [*Site Settings Service guide*](/content/site-settings).
:::

## Managing country configurations through Emporix API

Check out the following tutorials to learn more about country configuration with Emporix API.

### How to check which country is configured for your tenant

To retrieve your tenant's country configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/GET-configuration-retrieve-config" size="small">Retrieving a configuration</Button></nobr> endpoint.



<OpenApiTryIt
  definitionId="configuration"
  operationId="GET-configuration-retrieve-config"
  parameters={{
    "path":{
         "propertyKey": "project_country"
    }
  }}
/>

### How to change your tenant's country configuration

To change your tenant's country configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/PUT-configuration-update-config" size="small">Updating a configuration</Button></nobr> endpoint with updated country information in the request body.

:::attention

The value in the request body must be compliant with the [ISO 3166-1 alpha-2 standard](https://www.iso.org/obp/ui/#iso:pub:PUB500001:en).
:::

<OpenApiTryIt
  definitionId="configuration"
  operationId="PUT-configuration-update-config"
  parameters={{
    "path":{
         "propertyKey": "project_country"
    }
  }}
  properties={{
      "key": "project_country",
      "value": "DE"
  }}
/>

### How to check which country is configured for a particular site

To retrieve a particular site's country configuration, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-retrieve-site-config" size="small">Retrieving a site</Button></nobr> endpoint. The country configuration will be returned under the `homeBase` field in the response body.

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


### How to change a particular site's country configuration

To change a particular site's country configuration, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site" size="small">Partially updating a site</Button></nobr> endpoint with the address of your choice in the request body.

:::attention

The country code must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
:::

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site"
  properties={{
        homeBase: {
            address: {
                street: "Platz der Republik",
                streetNumber: "1",
                zipCode: "11011",
                city: "Berlin",
                country: "DE",
                state: "Berlin"
            }
    }
  }}
/>
