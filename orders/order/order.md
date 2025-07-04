---
seo:
  title: Order Service Tutorials
  description: order
icon: graduation-cap
---

# Order Tutorial

The Order Service is divided into two categories based on who manages the orders:

* **Tenant-Managed Orders** – This refers to the management of customer orders. Customers create the orders, which are then accessible to your employees for processing, status updates, and data modifications.
* **Customer-Managed Orders** – These are orders submitted by your customers. When logged into their account, customers can view and access their order history.

As Emporix offers full commerce functionality, order calculations and management can be handled end-to-end by our Commerce Orchestration Platform services. However, to support integrations with other systems, we have also introduced other capabilities. Order management with external systems can be approached using three different models:

* asynchronous calculation
* synchronous calculation
* ERP calculated orders

## Asynchronous calculation

Emporix utilizes an asynchronous pricing model, where all price calculations are dynamically determined at the cart/checkout stage. Product prices are initially replicated from an ERP system and stored in the Emporix, ensuring consistency across the platform.

During checkout, the final price is calculated based on customer-specific details, such as shipping address or payment methods. Prices are categorized into net or gross price models, depending on the price type, with customer assignments managed at the ship-to level:

* Pricing rules (net or gross) are assigned based on the shipping address of the customer.
* Different locations may have different tax regulations, so the system determines which price model applies based on where the order is being shipped.

Once an order is placed, the order information simply reflects the calculated prices without further modifications, ensuring accuracy and transparency in the final transaction.

