---
seo:
  title: Product Service events
  description: Webhooks, product events
icon: webhook
description: Webhook events related to the creation, update, and deletion of a product.
---

# Events - Product

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>product.created</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String",
  "code": "String",
  "name": "Map",
  "description": "Map",
  "productType": "String",
  "taxClasses": "Map",
  "published": "Boolean",
  "template": {
    "id": "String",
    "version": "Integer"
  },
  "media": [
    {
      "id": "String",
      "mediaId": "String",
      "url": "String",
      "commitLink": "String",
      "contentType": "String",
      "stored": "Boolean",
      "createdAt": "String",
      "customAttributes": "Map",
      "tags": [
        "String"
      ],
      "uncommittedMedia": "Boolean",
      "uploadLink": "String"
    }
  ],
  "bundledProducts": [
    {
      "productId": "String",
      "amount": "Integer"
    }
  ],
  "relatedItems": [
    {
      "refId": "String",
      "type": "String"
    }
  ],
  "mixins": "Map",
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
</code></pre></td></tr><tr><td>product.updated</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String",
  "code": "String",
  "name": "Map",
  "description": "Map",
  "productType": "String",
  "taxClasses": "Map",
  "published": "Boolean",
  "template": {
    "id": "String",
    "version": "Integer"
  },
  "media": [
    {
      "id": "String",
      "mediaId": "String",
      "url": "String",
      "commitLink": "String",
      "contentType": "String",
      "stored": "Boolean",
      "createdAt": "String",
      "customAttributes": "Map",
      "tags": [
        "String"
      ],
      "uncommittedMedia": "Boolean",
      "uploadLink": "String"
    }
  ],
  "bundledProducts": [
    {
      "productId": "String",
      "amount": "Integer"
    }
  ],
  "relatedItems": [
    {
      "refId": "String",
      "type": "String"
    }
  ],
  "mixins": "Map",
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
</code></pre></td></tr><tr><td>product.deleted</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre></td></tr></tbody></table>
