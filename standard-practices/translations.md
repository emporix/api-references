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
description: The Emporix API supports translations by storing localized fields as language-code maps, allowing objects to be created, retrieved, and updated in single or multiple languages using the Content-Language and Accept-Language headers.
---

# Translations

Descriptive fields — such as names or descriptions — can be localized and translated into multiple languages.

In the Emporix Commerce Engine, localized fields are stored in the form of String-String maps, where the keys are language codes and the values are the translations.

{% hint style="warning" %}
Language codes must match the ones defined in your language configurations.

For more information on language configurations, check out the [Language Configuration Tutorials](../content/language/).
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
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
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
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
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
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

## How to retrieve a localized object in all available languages

To retrieve localized fields in all available languages, you need to call a `GET` endpoint for a specific resource with the `Accept-Language` header set to `*`.

Here's an example on how to retrieve a product's localized fields in all available languages:

```bash
curl -i -X GET \
  'https://api.emporix.io/product/{tenant}/products/{productId}?fields=name%2Ccode&expand=string&rawValue=true' \
  -H 'Accept-Language: *' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
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
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
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
