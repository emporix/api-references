---
seo:
  title: Tax Service Tutorials
  description: tax, taxes, tax classes, tax class, tax configuration
icon: graduation-cap
---

# Tax Tutorials

## How to calculate net and gross values for prices

You can calculate net and gross values for prices through the [Calculating net and gross values for prices](https://developer.emporix.io/api-references/api-guides-and-references/prices-and-taxes/tax-service/api-reference/tax-calculation) endpoint.

### Before you start

Make sure you configured sales tax rates through the Emporix API Tax Service.

{% hint style="warning" %}
For instructions, check out [_How to add your first product_](../../products-labels-and-brands/product-service/product.md#how-to-add-your-first-product).
{% endhint %}

### Convert a gross price to a net price

To calculate a price's net value based on its gross value, put the following data in the request body:

```json
{
  "input": {
      "targetLocation": {
          "countryCode": "DE" // country code indicated in the Tax Service
      },
      "targetTaxClass": "STANDARD", // tax class code defined in the Tax Service
      "includesTax": true, // the original price is expressed as a gross value
      "price": "1.99" // gross value
  }
}
```

Then, send a request to the [Calculating net and gross values for prices](https://developer.emporix.io/api-references/api-guides-and-references/prices-and-taxes/tax-service/api-reference/tax-calculation) endpoint:

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/tax/{tenant}/taxes/calculation-commands' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "input": {
      "targetLocation": {
        "countryCode": "DE"
      },
      "targetTaxClass": "STANDARD",
      "includesTax": true,
      "price": 1.59
    }
  }'
```

The calculated net value is returned in the `output.netPrice` field.

### Convert a net price to a gross price

To calculate a price's gross value based on its net value, put the following data in the request body:

```json
{
  "input": {
      "targetLocation": {
          "countryCode": "DE" // country code indicated in the Tax Service
      },
      "targetTaxClass": "STANDARD", // tax class defined in the Tax Service
      "includesTax": false, // the original price is expressed as a net value
      "price": "1.99" // net value
  }
}
```

Then, send a request to the [Calculating net and gross values for prices](https://developer.emporix.io/api-references/api-guides-and-references/prices-and-taxes/tax-service/api-reference/tax-calculation) endpoint:

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/tax/{tenant}/taxes/calculation-commands' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "input": {
      "targetLocation": {
        "countryCode": "DE"
      },
      "targetTaxClass": "STANDARD",
      "includesTax": false,
      "price": "1.99"
    }
  }'
```

The calculated gross value is returned in the `output.grossPrice` field.

## How to calculate gross values between countries

You can calculate a gross price in one country to a gross price in another country through the [Calculating net and gross values for prices](https://developer.emporix.io/api-references/api-guides-and-references/prices-and-taxes/tax-service/api-reference/tax-calculation) endpoint.

{% hint style="warning" %}
This tutorial presents how to calculate gross prices between countries based on specific values.

To learn how to calculate gross prices between countries based on `Price` objects, check out [_How to calculate gross prices between countries_](../price-service/price.md#how-to-calculate-gross-prices-between-countries).
{% endhint %}

### Before you start

Make sure you configured sales tax rates through the Emporix API Tax Service.

{% hint style="warning" %}
For instructions, check out [_How to add your first product_](../../products-labels-and-brands/product-service/product.md#how-to-add-your-first-product).
{% endhint %}

### Calculate the price

To calculate a gross price between countries based on its applicable tax classes, put the following data in the request body:

```json
{
  "input": {
      "sourceLocation": {
          "countryCode": "DE" // code of the country for which the original gross price is defined (indicated in the Tax Service)
      },
      "sourceTaxClass": "STANDARD", // tax class applied to the original gross price (defined in the Tax Service)
      "targetLocation": {
          "countryCode": "AT" // code of the country for which the gross price should be calculated (indicated in the Tax Service)
      },
      "targetTaxClass": "STANDARD", // tax class that should be applied to the calculated gross price (defined in the Tax Service)
      "includesTax": true, // the original price is expressed as a gross value
      "price": "1.99" // original gross price
  }
}
```

Then, send a request to the [Calculating net and gross values for prices](https://developer.emporix.io/api-references/api-guides-and-references/prices-and-taxes/tax-service/api-reference/tax-calculation) endpoint:

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/tax/{tenant}/taxes/calculation-commands' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "input": {
      "sourceLocation": {
        "countryCode": "DE"
      },
      "sourceTaxClass": "STANDARD",
      "targetLocation": {
        "countryCode": "AT"
      },
      "targetTaxClass": "STANDARD",
      "includesTax": true,
      "price": "1.99"
    }
  }'
```

The calculated gross price is returned in the `output.grossPrice` field.
