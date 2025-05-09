---
seo:
  title: Unit Handling Service Tutorials
  description: unit, units, measurement unit, measurement units
label: Tutorials
---

# Unit Handling Tutorial

### How to add a new unit

To add a new measurement unit to your configuration, you need to send a request to the [Adding a new unit](https://emporix.gitbook.io/documentation-portal/api-references/api-guides-and-references/configuration/unit-handling-service/api-reference/unit-management#post-unit-handling-tenant-units) endpoint.

{% hint style="warning" %}
Unit names are localized. When creating a new unit, you can specify the unit name in two different ways — in one language or in multiple languages.

Looking for more info on localization? Check out [_Standard practices_](../../standard-practices/translations.md).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

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

To convert between units, you need to send a request to the [Converting units ](https://emporix.gitbook.io/documentation-portal/api-references/~/changes/115/api-guides-and-references/configuration/unit-handling-service/api-reference/unit-conversion)endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

<pre class="language-bash"><code class="lang-bash">curl -L \
<strong>  --request PUT \
</strong>  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' \
  --header 'Content-Type: application/json' \
  --data '{
    "commandUuid": "text",
    "input": {
      "sourceUnitAmount": 100,
      "sourceUnit": "g",
      "targetUnit": "kg"
    }
  }'
</code></pre>
