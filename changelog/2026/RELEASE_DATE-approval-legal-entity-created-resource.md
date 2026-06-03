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

# RELEASE_DATE: Approval Service - legal entity and created resource on approval responses

## Overview

Approval GET responses were extended with `legalEntity` and `createdResource`. The `legalEntity` object identifies the company the approval belongs to and is set when the approval is created. The `createdResource` object links the approval to the resource created when the flow completes (for checkout, typically an order); it is omitted until that resource exists.

## Updated endpoints

| Endpoint                                                                                                                                                       | Description                                                                                    |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| [Retrieving a list of approvals](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#get-approval-tenant-approvals)          | Response includes `legalEntity` and optional `createdResource`.                                |
| [Retrieving an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#get-approval-tenant-approvals-approvalid)       | Response includes `legalEntity` and optional `createdResource`.                                |

## Schema updates

The `getApprovalResponse` schema was extended with:

- `legalEntity` — object with `id` (legal entity identifier)
- `createdResource` — object with `id` (identifier of the created resource; for checkout, typically an order ID); omitted until the approved action produces a linked resource

## Known problems

There are no known problems.
