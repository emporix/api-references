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

# 2026-04-27: Client Management Service - customer group role in Legal Entities

## Overview

The `customerGroups` object in Legal Entity responses now includes an optional `role` property. This field represents the customer group role and is returned for GET endpoints.

## Updated endpoints

| Endpoint | Description |
|---|---|
| [Retrieving all legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities) | Property `customerGroups.role` is now returned in the response. |
| [Searching with parameters for legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-customer-management-tenant-legal-entities-search) | Property `customerGroups.role` is now returned in the response. |
| [Retrieving a legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid) | Property `customerGroups.role` is now returned in the response. |
| [Retrieving a legal entity with parent hierarchy](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid-parent-hierarchy) | Property `customerGroups.role` is now returned in the response. |

## Known problems

There are no known problems.
