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

1. Create one of the following user sessions (these requests are normally sent on the storefront, but are here for illustrative purposes):

  * [Anonymous session](session-context.md#create-an-anonymous-user-session)
  * [(Logged) customer session](session-context.md#create-a-customer-session)

2. [Retrieve the session context attributes and values of a particular user session.](session-context.md#retrieve-a-session-context-by-using-a-session-id)
3. [Add or remove custom attributes from the session context.](session-context.md#add-new-attributes-to-the-session-context)

{% hint style="warning" %}
To be able to manage a user session and its corresponding session context file, a session context must already exist. The session context (and session ID) is created when a cart is created. Until then, only the anonymous or customer token is available and there is no session context to retrieve or manage.
{% endhint %}

### Create an anonymous user session

An anonymous user session starts when a non-logged user enters the storefront and sends a request to the [Requesting an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-refresh) endpoint. That request returns only an anonymous access token, no session context is created yet.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-management/api-reference" %}
[api-reference](../../companies-and-customers/customer-management/api-reference)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id={client_id}'
```

{% hint style="warning" %}
A session context, and its session ID, is created only when a cart is created for that user - when they add a product to the cart. Until then, only the anonymous token is returned. There is no session context resource to retrieve or manage. After the session context exists, the session ID should be preserved on the storefront, for example in user cookies.
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
If a session context already existed for the anonymous session (for example when a cart was created before login), the session ID and session context remain the same after login. If no cart was created yet, the session context is created only when a cart is created (after or before login).
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

### Retrieve a session context by using a session Id

The session context is created when a cart is created - when a customer adds an item to the cart. The session-context details can be retrieved using the `sessionId` and include the following information:

* `cartId` — if a cart was created during the anonymous session, the cart's Id is present. If not, adding products to cart triggers the Session Context Service, creates the session context if needed, and adds a `cartId`.
* `customerId` — retrieved from the saas token returned during login, based on the user password provided.
* `currency` — fetched from the `customerprefferedCurrency` entry in the customer's profile.
* `targetLocation` — fetched from the customer's profile. Either default shipping address, or default billing address. Empty if none of those exist.
* `siteCode` — fetched from the `customerprefferedSite` entry in the customer's profile.

{% hint style="warning" %}
If any of these values are not present in the customer's profile, they are retrieved from the configuration on your main site.
{% endhint %}

The customer's session is terminated when the customer logs out.

{% stepper %}
{% step %}
### Get the session ID

When retrieving the session-context details, you must supply the `sessionId`. It can be retrieved from the storefront or by sending the request to the [Retrieving own session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/own-session-management#get-session-context-tenant-me-context) endpoint with the `customerToken` -  in the request. Then, the response includes the `sessionId`.

**Example**:

```bash
curl -L \
  --url 'https://api.emporix.io/session-context/{tenant}/me/context' \
  --header 'Authorization: Bearer YOUR_SECRET_TOKEN' \
  --header 'Accept: */*'
```

The response is:

```json
{
  "sessionId": "3ef05d1f-bd7f-42a7-8322-ff85746e0f35",
  "customerId": "31746755",
  "siteCode": "main",
  "currency": "USD",
  "targetLocation": "DE",
  "context": {
    "legalEntityId": "68cd05d71aeab17fc69f81b7"
  },
  "metadata": {
    "version": 5,
    "createdAt": "2026-02-04T17:06:50.134Z",
    "modifiedAt": "2026-02-04T17:07:04.104Z"
  }
}
```

{% endstep %}
{% step %}

Retrieve the session context by sending a request to the [Retrieving a session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/session-management) endpoint. Use the `sessioncontext.context_manage` scope.
{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X GET 
  'https://api.emporix.io/session-context/{tenant}/context/01736216-39a9-4801-b6f0-90a977453b75' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

The response is:

```json
{
  "sessionId": "01736216-39a9-4801-b6f0-90a977453b75",
  "customerId": "31746755",
  "siteCode": "main",
  "currency": "EUR",
  "cartId": "61079711ce0eb90861357045",
  "targetLocation": "DE",
  "context": {
    "customObject": {
      "property1": "value1"
    },
    "additional attribute name": "61079711ce0eb90861357445",
    "customProperty": "customValue"
  },
  "metadata": {
    "version": 10,
    "createdAt": "2026-02-04T16:36:44.047Z",
    "modifiedAt": "2026-02-04T17:01:56.173Z"
  }
}
```
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

### Add new attributes to the session context

If you want to personalize user experience on your website, you can add custom attributes to selected session contexts. Your attributes are not validated, as they are only stored in the Emporix Commerce Engine and can be deleted at any time. However, you can make the data actionable by incorporating a solution of your choice.

**Example**:

If you want to suggest products on the storefront that are relevant to the weather conditions near the user's location, you can add two new attributes: `latitude` and `longitude` to the session context.
The data can be collected on the storefront every time a user enters your website, and it will be kept in the Emporix Commerce Engine.
You can then implement a mechanism that uses the collected data, for example to display relevant products first, according to the weather.

For example, it's raining in the user's location, so the list of suggested products on the storefront prioritizes umbrellas and other rain equipment.

{% hint style="warning" %}
You can also implement a mechanism allowing users to manage and modify their own sessions and session contexts by calling the [Adding a new attribute to a session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/session-context-modification#post-session-context-tenant-context-sessionid-attributes) endpoint on the storefront.
{% endhint %}

In the following example, we add an attribute by sending a request to the [Adding a new attribute to a session context](https://developer.emporix.io/api-references/api-guides/users-and-permissions/session-context/api-reference/session-context-modification#post-session-context-tenant-context-sessionid-attributes) endpoint with the `sessioncontext.context_manage` scope (with underscore in `session_context`).

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
 
