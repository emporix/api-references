---
seo:
  title: Invoice Service Tutorials
  description: Invoices Generation
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Invoice Service Tutorials



## How to configure your tenant for invoice creation

To prepare your tenant for invoice generation, you have to set up the Configuration, Sequential ID and Site Settings services.

### Set up invoice configuration in the Configuration service


Use the parameters for an order query in case of an automatic job type:

* `threshold` - the time after delivery date for which the order should be found, the time is defined in hours (96h)
* `status` - the order status for which the order should be found (CREATED)
* `extendedOrderStatus` - the extended order status for which the order should be found (70)

To set up the invoice configuration, call the <nobr><Button to="/openapi/configuration/#operation/POST-configuration-create-config" size="small">Creating new configurations</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="POST-configuration-create-config"
  defaultExample="Create invoice settings example"
  properties={[
  {
    "key" : "invoiceSettings",
    "value" : {
        "threshold" : "24",
        "status" : "CREATED,CONFIRMED",
        "extendedOrderStatus" : "70,75,76"
    },
    "version" : 1
  }
]}
/>

### Set up the Sequential ID service

This configuration is used to set up the format of invoice numbers. Set up the numbers by invoking the sequential id service with the <nobr><Button to="/openapi/sequential-id/#operation/POST-sequential-id-create-schema" size="small">Creating a new schema</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="sequential-id"
  operationId="POST-sequential-id-create-schema"
  properties={
  {
    "name": "invoiceNoSequence",
    "schemaType": "invoiceNoSequence",
    "preText": "INV__num__",
    "maxValue": 999999999,
    "numberOfDigits": 4,
    "startValue": 1000,
    "placeholders": {
      "__num__": {
        "required": true
      }
    }
  }
}
/>

### Set up the Site Settings service

The logo URL configuration allows to upload a custom logo that should be visible on the invoice header. 
Add your company logo to the invoice with the <nobr><Button to="/openapi/site-settings/#operation/POST-site-settings-create-site-mixin" size="small">Creating a site mixin</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="site-settings"
  operationId="POST-site-settings-create-site-mixin"
  defaultExample="Create general shop settings mixin"
  properties={{
  "generalShopSettings": {
    "logoUrl" : "https://sample_logo_url.png"
  }
}}
/>

## How to trigger the invoice creation process

To trigger the invoice creation process, initiate a job by making a call to the <nobr><Button to="/openapi/invoice/#operation/POST-invoice-create-job" size="small">Creating a job</Button></nobr> endpoint of the Invoice Service. Two types of jobs can be started:

* **Manual**: Requires providing a list of `orderIds` in the job creation request.

* **Automatic**: The list of `orderIds` is generated using a parameterized query. The query parameters, including order status, order extended status, and time after the delivery date (in hours), can be configured in the configuration service. The Invoice Service then sends a request to the Order Service to retrieve orders that match the specified query criteria.

The standard invoice service flow is:

  1. Validation - checks if there's an existing invoice for the specific order.
  
  2. Recalculation - checks what is ordered and at what cost.
  
  3. Payment capture - charges the credit card.
  
  4. Creation of a PDF file with invoice.
  
  5. Sending email to the customer with the invoice file.

