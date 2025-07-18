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

<!-- <figure><img src="../../static/order/diagram1.svg" alt=""><figcaption></figcaption></figure> -->

```mermaid
---
config:
  layout: fixed
  theme: default
  look: classic
---
flowchart LR
 subgraph subGraph0["**Storefront**"]
        A["Customer"]
  end
 subgraph subGraph1["**Emporix**"]
        CS["Cart Service"]
        CHK["Checkout Service"]
        OS["Order Service"]
        WS["Webhook Service"]
  end
 subgraph subGraph2["**Customer's System**"]
        ERP["ERP"]
  end
    A -- "1.Add product to cart" --> CS
    A -- "2.Start checkout" --> CHK
    CHK -- "3.Fetch cart data" --> CS
    CHK -- "4.Create order" --> OS
    OS -- "5.Receive order.created event" --> WS
    WS -- "6.Replicate order to ERP" --> ERP
    A@{ shape: rounded}
    CS@{ shape: rounded}
    CHK@{ shape: rounded}
    OS@{ shape: rounded}
    ERP@{ shape: rounded}
    WS@{ shape: rounded}
     A:::Class_04
     CS:::Class_04
     CHK:::Class_04
     OS:::Class_04
     WS:::Class_04
     ERP:::Class_04
     subGraph1:::Class_03
     subGraph0:::Class_01
     subGraph2:::Class_02
    classDef Class_02 stroke-width:1px, stroke-dasharray: 0, stroke:#DDE6EE, fill:#DDE6EE
    classDef Class_01 stroke-width:1px, stroke-dasharray: 0, stroke:#A1BDDC, fill:#A1BDDC
    classDef Class_03 stroke-width:1px, stroke-dasharray: 0, stroke:#3b73bb, fill:#3b73bb
    classDef Class_04 fill:#F2F6FA, stroke:#E86C07
    style subGraph0 color:#FFFFFF
    style subGraph1 color:#FFFFFF
```
{% hint style="warning" %}
You have to register your listener in the Emporix Webhook Service so that the listener pushes order information to your ERP system.
{% endhint %}

