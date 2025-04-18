---
seo:
  title: Language Configuration Tutorials
  description: language, languages
---
import {
  Button,
  OpenApiTryIt,
  ExplainStep
} from '@redocly/developer-portal/ui';

# Language Configuration Tutorials

While the Emporix e-commerce system is designed in English, you can specify languages in which your business communicates with suppliers and customers. Languages are used when generating the following resources:

* Business reports
* Emails
* Invoices
* Packlists
* Picklists
* Shipping notes

## Supported languages

The Emporix e-commerce system supports all existing languages, including regional language variants such as American English or Swiss German. By default, both your Emporix tenant and its main site have their language set to English.

:::info

Currently, the Emporix e-commerce system does not offer translation services.

To learn how to localize and translate your business's resources, check out the developer guides for particular services.
:::

## Language configurations

Languages are configured both tenant-wide and independently for particular sites.

:::info

*What's the difference between a tenant's language configuration and a site's language configuration?*

Languages configured for a particular site need to be a subset of languages configured for the whole tenant. In other words, your tenant's language configuration must include all languages configured for all of the sites.
:::

Language codes defined in language configurations must be compliant with the [IETF BCP-47 standard](https://en.wikipedia.org/wiki/IETF_language_tag).

Your tenant's language configuration is stored under the `project_lang` key in the [Emporix API Configuration Service](/openapi/configuration). Check out the following language configuration example:

```json
{
  "key": "project_lang",
  "value": "[{\"id\":\"en\",\"label\":\"English\",\"default\":false,\"required\":false},{\"id\":\"de\",\"label\":\"German\",\"default\":true,\"required\":true},{\"id\":\"fr\",\"label\":\"French\",\"default\":false,\"required\":false}]"
}
```

Site-specific language configuration is stored in the `defaultLanguage` and `languages` fields, inside the `Site` object.

```json

{
  "defaultLanguage": "de",
  "languages": [
    "de",
    "en"
  ]
}
```

:::info
For more information on the `Site` object, check out the [*Site Settings Service guide*](/content/site-settings).
:::


## Managing language configurations through Emporix API

Check out the following tutorials to learn more about language configuration with Emporix API.

### How to check which languages are configured for your tenant

To retrieve your tenant's language configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/GET-configuration-retrieve-config" size="small">Retrieving a configuration</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="GET-configuration-retrieve-config"
  parameters={{
    path:{
         "propertyKey": "project_lang"
    }
  }}
/>

### How to change your tenant's language configuration

To change your tenant's language configuration, you need to send a request to the <nobr><Button to="/openapi/configuration/#operation/PUT-configuration-update-config" size="small">Updating a configuration</Button></nobr> endpoint with updated language information in the request body.

:::attention
The id in the request body must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
:::

<OpenApiTryIt
  definitionId="configuration"
  operationId="PUT-configuration-update-config"
  parameters={{
    path:{
         "propertyKey": "project_lang"
    }
  }}
  properties={{
      key: "project_lang",
      value: [
        {   id: "pl",
            label: "Polish",
            default: "true",
            required: "true"
        }
          ]
  }}
/>

### How to check which languages are configured for a particular site

To retrieve a particular site's language configuration, you need to send a request to the <nobr><Button to="/openapi/site-settings/#operation/GET-site-settings-retrieve-site-config" size="small">Retrieving a site</Button></nobr> endpoint. The language configuration will be returned in the the `defaultLanguage` and `language` fields in the response body.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site"
  parameters={{
    query: {
      expand: "payment:all,shipping:active,tax:none"
    }
  }}
/>

### How to change a particular site's language configuration

To change a particular site's language configuration, you need to call the <nobr><Button to="/openapi/site-settings/#operation/PATCH-site-settings-update-site" size="small">Partially updating a site</Button></nobr> endpoint with language configuration of your choice in the request body.

:::attention

The currency code must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
:::

<OpenApiTryIt
  definitionId="site-settings"
  operationId="PATCH-site-settings-update-site"
  properties={{
        defaultLanguage: "de",
        languages: [
            "de",
            "en"
        ]
  }}
/>
