---
---

# 2025-02-19: Customer Segments Service - expanded response for retrieving category trees for a customer segments endpoint

## Overview

From now on, the response of the "Retrieving category trees for a customer segments" endpoint includes new fields: `localizedDescription`, `localizedSlug`, `ecn`, `validity`, `position`, and `published`, which allows fetching complete category tree information in a single request.

## Updated endpoints

| Endpoint                                                                                                                               | Description                                                                                                            |
|----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| [Retrieving category trees for a customer segments](/openapi/customer-segment/#operation/GET-customer-segment-retrieve-category-trees) | Added `localizedDescription`, `localizedSlug`, `ecn`, `validity`, `position`, and `published` fields to the responses. |

## Known problems

There are no known problems.