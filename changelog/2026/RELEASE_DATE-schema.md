---
icon: wand-sparkles
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: false
  pagination:
    visible: true
---

# RELEASE_DATE: Schema Service — explicit `owner` on custom instance creation

## Overview

The Schema Service now accepts an optional `owner` field in the request body when creating a custom instance, so clients can assign ownership explicitly instead of relying on the platform to derive it from the calling principal.

The `owner` field can be set explicitly only by clients authorized with a `manage` scope (`schema.custominstance_manage` or `custom.{lowerCaseType}_manage`). When the request is authorized with a `manage_own` scope, the field is ignored and ownership is set automatically to the user who created the custom instance. When a `manage` scope is granted but the field is omitted, ownership is likewise set automatically to the user who created the custom instance.

The following limitations apply when providing `owner`:

- `type` can only be set to `CUSTOMER` or `EMPLOYEE`. The `SERVICE` type cannot be assigned explicitly.
- `legalEntityId` can be provided only when `type` is `CUSTOMER`.
- The `owner` field is immutable. It can only be set during creation.

## Updated endpoints

| Endpoint                                                                                                                                                                                | Description                                                                                                                                |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| [Creating a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances)   | The request body now accepts an optional `owner`.    |
| [Upserting a custom instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#put-schema-tenant-custom-entities-type-instances-id) | The request body now accepts an optional `owner` field. |

## Known problems

There are no known problems.
