---
layout:
  width: wide
icon: square-binary
description: Implement token exchange as a way to authenticate your customers.
---

# Token Exchange

The **Token Exchange** flow extends the existing Single Sign-On (SSO) system to allow alternative way to authenticate end-customers. The standard SSO implementation offered at Emporix allows you to cover the whole authentication flow fromstart to end using your preferred identity provider in the middle, while Emporix manages the entire authentication code exchange.
However, at enterprises with complex enterprise ecosystems where businesses need to use their own identity tokens across multiple platforms, it is crucial to maintain full ownership of the initial authentication process. In such a case, token exchange is a solution that allows you to unify Emporix authentication within your existing system network.

You can choose between delegating the entire flow to Emporix for simplicity or utilizing the exchange endpoint for greater architectural flexibility. 