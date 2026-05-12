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

# RELEASE_DATE: Approval Service - deprecated fields

## Overview

All deprecations will be removed on 2026-11-30. Several fields in the approval response have been deprecated in favor of new, more descriptive fields. The new fields provide a more comprehensive and consistent way to access price calculations.

### Deprecated approval resource level fields:

- `totalPrice.amount` - use `totalPrice.netValue`, `totalPrice.grossValue` and `totalPrice.taxValue` instead
- `subTotalPrice.amount` - use `subTotalPrice.netValue`, `subTotalPrice.grossValue` and `subTotalPrice.taxValue` instead

### Deprecated approval resource-item level fields:

- `itemYrn` - use `itemId` instead
- `itemPrice.amount` - use `calculatedPrice` and `unitPrice` instead

## Updated endpoints

| Endpoint                                                                                                                                                 | Description                                                                            |
| -------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| [Retrieving a list of approvals](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals)    | Deprecated response fields in favor of new more comprehensive way to represent prices. |
| [Retrieving an approval](https://developer.emporix.io/api-references-1/readme/approval-api-reference/approvals#get-approval-tenant-approvals-approvalid) | Deprecated response fields in favor of new more comprehensive way to represent prices. |

## Known problems

There are no known problems.
