---
seo:
  title: Session Context Service Tutorials
  description: session context
icon: graduation-cap
layout:
  width: wide
---

# Session-context Tutorial

## How to configure the Session Context Service

By default, an anonymous user session expires after one hour. You can refresh the anonymous session by sending a request to the [Refreshing an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-refresh) endpoint.

{% hint style="warning" %}
There is no timeout for logged customer sessions.
{% endhint %}

{% hint style="warning" %}
You can use the price matching mechanism based on a session context file values. For more information on how the price matching functionality works, check out _How to use the price matching functionality_ in the [Price Service Tutorials](../../prices-and-taxes/price-service/price.md#how-to-use-the-price-matching-functionality).
{% endhint %}

## How to manage user sessions and session context files

Sessions and session context files can be managed both by your customers and employees.

In the following scenario, we are going to perform the following actions from the perspective of an employee:

{% stepper %}
{% step %}
Create one of the following user sessions (these requests are normally sent on the storefront, but are here for illustrative purposes):

* [Anonymous session](session-context.md#create-an-anonymous-user-session)
* [(Logged) customer session](session-context.md#create-a-customer-session)
{% endstep %}

{% step %}
[Create a cart for that session](session-context.md#create-a-cart-so-that-session-context-exists) so that a session context (and session ID) is created. Without this step, there is no session context to retrieve or manage.
{% endstep %}

{% step %}
[Retrieve the session context](session-context.md#retrieve-a-session-context-by-using-a-session-id) attributes and values for that user session.
{% endstep %}

{% step %}
[Add or remove custom attributes](session-context.md#add-new-attributes-to-the-session-context) from the session context.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
The session context (and session ID) is created only when a cart is created for that session. Until then, only the anonymous or customer token is available—there is no session context to retrieve or manage. So you must complete the second step (create a cart) before retrieving or modifying the session context.
{% endhint %}

### Create an anonymous user session

An anonymous user session starts when a non-logged user enters the storefront and sends a request to the [Requesting an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-refresh) endpoint. That request returns only an anonymous access token; no session context is created yet.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-management/api-reference" %}
[api-reference](../../companies-and-customers/customer-management/api-reference)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id={client_id}'
```

{% hint style="warning" %}
A **session context** (and its session ID) is created only when a cart is created for that user (for example when they add a product to the cart). Until then, only the anonymous token is returned; there is no session context resource to retrieve or manage. After the session context exists, preserve the session ID on the storefront (for example in user cookies).
{% endhint %}

Once a session context has been created (when a cart was created), it contains the following information:

* `cartId` — present when a cart was created (session context is created at that time).
* `customerId` — this field is empty for anonymous users.
* `currency` — fetched from the site settings of the tenant's default site.
* `targetLocation` — fetched from the home base address specified in the tenant's default site's settings.
* `siteCode` — fetched from the site settings of the tenant's default site.

An anonymous customer's session is terminated if one of those two requirements is met:

* The customer has logged in.
* The session has reached its lifetime.

### Create a customer session

The session is created when a customer logs in to the storefront. This means that the anonymous session that was established when the user entered the site is migrated into a customer session when a request is sent to the [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) endpoint.

{% hint style="warning" %}
If a session context already existed for the anonymous session (e.g. a cart was created before login), the session ID and session context remain the same after login. If no cart was created yet, the session context is still created only when a cart is created (after or before login).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-management/api-reference" %}
[api-reference](../../companies-and-customers/customer-management/api-reference)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/login' 
  -H 'Authorization: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "email": "customer@emporix.com",
    "password": "Qwurmdch673;'\''"
  }'
```

The session context (created when a cart is created) contains the following information:

* `cartId` — if a cart was created during the anonymous session, the cart's Id is present. If not, adding products to cart triggers the Session Context Service, creates the session context if needed, and adds a `cartId`.
* `customerId` — retrieved from the saas token returned during login, based on the user password provided.
* `currency` — fetched from the `customerprefferedCurrency` entry in the customer's profile.
* `targetLocation` — fetched from the customer's profile. Either default shipping address, or default billing address. Empty if none of those exist.
* `siteCode` — fetched from the `customerprefferedSite` entry in the customer's profile.

{% hint style="warning" %}
If any of these values are not present in the customer's profile, they are retrieved from the configuration on your main site.
{% endhint %}

The customer's session is terminated when the customer has logged out.

### Create a cart (so that session context exists)

A session context is created only when a cart is created for that user. Until then, the session has no session context and no session ID that you can use with the Session Context API.

To create a cart (and thus create the session context), have the user add at least one product to the cart—for example from the storefront, or by calling the [Cart Service](../../checkout/cart/README.md) with the same anonymous or customer token used for that session. Once the cart exists, the session context exists and you can retrieve it or add attributes to it (see the steps above).

{% hint style="info" %}
If you are testing as an employee: use a session where a cart has already been created (e.g. a test user who added a product to the cart), or create a cart via the Cart API using that session's token so that the session context is created.
{% endhint %}

### Retrieve a session context by using a session Id

To view the existing session context file, you need the session ID of a user session. Ensure a cart has been created for that session first (see [Create a cart (so that session context exists)](session-context.md#create-a-cart-so-that-session-context-exists)), so that the session context exists.

**Getting the session ID:** When calling the management endpoint below, you must supply the session ID—for example from your storefront (where it may be stored when the session context is created), or by having the customer call the [Retrieving own session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/own-session-management#get-session-context-tenant-me-context) endpoint (GET `/session-context/{tenant}/me/context`) with their token; the response includes `sessionId`.

Retrieve the session context by sending a request to the [Retrieving a session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/session-management) endpoint. Use the scope **`session_context.context_manage`** (with underscore in `session_context`) and client credentials.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/session-context/{tenant}/context/{sessionId}' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

### Add new attributes to the session context

If you want to personalize user experience on your website, you can add custom attributes to selected session contexts. Your attributes are not validated, as they are only stored in the Emporix Commerce Engine and can be deleted at any time. However, you can make the data actionable by incorporating a solution of your choice.

Example:

If you want to suggest products on the storefront that are relevant to the weather conditions near the user's location, you can add two new attributes: `latitude` and `longitude` to the session context.
The data can be collected on the storefront every time a user enters your website, and it will be kept in the Emporix Commerce Engine.
You can then implement a mechanism that uses the collected data, for example to display relevant products first, according to the weather.

For example, it's raining in the user's location, so the list of suggested products on the storefront prioritizes umbrellas and other rain equipment.

{% hint style="warning" %}
You can also implement a mechanism allowing users to manage and modify their own sessions and session contexts by calling the [Adding a new attribute to a session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/session-context-modification#post-session-context-tenant-context-sessionid-attributes) endpoint on the storefront.
{% endhint %}

In the following example, we add an attribute by sending a request to the [Adding a new attribute to a session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/session-context-modification#post-session-context-tenant-context-sessionid-attributes) endpoint with the **`session_context.context_manage`** scope (with underscore in `session_context`).

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/session-context/{tenant}/context/{sessionId}/attributes' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "key": "additional attribute name",
    "value": "61079711ce0eb90861357045"
  }'
```

{% hint style="warning" %}
The changes introduced to the session context are automatically applied to the user session to which the session context belongs.
{% endhint %}
 
