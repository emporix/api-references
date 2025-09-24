---
seo:
  title: Country Service Tutorials
  description: country, countries
icon: graduation-cap
layout:
  width: wide
---

# Country Tutorial

## Supported countries

The Emporix e-commerce system does not impose any restrictions as to which countries can be configured as your business's locations.

## Country configurations

The countries where your business is located are specified both tenant-wide and independently for particular sites.

{% hint style="warning" %}
_**What's the difference between a tenant's country configuration and a site's country configuration?**_

A tenant's country configuration specifies where your business's headquarters are located.

A particular site's country configuration specifies where that site is located.
{% endhint %}

Country codes defined in country configurations must be compliant with the [ISO 3166-1 alpha-2 standard](https://www.iso.org/obp/ui/#iso:pub:PUB500001:en).

Your tenant's country configuration is stored under the project\_country key in the [Emporix API Configuration Service](../configuration-service/).

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

{% hint style="warning" %}
For more information on the Site object, check out the [_Site Settings Service guide_](../site-settings-service/)
{% endhint %}

## Managing country configurations through Emporix API

Check out the following tutorials to learn more about country configuration with Emporix API.

### How to check which country is configured for your tenant

To retrieve your tenant's country configuration, you need to send a request to the [Retrieving a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  --header 'Accept: */*'
```

### How to change your tenant's country configuration

To change your tenant's country configuration, you need to send a request to the [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint with updated country information in the request body.

{% hint style="warning" %}
The value in the request body must be compliant with the [ISO 3166-1 alpha-2 standard](https://www.iso.org/obp/ui/#iso:pub:PUB500001:en).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  --header 'Content-Type: application/json' \
  --data '{
    "key": "project_country",
    "secured": false,
    "value": "DE",
    "version": 1
  }'
```

### How to check which country is configured for a particular site

To retrieve a particular site's country configuration, you need to send a request to the [Retrieving a site ](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode)endpoint. The country configuration will be returned under the `homeBase` field in the response body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/site/{tenant}/sites/{siteCode}' \
  --header 'Accept: */*'
```

### How to change a particular site's country configuration

To change a particular site's country configuration, you need to send a request to the [Partially updating a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#patch-site-tenant-sites-sitecode) endpoint with the address of your choice in the request body.

{% hint style="warning" %}
The country code must be compliant with the [ISO 4217 standard](https://en.wikipedia.org/wiki/ISO_4217).
{% endhint %}

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
    "homeBase": {
    "address": {
      "street": "Platz der Republik",
      "streetNumber": "1",
      "zipCode": "11011",
      "city": "Berlin",
      "country": "DE",
      "state": "Berlin"
  }'
```
