---
icon: sparkles
layout:
<<<<<<< HEAD
  width: wide
=======
>>>>>>> parent of 31b07a6 (changelog width)
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

# 2025-06-02: Customer Service (Customer Managed) - add fields to /validateauthtoken response

## Overview

The [Validate a token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-validateauthtoken) endpoint of Oauth service returns now two additional fields:
* email - Customer email used to login (generate the token).
* legalEntityId - Legal Entity Id.

## Updated endpoints

| Endpoint                                                                                          | Description                               |
|---------------------------------------------------------------------------------------------------|-------------------------------------------|
| [Validate a token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-validateauthtoken)               | Added the `email` and `legalEntityId` fields in response. |

## Known problems

There are no known problems.