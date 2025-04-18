---
seo:
  title: Customer Service events
  description: Webhooks, customer events
---

# Customer Service events

## Overview

Webhook events related to the creation, update and deletion of customer, sending a request to reset a customer's password and resending an account activation link to a customer.

## Available events

<table>
  <tr>
    <td><b>Event type</b></td>
    <td><b>Event schema</b></td>
  </tr>
<tr>
    <td>customer.created</td>
<td>

```json
{
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
```
</td>
  </tr>
<tr>
    <td>customer.updated</td>
<td>

```json
{
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
```
</td>
  </tr>
  <tr>
      <td>customer.deleted</td>
  <td>

```json
{
  "customerNumber": "String",
  "email": "String",
  "triggeredBy": "String",
  "tenant": "String"
}
```
</td>
  </tr>
  <tr>
    <td>customer.password-reset</td>
<td>

```json
{
  "email": "String",
  "token": "String",
  "site": "String"
}
```
  </td>
    </tr>
<tr>
    <td>customer.refresh-token</td>
<td>

```json
{
  "email": "String",
  "tenant": "String"
}
```
  </td>
    </tr>
<tr>
    <td>customer.opt-in</td>
<td>

```json
{
  "customerNumber": "String",
  "activateAccountUrl": "String",
  "token": "String"
}
```
  </td>
    </tr>
<tr>
    <td>customer.logged.in</td>
<td>

```json
{
  "tenant": "String",
  "sessionId": "String",
  "customerId": "String"
}
```
  </td>
   </tr>
<tr>
  <td>customer.email-change</td>
<td>

```json
{
  "tenant": "String",
  "customerId": "String",
  "token": "String",
  "email": "String",
  "newEmail": "String"
}
```
  </td>
   </tr>
 <tr>
   <td>customer.email-change-request</td>
 <td>

 ```json
 {
   "tenant": "String",
   "customerId": "String",
   "token": "String",
   "email": "String",
   "newEmail": "String"
 }
 ```
   </td>
    </tr>
</table>
