---
seo:
  title: Cart Service Events
  description: Webhooks, cart events
---

# Cart Service events

## Overview

Webhook events related to the creation, update, and deletion of a cart.

## Available events

| Event type        | Event schema                                                                                                                                                                                                                                                         |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| cart.created      | <pre class="language-json"><code class="lang-json">{
  "currency": "String",
  "customerId": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "siteCode": "String",
}
</code></pre> |
| cart.merged       | <pre class="language-json"><code class="lang-json">{
  "currency": "String",
  "customerId": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "siteCode": "String",
}
</code></pre> |
| cart.closed       | <pre class="language-json"><code class="lang-json">{
  "currency": "String",
  "customerId": "String",
  "id": "String",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number"
  },
  "siteCode": "String",
}
</code></pre> |
| cart.item-added   | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "cartId": "String",
  "itemId":  "String",
  "quantity": "Number",
  "priceId": "String"
}
</code></pre>                                                                                |
| cart.item-updated | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "cartId": "String",
  "itemId":  "String",
  "quantity": "Number",
  "priceId": "String"
}
</code></pre>                                                                                |
| cart.item-deleted | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "cartId": "String",
  "itemId":  "String"
}
</code></pre>                                                                                                                               |
