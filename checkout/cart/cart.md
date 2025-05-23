---
seo:
  title: Cart Service Tutorials
  description: cart, carts
toc:
  enable: true
tocMaxDepth: 2
editPage:
  disable: true
label: Tutorials
---

# How to create a new cart

To create a new cart, you need to send a request to the [Creating a new cart](https://emporix.gitbook.io/documentation-portal/api-references/checkout/cart/api-reference/carts#post-cart-tenant-carts) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -H 'saas-token: string' \
  -H 'session-id: string' \
  -d '{
    "siteCode": "main",
    "currency": "EUR",
    "type": "shopping",
    "channel": {
      "name": "storefront",
      "source": "https://your-storefront.com/"
    },
    "sessionValidated": true
  }'
```

# How to add custom attributes to a cart

You can define custom attributes for a cart through `mixins`.

# Define your custom attributes schema

First, define your custom attributes schema in the form of a JSON schema.

```json
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {
      "cartInstructions": {
        "type": "object",
        "properties": {
          "instruction": {
            "type": "string"
          }
        }
      }
    }
}
```

Upload your schema to a hosting service and save its URL

# Update a cart with custom attributes

To add custom attributes to a cart, you need to send a request to the [Updating a cart](https://emporix.gitbook.io/documentation-portal/api-references/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
  "customerId": "87413250",
  "currency": "EUR",
  "deliveryWindowId": "60006da77ec20a807cd6f065",
  "type": "wishlist",
  "zipCode": "10115",
  "countryCode": "DE",
  "status": "OPEN",
  "deliveryWindow": {
    "id": "5b5572a61cf31a000f31eee4",
    "deliveryDate": "2023-06-06T12:00:00.000Z",
    "slotId": "5678-8756-3321-1234"
  },
  "channel": {
    "name": "storefront",
    "source": "https://your-storefront.com/"
  },
  "metadata": {
    "mixins": {
      "generalAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/orderGeneralAttributesMixIn.v9.json",
      "deliveryTime": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/deliveryTimeMixIn.v2.json",
      "cartInstructions": "https://res.cloudinary.com/saas-ag/raw/upload/v1635253083/schemata/CAAS/cartInstructions_schema.json"
    }
  },
  "mixins": {
    "deliveryTime": {
      "deliveryDate": "2021-06-08T12:00:00.000Z",
      "deliveryTimeId": "5f5a3da02d48b9000d39798c"
    },
    "cartInstructions": {
      "instruction": "It would be nice if you could deliver the order after 5 PM."
    }
  }
}'
```

# How to merge carts

{% hint style="warning" %}
To learn more about merging carts, check out [Cart merging](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/core-commerce/carts#cart-merging) in the Carts guide.
{% endhint %}

To merge an anonymous cart with a customer cart, you need to send a request to the [Merging carts](https://emporix.gitbook.io/documentation-portal/api-references/checkout/cart/api-reference/carts#post-cart-tenant-carts-cartid-merge) endpoint. Provide the customer cart's ID in the `cartId` path parameter and the anonymous cart's ID in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/merge' \
  -H 'Accept-Language: string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
  -H 'languages: string' \
  -d '{
  "carts": [
    " "
  ]
}'
```

# How to source pricing information from an external price calculation tool

For B2B scenarios, you might want to integrate an external application for price calculation for your products. Usually, the systems, such as ERPs, store all the relevant customer-specific pricing information needed for customer-specific pricing.\
The external system then can communicate with the Cart Service directly to overwrite the price of the product added to the cart.

{% hint style="warning" %}
To achieve the communication between Commerce Engine and the external pricing tool, you have to configure both systems accordingly.\
The steps required for such a case are described in the [External Products, Pricing and Fees](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) documentation.\
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

After enabling the external application to update carts with calculated prices, to add a product that is available within Commerce Engine, but with an external price, you need to send the request to the [Adding a product to cart](https://emporix.gitbook.io/documentation-portal/api-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) endpoint.\
Provide the customer cart's ID in the `cartId` path parameter.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/items?siteCode=string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "itemYrn": "urn:yaas:saasag:caasproduct:product:mytenant;1600A016BF",
    "price": {
      "priceId": "{priceId}",
      "effectiveAmount": 2,
      "originalAmount": 2,
      "currency": "EUR"
    },
    "quantity": 1,
    "itemType": "EXTERNAL",
    "tax": {
      "name": "STANDARD",
      "rate": 10,
      "grossValue": 2,
      "netValue": 1.82
    }
  }'
```

Notice the `"itemType": "EXTERNAL"` definition which allows the Cart Service to overwrite the pricing from Commerce Engine. The payload must include the price and tax information.

{% hint style="danger" %}
When you have enabled external pricing, it's essential to ensure the accuracy of the prices, as CE does not perform price validation in these instances.
{% endhint %}

# How to add a product from an external source to a cart

For some cases, you might want to allow adding products from an external system to cart, and not only from your online store. The products from external product management sources can be added directly to the customer's cart, bypassing the standard product catalog.

{% hint style="warning" %}
To achieve the communication between Commerce Engine and the external product management tool, you have to configure both systems accordingly. The steps required for such a case are described in the [External Products, Pricing and Fees](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) documentation.\
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

To add a product outside Commerce Engine, you need to send the request to the Adding a product to cart endpoint.\
Provide the customer cart's ID in the `cartId` path parameter. The payload has to include the `"itemType" : "EXTERNAL"` parameter, as well as the price and tax information.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/items?siteCode=string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "itemYrn": "{productYrn}",
    "price": {
      "priceId": "{priceId}",
      "effectiveAmount": 1239,
      "originalAmount": 1239,
      "currency": "EUR"
    },
    "quantity": 1,
    "itemType": "EXTERNAL",
    "product": {
      "id": "ip15p",
      "name": "iPhone 15 pro",
      "description": "Apple iPhone 15 pro 128gb natural titanium",
      "sku": "testSku",
    },
    " tax": {
      "name": "STANDARD",
      "rate": 19,
      "grossValue": 1239,
      "netValue": 1041.18
    }
  }'
