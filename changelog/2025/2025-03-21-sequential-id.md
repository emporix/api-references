---
---
# 2025-03-21: Sequential ID Service - `siteCode` query param

## Overview

Query param `siteCode` has been added to endpoints responsible for generating next ids. The `siteCode` is used to resolve certain placeholders.
Placeholders such as `__year__`, `__month__`, `__day__`, `__hour__`, `__minute__`, `__second__` and `__country__`, which are defined in the schema, can have some default values computed when their counterparts are missing in the request body.
The default values are derived from the site. Specifically:
- All date-related placeholders are computed based on the `site.homeBase.timezone` field.
- The country placeholder is replaced with the value of the `site.homeBase.address.country` field.


If these values are missing in a site configuration, the following defaults are used:
- `UTC` for timezone
- `DE` for country

## Updated endpoints

| Endpoint                                                                                                               | Description                   |
|------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| [Creating a nextId](/openapi/sequential-id/#operation/POST-sequential-id-create-nextId)                                | Query param `siteCode` added. |
| [Creating a nextId for schema type](/openapi/sequential-id/#operation/POST-sequential-id-create-schema-type-nextId)    | Query param `siteCode` added. |
| [Creating a nextId for schema types](/openapi/sequential-id/#operation/POST-sequential-id-create-schema-types-nextIds) | Query param `siteCode` added. |

## Known problems

There are no known problems.