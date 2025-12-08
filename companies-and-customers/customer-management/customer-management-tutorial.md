---
description:  
icon: graduation-cap
layout:
  width: wide
---

# Customer Service (Customer Managed) Tutorial

The Customer Service (Customer Managed) allows you to create, manage, and delete customer profiles from your commerce frontend perspective. You might use the Customer Service endpoints when implementing the custom storefront. It enables you to generate relevant access tokens to log in anonymous or registered customers on a storefront.

This tutorial guides you through the process of managing customer authentication, including creating customer accounts, logging in customers, and managing authentication tokens.

## How to manage customer authentication

Customer authentication is a fundamental part of the customer experience. This section covers the complete authentication flow, from requesting anonymous tokens for browsing to logging in registered customers and managing their sessions.

{% stepper %}
{% step %}
### Request an anonymous token

When a user enters your storefront, before they choose to log in, an anonymous user session is created. An anonymous token allows customers to browse products, view prices, and add products to the cart without being logged in.

Get an anonymous access token by sending a request to the [Requesting an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-login) endpoint.

```bash
curl -i -X GET 
  'https://api.emporix.io/customerlogin/auth/anonymous/login?tenant={tenant}&client_id={client_id_storefront}'
```
Pass the Storefront Client ID in the request.

Sample response returns relevant access credentials:

```json
{
  "token_type": "Bearer",
  "access_token": "tpYgJPZqddEQ2zwfzNtx79noBP65",
  "expires_in": 3599,
  "refresh_token": "7FnviYrxvQWYdzUVBVTvXeNAA4Jy1HPe",
  "refresh_token_expires_in": 86399,
  "sessionId": "6d4d4d5e-04b9-40c5-9074-4df1405c6081",
  "scope": "tenant={tenant}"
}
```

{% hint style="warning" %}
The anonymous token is valid for one hour. After that time, it should be refreshed to keep the same session ID associated.
{% endhint %}
{% endstep %}

{% step %}
### Create a new customer

To create a new customer account, send a request to the [Creating a new customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-signup) endpoint. Authorize the request with the anonymous access token.

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/signup' 
  -H 'Authorization: Bearer {anonymous_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "email": "example@customer.com",
    "password": "password123",
    "customerDetails": {
      "title": "MR",
      "firstName": "John",
      "middleName": "",
      "lastName": "Doe",
      "contactEmail": "example@customer.com",
      "contactPhone": "123456789",
      "company": "Emporix",
      "preferredLanguage": "en_US",
      "preferredCurrency": "EUR",
      "preferredSite": "main",
      "b2b": {
        "companyRegistrationId": "123-456-789"
      }
    },
    "customerAddress": {
      "contactName": "John Doe",
      "companyName": "Emporix",
      "street": "Platz der Republik",
      "streetNumber": "1",
      "streetAppendix": "",
      "extraLine1": "",
      "extraLine2": "",
      "zipCode": "11011",
      "city": "Berlin",
      "country": "DE",
      "state": "Berlin",
      "contactPhone": "123456789",
      "tags": ["BILLING", "SHIPPING"]
    }
  }'
```

The response returns the ID of the created customer.

{% hint style="info" %}
If you want to use separate sign-up credentials (different email for login than the main contact email), you can include the `signup` object with `email` and `password` fields in the request.
{% endhint %}
{% endstep %}

{% step %}
### Log in as a customer

After creating a customer account, customers can log in using their email and password. This operation returns both a customer access token and a SaaS token.

Send an authorization request to the [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) endpoint, passing the anonymous access token as authorization method.


```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/login' 
  -H 'Authorization: Bearer {anonymous_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "email": "customer@customer.com",
    "password": "password123"
  }'
```

**Response example:**

```json
{
  "access_token": "aYR3Lu3rpsQ9ODhBIR83b3txTr5K",
  "saas_token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMzg2OTAwMCIsImV4cCI6MTY0MDQ0NDAzMn0.lvxFOeCOk-DWi3kqwJwR8eKal3ON2rr53e9I6Pha5rI",
  "expires_in": 2591999,
  "refresh_token": "94tKQ2Tsvlf9dYbmyccA7X1Rqe54B6dH",
  "refresh_token_expires_in": 86399,
  "token_type": "Bearer",
  "session_id": "45c9726e-77c8-4bd0-b29d-61ab56f59726",
  "initialPassword": false
}
```

{% hint style="info" %}
The customer access token is valid for 30 days (2591999 seconds). The SaaS token is a JSON Web Token (JWT) containing encrypted customer data.
{% endhint %}
{% endstep %}

{% step %}
### Refresh an anonymous token

Anonymous tokens expire after one hour. To maintain the same session ID and continue browsing without interruption, you should refresh the anonymous token before it expires.

**When to refresh**: Refresh the anonymous token when it's about to expire (before the one-hour mark) or when you want to extend the anonymous session.

**Why refresh**: Refreshing keeps the same session ID associated with the user's browsing session, which is important for maintaining cart contents and session context.

Send a request to the [Refreshing an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-refresh) endpoint.

```bash
curl -i -X GET \
  'https://api.emporix.io/customerlogin/auth/anonymous/refresh?tenant={tenant}&refresh_token={refresh_token}&client_id={client_id}'