```

# How to add an external fee

For some cases, you might need to calculate and charge additional fees, for example for packaging, freight, or any additional reasons. The fees calculated externally can be added directly to the customer's cart.

{% hint style="warning" %}
To achieve the communication between Commerce Engine and the fee management tool, you have to configure both systems accordingly. The steps required for such a case are described in the [External Products, Pricing and Fees](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) documentation.\
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

To add a custom fee to the cart, you need to send the request to the [Adding a product to cart](https://emporix.gitbook.io/documentation-portal/api-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) endpoint.\
Provide the customer cart's ID in the `cartId` path parameter. Custom fee can be configured both for EXTERNAL and INTERNAL products, the payload should include the `"itemType" : "EXTERNAL"` or `"itemType" : "INTERNAL"` parameter. If the parameter is not provided, then "INTERNAL" is taken as default.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}/items?siteCode=string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "itemYrn": "{productYrn}",
    "price": {
      "priceId": "{priceId}",
      "effectiveAmount": 0.3582,
      "originalAmount": 0.3582,
      "currency": "EUR"
    },
    "quantity": 6,
    "itemType": "EXTERNAL",
    "externalFees": [
      {
        "name": {
          "en": "Freight Fee"
        },
        "feeType": "ABSOLUTE",
        "feeAbsolute": {
          "amount": 2.13,
          "currency": "EUR"
        }
      }
    ]
  }'
```
# How to apply an external discount on an item level

Adding an external discount to an item in a cart is done with the `cart.cart_manage_external_prices` scope. Use the `externalDiscounts` attribute when adding an item to the cart or updating an existing one.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../cart/api-reference/" %}
[api-reference](../cart/api-reference/)
{% endcontent-ref %}


```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/cart/{tenant}/carts/{cartId}/items?siteCode=text' \
  --header 'Authorization: Bearer YOUR_SECRET_TOKEN' \
  --header 'Content-Type: application/json' \
  --data '{
    "externalDiscounts": [
        {
            "id": "ext-discount-001",
            "discountType": "PERCENT",
            "value": 15.00,
            "sequence": 1
        }
    ]
  }'
```


# Pricing calculations

To ensure that both net and gross prices are available, along with clear details on how these values are derived, the Cart Service includes the calculatedPrice field.

At the item level, there's a `calculatedPrice` attribute, which contains detailed price calculations for a specific item. Additionally, a `calculatedPrice` is also available at the cart level, summarizing the price calculations for all items in the cart.

{% hint style="warning" %}
<details>

<summary>See the item level calculation payload example</summary>

```json
"calculatedPrice" : {
      "price" : {
        "netValue" : 100.0,
        "grossValue" : 110.0,
        "taxValue" : 10.0,
        "taxCode" : "STANDARD",
        "taxRate" : 10.0
      },
      "upliftValue" : {
        "netValue" : 30.0,
        "grossValue" : 33.0,
        "taxValue" : 3.0,
        "taxCode" : "STANDARD",
        "taxRate" : 10.0
      },
      "discountedPrice" : {
        "netValue" : 90.0,
        "grossValue" : 99.0,
        "taxValue" : 9.0,
        "taxCode" : "STANDARD",
        "taxRate" : 10.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 10.0,
          "discountType" : "PERCENT"
        } ]
      },
      "fees" : [ {
        "id" : "6793753e7d4bba47e2a99801",
        "type" : "ABSOLUTE",
        "origin": "EXTERNAL",
        "name" : {
          "en" : "Freight Fee"
        },
        "price" : {
          "netValue" : 5.0,
          "grossValue" : 5.0,
          "taxValue" : 0
        },
        "discountedPrice" : {
          "netValue" : 4.5,
          "grossValue" : 4.5,
          "taxValue" : 0.0,
          "appliedDiscounts" : [ {
            "id" : "LS10PTOTAL",
            "value" : 0.5,
            "discountType" : "PERCENT"
          } ]
        }
      } ],
      "totalFee" : {
        "netValue" : 4.5,
        "grossValue" : 4.5,
        "taxValue" : 0.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 0.5,
          "discountType" : "PERCENT"
        } ]
      },
      "totalDiscount" : {
        "calculationType" : "ApplyDiscountBeforeTax",
        "value" : 10.5,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 10.5,
          "discountType" : "PERCENT"
        } ]
      },
      "finalPrice" : {
        "netValue" : 94.5,
        "grossValue" : 103.5,
        "taxValue" : 9.0
      }
    }
```

</details>

<details>

<summary>See the cart level calculation payload example</summary>

```json
  "calculatedPrice" : {
    "price" : {
      "netValue" : 100.0,
      "grossValue" : 110.0,
      "taxValue" : 10.0,
      "taxCode" : "STANDARD",
      "taxRate" : 10.0
    },
    "upliftValue" : {
      "netValue" : 30.0,
      "grossValue" : 33.0,
      "taxValue" : 3.0,
      "taxCode" : "STANDARD",
      "taxRate" : 10.0
    },
    "discountedPrice" : {
      "netValue" : 90.0,
      "grossValue" : 99.0,
      "taxValue" : 9.0,
      "taxCode" : "STANDARD",
      "taxRate" : 10.0,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 10.0,
        "discountType" : "PERCENT"
      } ]
    },
    "totalFee" : {
      "netValue" : 4.5,
      "grossValue" : 4.5,
      "taxValue" : 0.0,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 0.5,
        "discountType" : "PERCENT"
      } ]
    },
    "totalDiscount" : {
      "calculationType" : "ApplyDiscountBeforeTax",
      "value" : 11.22,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 11.22,
        "discountType" : "PERCENT"
      } ]
    },
    "totalShipping" : {
      "netValue" : 6.5,
      "grossValue" : 6.955,
      "taxValue" : 0.455,
      "taxCode" : "REDUCED",
      "taxRate" : 7.0,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 0.72,
        "discountType" : "PERCENT"
      } ]
    },
    "finalPrice" : {
      "netValue" : 101.0,
      "grossValue" : 110.455,
      "taxValue" : 9.455,
       "taxAggregate":
                "lines": [
                    {
                        "netValue" : 96.5,
                        "grossValue" : 103.26,
                        "taxValue" : 6.76,
                        "taxCode" : "REDUCED",
                        "taxRate" : 7.0
                    },
                    {
                        "netValue" : 263.19,
                        "grossValue" : 313.2,
                        "taxValue" : 50.01,
                        "taxCode" : "STANDARD",
                        "taxRate" : 19.0
                    },
                    {
                        "netValue" : 9.0,
                        "grossValue" : 9.0,
                        "taxValue" : 0.0
                    }
                ]
            }
  }
```

