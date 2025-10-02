---
icon: hourglass-half
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
# 2025-04-04: Sequential ID Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01.

## Deprecated endpoints

| Endpoint                                                                                        | Description                                                                                                                                                                               |
|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving all schemas](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#get-sequential-id-sequenceschemas)  | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#get-sequential-id-tenant-schemas) instead.                              |
| [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-sequenceschemas)         | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-tenant-schemas) instead.                                |
| [Creating a nextId](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-sequenceschemas-sequenceschema-nextids)         | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas/types/{schemaType}/nextId](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-tenant-schemas-types-schematype-nextid) instead. |

## Known problems

There are no known problems.