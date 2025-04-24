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

# cart

import {\
Alert,\
Button,\
OpenApiTryIt,\
ExplainStep\
} from '@redocly/developer-portal/ui';

## Cart Service Tutorials

### How to create a new cart

To create a new cart, you need to send a request to the Creating a new cart endpoint.

### How to add custom attributes to a cart

You can define custom attributes for a cart through `mixins`.

### Define your custom attributes schema

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

### Update a cart with custom attributes

To add custom attributes to a cart, you need to send a request to the Updating a cart endpoint.

\<OpenApiTryIt\
definitionId="cart"\
operationId="PUT-cart-update-cart"\
properties=\{{\
"metadata": {\
"mixins": {\
"cartInstructions": "https://res.cloudinary.com/saas-ag/raw/upload/v1635253083/schemata/CAAS/cartInstructions\_schema.json"\
}\
},\
"mixins": {\
"cartInstructions": {\
"instruction": "It would be nice if you could deliver the order after 5 PM."\
}\
}\
\}}\
/>

### How to merge carts

{% hint style="warning" %}

To learn more about merging carts, check out [Cart merging](https://developer.emporix.io/user-guides/core-commerce/carts/carts#cart-merging) in the Carts guide.

{% endhint %}

To merge an anonymous cart with a customer cart, you need to send a request to the Merging carts endpoint. Provide the customer cart's ID in the `cartId` path parameter and the anonymous cart's ID in the request body.

\<OpenApiTryIt\
definitionId="cart"\
operationId="POST-cart-merge-carts"\
properties=\{{\
"carts": \[\
" "\
]\
\}}\
/>

### How to source pricing information from an external price calculation tool

For B2B scenarios, you might want to integrate an external application for price calculation for your products. Usually, the systems, such as ERPs, store all the relevant customer-specific pricing information needed for customer-specific pricing.
The external system then can communicate with the Cart Service directly to overwrite the price of the product added to the cart.

{% hint style="warning" %}

To achieve the communication between Commerce Engine and the external pricing tool, you have to configure both systems accordingly.
The steps required for such a case are described in the [External Products, Pricing and Fees](https://developer.emporix.io/user-guides/extensibility/extensibility-cases/external-pricing-and-products) documentation.
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

After enabling the external application to update carts with calculated prices, to add a product that is available within Commerce Engine, but with an external price,\
you need to send the request to the Adding a product to cart endpoint.
Provide the customer cart's ID in the `cartId` path parameter.

\<OpenApiTryIt\
definitionId="cart"\
operationId="POST-cart-add-item-to-cart"\
properties=\{{\
"itemYrn": "urn:yaas:saasag:caasproduct:product:mytenant;1600A016BF",\
"itemType": "EXTERNAL",\
"price": {\
"effectiveAmount": 2.0,\
"originalAmount": 2.0,\
"currency": "EUR"\
},\
"tax": {\
"name": "STANDARD",\
"rate": 10,\
"grossValue": 2.0,\
"netValue": 1.82\
},\
"quantity": 1\
\}}\
/>

Notice the `"itemType": "EXTERNAL"` definition which allows the Cart Service to overwrite the pricing from Commerce Engine. The payload must include the price and tax information.

{% hint style="danger" %}\
When you have enabled external pricing, it's essential to ensure the accuracy of the prices, as CE does not perform price validation in these instances.
{% endhint %}

### How to add a product from an external source to a cart

For some cases, you might want to allow adding products from an external system to cart, and not only from your online store. The products from external product management sources can be added directly to the customer's cart, bypassing the standard product catalog.

{% hint style="warning" %}\
To achieve the communication between Commerce Engine and the external product management tool, you have to configure both systems accordingly. The steps required for such a case are described in the [External Products, Pricing and Fees](https://developer.emporix.io/user-guides/extensibility/extensibility-cases/external-pricing-and-products) documentation.
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

To add a product outside Commerce Engine, you need to send the request to the Adding a product to cart endpoint.
Provide the customer cart's ID in the `cartId` path parameter. The payload has to include the `"itemType" : "EXTERNAL"` parameter, as well as the price and tax information.

\<OpenApiTryIt\
definitionId="cart"\
operationId="POST-cart-add-item-to-cart"\
properties=\{{\
"itemType" : "EXTERNAL",\
"product" : {\
"id" : "ip15p",\
"name" : "iPhone 15 pro",\
"description" : "Apple iPhone 15 pro 128gb natural titanium",\
"sku": "testSku",\
"images": \[\
{\
"id": "firstImage",\
"url": "data:image/jpeg;base64,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"\
}\
]\
},\
"price": {\
"effectiveAmount": 1239.00,\
"originalAmount": 1239.00,\
"currency": "EUR"\
},\
" tax": {\
"name": "STANDARD",\
"rate": 19,\
"grossValue": 1239.00,\
"netValue": 1041.18\
},\
"quantity": 1\
\}}\
/>

### How to add an external fee

For some cases, you might need to calculate and charge additional fees, for example for packaging, freight, or any additional reasons. The fees calculated externally can be added directly to the customer's cart.

{% hint style="warning" %}\
To achieve the communication between Commerce Engine and the fee management tool, you have to configure both systems accordingly. The steps required for such a case are described in the [External Products, Pricing and Fees](https://developer.emporix.io/user-guides/extensibility/extensibility-cases/external-pricing-and-products) documentation.
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

To add a custom fee to the cart, you need to send the request to the Adding a product to cart endpoint.
Provide the customer cart's ID in the `cartId` path parameter. The payload has to include the `"itemType" : "EXTERNAL"` parameter.

\<OpenApiTryIt\
definitionId="cart"\
operationId="POST-cart-add-item-to-cart"\
properties=\{{\
"itemType": "EXTERNAL",\
"externalFees": \[\
{\
"name": {\
"en": "Freight Fee"\
},\
"feeType": "ABSOLUTE",\
"feeAbsolute": {\
"amount": 2.13,\
"currency": "EUR"\
}\
}\
]\
\}}\
/>

### Pricing calculations

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

### Pricing calculations glossary

#### Calculated price on item level

| Term              | Definition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ----------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `price`           | <p>A unit price from <code>priceMatch</code>, it's multiplied by item quantity.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `upliftValue`     | <p>An additional amount authorized for payment to cover potential price adjustments during packing of weight-based products. There are two conditions to have this value for an item line:</p><ul><li>The item has to be added to the cart with the <code>"weightDependent":true</code> attribute. It means that the quantity may vary during packaging, as some items, for example a case of bananas, cannot be divided to precisely match a given weight.</li><li>The tenant has to have the percentage uplift defined - <code>authorizedAmountUplift</code>, for example 0,1=10%. If the item <code>price.netValue=12</code>, the <code>upliftValue.netValue=1,2</code> with the 10% uplift configured. If the upliftValue is not configured for an item, it's not returned in the response.</li></ul><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `discountedPrice` | <p>The price of the line item is calculated as unit price × quantity, with any applied discounts. If no discounts are applied to a given line item, this attribute is not included in the response.<br>Depending on the site configuration, the <code>includesTax</code> attribute can be <code>true</code> or <code>false</code>. The discount is applied to <code>price.grossValue</code> when <code>includesTax=true</code> or <code>price.netValue</code> when <code>includesTax=false</code>. Based on this, the corresponding <code>netValue</code> or <code>grossValue</code> is recalculated using the <code>taxRate</code>.<br>The calculation method that was used is indicated in <code>totalDiscount.calculationType</code>, which can be either <code>ApplyDiscountAfterTax</code> or <code>ApplyDiscountBeforeTax</code>.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `totalDiscount`   | <p>A summary of all discounts applied to the line, including discounts on both the line item's price and its fees. If there are no discounts applied on the line item, it's not returned in the response.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `fees`            | <p>A list of fees applied to the line item. If there are no fees on the line item, it's not returned in the response.</p><ul><li><p>Types of fees:</p><ul><li>PERCENT - The fee percentage of the line item <code>price.netValue</code> - unit price x quantity.</li><li>ABSOLUTE - The absolute amount assigned to the item line.</li><li>ABSOLUTE_MULTIPLY_ITEMQUANTITY - Monetary amount multiplied by the item quantity and assigned to the item line.</li></ul></li><li><p>Fees origin:</p><ul><li><code>INTERNAL</code> - Defined in commerce engine</li><li><code>EXTERNAL</code> - Specified when an item is added to the cart.</li></ul></li><li><p><code>netValue</code> - Monetary amount of the fee. Depends on the fee type:</p><ul><li>ABSOLUTE - The value of the defined fee's <code>feeAbsolute.amount</code> attribute.</li><li>ABSOLUTE_MULTIPLY_ITEMQUANTITY - The value of the defined fee's <code>feeAbsolute.amount</code> attribute multiplied by the quantity of the line item.</li><li>PERCENT - The defined fee level percentage (<code>feePercentage</code> attribute) of the line item <code>price.netValue</code>.</li></ul></li><li><code>grossValue</code> - Value calculated based on the <code>taxCode</code> and the <code>taxRate</code> if <code>taxable=true</code>. For a fee that is <code>taxable=true</code> and has a correct <code>taxCode</code>, the <code>taxRate</code> defined for that <code>taxCode</code> is used to calculate the <code>grossValue</code>. If the fee is not taxable, the <code>netValue</code> is equal to <code>grossValue</code>.</li><li><code>taxRate</code> - If a fee is defined with the attribute <code>taxable=true</code>, the tax rate is calculated based on the provided <code>taxCode</code> at the fee level. A taxable fee must have a defined <code>taxCode</code>.</li><li><code>taxCode</code> - Tax code defined on the fee level, for example STANDARD. The value should match the available tax codes in the system configuration.</li></ul><pre><code>          {`{
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
}`}
        
</code></pre> |
| `totalFee`        | <p>Sum of all fees applied to the line item. It's calculated by summarizing <code>fees[].discountedPrice</code> if any discounts were applied to the fee, or <code>fees[].price</code> for a a not discounted fee.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `calculationType` | <p>Indicates whether discounts were applied to net or gross values.</p><ul><li>The discount is applied to either <code>price.grossValue</code>, when <code>includesTax=true</code>, or <code>price.netValue</code>, when <code>includesTax=false</code>. Based on this, the corresponding net or gross value is recalculated using the tax rate.</li><li>The calculation method used is indicated in <code>totalDiscount.calculationType</code>>, which can be either <code>ApplyDiscountAfterTax</code> or <code>ApplyDiscountBeforeTax</code>.</li></ul><pre><code>          {`{
  "calculatedPrice": {
    //...
    "totalDiscount" : {
        "calculationType" : "ApplyDiscountBeforeTax",
    //...
  }
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `finalPrice`      | <p>The final price is the sum of the <code>discountedPrice</code> or the original price, depending on whether any discounts were applied to the line item, and the <code>totalFee</code>, which includes all fees applied to the line item.</p><pre><code>          {`{
  "calculatedPrice": {
    //...
    "finalPrice" : {
        "netValue" : 94.5,
        "grossValue" : 103.5,
        "taxValue" : 9.0
      }
  }
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

#### Calculated price on cart level

| Term                     | Definition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `price`                  | <p>A sum of all line item prices without discounts.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `discountedPrice`        | <p>The sum of all line item prices after discounts. This attribute is included in the response if at least one line item has a discounted price.<br>It represents the total of discounted prices for line items with discounts applied, or the regular prices for line items without discounts. Ultimately, it reflects the total cost of all line items after discounts.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `totalShipping`          | <p>The calculated shipping cost. It takes the sum of <code>items[].calculatedPrice.price.grossValue</code> for shipping estimation.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `paymentFees`            | <p>A list of payment fees applied to an order. This field is only available after checkout, as payment is not processed in the shopping cart.<br>Payment fees are not discounted even if discount/coupon is set to TOTAL.</p>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `totalDiscount`          | <p>A summary of all discounts. It's the sum of all <code>lines[].totalDiscount</code> and shipping discounts.</p><pre><code>          {`{
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
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `finalPrice`             | <p>The final price is the sum of <code>items[].finalPrice</code>, <code>totalShipping</code> and <code>paymentFee</code>.</p><pre><code>          {`{
  "calculatedPrice": {
    //...
    "finalPrice" : {
      "netValue" : 101.0,
      "grossValue" : 110.455,
      "taxValue" : 9.455
    //...
    }
  }
}`}
        
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| `taxAggregate` - `lines` | <p>A list of tax values grouped by <code>taxCode</code> and <code>taxRate</code>. It includes the sum of <code>item[].calculatedPrice.discountedPrice</code> or <code>item[].calculatedPrice.price</code>, <code>item[].calculatedPrice.fees[].discountedPrice</code> or <code>item[].calculatedPrice.fees[].price</code>, <code>calculatedPrice.totalShipping</code> and <code>calculatedPrice.paymentFees</code>. If any of these values have the same <code>taxRate</code> but different <code>taxCode</code>, they are listed separately. The aggregation also includes items that do not have a <code>taxRate</code> or <code>taxCode</code> defined.</p><pre><code>          {`{
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
}`}
        
</code></pre> |

See the sections below for shipping, payment fee, tax and discounts calculations.

### How is shipping calculated

The shipping calculation depends on the stage at which it is done.

* In the cart, where the address, delivery method, and zone are not available yet, the calculation uses the minimum shipping estimation. At this stage, `sites.homeBase.Address` is used as the `shipFromAddress`, and the `shipToAddress` is created based on the cart’s `countryCode` and `zipCode`.
  See the [Calculating the minimum shipping costs](https://developer.emporix.io/docs/openapi/shipping/#operation/POST-shipping-calculate-min-shipping-cost) endpoint.
* In the checkout, where information about the delivery window and zone is already available, the calculation uses the following endpoints: [Calculating the final shipping cost](https://developer.emporix.io/docs/openapi/shipping/#operation/POST-shipping-calculate-shipping-cost), or [Calculating the shipping cost for a given slot](https://developer.emporix.io/docs/openapi/shipping/#operation/POST-shipping-calculate-slot-shipping-cost) accordingly.

{% hint style="danger" %}\
Always make sure that your site’s `homeBase.address` has the `country` and `zip-code` information included. It's mandatory for shipping calculations.
{% endhint %}

### How to calculate a payment fee at cart level

At the cart level, only one additional fee is calculated, apart from the fees applied at the item level. The `paymentFees` is an additional, non-discountable amount that the customer must pay for using a given payment method.

The fee has a specific format, and there are two options for calculating it:

* ABSOLUTE - the value of defined fee’s attribute `feeAbsolute.amount`, where the amount is treated as `netValue`.
* PERCENT - the fee is calculated as a percentage of the total net value of all item lines' `finalPrice.netValue`, plus the cart’s `calculatedPrice.totalShipping.netValue`. The fee is specified by the `feePercentage` attribute.

If the fee is taxable and has a tax code, the gross value is calculated. Otherwise, the `grossValue` is equal to `netValue`.

### How to determine a tax country at cart level

Since the shipping address is not set in the cart, you need to determine the country to find the `taxRate` for a fee that has a `taxCode` only.
Ways to find the country data:

* Use the country code that is set on the cart
* If the cart has a customer, check the customer addresses, based on site’s setting `taxDeterminationBasedOn`:
  * SHIPPING\_ADDRESS - use the address that is tagged with `SHIPPING`, select the default address or the first match.
  * BILLING\_ADDRESS - use the address that is tagged with `BILLING`, select the default address or the first match.
    If the matching address is not found, return an error.
* Get country code from site’s `homeBase.address.country`.

### How to apply discounts at cart level

Discounts are known as coupons and, with the relevant settings that influence `calculatedPrice`, they can be applied to a cart.

##

Depending on the site configuration and the `includesTax=true/false`, the discount is applied to either the gross value - `includesTax=true`, or the net value - `includesTax=false`.
Based on this setting, the corresponding `netValue` or `grossValue` is recalculated using the tax rate.

##

The information about which calculation method was used is available in `totalDiscount.calculationType=ApplyDiscountAfterTax/ApplyDiscountBeforeTax`:

* `discountCalculationType`:
  * SUBTOTAL - the discounts are applied on `items[].calculatedPrice.price`. The line item fees and shipping cost are **NOT** discounted.
  * TOTAL - the discounts are applied on `items[].calculatedPrice.price`, the line item fees and shipping cost.

##

*   `discountType`:

    * ABSOLUTE - a coupon that has a given type must have `discountAbsolute` attribute configured. It represents a monetary amount that should be discounted.

    Depending on the `ApplyDiscountAfterTax/ApplyDiscountBeforeTax` discount, the absolute amount is subtracted either from the `grossValue` or the `netValue`.
    The value of the discount on the cart level is divided across all the applicable cart prices, proportionally to the `items[].calculatedPrice.price`, `items[].calculatedPrice.fees[].price` and the calculated shipping cost. It's related to the difference between `discountCalculationType:SUBTOTAL/TOTAL` described above, to know which items are applicable.

    * PERCENT - it takes the value of discount’s `discountPercentage` attribute and calculates the percentage discount to the price.
    * FREE\_SHIPPING - this type of a discount fully discounts the price of the `calculatedPrice.totalShipping`. It's applied before any other discount is applied.

##

* `categoryRestricted` - the discount applies only to the line items that belong to a specific category. If the `discountCalculationType=TOTAL`, a fee of an item that fulfills the restriction is discounted. However, any other fees, or shipping are not part of the discounting.

##

* `segmentRestricted` - the discount is applied only to the line items that belong to the given customer segment.

Since the system can be configured to allow more than one discount to a cart, it has a few implications:

* The `FREE_SHIPPING` discount is applied on the shipping first.
* The rest of the discounts are applied based on the order the discounts were applied to the cart.
* Every PERCENT discount is calculated based on the original price, without applied discounts. Applying two coupons of 10% to 15.0 value results in 12.0 discounted price and two applied discounts of 1,5 value.
* Every ABSOLUTE discount uses the not discounted values for the discount value spread. It means that if the given applicable item is already fully discounted, the remaining amount of the discount is spread proportionally on the discounts that still have some value left.

{% hint style="warning" %}\
Check the [System Preferences](https://developer.emporix.io/user-guides/management-dashboard/settings/system-preferences/) documentation for coupons settings related to the number of discounts.
{% endhint %}

For some cases, you might need to calculate and charge additional fees, for example for packaging, freight, or any additional reasons. The fees calculated externally can be added directly to the customer's cart.

To achieve the communication between Commerce Engine and the fee management tool, you have to configure both systems accordingly. The steps required for such a case are described in the [External Products, Pricing and Fees](https://developer.emporix.io/user-guides/extensibility/extensibility-cases/external-pricing-and-products) documentation. You need to generate a dedicated scope that serves as the authorization token for the API calls.

To add a custom fee to the cart, you need to send the request to the endpoint. Provide the customer cart's ID in the cartId path parameter. The payload has to include the "itemType" : "EXTERNAL" parameter - see the [Adding a product to a cart](https://developer.emporix.io/docs/openapi/cart/#operation/POST-cart-add-item-to-cart) documentation.
