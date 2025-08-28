---
seo:
  title: Identity providers at Emporix
  description: IDPs, token, tokens, login, social login, 
icon: id-card-clip
---

# Identity Providers

Emporix makes it possible to create standard customer tokens based on authentication provided by third-party identity providers (IDPs). You can use external IDPs to offer the users alternative ways of signing up, such as social login. 

**Social login** is a single sign-on method that allows customers to authenticate themselves with an existing social media account. Introducing social login to your storefront simplifies the registration process by eliminating the need to manually create an account.

Emporix uses **Ory** as its primary authentication provider and also integrates with **Auth0** and **Keycloak** as external IDPs.

## Configuring multiple IDPs

With Emporix, you can configure one or multiple Identity Providers (IDPs) within a single tenant. When submitting your IDP configuration, you need to specify whether you want to use a single IDP or multiple IDPs.

Multiple IDPs mean either different providers (for example Auth0 or Keycloak), or the same provider with multiple realms.

To set up multiple IDPs:

{% stepper %}
{% step %}
### Provide a unique name for each configuration
The unique naming is necessary for the storefront reference, where the configuration uses the name to decide which IDP should be used in a given case. For example: `auth0_de`, `auth0_pl`, `keycloak_en`, `keycloak_de`.
{% endstep %}
{% step %}
### Initiate the authentication flow 
Use the OAuth2 `state` parameter when initiating the authentication flow on the storefront. The parameter must follow this format: `{configName}--{randomValue}`.
{% endstep %}
{% endstepper %}

Emporix extracts the `configName` and matches it to the corresponding configuration.

* If a match is found, that configuration is used.
* If no match is found, the default configuration is used. 


## Support for external identity providers

See the documentation below for configuration details of different external IDPs:

* [Auth0](auth0.md)
* [Keycloak](keycloak.md)

