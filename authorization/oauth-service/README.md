---
icon: lock
---

# OAuth Service

The OAuth Service allows you to generate various token types.

### Key features and benefits

* Service access token
  * Required to access Emporix services such as adding products, managing categories, or modifying prices

{% hint style="success" %}
The tokens related to the customer, anonymous or Saas, are generated with the [Customer Service (Customer Managed)](../../companies-and-customers/customer-service/api-reference/README.md)
* Anonymous token
  * Used by the storefront to access public resources with read-only permissions
  * Allows customers to browse products, view prices, and add products to the cart
  * Not associated with any specific customer
* SaaS (customer) token
  * A JSON Web Token (JWT) containing encrypted customer data
  * Functions similarly to the anonymous token, but is tied to a specific customer
{% endhint %}
