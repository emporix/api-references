---
seo:
  title: Category Service events
  description: Webhooks, category tree events
icon: webhook
description: Webhook events related to the creation, update, and deletion of a category tree and to the creation and deletion of a category assignment.
---

# Events - Category Tree

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>category.created</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String",
  "parentId": "String",
  "name": {
    "name" : "Map"
  },
  "description": {
    "description": "Map"
  },
  "slug": {
    "code": "Map"
  },
  "ecn": {
    "externalCategoryNumbers": [
      "String"
    ]
  },
  "validity": {
    "from": "String",
    "to": "String"
  },
  "position": {
    "position": "Number"
  },
  "publish": {
    "published": "Boolean"
  },
  "mixins": "Map",
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
</code></pre></td></tr><tr><td>category.updated</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String",
  "parentId": "String",
  "name": {
    "name" : "Map"
  },
  "description": {
    "description": "Map"
  },
  "slug": {
    "code": "Map"
  },
  "ecn": {
    "externalCategoryNumbers": [
      "String"
    ]
  },
  "validity": {
    "from": "String",
    "to": "String"
  },
  "position": {
    "position": "Number"
  },
  "publish": {
    "published": "Boolean"
  },
  "mixins": "Map",
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
</code></pre></td></tr><tr><td>category.deleted</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String",
  "parentId": "String"
}
</code></pre></td></tr><tr><td>assignment.created</td><td><pre class="language-json"><code class="lang-json">{
  "categoryId": "String",
  "assignment": {
    "id": "String",
    "categoryId": "String",
    "createdAt": "String",
    "ref": {
      "id": "String",
      "type": "String"
    }
  },
  "metadata": {
    "createdAt": "String"
  }
}
</code></pre></td></tr><tr><td>assignment.deleted</td><td><pre class="language-json"><code class="lang-json">{
  "categoryId": "String",
  "assignments": [
    {
      "id": "String",
      "categoryId": "String",
      "createdAt": "String",
      "ref": {
        "id": "String",
        "type": "String"
      }
    }
  ]
}
</code></pre></td></tr></tbody></table>
 