</details>
{% endhint %}

This calculation method provides a comprehensive breakdown of prices, including net values, gross values, tax details, fees, and discounts, both at the cart level and for individual line items.

{% hint style="warning" %}
<details>

<summary>See the full payload example</summary>

```json
{
  "id" : "67b73cf5e4081e623d81fa47",
  "yrn" : "urn:yaas:hybris:cart:cart:b2b2cstage;67b73cf5e4081e623d81fa47",
  "customerId" : "45620894",
  "currency" : "EUR",
  "siteCode" : "GrossSite",
  "type" : "shopping",
  "channel" : {
    "name" : "storefront",
    "source" : "https://your-storefront.com/"
  },
  "items" : [ {
    "id" : "0",
    "type" : "INTERNAL",
    "itemYrn" : "urn:yaas:saasag:caasproduct:product:b2b2cstage;samsung-galaxy-s27-gross",
    "quantity" : 2.0,
    "effectiveQuantity" : 2.0,
    "unitPrice" : {
      "netValue" : 46.22,
      "grossValue" : 55.0,
      "taxValue" : 8.78,
      "taxCode" : "STANDARD",
      "taxRate" : 19.0
    },
    "couponDiscounts" : [ {
      "couponId" : "LS10PTOTAL",
      "value" : 11.0
    } ],
    "calculatedPrice" : {
      "price" : {
        "netValue" : 92.44,
        "grossValue" : 110.0,
        "taxValue" : 17.56,
        "taxCode" : "STANDARD",
        "taxRate" : 19.0
      },
      "discountedPrice" : {
        "netValue" : 83.19,
        "grossValue" : 99.0,
        "taxValue" : 15.81,
        "taxCode" : "STANDARD",
        "taxRate" : 19.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 11.0,
          "discountType" : "PERCENT"
        } ]
      },
      "totalDiscount" : {
        "calculationType" : "ApplyDiscountAfterTax",
        "value" : 11.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 11.0,
          "discountType" : "PERCENT"
        } ]
      },
      "finalPrice" : {
        "netValue" : 83.19,
        "grossValue" : 99.0,
        "taxValue" : 15.81,
        "taxCode" : "STANDARD",
        "taxRate" : 19.0
      }
    }
  }, {
    "id" : "1",
    "type" : "EXTERNAL",
    "itemYrn" : "urn:yaas:saasag:caasproduct:product:b2b2cstage;samsung-galaxy-s24-gross",
    "quantity" : 1.0,
    "effectiveQuantity" : 1.0,
    "couponDiscounts" : [ {
      "couponId" : "LS10PTOTAL",
      "value" : 11.2
    } ],
    "calculatedPrice" : {
      "price" : {
        "netValue" : 100.0,
        "grossValue" : 107.0,
        "taxValue" : 7.0,
        "taxCode" : "REDUCED",
        "taxRate" : 7.0
      },
      "upliftValue" : {
        "netValue" : 30.0,
        "grossValue" : 32.1,
        "taxValue" : 2.1,
        "taxCode" : "REDUCED",
        "taxRate" : 7.0
      },
      "discountedPrice" : {
        "netValue" : 90.0,
        "grossValue" : 96.3,
        "taxValue" : 6.3,
        "taxCode" : "REDUCED",
        "taxRate" : 7.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 10.7,
          "discountType" : "PERCENT"
        } ]
      },
      "fees" : [ {
        "id" : "67b73d01e4081e623d81fa48",
        "type" : "ABSOLUTE",
        "origin" : "EXTERNAL",
        "name" : {
          "en" : "Freight Fee"
        },
        "price" : {
          "netValue" : 5.0,
          "grossValue" : 5.0,
          "taxValue" : 0.0
        },
        "discountedPrice" : {
          "netValue" : 4.5,
          "grossValue" : 4.5,
          "taxValue" : 0.0,
          "appliedDiscounts" : [ {
            "id" : "LS10PTOTAL",
            "value" : 0.5,
            "discountType" : "PERCENT"
          } ]
        }
      } ],
      "totalFee" : {
        "netValue" : 4.5,
        "grossValue" : 4.5,
        "taxValue" : 0.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 0.5,
          "discountType" : "PERCENT"
        } ]
      },
      "totalDiscount" : {
        "calculationType" : "ApplyDiscountAfterTax",
        "value" : 11.2,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 11.2,
          "discountType" : "PERCENT"
        } ]
      },
      "finalPrice" : {
        "netValue" : 94.5,
        "grossValue" : 100.8,
        "taxValue" : 6.3
      }
    }
  }, {
    "id" : "2",
    "type" : "EXTERNAL",
    "product" : {
      "id" : "myTestId",
      "sku" : "sku",
      "name" : "myExternalProduct",
      "description" : "testExternalProduct",
      "images" : [ {
        "id" : "imageid",
        "url" : "imageURL"
      } ]
    },
    "quantity" : 2.0,
    "effectiveQuantity" : 2.0,
    "unitPrice" : {
      "netValue" : 100.0,
      "grossValue" : 119.0,
      "taxValue" : 19.0,
      "taxCode" : "STANDARD",
      "taxRate" : 19.0
    },
    "couponDiscounts" : [ {
      "couponId" : "LS10PTOTAL",
      "value" : 24.3
    } ],
    "calculatedPrice" : {
      "price" : {
        "netValue" : 200.0,
        "grossValue" : 238.0,
        "taxValue" : 38.0,
        "taxCode" : "STANDARD",
        "taxRate" : 19.0
      },
      "discountedPrice" : {
        "netValue" : 180.0,
        "grossValue" : 214.2,
        "taxValue" : 34.2,
        "taxCode" : "STANDARD",
        "taxRate" : 19.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 23.8,
          "discountType" : "PERCENT"
        } ]
      },
      "fees" : [ {
        "id" : "67b73d04e4081e623d81fa49",
        "type" : "ABSOLUTE",
        "origin" : "EXTERNAL",
        "name" : {
          "en" : "Freight Fee"
        },
        "price" : {
          "netValue" : 5.0,
          "grossValue" : 5.0,
          "taxValue" : 0.0
        },
        "discountedPrice" : {
          "netValue" : 4.5,
          "grossValue" : 4.5,
          "taxValue" : 0.0,
          "appliedDiscounts" : [ {
            "id" : "LS10PTOTAL",
            "value" : 0.5,
            "discountType" : "PERCENT"
          } ]
        }
      } ],
      "totalFee" : {
        "netValue" : 4.5,
        "grossValue" : 4.5,
        "taxValue" : 0.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 0.5,
          "discountType" : "PERCENT"
        } ]
      },
      "totalDiscount" : {
        "calculationType" : "ApplyDiscountAfterTax",
        "value" : 24.3,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 24.3,
          "discountType" : "PERCENT"
        } ]
      },
      "finalPrice" : {
        "netValue" : 184.5,
        "grossValue" : 218.7,
        "taxValue" : 34.2
      }
    }
  } ],
  "discounts" : [ {
    "id" : "0",
    "code" : "LS10PTOTAL",
    "currency" : "EUR",
    "discountRate" : 10.0,
    "name" : "LS10PTOTAL",
    "calculationType" : "ApplyDiscountBeforeTax",
    "valid" : true,
    "links" : [ {
      "rel" : "validate",
      "title" : "Coupon Validation",
      "href" : "https://api-stage.emporix.io/caas-coupon/b2b2cstage/coupons/LS10PTOTAL/validation",
      "type" : "application/json"
    }, {
      "rel" : "redeem",
      "title" : "Coupon Redemption",
      "href" : "https://api-stage.emporix.io/caas-coupon/b2b2cstage/coupons/LS10PTOTAL/redemptions",
      "type" : "application/json"
    } ],
    "discountType" : "PERCENT",
    "discountCalculationType" : "TOTAL",
    "categoryRestricted" : false
  } ],
  "totalUnitsCount" : 5.0,
  "metadata" : {
    "createdAt" : "2025-02-20T14:32:45.290134Z",
    "modifiedAt" : "2025-02-20T14:32:45.290155Z",
    "version" : 3
  },
  "totalTax" : {
    "amount" : 0.0,
    "currency" : "EUR"
  },
  "leadTime" : 0,
  "calculatedPrice" : {
    "price" : {
      "netValue" : 392.44,
      "grossValue" : 455.0,
      "taxValue" : 62.56
    },
    "upliftValue" : {
      "netValue" : 30.0,
      "grossValue" : 32.1,
      "taxValue" : 2.1,
      "taxCode" : "REDUCED",
      "taxRate" : 7.0
    },
    "discountedPrice" : {
      "netValue" : 353.19,
      "grossValue" : 409.5,
      "taxValue" : 56.31,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 45.5,
        "discountType" : "PERCENT"
      } ]
    },
    "totalFee" : {
      "netValue" : 9.0,
      "grossValue" : 9.0,
      "taxValue" : 0.0,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 1.0,
        "discountType" : "PERCENT"
      } ]
    },
    "totalDiscount" : {
      "calculationType" : "ApplyDiscountAfterTax",
      "value" : 47.27,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 47.27,
        "discountType" : "PERCENT"
      } ]
    },
    "totalShipping" : {
      "netValue" : 6.5,
      "grossValue" : 6.96,
      "taxValue" : 0.46,
      "taxCode" : "REDUCED",
      "taxRate" : 7.0,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 0.77,
        "discountType" : "PERCENT"
      } ]
    },
    "finalPrice" : {
      "netValue" : 368.69,
      "grossValue" : 425.46,
      "taxValue" : 56.77,
      "taxAggregate" : {
        "lines" : [ {
          "netValue" : 96.5,
          "grossValue" : 103.26,
          "taxValue" : 6.76,
          "taxCode" : "REDUCED",
          "taxRate" : 7.0
        }, {
          "netValue" : 263.19,
          "grossValue" : 313.2,
          "taxValue" : 50.01,
          "taxCode" : "STANDARD",
          "taxRate" : 19.0
        }, {
          "netValue" : 9.0,
          "grossValue" : 9.0,
          "taxValue" : 0.0
        } ]
      }
    }
  }
}
```

