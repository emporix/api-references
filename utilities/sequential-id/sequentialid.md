---
seo:
  title: Sequential ID Service Tutorials
  description: Sequential Ids Schema Management
icon: graduation-cap
layout:
  width: wide
---

# Sequential-id Tutorial

The Sequential ID Service serves for generating subsequential unique IDs for such objects as orders, invoices, quotes, pick-packs, or similar.
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
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
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

The schema can use these built-in placeholders, which Sequential ID resolves from [Retrieving a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode) when you pass `siteCode`:

| Placeholder | Source |
| --- | --- |
| `__year__`, `__month__`, `__day__`, `__hour__`, `__minute__`, `__second__` | `homeBase.timezone`. If no timezone is defined, `UTC` is used. |
| `__country__` | `homeBase.address.country`. If no country is defined, `DE` is used. |

### Resolve custom placeholders from a site

You can declare custom placeholders that Sequential ID fills from site data when you pass `siteCode` during ID generation.

Each placeholder object can include these properties in addition to `required` and `default`:

| Property | Type | Description |
| --- | --- | --- |
| `sitePath` | string | Dotted path used to resolve the placeholder. Paths that start with `mixins.` come from [Retrieving site mixins](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins), for example `mixins.customConfig.region`. Other paths come from [Retrieving a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode) and must match the Site schema, for example `homeBase.address.country`. Use numeric segments to index arrays, for example `shipping.0.id`. |
| `arrayLimit` | integer | Maximum number of array elements to include when `sitePath` resolves to an array. Minimum value is `1`. Default: `10`. Ignored for scalar values. |
| `delimiter` | string | Separator used when joining array values. Default: `-`. Ignored for scalar values. |

Placeholder names must start and end with `__`, for example `__region__`.

Example schema with a custom placeholder resolved from a site mixin:

```bash
curl -i -X POST 
  'https://api.emporix.io/sequential-id/{tenant}/schemas' 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "testSchema",
    "schemaType": "orderNoSequence",
    "preText": "EC-__region__-__year__-__month__-__abo__-",
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
      },
      "__abo__": {
        "default": "REG",
        "required": false
      },
      "__region__": {
        "required": true,
        "sitePath": "mixins.customConfig.region"
      }
    }
  }'
```

Example placeholder resolved from an array field:

```json
{
  "__regions__": {
    "required": false,
    "sitePath": "shipToCountries",
    "arrayLimit": 3,
    "delimiter": "_"
  }
}
```

When you create a schema, Sequential ID validates every `sitePath`:

* Standard site paths must match the known Site schema from [Retrieving a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode), for example `homeBase.address.country`, `currency`, `shipToCountries`, or `shipping.0.id`.
* Paths that start with `mixins.` are format-validated only, because mixin content is tenant-defined. These paths are resolved from [Retrieving site mixins](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins).
* The service rejects malformed paths, bracket notation such as `shipping[0].id`, unknown non-mixin properties, the bare `mixins` root, any `metadata` path, and `arrayLimit` values that are not positive.

{% hint style="warning" %}
Placeholder values can be resolved dynamically from site data when you pass `siteCode`:

* Built-in date and time placeholders (`__year__`, `__month__`, `__day__`, `__hour__`, `__minute__`, `__second__`) use `homeBase.timezone` from [Retrieving a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode). If no timezone is defined, `UTC` is used.
* The built-in `__country__` placeholder uses `homeBase.address.country` from the same response. If no country is defined, `DE` is used.
* Custom placeholders that declare `sitePath` are resolved from [Retrieving a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode), or from [Retrieving site mixins](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins) when the path starts with `mixins.`.
* `sitePath` must resolve to a scalar value or to an array of scalars. Object paths are not supported.
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
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
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
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
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

In the query parameter, pass the `siteCode` of a site where you want to use the schema so that site-based placeholders can be resolved during ID generation.

Providing `siteCode` is required when the schema uses a required `sitePath` placeholder that is not supplied in the request body.

This endpoint creates and returns the `nextId` value. When you send an empty body in the request, the `nextId` is generated following the pattern defined in the schema and the placeholders are replaced with values from the site settings.

If a placeholder defines `sitePath`, Sequential ID resolves it from [Retrieving a site](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/site-settings#get-site-tenant-sites-sitecode), or from [Retrieving site mixins](https://developer.emporix.io/api-references/api-guides/configuration/site-settings-service/api-reference/mixins#get-site-tenant-sites-sitecode-mixins) when the path starts with `mixins.`. Values supplied in the request body take precedence over `sitePath` resolution.

For example, for a schema with `"preText": "EC-__region__-"` and `"sitePath": "mixins.customConfig.region"`, a site mixin value of `"EU"` produces an ID such as:

```
EC-EU-1001
```

If `sitePath` resolves to an array of scalar values, Sequential ID joins the values using the configured `delimiter` and `arrayLimit`. By default, up to `10` elements are included and joined with `-`. Placeholders that resolve to a value longer than 100 characters are truncated.

If a required placeholder cannot be resolved from `sitePath`, for example because the path is missing or points to an object, the request fails with `400 Bad Request`.

### Vendor-specific invoice numbering

You can define vendor-specific, separate number ranges with consecutive numbering for invoice IDs. Each vendor maintains their own sequential numbering sequence, ensuring that invoice IDs are unique and properly sequenced per vendor. The following example demonstrates how to create an invoice sequence schema that includes the vendor name in the ID pattern:

```bash
curl -i -X POST 
  https://api.emporix.io/sequential-id/sequenceSchemas 
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' 
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
