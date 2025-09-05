---
seo:
  title: Customer Service events
  description: Webhooks, customer events
icon: webhook
description: Webhook events related to the creation, update and deletion of customer, sending a request to reset a customer's password and resending an account activation link to a customer.
---

# Events - Customer

## Available events

<table><thead><tr><th>Event type</th><th>Event schema</th></tr></thead><tbody><tr><td>customer.created</td><td><pre class="language-json"><code class="lang-json">{
  "customerNumber": "String",
  "id": "String",
  "title": "String",
  "firstName": "String",
  "lastName": "String",
  "middleName": "String",
  "company": "String",
  "preferredSite": "String",
  "preferredCurrency": "String",
  "preferredLanguage": "String",
  "accounts": ["String"],
  "contactPhone": "String",
  "contactEmail": "String",
  "active": "Boolean",
  "onHold": "Boolean",
  "b2b": {
    "companyRegistrationId": "String"
  },
  "type": "String",
  "metadata": "Object",
  "mixins": "Map",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer.updated</td><td><pre class="language-json"><code class="lang-json">{
  "updatedBy": "String",
  "customerNumber": "String",
  "id": "String",
  "title": "String",
  "firstName": "String",
  "lastName": "String",
  "middleName": "String",
  "company": "String",
  "preferredSite": "String",
  "preferredCurrency": "String",
  "preferredLanguage": "String",
  "accounts": ["String"],
  "contactPhone": "String",
  "contactEmail": "String",
  "active": "Boolean",
  "onHold": "Boolean",
  "b2b": {
    "companyRegistrationId": "String"
  },
  "type": "String",
  "defaultAddress": "Object",
  "addresses": ["Object"],
  "metadata": "Object",
  "mixins": "Map",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer.deleted</td><td><pre class="language-json"><code class="lang-json">{
  "customerNumber": "String",
  "email": "String",
  "triggeredBy": "String",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer.password-reset</td><td><pre class="language-json"><code class="lang-json">{
  "email": "String",
  "token": "String",
  "site": "String"
}
</code></pre></td></tr><tr><td>customer.refresh-token</td><td><pre class="language-json"><code class="lang-json">{
  "email": "String",
  "tenant": "String"
}
</code></pre></td></tr><tr><td>customer.opt-in</td><td><pre class="language-json"><code class="lang-json">{
  "customerNumber": "String",
  "activateAccountUrl": "String",
  "token": "String"
}
</code></pre></td></tr><tr><td>customer.logged.in</td><td><pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "sessionId": "String",
  "customerId": "String"
}
</code></pre></td></tr><tr><td>customer.email-change</td><td><pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "customerId": "String",
  "token": "String",
  "email": "String",
  "newEmail": "String"
}
</code></pre></td></tr><tr><td>customer.email-change-request</td><td><pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "customerId": "String",
  "token": "String",
  "email": "String",
  "newEmail": "String"
}
</code></pre></td></tr></tbody></table>
