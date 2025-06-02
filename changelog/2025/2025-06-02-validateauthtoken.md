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

# 2025-06-02: OAuth Service - add fields to /validateauthtoken response

## Overview

The [Validate a token](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token#get-customer-tenant-validateauthtoken) endpoint of Oauth service returns now two additional fields:
* email - Customer email used to login (generate the token).
* legalEntityId - Legal Entity Id.

## Updated endpoints

| Endpoint                                                                                          | Description                               |
|---------------------------------------------------------------------------------------------------|-------------------------------------------|
| [Validate a token](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token#get-customer-tenant-validateauthtoken)               | Added the `email` and `legalEntityId` fields in response. |

## Known problems

There are no known problems.