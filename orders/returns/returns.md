---
seo:
  title: Returns Service Tutorials
  description: returns
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

 # Returns Service Tutorials

 ## How to configure the Returns Service

 By default, the expiration date offset for a return request is set to 30 days.

 ### Update the expiration date settings

 You can update the expiration date offset for a tenant by sending a request to the <nobr><Button to="/openapi/configuration/#operation/PUT-configuration-update-config" size="small">Updating a configuration</Button></nobr> endpoint in the Configuration Service.

 In the following example, we are changing the expiration date offset to 14 days.

<OpenApiTryIt
  definitionId="configuration"
  operationId="PUT-configuration-update-config"
    parameters={{
    path:{
         "propertyKey": "return.defaultExpiryDate"
    }
  }}
    properties={{
      key: "return.defaultExpiryDate",
      value: "14"
  }}
  />

 
 ## How to manage return requests

 A return can be created both by a customer directly on your business' website, or by an employee on behalf of a customer.


{% hint style="warning" %}

If you want the return-service-specific events to trigger any actions of your choice, configure webhook subscriptions. See the [*Webhook Service Tutorials*](/content/webhook) for more information.
{% endhint %}

 First, ensure that the orders that you want to return (along with their `order_Id` values) exist in the system.


 ### Create a return by a customer

 On the storefront, a customer fills in the applicable fields in the return request:
 
 * `orders`
 * `reason`
 * `mixins`

Based on your tenant's configuration settings and customer's oauth token, the remaining fields are populated automatically.

When a customer sends a return request, the <nobr><Button to="/openapi/returns/#operation/POST-returns-create-return" size="small">Creating a single return entity</Button></nobr> endpoint is called.

{% hint style="warning" %}

The following set of scopes is granted to a customer group:

```
returns.returns_read_own returns.returns_manage_own
 
```
The `returns.returns_read` and `returns.returns_manage` scopes are only required for employee groups.
{% endhint %}

 
<OpenApiTryIt
  definitionId="returns"
  operationId="POST-returns-create-return"
  defaultExample="A return requested by a customer"
  />
 

 ### Create a return on behalf of a customer


 To create a return on behalf of a customer, you need to send a request to the <nobr><Button to="/openapi/returns/#operation/POST-returns-create-return" size="small">Creating a single return entity</Button></nobr> endpoint.

 
{% hint style="warning" %}

The following set of scopes is required for an employee group:

```
returns.returns_read returns.returns_manage
 
```

The `returns.returns_read_own` and `returns.returns_manage_own` scopes are only required for customer groups.
{% endhint %}

<OpenApiTryIt
  definitionId="returns"
  operationId="POST-returns-create-return"
  defaultExample="A return requested on behalf of a customer"
  />

{% hint style="warning" %}

The `approvalStatus` field is automatically populated during the creation of a return and is always set to `PENDING`.
{% endhint %}


### Update the return request by a customer

Customers can update their return request only when the approval status of the request is `PENDING`. When a customer updates a return, the <nobr><Button to="/openapi/returns/#operation/PUT-returns-update-return" size="small">Updating a single return</Button></nobr> endpoint is called.

{% hint style="warning" %}

The following set of scopes is granted to a customer group:

```
returns.returns_read_own returns.returns_manage_own
 
```
The `returns.returns_read` and `returns.returns_manage` scopes are only required for employee groups.
{% endhint %}

In this scenario, the customer updates the reason for the return. 

<OpenApiTryIt
  definitionId="returns"
  operationId="PUT-returns-update-return"
  defaultExample="A return being updated by a customer"
  properties={{
    reason: {
      code: "003",
      details: "The items are too small"
      }
  }}
  />



 ### Update the return status

 As an employee, you can update all the fields available during the return creation, as well as the `approvalStatus` and `received` fields, by sending a request to the <nobr><Button to="/openapi/returns/#operation/PUT-returns-update-return" size="small">Updating a single return</Button></nobr> endpoint.
 
{% hint style="warning" %}

The following set of scopes is required for an employee group:

```
returns.returns_read returns.returns_manage
 
```
The `returns.returns_read_own` and `returns.returns_manage_own` scopes are only required for customer groups.
{% endhint %}


In this scenario, the employee updates the approval status of the return request.

<OpenApiTryIt
  definitionId="returns"
  operationId="PUT-returns-update-return"
  defaultExample="A return being updated on behalf of a customer"
  properties={{
    reason: {
      code: "003",
      details: "The items are too small"
      },
    approvalStatus: "APPROVED"
  }}
  />



 