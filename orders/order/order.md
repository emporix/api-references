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

### Asynchronous calculation

Emporix utilizes an asynchronous pricing model, where all price calculations are dynamically determined at the cart/checkout stage. Product prices are initially replicated from an ERP system and stored in the Emporix, ensuring consistency across the platform.

During checkout, the final price is calculated based on customer-specific details, such as shipping address or payment methods. Prices are categorized into net or gross price models, depending on the price type, with customer assignments managed at the ship-to level:

* Pricing rules (net or gross) are assigned based on the shipping address of the customer.
* Different locations may have different tax regulations, so the system determines which price model applies based on where the order is being shipped.

Once an order is placed, the order information simply reflects the calculated prices without further modifications, ensuring accuracy and transparency in the final transaction.

<figure><img src="../../static/order/diagram1.svg" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
To learn how pricing is calculated at Emporix, see the [Cart Service Tutorials](../../checkout/cart/cart.md#pricing-calculations).
{% endhint %}

### Synchronous calculation

In this approach, the Emporix cart interacts with an ERP system to retrieve real-time order calculations. Instead of using the Emporix calculation, the checkout uses the calculation provided by the ERP.

Commerce Orchestration Platform (COP) enables this functionality with external pricing, ensuring real-time accuracy.

Communication with the ERP system occurs using the BFF (Backend-for-Frontend) layer and with a [POST](https://developer.emporix.io/documentation-portal/api-references/orders/order/api-reference/orders-tenant-managed#post-order-v2-tenant-salesorders) request the order is send to an ERP system. This architecture ensures a secure, real-time pricing model while leveraging external systems for order calculations.

<figure><img src="../../static/order/diagram2.svg" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
For more information, see the [External Pricing](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/extensibility-cases/external-pricing-and-products) guides.
{% endhint %}

### ERP calculated order

With this use case, the Commerce Orchestration Platform cart is used to collect products and customer details, such as addresses. However, instead of using COP for final price calculations at checkout, the BFF (Backend-for-Frontend) layer communicates with the ERP to simulate the order, ensuring that all pricing, discounts, and rules from the ERP are applied before order creation.

Once the order is validated and priced by the ERP, the BFF layer creates the order in COP using the [Sales Order API](api-reference/). This allows for seamless integration between Emporix and the external ERP system while maintaining flexibility in how orders are processed.

<figure><img src="../../static/order/diagram3.svg" alt=""><figcaption></figcaption></figure>

### Order calculation approaches comparison

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

#### Summary of differences

* **Asynchronous calculation** - Emporix controls pricing (replicated from ERP), and calculation happens at checkout.
* **Synchronous calculation** - Pricing is provided by an external system, for example an ERP in real time, and checkout/order processing happens with external prices.
* **ERP calculated order** - Emporix cart is used, but ERP simulates pricing at checkout before the order is created in Emporix.
