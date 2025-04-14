---
seo:
  title: Introduction to Emporix API
  description: Introduction to Emporix API
label: Getting started with Emporix API
---

# Getting started with Emporix API

## Introduction

The Emporix API is the core of our Commerce Engine designed to help you easily manage your business's resources. It is organized around REST and makes use of the following components:

* [OAuth 2.0](https://oauth.net/2/) token-based authorization.
* Resource-oriented URLs.
* [HTTP request methods](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods).
* JSON-encoded requests and responses.
* [HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes).

You can check the current status of Emporix API services on the [Emporix Status Page](https://status.emporix.io).

### Base URL

```
https://api.emporix.io
```

:::info

To start working with our API, make sure to allowlist [api.emporix.io](http://api.emporix.io/) IP: 34.128.182.253.

:::

## Authorization and scopes

The Emporix API incorporates [OAuth 2.0](https://oauth.net/2/) token-based authorization. API keys are used to generate access tokens, which are then used to authorize HTTP methods.

### API credentials

The Emporix Developer Portal provides you with two types of credentials:

* **Emporix API** — used to access the API from a business owner's perspective.
* **Storefront API** — used to access the API from a customer's perspective. These credentials are used to perform basic actions on the storefront — browse products, view prices, or add products to a cart.

### Types of access tokens

When using our API, you will come across four types of access tokens:

| Token type | Description | Emporix API endpoint |
|---|---|---|
| Anonymous token | Used by the storefront to access public resources with a reading scope. It allows customers to browse products, view prices, or add products to a cart. The anonymous token is not associated with any specific customer. | [Requesting an anonymous token](/openapi/oauth/#operation/GET-oauth-generate-anonymous-access-token) |
| Customer token | A JSON Web Token (JWT) which contains encrypted customer data. The customer token works similarly to the anonymous token, but it is associated with a specific customer. | [Requesting a customer token](/openapi/oauth/#operation/POST-oauth-authorize-customer) |
| Refresh token | Used to refresh the customer token. | [Requesting a refresh token](/openapi/oauth/#operation/GET-oauth-refresh-token) |
| <nobr>Service access token</nobr> | Needed to access and manage the Emporix services such as adding new products, managing categories, or modifying prices. | [Requesting a <nobr>service access token</nobr>](/openapi/oauth/#operation/POST-oauth-request-client-credentials) |

### Scopes

When you request an access token, you can see a `scope` field in the response. Scopes define which operations you are allowed to perform and which resources you can access.

<Alert variant="attention">
The overall naming convention for scopes is <code>[service_name].[resource_name]_[action_name]</code>.

The action names `read` and `view` are used interchangeably and both mean that the scope grants read-only access to a particular resource.

</Alert>

Anonymous, customer, and refresh tokens have a pre-defined set of scopes. You can request specific scopes only when requesting a service access token. To find out which scopes are needed to access a particular endpoint, check its description in the Emporix API Reference.

<Alert variant="attention">
Some endpoints do not require any scopes as they are implicitly readable.
</Alert>

## Customer audit logs

You can request customer audit logs from Emporix by reaching out to our [Support Team](mailto:support@emporix.com) and sending the email request. 
The logs are kept for the last 2 years. You can retrieve information about create, update or delete operations. The records contain information about the tenant, timestamp and the person who performed the actions. 


## Quick Start Guide for developers

### Before you start

Make sure you have an account on the [Emporix Developer Portal](https://app.emporix.io).

### Retrieve your Emporix API keys

To access the Emporix API, you first need to retrieve your API keys. Perform the following steps:

1. Log in to the [Emporix Developer Portal](https://app.emporix.io).
2. Go to the **Manage API Keys** tab.
3. Copy the **Client ID** and **Secret** values from the Emporix API row.

### Send a sample request

You can now use your Emporix API keys to authorize requests. Try it out by calling the <Button to="/openapi/site-settings/#operation/GET-site-settings-list-site-configurations" size="small">Retrieving sites</Button> endpoint:

<OpenApiTryIt
  definitionId="site-settings"
  operationId="GET-site-settings-list-site-configurations"
  parameters={{
    query: {
        pageNumber: 1,
        pageSize: 100,
        q: " ",
        expand: " "
    }
  }}
/>


You should receive your main site's settings in the response body.

:::warning

If you want to send a request to an endpoint that requires a different set of scopes, you need to generate a new access token.
:::

### Explore the Emporix API

You're all set! You can now interact with the Emporix API.
