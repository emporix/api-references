---
icon: sparkles
---
layout:
   width: wide
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

# 2025-06-05: Customer Service (Customer Managed) - added session_id field to /login and /refreshauthtoken response

## Overview

The [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) and [Refreshing a customer token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-refreshauthtoken) endpoints of Customer Service now return the additional field:
* `session_id` - Customer email used to login (generate the token).

## Updated endpoints

| Endpoint                                                                                          | Description                               |
|---------------------------------------------------------------------------------------------------|-------------------------------------------|
| [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login)               | Added the `session_id` field in response. |
| [Refreshing a customer token](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#get-customer-tenant-refreshauthtoken)              | Added the `session_id` field in response. |

## Known problems

There are no known problems.