---
seo:
  title: Unit Handling Service Tutorials
  description: unit, units, measurement unit, measurement units
label: Tutorials
icon: graduation-cap
layout:
  width: wide
---

# Unit Handling Tutorial

### What is Unit Handling?

Unit handling defines, localizes, and converts measurement units (metric, imperial, USC, and custom) used across your catalog and calculations. It is tenant-scoped and acts as the source of truth for unit codes, names/symbols, base units, and conversion factors.

### Where is it used?

- Product Service: product data (for example, `unitPricingMeasure`, `unitPricingBaseMeasure`, `orderUnit`).
- Price Service: measurement-based pricing and normalization.
- Checkout and Cart: weight/volume-based fees and totals.
- Shipping and Delivery: parcel weight/dimensions and rate calculations.
- Orders and Pick-Pack: item/package weights and dimensions.
- Returns: weight-dependent items and adjustments.
- Search/Indexing: filtering and sorting on size/weight fields.

Changes to units propagate across the platform within ~5 minutes after create/update/delete.

### Example: Handling units during checkout

This example shows how to sum item weights in the cart, convert them to a target shipping unit, and then use the result for shipping-rate calculations.

1) Sum item weights in the cart (application logic)

- Assume your products store weight in grams (`g`). When items are added to the cart, compute the total weight in grams: `totalWeightG = sum(itemWeightG * quantity)`.

2) Convert cart total to the shipping unit (API call)

- If the shipping provider expects kilograms (`kg`), convert the total from `g` ➜ `kg` using the convert endpoint.

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' \
  --header 'Content-Type: application/json' \
  --data '{
    "commandUuid": "83ddc478-89d7-48e1-8b6c-527f4c67fb56",
    "input": {
      "sourceUnitAmount": 3250,
      "sourceUnit": "g",
      "targetUnit": "kg"
    }
  }'
```

Response contains the converted amount:

```json
{
  "commandUuid": "83ddc478-89d7-48e1-8b6c-527f4c67fb56",
  "input": { "sourceUnitAmount": 3250, "sourceUnit": "g", "targetUnit": "kg" },
  "output": { "targetUnitAmount": 3.25, "targetUnit": "kg" }
}
```

3) Use the converted weight to calculate shipping rates

- Pass `3.25 kg` to your shipping rate logic or provider integration. If the UI needs localized unit names, use `Accept-Language` when reading units (or store localized labels) and display accordingly.

Optional: If you only need the factor (for example, to convert multiple values in-app), fetch it once and apply locally:

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/conversion-factor-commands' \
  --header 'Content-Type: application/json' \
  --data '{
    "input": { "sourceUnit": "g", "targetUnit": "kg" }
  }'
```

{% content-ref url="../../checkout/cart/api-reference/" %}
[api-reference](../../checkout/cart/api-reference/)
{% endcontent-ref %}

### How to add a new unit

To add a new measurement unit to your configuration, you need to send a request to the [Adding a new unit](https://developer.emporix.io/api-references/api-guides/configuration/unit-handling-service/api-reference/unit-management#post-unit-handling-tenant-units) endpoint.

{% hint style="warning" %}
Unit names are localized. When creating a new unit, you can specify the unit name in two different ways — in one language or in multiple languages.

Looking for more info on localization? Check out [_Standard practices_](../../standard-practices/translations.md).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units' 
  --header 'Content-Language: fr' 
  --header 'Content-Type: application/json' 
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

To convert between units, you need to send a request to the [Converting units ](https://developer.emporix.io/api-references/api-guides/~/changes/115/api-guides-and-references/configuration/unit-handling-service/api-reference/unit-conversion)endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

<pre class="language-bash"><code class="lang-bash">curl -L 
<strong>  --request PUT 
</strong>  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' 
  --header 'Content-Type: application/json' 
  --data '{
    "commandUuid": "text",
    "input": {
      "sourceUnitAmount": 100,
      "sourceUnit": "g",
      "targetUnit": "kg"
    }
  }'
</code></pre>

### Using unit handling with product service

Unit handling is the source for measurement units used in product data.
* Define units and their localized names/symbols here; product payloads reference unit codes (for example, `unitPricingMeasure`, `unitPricingBaseMeasure`, `orderUnit`).
* After you create or update a unit, allow ~5 minutes for changes to propagate before they appear in the products.
* To display product values in another unit, request a conversion from Unit Handling and render the converted amount and localized unit name.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
# Example: convert a product's weight from g to kg for display
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' 
  --header 'Content-Type: application/json' 
  --data '{
    "commandUuid": "83ddc478-89d7-48e1-8b6c-527f4c67fb56",
    "input": {
      "sourceUnitAmount": 100,
      "sourceUnit": "g",
      "targetUnit": "kg"
    }
  }'
```
{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

### Using unit handling with price service

Price Service references the same unit codes for measurement-based pricing (for example, per kg, per l).

* Keep unit codes consistent across services by managing them in Unit Handling.
* For per-unit price displays or normalization, use Unit Handling to compute a conversion factor or convert amounts before calculating or showing prices.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
# Example: fetch a conversion factor to normalize prices (lb ➜ kg)
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/conversion-factor-commands' 
  --header 'Content-Type: application/json' 
  --data '{
    "commandUuid": "83ddc478-89d7-48e1-8b6c-527f4c67fb56",
    "input": {
      "sourceUnitAmount": 1,
      "sourceUnit": "g",
      "targetUnit": "kg"
    }
  }'
```
{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}