{% hint style="info" %}
To learn how pricing is calculated at Emporix, see the [Cart Service Tutorials](../../checkout/cart/cart.md#pricing-calculations).
{% endhint %}

## Synchronous calculation

In this approach, the Emporix cart interacts with an ERP system to retrieve real-time order calculations. Instead of using the Emporix calculation, the checkout uses the calculation provided by the ERP.

Commerce Orchestration Platform (COP) enables this functionality with external pricing, ensuring real-time accuracy.

Communication with the ERP system occurs using the BFF (Backend-for-Frontend) layer and with a [POST](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders) request the order is send to an ERP system. This architecture ensures a secure, real-time pricing model while leveraging external systems for order calculations.

<!-- <figure><img src="../../static/order/diagram2.svg" alt=""><figcaption></figcaption></figure> -->

```mermaid
---
config:
  layout: fixed
  theme: default
  look: classic
---
flowchart LR
 subgraph subGraph0["**Storefront**"]
        A["Customer"]
  end
 subgraph subGraph1["**Emporix**"]
        CS["Cart Service"]
        CHK["Checkout Service"]
        OS["Order Service"]
        WS["Webhook Service"]
  end
 subgraph subGraph2["**Customer's System**"]
        BFF["Backend for Frontend (BFF)"]
        ERP["ERP"]
  end
    A -- "1.Add product to cart" --> BFF
    BFF -- "2.Calculate a price" --> ERP
    BFF -- "3.Add a product with an external price to a cart" --> CS
    A -- "4.Start checkout" --> CHK
    CHK -- "5.Fetch cart data" --> CS
    CHK -- "6.Create order" --> OS
    OS -- "7.Receive order.created event" --> WS
    WS -- "8.Replicate order" --> ERP
    A@{ shape: rounded}
    CS@{ shape: rounded}
    CHK@{ shape: rounded}
    OS@{ shape: rounded}
    WS@{ shape: rounded}
    BFF@{ shape: rounded}
    ERP@{ shape: rounded}
     A:::Class_04
     CS:::Class_04
     CHK:::Class_04
     OS:::Class_04
     WS:::Class_04
     BFF:::Class_04
     ERP:::Class_04
     subGraph1:::Class_03
     subGraph0:::Class_01
     subGraph2:::Class_02
    classDef Class_02 stroke-width:1px, stroke-dasharray: 0, stroke:#DDE6EE, fill:#DDE6EE
    classDef Class_01 stroke-width:1px, stroke-dasharray: 0, stroke:#A1BDDC, fill:#A1BDDC
    classDef Class_03 stroke-width:1px, stroke-dasharray: 0, stroke:#3b73bb, fill:#3b73bb
    classDef Class_04 fill:#F2F6FA, stroke:#E86C07
    style subGraph1 color:#FFFFFF
    style subGraph0 color:#FFFFFF
```

{% hint style="warning" %}
You have to register your listener in the Emporix Webhook Service so that the listener pushes order information to your ERP system.
{% endhint %}

{% hint style="info" %}
For more information, see the [External Pricing](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) guides.
{% endhint %}

## ERP calculated order

With this use case, the Commerce Orchestration Platform cart is used to collect products and customer details, such as addresses. However, instead of using COP for final price calculations at checkout, the BFF (Backend-for-Frontend) layer communicates with the ERP to simulate the order, ensuring that all pricing, discounts, and rules from the ERP are applied before order creation.

Once the order is validated and priced by the ERP, the BFF layer creates the order in COP using the [Sales Order API](api-reference/). This allows for seamless integration between Emporix and the external ERP system while maintaining flexibility in how orders are processed.

<!-- <figure><img src="../../static/order/diagram3.svg" alt=""><figcaption></figcaption></figure> -->

```mermaid
---
config:
  layout: fixed
  theme: default
  look: classic
---
flowchart LR
 subgraph subGraph0["**Storefront**"]
        A["Customer"]
  end
 subgraph subGraph1["**Emporix**"]
        CS["Cart Service"]
        OS["Order Service"]
        WS["Webhook Service"]
  end
 subgraph subGraph2["**Customer's System**"]
        BFF["Backend for Frontend (BFF)"]
        ERP["ERP"]
  end
    A -- "1.Start checkout" --> BFF
    BFF -- "2.Get cart data" --> CS
    BFF -- "3.Simulate order" --> ERP
    BFF -- "4.Create sales order" --> OS
    OS -- "5.Receive order.created event" --> WS
    WS -- "6.Replicate order" --> ERP
    A@{ shape: rounded}
    CS@{ shape: rounded}
    OS@{ shape: rounded}
    WS@{ shape: rounded}
    BFF@{ shape: rounded}
    ERP@{ shape: rounded}
     A:::Class_04
     CS:::Class_04
     OS:::Class_04
     WS:::Class_04
     BFF:::Class_04
     ERP:::Class_04
     subGraph1:::Class_03
     subGraph0:::Class_01
     subGraph2:::Class_02
    classDef Class_02 stroke-width:1px, stroke-dasharray: 0, stroke:#DDE6EE, fill:#DDE6EE
    classDef Class_01 stroke-width:1px, stroke-dasharray: 0, stroke:#A1BDDC, fill:#A1BDDC
    classDef Class_03 stroke-width:1px, stroke-dasharray: 0, stroke:#3b73bb, fill:#3b73bb
    classDef Class_04 fill:#F2F6FA, stroke:#E86C07
    style subGraph1 color:#FFFFFF
    style subGraph0 color:#FFFFFF
```

{% hint style="warning" %}
You have to register your listener in the Emporix Webhook Service so that the listener pushes order information to your ERP system.
{% endhint %}

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
            "calculatedUnitPrice": {
                "netValue": 294.118,
                "grossValue": 350.0,
                "taxValue": 55.882,
                "taxCode": "STANDARD",
                "taxRate": 19.0
            },
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
            "calculatedUnitPrice": {
                "netValue": 9.346,
                "grossValue": 10.0,
                "taxValue": 0.654,
                "taxCode": "REDUCED",
                "taxRate": 7.0
            },
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
            "calculatedUnitPrice": {
                "netValue": 51.402,
                "grossValue": 55.0,
                "taxValue": 3.598,
                "taxCode": "REDUCED",
                "taxRate": 7.0
            },
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

## How to create an order on behalf of a customer

The Order Service functionality allows your employees to act on behalf of a customer and create an order for them. This way, merchants can facilitate order process for your customers. See the steps of the order process flow. 

### Create an order as a merchant

#### Get authorization

To create an order, first get the credentials to log in as a customer on the storefront:

1. Get the `access_token` by sending the request to the [Requesting a service access token](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/service-access-token).

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/oauth/token' 
  --header 'Content-Type: application/json' 
  --data '{
    "client_id": "{client_id}",
    "client_secret": "{client_secret}",
    "grant_type": "client_credentials",
    "scope": "scope=order.order_read order.order_delete order.order_create order.order_update tenant={tenant}"
  }'
