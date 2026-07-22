---
description: >-
  Use this OpenAPI starter when creating a new API reference in the
  api-references repository.
icon: file-code
---

# API Reference

Use this template when adding a new service API reference (OpenAPI `.yml`) in the [emporix/api-references](https://github.com/emporix/api-references) repository.

* Authoring rules: [API References](../writing-standards/api-references.md)
* Starter file: [api-reference.yml](api-reference.yml)

Copy `api-reference.yml`, rename it for your service, and replace the Product Service placeholders with the real service name, paths, schemas, scopes, and examples.

{% hint style="info" %}
Leave `info.version` empty. Declare scopes on `security` / `securitySchemes` only — do not duplicate them in endpoint descriptions.
{% endhint %}
