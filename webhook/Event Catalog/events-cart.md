---
seo:
  title: Cart Service Events
  description: Webhooks, cart events
---

# Cart Service events

## Overview

Webhook events related to the creation, update, and deletion of a cart.

## Available events

| Event type              | Event schema                                                       |
| ----------------------- | ------------------------------------------------------------------ |
| cart.created            | <pre class="language-json"><code class="lang-json">{
</code></pre> |
| "currency": "String",   |                                                                    |
| "customerId": "String", |                                                                    |
| "id": "String",         |                                                                    |
| "metadata": {           |                                                                    |

```
"createdAt": "String",
"modifiedAt": "String",
"version": "Number"
```

},\
"siteCode": "String",\
}\
|\
\| cart.merged |

```json
{
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
```

|\
\| cart.closed |

```json
{
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
```

|\
\| cart.item-added |

```json
{
"tenant": "String",
"cartId": "String",
"itemId":  "String",
"quantity": "Number",
"priceId": "String"
}
```

|\
\| cart.item-updated |

```json
{
"tenant": "String",
"cartId": "String",
"itemId":  "String",
"quantity": "Number",
"priceId": "String"
}
```

|\
\| cart.item-deleted |

```json
{
"tenant": "String",
"cartId": "String",
"itemId":  "String"
}
```

|
