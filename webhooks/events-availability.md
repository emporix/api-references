---
seo:
  title: Availability Service events
  description: Webhooks, availability events
icon: webhook
description: Webhook events related to the creation, update, and deletion of an availability.
layout:
  width: wide

---

# Events - Availability

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>availability.created</td><td><pre class="language-json"><code class="lang-json">{
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
</code></pre></td></tr><tr><td>availability.updated</td><td><pre class="language-json"><code class="lang-json">{
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
</code></pre></td></tr><tr><td>availability.deleted</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre></td></tr></tbody></table>
