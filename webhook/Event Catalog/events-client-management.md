---
seo:
  title: Client Management Service events
  description: Webhooks, client management events

---

# Client Management Service events

## Overview

Webhook events related to the creation, update and deletion of legal entity and assigning user to legal entity.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
<tr>
    <td>client-management.legalentity-created</td>
<td>

```json
{
  "legalEntityId": "String",
  "name": "String",
  "type": "String",
  "parentId": "String",
  "legalInfo": "Object",
  "accountLimit": "Object",
  "CustomerGroupId": "String",
  "customerGroups": ["Object"],
  "addresses": ["Object"],
  "documents": ["String"],
  "approvalGroup": ["Object"],
  "mixins": "Map",
  "metadata": "Object",
  "tenant": "String"
}
```
</td>
  </tr>
<tr>
    <td>client-management.legalentity-updated</td>
<td>

```json
{
  "legalEntityId": "String",
  "name": "String",
  "type": "String",
  "parentId": "String",
  "legalInfo": "Object",
  "accountLimit": "Object",
  "CustomerGroupId": "String",
  "customerGroups": ["Object"],
  "addresses": ["Object"],
  "documents": ["String"],
  "approvalGroup": ["Object"],
  "mixins": "Map",
  "metadata": "Object",
  "tenant": "String"
}
```
</td>
  </tr>
  <tr>
      <td>client-management.legalentity-deleted</td>
  <td>

```json
{
  "tenant": "String",
  "legalEntityId": "String",
  "legalEntityParentId": "String"
}
```
</td>
  </tr>
<tr>
    <td>client-management.user-assigned-to-legalentity</td>
<td>

```json
{
  "tenant": "String",
  "userId": "String",
  "email": "String",
  "legalEntityId": "String",
  "type": "String",
  "primary": "Boolean",
  "assignmentId": "String"
}
```
  </td>
    </tr>
</table>
