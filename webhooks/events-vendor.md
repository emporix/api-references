---
seo:
  title: Vendor Service events
  description: Webhooks, Vendor events
icon: webhook
description: Webhook events related to the creation, update, and deletion of a vendor.
---

# Events - Vendor

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>vendor.vendor-created</td><td><pre class="language-json"><code class="lang-json">{
  "addresses": ["Object"],
  "documents": ["Object"],
  "legalInfo": {},
  "metadata": {},
  "mixins": "Map",
  "name": "String",
  "parentId": "String",
  "tenant": "String",
  "type": "String",
  "vendorId": "String"
}
</code></pre></td></tr><tr><td>vendor.vendor-updated</td><td><pre class="language-json"><code class="lang-json">{
  "addresses": ["Object"],
  "documents": ["Object"],
  "legalInfo": {},
  "metadata": {},
  "mixins": "Map",
  "name": "String",
  "parentId": "String",
  "tenant": "String",
  "type": "String",
  "vendorId": "String"
}
</code></pre></td></tr><tr><td>vendor.vendor-deleted</td><td><pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "vendorId": "String",
  "vendorParentId": "String"
}
</code></pre></td></tr></tbody></table>
 
