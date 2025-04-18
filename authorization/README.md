# Authorization

The OAuth Service allows you to generate the following token types:

| Token type            | Description                                                                                                                                                                                                                 |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Anonymous token       | <p>Used by the storefront to access public resources with a reading scope. It allows customers to browse products, view prices or add products to cart.<br><br>The anonymous token is not associated with any customer.</p> |
| SaaS (customer) token | <p>A JSON Web Token (JWT) which contains encrypted customer data.<br><br>The SaaS token works similarly to the anonymous token, but it is associated with a specific customer.</p>                                          |
| Service access token  | Needed to access the Emporix services such as adding new products, managing categories or modifying prices.                                                                                                                 |
