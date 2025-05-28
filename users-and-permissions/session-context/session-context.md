---
seo:
  title: Session Context Service Tutorials
  description: session context
icon: graduation-cap
---

# Session-context Tutorial

## How to configure the Session Context Service

By default, an anonymous user session expires after one hour. You can refresh the anonymous session by sending a request to the [Refreshing an anonymous token]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/authorization/oauth-service/api-reference/anonymous-token#get-customerlogin-auth-anonymous-refresh) endpoint.

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
To be able to manage a user session and its corresponding session context file, make sure that the session with its session ID is present in the system.
{% endhint %}

### Create an anonymous user session

An anonymous user session is created every time a non-logged user enters the storefront and sends a request to the [Requesting an anonymous token]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/authorization/oauth-service/api-reference/anonymous-token#get-customerlogin-auth-anonymous-refresh) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id={client_id}'
```

{% hint style="warning" %}
The session ID is automatically generated. It should be preserved on the storefront, for example in user cookies.
{% endhint %}

As a result of the anonymous session being established, a session context is created. It contains the following information:

* `cartId` — present if a cart was created.
* `customerId` — this field is empty.
* `currency` — fetched from the site settings of the tenant's default site.
* `targetLocation` — fetched from the home base address specified in the tenant's default site's settings.
* `siteCode` — fetched from the site settings of the tenant's default site.

An anonymous customer's session is terminated if one of those two requirements is met:

* The customer has logged in.
* The session has reached its lifetime.

### Create a customer session

The session is created when a customer logs in to the storefront. This means that the anonymous session that was established when the user entered the site is migrated into a customer session when a request is sent to the [Requesting a customer token]https://developer.emporix.io/api-references/api-guides-and-references/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token#post-customer-tenant-login) endpoint.

{% hint style="warning" %}
The session Id and session context remain the same.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer/{tenant}/login' \
  -H 'Authorization: string' \
  -H 'Content-Type: application/json' \
  -d '{
    "email": "customer@emporix.com",
    "password": "Qwurmdch673;'\''"
  }'
```

The session context contains the following information:

* `cartId` — if a cart was created during the anonymous session, the cart's Id is present. If not, adding products to cart triggers the Session Context Service and a `cartId` is added.
* `customerID` — retrieved from the saas token returned during login, based on the user password provided.
* `currency` — fetched from the `customerprefferedCurrency` entry in the customer's profile.
* `targetLocation` — fetched from the customer's profile. Either default shipping address, or default billing address. Empty if none of those exist.
* `siteCode` — fetched from the `customerprefferedSite` entry in the customer's profile.

{% hint style="warning" %}
If any of these values are not present in the customer's profile, they are retrieved from the configuration on your main site.
{% endhint %}

The customer's session is terminated when the customer has logged out.

### Retrieve a session context by using a session Id

To view the existing session context file, you need to have a session Id of a particular user session.

Retrieve the session context values by sending a request to the [Retrieving a session context]https://developer.emporix.io/api-references/api-guides-and-references/api-references/users-and-permissions/session-context/api-reference/session-management) endpoint with the `session_context.context_manage` scope.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/session-context/{tenant}/context/{sessionId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

### Add new attributes to the session context

If you want to personalize user experience on your website, you can add custom attributes to selected session contexts. Your attributes are not validated, as they are only stored in the Emporix Commerce Engine and can be deleted at any time. However, you can make the data actionable by incorporating a solution of your choice.

success Example\
If we want to suggest products on the storefront that are relevant to the weather conditions near our user's location, we can add two new attributes: `latitude` and `longitude` to the session context.\
The data can be collected on the storefront every time a user enters your website, and it will be kept in the Emporix Commerce Engine.\
You can then implement a mechanism that uses the collected data, for example to display relevant products first, according to the weather.

For example, it's raining in the user's location, so the list of suggested products on the storefront prioritizes umbrellas and other rain equipment.

{% hint style="warning" %}
You can also implement a mechanism allowing users to manage and modify their own sessions and session contexts by calling the Adding a new attribute to a session context] endpoint on the storefront.
{% endhint %}

In the following example, we add an attribute by sending a request to the [Adding a new attribute to a session context]https://developer.emporix.io/api-references/api-guides-and-references/api-references/users-and-permissions/session-context/api-reference/own-session-context-modification#post-session-context-tenant-me-context-attributes) endpoint with the `session_context.context_manage` scope.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/session-context/{tenant}/context/{sessionId}/attributes' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "key": "additional attribute name",
    "value": "61079711ce0eb90861357045"
  }'
```

{% hint style="warning" %}
The changes introduced to the session context are automatically applied to the user session to which the session context belongs.
{% endhint %}
