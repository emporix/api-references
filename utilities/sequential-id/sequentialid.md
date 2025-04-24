---
seo:
  title: Sequential ID Service Tutorials
  description: Sequential Ids Schema Management
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Sequential ID Service Tutorials

The Sequential ID Service serves for generating subsequential unique IDs for such objects as orders, invoices, quotes, pick-packs, or similar. 
Define a pattern how such IDs should look like in a schema for specific objects, use placeholders for computing certain values dynamically, and the Sequential ID Service takes care of following the defined sequence.

To add your custom sequence ID schema, make sure you provide the correct `schemaType`. The `schemaType` field has to correspond to the schema used in the Emporix system for a particular entity:

|Entity| schemaType|
|---|---|
|Order|`orderNoSequence`|
|Invoice|`invoiceNoSequence`|
|Quote|`quoteNoSequence`|
|Pick-Pack|`orderHoldingAreaNoSequence`|


## How to create a sequential ID schema

This tutorial demonstrates creating and using sequential IDs for order numbers.

### Create a sequence schema

To create a schema for sequential IDs creation, send the request to the <nobr><Button to="/openapi/sequential-id/#operation/POST-sequential-id-create-tenant-schema" size="small">Creating a schema</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="sequential-id"
  operationId="POST-sequential-id-create-tenant-schema"
  properties={{
    "name": "OrderNumberSchema",
    "schemaType": "orderNoSequence",
    "preText": "ORDER-__year__-__month__-__day__-__hour__-__minute__-__second__-__country__",
    "postText": "-N",
    "maxValue": 999999999,
    "numberOfDigits": 4,
    "startValue": 1,
    "placeholders": {
        "__year__": {
            "required": true
        },
        "__month__": {
            "required": true
        },
        "__day__": {
            "required": true
        },
        "__hour__": {
            "required": true
        },
        "__minute__": {
            "required": true
        },
        "__second__": {
            "required": true
        },
        "__country__": {
            "required": true
        }
    }
  }}
  />

{% hint style="warning" %}

The values of the placeholder properties are resolved dynamically from the defined site settings: 
* All the placeholder values connected to date and time are based on the `site.homeBase.timezone` property. If no timezone is defined, the default GMT (UTC-0) timezone is used. 
* The `__country__` placeholder comes from the `site.homeBase.address.country` property. The default system value is `DE` for Germany.

{% endhint %}

### Retrieve the created schema

To get the created schema details, make a call to the <nobr><Button to="/openapi/sequential-id/#operation/GET-sequential-id-retrieve-schema" size="small">Retrieving a schema</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="sequential-id"
  operationId="GET-sequential-id-retrieve-schema"
/>

Copy the schema ID.

### Activate the schema

Activate the schema to apply it in the system so that the order numbers follow the new pattern. Send the request to the <nobr><Button to="/openapi/sequential-id/#operation/POST-sequential-id-activate-schema" size="small">Activating a schema</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="sequential-id"
  operationId="POST-sequential-id-activate-schema"
/>

Provide the `sequenceSchemaID` in the request.

### Generate a sequence ID based on the schema

Now, you can generate the order IDs that follow the new schema. To create a sequence ID, make a call to the <nobr><Button to="/openapi/sequential-id/#operation/POST-sequential-id-create-schema-type-nextId" size="small">Creating a nextId for schema type</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="sequential-id"
  operationId="POST-sequential-id-create-schema-type-nextId"
  properties={{
    "sequenceKey": "2025-03",
    "placeholders": {
      "__year__": "2025",
      "__month__": "03"
  }
  }}
/>

In the query parameter, pass the `siteCode` of a site where you want to use the schema to ensure the placeholder values are replaced in a fly.

#
This endpoint creates and returns the `nextId` value. When you send an empty body in the request, the `nextId` is generated following the pattern defined in the schema and the placeholders are replaced with the values from the site settings. 

#
In this case, the subsequent order ID looks like this: 

```
ORDER-2025-03-27-14-03-22-DE0002-N
```



