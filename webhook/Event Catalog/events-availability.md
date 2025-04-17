---
seo:
  title: Availability Service Events
  description: Webhooks, availability events
---

# Availability Service events

## Overview

Webhook events related to the creation, update, and deletion of an availability.

## Available events

| Event type                       | Event schema                                                       |
| -------------------------------- | ------------------------------------------------------------------ |
| availability.created             | <pre class="language-json"><code class="lang-json">{
</code></pre> |
| "available": "Boolean",          |                                                                    |
| "distributionChannel": "String", |                                                                    |
| "id": "String",                  |                                                                    |
| "metadata": {                    |                                                                    |

```
"createdAt": "String",
"modifiedAt": "String",
"mixins": "Object"
```

},\
"mixins": "Object",\
"popularity": "Number",\
"productId": "String",\
"site": "String",\
"stockLevel": "Number"\
}\
|\
\| availability.updated |

```json
{
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
```

|\
\| availability.deleted |

```json
{
"id": "String"
}
```

|
