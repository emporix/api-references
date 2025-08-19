---
seo:
  title: Customer Segment Service events
  description: Webhooks, Customer segment events
---

# Events - Customer Segments

## Overview

Webhook events related to the creation, update, and deletion of customer segments.

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>customer-segment.customer-assignment-created</td><td><pre class="language-json"><code class="lang-json">{
  "assignmentType": "String",
  "customer": {
    "email": "String",
    "firstName": "String",
    "id": "String",
    "lastName": "String"
  },
  "legalEntity": {
    "id": "String",
    "name": "String"
  },
  "metadata": {},
  "mixins": "Map",
  "segmentId": "String",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer-segment.customer-assignment-deleted</td><td><pre class="language-json"><code class="lang-json">{
  "customerId": "String",
  "legalEntityId": "String",
  "segmentId": "String",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer-segment.customer-assignment-updated</td><td><pre class="language-json"><code class="lang-json">{
  "assignmentType": "String",
  "customer": {
    "email": "String",
    "firstName": "String",
    "id": "String",
    "lastName": "String"
  },
  "legalEntity": {
    "id": "String",
    "name": "String"
  },
  "metadata": {},
  "mixins": "Map",
  "segmentId": "String",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer-segment.item-assignment-created</td><td><pre class="language-json"><code class="lang-json">{
  "item": {
    "code": "String",
    "id": "String",
    "name": {
        "name" : "Map"
    },
  }
  "metadata": {},
  "mixins": "Map",
  "segmentId": "String",
  "tenant": "String",
  "type": "String"
}
</code></pre></td></tr><tr><td>customer-segment.item-assignment-deleted</td><td><pre class="language-json"><code class="lang-json">{
  "itemId": "String",
  "segmentId": "String",
  "tenant": "String",
  "type": "String"
}
</code></pre></td></tr><tr><td>customer-segment.item-assignment-updated</td><td><pre class="language-json"><code class="lang-json">{
  "item": {
    "code": "String",
    "id": "String",
    "name": {
        "name" : "Map"
    },
  }
  "metadata": {},
  "mixins": "Map",
  "segmentId": "String",
  "tenant": "String",
  "type": "String"
}
</code></pre></td></tr><tr><td>customer-segment.segment-created</td><td><pre class="language-json"><code class="lang-json">{
  "description": {},
  "id": "String",
  "metadata": {},
  "name": {
    "name" : "Map"
  },
  "siteCode": "String",
  "status": "String",
  "tenant": "String",
  "validity": {}
}
</code></pre></td></tr><tr><td>customer-segment.segment-deleted</td><td><pre class="language-json"><code class="lang-json">{
  "id": "String",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer-segment.segment-updated</td><td><pre class="language-json"><code class="lang-json">{
  "description": {},
  "id": "String",
  "metadata": {},
  "mixins": "Map",
  "name": {
    "name" : "Map"
  },
  "previousStatus": "String",
  "siteCode": "String",
  "status": "String",
  "tenant": "String",
  "validity": {}
}
</code></pre></td></tr></tbody></table>
