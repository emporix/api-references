---
seo:
  title: Client Management Service events
  description: Webhooks, client management events
icon: webhook
description: Webhook events related to the creation, update and deletion of legal entity and assigning user to legal entity.
layout:
  width: wide
---

# Events - Client Management

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>client-management.legalentity-created</td><td><pre class="language-json"><code class="lang-json">{
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
</code></pre></td></tr><tr><td>client-management.legalentity-updated</td><td><pre class="language-json"><code class="lang-json">{
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
</code></pre></td></tr><tr><td>client-management.legalentity-deleted</td><td><pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "legalEntityId": "String",
  "legalEntityParentId": "String"
}
</code></pre></td></tr><tr><td>client-management.user-assigned-to-legalentity</td><td><pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "userId": "String",
  "email": "String",
  "legalEntityId": "String",
  "type": "String",
  "primary": "Boolean",
  "assignmentId": "String"
}
</code></pre></td></tr></tbody></table>
