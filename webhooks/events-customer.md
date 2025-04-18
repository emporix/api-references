---
seo:
  title: Customer Service events
  description: Webhooks, customer events
---

# Events-Customer

## Overview

Webhook events related to the creation, update and deletion of customer, sending a request to reset a customer's password and resending an account activation link to a customer.

## Available events

| Event type                    | Event schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| customer.created              | <pre class="language-json"><code class="lang-json">{
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
</code></pre>                                                                                   |
| customer.updated              | <pre class="language-json"><code class="lang-json">{
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
</code></pre> |
| customer.deleted              | <pre class="language-json"><code class="lang-json">{
  "customerNumber": "String",
  "email": "String",
  "triggeredBy": "String",
  "tenant": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| customer.password-reset       | <pre class="language-json"><code class="lang-json">{
  "email": "String",
  "token": "String",
  "site": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| customer.refresh-token        | <pre class="language-json"><code class="lang-json">{
  "email": "String",
  "tenant": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| customer.opt-in               | <pre class="language-json"><code class="lang-json">{
  "customerNumber": "String",
  "activateAccountUrl": "String",
  "token": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| customer.logged.in            | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "sessionId": "String",
  "customerId": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| customer.email-change         | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "customerId": "String",
  "token": "String",
  "email": "String",
  "newEmail": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| customer.email-change-request | <pre class="language-json"><code class="lang-json">{
  "tenant": "String",
  "customerId": "String",
  "token": "String",
  "email": "String",
  "newEmail": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
