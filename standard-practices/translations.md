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
---




# Translations

Descriptive fields — such as names or descriptions — can be localized and translated into multiple languages.

In the Emporix Commerce Engine, localized fields are stored in the form of String-String maps, where the keys are language codes and the values are the translations.

{% hint style="warning" %}

Language codes must match the ones defined in your language configurations.

For more information on language configurations, check out the [Language Configuration Tutorials](/content/language).

{% endhint %}

## How to create a localized object in a specific language

To create an object where field values are specified in one language, you need to call a `POST` endpoint for a specific resource with the `Content-Language` header set to the language's [IETF BCP 47 tag](https://en.wikipedia.org/wiki/IETF_language_tag).

{% hint style="warning" %} 

When you set the `Content-Language` header to a specific language, you need to pass the localized fields as Strings.

{% endhint %}

{% hint style="warning" %}

***What if I don't specify the fields' language?***

If you do not specify a language in which the values are expressed, the Emporix API will assume the values are expressed in your tenant's default language.

{% endhint %}

Here's an example on how to create a measurement unit with its name in German:

<OpenApiTryIt
  definitionId="unit-handling"
  operationId="POST-unit-handling-create-unit"
  parameters={{
    path: {
      tenant: "{tenant}"
      },
    header: {
        "Content-Language": "en"
    }
  }}
  defaultExample="Unit with name as a string"
/>

## How to create a localized object in multiple languages

To create an object where field values are translated to multiple languages, you need to call a `POST` endpoint for a specific resource with the `Content-Language` header set to `*`.

{% hint style="warning" %} 

When you set the `Content-Language` header to `*`, you need to pass the translations as maps of String-String pairs. 

{% endhint %}

Here's an example on how to create a measurement unit with its name in multiple languages:

<OpenApiTryIt
  definitionId="unit-handling"
  operationId="POST-unit-handling-create-unit"
  parameters={{
    path: {
      tenant: "{tenant}"
      },    
    header: {
        "Content-Language": "*"
    }
  }}
  defaultExample="Unit with name as a string"
/>

<!-- Accessing localized data in a specific language  -->

## How to retrieve a localized object in a specific language

To retrieve localized fields in one language, you need to call a `GET` endpoint for a specific resource with the `Accept-Language` header set to the language's [IETF BCP 47 tag](https://en.wikipedia.org/wiki/IETF_language_tag).

Here's an example on how to retrieve a product's localized fields in German:

<OpenApiTryIt
  definitionId="product"
  operationId="GET-product-retrieve-product"
  parameters={{
    path: {
      tenant: "{tenant}"
      },
    header: {
        "Accept-Language": "en"
    }
  }}
/>

 
## How to retrieve a localized object in all available languages

To retrieve localized fields in all available languages, you need to call a `GET` endpoint for a specific resource with the `Accept-Language` header set to `*`.

Here's an example on how to retrieve a product's localized fields in all available languages:

<OpenApiTryIt
  definitionId="product"
  operationId="GET-product-retrieve-product"
  parameters={{
    path: {
      tenant: "{tenant}"
      },
    header: {
        "Accept-Language": "*"
    }
  }}
/>

## How to add localized fields to an existing object

To add translations to an existing object's localizable fields, you need to call a `PUT` or a `PATCH` endpoint for a specific resource with the `Content-Language` header set to `*`.

{% hint style="warning" %} 

When you add translations to an existing object, you need to always pass the translations as maps of String-String pairs. 

{% endhint %}

Here's an example on how to add translations to a measurement unit's name:

<OpenApiTryIt
  definitionId="unit-handling"
  operationId="PUT-unit-handling-update-unit"
  parameters={{
    path: {
      tenant: "{tenant}"
      },
    header: {
        "Content-Language": "*"
    }
  }}
  properties={{
    "code" : "kg",
    "name" : {
        "de" : "Kilogramm",
        "en" : "kilogram",
        "pl" : "kilogram",
        "fr" : "kilogramme"
    },
    "type" : "mass",
    "baseUnit" : true,
    "factor": 1
  }}
/>