</details>
{% endhint %}

# Pricing calculations glossary

# Calculated price on item level

<table data-full-width="false"><thead><tr><th>Term</th><th>Definition</th></tr></thead><tbody><tr><td><code>price</code></td><td><p>A unit price from <code>priceMatch</code>, it's multiplied by item quantity.</p><pre><code>{
  "calculatedPrice": {
    "price": {
      "netValue": 100.0,
      "grossValue": 110.0,
      "taxValue": 10.0,
      "taxCode": "STANDARD",
      "taxRate": 10.0
    }
    //...
  }
}
</code></pre></td></tr><tr><td><code>upliftValue</code></td><td><p>An additional amount authorized for payment to cover potential price adjustments during packing of weight-based products. There are two conditions to have this value for an item line:</p><ul><li>The item has to be added to the cart with the <code>"weightDependent":true</code> attribute. It means that the quantity may vary during packaging, as some items, for example a case of bananas, cannot be divided to precisely match a given weight.</li><li>The tenant has to have the percentage uplift defined - <code>authorizedAmountUplift</code>, for example 0,1=10%. If the item <code>price.netValue=12</code>, the <code>upliftValue.netValue=1,2</code> with the 10% uplift configured. If the upliftValue is not configured for an item, it's not returned in the response.</li></ul><pre><code>{
  "calculatedPrice": {
    //...
    "upliftValue" : {
        "netValue" : 30.0,
        "grossValue" : 33.0,
        "taxValue" : 3.0,
        "taxCode" : "STANDARD",
        "taxRate" : 10.0
      },
    //...
  }
}
</code></pre></td></tr><tr><td><code>discountedPrice</code></td><td><p>The price of the line item is calculated as unit price × quantity, with any applied discounts. If no discounts are applied to a given line item, this attribute is not included in the response. Depending on the site configuration, the <code>includesTax</code> attribute can be <code>true</code> or <code>false</code>. The discount is applied to <code>price.grossValue</code> when <code>includesTax=true</code> or <code>price.netValue</code> when <code>includesTax=false</code>. Based on this, the corresponding <code>netValue</code> or <code>grossValue</code> is recalculated using the <code>taxRate</code>. The calculation method that was used is indicated in <code>totalDiscount.calculationType</code>, which can be either <code>ApplyDiscountAfterTax</code> or <code>ApplyDiscountBeforeTax</code>.</p><pre><code>{
  "calculatedPrice": {
    //...
    "discountedPrice" : {
          "netValue" : 4.5,
          "grossValue" : 4.5,
          "taxValue" : 0.0,
          "appliedDiscounts" : [ {
            "id" : "LS10PTOTAL",
            "value" : 0.5,
            "discountType" : "PERCENT"
          } ]
        },
    //...
  }
}
</code></pre></td></tr><tr><td><code>totalDiscount</code></td><td><p>A summary of all discounts applied to the line, including discounts on both the line item's price and its fees. If there are no discounts applied on the line item, it's not returned in the response.</p><pre><code>{
  "calculatedPrice": {
    //...
    "totalDiscount" : {
        "calculationType" : "ApplyDiscountBeforeTax",
        "value" : 10.5,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 10.5,
          "discountType" : "PERCENT"
        } ]
      },
    //...
  }
}
</code></pre></td></tr><tr><td><code>fees</code></td><td><p>A list of fees applied to the line item. If there are no fees on the line item, it's not returned in the response.</p><ul><li><p>Types of fees:</p><ul><li>PERCENT - The fee percentage of the line item <code>price.netValue</code> - unit price x quantity.</li><li>ABSOLUTE - The absolute amount assigned to the item line.</li><li>ABSOLUTE_MULTIPLY_ITEMQUANTITY - Monetary amount multiplied by the item quantity and assigned to the item line.</li></ul></li><li><p>Fees origin:</p><ul><li><code>INTERNAL</code> - Defined in commerce engine</li><li><code>EXTERNAL</code> - Specified when an item is added to the cart.</li></ul></li><li><p><code>netValue</code> - Monetary amount of the fee. Depends on the fee type:</p><ul><li>ABSOLUTE - The value of the defined fee's <code>feeAbsolute.amount</code> attribute.</li><li>ABSOLUTE_MULTIPLY_ITEMQUANTITY - The value of the defined fee's <code>feeAbsolute.amount</code> attribute multiplied by the quantity of the line item.</li><li>PERCENT - The defined fee level percentage (<code>feePercentage</code> attribute) of the line item <code>price.netValue</code>.</li></ul></li><li><code>grossValue</code> - Value calculated based on the <code>taxCode</code> and the <code>taxRate</code> if <code>taxable=true</code>. For a fee that is <code>taxable=true</code> and has a correct <code>taxCode</code>, the <code>taxRate</code> defined for that <code>taxCode</code> is used to calculate the <code>grossValue</code>. If the fee is not taxable, the <code>netValue</code> is equal to <code>grossValue</code>.</li><li><code>taxRate</code> - If a fee is defined with the attribute <code>taxable=true</code>, the tax rate is calculated based on the provided <code>taxCode</code> at the fee level. A taxable fee must have a defined <code>taxCode</code>.</li><li><code>taxCode</code> - Tax code defined on the fee level, for example STANDARD. The value should match the available tax codes in the system configuration.</li></ul><pre><code>{
  "calculatedPrice": {
    //...
    "fees" : [ {
        "id" : "6793753e7d4bba47e2a99801",
        "type" : "ABSOLUTE",
        "origin": "EXTERNAL",
        "name" : {
          "en" : "Freight Fee"
        },
        "price" : {
          "netValue" : 5.0,
          "grossValue" : 5.0,
          "taxValue" : 0
        },
        "discountedPrice" : {
          "netValue" : 4.5,
          "grossValue" : 4.5,
          "taxValue" : 0.0,
          "appliedDiscounts" : [ {
            "id" : "LS10PTOTAL",
            "value" : 0.5,
            "discountType" : "PERCENT"
          } ]
        }
      } ],
    //...
  }
}
</code></pre></td></tr><tr><td><code>totalFee</code></td><td><p>Sum of all fees applied to the line item. It's calculated by summarizing <code>fees[].discountedPrice</code> if any discounts were applied to the fee, or <code>fees[].price</code> for a a not discounted fee.</p><pre><code>{
  "calculatedPrice": {
    //...
    "totalFee" : {
        "netValue" : 4.5,
        "grossValue" : 4.5,
        "taxValue" : 0.0,
        "appliedDiscounts" : [ {
          "id" : "LS10PTOTAL",
          "value" : 0.5,
          "discountType" : "PERCENT"
        } ]
      },
    //...
  }
}
</code></pre></td></tr><tr><td><code>calculationType</code></td><td><p>Indicates whether discounts were applied to net or gross values.</p><ul><li>The discount is applied to either <code>price.grossValue</code>, when <code>includesTax=true</code>, or <code>price.netValue</code>, when <code>includesTax=false</code>. Based on this, the corresponding net or gross value is recalculated using the tax rate.</li><li>The calculation method used is indicated in <code>totalDiscount.calculationType</code>>, which can be either <code>ApplyDiscountAfterTax</code> or <code>ApplyDiscountBeforeTax</code>.</li></ul><pre><code>{
  "calculatedPrice": {
    //...
    "totalDiscount" : {
        "calculationType" : "ApplyDiscountBeforeTax",
    //...
  }
}
</code></pre></td></tr><tr><td><code>finalPrice</code></td><td><p>The final price is the sum of the <code>discountedPrice</code> or the original price, depending on whether any discounts were applied to the line item, and the <code>totalFee</code>, which includes all fees applied to the line item.</p><pre><code>{
  "calculatedPrice": {
    //...
    "finalPrice" : {
        "netValue" : 94.5,
        "grossValue" : 103.5,
        "taxValue" : 9.0
      }
  }
}
</code></pre></td></tr></tbody></table>

# Calculated price on cart level

<table data-full-width="false"><thead><tr><th>Term</th><th>Definition</th></tr></thead><tbody><tr><td><code>price</code></td><td><p>A sum of all line item prices without discounts.</p><pre><code>{
  "calculatedPrice": {
    "price" : {
      "netValue" : 100.0,
      "grossValue" : 110.0,
      "taxValue" : 10.0,
      "taxCode" : "STANDARD",
      "taxRate" : 10.0
    },
    //...
  }
}
</code></pre></td></tr><tr><td><code>discountedPrice</code></td><td><p>The sum of all line item prices after discounts. This attribute is included in the response if at least one line item has a discounted price. It represents the total of discounted prices for line items with discounts applied, or the regular prices for line items without discounts. Ultimately, it reflects the total cost of all line items after discounts.</p><pre><code>{
  "calculatedPrice": {
    //...
    "discountedPrice" : {
      "netValue" : 90.0,
      "grossValue" : 99.0,
      "taxValue" : 9.0,
      "taxCode" : "STANDARD",
      "taxRate" : 10.0,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 10.0,
        "discountType" : "PERCENT"
      } ]
    },
    //...
  }
}
</code></pre></td></tr><tr><td><code>totalShipping</code></td><td><p>The calculated shipping cost. It takes the sum of <code>items[].calculatedPrice.price.grossValue</code> for shipping estimation.</p><pre><code>{
  "calculatedPrice": {
    //...
    "totalShipping" : {
      "netValue" : 6.5,
      "grossValue" : 6.955,
      "taxValue" : 0.455,
      "taxCode" : "REDUCED",
      "taxRate" : 7.0,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 0.72,
        "discountType" : "PERCENT"
      } ]
    },
    //...
  }
}
</code></pre></td></tr><tr><td><code>paymentFees</code></td><td>A list of payment fees applied to an order. This field is only available after checkout, as payment is not processed in the shopping cart. Payment fees are not discounted even if discount/coupon is set to TOTAL.</td></tr><tr><td><code>totalDiscount</code></td><td><p>A summary of all discounts. It's the sum of all <code>lines[].totalDiscount</code> and shipping discounts.</p><pre><code>{
  "calculatedPrice": {
    //...
     "totalDiscount" : {
      "calculationType" : "ApplyDiscountBeforeTax",
      "value" : 11.22,
      "appliedDiscounts" : [ {
        "id" : "LS10PTOTAL",
        "value" : 11.22,
        "discountType" : "PERCENT"
      } ]
    },
    //...
  }
}
</code></pre></td></tr><tr><td><code>finalPrice</code></td><td><p>The final price is the sum of <code>items[].finalPrice</code>, <code>totalShipping</code> and <code>paymentFee</code>.</p><pre><code>{
  "calculatedPrice": {
    //...
    "finalPrice" : {
      "netValue" : 101.0,
      "grossValue" : 110.455,
      "taxValue" : 9.455
    //...
    }
  }
}
</code></pre></td></tr><tr><td><code>taxAggregate</code> - <code>lines</code></td><td><p>A list of tax values grouped by <code>taxCode</code> and <code>taxRate</code>. It includes the sum of <code>item[].calculatedPrice.discountedPrice</code> or <code>item[].calculatedPrice.price</code>, <code>item[].calculatedPrice.fees[].discountedPrice</code> or <code>item[].calculatedPrice.fees[].price</code>, <code>calculatedPrice.totalShipping</code> and <code>calculatedPrice.paymentFees</code>. If any of these values have the same <code>taxRate</code> but different <code>taxCode</code>, they are listed separately. The aggregation also includes items that do not have a <code>taxRate</code> or <code>taxCode</code> defined.</p><pre><code>{
  "finalPrice": {
    //...
    "taxAggregate" : {
        "lines" : [ {
          "netValue" : 96.5,
          "grossValue" : 103.26,
          "taxValue" : 6.76,
          "taxCode" : "REDUCED",
          "taxRate" : 7.0
        }, {
          "netValue" : 263.19,
          "grossValue" : 313.2,
          "taxValue" : 50.01,
          "taxCode" : "STANDARD",
          "taxRate" : 19.0
        }, {
          "netValue" : 9.0,
          "grossValue" : 9.0,
          "taxValue" : 0.0
        } ]
      }
    //...
  }
}
</code></pre></td></tr></tbody></table>

