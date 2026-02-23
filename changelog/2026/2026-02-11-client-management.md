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

# 2026-02-11: Client Management Service - restrictions property for Legal Entities

## Overview

The `LegalEntity` object was extended with a new `restrictions` property. This property is an access control identifier that determines who
can
view or manage the LegalEntity.

The `restrictions` field:

- Restricts Legal Entities visibility based on scope permissions
- Users can only query and view Legal Entities and Contact Assignments whose `restrictions` value matches one of their authorized
  restrictions

## Updated endpoints

| Endpoint                                                                                                                                                                                                                                                      | Description                                              |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| [Retrieving all legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities)                                                  | Property `restrictions` has been introduced.             |
| [Creating legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-customer-management-tenant-legal-entities)                                                         | Property `restrictions` has been introduced.             |
| [Searching with parameters for legal entities](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#post-customer-management-tenant-legal-entities-search)                           | Property `restrictions` has been introduced.             |
| [Retrieving a legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid)                                        | Property `restrictions` has been introduced.             |
| [Upserting a legal entity](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#put-customer-management-tenant-legal-entities-legalentityid)                                         | Property `restrictions` has been introduced.             |
| [Retrieving a legal entity with parent hierarchy](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/legal-entities#get-customer-management-tenant-legal-entities-legalentityid-parent-hierarchy) | Property `restrictions` has been introduced.             |
| [Retrieving all contact assignments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/contact-assignments#get-customer-management-tenant-contact-assignments)                                   | Property `legalEntity.restrictions` has been introduced. |
| [Retrieving a contact assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/client-management/api-reference/contact-assignments#get-customer-management-tenant-contact-assignments-contactassignmentid)                  | Property `legalEntity.restrictions` has been introduced. |

## Known problems

There are no known problems.

