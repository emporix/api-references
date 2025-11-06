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

Unit handling defines, localizes, and converts measurement units (metric, imperial, USC, and custom) used across your catalog and calculations. It is tenant-scoped and acts as the source of truth for unit codes, names/symbols, base units, and conversion factors.

### Where is unit handling used?

- Product Service: product data (for example, `unitPricingMeasure`, `unitPricingBaseMeasure`, `orderUnit`).
- Price Service: measurement-based pricing and normalization.
- Checkout and Cart: weight/volume-based fees and totals.
- Shipping and Delivery: parcel weight/dimensions and rate calculations.
- Orders and Pick-Pack: item/package weights and dimensions.
- Returns: weight-dependent items and adjustments.
- Search/Indexing: filtering and sorting on size/weight fields.

Changes to units propagate across the platform within ~5 minutes after create/update/delete.

## How to add a new unit

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

## How to convert units

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

## Using unit handling with product service

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

## Using unit handling with price service

The Price Service uses the same unit codes for measurement-based pricing (e.g., per kg, per L).

When displaying or normalizing per-unit prices, use the unit handling to calculate conversion factors or to convert quantities before computing or presenting prices.

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

### Validating units in price models (price-v2)

When creating or updating a price model, the `unitCode` in the `measurementUnit` field must exist in Unit Handling. The Price Service validates this by checking if the unit exists.

**Example: Creating a price model with unit validation**

Before creating a price model with `unitCode: "kg"`, verify the unit exists:

```bash
# Step 1: Validate the unit exists
curl -L 
  --request GET 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/kg'
```

If the unit exists (200 response), proceed with creating the price model:

```json
{
  "name": "Tiered pricing - per kilogram",
  "measurementUnit": {
    "quantity": 1,
    "unitCode": "kg"
  },
  "tierDefinition": {
    "tierType": "TIERED",
    "tiers": [
      {
        "minQuantity": {
          "quantity": 0,
          "unitCode": "kg"
        }
      }
    ]
  }
}
```

If the unit doesn't exist (404 response), create it first using the Unit Handling Service.

### Converting units in price matching (price-v2)

When matching prices, if the requested `unitCode` differs from the price model's unit, the system uses Unit Handling to convert the price to the requested unit.

**Example: Matching prices with unit conversion**

Request a price match for 10 kg, but the price model uses grams:

```json
{
  "targetCurrency": "EUR",
  "siteCode": "1111",
  "targetLocation": {
    "countryCode": "DE"
  },
  "items": [
    {
      "itemId": {
        "itemType": "PRODUCT",
        "id": "5f5a3a365bac380024b93c45"
      },
      "quantity": {
        "quantity": 10,
        "unitCode": "kg"
      }
    }
  ]
}
```

If the price model's `measurementUnit.unitCode` is `"g"` but you request `"kg"`, the Price Service internally calls:

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' 
  --header 'Content-Type: application/json' 
  --data '{
    "commandUuid": "83ddc478-89d7-48e1-8b6c-527f4c67fb56",
    "input": {
      "sourceUnitAmount": 10,
      "sourceUnit": "kg",
      "targetUnit": "g"
    }
  }'
```

The matched price response includes the converted quantity:

```json
{
  "quantity": {
    "quantity": 10000,
    "unitCode": "g"
  },
  "originalValue": 13.55,
  "effectiveValue": 13.55
}
```

{% content-ref url="../../prices-and-taxes/price-service/api-reference/" %}
[api-reference](../../prices-and-taxes/price-service/api-reference/)
{% endcontent-ref %}

### Validating units in cart items

When adding or updating cart items, the `unitCode` in `item.unitPrice.measurementUnit.unitCode` must exist in Unit Handling. The Cart Service validates this by checking if the unit exists.

**Example: Adding a cart item with unit validation**

Before adding a cart item with a unit price, verify the unit exists:

```bash
# Step 1: Validate the unit exists (list units and filter by code)
curl -L 
  --request GET 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units?code=kg'
```

Or retrieve the specific unit:

```bash
curl -L 
  --request GET 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/kg'
```

If the unit exists (200 response), proceed with adding the cart item:

```json
{
  "product": {
    "id": "5f5a3a365bac380024b93c45"
  },
  "quantity": 2,
  "price": {
    "priceId": "6245aa0a78a8576e338fa9c4",
    "originalAmount": 10.50,
    "effectiveAmount": 10.50,
    "currency": "EUR",
    "measurementUnit": {
      "quantity": 1,
      "unitCode": "kg"
    }
  }
}
```

If the unit doesn't exist (404 response), create it first using the Unit Handling Service.

### Calculating unit prices in cart (cart-v2)

When calculating item unit prices, the Cart Service may need to convert prices to match the item's unit. This uses Unit Handling's conversion endpoint.

**Example: Converting unit price for cart item**

If a product's price is defined per kilogram (`kg`), but the cart item needs the price per gram (`g`), convert the unit price:

```bash
# Convert price from per kg to per g
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' 
  --header 'Content-Type: application/json' 
  --data '{
    "commandUuid": "83ddc478-89d7-48e1-8b6c-527f4c67fb56",
    "input": {
      "sourceUnitAmount": 10.50,
      "sourceUnit": "kg",
      "targetUnit": "g"
    }
  }'
```

Response:

```json
{
  "commandUuid": "83ddc478-89d7-48e1-8b6c-527f4c67fb56",
  "input": {
    "sourceUnitAmount": 10.50,
    "sourceUnit": "kg",
    "targetUnit": "g"
  },
  "output": {
    "targetUnitAmount": 0.0105,
    "targetUnit": "g"
  }
}
```

Use the converted `targetUnitAmount` (0.0105) as the unit price per gram in the cart item's `unitPrice.measurementUnit`.

{% content-ref url="../../checkout/cart/api-reference/" %}
[api-reference](../../checkout/cart/api-reference/)
{% endcontent-ref %}
