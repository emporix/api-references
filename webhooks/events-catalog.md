---
seo:
  title: Catalog Service events
  description: Webhooks, catalog events
icon: webhook
description: Webhook events related to the creation, update, and deletion of a catalog.
---

# Events - Catalog

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>catalog.created</td><td><pre class="language-json"><code class="lang-json">{
  "categoryIds": [
    "String"
  ],
  "description": "Map",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "name": "Map",
  "publishedSites": [
    "String"
  ],
  "status": "String",
  "visibility": {
    "from": "String",
    "to": "String",
    "visible": "Boolean"
  }  
}
</code></pre></td></tr><tr><td>catalog.updated</td><td><pre class="language-json"><code class="lang-json">{
  "categoryIds": [
    "String"
  ],
  "description": "Map",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "name": "Map",
  "publishedSites": [
    "String"
  ],
  "status": "String",
  "visibility": {
    "from": "String",
    "to": "String",
    "visible": "Boolean"
  }  
}
</code></pre></td></tr><tr><td>catalog.deleted</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre></td></tr></tbody></table>
 
