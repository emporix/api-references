---
icon: graduation-cap
layout:
  width: wide
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
---

# Wishlist Tutorial

The Cart Service supports wishlists as a dedicated cart type. A customer can have an open `shopping` cart for checkout and a separate open `wishlist` cart for saved products at the same time. Cart uniqueness is defined by the combination of `siteCode`, `type`, `legalEntityId`, and (`sessionId` or `customerId`).

{% hint style="info" %}
Use the **Cart Service** with `"type": "wishlist"` for save-for-later functionality. The **Shopping List Service** is intended for frequently purchased items and reorder lists, not classic wishlists.
{% endhint %}

## How to implement customer wishlists

Follow these steps to authenticate customers, manage wishlist items, persist anonymous wishlists across login, and move products to the shopping cart.

{% stepper %}
{% step %}
#### Start an anonymous session

When a guest enters your storefront, request an anonymous token before they log in. The token returns a `sessionId` that links anonymous carts to the browsing session.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-management/api-reference/" %}
[api-reference](../../companies-and-customers/customer-management/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id={client_id_storefront}'
```

The anonymous token is valid for one hour. Refresh it with the [Refreshing an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-refresh) endpoint to keep the same `sessionId`. Store the `sessionId` on the storefront, for example in a cookie.

A session context is created when the first cart is created for that session. Until then, only the anonymous token is available.
{% endstep %}

{% step %}
#### Create or retrieve a wishlist cart

Create a wishlist cart by setting `"type": "wishlist"` in the request body. For anonymous customers, pass the `session-id` header.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts' \
  -H 'Authorization: Bearer {ANONYMOUS_TOKEN}' \
  -H 'Content-Type: application/json' \
  -H 'session-id: {sessionId}' \
  -d '{
    "siteCode": "main",
    "currency": "EUR",
    "type": "wishlist",
    "channel": {
      "name": "storefront",
      "source": "https://your-storefront.com/"
    },
    "sessionValidated": true
  }'
```

To retrieve an existing wishlist without creating a new one, call the [Retrieving a cart by criteria](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts) endpoint with `siteCode`, `sessionId`, and `type=wishlist`. Pass `create=true` to auto-create the cart if none exists.

```bash
curl -i -X GET \
  'https://api.emporix.io/cart/{tenant}/carts?siteCode=main&sessionId={sessionId}&type=wishlist&create=true' \
  -H 'Authorization: Bearer {ANONYMOUS_TOKEN}' \
  -H 'session-id: {sessionId}'
```

For logged-in customers, use the customer access token and `saas-token` header instead of `session-id`. Retrieve or create the wishlist with `customerId` and `type=wishlist`.
{% endstep %}

{% step %}
#### Add and remove wishlist items

Use the same cart item endpoints as for a shopping cart. Provide the wishlist cart ID in the `cartId` path parameter.

To add a product, call the [Adding a product to cart](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#post-cart-tenant-carts-cartid-items) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{wishlistCartId}/items?siteCode=main' \
  -H 'Authorization: Bearer {ACCESS_TOKEN}' \
  -H 'Content-Type: application/json' \
  -H 'session-id: {sessionId}' \
  -d '{
    "itemYrn": "urn:yaas:saasag:caasproduct:product:{tenant};{productId}",
    "quantity": 1
  }'
```

To remove a single item, call the [Deleting a cart item](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/cart-items#delete-cart-tenant-carts-cartid-items-itemid) endpoint with the wishlist cart ID and item ID.

```bash
curl -i -X DELETE \
  'https://api.emporix.io/cart/{tenant}/carts/{wishlistCartId}/items/{itemId}' \
  -H 'Authorization: Bearer {ACCESS_TOKEN}' \
  -H 'session-id: {sessionId}'
```
{% endstep %}

{% step %}
#### Log in and merge the anonymous wishlist

When a guest logs in, authenticate the login request with their **existing** anonymous token so the same `sessionId` is preserved. Creating a new anonymous token at login starts a new session and the guest wishlist is no longer accessible.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-management/api-reference/" %}
[api-reference](../../companies-and-customers/customer-management/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer/{tenant}/login' \
  -H 'Authorization: Bearer {ANONYMOUS_TOKEN}' \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "customer@example.com",
    "password": "{CUSTOMER_PASSWORD}"
  }'
```

Cart merge is **not automatic**. After login, merge the anonymous wishlist into the customer's wishlist cart by calling the [Merging carts](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#post-cart-tenant-carts-cartid-merge) endpoint. The cart in the path parameter must belong to the logged-in customer. The cart ID in the request body must belong to the anonymous session.

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{customerWishlistCartId}/merge' \
  -H 'Authorization: Bearer {CUSTOMER_TOKEN}' \
  -H 'Content-Type: application/json' \
  -H 'saas-token: {SAAS_TOKEN}' \
  -d '{
    "carts": [
      "{anonymousWishlistCartId}"
    ]
  }'
```

After a successful merge:

* The anonymous wishlist cart status is set to `CLOSED`.
* Items from the anonymous wishlist are combined into the customer's wishlist cart.
* If both carts contain the same product, quantities are added together.

If the guest had both an anonymous shopping cart and an anonymous wishlist, perform a separate merge for each cart type — one targeting the customer's shopping cart and one targeting the customer's wishlist cart.

{% hint style="warning" %}
To learn more about merge behavior and conflict resolution, see [Cart merging](https://developer.emporix.io/ce/core-commerce/carts#cart-merging) in the Carts guide.
{% endhint %}
{% endstep %}

{% step %}
#### Move a wishlist item to the shopping cart

There is no dedicated endpoint to move items between cart types. To implement **Add to cart** from the wishlist:

1. Add the product to the customer's `type: "shopping"` cart.
2. Remove the product from the `type: "wishlist"` cart.

Retrieve each cart independently using the `type` query parameter on the [Retrieving a cart by criteria](https://developer.emporix.io/api-references/api-guides/checkout/cart/api-reference/carts#get-cart-tenant-carts) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/cart/{tenant}/carts/{shoppingCartId}/items?siteCode=main' \
  -H 'Authorization: Bearer {CUSTOMER_TOKEN}' \
  -H 'Content-Type: application/json' \
  -H 'saas-token: {SAAS_TOKEN}' \
  -d '{
    "itemYrn": "urn:yaas:saasag:caasproduct:product:{tenant};{productId}",
    "quantity": 1
  }'
```

```bash
curl -i -X DELETE \
  'https://api.emporix.io/cart/{tenant}/carts/{wishlistCartId}/items/{itemId}' \
  -H 'Authorization: Bearer {CUSTOMER_TOKEN}' \
  -H 'saas-token: {SAAS_TOKEN}'
```
{% endstep %}
{% endstepper %}

## Anonymous wishlist sessions

### Session lifetime

There is no wishlist-specific expiration. Anonymous sessions follow the standard session and token rules:

| Mechanism | Lifetime | Notes |
|---|---|---|
| Anonymous access token | 1 hour | Refresh to keep the same `sessionId` |
| Anonymous refresh token | 24 hours | Used by the anonymous token refresh endpoint |
| Anonymous session | Until login or session lifetime | Session context ends; cart data is not automatically deleted |
| Logged-in customer session | No timeout documented | Wishlist is tied to `customerId` and persists across sessions |

An anonymous customer's session is terminated when the customer logs in or when the session reaches its lifetime. Carts remain `OPEN` in the system, but guests lose access if they lose their `sessionId` or token — for example when cookies are cleared or tokens are not refreshed.

To keep an anonymous wishlist accessible, preserve the `sessionId` on the storefront and refresh the anonymous token before it expires.

### Session context and multiple cart types

The session context stores a single `cartId` field for the active cart. If a customer has both a shopping cart and a wishlist cart, retrieve each cart separately using the `type` query parameter (`shopping` or `wishlist`).

## Authorization

| Action | Auth |
|---|---|
| Anonymous wishlist operations | Anonymous access token and `session-id` header |
| Logged-in wishlist operations | Customer access token and `saas-token` header |
| Employee or technical client operations | OAuth token with `cart.cart_manage` scope |

For the complete authentication flow, see [Tokens and scopes](https://developer.emporix.io/api-references/quickstart/authentication-and-authorization/tokens-and-scopes) and the [Customer Service (Customer Managed) Tutorial](../../companies-and-customers/customer-management/customer-management-tutorial.md).
