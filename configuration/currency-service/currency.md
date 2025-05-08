---
seo:
  title: Currency Service Tutorials
  description: currency, currencies
---

# Currency Tutorial

### Supported currencies

The Emporix e-commerce system supports all existing currencies.

When creating a tenant on the Emporix Developer Portal, you can choose one of the following currencies:

* EUR — Euro
* GBP — Pound sterling
* NOK — Norwegian krone
* USD — United States dollar

{% hint style="warning" %}
_What if my business operates in a currency that's not on the list?_
{% endhint %}

If your business operates in a currency that's not listed on the Emporix Developer Portal, you need to perform the following steps:

1. Choose one of the available currencies and finish creating your tenant.
2. Get your Emporix API keys from the Emporix Developer Portal.
3. Change your tenant's currency configuration.
{% endhint %}

### Currency configurations

Currencies are configured both tenant-wide and independently for particular sites.

{% hint style="warning" %}
_What's the difference between a tenant's currency configuration and a site's currency configuration?_

Currency configured for a particular site needs to be one of the currencies configured for the whole tenant. In other words, your tenant's currency configuration must include all currencies configured for all of the sites.
{% endhint %}

Currency codes defined in currency configurations must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).

Your tenant's currency configuration is stored under the `project_curr` key in the Emporix API [Configuration Service](../configuration-service/). Check out the following example:

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

{% hint style="warning" %}
For more information on the `Site` object, check out the [_Site Settings Service guide_](../site-settings-service/README.md)
{% endhint %}

### Managing currency configurations through Emporix API

Check out the following tutorials to learn more about currency configuration with Emporix API.

### How to check which currencies are configured for your tenant

To retrieve your tenant's currency configuration, you need to send a request to the [Retrieving a configuration](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  --header 'Accept: */*'
```

### How to change your tenant's currency configuration

To change your tenant's currency configuration, you need to send a request to the [Updating a configuration](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint with updated currency information in the request body.

{% hint style="warning" %}
The id in the request body must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

```
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  --header 'Content-Type: application/json' \
  --data '{
    "key": "project_curr",
    "secured": false,
    "value": [
    {
      "id": "PLN",
      "label": "Polish zloty",
      "default": "true",
      "required": "true"
    }
    "version": 1
  }'
```

### How to check which currency is configured for a particular site

To retrieve a particular site's currency configuration, you need to call the [Retrieving a site](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode) endpoint. The currency configuration will be returned under the `currency` field in the response body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}' \
  --header 'Accept: */*'
```

### How to change a particular site's currency configuration

To change a particular site's currency configuration, you need to call the [Partially updating a site ](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/site-settings-service/api-reference/site-settings#patch-site-tenant-sites-sitecode)endpoint with the currency code of your choice in the request body.

{% hint style="warning" %}
The currency code must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

```
curl -L \
  --request PATCH \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}' \
  --header 'Content-Type: application/json' \
  --data '{
    "defaultLanguage": "en"
    "currency": "PLN"
  }'
```
