---
seo:
  title: Translations
  description: standard practices
toc:
  enable: true
tocMaxDepth: 2
editPage:
  disable: true
label: Translations
icon: globe
layout:
  width: wide
description: Translations use language-code maps, enabling objects to be created, retrieved, and updated in one or multiple languages.
---

# Translations

Descriptive fields — such as names or descriptions — can be localized and translated into multiple languages.

In the Emporix Commerce Engine, localized fields are stored in the form of String-String maps, where the keys are language codes and the values are the translations.

{% hint style="warning" %}
Language codes must match the ones defined in your language configurations.

The following letter-case rules apply to language codes in the Product Service (products, variants, and product templates), Brand Service, Label Service, and Site Settings Service:

* `Content-Language` and `Accept-Language` values match a configured language in any letter case. For example, `Content-Language: de-de` matches the configured `de-DE` and is treated as `de-DE`.
* When you update an object with a single-language `Content-Language` header, an existing translation keeps the letter case it was stored with. Sending `Content-Language: de-de` updates an existing `de-DE` translation and does not add a second one.
* With `Content-Language: *`, the keys of a translation map must use exactly the letter case of your language configuration.
* A translation map that contains the same language twice in different letter case, for example `de-de` and `de-DE`, is rejected with a `400` response. The response message is `Language de-DE is provided more than once with different letter case.`

In other services, use language codes exactly as they are written in your language configuration.

For more information on language configurations, check out the [Language Tutorials](../configuration/configuration-service/language.md).
{% endhint %}

## How to create a localized object in a specific language

To create an object where field values are specified in one language, you need to call a `POST` endpoint for a specific resource with the `Content-Language` header set to the language's [IETF BCP 47 tag](https://en.wikipedia.org/wiki/IETF_language_tag).

{% hint style="warning" %}
When you set the `Content-Language` header to a specific language, you need to pass the localized fields as Strings.
{% endhint %}

{% hint style="warning" %}
_**What if I don't specify the fields' language?**_

If you do not specify a language in which the values are expressed, the Emporix API will assume the values are expressed in your tenant's default language.
{% endhint %}

Here's an example on how to create a measurement unit with its name in German:

```bash
curl -i -X POST \
  'https://api.emporix.io/unit-handling/{tenant}/units' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Language: de' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "kg",
    "name": "kilogram",
    "type": "mass",
    "baseUnit": true,
    "symbol": "kg",
    "factor": 1
  }'
```

## How to create a localized object in multiple languages

To create an object where field values are translated to multiple languages, you need to call a `POST` endpoint for a specific resource with the `Content-Language` header set to `*`.

{% hint style="warning" %}
When you set the `Content-Language` header to `*`, you need to pass the translations as maps of String-String pairs.
{% endhint %}

Here's an example on how to create a measurement unit with its name in multiple languages:

```bash
curl -i -X POST \
  'https://api.emporix.io/unit-handling/{tenant}/units' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Language: *' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "kg",
    "name": "kilogram",
    "type": "mass",
    "baseUnit": true,
    "symbol": "kg",
    "factor": 1
  }'
```

## How to retrieve a localized object in a specific language

To retrieve localized fields in one language, you need to call a `GET` endpoint for a specific resource with the `Accept-Language` header set to the language's [IETF BCP 47 tag](https://en.wikipedia.org/wiki/IETF_language_tag).

Here's an example on how to retrieve a product's localized fields in German:

```bash
curl -i -X GET \
  'https://api.emporix.io/product/{tenant}/products/{productId}?fields=name%2Ccode&expand=string&rawValue=true' \
  -H 'Accept-Language: de' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

## How to retrieve a localized object in all available languages

To retrieve localized fields in all available languages, you need to call a `GET` endpoint for a specific resource with the `Accept-Language` header set to `*`.

Here's an example on how to retrieve a product's localized fields in all available languages:

```bash
curl -i -X GET \
  'https://api.emporix.io/product/{tenant}/products/{productId}?fields=name%2Ccode&expand=string&rawValue=true' \
  -H 'Accept-Language: *' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

## How to add localized fields to an existing object

To add translations to an existing object's localizable fields, you need to call a `PUT` or a `PATCH` endpoint for a specific resource with the `Content-Language` header set to `*`.

{% hint style="warning" %}
When you add translations to an existing object, you need to always pass the translations as maps of String-String pairs.
{% endhint %}

Here's an example on how to add translations to a measurement unit's name:

```bash
curl -i -X PUT \
  'https://api.emporix.io/unit-handling/{tenant}/units/{unitCode}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Language: fr' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "kg",
    "name": {
      "de": "Kilogramm",
      "en": "kilogram",
      "pl": "kilogram",
      "fr": "kilogramme"
    },
    "type": "mass",
    "baseUnit": true,
    "factor": 1,
    "metadata": {
      "version": 1
    }
  }
```
 
