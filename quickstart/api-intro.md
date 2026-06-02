---
layout:
  width: wide
icon: code-branch
description: Get familiar with Emporix API.
---
# Getting Started with Emporix API 

## API Quickstart

Download API references:

<a href="https://github.com/emporix/api-references/releases/latest/download/api-references.zip" class="button primary" data-icon="down-to-line">Download all Emporix API Specs - ZIP</a>

For easier testing of Emporix API, check out the Postman Collection with example flows:

{% embed url="https://www.postman.com/emporix/emporix-commerce-orchestration-platform/overview" %}


## Introduction

The Emporix API is the core of our Commerce Engine designed to help you easily manage your business's resources. It is organized around REST and makes use of the following components:

* [OAuth 2.0](https://oauth.net/2/) token-based authorization
* Resource-oriented URLs
* HTTP request methods
* JSON-encoded requests and responses
* HTTP status codes

You can check the current status of Emporix API services on the [Emporix Status Page](https://status.emporix.io).

### Base URL

```
https://api.emporix.io
```

{% hint style="warning" %}
To start working with our API, make sure to allowlist the [api.emporix.io](http://api.emporix.io/) IP: 34.128.182.253.
{% endhint %}

## Authentication and authorization scopes

The Emporix API incorporates [OAuth 2.0](https://oauth.net/2/) token-based authorization. API keys are used to generate access tokens, which are then used to authorize HTTP methods.

{% hint style="info" %}
To get familiar with the **authentication and access scopes**, refer to the [Tokens and Scopes](../quickstart/authentication-and-authorization/tokens-and-scopes.md) guide.
{% endhint %}

<!-- ### API credentials

The Emporix Developer Portal provides you with two types of credentials:

* **Emporix API** — used to access the API from a business user's perspective.
* **Storefront API** — used to access the API from a customer's perspective. These credentials are used to perform basic actions on the storefront — browse products, view prices, or add products to a cart.

In the Developer Portal, you can define custom API keys that grant access to specific resources. This allows you to control authorization for particular users or simulate specific scenarios. -->

<!-- ### Types of access tokens

When using our API, you will come across four types of access tokens:

| Token type           | Description                                                                                                                                                                                                               | Emporix API endpoint                                  |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| Anonymous token      | Used by the storefront to access public resources with a reading scope. It allows customers to browse products, view prices, or add products to a cart. The anonymous token is not associated with any specific customer. | [Requesting an anonymous token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization)     |
| Customer token       | A JSON Web Token (JWT) which contains encrypted customer data. The customer token works similarly to the anonymous token, but it is associated with a specific customer.                                                  | [Requesting a customer token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization)       |
| Refresh token        | Used to refresh the customer token.                                                                                                                                                                                       | [Requesting a refresh token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization)        |
| Service access token | Needed to access and manage the Emporix services such as adding new products, managing categories, or modifying prices.                                                                                                   | [Requesting a service access token](https://developer.emporix.io/api-references/api-guides/authorization/oauth-service/api-reference/service-access-token) | -->

<!-- ### Scopes

When you request an access token, you can see a `scope` field in the response. Scopes define which operations you are allowed to perform and which resources you can access.

The overall naming convention for scopes is `[service_name].[resource_name]_[action_name]`.

The action names `read` and `view` are used interchangeably and both mean that the scope grants read-only access to a particular resource.

Anonymous, customer, and refresh tokens have a pre-defined set of scopes. You can request specific scopes only when requesting a service access token. To find out which scopes are needed to access a particular endpoint, check its description in the Emporix API Reference.

Some endpoints do not require any scopes as they are implicitly readable. -->

## Customer audit logs

You can request customer audit logs from Emporix by reaching out to our [Support Team](mailto:support@emporix.com) and sending the email request.\
The logs are kept for the last 712 days. You can retrieve information about create, update or delete operations. The records contain information about the tenant, timestamp and the person who performed the actions.

## Quick start guide for developers

### Before you start

Make sure you have an account on the [Emporix Developer Portal](https://app.emporix.io).

### Retrieve your Emporix API keys

To access the Emporix API, you first need to retrieve your API keys. Perform the following steps:

{% stepper %}
{% step %}
Log in to the [Emporix Developer Portal](https://app.emporix.io).
{% endstep %}
{% step %}
Go to the **Manage API Keys** tab and copy the **Client ID** and **Secret** values from the Emporix API.
{% endstep %}
{% step %}
Authenticate and authorize yourself by obtaining the service token. See more details in the [OAuth Service Tutorial](../authentication/oauth-service/oauth.md).
For example:
```bash
curl --location --request POST 'https://api.emporix.io/oauth/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id={{Client_ID}}' \
--data-urlencode 'client_secret={{Client_Secret}}'
```
{% endstep %}
{% step %}
Send a sample request. For example, create a basic product:

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/product/{tenant}/products' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "Smartphone X2",
    "code": "BASIC001",
    "description": "The world best camera and camcorder in a waterproof smartphone.",
    "published": false,
    "productType": "BASIC"
  }'
```
{% endstep %}
{% endstepper %}

{% hint style="danger" %}
If you want to send a request to an endpoint that requires a different set of scopes, you need to generate a new access token.
{% endhint %}

### Explore the Emporix API

You're all set! You can now interact with the Emporix API. 
