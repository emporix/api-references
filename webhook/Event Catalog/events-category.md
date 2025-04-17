---
seo:
  title: Category Service events
  description: Webhooks, category events
---

# Category Service events

## Overview

Webhook events related to the creation, update, and deletion of a category tree and to the creation and deletion of a category assignment.

## Available events

| Event type         | Event schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| category.created   | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| category.updated   | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| category.deleted   | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "parentId": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| assignment.created | <pre class="language-json"><code class="lang-json">{
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
</code></pre>                                                                                                                                                                                                                                                                                |
| assignment.deleted | <pre class="language-json"><code class="lang-json">{
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
</code></pre>                                                                                                                                                                                                                                                                                                    |
