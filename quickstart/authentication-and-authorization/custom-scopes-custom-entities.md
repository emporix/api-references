---
seo:
  title: Custom scopes for custom entities
  description: End-to-end IAM and Schema authorization for tenant-defined custom entities
icon: key
layout:
  width: wide
---

# Custom scopes for custom entities

This tutorial explains how to configure end-to-end authorization for custom entities by combining IAM custom scopes and Schema custom-instance APIs.

{% hint style="info" %}
This functionality is still under development. Management Dashboard support is being added and may not yet expose all flows described in this tutorial.
{% endhint %}

## Why this flow matters

When tenants define custom entities, authorization should remain consistent with platform entities. The platform therefore supports:

- tenant-defined custom scopes in IAM
- automatic type-specific scopes for custom entities in Schema
- ownership-aware scopes (`*_own`) for creator-limited access

## Scope model

### Tenant-wide Schema scopes

- `schema.custominstance_read`
- `schema.custominstance_manage`

These scopes apply to custom instances across all custom entity types.

### Type-specific custom scopes

When a custom entity type is created (for example `DOCUMENT`), scopes are provisioned for that type:

- `custom.document_read`
- `custom.document_manage`
- `custom.document_read_own`
- `custom.document_manage_own`

These scopes target a single custom entity type.

### Ownership (`*_own`) semantics

To support ownership-based access checks, custom instances include immutable owner data:

```json
{
  "owner": {
    "type": "CUSTOMER",
    "userId": "79474954",
    "legalEntityId": "0149b1314144a01491314z128"
  }
}
```

`owner` is assigned when an instance is created and must not be updated later.

## End-to-end setup

{% stepper %}
{% step %}
### Create or upsert a custom entity type in Schema

Create a type with the Schema custom-entities API. This is the step that provisions type-scoped `custom.{lowerCaseType}_*` scopes.

{% content-ref url="../../utilities/schema/api-reference/custom-schema-type" %}
[custom-schema-type](../../utilities/schema/api-reference/custom-schema-type)
{% endcontent-ref %}
{% endstep %}

{% step %}
### Define IAM custom scopes (optional but recommended)

Use IAM custom-scopes endpoints to define any additional tenant-specific scopes needed by your authorization model.

{% content-ref url="../../users-and-permissions/iam/api-reference/custom-scopes" %}
[custom-scopes](../../users-and-permissions/iam/api-reference/custom-scopes)
{% endcontent-ref %}
{% endstep %}

{% step %}
### Map scopes into access controls

Create or upsert IAM access controls that resolve to the required scopes (`schema.custominstance_*` and/or `custom.{lowerCaseType}_*`).

{% content-ref url="../../users-and-permissions/iam/api-reference/access-controls" %}
[access-controls](../../users-and-permissions/iam/api-reference/access-controls)
{% endcontent-ref %}
{% endstep %}

{% step %}
### Assign access controls to groups and users

Assign access controls to IAM groups and assign users to these groups.

{% content-ref url="../../users-and-permissions/iam/api-reference/groups" %}
[groups](../../users-and-permissions/iam/api-reference/groups)
{% endcontent-ref %}
{% endstep %}

{% step %}
### Request OAuth2 tokens and call Schema custom-instance APIs

Call custom-instance APIs with one of the accepted scope sets:

- Read endpoints: `schema.custominstance_read` or `custom.{lowerCaseType}_read` or `custom.{lowerCaseType}_read_own`
- Manage endpoints: `schema.custominstance_manage` or `custom.{lowerCaseType}_manage` or `custom.{lowerCaseType}_manage_own`

{% content-ref url="../../utilities/schema/api-reference/custom-instance" %}
[custom-instance](../../utilities/schema/api-reference/custom-instance)
{% endcontent-ref %}
{% endstep %}
{% endstepper %}

## Example decision guide

- Use `schema.custominstance_*` when the client must handle many custom entity types.
- Use `custom.{lowerCaseType}_*` when you need least-privilege, type-specific access.
- Use `*_own` scopes when users should only access instances they created.

## Related tutorials

- [IAM Tutorial](../../users-and-permissions/iam/iam.md)
- [Schema Tutorial](../../utilities/schema/schema.md)
