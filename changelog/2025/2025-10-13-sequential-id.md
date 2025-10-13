---
icon: sparkles
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

# 2025-10-13: Sequential ID Service - removal of deprecated endpoints

## Overview

All previously deprecated endpoints are now removed ([2025-04-04: Sequential ID Service - deprecations](../2025/2025-04-04-sequential-id.md)).

## Removed endpoints & fields

| Endpoint                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
|-------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Retrieving all schemas  | Endpoint removed. Previous documentation under [Retrieving all schemas](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#get-sequential-id-sequenceschemas) is no longer available. Please use [this endpoint](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#get-sequential-id-tenant-schemas) instead.                                             |
| Creating a schema       | Endpoint removed. Previous documentation under [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-sequenceschemas) is no longer available. Please use [this endpoint](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-tenant-schemas) instead.                                                |
| Creating a nextId       | Endpoint removed. Previous documentation under [Creating a nextId](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-sequenceschemas-sequenceschema-nextids) is no longer available. Please use [this endpoint](https://developer.emporix.io/api-references/api-guides/utilities/sequential-id/api-reference/sequential-ids-management#post-sequential-id-tenant-schemas-types-schematype-nextid) instead. |


## Known problems

There are no known problems.