```

**Response example:**

```json
{
  "token_type": "Bearer",
  "access_token": "tpYgJPZqddEQ2zwfzNtx79noBP65",
  "expires_in": 3599,
  "refresh_token": "7FnviYrxvQWYdzUVBVTvXeNAA4Jy1HPe",
  "refresh_token_expires_in": 86399,
  "sessionId": "6d4d4d5e-04b9-40c5-9074-4df1405c6081",
  "scope": "tenant={tenant}"
}
```

{% hint style="warning" %}
It's recommended to use the `refresh_token` parameter instead of the deprecated `anonymous_token` parameter. The refresh token is valid for 24 hours (86399 seconds).
{% endhint %}
{% endstep %}

{% step %}
### Refresh a customer token

Customer access tokens expire after 30 days. To maintain an active session without requiring the customer to log in again, you should refresh the customer token before it expires.

**When to refresh**: Refresh the customer token when it's about to expire or when you want to extend the customer's authenticated session.

**Why refresh**: Refreshing allows customers to stay logged in without re-entering credentials, providing a seamless user experience.

Send a request to the [Refreshing a customer token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-refreshauthtoken) endpoint.

**Note**: The request needs to be authorized with an anonymous access token.

```bash
curl -i -X GET \
  'https://api.emporix.io/customer/{tenant}/refreshauthtoken?refreshToken={customer_refresh_token}&legalEntityId={legalEntityId}' \
  -H 'Authorization: Bearer {anonymous_access_token}'
```

**Response example:**

```json
{
  "access_token": "2yXy8H7sByl4JSWrr7GRqxiCRMUm",
  "expires_in": 2591999,
  "refresh_token": "iwXAFjGwboaehJar1qNOkV05phDw1god",
  "refresh_token_expires_in": 86390,
  "token_type": "Bearer",
  "session_id": "45c9726e-77c8-4bd0-b29d-61ab56f59726"
}
```

{% hint style="info" %}
The `legalEntityId` parameter is optional and should be used if you want to associate the session with a specific legal entity.
{% endhint %}
{% endstep %}

{% step %}
### Validate a token

Token validation allows you to verify whether a token is still valid and retrieve information about the token, such as expiration time, scopes, and associated session details.

**When to validate**: Validate tokens before making authenticated requests to ensure the token hasn't expired or been revoked. This is especially useful for checking token status in your application.

**Why validate**: Validating tokens helps prevent authentication errors and allows you to proactively refresh tokens before they expire.

Send a request to the [Validate a token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-validateauthtoken) endpoint.

**Note**: The request needs to be authorized with a customer access token.

```bash
curl -i -X GET \
  'https://api.emporix.io/customer/{tenant}/validateauthtoken' \
  -H 'Authorization: Bearer {customer_access_token}'
```

**Response example:**

```json
{
  "token_type": "Bearer",
  "expires_in": 2591974,
  "scope": "approval.approval_read_own customermanagement.legalentity_read_own customer.customer_read_own quote.quote_read_own returns.returns_read_own iam.scope_read_own iam.user_read_own customersegment.segment_read_own iam.group_read_own order.order_readascustomer coupon.coupon_redeem customer.customerprofile_edit quote.quote_manage_own returns.returns_manage_own customer.customer_manage_own approval.approval_manage_own order.order_updateascustomer iam.assignment_delete_own customer.consent_view customer.customerprofile_view order.history_view iam.assignment_create_own customer.consent_manage tenant=test",
  "sessionId": "415c340b-5996-4112-bb3b-38139a409f93",
  "email": "customer@example.com",
  "legalEntityId": "53ac81fd0cce8b26b36f3492"
}
```

{% hint style="info" %}
If the token is invalid, the endpoint returns a 401 Unauthorized status code.
{% endhint %}
{% endstep %}

{% step %}
### Log in using social login

Social login allows customers to authenticate using their existing social media accounts (e.g., Google, Facebook) through Auth0. This provides a convenient login experience without requiring customers to create a new password.

Send a request to the [Logging in a customer with social login](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-sociallogin) endpoint.

**Note**: The request needs to be authorized with an anonymous access token.

```bash
curl -i -X POST \
  'https://api.emporix.io/customer/{tenant}/socialLogin?code={authorization_code}&redirect_uri={redirect_uri}&code_verifier={code_verifier}' \
  -H 'Authorization: Bearer {anonymous_access_token}' \
  -H 'session-id: {session_id}'
```

**Response example:**

```json
{
  "social_access_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "social_id_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "94tKQ2Tsvlf9dYbmyccA7X1Rqe54B6dH",
  "refresh_token_expires_in": "86399",
  "session_idle_time": 3600,
  "token_type": "Bearer",
  "access_token": "aYR3Lu3rpsQ9ODhBIR83b3txTr5K",
  "saas_token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMzg2OTAwMCIsImV4cCI6MTY0MDQ0NDAzMn0.lvxFOeCOk-DWi3kqwJwR8eKal3ON2rr53e9I6Pha5rI",
  "expires_in": "2591999",
  "scope": "tenant={tenant}"
}
```

{% hint style="info" %}
The `code_verifier` parameter is required only if using PKCE (Proof Key for Code Exchange) flow. The `session-id` header is optional and should be used to maintain the same session when transitioning from anonymous to authenticated state.
{% endhint %}
{% endstep %}

{% step %}
### Log out

When a customer wants to end their session, you should log them out to invalidate their customer access token. This ensures that the token cannot be used for further authenticated requests.

Send a request to the [Logging out a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-logout) endpoint.

**Note**: The request needs to be authorized with a customer access token.

```bash
curl -i -X GET \
  'https://api.emporix.io/customer/{tenant}/logout?accessToken={customer_access_token}' \
  -H 'Authorization: Bearer {customer_access_token}'
```

**Response:** 204 No Content

{% hint style="info" %}
After logging out, the customer access token is invalidated and cannot be used for further requests. The customer will need to log in again to obtain a new token.
{% endhint %}
{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[API Reference](api-reference/)
{% endcontent-ref %}

