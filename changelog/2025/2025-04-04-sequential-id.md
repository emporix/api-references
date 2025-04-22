---
---
# 2025-04-04: Sequential-ID Service - deprecations

## Overview

All deprecations will be removed on 2025-10-01.

## Deprecated endpoints

| Endpoint                                                                                        | Description                                                                                                                                                                               |
|-------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving all schemas](/openapi/sequential-id/#operation/GET-sequential-id-retrieve-schemas)  | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas](/openapi/sequential-id/#operation/GET-sequential-id-retrieve-tenant-schemas) instead.                              |
| [Creating a schema](/openapi/sequential-id/#operation/POST-sequential-id-create-schema)         | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas](/openapi/sequential-id/#operation/POST-sequential-id-create-tenant-schema) instead.                                |
| [Creating a nextId](/openapi/sequential-id/#operation/POST-sequential-id-create-nextId)         | Endpoint will be removed. Please use [/sequential-id/{tenant}/schemas/types/{schemaType}/nextId](/openapi/sequential-id/#operation/POST-sequential-id-create-schema-type-nextId) instead. |

## Known problems

There are no known problems.