<figure><img src="../../static/order/diagram1.svg" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
To learn how pricing is calculated at Emporix, see the [Cart Service Tutorials](../../checkout/cart/cart.md#pricing-calculations).
{% endhint %}

## Synchronous calculation

In this approach, the Emporix cart interacts with an ERP system to retrieve real-time order calculations. Instead of using the Emporix calculation, the checkout uses the calculation provided by the ERP.

Commerce Orchestration Platform (COP) enables this functionality with external pricing, ensuring real-time accuracy.

Communication with the ERP system occurs using the BFF (Backend-for-Frontend) layer and with a [POST](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders) request the order is send to an ERP system. This architecture ensures a secure, real-time pricing model while leveraging external systems for order calculations.

<figure><img src="../../static/order/diagram2.svg" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
For more information, see the [External Pricing](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) guides.
{% endhint %}

## ERP calculated order

With this use case, the Commerce Orchestration Platform cart is used to collect products and customer details, such as addresses. However, instead of using COP for final price calculations at checkout, the BFF (Backend-for-Frontend) layer communicates with the ERP to simulate the order, ensuring that all pricing, discounts, and rules from the ERP are applied before order creation.

Once the order is validated and priced by the ERP, the BFF layer creates the order in COP using the [Sales Order API](api-reference/). This allows for seamless integration between Emporix and the external ERP system while maintaining flexibility in how orders are processed.

<figure><img src="../../static/order/diagram3.svg" alt=""><figcaption></figcaption></figure>

## Order calculation approaches comparison

| **Aspect**                | **Asynchronous Calculation (Emporix driven)**                                                           | **Synchronous Calculation (External pricing)**                                                | **ERP Calculated Order**                                                                       |
| ------------------------- | ------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| **Cart Usage**            | Emporix cart handles product selection & pricing.                                                       | Emporix cart calls an external system for pricing.                                            | Emporix cart is used to collect products & addresses.                                          |
| **Price Calculation**     | Calculated at checkout within Emporix COP based on customer details (address, shipping, payment, etc.). | Fetched dynamically from an external system when items are displayed or added to the cart.    | Calculated at checkout by ERP simulating an order.                                             |
| **Checkout Process**      | Handled entirely within Emporix.                                                                        | Checkout is using external pricing.                                                           | Checkout occurs in Emporix, but order is simulated with an ERP system first.                   |
| **Order Processing**      | Order info reflects the calculated prices from checkout.                                                | Order is processed entirely in the external system (not Emporix).                             | Order is created in Emporix via the Sales Order API after ERP calculation.                     |
| **Data Flow**             | Prices are replicated from ERP and stored in Emporix for calculation at checkout.                       | BFF fetches prices from ERP dynamically during cart interactions.                             | BFF sends cart details to ERP at checkout, then creates an order in Emporix.                   |
| **Where Pricing Happens** | In Emporix COP during checkout.                                                                         | In an external system during cart interactions.                                               | In ERP during checkout calculation (before order creation in Emporix).                         |
| **Security**              | Secure – prices stored in Emporix cannot be altered.                                                    | Secure – only BFF can fetch external prices, preventing tampering.                            | Secure – BFF ensures price integrity before order creation.                                    |
| **Use Case**              | Best for businesses that want Emporix to manage pricing and apply customer-specific rules at checkout.  | Ideal when ERP must control pricing in real time, and checkout happens in an external system. | Suitable when ERP validation is needed before order creation, but checkout remains in Emporix. |

## Summary of differences

* **Asynchronous calculation** - Emporix controls pricing (replicated from ERP), and calculation happens at checkout.
* **Synchronous calculation** - Pricing is provided by an external system, for example an ERP in real time, and checkout/order processing happens with external prices.
* **ERP calculated order** - Emporix cart is used, but ERP simulates pricing at checkout before the order is created in Emporix.

## Payload example

{% hint style="warning" %}

<details>
<summary>See the order calculation payload example</summary>

```json
  {
    "id": "EON1200",
    "createdBy": "45620894",
    "status": "CREATED",
    "lastStatusChange": "2025-06-10T12:31:39.614Z",
    "created": "2025-06-10T12:31:39.614Z",
    "channel": {
        "name": "storefront",
        "source": "https://your-storefront.com/"
    },
    "cartId": "68481e9e8bf22744fc578572",
    "entries": [
        {
            "id": "0_SLI_samsung-galaxy-s24-gross",
            "itemYrn": "urn:yaas:saasag:caasproduct:product:b2b2cstage;samsung-galaxy-s24-gross",
            "keepAsSeparateLineItem": true,
            "type": "INTERNAL",
            "amount": 2,
            "orderedAmount": 2,
            "effectiveQuantity": 2.0,
            "originalAmount": 350,
            "originalPrice": 350,
            "unitPrice": 350,
            "calculatedUnitPrice": {
                "netValue": 294.118,
                "grossValue": 350.0,
                "taxValue": 55.882,
                "taxCode": "STANDARD",
                "taxRate": 19.0
            },
            "totalPrice": 700.0,
            "authorizedAmount": 700.0,
            "product": {
                "id": "samsung-galaxy-s24-gross",
                "sku": "Samsung Galaxy s24 gross",
                "name": "Samsung Galaxy s24 gross",
                "localizedName": {
                    "en": "Samsung Galaxy s24 gross"
                },
                "published": true,
                "images": [
                    {
                        "id": "67169928ceaab717e17f3734",
                        "url": "http://res.cloudinary.com/saas-ag/image/upload/v1729534248/b2b2cstage/media/67169928ceaab717e17f3734",
                        "stored": false
                    }
                ],
                "productType": "BASIC"
            },
            "tax": {
                "lines": [
                    {
                        "amount": 111.76,
                        "currency": "EUR",
                        "code": "STANDARD",
                        "name": "STANDARD",
                        "rate": 19.0,
                        "sequenceId": 0,
                        "inclusive": true
                    }
                ],
                "total": {
                    "amount": 0,
                    "currency": "EUR",
                    "inclusive": true
                }
            },
            "price": {
                "priceId": "679ca63dbcdefe5b380c98bc",
                "priceListId": "abc123",
                "currency": "EUR",
                "originalAmount": 350.0,
                "effectiveAmount": 350.0,
                "basePrice": {},
                "presentationPrice": {},
                "metadata": {
                    "createdAt": "2025-01-31T10:30:21.998Z",
                    "modifiedAt": "2025-01-31T10:30:21.998Z",
                    "version": 1
                }
            },
            "totalDiscount": {
                "amount": 84.06,
                "currency": "EUR"
            },
            "fees": {
                "elements": [
                    {
                        "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                        "name": {
                            "de": "Apple Picking Fee",
                            "en": "Apple Picking Fee"
                        },
                        "taxCode": "REDUCED",
                        "total": {
                            "subTotal": 3.5,
                            "totalTax": 0.0,
                            "total": 3.08
                        }
                    }
                ],
                "total": {
                    "subTotal": 3.5,
                    "totalTax": 0.0,
                    "total": 3.08
                }
            },
            "metadata": {
                "mixins": {
                    "fees": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/fees_checkout-mashup.json"
                }
            },
            "mixins": {
                "fees": {
                    "elements": [
                        {
                            "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                            "name": {
                                "de": "Apple Picking Fee",
                                "en": "Apple Picking Fee"
                            },
                            "taxCode": "REDUCED",
                            "total": {
                                "subTotal": 3.5,
                                "totalTax": 0.0,
                                "total": 3.08,
                                "discount": 0.42
                            }
                        }
                    ],
                    "total": {
                        "subTotal": 3.5,
                        "totalTax": 0.0,
                        "total": 3.08,
                        "discount": 0.42
                    }
                }
            },
            "calculatedPrice": {
                "price": {
                    "netValue": 588.235,
                    "grossValue": 700.0,
                    "taxValue": 111.765,
                    "taxCode": "STANDARD",
                    "taxRate": 19.0
                },
                "discountedPrice": {
                    "netValue": 282.862,
                    "grossValue": 336.606,
                    "taxValue": 53.744,
                    "taxCode": "STANDARD",
                    "taxRate": 19.0,
                    "appliedDiscounts": [
                        {
                            "value": 83.394,
                            "price": {
                                "netValue": 70.079,
                                "grossValue": 83.394,
                                "taxValue": 13.315,
                                "taxCode": "STANDARD",
                                "taxRate": 19.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        },
                        {
                            "id": "buy-2-get-1-free",
                            "value": 280.0,
                            "price": {
                                "netValue": 235.294,
                                "grossValue": 280.0,
                                "taxValue": 44.706,
                                "taxCode": "STANDARD",
                                "taxRate": 19.0
                            },
                            "discountType": "PERCENT",
                            "origin": "EXTERNAL"
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
                            "netValue": 3.083,
                            "grossValue": 3.299,
                            "taxValue": 0.216,
                            "taxCode": "REDUCED",
                            "taxRate": 7.0,
                            "appliedDiscounts": [
                                {
                                    "value": 0.446,
                                    "price": {
                                        "netValue": 0.417,
                                        "grossValue": 0.446,
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
                    "netValue": 3.083,
                    "grossValue": 3.299,
                    "taxValue": 0.216,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "value": 0.446,
                            "price": {
                                "netValue": 0.417,
                                "grossValue": 0.446,
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
                    "value": 363.84,
                    "price": {
                        "netValue": 305.79,
                        "grossValue": 363.84,
                        "taxValue": 58.05
                    },
                    "appliedDiscounts": [
                        {
                            "value": 83.84,
                            "price": {
                                "netValue": 70.496,
                                "grossValue": 83.84,
                                "taxValue": 13.344
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        },
                        {
                            "id": "buy-2-get-1-free",
                            "value": 280.0,
                            "price": {
                                "netValue": 235.294,
                                "grossValue": 280.0,
                                "taxValue": 44.706,
                                "taxCode": "STANDARD",
                                "taxRate": 19.0
                            },
                            "discountType": "PERCENT",
                            "origin": "EXTERNAL"
                        }
                    ]
                },
                "finalPrice": {
                    "netValue": 285.945,
                    "grossValue": 339.905,
                    "taxValue": 53.96
                }
            },
            "priceMatchDetails": {
                "netValue": 294.11764705882354,
                "grossValue": 350.0,
                "taxValue": 55.88235294117647,
                "taxCode": "STANDARD",
                "taxRate": 19,
                "taxCountry": "DE"
            },
            "externalDiscounts": [
                {
                    "id": "buy-2-get-1-free",
                    "discountType": "PERCENT",
                    "value": 40.0,
                    "sequence": 1
                }
            ]
        },
        {
            "id": "shirt--301722c1-23e8-42b4-a4d8-1a5480fe3ea5",
            "itemYrn": "urn:yaas:saasag:caasproduct:product:b2b2cstage;shirt--301722c1-23e8-42b4-a4d8-1a5480fe3ea5",
            "keepAsSeparateLineItem": false,
            "type": "INTERNAL",
            "amount": 1,
            "orderedAmount": 1,
            "effectiveQuantity": 1.0,
            "originalAmount": 10,
            "originalPrice": 10,
            "unitPrice": 10,
            "calculatedUnitPrice": {
                "netValue": 9.346,
                "grossValue": 10.0,
                "taxValue": 0.654,
                "taxCode": "REDUCED",
                "taxRate": 7.0
            },
            "totalPrice": 10.0,
            "authorizedAmount": 10.0,
            "product": {
                "metadata": {
                    "mixins": {
                        "productTemplateAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/b2b2cstage/6818bfed8844a34a391a566e-templateAttributes_v1.json",
                        "productVariantAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/b2b2cstage/6818bfed8844a34a391a566e-variantAttributes_v1.json"
                    }
                },
                "id": "shirt--301722c1-23e8-42b4-a4d8-1a5480fe3ea5",
                "sku": "shirt--red",
                "name": "shirt",
                "localizedName": {
                    "en": "shirt"
                },
                "description": "[de:, en:, pl:]",
                "published": true,
                "images": [],
                "mixins": {
                    "productVariantAttributes": {
                        "color": "red"
                    }
                },
                "productType": "VARIANT"
            },
            "tax": {
                "lines": [
                    {
                        "amount": 0.65,
                        "currency": "EUR",
                        "code": "REDUCED",
                        "name": "REDUCED",
                        "rate": 7.0,
                        "sequenceId": 0,
                        "inclusive": true
                    }
                ],
                "total": {
                    "amount": 0,
                    "currency": "EUR",
                    "inclusive": true
                }
            },
            "price": {
                "priceId": "6818c032524d1c16623037e2",
                "currency": "EUR",
                "originalAmount": 10.0,
                "effectiveAmount": 10.0,
                "basePrice": {},
                "presentationPrice": {},
                "metadata": {
                    "createdAt": "2025-05-05T13:42:10.674Z",
                    "modifiedAt": "2025-05-05T13:44:20.599Z",
                    "version": 2
                }
            },
            "totalDiscount": {
                "amount": 1.19,
                "currency": "EUR"
            },
            "fees": {
                "total": {
                    "subTotal": 0.0,
                    "totalTax": 0.0,
                    "total": 0.0
                }
            },
            "metadata": {
                "mixins": {
                    "fees": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/fees_checkout-mashup.json"
                }
            },
            "mixins": {
                "fees": {
                    "total": {
                        "subTotal": 0.0,
                        "totalTax": 0.0,
                        "total": 0.0,
                        "discount": 0.0
                    }
                }
            },
            "calculatedPrice": {
                "price": {
                    "netValue": 9.346,
                    "grossValue": 10.0,
                    "taxValue": 0.654,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                },
                "discountedPrice": {
                    "netValue": 8.233,
                    "grossValue": 8.809,
                    "taxValue": 0.576,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "value": 1.191,
                            "price": {
                                "netValue": 1.113,
                                "grossValue": 1.191,
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
                    "value": 1.191,
                    "price": {
                        "netValue": 1.113,
                        "grossValue": 1.191,
                        "taxValue": 0.078,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    "appliedDiscounts": [
                        {
                            "value": 1.191,
                            "price": {
                                "netValue": 1.113,
                                "grossValue": 1.191,
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
                    "netValue": 8.233,
                    "grossValue": 8.809,
                    "taxValue": 0.576,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                }
            },
            "priceMatchDetails": {
                "netValue": 9.345794392523365,
                "grossValue": 10.0,
                "taxValue": 0.6542056074766355,
                "taxCode": "REDUCED",
                "taxRate": 7,
                "taxCountry": "DE"
            }
        },
        {
            "id": "2_SLI_samsung-galaxy-s27-gross",
            "itemYrn": "urn:yaas:saasag:caasproduct:product:b2b2cstage;samsung-galaxy-s27-gross",
            "keepAsSeparateLineItem": true,
            "type": "INTERNAL",
            "amount": 2,
            "orderedAmount": 2,
            "effectiveQuantity": 2.0,
            "originalAmount": 55,
            "originalPrice": 55,
            "unitPrice": 55,
            "calculatedUnitPrice": {
                "netValue": 51.402,
                "grossValue": 55.0,
                "taxValue": 3.598,
                "taxCode": "REDUCED",
                "taxRate": 7.0
            },
            "totalPrice": 110.0,
            "authorizedAmount": 143.0,
            "product": {
                "id": "samsung-galaxy-s27-gross",
                "sku": "samsung-galaxy-s27-gross",
                "name": "samsung-galaxy-s27-gross",
                "localizedName": {
                    "en": "samsung-galaxy-s27-gross"
                },
                "description": "[en:samsung-galaxy-s27-gross]",
                "published": true,
                "images": [],
                "productType": "BASIC"
            },
            "tax": {
                "lines": [
                    {
                        "amount": 7.2,
                        "currency": "EUR",
                        "code": "REDUCED",
                        "name": "REDUCED",
                        "rate": 7.0,
                        "sequenceId": 0,
                        "inclusive": true
                    }
                ],
                "total": {
                    "amount": 0,
                    "currency": "EUR",
                    "inclusive": true
                }
            },
            "price": {
                "priceId": "6797da2f3537716a5a537ecf",
                "currency": "EUR",
                "originalAmount": 55.0,
                "effectiveAmount": 55.0,
                "basePrice": {},
                "presentationPrice": {},
                "metadata": {
                    "createdAt": "2025-01-27T19:10:39.966Z",
                    "modifiedAt": "2025-04-14T07:54:30.431Z",
                    "version": 23
                }
            },
            "totalDiscount": {
                "amount": 13.56,
                "currency": "EUR"
            },
            "fees": {
                "elements": [
                    {
                        "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                        "name": "Apple Picking Fee",
                        "taxCode": "REDUCED",
                        "total": {
                            "subTotal": 3.5,
                            "totalTax": 0.0,
                            "total": 3.08
                        }
                    }
                ],
                "total": {
                    "subTotal": 3.5,
                    "totalTax": 0.0,
                    "total": 3.08
                }
            },
            "metadata": {
                "mixins": {
                    "fees": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/fees_checkout-mashup.json"
                }
            },
            "mixins": {
                "fees": {
                    "elements": [
                        {
                            "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                            "name": "Apple Picking Fee",
                            "taxCode": "REDUCED",
                            "total": {
                                "subTotal": 3.5,
                                "totalTax": 0.0,
                                "total": 3.08,
                                "discount": 0.42
                            }
                        }
                    ],
                    "total": {
                        "subTotal": 3.5,
                        "totalTax": 0.0,
                        "total": 3.08,
                        "discount": 0.42
                    }
                }
            },
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
                    "netValue": 90.556,
                    "grossValue": 96.895,
                    "taxValue": 6.339,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "value": 13.105,
                            "price": {
                                "netValue": 12.248,
                                "grossValue": 13.105,
                                "taxValue": 0.857,
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
                            "netValue": 3.083,
                            "grossValue": 3.299,
                            "taxValue": 0.216,
                            "taxCode": "REDUCED",
                            "taxRate": 7.0,
                            "appliedDiscounts": [
                                {
                                    "value": 0.446,
                                    "price": {
                                        "netValue": 0.417,
                                        "grossValue": 0.446,
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
                    "netValue": 3.083,
                    "grossValue": 3.299,
                    "taxValue": 0.216,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0,
                    "appliedDiscounts": [
                        {
                            "value": 0.446,
                            "price": {
                                "netValue": 0.417,
                                "grossValue": 0.446,
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
                    "value": 13.551,
                    "price": {
                        "netValue": 12.665,
                        "grossValue": 13.551,
                        "taxValue": 0.886,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    "appliedDiscounts": [
                        {
                            "value": 13.551,
                            "price": {
                                "netValue": 12.665,
                                "grossValue": 13.551,
                                "taxValue": 0.886,
                                "taxCode": "REDUCED",
                                "taxRate": 7.0
                            },
                            "discountType": "ABSOLUTE",
                            "origin": "INTERNAL"
                        }
                    ]
                },
                "finalPrice": {
                    "netValue": 93.639,
                    "grossValue": 100.194,
                    "taxValue": 6.555,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                }
            },
            "priceMatchDetails": {
                "netValue": 51.401869158878505,
                "grossValue": 55.0,
                "taxValue": 3.5981308411214954,
                "taxCode": "REDUCED",
                "taxRate": 7,
                "taxCountry": "DE"
            }
        }
    ],
    "discounts": [
        {
            "code": "TOTAL",
            "amount": 100.0,
            "currency": "EUR",
            "sequenceId": 1,
            "categoryRestricted": false
        },
        {
            "code": "LS100EUROTOTAL",
            "amount": 100.0,
            "currency": "EUR",
            "name": "LS100EUROTOTAL",
            "calculationType": "ApplyDiscountBeforeTax",
            "discountType": "ABSOLUTE",
            "discountCalculationType": "TOTAL",
            "categoryRestricted": false
        }
    ],
    "customer": {
        "id": "45620894",
        "name": "John Dutton",
        "firstName": "John",
        "lastName": "Dutton",
        "email": "cartb2c.emporix@yopmail.com"
    },
    "siteCode": "GrossSite",
    "countryCode": "DE",
    "billingAddress": {
        "contactName": "Dom",
        "street": "Kochanowskiego",
        "streetNumber": "21",
        "streetAppendix": "",
        "zipCode": "44-122",
        "city": "Gliwice",
        "country": "DE",
        "state": "Slaskie",
        "contactPhone": ""
    },
    "shippingAddress": {
        "contactName": "Dom",
        "street": "Kochanowskiego",
        "streetNumber": "21",
        "streetAppendix": "",
        "zipCode": "44-122",
        "city": "Gliwice",
        "country": "DE",
        "state": "Slaskie",
        "contactPhone": ""
    },
    "payments": [
        {
            "status": "PENDING",
            "method": "invoice",
            "paidAmount": 0,
            "currency": "EUR",
            "provider": "stripe"
        }
    ],
    "shipping": {
        "total": {
            "amount": 10.71,
            "currency": "EUR"
        },
        "lines": [
            {
                "amount": 10.0,
                "currency": "EUR",
                "code": "Pickup",
                "name": "Pickup",
                "localizedName": {
                    "en": "Pickup"
                },
                "tax": {
                    "total": {
                        "amount": 1.9,
                        "currency": "EUR",
                        "inclusive": false
                    },
                    "rate": 19.0
                },
                "shippingTaxCode": "STANDARD"
            }
        ]
    },
    "tax": {
        "lines": [
            {
                "amount": 7.85,
                "currency": "EUR",
                "code": "REDUCED",
                "name": "REDUCED",
                "rate": 7.0,
                "sequenceId": 0,
                "inclusive": false
            },
            {
                "amount": 113.66,
                "currency": "EUR",
                "code": "STANDARD",
                "name": "STANDARD",
                "rate": 19.0,
                "sequenceId": 1,
                "inclusive": false
            }
        ],
        "total": {
            "amount": 1.9,
            "currency": "EUR",
            "inclusive": false
        }
    },
    "subTotalPrice": 820.0,
    "totalPrice": 812.79,
    "totalAuthorizedAmount": 534.829,
    "currency": "EUR",
    "metadata": {
        "mixins": {
            "payments": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/CAAS/fees_checkout-mashup.json",
            "generalAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/orderGeneralAttributesMixIn.v9.json"
        },
        "version": 1
    },
    "mixins": {
        "payments": {
            "elements": [
                {
                    "paymentMethodYrn": "urn:yaas:hybris:payments:payment-method:b2b2cstage;invoice",
                    "fees": {
                        "elements": [
                            {
                                "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;678f552a949c723de46bdb14",
                                "name": {
                                    "de": "Payment fee",
                                    "en": "Payment fee"
                                },
                                "taxCode": "REDUCED",
                                "total": {
                                    "subTotal": 73.89,
                                    "totalTax": 0.0,
                                    "total": 73.89,
                                    "discount": 0.0
                                }
                            }
                        ],
                        "total": {
                            "subTotal": 0,
                            "totalTax": 0,
                            "total": 0,
                            "discount": 0
                        }
                    },
                    "total": {
                        "subTotal": 73.89,
                        "totalTax": 0.0,
                        "total": 73.89,
                        "discount": 0.0
                    }
                }
            ],
            "total": {
                "subTotal": 73.89,
                "totalTax": 0.0,
                "total": 73.89,
                "discount": 0.0
            }
        },
        "generalAttributes": {
            "extendedOrderStatus": "10",
            "customerFirstOrder": false,
            "orderNumber": "EON1200"
        }
    },
    "feeYrnAggregate": {
        "elements": [
            {
                "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;677d49ca3a421b451eab23f2",
                "name": {
                    "de": "Apple Picking Fee",
                    "en": "Apple Picking Fee"
                },
                "taxCode": "REDUCED",
                "total": {
                    "subTotal": 7.0,
                    "totalTax": 0.0,
                    "total": 6.16
                }
            },
            {
                "yrn": "urn:yaas:saasag:fee:fee:b2b2cstage;678f552a949c723de46bdb14",
                "name": {
                    "de": "Payment fee",
                    "en": "Payment fee"
                },
                "taxCode": "REDUCED",
                "total": {
                    "subTotal": 73.89,
                    "totalTax": 0.0,
                    "total": 73.89
                }
            }
        ],
        "total": {
            "subTotal": 80.89,
            "totalTax": 0.0,
            "total": 80.05
        }
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
            "netValue": 381.651,
            "grossValue": 442.31,
            "taxValue": 60.659,
            "appliedDiscounts": [
                {
                    "value": 97.69,
                    "price": {
                        "netValue": 83.44,
                        "grossValue": 97.69,
                        "taxValue": 14.25
                    },
                    "discountType": "ABSOLUTE",
                    "origin": "INTERNAL"
                },
                {
                    "id": "buy-2-get-1-free",
                    "value": 280.0,
                    "price": {
                        "netValue": 235.294,
                        "grossValue": 280.0,
                        "taxValue": 44.706,
                        "taxCode": "STANDARD",
                        "taxRate": 19.0
                    },
                    "discountType": "PERCENT",
                    "origin": "EXTERNAL"
                }
            ]
        },
        "paymentFees": [
            {
                "id": "678f552a949c723de46bdb14",
                "type": "PERCENT",
                "origin": "INTERNAL",
                "name": {
                    "de": "Payment fee",
                    "en": "Payment fee"
                },
                "price": {
                    "netValue": 39.663,
                    "grossValue": 42.439,
                    "taxValue": 2.776,
                    "taxCode": "REDUCED",
                    "taxRate": 7.0
                }
            }
        ],
        "fees": {
            "netValue": 46.663,
            "grossValue": 49.929,
            "taxValue": 3.266,
            "taxCode": "REDUCED",
            "taxRate": 7.0
        },
        "totalFee": {
            "netValue": 45.829,
            "grossValue": 49.037,
            "taxValue": 3.208,
            "taxCode": "REDUCED",
            "taxRate": 7.0,
            "appliedDiscounts": [
                {
                    "value": 0.892,
                    "price": {
                        "netValue": 0.834,
                        "grossValue": 0.892,
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
            "netValue": 10.0,
            "grossValue": 11.9,
            "taxValue": 1.9,
            "taxCode": "STANDARD",
            "taxRate": 19.0
        },
        "totalShipping": {
            "netValue": 8.808,
            "grossValue": 10.482,
            "taxValue": 1.674,
            "taxCode": "STANDARD",
            "taxRate": 19.0,
            "appliedDiscounts": [
                {
                    "value": 1.418,
                    "price": {
                        "netValue": 1.192,
                        "grossValue": 1.418,
                        "taxValue": 0.226,
                        "taxCode": "STANDARD",
                        "taxRate": 19.0
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
                "netValue": 320.76,
                "grossValue": 380.0,
                "taxValue": 59.24
            },
            "appliedDiscounts": [
                {
                    "value": 100.0,
                    "price": {
                        "netValue": 85.466,
                        "grossValue": 100.0,
                        "taxValue": 14.534
                    },
                    "discountType": "ABSOLUTE",
                    "origin": "INTERNAL"
                },
                {
                    "id": "buy-2-get-1-free",
                    "value": 280.0,
                    "price": {
                        "netValue": 235.294,
                        "grossValue": 280.0,
                        "taxValue": 44.706,
                        "taxCode": "STANDARD",
                        "taxRate": 19.0
                    },
                    "discountType": "PERCENT",
                    "origin": "EXTERNAL"
                }
            ]
        },
        "finalPrice": {
            "netValue": 436.288,
            "grossValue": 501.829,
            "taxValue": 65.541,
            "taxAggregate": {
                "lines": [
                    {
                        "netValue": 144.618,
                        "grossValue": 154.741,
                        "taxValue": 10.123,
                        "taxCode": "REDUCED",
                        "taxRate": 7.0
                    },
                    {
                        "netValue": 291.67,
                        "grossValue": 347.088,
                        "taxValue": 55.418,
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