---
seo:
  title: IAM Service Tutorials
  description: identity access management, access control groups, users
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# IAM Service Tutorials

{% endhint %}info

Names and descriptions of groups, permissions, resources, access control templates, and role resources are localized.

Looking for more info on localization? Check out [*Standard practices*](/content/standard-practices).

{% endhint %}

## How to create a group of employees with a specific set of access controls

To specify user access level in a particular service resource, you need to create a group of users that share the same access controls.
For the purposes of this tutorial, you will create an employee group with manager rights in Catalog API service.

### Before you start

Ensure you have a tenant and users created.

{% endhint %}info

To create users, check out the **Manage Users** tab in the [Emporix Developer Portal](https://app.emporix.io/users). 

{% endhint %}

### Retrieve a list of available access controls

{% hint style="warning" %}

Access controls are predefined and designed to cover all necessary scenarios. It is not possible to create your own access controls.

{% endhint %}

To assign specific access control level to a group, first you need to retrieve a list of predefined access controls available for your tenant by sending a request to the <nobr><Button to="/openapi/iam/#operation/GET-iam-list-tenant-access-controls" size="small">Retrieving all access controls</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="iam"
  operationId="GET-iam-list-tenant-access-controls"
  parameters={{
    header: {
        "Accept-Language": "*"
    }
  }}
/>


### Create an employee group

Employee groups aggregate users that share the same access control within a particular service and resource. Create an employee group and assign access controls to it by sending a request to the <nobr><Button to="/openapi/iam/#operation/POST-iam-create-user-group" size="small">Creating a new group</Button></nobr> endpoint.

{% endhint %}info

The user type in the `userType` parameter can be specified as `CUSTOMER` or `EMPLOYEE`. For the purposes of this tutorial, set the `userType` parameter as `EMPLOYEE`.

{% endhint %}

<OpenApiTryIt
  definitionId="iam"
  operationId="POST-iam-create-user-group"
  parameters={{
    header: {
        "Content-Language": "*"
    }
  }}
  properties={{
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
  "mixins": {},
  "userType": "EMPLOYEE"
  }}
/>

### Assign users to an employee group

By assigning a user to a particular employee group, you grant them a specific access control level. Create assignments by calling the <nobr><Button to="/openapi/iam/#operation/POST-iam-add-user-to-group" size="small">Adding a user to a group</Button></nobr>

{% endhint %}info

The user type in the `userType` parameter can be specified as `customer` or `employee`. For the purposes of this tutorial, set the `userType` parameter as `employee`.

{% endhint %}

<OpenApiTryIt
  definitionId="iam"
  operationId="POST-iam-add-user-to-group"
  properties={{
    "userId": " ",
    "userType": "EMPLOYEE"
  }}
/>
