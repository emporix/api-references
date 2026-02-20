---
icon: user-key
description: Implement SSO solution to authenticate your customers on the storefront.
---

Emporix supports a Single Sign-On (SSO) mechanism based on the OAuth 2.0 authorization code flow that provides a holistic approach to customer authentication on the storefront. 

{% hint style="info" %}
If you do not use an external IDP, the customers' data is stored in the Emporix database.
{% endhint %}

You can use the Emporix solution alone or integrate a chosen Identity Provider (IDP), such as Keycloak, Auth0, or any other OpenID Connect–compliant provider.

## How the SSO flow works

The following steps describe the end-to-end SSO authentication flow in the Emporix implementation.

{% stepper %}
{% step %}
### Initiation

The storefront (frontend) initiates the SSO flow by redirecting the customer to your configured Identity Provider. The customer authenticates with the IDP using its native login (for example, corporate credentials or social login).

{% endstep %}

{% step %}
### Callback with authentication code

After successful authentication, the Identity Provider redirects the customer back to a designated Emporix callback endpoint, including a one-time authentication code in the request. This code is short-lived and must not be used directly by the customer.

{% endstep %}

{% step %}
### Token exchange (backend)

The Emporix Authentication Service receives the callback and exchanges the authentication code with the OpenID Provider for an access token (and optionally a refresh token). This exchange happens server-side.
{% endstep %}

{% step %}
### Emporix token generation

Emporix then issues the Emporix-specific OAuth token and returns it to the client (application/system). All subsequent API calls are authenticated using this Emporix token, not the IDP token.
{% endstep %}

{% step %}
### API access

The client uses the Emporix token to call Emporix APIs. Authentication and session management are handled by Emporix based on this token.
{% endstep %}
{% endstepper %}

```mermaid
---
config:
  layout: fixed
  theme: base
  themeVariables:
    primaryColor: '#DDE6EE'
    primaryBorderColor: '#4C5359'
    actorBkg: '#DDE6EE'
    actorBorder: '#4C5359'
    actorLineColor: '#4C5359'
    signalColor: '#E86C07'
    signalTextColor: '#7B8B99'
    background: transparent 
---
sequenceDiagram
  User->>Frontend: Start SSO login
Frontend->>OpenID Provider: Redirect user (authorization request)
OpenID Provider-->>OpenID Provider: Authenticate user
OpenID Provider-->>Emporix Authentication Service: Redirect back with authorization code
Emporix Authentication Service->>Emporix Customer Service: Forward authorization code
Emporix Customer Service->>OpenID Provider: Exchange code for access token
OpenID Provider->>Emporix Authentication Service: Access token (OIDC)
Emporix Authentication Service-->>Frontend: Emporix-specific OAuth token
Frontend->>API: Call APIs with Emporix token
API-->>Frontend: API response
```

This design keeps Emporix as the sole authority for the authentication-code exchange and token generation in the SSO flow. The Identity Provider is responsible for authenticating the customer. Emporix is responsible for issuing and validating tokens used to access Emporix APIs.

{% hint style="success" %}
See the example flows that incorporate an external Identity Provider into the process:

 * [Identity Providers](../../integrations/authentication/identity-providers.md)
    * [Auth0](../../integrations/authentication/auth0.md)
    * [Keycloak](../../integrations/authentication/keycloak.md)
{% endhint %}

