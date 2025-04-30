---
seo:
  title: Unit Handling Service Tutorials
  description: unit, units, measurement unit, measurement units
label: Tutorials
---

# Unit Handling Tutorial

### How to add a new unit

To add a new measurement unit to your configuration, you need to send a request to the [Adding a new unit](broken-reference) endpoint.

{% hint style="warning" %}
Unit names are localized. When creating a new unit, you can specify the unit name in two different ways — in one language or in multiple languages.

Looking for more info on localization? Check out [_Standard practices_](../../content/standard-practices/).
{% endhint %}

<mark style="color:red;">EXAMPLE OPTION 1:</mark>

{% openapi-operation spec="unit-handling-api" path="/unit-handling/{tenant}/units" method="post" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

<mark style="color:red;">EXAMPLE OPTION 2:</mark>

{% hint style="success" %}
Try it out! [Broken link](broken-reference "mention")
{% endhint %}

<mark style="color:red;">EXAMPLE OPTION 3:</mark>

```
POST /unit-handling/{tenant}/units HTTP/1.1
Host: api.emporix.io
Content-Language: fr
Content-Type: application/json
Accept: */*
Content-Length: 86

{
  "code": "kg",
  "name": {
    "en": "kilogram",
    "de": "Kilogramm",
    "pl": "kilogram",
    "fr": "kilogramme"
  },
  "type": "mass",
  "baseUnit": true,
  "symbol": "kg",
  "factor": 1
}
```

<mark style="color:red;">EXAMPLE OPTION 4:</mark>

<details>

<summary>Try it out! <a data-mention href="broken-reference">Broken link</a></summary>

```
{
  "code": "kg",
  "name": {
    "en": "kilogram",
    "de": "Kilogramm",
    "pl": "kilogram",
    "fr": "kilogramme"
  },
  "type": "mass",
  "baseUnit": true,
  "symbol": "kg",
  "factor": 1
}
```

</details>



\<OpenApiTryIt\
definitionId="unit-handling"\
operationId="POST-unit-handling-create-unit"\
defaultExample="Unit with name as a map"\
parameters=\{{\
header: {\
"Content-Language": "\*"\
}\
\}}\
properties=\{{\
"code" : "kg",\
"name" : {\
"de" : "Kilogramm",\
"en" : "kilogram",\
"pl" : "kilogram",\
"fr" : "kilogramme"\
},\
"type" : "mass",\
"baseUnit" : true,\
"factor": 1\
\}}\
/>

### How to convert units

You can convert between any measurement units that share the same base unit, such as kilograms to grams, or centimeters to meters.

To convert between units, you need to send a request to the Converting units endpoint.