```

2. Retrieve the `anonymous_token` by sending a request to the [Requesting an anonymous token](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/anonymous-token) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl 'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id&{client_id}'
```
 
3. Log in as the customer by sending an authorization request to the [Requesting a customer token](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl 'https://api.emporix.io/customer/{tenant}/login' 
  --request POST 
  --header 'Authorization: Bearer {anonymous_access_token}' 
  --header 'Content-Type: application/json' 
  --data '{
  "email": "customer@emporix.com",
  "password": "Qwurmdch673;'"
}'
```

#### Create an order

As a merchant acting on behalf of a customer, send the request to the [Creating a new order](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../orders/order/api-reference/" %}
[api-reference](../../orders/order/api-reference)
{% endcontent-ref %}

```bash
curl --location 'https://api.emporix.io/order-v2/{tenant}/salesorders' 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: {customer_token}' 
--data-raw '{
  "entries": [
    {
      "id": "5c336893a981210009900071",
      "amount": 3,
      "orderedAmount": 3,
      "effectiveQuantity": 3,
      "calculatedUnitPrice": {
        "netValue": 294.118,
        "grossValue": 350.0,
        "taxValue": 55.882,
        "taxCode": "STANDARD",
        "taxRate": 19.0
      },
      "measurementUnit": {
        "value": 1,
        "unit": "H87"
      },
      "calculatedPrice": {
        "price": {
            "netValue": 882.354,
            "grossValue": 1050.0,
            "taxValue": 167.646,
            "taxCode": "STANDARD",
            "taxRate": 19.0
        },
        "finalPrice": {
            "netValue": 882.354,
            "grossValue": 1050.0,
            "taxValue": 167.646
        }
      }
    }
  ],
  "discounts": [],
  "customer": {
    "id": "{{first_customer_id}}",
    "name": "John Dee",
    "title": "MRS",
    "firstName": "John",
    "lastName": "Dee",
    "email": "j.dee@emporix.com",
    "metadata": {
      "mixins": {
        "generalAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/customerGeneralAttributesMixIn.v4.json",
        "backofficeAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/accountBoMixIn.v3.json",
        "payment": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/paymentMixIn.v3.json",
        "marketing": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/accountMarketingMixIn.v4.json",
        "administration": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/administrativeMixIn.v4.json",
        "deliveryOptions": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/deliveryOptionsMixIn.v6.json"
      }
    }
  },
  "siteCode": "main",
  "countryCode": "DE",
  "billingAddress": {
    "contactName": "John Dee",
    "street": "Maximilianstrasse",
    "streetNumber": "55",
    "streetAppendix": "",
    "zipCode": "70173",
    "city": "Stuttgart-Mitte",
    "country": "DE",
    "metadata": {
      "mixins": {
        "customAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/addressMixIn.v4.json"
      }
    }
  },
  "shippingAddress": {
    "contactName": "John Dee",
    "street": "Maximilianstrasse",
    "streetNumber": "55",
    "streetAppendix": "",
    "zipCode": "70173",
    "city": "Stuttgart-Mitte",
    "country": "DE",
    "metadata": {
      "mixins": {
        "customAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/addressMixIn.v4.json"
      }
    }
  },
  "payments": [
    {
      "status": "PENDING",
      "method": "cash-on-delivery",
      "paidAmount": 0,
      "currency": "EUR"
    }
  ],
  "calculatedPrice": {
        "price": {
            "netValue": 882.354,
            "grossValue": 1050.00,
            "taxValue": 167.646
        },
        "finalPrice": {
            "netValue": 882.354,
            "grossValue": 1050.00,
            "taxValue": 167.646
        }
  },
  "channel": {}
}

