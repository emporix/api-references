---
seo:
  title: Language Configuration Tutorials
  description: language, languages
---

# Language Tutorials

import {\
Button,\
OpenApiTryIt,\
ExplainStep\
} from '@redocly/developer-portal/ui';

## Language Configuration Tutorials

While the Emporix e-commerce system is designed in English, you can specify languages in which your business communicates with suppliers and customers. Languages are used when generating the following resources:

* Business reports
* Emails
* Invoices
* Packlists
* Picklists
* Shipping notes

### Supported languages

The Emporix e-commerce system supports all existing languages, including regional language variants such as American English or Swiss German. By default, both your Emporix tenant and its main site have their language set to English.

{% hint style="warning" %}
Currently, the Emporix e-commerce system does not offer translation services.

To learn how to localize and translate your business's resources, check out the developer guides for particular services.
{% endhint %}

### Language configurations

Languages are configured both tenant-wide and independently for particular sites.

{% hint style="warning" %}
_What's the difference between a tenant's language configuration and a site's language configuration?_

Languages configured for a particular site need to be a subset of languages configured for the whole tenant. In other words, your tenant's language configuration must include all languages configured for all of the sites.
{% endhint %}

Language codes defined in language configurations must be compliant with the [IETF BCP-47 standard](https://en.wikipedia.org/wiki/IETF_language_tag).

Your tenant's language configuration is stored under the `project_lang` key in the [Emporix API Configuration Service](../../openapi/configuration/). Check out the following language configuration example:

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

{% hint style="warning" %}
For more information on the `Site` object, check out the [_Site Settings Service guide_](../../content/site-settings/).
{% endhint %}

### Managing language configurations through Emporix API

Check out the following tutorials to learn more about language configuration with Emporix API.

#### How to check which languages are configured for your tenant

To retrieve your tenant's language configuration, you need to send a request to the Retrieving a configuration endpoint.

Try it out: Retrieve Configuration

#### How to change your tenant's language configuration

To change your tenant's language configuration, you need to send a request to the Updating a configuration endpoint with updated language information in the request body.

{% hint style="warning" %}
The id in the request body must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
{% endhint %}

\<OpenApiTryIt\
definitionId="configuration"\
operationId="PUT-configuration-update-config"\
parameters=\{{\
path:{\
"propertyKey": "project\_lang"\
}\
\}}\
properties=\{{\
key: "project\_lang",\
value: \[\
{ id: "pl",\
label: "Polish",\
default: "true",\
required: "true"\
}\
]\
\}}\
/>

#### How to check which languages are configured for a particular site

To retrieve a particular site's language configuration, you need to send a request to the Retrieving a site endpoint. The language configuration will be returned in the the `defaultLanguage` and `language` fields in the response body.

\<OpenApiTryIt\
definitionId="site-settings"\
operationId="PATCH-site-settings-update-site"\
parameters=\{{\
query: {\
expand: "payment:all,shipping:active,tax:none"\
}\
\}}\
/>

#### How to change a particular site's language configuration

To change a particular site's language configuration, you need to call the Partially updating a site endpoint with language configuration of your choice in the request body.

{% hint style="warning" %}
The currency code must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
{% endhint %}

\<OpenApiTryIt\
definitionId="site-settings"\
operationId="PATCH-site-settings-update-site"\
properties=\{{\
defaultLanguage: "de",\
languages: \[\
"de",\
"en"\
]\
\}}\
/>
