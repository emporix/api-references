---
seo:
  title: Site Service events
  description: Webhooks, site service events
icon: webhook
descriptions: Webhook events the creation, update, and deletion of a site.
---

# Events - Site

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>site.site-created</td><td><pre class="language-json"><code class="lang-json">{
  "code": "String",
  "tenant": "String"
  }
</code></pre></td></tr><tr><td>site.site-deleted</td><td><pre class="language-json"><code class="lang-json">{
  "code": "String",
  "tenant": "String"
  }
</code></pre></td></tr><tr><td>site.site-updated</td><td><pre class="language-json"><code class="lang-json">{
  "code": "String",
  "tenant": "String"
  }
</code></pre></td></tr></tbody></table>
