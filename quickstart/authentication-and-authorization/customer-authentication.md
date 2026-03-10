---
layout:
  width: wide
icon: user-key
description: Learn how customer authentication works in Emporix.
---

# Customer Authentication

Emporix provides you with tools how you can authenticate and authorize the storefront customers. Check the dedicated guides:

* [SSO Authentication](sso-authentication.md)
* [Token Exchange](token-exchange.md)

## Authorization code vs Token exchange approaches 

You can choose between delegating the entire flow to Emporix for simplicity or utilizing the exchange endpoint for greater architectural flexibility. 

| Aspect | **SSO authorization code flow** | **SSO Token exchange flow** |
| ------- | --------------------- | ----------------------- |
| Integration | The standard SSO flow provides simple integration for clients, requiring only minimal OAuth logic implementation. | The token exchange flow offers full flexibility for clients to integrate Emporix with other internal or third-party services. |
| Flow Ownership | Emporix maintains centralized control over authentication and token generation throughout the entire flow. | The token exchange flow separates responsibilities: the client owns the authentication process, while Emporix owns authorization within its own domain. |
| Token lifecycle and validation | Tokens follow a consistent Emporix structure and lifecycle management. | Emporix supports token validation for externally issued tokens while maintaining its own token structure. |
| Risk mitigation | The standard flow reduces the risk of misconfiguration on the client side by handling the authentication process centrally. | Clients must correctly implement OAuth flows and token management, which increases the responsibility and potential for configuration errors. |
| Authentication code access | The authorization code is consumed exclusively by Emporix. Clients do not receive authentication codes or external access tokens, as the entire process is fully maintained at Emporix. Clients cannot generate their own tokens for non-Emporix services. | Clients can reuse authentication results because they authenticate the customer and obtain an access token in their own system before exchanging it with Emporix. |
| Limitation | The standard flow creates tight coupling between Emporix and the authentication process, limiting flexibility. | The token exchange flow requires higher integration complexity for clients, which may not be suitable for all use cases. |
| Good fit | The standard SSO flow is well-suited for enterprises that do not have external systems and do not want to invest in implementing own authentication mechanisms, but instead they want to delegate the whole authentication flow to Emporix. | The token exchange flow is ideal for large enterprises and platform customers with complex distributed ecosystems that already use own authentication flow and require greater architectural flexibility. |

{% hint style="danger" %}
SSO authentication code flow and token exchange flow are two separate approaches that you can choose from when enabling customer authentication in the webshop storefront, based on your integration needs. You cannot mix both flows in one implementation to mitigate ambiguity and security risks.
{% endhint %}