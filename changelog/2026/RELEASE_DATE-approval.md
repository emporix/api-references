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

# RELEASE_DATE: Approval Service - quote approval process

## Overview

The Approval Service supports quote checkout approvals alongside cart approvals. For `resourceType: QUOTE`, the client sends the quote ID in `resourceId` and does not send `details`. The service loads quote line and price data from the quote integration. For `resourceType: CART`, `details` remains required as before.

## Updated endpoints

| Endpoint                                                                                                                                                       | Description                                                           |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| [Creating an approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#post-approval-tenant-approvals)                   | Supports `resourceType: QUOTE` with quote `resourceId`.               |
| [Retrieving a list of approvals](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals)          | Response resource payloads align with updated item and price schemas. |
| [Retrieving an approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals-approvalid)       | Response resource payloads align with updated item and price schemas. |
| [Checking the resource approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approval#post-approval-tenant-approval-permitted) | Request may use `resourceType: QUOTE` and a quote `resourceId`.       |
| [Searching for approver users](https://developer.emporix.io/api-references-1/readme/approval-api-reference/search#post-approval-tenant-search-users)           | Request may use `resourceType: QUOTE` and a quote `resourceId`.       |

## Schema updates

The Approval Service API reference schemas were extended with:

- `resourceType` value `QUOTE`
- `resourceItem`: `itemId`; `itemPrice` as line-level price (`unitPrice`, `newUnitPrice`, `calculatedPrice`)
- `price` (totals): `netValue`, `grossValue`, `taxValue`

## Known problems

There are no known problems.
