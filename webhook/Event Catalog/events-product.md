---
seo:
  title: Product Service events
  description: Webhooks, product events
---

# Product Service events

## Overview

Webhook events related to the creation, update, and deletion of a product.

## Available events

| Event type      | Event schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| product.created | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| product.updated | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| product.deleted | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
