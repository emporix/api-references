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

# 2025-06-05: OAuth Service - added session_id field to /login and /refreshauthtoken response

## Overview

The [Login](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token#post-customer-tenant-login) and [Refresh Token](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token#get-customer-tenant-refreshauthtoken) endpoints of Oauth service returns now additional field:
* session_id - Customer email used to login (generate the token).

## Updated endpoints

| Endpoint                                                                                          | Description                               |
|---------------------------------------------------------------------------------------------------|-------------------------------------------|
| [Login](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token#post-customer-tenant-login)               | Added the `session_id` field in response. |
| [Refresh Token](https://developer.emporix.io/api-references/api-guides-and-references/authorization/oauth-service/api-reference/customer-token#get-customer-tenant-refreshauthtoken)               | Added the `session_id` field in response. |

## Known problems

There are no known problems.