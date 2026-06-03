---
icon: sliders-up
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

# RELEASE_DATE: Approval Service - legal entity scoping and approval response fields

## Overview

The Approval Service now scopes approvals to the B2B legal entity from the customer token. Previously, customers could see approvals created for other companies because the `Legal-Entity-Id` has not been stored on the `Approval` model.

New and updated approvals store `legalEntity` on the document and are filtered by `legalEntity.id`. GET responses also expose `createdResource` when a downstream resource (for checkout, typically an order) exists after the approval flow completes.

## Behavior change (not backward compatible)

When the `Legal-Entity-Id` request header is sent (injected for B2B customer tokens — see [B2B token and legal entity](https://developer.emporix.io/api-references/api-guides/quickstart/authentication-and-authorization/tokens-and-scopes#b2b-token)), the service:

- **Creates** approvals for that legal entity only (requestor and approver contact assignments are resolved for the given entity).
- **Returns** only approvals whose stored `legalEntity.id` matches the `legal-entity-id` from token.

**Existing approvals created before this release do not have `legalEntity` stored.** They are **not** returned when `Legal-Entity-Id` is present in token, because they cannot match the legal-entity filter. This is intentional and **not backward compatible**: tenants will not see historical approvals through the scoped B2B API.

## Updated endpoints

| Endpoint                                                                                                                                                       | Description                                                                                                                                 |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| [Creating an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#post-approval-tenant-approvals)                   | Respects `Legal-Entity-Id`; persists `legalEntity` on the approval.                                                                          |
| [Retrieving a list of approvals](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#get-approval-tenant-approvals)          | Filtered by `Legal-Entity-Id` when present; response includes `legalEntity` and optional `createdResource`.                                   |
| [Retrieving an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#get-approval-tenant-approvals-approvalid)       | Filtered by `Legal-Entity-Id` when present; response includes `legalEntity` and optional `createdResource`.                                   |
| [Updating an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#patch-approval-tenant-approvals-approvalid)         | Filtered by `Legal-Entity-Id` when present.                                                                                                 |
| [Deleting an approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approvals#delete-approval-tenant-approvals-approvalid)      | Filtered by `Legal-Entity-Id` when present.                                                                                                 |
| [Checking the resource approval](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/approval#post-approval-tenant-approval-permitted) | Respects `Legal-Entity-Id` when checking existing approvals.                                                                                  |
| [Searching for approver users](https://developer.emporix.io/api-references/api-guides/companies-and-customers/approval-service/approval-api-reference/search#post-approval-tenant-search-users)           | Respects `Legal-Entity-Id` for contact assignment and approver resolution.                                                                  |

## Schema updates

The `getApprovalResponse` schema was extended with:

- `legalEntity` — object with `id` (legal entity identifier); set when the approval is created
- `createdResource` — object with `id` (identifier of the created resource; for checkout, typically an order ID); omitted until the approved action produces a linked resource

## Known problems

There are no known problems.
