---
icon: wand-sparkles
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: false
  pagination:
    visible: true
---

# 2025-10-27: Checkout Service - tax country determination

## Overview

The Checkout Service uses a sophisticated logic to determine the tax country code for calculating taxes during the checkout process. Understanding this logic ensures accurate tax calculations for your orders.

The tax country determination follows a priority-based approach that checks multiple sources in a specific order to identify the most appropriate country code for tax calculations.

## Tax determination logic

The tax country code is determined based on the following rules:

### Step 1: Determine address type from site settings

First, the system checks the site's `taxDeterminationBasedOn` setting to determine which address type should be used:
* `SHIPPING_ADDRESS` - use the shipping address for tax determination
* `BILLING_ADDRESS` - use the billing address for tax determination

### Step 2: Check checkout addresses

The system looks for an address with the matching type in the `addresses` array provided in the checkout request:

* If the configured address type (e.g., `SHIPPING`) is found, its `country` field is used for tax determination
* **Fallback behavior**: If the primary address type is not found and `SHIPPING_ADDRESS` was configured, the system falls back to checking for a `BILLING` address
* If a matching address is found in the checkout request, its country code is used

### Step 3: Check legal entity addresses

If no matching address is found in the checkout request:

* The system checks if the cart has a `legalEntityId` associated with it
* If a legal entity is found, the system retrieves the legal entity's addresses
* The system looks for an address with the matching type (based on `taxDeterminationBasedOn` setting)
* If found, the legal entity address's country code is used

### Step 4: Check customer addresses

If no legal entity address is found:

* The system checks if the customer is logged in
* If logged in, the system retrieves the customer's addresses
* The system looks for the default address with the matching type
* If no default address exists with the required type, the first address matching the type is used
* If found, the customer address's country code is used

## Example checkout payload with addresses

```bash
curl -i -X POST 
  'https://api.emporix.io/checkout/{tenant}/checkouts/order' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "cartId": "9b36757a-5ea1-4689-9ed3-fb630eb5048c",
    "addresses": [
      {
        "contactName": "John Doe",
        "street": "Fritz-Elsaas",
        "streetNumber": "20",
        "zipCode": "70173",
        "city": "Stuttgart",
        "country": "DE",
        "type": "SHIPPING"
      },
      {
        "contactName": "John Doe",
        "street": "Main Street",
        "streetNumber": "100",
        "zipCode": "10001",
        "city": "New York",
        "country": "US",
        "type": "BILLING"
      }
    ],
    "paymentMethods": [...],
    "shipping": {...}
  }'
```

In this example:
* If `taxDeterminationBasedOn` is set to `SHIPPING_ADDRESS`, the system uses `DE` (Germany) for tax calculations
* If `taxDeterminationBasedOn` is set to `BILLING_ADDRESS`, the system uses `US` (United States) for tax calculations

## Comparison with Cart tax determination

While similar in concept, the Checkout Service's tax determination logic differs from the Cart Service:

**Cart Service priority order:**
1. Cart's address with origin `REQUEST` and matching type
2. Cart's `countryCode` (backward compatibility)
3. Legal entity address with matching type (origin: `LEGAL_ENTITY`)
4. Customer address with matching type (origin: `CUSTOMER`)
5. Site homebase address (origin: `SITE`)

**Checkout Service priority order:**
1. Checkout request's addresses with matching type
2. Legal entity address with matching type
3. Customer address with matching type

The key difference is that Checkout uses addresses explicitly provided in the checkout request first, while Cart manages addresses directly on the cart object with origin tracking.

## Related documentation

For more information about:
* Cart tax determination: [How to determine a tax country at cart level](https://developer.emporix.io/api-references/api-guides/checkout/cart/cart#how-to-determine-a-tax-country-at-cart-level)
* Site settings configuration: [Site Settings Service](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/)

## Updated endpoints

| Endpoint                                                                                                                                                                   | Description                                                            |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| [Triggering a checkout](https://developer.emporix.io/api-references/api-guides/checkout/checkout/api-reference/checkouts#post-checkout-tenant-checkouts-order)                    | Tax country determination logic is applied based on provided addresses.  |

## Known problems

There are no known problems.