See the sections below for shipping, payment fee, tax and discounts calculations.

# How is shipping calculated

The shipping calculation depends on the stage at which it is done.

* In the cart, where the address, delivery method, and zone are not available yet, the calculation uses the minimum shipping estimation. At this stage, `sites.homeBase.Address` is used as the `shipFromAddress`, and the `shipToAddress` is created based on the cart’s `countryCode` and `zipCode`.\
  See the [Calculating the minimum shipping costs](https://emporix.gitbook.io/documentation-portal/api-references/delivery-and-shipping/shipping/api-reference/shipping-cost#post-shipping-tenant-site-quote-minimum) endpoint.
* In the checkout, where information about the delivery window and zone is already available, the calculation uses the following endpoints: [Calculating the final shipping cost](https://emporix.gitbook.io/documentation-portal/api-references/delivery-and-shipping/shipping/api-reference/shipping-cost#post-shipping-tenant-site-quote), or [Calculating the shipping cost for a given slot](https://emporix.gitbook.io/documentation-portal/api-references/delivery-and-shipping/shipping/api-reference/shipping-cost#post-shipping-tenant-site-quote-slot) accordingly.

{% hint style="danger" %}
Always make sure that your site’s `homeBase.address` has the `country` and `zip-code` information included. It's mandatory for shipping calculations.
{% endhint %}

# How to calculate a payment fee at cart level

At the cart level, only one additional fee is calculated, apart from the fees applied at the item level. The `paymentFees` is an additional, non-discountable amount that the customer must pay for using a given payment method.

The fee has a specific format, and there are two options for calculating it:

* ABSOLUTE - the value of defined fee’s attribute `feeAbsolute.amount`, where the amount is treated as `netValue`.
* PERCENT - the fee is calculated as a percentage of the total net value of all item lines' `finalPrice.netValue`, plus the cart’s `calculatedPrice.totalShipping.netValue`. The fee is specified by the `feePercentage` attribute.

If the fee is taxable and has a tax code, the gross value is calculated. Otherwise, the `grossValue` is equal to `netValue`.

# How to determine a tax country at cart level

Since the shipping address is not set in the cart, you need to determine the country to find the `taxRate` for a fee that has a `taxCode` only.\
Ways to find the country data:

* Use the country code that is set on the cart
* If the cart has a customer, check the customer addresses, based on site’s setting `taxDeterminationBasedOn`:
  * SHIPPING\_ADDRESS - use the address that is tagged with `SHIPPING`, select the default address or the first match.
  * BILLING\_ADDRESS - use the address that is tagged with `BILLING`, select the default address or the first match.\
    If the matching address is not found, return an error.
* Get country code from site’s `homeBase.address.country`.

# How to apply discounts at cart level

Discounts are known as coupons and, with the relevant settings that influence `calculatedPrice`, they can be applied to a cart.

Depending on the site configuration and the `includesTax=true/false`, the discount is applied to either the gross value - `includesTax=true`, or the net value - `includesTax=false`.\
Based on this setting, the corresponding `netValue` or `grossValue` is recalculated using the tax rate.

The information about which calculation method was used is available in `totalDiscount.calculationType=ApplyDiscountAfterTax/ApplyDiscountBeforeTax`:

* `discountCalculationType`:
  * SUBTOTAL - the discounts are applied on `items[].calculatedPrice.price`. The line item fees and shipping cost are **NOT** discounted.
  * TOTAL - the discounts are applied on `items[].calculatedPrice.price`, the line item fees and shipping cost.
*   `discountType`:

    * ABSOLUTE - a coupon that has a given type must have `discountAbsolute` attribute configured. It represents a monetary amount that should be discounted.

    Depending on the `ApplyDiscountAfterTax/ApplyDiscountBeforeTax` discount, the absolute amount is subtracted either from the `grossValue` or the `netValue`.\
    The value of the discount on the cart level is divided across all the applicable cart prices, proportionally to the `items[].calculatedPrice.price`, `items[].calculatedPrice.fees[].price` and the calculated shipping cost. It's related to the difference between `discountCalculationType:SUBTOTAL/TOTAL` described above, to know which items are applicable.

    * PERCENT - it takes the value of discount’s `discountPercentage` attribute and calculates the percentage discount to the price.
    * FREE\_SHIPPING - this type of a discount fully discounts the price of the `calculatedPrice.totalShipping`. It's applied before any other discount is applied.
* `categoryRestricted` - the discount applies only to the line items that belong to a specific category. If the `discountCalculationType=TOTAL`, a fee of an item that fulfills the restriction is discounted. However, any other fees, or shipping are not part of the discounting.
* `segmentRestricted` - the discount is applied only to the line items that belong to the given customer segment.

Since the system can be configured to allow more than one discount to a cart, it has a few implications:

* The `FREE_SHIPPING` discount is applied on the shipping first.
* The rest of the discounts are applied based on the order the discounts were applied to the cart.
* Every PERCENT discount is calculated based on the original price, without applied discounts. Applying two coupons of 10% to 15.0 value results in 12.0 discounted price and two applied discounts of 1,5 value.
* Every ABSOLUTE discount uses the not discounted values for the discount value spread. It means that if the given applicable item is already fully discounted, the remaining amount of the discount is spread proportionally on the discounts that still have some value left.

{% hint style="warning" %}
Check the [System Preferences](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/management-dashboard/settings/system-preferences) documentation for coupons settings related to the number of discounts.
{% endhint %}

For some cases, you might need to calculate and charge additional fees, for example for packaging, freight, or any additional reasons. The fees calculated externally can be added directly to the customer's cart.

To achieve the communication between Commerce Engine and the fee management tool, you have to configure both systems accordingly. The steps required for such a case are described in the [External Products, Pricing and Fees](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) documentation. You need to generate a dedicated scope that serves as the authorization token for the API calls.

To add a custom fee to the cart, you need to send the request to the endpoint. Provide the customer cart's ID in the cartId path parameter. The payload has to include the "itemType" : "EXTERNAL" parameter - see the [Adding a product to a cart](https://emporix.gitbook.io/documentation-portal/api-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) documentation.

# How to apply separation of the same line items in the cart

When you add an item to the cart, it's stored as a single line. If you add the same item multiple times, it remains a single line item, but the `quantity` attribute is updated to reflect the total amount, for example  when you add 5 items they are stored as `item1: productA, qty:5`. 

If you need to add the same item multiple times on separate lines in the cart, use the `keepAsSeparateLineItem=true` flag - it ensures each instance of the item appears as a distinct line item. This can be useful in a variety of scenarios, such as applying different discounts or fees to the same product, or handling separate delivery options.

A common use case is the *Buy 2, Get 1 Free* promotion. In this case, when a customer adds two of the same line items to the cart, the system can add a third instance as a separate line item marked as free.

Using the `keepAsSeparateLineItem=true` flag stores each addition of the product as an individual line, while the `keepAsSeparateLineItem=false` keeps them all in one.

By default, all items are grouped into a single line in the cart. This behavior is defined by `keepAsSeparateLineItem=false`. However, even if the `keepAsSeparateLineItem` flag is not explicitly included in the payload, the system assumes this default behavior. In other words, unless stated otherwise, `keepAsSeparateLineItem=false` is always applied.

**Adding the `keepAsSeparateLineItem":true` flag to the payload example**:

```json
{
    "itemYrn": "urn:yaas:saasag:caasproduct:product:b2b2cstage;samsung-galaxy-s24-gross",
    "keepAsSeparateLineItem":true,
    "price": {
        "priceId": "679ca63dbcdefe5b380c98bc",
        "effectiveAmount": 550,
        "originalAmount": 550,
        "currency": "EUR"
    },
}
```

## Usage examples

**Adding multiple `productA` items with the `keepAsSeparateLineItem=true` flag:**

  1. Adding the first `productA` item with `keepAsSeparateLineItem=true` results in:

  <code> item0: productA, qty:1, keepAsSeparateLineItem=true</code>


  2. Adding another `productA` item with `keepAsSeparateLineItem=true` results in:

    ```json
      item0: productA, qty:1, keepAsSeparateLineItem=true
      item1: productA, qty:1, keepAsSeparateLineItem=true 
    ```

**Adding multiple `productA` items with the `keepAsSeparateLineItem=false` flag:**

  1. Adding the first `productA` item with `keepAsSeparateLineItem=false` results in:

    ```json
      item0: productA, qty:1, keepAsSeparateLineItem=false
    ```

  2. Adding another `productA` item with `keepAsSeparateLineItem=false` results in:

    ```json
      item0: productA, qty:2, keepAsSeparateLineItem=false
    ```

**Adding multiple `productA` items with the `keepAsSeparateLineItem=true` and `keepAsSeparateLineItem=false` flags**

  1. Adding the first `productA` item with two different flags results in:

    ```json
      item0: productA, qty:1, keepAsSeparateLineItem=true 
      item2: productA, qty:1, keepAsSeparateLineItem=false 
    ```

  2. Adding another two `productA` items with different flags results in:

    ```json
      item0: productA, qty:1, keepAsSeparateLineItem=true 
      item1: productA, qty:1, keepAsSeparateLineItem=true 
      item2: productA, qty:2, keepAsSeparateLineItem=false 
  ```

**Products with external prices**

  You can add external prices for both custom products and products from the internal catalog. Line items for the same product can have different prices if they’re added separately with `keepAsSeparateLineItem=true`.

  For example:

  1. Adding the first `productA` item with `priceX` and `keepAsSeparateLineItem=true` results in:

    ```json
      item0: productA, external, priceX, qty:1, keepAsSeparateLineItem=true 
    ```

  2. Adding another `productA` item to it, but with `priceY` and `keepAsSeparateLineItem=true` results in:

    ```json
      item0: productA, external, priceX, qty:1, keepAsSeparateLineItem=true 
      item1: productA, external, priceY, qty:1, keepAsSeparateLineItem=true 
    ```

**Products with standard prices**

  When using internal prices, the `priceId` is the same across all line items - if the product uses a standard price from the catalog, all lines for that item are expected to have the same price.

  For example:

  1. Adding the first `productA` item with `priceX` and `keepAsSeparateLineItem=true` results in:

    ```json
      item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=true 
    ```

  2. Adding another `productA` item with different `priceY` and `keepAsSeparateLineItem=true` results in:

    ```json
      item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=true 
      item1: productA, internal, priceY, qty:1, keepAsSeparateLineItem=true 
    ```

  * If `cartItemValidationSkipExistingItemsValidationOnAddToCart=false`, the validation occurs, and an error is thrown due to the price mismatch.

  * If `cartItemValidationSkipExistingItemsValidationOnAddToCart=true`, the validation does not occur, and the cart accepts the new line item.

  {% hint style="warning" %}
  When the cart item validation is not executed on `add to cart`, you can use the [cart validation](https://emporix.gitbook.io/documentation-portal/api-references/~/revisions/yWwHvejmTq395ReuRRIQ/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid-validate) endpoint. It should return errors informing that the prices are duplicated.
  
  EXTERNAL pricing products can have different prices in the cart, INTERNAL pricing products can't.
{% hint style="warning" %}

**Adding products with internal and external pricing**

  When you add the same product first as an internal one and then as an external, the items are split into separate line items even if `keepAsSeparateLineItem=false`, or if the flag is not present.

  1. Adding `productA` item, with internal `priceX` and `keepAsSeparateLineItem=false` results in:

    ```json
      item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=false 
    ```

  2. Adding `productA` item to it, with external `priceY` and `keepAsSeparateLineItem=false` results in:

    ```json
      item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=false 
      item0: productA, external, priceY, qty:1, keepAsSeparateLineItem=false
    ```