---
seo:
  title: Language Configuration Tutorials
  description: language, languages
---

# Language Tutorials

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

Your tenant's language configuration is stored under the `project_lang` key in the [Emporix API Configuration Service](../configuration-service/README.md). Check out the following language configuration example:

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
For more information on the `Site` object, check out the [_Site Settings Service guide_](../site-settings-service/README.md).
{% endhint %}

### Managing language configurations through Emporix API

Check out the following tutorials to learn more about language configuration with Emporix API.

### How to check which languages are configured for your tenant

To retrieve your tenant's language configuration, you need to send a request to the [Retrieving a configuration](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../configuration-service/api-reference/" %}
[api-reference](../configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  --header 'Accept: */*'
```

### How to change your tenant's language configuration

To change your tenant's language configuration, you need to send a request to the [Updating a configuration](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint with updated language information in the request body.

{% hint style="warning" %}
The id in the request body must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../configuration-service/api-reference/" %}
[api-reference](../configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  --header 'Content-Type: application/json' \
  --data '{
    "key": "project_country",
    "secured": false,
    "value": "AT",
    "version": 1
  }'
```

### How to check which languages are configured for a particular site

To retrieve a particular site's language configuration, you need to send a request to the [Retrieving a site](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode) endpoint. The language configuration will be returned in the the `defaultLanguage` and `language` fields in the response body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../site-settings-service/api-reference/" %}
[api-reference](../site-settings-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}' \
  --header 'Accept: */*'
```

### How to change a particular site's language configuration

To change a particular site's language configuration, you need to call the [Partially updating a site](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#patch-site-tenant-sites-sitecode) endpoint with language configuration of your choice in the request body.

{% hint style="warning" %}
The currency code must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../site-settings-service/api-reference/" %}
[api-reference](../site-settings-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}' \
  --header 'Content-Type: application/json' \
  --data '{
    "defaultLanguage": "en"
  }'
```
