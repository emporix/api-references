---
icon: flask
description: >-
  Use the public Emporix Postman Collection to test API endpoints and run
  example flows for the Commerce Orchestration Platform.
layout:
  width: wide
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
---

# Postman Collection

The public Emporix Postman Collection helps you test Emporix API endpoints and try example request flows without building your own request set from scratch.

Use it when you want to:

* Explore Emporix API services in Postman
* Run example authentication and commerce flows
* Validate requests and responses against a live tenant

## Open the collection

Open the Emporix Commerce Orchestration Platform workspace on Postman:

{% embed url="https://www.postman.com/emporix/emporix-commerce-orchestration-platform/overview" %}

[Emporix Postman Collection — Commerce Orchestration Platform](https://www.postman.com/emporix/emporix-commerce-orchestration-platform/overview)

## Before you run requests

To run requests from the Postman Collection, perform the following steps:

{% stepper %}
{% step %}
Fork or import the collection into your Postman workspace.
{% endstep %}

{% step %}
Retrieve your Emporix API keys. Log in to the [Emporix Developer Portal](https://app.emporix.io), go to **Manage API Keys**, and copy the **Client ID** and **Secret** for the Emporix API.
{% endstep %}

{% step %}
Set your tenant credentials and environment variables in Postman for the Emporix API base URL `https://api.emporix.io`.
{% endstep %}

{% step %}
Obtain an access token. See [Tokens and Scopes](authentication-and-authorization/tokens-and-scopes.md).
{% endstep %}
{% endstepper %}

{% hint style="info" %}
For the API overview, downloadable OpenAPI specs, and base URL details, see [Getting Started with Emporix API](api-intro.md).
{% endhint %}
