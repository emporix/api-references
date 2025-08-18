---
seo:
  title: Vendor Service events
  description: Webhooks, Vendor events
---

# Events - Quote

## Overview

Webhook events related to the creation, update, and deletion of a vendor.

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>vendor.vendor-created</td><td><pre class="language-json"><code class="lang-json">{
  "quote": {}
}
</code></pre></td></tr><tr><td>vendor.vendor-updated</td><td><pre class="language-json"><code class="lang-json">{
  "previousStatus": "String",
  "quote": {}
}
</code></pre></td></tr><tr><td>vendor.vendor-deleted</td><td><pre class="language-json"><code class="lang-json">{
 "quoteId": "String"
}
</code></pre></td></tr></tbody></table>
