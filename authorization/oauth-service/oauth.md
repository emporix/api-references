---
title: OAuth Service Tutorial
icon: graduation-cap
layout:
  width: wide
---

# OAuth Tutorial

This tutorial explains how to obtain a **service access token** from the OAuth Service. A service access token is required in server-to-server calls in your backend, scripts or jobs to call Emporix APIs for tasks such as adding products, managing categories, or modifying prices. 

## Prerequisites

Before requesting a token, ensure you have:

* **Client ID** – Your application's client identifier
* **Client secret** – Your application's client secret
* **Scope** – At least one scope, for example `tenant={tenant}` (replace `{tenant}` with your tenant identifier). Multiple scopes can be specified, separated by spaces.

These data can be found in the Developer Portal.

## Requesting a service access token

The OAuth Service uses the **client credentials** grant type, so you receive an access token by sending a request authenticating with your client ID and secret.

{% stepper %}
{% step %}
#### Send an authentication request

Send a `POST` request to the token endpoint with form-encoded credentials.

**Endpoint:** `POST https://api.emporix.io/oauth/token`

**Headers:**

| Header | Value |
|--------|--------|
| `Content-Type` | `application/x-www-form-urlencoded` |

**Request body (form parameters):**

| Parameter | Description |
|-----------|-------------|
| `grant_type` | Always `client_credentials` for service access tokens |
| `client_id` | Your client ID |
| `client_secret` | Your client secret |
| `scope` | One or more scopes (for example, `tenant={tenant}`) |

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[API reference](api-reference/)
{% endcontent-ref %}

**Example request:**

```bash
curl -i -X POST 'https://api.emporix.io/oauth/token' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'client_id={client_id}' \
  -d 'client_secret={client_secret}' \
  -d 'grant_type=client_credentials' \
  -d 'scope=tenant={tenant}'
```

Replace `{client_id}`, `{client_secret}`, and `{tenant}` with your actual values.
{% endstep %}

{% step %}
#### Use the response

A successful response returns a JSON object containing the access token and metadata:

| Field | Description |
|--------|-------------|
| `access_token` | The token to use in the `Authorization` header when calling Emporix APIs |
| `token_type` | Always `Bearer` |
| `expires_in` | Token lifetime in seconds (e.g. 14399) |
| `session_idle_time` | Session idle time in seconds |
| `scope` | The granted scope(s) |
| `refresh_token` | Empty for service access tokens (not supported) |
| `refresh_token_expires_in` | 0 for service access tokens |

**Example response:**

```json
{
  "access_token": "vkFuQ6oTwj8_Ye4eiRSsqMeqLYNeQRJi",
  "token_type": "Bearer",
  "expires_in": 14399,
  "session_idle_time": 120,
  "refresh_token": "",
  "refresh_token_expires_in": 0,
  "scope": "tenant={tenant} ..."
}
```

Use the token in subsequent API calls by setting the `Authorization` header:

```text
Authorization: Bearer <access_token>
```
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
**No refresh tokens:** The OAuth Service does not support refresh tokens for service access tokens. When your token expires, send a new authentication request to `POST /oauth/token` to obtain a new access token.
{% endhint %}