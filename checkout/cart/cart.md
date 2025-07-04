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
icon: graduation-cap
---

# Cart Tutorial

## How to create a new cart

To create a new cart, you need to send a request to the [Creating a new cart](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/carts#post-cart-tenant-carts) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
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

## How to add custom attributes to a cart

You can define custom attributes for a cart through `mixins`.

## Define your custom attributes schema

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

## Update a cart with custom attributes

To add custom attributes to a cart, you need to send a request to the [Updating a cart](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/carts#put-cart-tenant-carts-cartid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
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

## How to merge carts

{% hint style="warning" %}
To learn more about merging carts, check out [Cart merging](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/core-commerce/carts#cart-merging) in the Carts guide.
{% endhint %}

To merge an anonymous cart with a customer cart, you need to send a request to the [Merging carts](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/carts#post-cart-tenant-carts-cartid-merge) endpoint. Provide the customer cart's ID in the `cartId` path parameter and the anonymous cart's ID in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
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

## How to source pricing information from an external price calculation tool

For B2B scenarios, you might want to integrate an external application for price calculation for your products. Usually, the systems, such as ERPs, store all the relevant customer-specific pricing information needed for customer-specific pricing.\
The external system then can communicate with the Cart Service directly to overwrite the price of the product added to the cart.

{% hint style="warning" %}
To achieve the communication between Commerce Engine and the external pricing tool, you have to configure both systems accordingly.\
The steps required for such a case are described in the [External Products, Pricing and Fees](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) documentation.\
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

After enabling the external application to update carts with calculated prices, to add a product that is available within Commerce Engine, but with an external price, you need to send the request to the [Adding a product to cart](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) endpoint.\
Provide the customer cart's ID in the `cartId` path parameter.

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

## How to add a product from an external source to a cart

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

## How to add an external fee

For some cases, you might need to calculate and charge additional fees, for example for packaging, freight, or any additional reasons. The fees calculated externally can be added directly to the customer's cart.

{% hint style="warning" %}
To achieve the communication between Commerce Engine and the fee management tool, you have to configure both systems accordingly. The steps required for such a case are described in the [External Products, Pricing and Fees](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) documentation.\
You need to generate a dedicated scope that serves as the authorization token for the API calls.
{% endhint %}

To add a custom fee to the cart, you need to send the request to the [Adding a product to cart](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) endpoint.\
Provide the customer cart's ID in the `cartId` path parameter. Custom fee can be configured both for EXTERNAL and INTERNAL products, the payload should include the `"itemType" : "EXTERNAL"` or `"itemType" : "INTERNAL"` parameter. If the parameter is not provided, then "INTERNAL" is taken as default.

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

## How to apply an external discount on an item level

Adding an external discount to an item in a cart is done with the `cart.cart_manage_external_prices` scope. Use the `externalDiscounts` attribute when adding an item to the cart or updating an existing one.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
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

## Pricing calculations

To ensure that both net and gross prices are available, along with clear details on how these values are derived, the Cart Service includes the calculatedPrice field.

At the item level, there's a `calculatedPrice` attribute, which contains detailed price calculations for a specific item. Additionally, a `calculatedPrice` is also available at the cart level, summarizing the price calculations for all items in the cart.

{% hint style="warning" %}
<details>

<summary>See the item level calculation payload example</summary>

```json
"calculatedPrice": {
      "price": {
          "netValue": 588.235,
          "grossValue": 700.0,
          "taxValue": 111.765,
          "taxCode": "STANDARD",
          "taxRate": 19.0
      },
      "discountedPrice": {
          "netValue": 282.511,
          "grossValue": 336.188,
          "taxValue": 53.677,
          "taxCode": "STANDARD",
          "taxRate": 19.0,
          "appliedDiscounts": [
              {
                  "id": "buy-2-get-1-free",
                  "value": 280.000,
                  "price": {
                      "netValue": 235.294,
                      "grossValue": 280.000,
                      "taxValue": 44.706,
                      "taxCode": "STANDARD",
                      "taxRate": 19.0
                  },
                  "discountType": "PERCENT",
                  "origin": "EXTERNAL"
              },
              {
                  "id": "LS100EUROTOTAL",
                  "value": 83.812,
                  "price": {
                      "netValue": 70.430,
                      "grossValue": 83.812,
                      "taxValue": 13.382,
                      "taxCode": "STANDARD",
                      "taxRate": 19.0
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      },
      "fees": [
          {
              "id": "677d49ca3a421b451eab23f2",
              "type": "ABSOLUTE",
              "origin": "INTERNAL",
              "name": {
                  "de": "Apple Picking Fee",
                  "en": "Apple Picking Fee"
              },
              "price": {
                  "netValue": 3.5,
                  "grossValue": 3.745,
                  "taxValue": 0.245,
                  "taxCode": "REDUCED",
                  "taxRate": 7.0
              },
              "discountedPrice": {
                  "netValue": 3.081,
                  "grossValue": 3.297,
                  "taxValue": 0.216,
                  "taxCode": "REDUCED",
                  "taxRate": 7.0,
                  "appliedDiscounts": [
                      {
                          "id": "LS100EUROTOTAL",
                          "value": 0.448,
                          "price": {
                              "netValue": 0.419,
                              "grossValue": 0.448,
                              "taxValue": 0.029,
                              "taxCode": "REDUCED",
                              "taxRate": 7.0
                          },
                          "discountType": "ABSOLUTE",
                          "origin": "INTERNAL"
                      }
                  ]
              }
          }
      ],
      "totalFee": {
          "netValue": 3.081,
          "grossValue": 3.297,
          "taxValue": 0.216,
          "taxCode": "REDUCED",
          "taxRate": 7.0,
          "appliedDiscounts": [
              {
                  "id": "LS100EUROTOTAL",
                  "value": 0.448,
                  "price": {
                      "netValue": 0.419,
                      "grossValue": 0.448,
                      "taxValue": 0.029,
                      "taxCode": "REDUCED",
                      "taxRate": 7.0
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      },
      "totalDiscount": {
          "calculationType": "ApplyDiscountAfterTax",
          "value": 364.26,
          "price": {
              "netValue": 306.143,
              "grossValue": 364.26,
              "taxValue": 58.117
          },
          "appliedDiscounts": [
              {
                  "id": "buy-2-get-1-free",
                  "value": 280.000,
                  "price": {
                      "netValue": 235.294,
                      "grossValue": 280.000,
                      "taxValue": 44.706,
                      "taxCode": "STANDARD",
                      "taxRate": 19.0
                  },
                  "discountType": "PERCENT",
                  "origin": "EXTERNAL"
              },
              {
                  "id": "LS100EUROTOTAL",
                  "value": 84.260,
                  "price": {
                      "netValue": 70.849,
                      "grossValue": 84.260,
                      "taxValue": 13.411
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      },
      "finalPrice": {
          "netValue": 285.592,
          "grossValue": 339.485,
          "taxValue": 53.893
      }
  }
```

</details>

<details>

<summary>See the cart level calculation payload example</summary>

```json
  "calculatedPrice" : {
      "price": {
          "netValue": 700.385,
          "grossValue": 820.0,
          "taxValue": 119.615
      },
      "upliftValue": {
          "netValue": 30.841,
          "grossValue": 33.0,
          "taxValue": 2.159,
          "taxCode": "REDUCED",
          "taxRate": 7.0
      },
      "discountedPrice": {
          "netValue": 381.233,
          "grossValue": 441.821,
          "taxValue": 60.588,
          "appliedDiscounts": [
              {
                  "id": "buy-2-get-1-free",
                  "value": 280.000,
                  "price": {
                      "netValue": 235.294,
                      "grossValue": 280.000,
                      "taxValue": 44.706,
                      "taxCode": "STANDARD",
                      "taxRate": 19.0
                  },
                  "discountType": "PERCENT",
                  "origin": "EXTERNAL"
              },
              {
                  "id": "LS100EUROTOTAL",
                  "value": 98.179,
                  "price": {
                      "netValue": 83.857,
                      "grossValue": 98.179,
                      "taxValue": 14.322
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      },
      "fees": {
          "netValue": 7.0,
          "grossValue": 7.49,
          "taxValue": 0.49,
          "taxCode": "REDUCED",
          "taxRate": 7.0
      },
      "totalFee": {
          "netValue": 6.162,
          "grossValue": 6.594,
          "taxValue": 0.432,
          "taxCode": "REDUCED",
          "taxRate": 7.0,
          "appliedDiscounts": [
              {
                  "id": "LS100EUROTOTAL",
                  "value": 0.896,
                  "price": {
                      "netValue": 0.838,
                      "grossValue": 0.896,
                      "taxValue": 0.058,
                      "taxCode": "REDUCED",
                      "taxRate": 7.0
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      },
      "shipping": {
          "netValue": 7.22,
          "grossValue": 7.725,
          "taxValue": 0.505,
          "taxCode": "REDUCED",
          "taxRate": 7.0
      },
      "totalShipping": {
          "netValue": 6.355,
          "grossValue": 6.8,
          "taxValue": 0.445,
          "taxCode": "REDUCED",
          "taxRate": 7.0,
          "appliedDiscounts": [
              {
                  "id": "LS100EUROTOTAL",
                  "value": 0.925,
                  "price": {
                      "netValue": 0.864,
                      "grossValue": 0.925,
                      "taxValue": 0.061,
                      "taxCode": "REDUCED",
                      "taxRate": 7.0
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      },
      "totalDiscount": {
          "calculationType": "ApplyDiscountAfterTax",
          "value": 380.0,
          "price": {
              "netValue": 320.853,
              "grossValue": 380.0,
              "taxValue": 59.147
          },
          "appliedDiscounts": [
              {
                  "id": "buy-2-get-1-free",
                  "value": 280.000,
                  "price": {
                      "netValue": 235.294,
                      "grossValue": 280.000,
                      "taxValue": 44.706,
                      "taxCode": "STANDARD",
                      "taxRate": 19.0
                  },
                  "discountType": "PERCENT",
                  "origin": "EXTERNAL"
              },
              {
                  "id": "LS100EUROTOTAL",
                  "value": 100.000,
                  "price": {
                      "netValue": 85.559,
                      "grossValue": 100.000,
                      "taxValue": 14.441
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      },
      "finalPrice": {
          "netValue": 393.75,
          "grossValue": 455.215,
          "taxValue": 61.465,
          "taxAggregate": {
              "lines": [
                  {
                      "netValue": 111.239,
                      "grossValue": 119.027,
                      "taxValue": 7.788,
                      "taxCode": "REDUCED",
                      "taxRate": 7.0
                  },
                  {
                      "netValue": 282.511,
                      "grossValue": 336.188,
                      "taxValue": 53.677,
                      "taxCode": "STANDARD",
                      "taxRate": 19.0
                  }
              ]
          }
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
    "id": "68481e9e8bf22744fc578572",
    "yrn": "urn:yaas:hybris:cart:cart:b2b2cstage;68481e9e8bf22744fc578572",
    "customerId": "45620894",
    "currency": "EUR",
    "siteCode": "GrossSite",
    "type": "shoppingDUpaeaaa2s12234",
    "channel": {
        "name": "storefront",
        "source": "https://your-storefront.com/"
    },
    "items": [
        {
            "id": "0",
            "keepAsSeparateLineItem": true,
            "type": "INTERNAL",
            "product": {
                "id": "samsung-galaxy-s24-gross",
                "sku": "Samsung Galaxy s24 gross",
                "code": "Samsung Galaxy s24 gross",
                "name": "Samsung Galaxy s24 gross",
                "localizedName": {
                    "en": "Samsung Galaxy s24 gross"
                },
                "images": [
                    {
                        "id": "67169928ceaab717e17f3734",
                        "url": "http://res.cloudinary.com/saas-ag/image/upload/v1729534248/b2b2cstage/media/67169928ceaab717e17f3734"
                    }
                ]
            },
            "itemYrn": "urn:yaas:saasag:caasproduct:product:b2b2cstage;samsung-galaxy-s24-gross",
            "quantity": 2.0,
            "effectiveQuantity": 2.0,
            "price": {
                "priceId": "679ca63dbcdefe5b380c98bc",
                "priceListId": "abc123",
                "originalAmount": 350.0,
                "effectiveAmount": 350.0,
                "currency": "EUR"
            },
            "unitPrice": {
                "netValue": 294.118,
                "grossValue": 350.0,
                "taxValue": 55.882,
                "taxCode": "STANDARD",
                "taxRate": 19.0
            },
            "itemPrice": {
                "amount": 700.0,
                "currency": "EUR"
            },
            "itemTaxInfo": [
                {
                    "name": "STANDARD",
                    "value": {
                        "amount": 111.76
                    },
                    "rate": 19.0,
                    "grossValue": 700.00,
                    "netValue": 588.24
                }
            ],
            "fees": {
                "elements": [
                    {
                        "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                        "taxCode": "REDUCED",
                        "total": {
                            "subTotal": 3.50,
                            "totalTax": 0.00,
                            "total": 3.08,
                            "discount": 0.42
                        },
                        "name": {
                            "de": "Apple Picking Fee",
                            "en": "Apple Picking Fee"
                        }
                    }
                ],
                "total": {
                    "subTotal": 3.50,
                    "totalTax": 0.00,
                    "total": 3.08,
                    "discount": 0.42
                }
            },
            "authorizedAmount": {
                "amount": 700.0,
                "currency": "EUR"
            },
            "totalDiscount": {
                "amount": 84.32,
                "currency": "EUR"
            },
            "couponDiscounts": [
                {
                    "couponId": "LS100EUROTOTAL",
                    "value": 84.32
                }
            ],
            "externalDiscounts": [
                {
                    "id": "buy-2-get-1-free",
                    "discountType": "PERCENT",
                    "value": 40.00,
                    "sequence": 1
                }
            ],
            "calculatedPrice": {
                "price": {
                    "netValue": 588.235,
                    "grossValue": 700.0,
                    "taxValue": 111.765,
                    "taxCode": "STANDARD",
                    "taxRate": 19.0
                },
                "discountedPrice": {
                    "netValue": 282.511,
                    "grossValue": 336.188,
                    "taxValue": 53.677,
                    "taxCode": "STANDARD",
                    "taxRate": 19.0,
                    "appliedDiscounts": [
                        {
                            "id": "buy-2-get-1-free",
                            "value": 280.000,
                            "price": {
                                "netValue": 235.294,
                                "grossValue": 280.000,
                                "taxValue": 44.706,
                                "taxCode": "STANDARD",
                                "taxRate": 19.0
                            },
                            "discountType": "PERCENT",
                            "origin": "EXTERNAL"
                        },
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 83.812,
                            "price": {
                                "netValue": 70.430,
                                "grossValue": 83.812,
                                "taxValue": 13.382,
                                "taxCode": "STANDARD",
                                "taxRate": 19.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "fees": [
                    {
                        "id": "677d49ca3a421b451eab23f2",
                        "type": "ABSOLUTE",
                        "origin": "INTERNAL",
                        "name": {
                            "de": "Apple Picking Fee",
                            "en": "Apple Picking Fee"
                        },
                        "price": {
                            "netValue": 3.5,
                            "grossValue": 3.745,
                            "taxValue": 0.245,
                            "taxCode": "REDUCED",
                            "taxRate": 7.0
                        },
                        "discountedPrice": {
                            "netValue": 3.081,
                            "grossValue": 3.297,
                            "taxValue": 0.216,
                            "taxCode": "REDUCED",
                            "taxRate": 7.0,
                            "appliedDiscounts": [
                                {
                                    "id": "LS100EUROTOTAL",
                                    "value": 0.448,
                                    "price": {
                                        "netValue": 0.419,
                                        "grossValue": 0.448,
                                        "taxValue": 0.029,
                                        "taxCode": "REDUCED",
                                        "taxRate": 7.0
                                    },
                                    "discountType": "ABSOLUTE",
                                    "origin": "INTERNAL"
                                }
                            ]
                        }
                    }
                ],
                "totalFee": {
                    "netValue": 3.081,
                    "grossValue": 3.297,
                    "taxValue": 0.216,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 0.448,
                            "price": {
                                "netValue": 0.419,
                                "grossValue": 0.448,
                                "taxValue": 0.029,
                                "taxCode": "REDUCED",
                                "taxRate": 7.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "totalDiscount": {
                    "calculationType": "ApplyDiscountAfterTax",
                    "value": 364.26,
                    "price": {
                        "netValue": 306.143,
                        "grossValue": 364.26,
                        "taxValue": 58.117
                    },
                    "appliedDiscounts": [
                        {
                            "id": "buy-2-get-1-free",
                            "value": 280.000,
                            "price": {
                                "netValue": 235.294,
                                "grossValue": 280.000,
                                "taxValue": 44.706,
                                "taxCode": "STANDARD",
                                "taxRate": 19.0
                            },
                            "discountType": "PERCENT",
                            "origin": "EXTERNAL"
                        },
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 84.260,
                            "price": {
                                "netValue": 70.849,
                                "grossValue": 84.260,
                                "taxValue": 13.411
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "finalPrice": {
                    "netValue": 285.592,
                    "grossValue": 339.485,
                    "taxValue": 53.893
                }
            }
        },
        {
            "id": "1",
            "keepAsSeparateLineItem": false,
            "type": "INTERNAL",
            "product": {
                "id": "shirt--301722c1-23e8-42b4-a4d8-1a5480fe3ea5",
                "sku": "shirt--red",
                "code": "shirt--red",
                "name": "shirt",
                "localizedName": {
                    "en": "shirt"
                },
                "description": ""
            },
            "itemYrn": "urn:yaas:saasag:caasproduct:product:b2b2cstage;shirt--301722c1-23e8-42b4-a4d8-1a5480fe3ea5",
            "quantity": 1.0,
            "effectiveQuantity": 1.0,
            "price": {
                "priceId": "6818c032524d1c16623037e2",
                "originalAmount": 10.0,
                "effectiveAmount": 10.0,
                "currency": "EUR"
            },
            "unitPrice": {
                "netValue": 9.346,
                "grossValue": 10.0,
                "taxValue": 0.654,
                "taxCode": "REDUCED",
                "taxRate": 7.0
            },
            "itemPrice": {
                "amount": 10.0,
                "currency": "EUR"
            },
            "itemTaxInfo": [
                {
                    "name": "REDUCED",
                    "value": {
                        "amount": 0.65
                    },
                    "rate": 7.0,
                    "grossValue": 10.00,
                    "netValue": 9.35
                }
            ],
            "fees": {
                "total": {
                    "subTotal": 0.00,
                    "totalTax": 0.00,
                    "total": 0.00,
                    "discount": 0.00
                }
            },
            "authorizedAmount": {
                "amount": 10.0,
                "currency": "EUR"
            },
            "totalDiscount": {
                "amount": 1.2,
                "currency": "EUR"
            },
            "couponDiscounts": [
                {
                    "couponId": "LS100EUROTOTAL",
                    "value": 1.20
                }
            ],
            "calculatedPrice": {
                "price": {
                    "netValue": 9.346,
                    "grossValue": 10.0,
                    "taxValue": 0.654,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                },
                "discountedPrice": {
                    "netValue": 8.227,
                    "grossValue": 8.803,
                    "taxValue": 0.576,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 1.197,
                            "price": {
                                "netValue": 1.119,
                                "grossValue": 1.197,
                                "taxValue": 0.078,
                                "taxCode": "REDUCED",
                                "taxRate": 7.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "totalDiscount": {
                    "calculationType": "ApplyDiscountAfterTax",
                    "value": 1.197,
                    "price": {
                        "netValue": 1.119,
                        "grossValue": 1.197,
                        "taxValue": 0.078,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    "appliedDiscounts": [
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 1.197,
                            "price": {
                                "netValue": 1.119,
                                "grossValue": 1.197,
                                "taxValue": 0.078,
                                "taxCode": "REDUCED",
                                "taxRate": 7.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "finalPrice": {
                    "netValue": 8.227,
                    "grossValue": 8.803,
                    "taxValue": 0.576,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                }
            }
        },
        {
            "id": "2",
            "keepAsSeparateLineItem": true,
            "type": "INTERNAL",
            "product": {
                "id": "samsung-galaxy-s27-gross",
                "sku": "samsung-galaxy-s27-gross",
                "code": "samsung-galaxy-s27-gross",
                "name": "samsung-galaxy-s27-gross",
                "localizedName": {
                    "en": "samsung-galaxy-s27-gross"
                },
                "description": "samsung-galaxy-s27-gross"
            },
            "itemYrn": "urn:yaas:saasag:caasproduct:product:b2b2cstage;samsung-galaxy-s27-gross",
            "quantity": 2.0,
            "effectiveQuantity": 2.0,
            "price": {
                "priceId": "6797da2f3537716a5a537ecf",
                "originalAmount": 55.0,
                "effectiveAmount": 55.0,
                "currency": "EUR"
            },
            "unitPrice": {
                "netValue": 51.402,
                "grossValue": 55.0,
                "taxValue": 3.598,
                "taxCode": "REDUCED",
                "taxRate": 7.0
            },
            "itemPrice": {
                "amount": 110.0,
                "currency": "EUR"
            },
            "itemTaxInfo": [
                {
                    "name": "REDUCED",
                    "value": {
                        "amount": 7.2
                    },
                    "rate": 7.0,
                    "grossValue": 110.00,
                    "netValue": 102.80
                }
            ],
            "fees": {
                "elements": [
                    {
                        "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                        "taxCode": "REDUCED",
                        "total": {
                            "subTotal": 3.50,
                            "totalTax": 0.00,
                            "total": 3.08,
                            "discount": 0.42
                        },
                        "name": "Apple Picking Fee"
                    }
                ],
                "total": {
                    "subTotal": 3.50,
                    "totalTax": 0.00,
                    "total": 3.08,
                    "discount": 0.42
                }
            },
            "authorizedAmount": {
                "amount": 143.0,
                "currency": "EUR"
            },
            "totalDiscount": {
                "amount": 13.61,
                "currency": "EUR"
            },
            "couponDiscounts": [
                {
                    "couponId": "LS100EUROTOTAL",
                    "value": 13.61
                }
            ],
            "calculatedPrice": {
                "price": {
                    "netValue": 102.804,
                    "grossValue": 110.0,
                    "taxValue": 7.196,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                },
                "upliftValue": {
                    "netValue": 30.841,
                    "grossValue": 33.0,
                    "taxValue": 2.159,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                },
                "discountedPrice": {
                    "netValue": 90.495,
                    "grossValue": 96.83,
                    "taxValue": 6.335,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 13.170,
                            "price": {
                                "netValue": 12.308,
                                "grossValue": 13.170,
                                "taxValue": 0.862,
                                "taxCode": "REDUCED",
                                "taxRate": 7.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "fees": [
                    {
                        "id": "677d49ca3a421b451eab23f2",
                        "type": "ABSOLUTE",
                        "origin": "INTERNAL",
                        "name": "Apple Picking Fee",
                        "price": {
                            "netValue": 3.5,
                            "grossValue": 3.745,
                            "taxValue": 0.245,
                            "taxCode": "REDUCED",
                            "taxRate": 7.0
                        },
                        "discountedPrice": {
                            "netValue": 3.081,
                            "grossValue": 3.297,
                            "taxValue": 0.216,
                            "taxCode": "REDUCED",
                            "taxRate": 7.0,
                            "appliedDiscounts": [
                                {
                                    "id": "LS100EUROTOTAL",
                                    "value": 0.448,
                                    "price": {
                                        "netValue": 0.419,
                                        "grossValue": 0.448,
                                        "taxValue": 0.029,
                                        "taxCode": "REDUCED",
                                        "taxRate": 7.0
                                    },
                                    "discountType": "ABSOLUTE",
                                    "origin": "INTERNAL"
                                }
                            ]
                        }
                    }
                ],
                "totalFee": {
                    "netValue": 3.081,
                    "grossValue": 3.297,
                    "taxValue": 0.216,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 0.448,
                            "price": {
                                "netValue": 0.419,
                                "grossValue": 0.448,
                                "taxValue": 0.029,
                                "taxCode": "REDUCED",
                                "taxRate": 7.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "totalDiscount": {
                    "calculationType": "ApplyDiscountAfterTax",
                    "value": 13.618,
                    "price": {
                        "netValue": 12.727,
                        "grossValue": 13.618,
                        "taxValue": 0.891,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    "appliedDiscounts": [
                        {
                            "id": "LS100EUROTOTAL",
                            "value": 13.618,
                            "price": {
                                "netValue": 12.727,
                                "grossValue": 13.618,
                                "taxValue": 0.891,
                                "taxCode": "REDUCED",
                                "taxRate": 7.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "finalPrice": {
                    "netValue": 93.576,
                    "grossValue": 100.127,
                    "taxValue": 6.551,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                }
            }
        }
    ],
    "discounts": [
        {
            "id": "0",
            "code": "LS100EUROTOTAL",
            "amount": 100.0,
            "currency": "EUR",
            "name": "LS100EUROTOTAL",
            "calculationType": "ApplyDiscountBeforeTax",
            "valid": true,
            "links": [
                {
                    "rel": "validate",
                    "title": "Coupon Validation",
                    "href": "https://api-stage.emporix.io/coupon/b2b2cstage/coupons/LS100EUROTOTAL/validation",
                    "type": "application/json"
                },
                {
                    "rel": "redeem",
                    "title": "Coupon Redemption",
                    "href": "https://api-stage.emporix.io/coupon/b2b2cstage/coupons/LS100EUROTOTAL/redemptions",
                    "type": "application/json"
                }
            ],
            "discountType": "ABSOLUTE",
            "discountCalculationType": "TOTAL",
            "categoryRestricted": false
        }
    ],
    "feeYrnAggregate": {
        "elements": [
            {
                "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                "taxCode": "REDUCED",
                "total": {
                    "subTotal": 7.00,
                    "totalTax": 0.00,
                    "total": 6.16,
                    "discount": 0.84
                },
                "name": {
                    "de": "Apple Picking Fee",
                    "en": "Apple Picking Fee"
                }
            }
        ],
        "total": {
            "subTotal": 7.00,
            "totalTax": 0.00,
            "total": 6.16,
            "discount": 0.84
        }
    },
    "totalPrice": {
        "amount": 734.22,
        "currency": "EUR"
    },
    "subTotalPrice": {
        "amount": 820.0,
        "currency": "EUR"
    },
    "shipping": {
        "fee": {
            "amount": 7.22,
            "currency": "EUR"
        },
        "total": {
            "subTotal": 7.22,
            "totalTax": 0.00,
            "total": 6.35,
            "discount": 0.87
        }
    },
    "totalUnitsCount": 5.0,
    "metadata": {
        "createdAt": "2025-06-10T12:01:34.057Z",
        "modifiedAt": "2025-06-10T12:23:14.894Z",
        "calculatedAt": "2025-06-10T12:23:14.894Z",
        "version": 5
    },
    "totalTax": {
        "amount": 0.0,
        "currency": "EUR"
    },
    "taxAggregate": {
        "lines": [
            {
                "name": "REDUCED",
                "amount": 7.85,
                "rate": 7.0,
                "taxable": 120.0
            },
            {
                "name": "STANDARD",
                "amount": 111.77,
                "rate": 19.0,
                "taxable": 700.01
            }
        ]
    },
    "subtotalAggregate": {
        "currency": "EUR",
        "netValue": 700.39,
        "grossValue": 820.01,
        "taxValue": 119.62
    },
    "totalDiscount": {
        "amount": 100.0,
        "currency": "EUR"
    },
    "itemFeesTotal": {
        "subTotal": 7.00,
        "totalTax": 0.00,
        "total": 6.16,
        "discount": 0.84
    },
    "paymentFeesTotal": {
        "subTotal": 0.00,
        "totalTax": 0.00,
        "total": 0.00,
        "discount": 0.00
    },
    "leadTime": 0,
    "totalAuthorizedAmount": {
        "amount": 767.22,
        "currency": "EUR"
    },
    "calculatedPrice": {
        "price": {
            "netValue": 700.385,
            "grossValue": 820.0,
            "taxValue": 119.615
        },
        "upliftValue": {
            "netValue": 30.841,
            "grossValue": 33.0,
            "taxValue": 2.159,
            "taxCode": "REDUCED",
            "taxRate": 7.0
        },
        "discountedPrice": {
            "netValue": 381.233,
            "grossValue": 441.821,
            "taxValue": 60.588,
            "appliedDiscounts": [
                {
                    "id": "buy-2-get-1-free",
                    "value": 280.000,
                    "price": {
                        "netValue": 235.294,
                        "grossValue": 280.000,
                        "taxValue": 44.706,
                        "taxCode": "STANDARD",
                        "taxRate": 19.0
                    },
                    "discountType": "PERCENT",
                    "origin": "EXTERNAL"
                },
                {
                    "id": "LS100EUROTOTAL",
                    "value": 98.179,
                    "price": {
                        "netValue": 83.857,
                        "grossValue": 98.179,
                        "taxValue": 14.322
                    },
                    "discountType": "ABSOLUTE",
                    "origin": "INTERNAL"
                }
            ]
        },
        "fees": {
            "netValue": 7.0,
            "grossValue": 7.49,
            "taxValue": 0.49,
            "taxCode": "REDUCED",
            "taxRate": 7.0
        },
        "totalFee": {
            "netValue": 6.162,
            "grossValue": 6.594,
            "taxValue": 0.432,
            "taxCode": "REDUCED",
            "taxRate": 7.0,
            "appliedDiscounts": [
                {
                    "id": "LS100EUROTOTAL",
                    "value": 0.896,
                    "price": {
                        "netValue": 0.838,
                        "grossValue": 0.896,
                        "taxValue": 0.058,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    "discountType": "ABSOLUTE",
                    "origin": "INTERNAL"
                }
            ]
        },
        "shipping": {
            "netValue": 7.22,
            "grossValue": 7.725,
            "taxValue": 0.505,
            "taxCode": "REDUCED",
            "taxRate": 7.0
        },
        "totalShipping": {
            "netValue": 6.355,
            "grossValue": 6.8,
            "taxValue": 0.445,
            "taxCode": "REDUCED",
            "taxRate": 7.0,
            "appliedDiscounts": [
                {
                    "id": "LS100EUROTOTAL",
                    "value": 0.925,
                    "price": {
                        "netValue": 0.864,
                        "grossValue": 0.925,
                        "taxValue": 0.061,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    "discountType": "ABSOLUTE",
                    "origin": "INTERNAL"
                }
            ]
        },
        "totalDiscount": {
            "calculationType": "ApplyDiscountAfterTax",
            "value": 380.0,
            "price": {
                "netValue": 320.853,
                "grossValue": 380.0,
                "taxValue": 59.147
            },
            "appliedDiscounts": [
                {
                    "id": "buy-2-get-1-free",
                    "value": 280.000,
                    "price": {
                        "netValue": 235.294,
                        "grossValue": 280.000,
                        "taxValue": 44.706,
                        "taxCode": "STANDARD",
                        "taxRate": 19.0
                    },
                    "discountType": "PERCENT",
                    "origin": "EXTERNAL"
                },
                {
                    "id": "LS100EUROTOTAL",
                    "value": 100.000,
                    "price": {
                        "netValue": 85.559,
                        "grossValue": 100.000,
                        "taxValue": 14.441
                    },
                    "discountType": "ABSOLUTE",
                    "origin": "INTERNAL"
                }
            ]
        },
        "finalPrice": {
            "netValue": 393.75,
            "grossValue": 455.215,
            "taxValue": 61.465,
            "taxAggregate": {
                "lines": [
                    {
                        "netValue": 111.239,
                        "grossValue": 119.027,
                        "taxValue": 7.788,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    {
                        "netValue": 282.511,
                        "grossValue": 336.188,
                        "taxValue": 53.677,
                        "taxCode": "STANDARD",
                        "taxRate": 19.0
                    }
                ]
            }
        }
    }
}
```

</details>
{% endhint %}

## Pricing calculations glossary

## Calculated price on item level

<table data-full-width="false"><thead><tr><th>Term</th><th>Definition</th></tr></thead><tbody><tr><td><code>price</code></td><td><p>A unit price from <code>priceMatch</code>, it's multiplied by item quantity.</p><pre><code>{
  "calculatedPrice": {
    "price": {
      "netValue": 588.235,
      "grossValue": 700.0,
      "taxValue": 111.765,
      "taxCode": "STANDARD",
      "taxRate": 19.0
    }
  }
}
</code></pre></td></tr><tr><td><code>upliftValue</code></td><td><p>An additional amount authorized for payment to cover potential price adjustments during packing of weight-based products. There are two conditions to have this value for an item line:</p><ul><li>The item has to be added to the cart with the <code>"weightDependent":true</code> attribute. It means that the quantity may vary during packaging, as some items, for example a case of bananas, cannot be divided to precisely match a given weight.</li><li>The tenant has to have the percentage uplift defined - <code>authorizedAmountUplift</code>, for example 0,1=10%. If the item <code>price.netValue=12</code>, the <code>upliftValue.netValue=1,2</code> with the 10% uplift configured. If the upliftValue is not configured for an item, it's not returned in the response.</li></ul><pre><code>{
  "calculatedPrice": {
    "upliftValue" : {
        "netValue" : 30.0,
        "grossValue" : 33.0,
        "taxValue" : 3.0,
        "taxCode" : "STANDARD",
        "taxRate" : 10.0
      },
  }
}
</code></pre></td></tr><tr><td><code>discountedPrice</code></td><td><p>The price of the line item is calculated as unit price × quantity, with any applied discounts. If no discounts are applied to a given line item, this attribute is not included in the response. Depending on the site configuration, the <code>includesTax</code> attribute can be <code>true</code> or <code>false</code>. The discount is applied to <code>price.grossValue</code> when <code>includesTax=true</code> or <code>price.netValue</code> when <code>includesTax=false</code>. Based on this, the corresponding <code>netValue</code> or <code>grossValue</code> is recalculated using the <code>taxRate</code>. The calculation method that was used is indicated in <code>totalDiscount.calculationType</code>, which can be either <code>ApplyDiscountAfterTax</code> or <code>ApplyDiscountBeforeTax</code>.</p><pre><code>{
  "calculatedPrice": {
    "discountedPrice" : {
      "netValue": 282.511,
      "grossValue": 336.188,
      "taxValue": 53.677,
      "taxCode": "STANDARD",
      "taxRate": 19.0,
      "appliedDiscounts": [
          {
              "id": "buy-2-get-1-free",
              "value": 280.000,
              "price": {
                  "netValue": 235.294,
                  "grossValue": 280.000,
                  "taxValue": 44.706,
                  "taxCode": "STANDARD",
                  "taxRate": 19.0
              },
              "discountType": "PERCENT",
              "origin": "EXTERNAL"
          },
          {
              "id": "LS100EUROTOTAL",
              "value": 83.812,
              "price": {
                  "netValue": 70.430,
                  "grossValue": 83.812,
                  "taxValue": 13.382,
                  "taxCode": "STANDARD",
                  "taxRate": 19.0
              },
              "discountType": "ABSOLUTE",
              "origin": "INTERNAL"
          }
      ]
    },
  }
}
</code></pre></td></tr><tr><td><code>fees</code></td><td><p>A list of fees applied to the line item. If there are no fees on the line item, it's not returned in the response.</p><ul><li><p>Types of fees:</p><ul><li>PERCENT - The fee percentage of the line item <code>price.netValue</code> - unit price x quantity.</li><li>ABSOLUTE - The absolute amount assigned to the item line.</li><li>ABSOLUTE_MULTIPLY_ITEMQUANTITY - Monetary amount multiplied by the item quantity and assigned to the item line.</li></ul></li><li><p>Fees origin:</p><ul><li><code>INTERNAL</code> - Defined in commerce engine</li><li><code>EXTERNAL</code> - Specified when an item is added to the cart.</li></ul></li><li><p><code>netValue</code> - Monetary amount of the fee. Depends on the fee type:</p><ul><li>ABSOLUTE - The value of the defined fee's <code>feeAbsolute.amount</code> attribute.</li><li>ABSOLUTE_MULTIPLY_ITEMQUANTITY - The value of the defined fee's <code>feeAbsolute.amount</code> attribute multiplied by the quantity of the line item.</li><li>PERCENT - The defined fee level percentage (<code>feePercentage</code> attribute) of the line item <code>price.netValue</code>.</li></ul></li><li><code>grossValue</code> - Value calculated based on the <code>taxCode</code> and the <code>taxRate</code> if <code>taxable=true</code>. For a fee that is <code>taxable=true</code> and has a correct <code>taxCode</code>, the <code>taxRate</code> defined for that <code>taxCode</code> is used to calculate the <code>grossValue</code>. If the fee is not taxable, the <code>netValue</code> is equal to <code>grossValue</code>.</li><li><code>taxRate</code> - If a fee is defined with the attribute <code>taxable=true</code>, the tax rate is calculated based on the provided <code>taxCode</code> at the fee level. A taxable fee must have a defined <code>taxCode</code>.</li><li><code>taxCode</code> - Tax code defined on the fee level, for example STANDARD. The value should match the available tax codes in the system configuration.</li></ul><pre><code>{
  "calculatedPrice": {
    "fees" : [ {
        "id": "677d49ca3a421b451eab23f2",
        "type": "ABSOLUTE",
        "origin": "INTERNAL",
        "name": {
            "de": "Apple Picking Fee",
            "en": "Apple Picking Fee"
        },
        "price": {
            "netValue": 3.5,
            "grossValue": 3.745,
            "taxValue": 0.245,
            "taxCode": "REDUCED",
            "taxRate": 7.0
        },
        "discountedPrice": {
            "netValue": 3.081,
            "grossValue": 3.297,
            "taxValue": 0.216,
            "taxCode": "REDUCED",
            "taxRate": 7.0,
            "appliedDiscounts": [
                {
                    "id": "LS100EUROTOTAL",
                    "value": 0.448,
                    "price": {
                        "netValue": 0.419,
                        "grossValue": 0.448,
                        "taxValue": 0.029,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    "discountType": "ABSOLUTE",
                    "origin": "INTERNAL"
                }
            ]
        }
    } ],
  }
}
</code></pre></td></tr><tr><td><code>totalFee</code></td><td><p>Sum of all fees applied to the line item. It's calculated by summarizing <code>fees[].discountedPrice</code> if any discounts were applied to the fee, or <code>fees[].price</code> for a a not discounted fee.</p><pre><code>{
  "calculatedPrice": {
    "totalFee" : {
        "netValue": 3.081,
        "grossValue": 3.297,
        "taxValue": 0.216,
        "taxCode": "REDUCED",
        "taxRate": 7.0,
        "appliedDiscounts": [
            {
                "id": "LS100EUROTOTAL",
                "value": 0.448,
                "price": {
                    "netValue": 0.419,
                    "grossValue": 0.448,
                    "taxValue": 0.029,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                },
                "discountType": "ABSOLUTE",
                "origin": "INTERNAL"
            }
        ]
    },
  }
}
</code></pre></td></tr><tr><td><code>totalDiscount</code></td><td><p>A summary of all discounts applied to the line, including discounts on both the line item's price and its fees. If there are no discounts applied on the line item, it's not returned in the response. </p><pre><code>{
  "calculatedPrice": {
    "totalDiscount" : {
        "calculationType": "ApplyDiscountAfterTax",
        "value": 364.26,
        "price": {
            "netValue": 306.143,
            "grossValue": 364.26,
            "taxValue": 58.117
        },
        "appliedDiscounts": [
            {
                "id": "buy-2-get-1-free",
                "value": 280.000,
                "price": {
                    "netValue": 235.294,
                    "grossValue": 280.000,
                    "taxValue": 44.706,
                    "taxCode": "STANDARD",
                    "taxRate": 19.0
                },
                "discountType": "PERCENT",
                "origin": "EXTERNAL"
            },
            {
                "id": "LS100EUROTOTAL",
                "value": 84.260,
                "price": {
                    "netValue": 70.849,
                    "grossValue": 84.260,
                    "taxValue": 13.411
                },
                "discountType": "ABSOLUTE",
                "origin": "INTERNAL"
            }
        ]
    },
  }
}
</code></pre></td></tr><tr><td><code>totalDiscount.calculationType</code></td><td><p>Indicates whether discounts were applied to net or gross values.</p><ul><li>The discount is applied to either <code>price.grossValue</code>, when <code>includesTax=true</code>, or <code>price.netValue</code>, when <code>includesTax=false</code>. Based on this, the corresponding net or gross value is recalculated using the tax rate.</li><li>The calculation method used is indicated in <code>totalDiscount.calculationType</code>>, which can be either <code>ApplyDiscountAfterTax</code> or <code>ApplyDiscountBeforeTax</code>.</li></ul><pre><code>{
  "calculatedPrice": {
    "totalDiscount" : {
        "calculationType" : "ApplyDiscountAfterTax",
  }
}
</code></pre></td></tr><tr><td><code>finalPrice</code></td><td><p>The final price is the sum of the <code>discountedPrice</code> or the original price, depending on whether any discounts were applied to the line item, and the <code>totalFee</code>, which includes all fees applied to the line item.</p><pre><code>{
  "calculatedPrice": {
    "finalPrice" : {
        "netValue": 285.592,
        "grossValue": 339.485,
        "taxValue": 53.893
    }
  }
}
</code></pre></td></tr></tbody></table>

## Calculated price on cart level

<table data-full-width="false"><thead><tr><th>Term</th><th>Definition</th></tr></thead><tbody><tr><td><code>price</code></td><td><p>A sum of all line item prices without discounts.</p><pre><code>{
  "calculatedPrice": {
    "price" : {
        "netValue": 700.385,
        "grossValue": 820.0,
        "taxValue": 119.615
    },
  }
}
</code></pre></td></tr><tr><td><code>upliftValue</code></td><td><p>It's the sum of all uplift values from item lines. At item level, it's an additional amount authorized for payment to cover potential price adjustments during packing of weight-based products. There are two conditions to have this value for an item line:</p><ul><li>The item has to be added to the cart with the <code>"weightDependent":true</code> attribute. It means that the quantity may vary during packaging, as some items, for example a case of bananas, cannot be divided to precisely match a given weight.</li><li>The tenant has to have the percentage uplift defined - <code>authorizedAmountUplift</code>, for example 0,1=10%. If the item <code>price.netValue=12</code>, the <code>upliftValue.netValue=1,2</code> with the 10% uplift configured. If the upliftValue is not configured for an item, it's not returned in the response.</li></ul><pre><code>{
  "calculatedPrice": {
    "upliftValue" : {
        "netValue": 30.841,
        "grossValue": 33.0,
        "taxValue": 2.159,
        "taxCode": "REDUCED",
        "taxRate": 7.0
    },
  }
}
</code></pre></td></tr><tr><td><code>discountedPrice</code></td><td><p>The sum of all line item prices after discounts. This attribute is included in the response if at least one line item has a discounted price. It represents the total of discounted prices for line items with discounts applied, or the regular prices for line items without discounts. Ultimately, it reflects the total cost of all line items after discounts.</p><pre><code>{
  "calculatedPrice": {
    "discountedPrice" : {
        "netValue": 381.233,
        "grossValue": 441.821,
        "taxValue": 60.588,
        "appliedDiscounts": [
            {
                "id": "buy-2-get-1-free",
                "value": 280.000,
                "price": {
                    "netValue": 235.294,
                    "grossValue": 280.000,
                    "taxValue": 44.706,
                    "taxCode": "STANDARD",
                    "taxRate": 19.0
                },
                "discountType": "PERCENT",
                "origin": "EXTERNAL"
            },
            {
                "id": "LS100EUROTOTAL",
                "value": 98.179,
                "price": {
                    "netValue": 83.857,
                    "grossValue": 98.179,
                    "taxValue": 14.322
                },
                "discountType": "ABSOLUTE",
                "origin": "INTERNAL"
            }
        ]
    },
  }
}
</code></pre></td></tr><tr><td><code>fees</code></td><td><p>It's a sum of all the fees of the line items in the cart - sum of all <code>items[].calculatedPrice.fees.price</code>. The fees are WITHOUT discounts.</p><pre><code>{
  "calculatedPrice": {
    "fees": {
        "netValue": 7.0,
        "grossValue": 7.49,
        "taxValue": 0.49,
        "taxCode": "REDUCED",
        "taxRate": 7.0
    },
  }
}
</code></pre></td></tr><tr><td><code>totalFee</code></td><td><p>Sum of all fees applied on the line items. It's a sum of <code>items[].calculatedPrice.totalFee</code>, WITH applied discounts.</p><pre><code>{
  "calculatedPrice": {
    "totalFee": {
        "netValue": 6.162,
        "grossValue": 6.594,
        "taxValue": 0.432,
        "taxCode": "REDUCED",
        "taxRate": 7.0,
        "appliedDiscounts": [
            {
                "id": "LS100EUROTOTAL",
                "value": 0.896,
                "price": {
                    "netValue": 0.838,
                    "grossValue": 0.896,
                    "taxValue": 0.058,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                },
                "discountType": "ABSOLUTE",
                "origin": "INTERNAL"
            }
        ]
    },
  }
}
</code></pre></td></tr><tr><td><code>shipping</code></td><td><p>The calculated shipping cost. It takes the sum of <code>items[].calculatedPrice.price.grossValue</code> for shipping estimation. It's shipping cost WITHOUT applied discounts.</p><pre><code>{
  "calculatedPrice": {
    "shipping": {
        "netValue": 7.22,
        "grossValue": 7.725,
        "taxValue": 0.505,
        "taxCode": "REDUCED",
        "taxRate": 7.0
    },
  }
}
</code></pre></td></tr><tr><td><code>totalShipping</code></td><td><p>The total shipping cost is calculated by summing <code>items[].calculatedPrice.price.grossValue</code> for shipping estimation. <code>grossValue</code> is used because, even for zero-tax items, it remains equal to <code>netValue</code>. It's a shipping cost WITH applied discounts.</p><pre><code>{
  "calculatedPrice": {
    "totalShipping" : {
        "netValue": 6.355,
        "grossValue": 6.8,
        "taxValue": 0.445,
        "taxCode": "REDUCED",
        "taxRate": 7.0,
        "appliedDiscounts": [
            {
                "id": "LS100EUROTOTAL",
                "value": 0.925,
                "price": {
                    "netValue": 0.864,
                    "grossValue": 0.925,
                    "taxValue": 0.061,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                },
                "discountType": "ABSOLUTE",
                "origin": "INTERNAL"
            }
        ]
    },
  }
}
</code></pre></td></tr><tr><td><code>totalDiscount</code></td><td><p>A summary of all discounts. It's the sum of all <code>lines[].totalDiscount</code> and shipping discounts. When discount is applied before tax the value equals <code>price.netValue</code> and <code>price.grossValue</code> for discount applied after tax.</p><pre><code>{
  "calculatedPrice": {
     "totalDiscount" : {
          "calculationType": "ApplyDiscountAfterTax",
          "value": 380.0,
          "price": {
              "netValue": 320.853,
              "grossValue": 380.0,
              "taxValue": 59.147
          },
          "appliedDiscounts": [
              {
                  "id": "buy-2-get-1-free",
                  "value": 280.000,
                  "price": {
                      "netValue": 235.294,
                      "grossValue": 280.000,
                      "taxValue": 44.706,
                      "taxCode": "STANDARD",
                      "taxRate": 19.0
                  },
                  "discountType": "PERCENT",
                  "origin": "EXTERNAL"
              },
              {
                  "id": "LS100EUROTOTAL",
                  "value": 100.000,
                  "price": {
                      "netValue": 85.559,
                      "grossValue": 100.000,
                      "taxValue": 14.441
                  },
                  "discountType": "ABSOLUTE",
                  "origin": "INTERNAL"
              }
          ]
      } ]
    },
  }
}
</code></pre></td></tr><tr><td><code>finalPrice</code></td><td><p>The final price is the sum of <code>items[].finalPrice</code>, <code>totalShipping</code>.</p><pre><code>{
  "calculatedPrice": {
    "finalPrice": {
            "netValue": 393.75,
            "grossValue": 455.215,
            "taxValue": 61.465,
            "taxAggregate": {
                "lines": [
                    {
                        "netValue": 111.239,
                        "grossValue": 119.027,
                        "taxValue": 7.788,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    {
                        "netValue": 282.511,
                        "grossValue": 336.188,
                        "taxValue": 53.677,
                        "taxCode": "STANDARD",
                        "taxRate": 19.0
                    }
                ]
            }
        }
    }
}
</code></pre></td></tr><tr><td><code>finalPrice.taxAggregate</code> - <code>lines</code></td><td><p>A list of tax values grouped by <code>taxCode</code> and <code>taxRate</code>. It includes the sum of <code>item[].calculatedPrice.discountedPrice</code> or <code>item[].calculatedPrice.price</code>, <code>item[].calculatedPrice.fees[].discountedPrice</code> or <code>item[].calculatedPrice.fees[].price</code>, <code>calculatedPrice.totalShipping</code> and <code>calculatedPrice.paymentFees</code>. If any of these values have the same <code>taxRate</code> but different <code>taxCode</code>, they are listed separately. The aggregation also includes items that do not have a <code>taxRate</code> or <code>taxCode</code> defined.</p><pre><code>{
  "finalPrice": {
    "taxAggregate" : {
      "lines": [
          {
              "netValue": 111.239,
              "grossValue": 119.027,
              "taxValue": 7.788,
              "taxCode": "REDUCED",
              "taxRate": 7.0
          },
          {
              "netValue": 282.511,
              "grossValue": 336.188,
              "taxValue": 53.677,
              "taxCode": "STANDARD",
              "taxRate": 19.0
          } ]
      }
  }
}
</code></pre></td></tr></tbody></table>

See the sections below for shipping, payment fee, tax and discounts calculations.

## How is shipping calculated

The shipping calculation depends on the stage at which it is done.

* In the cart, where the address, delivery method, and zone are not available yet, the calculation uses the minimum shipping estimation. At this stage, `sites.homeBase.Address` is used as the `shipFromAddress`, and the `shipToAddress` is created based on the cart’s `countryCode` and `zipCode`.
  See the [Calculating the minimum shipping costs](https://developer.emporix.io/api-references/api-guides-and-references/delivery-and-shipping/shipping/api-reference/shipping-cost#post-shipping-tenant-site-quote-minimum) endpoint.
* In the checkout, where information about the delivery window and zone is already available, the calculation uses the following endpoints: [Calculating the final shipping cost](https://developer.emporix.io/api-references/api-guides-and-references/delivery-and-shipping/shipping/api-reference/shipping-cost#post-shipping-tenant-site-quote), or [Calculating the shipping cost for a given slot](https://developer.emporix.io/api-references/api-guides-and-references/delivery-and-shipping/shipping/api-reference/shipping-cost#post-shipping-tenant-site-quote-slot) accordingly.

{% hint style="danger" %}
Always make sure that your site’s `homeBase.address` has the `country` and `zip-code` information included. It's mandatory for shipping calculations.
{% endhint %}

## How to calculate a payment fee at cart level

At the cart level, only one additional fee is calculated, apart from the fees applied at the item level. The `paymentFees` is an additional, non-discountable amount that the customer must pay for using a given payment method.

The fee has a specific format, and there are two options for calculating it:

* ABSOLUTE - the value of defined fee’s attribute `feeAbsolute.amount`, where the amount is treated as `netValue`.
* PERCENT - the fee is calculated as a percentage of the total net value of all item lines' `finalPrice.netValue`, plus the cart’s `calculatedPrice.totalShipping.netValue`. The fee is specified by the `feePercentage` attribute.

If the fee is taxable and has a tax code, the gross value is calculated. Otherwise, the `grossValue` is equal to `netValue`.

## How to determine a tax country at cart level

Since the shipping address is not set in the cart, you need to determine the country to find the `taxRate` for a fee that has a `taxCode` only.\
Ways to find the country data:

* Use the country code that is set on the cart
* If the cart has a customer, check the customer addresses, based on site’s setting `taxDeterminationBasedOn`:
  * SHIPPING\_ADDRESS - use the address that is tagged with `SHIPPING`, select the default address or the first match.
  * BILLING\_ADDRESS - use the address that is tagged with `BILLING`, select the default address or the first match.\
    If the matching address is not found, return an error.
* Get country code from site’s `homeBase.address.country`.

## How to apply discounts at cart level

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

To add a custom fee to the cart, you need to send the request to the endpoint. Provide the customer cart's ID in the cartId path parameter. The payload has to include the "itemType" : "EXTERNAL" parameter - see the [Adding a product to a cart](https://developer.emporix.io/api-references/api-guides-and-references/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) documentation.

## How to apply separation of the same line items in the cart

When you add an item to the cart, it's stored as a single line. If you add the same item multiple times, it remains a single line item, but the `quantity` attribute is updated to reflect the total amount, for example when you add 5 items they are stored as `item1: productA, qty:5`.

If you need to add the same item multiple times on separate lines in the cart, use the `keepAsSeparateLineItem=true` flag - it ensures each instance of the item appears as a distinct line item. This can be useful in a variety of scenarios, such as applying different discounts or fees to the same product, or handling separate delivery options.

A common use case is the _Buy 2, Get 1 Free_ promotion. In this case, when a customer adds two of the same line items to the cart, the system can add a third instance as a separate line item marked as free.

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

### Usage examples

**Adding multiple `productA` items with the `keepAsSeparateLineItem=true` flag**

1. Adding the first `productA` item with `keepAsSeparateLineItem=true` results in:

```js
item0: productA, qty:1, keepAsSeparateLineItem=true
```

2. Adding another `productA` item with `keepAsSeparateLineItem=true` results in:

```js
item0: productA, qty:1, keepAsSeparateLineItem=true
item1: productA, qty:1, keepAsSeparateLineItem=true 
```

**Adding multiple `productA` items with the `keepAsSeparateLineItem=false` flag**

1. Adding the first `productA` item with `keepAsSeparateLineItem=false` results in:

```js
item0: productA, qty:1, keepAsSeparateLineItem=false
```

2. Adding another `productA` item with `keepAsSeparateLineItem=false` results in:

```js
item0: productA, qty:2, keepAsSeparateLineItem=false
```

**Adding multiple `productA` items with the `keepAsSeparateLineItem=true` and `keepAsSeparateLineItem=false` flags**

1. Adding the first `productA` item with two different flags results in:

```js
item0: productA, qty:1, keepAsSeparateLineItem=true 
item2: productA, qty:1, keepAsSeparateLineItem=false 
```

2. Adding another two `productA` items with different flags results in:

```js
item0: productA, qty:1, keepAsSeparateLineItem=true 
item1: productA, qty:1, keepAsSeparateLineItem=true 
item2: productA, qty:2, keepAsSeparateLineItem=false 
```

### Products with external prices

You can add external prices for both custom products and products from the internal catalog. Line items for the same product can have different prices if they’re added separately with `keepAsSeparateLineItem=true`.

For example:

1. Adding the first `productA` item with `priceX` and `keepAsSeparateLineItem=true` results in

```js
item0: productA, external, priceX, qty:1, keepAsSeparateLineItem=true 
```

2. Adding another `productA` item to it, but with `priceY` and `keepAsSeparateLineItem=true` results in:

```js
item0: productA, external, priceX, qty:1, keepAsSeparateLineItem=true 
item1: productA, external, priceY, qty:1, keepAsSeparateLineItem=true 
```

### Products with standard prices

When using internal prices, the `priceId` is the same across all line items - if the product uses a standard price from the catalog, all lines for that item are expected to have the same price.

For example:

1. Adding the first `productA` item with `priceX` and `keepAsSeparateLineItem=true` results in:

```js
item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=true 
```

2. Adding another `productA` item with different `priceY` and `keepAsSeparateLineItem=true` results in:

```js
item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=true 
item1: productA, internal, priceY, qty:1, keepAsSeparateLineItem=true 
```

* If `cartItemValidationSkipExistingItemsValidationOnAddToCart=false`, the validation occurs, and an error is thrown due to the price mismatch.
* If `cartItemValidationSkipExistingItemsValidationOnAddToCart=true`, the validation does not occur, and the cart accepts the new line item.

{% hint style="warning" %}
When the cart item validation is not executed on `add to cart`, you can use the [cart validation](https://developer.emporix.io/api-references/api-guides-and-references/~/revisions/yWwHvejmTq395ReuRRIQ/checkout/cart/api-reference/carts#get-cart-tenant-carts-cartid-validate) endpoint. It should return errors informing that the prices are duplicated.

EXTERNAL pricing products can have different prices in the cart, INTERNAL pricing products can't.
{% endhint %}

**Adding products with internal and external pricing**

When you add the same product first as an internal one and then as an external, the items are split into separate line items even if `keepAsSeparateLineItem=false`, or if the flag is not present.

1. Adding `productA` item, with internal `priceX` and `keepAsSeparateLineItem=false` results in:

```js
  item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=false`
```

2. Adding `productA` item to it, with external `priceY` and `keepAsSeparateLineItem=false` results in:

```js
  item0: productA, internal, priceX, qty:1, keepAsSeparateLineItem=false 
  item0: productA, external, priceY, qty:1, keepAsSeparateLineItem=false
```
