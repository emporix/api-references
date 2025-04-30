---
seo:
  title: Unit Handling Service Tutorials
  description: unit, units, measurement unit, measurement units
label: Tutorials
---

# Unit Handling Tutorial

### How to add a new unit

To add a new measurement unit to your configuration, you need to send a request to the [Adding a new unit](broken-reference/) endpoint.

{% hint style="warning" %}
Unit names are localized. When creating a new unit, you can specify the unit name in two different ways — in one language or in multiple languages.

Looking for more info on localization? Check out [_Standard practices_](../../content/standard-practices/).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

[Broken link](broken-reference "mention")

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/unit-handling/{tenant}/units' \
  --header 'Content-Language: fr' \
  --header 'Content-Type: application/json' \
  --data '{
    "code": "kg",
    "name": "kilogram",
    "type": "mass",
    "baseUnit": true,
    "symbol": "kg",
    "factor": 1
  }'
```

### How to convert units

You can convert between any measurement units that share the same base unit, such as kilograms to grams, or centimeters to meters.

To convert between units, you need to send a request to the [Converting units ](broken-reference)endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

[Broken link](broken-reference "mention")

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' \
  --header 'Content-Type: application/json' \
  --data '{
    "commandUuid": "text",
    "input": {
      "sourceUnitAmount": 100,
      "sourceUnit": "g",
      "targetUnit": "kg"
    }
  }'
```
