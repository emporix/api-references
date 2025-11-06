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

Unit handling integrates with the following services:

- **Price Service**: 
  - Validates unit codes when creating or updating price models.
  - Converts units during price matching when the requested unit differs from the price model's unit.
- **Cart Service**: 
  - Validates unit codes when adding or updating cart items.
  - Calculates item unit prices by converting between units when needed.
- **Product Service**: 
  - Product data references unit codes, for example, `unitPricingMeasure`, `unitPricingBaseMeasure`, `orderUnit`. Unit names and symbols are retrieved from Unit Handling for display.

{% hint style="success" %}
Changes to units propagate across the platform within ~5 minutes after create/update/delete operations.
{% endhint %}

## How to add a new unit

To add a new measurement unit to your configuration, send a request to the [Adding a new unit](https://developer.emporix.io/api-references/api-guides/configuration/unit-handling-service/api-reference/unit-management#post-unit-handling-tenant-units) endpoint.

{% hint style="warning" %}
Unit names are localized. When creating a new unit, you can specify the unit name in two different ways — in one language or in multiple languages.

If you need more info on localization, see the [_Standard practices_](../../standard-practices/translations.md) documentation.
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

To convert between units, send a request to the [Converting units ](https://developer.emporix.io/api-references/api-guides/configuration/unit-handling-service/api-reference/unit-conversion#put-unit-handling-tenant-units-convert-unit-commands)endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../unit-handling-service/api-reference/" %}
[api-reference](../unit-handling-service/api-reference/)
{% endcontent-ref %}

<pre class="language-bash"><code class="lang-bash">curl -L 
<strong>  --request PUT 
</strong>  --url 'https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands' 
  --header 'Content-Type: application/json' 
  --data '{
    "commandUuid": "550e8400-e29b-41d4-a716-446655440000",
    "input": {
      "sourceUnitAmount": 100,
      "sourceUnit": "g",
      "targetUnit": "kg"
    }
  }'
</code></pre>

## Using unit handling with price service

The Price Service uses unit codes for measurement-based pricing, for example, per kg, per L.

When displaying per-unit prices, use the Unit Handling to calculate conversion factors or to convert quantities before computing or presenting prices.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
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

### Validating units in price models 

When creating or updating a price model, the `unitCode` in the `measurementUnit` field must exist in Unit Handling. The Price Service validates this by checking if the unit exists.

**Example: Creating a price model with unit validation**

Before creating a price model with `unitCode: "kg"`, first verify if the unit exists, by sending a request to the [Finding units by filters with sorting and paging](https://developer.emporix.io/api-references/api-guides/configuration/unit-handling-service/api-reference/unit-management#get-unit-handling-tenant-units) endpoint.

```bash
curl -L 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

If the unit exists, proceed with creating the price model:

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/price/{tenant}/priceModels' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "includesTax": true,
    "includesMarkup": true,
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
  }'
```

If the unit doesn't exist, create it first using the Unit Handling Service.

### Converting units in price matching

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

If the price model's `measurementUnit.unitCode` is `g` but you request `kg`, the Price Service internally calls the [Converting a unit](https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands) enpoint:

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

Where the matched price response includes the converted quantity:

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

Before adding a cart item with a unit price, verify the unit exists.

You can either retrieve the units list and filter by code:

```bash
curl -L 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

Or retrieve the specific unit:

```bash
curl -L 
  --request GET 
  --url 'https://api.emporix.io/unit-handling/{tenant}/units/kg'
```

If the unit exists, proceed with adding the cart item:

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

If the unit doesn't exist, create it first using the Unit Handling Service.

### Calculating unit prices in cart

When calculating item unit prices, the Cart Service may need to convert prices to match the item unit. This uses Unit Handling conversion endpoint.

**Example: Converting unit price for cart item**

If a product price is defined per kilogram `kg`, but the cart item needs the price per gram `g`, use the [Converting a unit](https://api.emporix.io/unit-handling/{tenant}/units/convert-unit-commands) enpoint:

```bash
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

Then, use the converted `targetUnitAmount` (0.0105) as the unit price per gram in the cart item's `unitPrice.measurementUnit`.

{% content-ref url="../../checkout/cart/api-reference/" %}
[api-reference](../../checkout/cart/api-reference/)
{% endcontent-ref %}
