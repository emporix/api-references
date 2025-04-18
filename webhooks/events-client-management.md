---
seo:
  title: Client Management Service events
  description: Webhooks, client management events
---

# Events-Client Management

## Overview

Webhook events related to the creation, update and deletion of legal entity and assigning user to legal entity.

## Available events

| Event type                                     | Event schema                                                                                                                                                                                                                                                                                                                                                                                                                               |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| client-management.legalentity-created          | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| client-management.legalentity-updated          | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| client-management.legalentity-deleted          | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "legalEntityId": "String",
  "legalEntityParentId": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                  |
| client-management.user-assigned-to-legalentity | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "userId": "String",
  "email": "String",
  "legalEntityId": "String",
  "type": "String",
  "primary": "Boolean",
  "assignmentId": "String"
}
</code></pre>                                                                                                                                                                                                  |
