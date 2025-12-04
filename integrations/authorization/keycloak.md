---
seo:
  title: Keycloak
  description: Keycloak integration
  parent: identity-providers
icon: id-badge
---

# Keycloak

[Keycloak](https://www.keycloak.org) is an open-source Identity and Access Management (IAM) solution that supports standard protocols like OpenID Connect, OAuth 2.0, and SAML 2.0. Integrating Keycloak with Emporix allows for secure management of user authentication and access across applications. At the same time, it reduces development effort and aligns with enterprise compliance needs.

## Prerequisites

If you want to integrate your Keycloak account with Emporix, contact our [Emporix Support Team](mailto:support@emporix.com) and provide us with the following data:

```bash
{
    "domain" : "",
    "token_endpoint": "",
    "provider": "keycloak",
    "client_id" : "",
    "redirect_uri" : "",
    "client_secret" : "",
    "public_key" : ""
}
```

* The `domain` is the Keycloak domain value, for example, `keycloak.eu.yourdomain.com`.
* The `token_endpoint` is the endpoint that is used for the token call, for Keycloak it’s usually `protocol/openid-connect/token`.
* The `provider` is the provider that is configured for the IDP, the provider value can be then used in the state parameter, thanks to that it’s possible to have multiple configurations for one tenant, for example, `keycloak_siteA`, `keycloak_siteB`.
* The `client_id` and `client_secret` are the credentials provided by the customer, to find the credentials in the Keycloak app go to **Clients** -> **Clients list**.
* The `redirect_uri` is a value provided by customer that indicates where a user should be redirected after authentication flow. The value points storefront URL, for example, `https://storefront.emporix.io/keycloak`.
* The `public_key` is a value provided by customer as their signing certificate. It has to be stored in one line, however each line of the original certificate value should be separated by `\n`. Copy the value to the json in the `public_key` field and surround it with `-----BEGIN CERTIFICATE-----\n{TOKEN}\n-----END CERTIFICATE-----`

Request example:

```bash
{
    "domain" : "keycloak.eu.yourdomain.com",
    "token_endpoint": "protocol/openid-connect/token",
    "provider": "keycloak",
    "client_id" : "showcase",
    "redirect_uri" : "https://storefront.emporix.io/keycloak",
    "client_secret" : "8Ku1to4R3mJAJ3tJ3u045EgKt4YfqRoN",
    "public_key" : "-----BEGIN CERTIFICATE-----\nMIICnzCC+F0\n-----END CERTIFICATE-----"
}
```

## Keycloak configuration flow with social login diagram

<figure><img src="../../.gitbook/assets/keycloak_diagram.svg" alt=""><figcaption></figcaption></figure>
