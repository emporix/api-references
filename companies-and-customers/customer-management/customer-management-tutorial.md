---
description:  
icon: graduation-cap
layout:
  width: wide
---

# Customer Service (Customer Managed) Tutorial

The Customer Service (Customer Managed) allows you to create, manage, and delete customer profiles from your commerce frontend perspective. You might use the Customer Service endpoints when implementing your custom commerce storefront or testing out your flows. It enables you to generate relevant access tokens to log in anonymous or registered customers on the storefront.

This tutorial guides you through the process of managing customer authentication, including creating customer accounts, logging in customers, and managing authentication tokens.

## How to manage customer authentication

Customer authentication is a fundamental part of the customer experience. This section covers the complete authentication flow, from requesting anonymous tokens for browsing to logging in registered customers and managing their sessions.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../../companies-and-customers/customer-management/api-reference/" %}
[api-reference](../../../companies-and-customers/customer-management/api-reference/)
{% endcontent-ref %}

{% stepper %}
{% step %}
### Requesting an anonymous token

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
### Refreshing an anonymous token

When the anonymous token is about to expire, use the refresh mechanism to maintain the same customer's session ID and allow them browsing without interruption.

Send a request to the [Refreshing an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customerlogin-auth-anonymous-refresh) endpoint.

```bash
curl -i -X GET \
  'https://api.emporix.io/customerlogin/auth/anonymous/refresh?tenant={tenant}&refresh_token={refresh_token}&client_id={client_id_storefront}'
```

See the sample response:

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
### Creating a new customer

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
        "companyRegistrationId": "123-456-789",
        "legalEntities": [
          {
            "id": "67e162a3ad4e2f12bc4f9306",
            "name": "ABC",
            "contactAssignmentId": "91033918"
          }
        ]
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
### Activating customer account as an employee
The created customer's account is inactive and requires an action on the employee's side to enable and activate the account. To achieve this, you need the relevant **employee access token**. 

{% hint style="success" %}
To obtain the employee token, see the steps described in the [Customer Service (Tenant Managed) Tutorial](../customer-service/api-reference/customer_service_tenant.md).

{% endhint %}

Send the `PATCH` request for [Updating a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber).

```bash
curl -X PATCH "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}" 
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN" 
  -H "Content-Type: application/json" 
  -d '{
    "active": true,
    "onHold": false
  }'
```
As a result, the customer is able to continue with logging in to their account.
{% endstep %}


{% step %}
### Logging in a customer

After creating and getting their account activated, customers can log in to the store using their email and password. This operation returns both a customer access token and a SaaS token.

Send an authorization request to the [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) endpoint, passing the anonymous access token as the authorization method.


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

The example response looks as follows:

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
### Refreshing a customer token

As the customer access tokens expire after 30 days, you need to introduce a mechanism to prolong the session. To maintain an active authenticated session without requiring the customer to log in again, refresh the customer token before it expires.
Send a request to the [Refreshing a customer token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-refreshauthtoken) endpoint.

