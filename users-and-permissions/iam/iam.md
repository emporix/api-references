---
seo:
  title: IAM Service Tutorials
  description: identity access management, access control groups, users
icon: graduation-cap
layout:
  width: wide
---

# IAM Tutorial

{% hint style="warning" %}
Names and descriptions of groups, permissions, resources, access control templates, and role resources are localized.

Looking for more info on localization? Check out [_Standard practices_](../../standard-practices/translations.md).
{% endhint %}

## How to create a group of employees with a specific set of access controls

To specify user access level in a particular service resource, you need to create a group of users that share the same access controls.\
For the purposes of this tutorial, you will create an employee group with manager rights in Catalog API service.

### Before you start

Ensure you have a tenant and users created.

{% hint style="warning" %}
To create users, check out the **Manage Users** tab in the [Emporix Developer Portal](https://app.emporix.io/users).
{% endhint %}

### Retrieve a list of available access controls

{% hint style="warning" %}
Access controls are predefined and designed to cover all necessary scenarios. It is not possible to create your own access controls.
{% endhint %}

To assign specific access control level to a group, first you need to retrieve a list of predefined access controls available for your tenant by sending a request to the [Retrieving all access controls](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../iam/api-reference/" %}
[api-reference](../iam/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/iam/{tenant}/access-controls?pageNumber=1&pageSize=60&metadataModifiedAt=2022-01-01&roleId=1rl5e52e-6e27-4ac5-9471-2467d3fb7503&resourceId=string&expand=role%2Cresource' 
  -H 'Accept-Language: string' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'X-Total-Count: true'
```

### Create an employee group

Employee groups aggregate users that share the same access control within a particular service and resource. Create an employee group and assign access controls to it by sending a request to the [Creating a new group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups) endpoint.

{% hint style="warning" %}
The user type in the `userType` parameter can be specified as `CUSTOMER` or `EMPLOYEE`. For the purposes of this tutorial, set the `userType` parameter as `EMPLOYEE`.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../iam/api-reference/" %}
[api-reference](../iam/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/iam/{tenant}/groups' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: de' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": {
      "en": "Catalog managers",
      "de": "Katalogmanager"
    },
    "description": {
      "en": "A group with manager access to the Catalog service.",
      "de": "Eine Gruppe mit Managerzugriff auf den Katalogservice."
    },
    "accessControls": [
      "5ac869fc-d548-4ec8-8e06-c01491314101"
    ],
    "templates": [
      "2ac869fc-d548-4ec8-8e06-c01491314144"
    ],
    "b2b": {
      "legalEntityId": "0149b1314144a01491314z128"
    },
    "userType": "EMPLOYEE",
    "mixins": {}
  }'
```

### Assign users to an employee group

By assigning a user to a particular employee group, you grant them a specific access control level. Create assignments by calling the [Adding a user to a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups-groupid-users) endpoint.

{% hint style="warning" %}
The user type in the `userType` parameter can be specified as `customer` or `employee`. For the purposes of this tutorial, set the `userType` parameter as `employee`.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../iam/api-reference/" %}
[api-reference](../iam/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/iam/{tenant}/groups/{groupId}/users' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "userId": " ",
    "userType": "EMPLOYEE"
  }'
```
 
## How to manage custom scopes

In addition to the standard authorization model, the IAM Service also supports tenant-specific custom scopes, allowing you to extend access control beyond the default capabilities. Custom access controls can be created as collections of scopes and assigned to groups representing employees, customers, or technical users.

When a group is linked to a custom access control, its users automatically inherit both the platform’s default scopes and any tenant-specific scopes.

Typical flow:

1. Create or update a custom scope in IAM.
2. Create or update an access control that resolves to this scope.
3. Assign the access control to a user group.
4. Assign users to the group and request OAuth2 tokens.
5. Verify the assigned controls and scopes.

{% stepper %}
{% step %}
### Create or update a custom scope

To create or update a custom scope, call the [Upserting a custom scope](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/custom-scopes#put-iam-tenant-custom-scopes-scopeid) endpoint.

```bash
curl -i -X PUT \
  'https://api.emporix.io/iam/{tenant}/custom-scopes/myproject.bulk_export_manage' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "description": {
      "en": "Allows triggering bulk export jobs."
    }
  }'
```

{% endstep %}

{% step %}
### Create or update an access control that uses custom scopes

Access controls map roles and resources to resolved scopes and are assigned to groups. To create or update an access control, call the [Upserting an access control](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/access-controls#put-iam-tenant-access-controls-accesscontrolid) endpoint.

```bash
curl -i -X PUT \
  'https://api.emporix.io/iam/{tenant}/access-controls/custom-bulk-export-manage' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "resourceId": "myproject.bulk_export",
    "roleId": "manage",
    "scopes": [
      "myproject.bulk_export_manage"
    ]
  }'
```

{% endstep %}

{% step %}
### Assign access controls through groups

To assign access controls, call the [Creating a new group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups) endpoint and include your access control IDs in the payload.

```bash
curl -i -X POST \
  'https://api.emporix.io/iam/{tenant}/groups' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": {
      "en": "Bulk Export Managers"
    },
    "userType": "EMPLOYEE",
    "accessControls": [
      "custom-bulk-export-manage"
    ]
  }'
```

Then call the [Adding a user to a group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups-groupid-users) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/iam/{tenant}/groups/{groupId}/users' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "userId": "00u4ukqvzlEP31sCk417",
    "userType": "EMPLOYEE"
  }'
```
{% endstep %}

{% step %}
### Verify resolved scopes for a user

To validate IAM configuration, call the [Retrieving all scopes granted to a user](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/users#get-iam-tenant-users-userid-scopes) endpoint.

```bash
curl -i -X GET \
  'https://api.emporix.io/iam/{tenant}/users/{userId}/scopes' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../iam/api-reference/" %}
[api-reference](../iam/api-reference/)
{% endcontent-ref %}

### Custom scopes for custom entities

When you create a custom entity for a tenant, Emporix automatically generates a standard set of custom scopes for this entity. This ensures consistency across APIs and reduces the effort required to design and maintain permission models.

For each custom entity, the platform creates a predefined set of scopes following a consistent naming pattern:

<code>
<entity>.<entity>_read
<entity>.<entity>_manage
<entity>.<entity>_readOwn
<entity>.<entity>_manageOwn
</code>

These scopes are immediately available for use in IAM and can be included in your custom access controls. They are also exposed through OAuth2.


{% hint style="info" %}
For a related Schema Service configuration, see the [Schema Service tutorial](../../utilities/schema/schema.md)
For the end-to-end integration flow across IAM and Schema, see [Custom scopes for custom entities](../../quickstart/authentication-and-authorization/tokens-and-scopes.md#custom-scopes-for-custom-entities) in the Tokens and Scopes guide.
{% endhint %}