```

#### Confirm order creation 

You can retrieve the order details as a merchant or as the customer.

* As a merchant, if you want to confirm that the order has been created, send the request to the [Retrieving a specific order by ID](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../orders/order/api-reference" %}
[api-reference](../../orders/order/api-reference)
{% endcontent-ref %}

```bash
curl 'https://api.emporix.io/order-v2/{tenant}/salesorders/{orderId}'
```

* As a logged in customer, you can display your orders history in the store. Use the [Retrieving a list of orders](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders) to fetch your own orders.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../orders/order/api-reference" %}
[api-reference](../../orders/order/api-reference)
{% endcontent-ref %}

```bash
curl 'https://api.emporix.io/order-v2/{tenant}/orders' \
  --header 'Saas-Token: '
```

### Change the order status

* As a merchant, when the order has been prepared and dispatched, change the order status to `SHIPPED`. Send the request to the [Partially updating an order](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-tenant-managed#patch-order-v2-tenant-salesorders-orderid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../orders/order/api-reference" %}
[api-reference](../../orders/order/api-reference)
{% endcontent-ref %}

```bash
curl --location --request PATCH 'https://api.emporix.io/order-v2/{tenant}/salesorders/{order_id}?recalculate=false' 
--header 'Content-Type: application/json' 
--header 'Accept: application/json' 
--header 'Authorization: Bearer {YOUR_OAUTH2_TOKEN}' 
--data '{
  "status": "SHIPPED"
  }'
```

* As a customer, you can only change the order status from `CREATED` to `DECLINED` if for any reason you need to cancel the order. To decline the order, send the quest to the [Updating order status](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-customer-managed#post-order-v2-tenant-orders-orderid-transitions) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../orders/order/api-reference" %}
[api-reference](../../orders/order/api-reference)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/order-v2/{tenant}/orders/{orderId}/transitions' \
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' \
  --header 'saas-token: text' \
  --header 'Content-Type: application/json' \
  --data '{
    "status": "DECLINED"
  }'
```

### Check the status transitions

Order Service APIs provide also tools for controlling the status transitions logs.

* As a merchant, check the status history of the order by sending the request to the [Retrieving status transitions for an order](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-tenant-managed#get-order-v2-tenant-salesorders-orderid-transitions) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../orders/order/api-reference" %}
[api-reference](../../orders/order/api-reference)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/order-v2/{tenant}/salesorders/{orderId}/transitions' 
  --header 'Authorization: Bearer {YOUR_OAUTH2_TOKEN}' 
  --header 'Accept: */*'
```

* As a logged in customer, you can fetch your own order status transitions history. Use the [Retrieving status transitions for an order](https://developer.emporix.io/api-references/api-guides-and-references/orders/order/api-reference/orders-customer-managed#get-order-v2-tenant-orders-orderid-transitions) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../orders/order/api-reference" %}
[api-reference](../../orders/order/api-reference)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/order-v2/{tenant}/orders/{orderId}/transitions' \
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' \
  --header 'saas-token: text' \
  --header 'Accept: */*'
  ```