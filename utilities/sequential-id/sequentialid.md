---
seo:
  title: Sequential ID Service Tutorials
  description: Sequential Ids Schema Management
icon: graduation-cap
layout:
  width: wide
---

# Sequential-id Tutorial

The Sequential ID Service serves for generating subsequential unique IDs for such objects as orders, invoices, quotes, pick-packs, or similar.\
Define a pattern how such IDs should look like in a schema for specific objects, use placeholders for computing certain values dynamically, and the Sequential ID Service takes care of following the defined sequence.

To add your custom sequence ID schema, make sure you provide the correct `schemaType`. The `schemaType` field has to correspond to the schema used in the Emporix system for a particular entity:

| Entity    | schemaType                   |
| --------- | ---------------------------- |
| Order     | `orderNoSequence`            |
| Invoice   | `invoiceNoSequence`          |
| Quote     | `quoteNoSequence`            |
| Pick-Pack | `orderHoldingAreaNoSequence` |

### How to create a sequential ID schema

This tutorial demonstrates creating and using sequential IDs for order numbers.

### Create a sequence schema

To create a schema for sequential IDs creation, send the request to the [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-tenant-schemas) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/sequential-id/{tenant}/schemas' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "testSchema",
    "schemaType": "orderNoSequence",
    "preText": "C-__year__-__month__-",
    "postText": "-D",
    "maxValue": 999999999,
    "numberOfDigits": 9,
    "startValue": 3,
    "placeholders": {
      "__year__": {
        "required": true
      },
      "__month__": {
        "required": true
      }
    }
  }'
```

{% hint style="warning" %}
The values of the placeholder properties are resolved dynamically from the defined site settings:

* All the placeholder values connected to date and time are based on the `site.homeBase.timezone` property. If no timezone is defined, the default GMT (UTC-0) timezone is used.
* The `__country__` placeholder comes from the `site.homeBase.address.country` property. The default system value is `DE` for Germany.
{% endhint %}

### Retrieve the created schema

To get the created schema details, make a call to the [Retrieving a schema](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#get-sequential-id-tenant-schemas-schemaid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET 
  'https://api.emporix.io/sequential-id/{tenant}/schemas/{schemaId}' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

Copy the schema ID.

### Activate the schema

Activate the schema to apply it in the system so that the order numbers follow the new pattern. Send the request to the [Activating a schema](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-tenant-schemas-schemaid-setactive) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  'https://api.emporix.io/sequential-id/{tenant}/schemas/{schemaId}/setActive' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

Provide the `sequenceSchemaID` in the request.

### Generate a sequence ID based on the schema

Now, you can generate the order IDs that follow the new schema. To create a sequence ID, make a call to the [Creating a nextId for schema type](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-tenant-schemas-types-schematype-nextid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
'https://api.emporix.io/sequential-id/{tenant}/schemas/types/{schemaType}/nextId?siteCode=string' 
-H 'Authorization: Bearer ' 
-H 'Content-Type: application/json' 
-d '{
"sequenceKey": "2025-05",
"placeholders": {
"__year__": "2025",
"__month__": "05"
}
}'
```

In the query parameter, pass the `siteCode` of a site where you want to use the schema to ensure the placeholder values are replaced in a fly.

This endpoint creates and returns the `nextId` value. When you send an empty body in the request, the `nextId` is generated following the pattern defined in the schema and the placeholders are replaced with the values from the site settings.

In this case, the subsequent order ID looks like this:

```
ORDER-2025-03-27-14-03-22-DE0002-N
```

### Vendor-specific invoice numbering

You can define vendor-specific, separate number ranges with consecutive numbering for invoice IDs. Each vendor maintains their own sequential numbering sequence, ensuring that invoice IDs are unique and properly sequenced per vendor. The following example demonstrates how to create an invoice sequence schema that includes the vendor name in the ID pattern:

```bash
curl -i -X POST 
  https://api.emporix.io/sequential-id/sequenceSchemas 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "invoiceNoSequence",
    "schemaType": "invoiceNoSequence",
    "preText": "meinMAKLERstore-__vendorName__",
    "postText":"-__year__-__month__

    "maxValue": 999999999,
    "numberOfDigits": 6,
    "startValue": 10000,
    "placeholders": {
      "__vendorName__": {
        "required": true
      }
    }
  }'
```