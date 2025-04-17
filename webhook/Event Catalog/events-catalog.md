---
seo:
  title: Catalog Service events
  description: Webhooks, catalog events
---

# Catalog Service events

## Overview

Webhook events related to the creation, update, and deletion of a catalog.

## Available events

| Event type      | Event schema                                                                                                                                                                                                                                                                                                                                                                                                                      |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| catalog.created | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| catalog.updated | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| catalog.deleted | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                             |
