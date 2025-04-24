# OAuth Service

The OAuth Service allows you to generate various token types.

### Key features and benefits

* Anonymous token
    * Used by the storefront to access public resources with a reading scope. 
    * It allows customers to browse products, view prices or add products to cart.
    * The anonymous token is not associated with any customer.
* SaaS (customer) token
    * A JSON Web Token (JWT) which contains encrypted customer data. 
    * The SaaS token works similarly to the anonymous token, but it is associated with a specific customer. 
* Service access token
    * Needed to access the Emporix services such as adding new products, managing categories or modifying prices.