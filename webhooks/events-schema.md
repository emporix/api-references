---
seo:
  title: Schema Service events
  description: Webhooks, schema events
---

# Events - Schema

## Overview

Webhook events related to the creation, update, and deletion of custom mixin schemas.

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>schema.custom-instance-created</td><td><pre class="language-json"><code class="lang-json">{
    "tenant": "String",
    "type": "String",
    "customInstance": {
        "id": "String",
        "metadata": {},
        "mixins": "Map",
        "name": {
            "name" : "Map"
        },
    }
}
</code></pre></td></tr><tr><td>schema.custom-instance-deleted</td><td><pre class="language-json"><code class="lang-json">{
    "tenant": "String",
    "type": "String",
    "id": "String"
}
</code></pre></td></tr><tr><td>schema.custom-instance-updated</td><td><pre class="language-json"><code class="lang-json">{
    "tenant": "String",
    "type": "String",
    "customInstance": {
        "id": "String",
        "metadata": {},
        "mixins": "Map",
        "name": {
            "name" : "Map"
        },
    }
}
</code></pre></td></tr>
</tbody></table>
