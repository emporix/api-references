---
seo:
  title: Tax Service Tutorials
  description: tax, taxes, tax classes, tax class, tax configuration
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Tax Service Tutorials

## How to calculate net and gross values for prices

You can calculate net and gross values for prices through the <nobr><Button to="/openapi/tax/#operation/PUT-tax-calculate-commands" size="small">Calculating net and gross values for prices</Button></nobr> endpoint.

### Before you start

Make sure you configured sales tax rates through the Emporix API Tax Service.

{% hint style="warning" %}

For instructions, check out [*How to add your first product*](/content/product/#how-to-add-your-first-product).

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

Then, send a request to the  <nobr><Button to="/openapi/tax/#operation/PUT-tax-calculate-commands" size="small">Calculating net and gross values for prices</Button></nobr> endpoint:

<OpenApiTryIt
  definitionId="tax"
  operationId="PUT-tax-calculate-commands"
  defaultExample="Gross to net"
  properties={{
    "input": {
    "targetLocation": {
      "countryCode": "DE"
    },
    "targetTaxClass": "STANDARD",
    "includesTax": true,
    "price": "1.99"
  }
  }}
/>

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

Then, send a request to the  <nobr><Button to="/openapi/tax/#operation/PUT-tax-calculate-commands" size="small">Calculating net and gross values for prices</Button></nobr> endpoint:

<OpenApiTryIt
  definitionId="tax"
  operationId="PUT-tax-calculate-commands"
  defaultExample="Net to gross"
  properties={{
    "input": {
    "targetLocation": {
      "countryCode": "DE"
    },
    "targetTaxClass": "STANDARD",
    "includesTax": false,
    "price": "1.99"
  }
  }}
/>


The calculated gross value is returned in the `output.grossPrice` field.

## How to calculate gross values between countries

You can calculate a gross price in one country to a gross price in another country through the  <nobr><Button to="/openapi/tax/#operation/PUT-tax-calculate-commands" size="small">Calculating net and gross values for prices</Button></nobr> endpoint.

{% hint style="warning" %}

This tutorial presents how to calculate gross prices between countries based on specific values.

To learn how to calculate gross prices between countries based on `Price` objects, check out [*How to calculate gross prices between countries*](/content/price/#how-to-calculate-gross-prices-between-countries).

{% endhint %}

### Before you start

Make sure you configured sales tax rates through the Emporix API Tax Service.

{% hint style="warning" %}

For instructions, check out [*How to add your first product*](/content/product/#how-to-add-your-first-product).

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

Then, send a request to the <nobr><Button to="/openapi/tax/#operation/PUT-tax-calculate-commands" size="small">Calculating net and gross values for prices</Button></nobr> endpoint:

<OpenApiTryIt
  definitionId="tax"
  operationId="PUT-tax-calculate-commands"
  defaultExample="Gross in one country to gross in another country"
  properties={{
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
  }}
/>

The calculated gross price is returned in the `output.grossPrice` field.