---
layout:
    width: wide
description: Customer-managed
icon: user-group-crown
---

# Customer Service (Customer Managed)

Creates, manages, and deletes customer profiles

{% hint style="info" %}
This part of the Customer Service is managed by the customers on the storefront.
{% endhint %}

### Key features and benefits

* Provides rich customer profiles that are extensible with custom fields
* Supports multiple addresses for payment and delivery
* Supports social login for different platforms
* Offers self-service for customers to manage their profile information
* Provides convenient login and removes login barriers with SSO for social logins
* Captures data important for the business to serve customers better
* Ensures secure login for customers to access their profiles
* Generates proper authorization tokens:
    * Anonymous token - Used by the storefront to access public resources with read-only permissions; it allows customers to browse products, view prices, and add products to the cart and is not associated with any specific customer
    * SaaS (customer) token - A JSON Web Token (JWT) containing encrypted customer data; it functions similarly to the anonymous token, but is tied to a specific customer
 