{% hint style="warning" %} 
Authorize the request with the anonymous access token.
{% endhint %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer/{tenant}/refreshauthtoken?refreshToken={customer_refresh_token}&legalEntityId={legalEntityId}' \
  -H 'Authorization: Bearer {anonymous_access_token}'
```

{% hint style="info" %}
The `legalEntityId` parameter is optional. Use it when you want to associate the session with a specific legal entity.
{% endhint %}
{% endstep %}

{% step %}
### Validating a token

Token validation allows you to verify whether a token is still valid and retrieve information about the token, such as expiration time, scopes, and associated session details. Validate tokens before making authenticated requests to ensure the token hasn't expired or been revoked. This helps prevent authentication errors and allows you to proactively refresh tokens before they expire.

Send a request to the [Validate a token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-validateauthtoken) endpoint.

{% hint style="warning" %}
Authorize the request with the customer access token.
{% endhint %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer/{tenant}/validateauthtoken' \
  -H 'Authorization: Bearer {customer_access_token}'
```

The response includes the details about the token type and granted scopes, for example:

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
If the token is invalid, the endpoint returns a `401 Unauthorized` status code.
{% endhint %}
{% endstep %}

{% step %}
### Logging in a customer using social login

Social login allows customers to authenticate using their existing social media accounts (for example, Google, Facebook) through Auth0. This provides a convenient login experience without requiring customers to create a new password. You can enable the social login option in your store by using a dedicated endpoint.

Send a request to the [Logging in a customer with social login](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-sociallogin) endpoint.

{% hint style="warning" %}
Authorize the request with the anonymous access token.
{% endhint %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer/{tenant}/socialLogin?code={authorization_code}&redirect_uri={redirect_uri}&code_verifier={code_verifier}' \
  -H 'Authorization: Bearer {anonymous_access_token}' \
  -H 'session-id: {session_id}'
```
The response returns the social access token to authenticate the customer.

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
The `code_verifier` parameter is required only if using PKCE (Proof Key for Code Exchange) flow. 
The `session-id` header is optional - use it to maintain the same session when transitioning from anonymous to authenticated state.
{% endhint %}
{% endstep %}

{% step %}
### Logging out the customer

When a customer wants to end their session, log them out to invalidate their customer access token. This ensures that the token cannot be used for further authenticated requests.

Send a request to the [Logging out a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-logout) endpoint.

{% hint style="warning" %}
Authorize the request with a customer access token.
{% endhint %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer/{tenant}/logout?accessToken={customer_access_token}' \
  -H 'Authorization: Bearer {customer_access_token}'
```

{% hint style="info" %}
After logging out, the customer access token is invalidated and cannot be used for further requests. The customer needs to log in again to obtain a new token.
{% endhint %}
{% endstep %}
{% endstepper %}

## How to manage a customer's profile

Once a customer is logged in, they can manage their profile information, including personal details, addresses, and account settings. This section covers all the operations available for managing customer profiles.

{% stepper %}
{% step %}
### Adding an address to a customer profile

Customers can add shipping or billing addresses to their profile. Send a request to the [Adding a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/addresses#post-customer-tenant-me-addresses) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/me/addresses' 
  -H 'Authorization: Bearer {customer_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "contactName": "John Doe",
    "companyName": "Emporix",
    "street": "Platz der Republik",
    "streetNumber": "1",
    "streetAppendix": "",
    "extraLine1": "",
    "extraLine2": "",
    "extraLine3": "",
    "extraLine4": "",
    "zipCode": "11011",
    "city": "Berlin",
    "country": "DE",
    "state": "Berlin",
    "contactPhone": "123456789",
    "tags": ["BILLING", "SHIPPING"]
  }'
```

The response returns the ID of the created address:

```json
{
  "id": "b05c20e034"
}
```

{% hint style="info" %}
Use the `tags` array to specify address types. Common values are `BILLING` and `SHIPPING`, but you can add your own.
{% endhint %}
{% endstep %}

{% step %}
### Retrieving customer addresses

To retrieve all addresses associated with a customer profile, send a request to the [Retrieving customer addresses](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/addresses#get-customer-tenant-me-addresses) endpoint.

```bash
curl -i -X GET 
  'https://api.emporix.io/customer/{tenant}/me/addresses' 
  -H 'Authorization: Bearer {customer_access_token}'
```
The response returns an array of addresses:

```json
[
  {
    "contactName": "John Doe",
    "companyName": "Emporix",
    "street": "Platz der Republik",
    "streetNumber": "1",
    "streetAppendix": "",
    "extraLine1": "",
    "extraLine2": "",
    "extraLine3": "",
    "extraLine4": "",
    "zipCode": "11011",
    "city": "Berlin",
    "country": "DE",
    "state": "Berlin",
    "contactPhone": "123456789",
    "tags": ["BILLING", "SHIPPING"],
    "id": "b05c20e034",
    "isDefault": true
  }
]
```
{% endstep %}

{% step %}
### Retrieving a specific customer address

To retrieve details of a specific address, send a request to the [Retrieving a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/addresses#get-customer-tenant-me-addresses-addressid) endpoint.

{% hint style="warning" %}
Authorize the request with a customer access token.
{% endhint %}

```bash
curl -i -X GET 
  'https://api.emporix.io/customer/{tenant}/me/addresses/{addressId}' 
  -H 'Authorization: Bearer {customer_access_token}'
```

The response returns the address details:

```json
{
  "contactName": "John Doe",
  "companyName": "Emporix",
  "street": "Platz der Republik",
  "streetNumber": "1",
  "streetAppendix": "",
  "extraLine1": "",
  "extraLine2": "",
  "extraLine3": "",
  "extraLine4": "",
  "zipCode": "11011",
  "city": "Berlin",
  "country": "DE",
  "state": "Berlin",
  "contactPhone": "123456789",
  "tags": ["BILLING", "SHIPPING"],
  "id": "b05c20e034",
  "isDefault": true
}
```
{% endstep %}

{% step %}
### Updating a customer address

To update an existing address, send a request to the [Updating a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/addresses#patch-customer-tenant-me-addresses-addressid) endpoint.

```bash
curl -i -X PATCH 
  'https://api.emporix.io/customer/{tenant}/me/addresses/{addressId}' 
  -H 'Authorization: Bearer {customer_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "contactName": "John Doe",
    "companyName": "Emporix",
    "street": "Platz der Republik",
    "streetNumber": "2",
    "streetAppendix": "Platz",
    "extraLine1": "",
    "extraLine2": "",
    "extraLine3": "",
    "extraLine4": "",
    "zipCode": "11011",
    "city": "Berlin",
    "country": "DE",
    "state": "Berlin",
    "contactPhone": "123456789",
    "tags": ["BILLING", "SHIPPING"],
    "isDefault": true
  }'
```

{% hint style="info" %}
Set the `isDefault` to `true` to mark the address as the default address for the customer.
{% endhint %}
{% endstep %}

{% step %}
### Adding tags to a customer address

To add tags to an existing address, send a request to the [Adding tags to a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/addresses#post-customer-tenant-me-addresses-addressid-tags) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/me/addresses/{addressId}/tags?tags=BILLING,SHIPPING,CUSTOM' 
  -H 'Authorization: Bearer {customer_access_token}'
```

{% hint style="info" %}
Provide tags as a comma-separated list in the `tags` query parameter.
{% endhint %}
{% endstep %}

{% step %}
### Deleting a customer address

To remove an address from a customer profile, send a request to the [Deleting a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/addresses#delete-customer-tenant-me-addresses-addressid) endpoint.

```bash
curl -i -X DELETE 
  'https://api.emporix.io/customer/{tenant}/me/addresses/{addressId}' 
  -H 'Authorization: Bearer {customer_access_token}'
```

{% hint style="warning" %}
Deleting an address also removes any accounts associated with it.
{% endhint %}

{% endstep %}
{% endstepper %}

## How to manage customer credentials

Customers may need to change their email address or reset their password. This section covers the complete flow for managing customer credentials, including password reset and email change processes.

{% hint style="info" %}
Note that to properly handle customer notifications, you need to have a mailing service configured first. For more information see [Customer Communication Integrations](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/extensibility-and-integrations/integrations/communication-integration).
{% endhint %}

{% stepper %}
{% step %}
### Requesting a password reset

When a customer forgets their password, they can request a password reset. This sends a unique token to their email address that they can use to set a new password.

Send a request to the [Sending a request to reset a customer password](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/credentials#post-customer-tenant-password-reset) endpoint.

{% hint style="warning" %}
Authorize the request with an anonymous access token.
{% endhint %}

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/password/reset' 
  -H 'Authorization: Bearer {anonymous_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "email": "example@customer.com",
    "site": "main"
  }'
```

{% hint style="info" %}
The `site` parameter is optional and specifies the site from which the password reset request was sent.
{% endhint %}
{% endstep %}

{% step %}
### Resetting a password using token

After the customer receives the password reset token by email, they can use it to set a new password. Send a request to the [Resetting a customer password](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/credentials#post-customer-tenant-password-reset-update) endpoint.

{% hint style="warning" %}
Authorize the request with the anonymous access token.
{% endhint %}

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/password/reset/update' 
  -H 'Authorization: Bearer {anonymous_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "token": "beExUmshJC5gnuXk1kET5dCLyQWkrAfKRGFOxVXLcJI13R1fn5USjaWku5G71whM",
    "password": "P@ssw0rd123"
  }'
```

{% hint style="info" %}
The token is sent to the customer's email address and is required to complete the password reset process.
{% endhint %}
{% endstep %}

{% step %}
### Changing a password

When a customer is logged in and wants to change their password, they can do so by providing their current password and the new password. Send a request to the [Changing a customer password](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/credentials#post-customer-tenant-password-change) endpoint.

{% hint style="warning" %}
Authorize the request with a customer access token.
{% endhint %}

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/password/change' 
  -H 'Authorization: Bearer {customer_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "currentPassword": "password123",
    "newPassword": "P@ssw0rd123"
  }'
```

{% hint style="info" %}
The customer must provide their current password to verify their identity before setting a new password.
{% endhint %}
{% endstep %}

{% step %}
### Request an email change

Customers can request to change their email address. This sends a confirmation token to the new email address. Send a request to the [Sending a request to update a customer email address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/credentials#post-customer-tenant-me-accounts-internal-email-change) endpoint.

{% hint style="warning" %}
Authorize the request with a customer access token.
{% endhint %}

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/me/accounts/internal/email/change' 
  -H 'Authorization: Bearer {customer_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "email": "example@customer.com",
    "password": "password123",
    "newEmail": "example@emporix.com",
    "syncContactEmail": true
  }'
```

{% hint style="info" %}
Set `syncContactEmail` to `true` if you want the `contactEmail` field in the customer profile to be updated to match the new email address.
{% endhint %}
{% endstep %}

{% step %}
### Confirming an email change

After the customer receives the confirmation token by email at their new email address, they can confirm the email change. Send a request to the [Updating a customer email address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/credentials#post-customer-tenant-me-accounts-internal-email-change-confirm) endpoint.

{% hint style="warning" %}
Authorize the request with an anonymous access token.
{% endhint %}

```bash
curl -i -X POST 
  'https://api.emporix.io/customer/{tenant}/me/accounts/internal/email/change/confirm' 
  -H 'Authorization: Bearer {anonymous_access_token}' 
  -H 'Content-Type: application/json' 
  -d '{
    "token": "beExUmshJC5gnuXk1kET5dCLyQWkrAfKRGFOxVXLcJI13R1fn5USjaWku5G71whM"
  }'
```

{% hint style="info" %}
The token is sent to the new email address and must be used to complete the email change process.
{% endhint %}
{% endstep %}
{% endstepper %}


