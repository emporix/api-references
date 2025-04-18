---
seo:
  title: Availability Service events
  description: Webhooks, availability events
---

# Events-Availability

## Overview

Webhook events related to the creation, update, and deletion of an availability.

## Available events

| Event type           | Event schema                                                                                                                                                                                                                                                                                                                                                                   |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| availability.created | <pre class="language-json"><code class="lang-json">{
  "available": "Boolean",
  "distributionChannel": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "mixins": "Object"
  },
  "mixins": "Object",
  "popularity": "Number",
  "productId": "String",
  "site": "String",
  "stockLevel": "Number"
}
</code></pre>   |
| availability.updated | <pre class="language-json"><code class="lang-json">{
  "available": "Boolean",
  "distributionChannel": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "mixins": "Object",
    "modifiedAt": "String"
  },
  "mixins": "Object",
  "popularity": "Number",
  "productId": "String",
  "site": "String",
  "stockLevel": "Number"  
}
</code></pre> |
| availability.deleted | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                          |
