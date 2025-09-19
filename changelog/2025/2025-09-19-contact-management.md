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

# 2025-09-19: Client Management Service – Added a new contact assignment type

## Overview

In the client management API, we added a new contact assignment type: *Contact*.

New validation rules:
* Customer can be assigned to a legal entity only once, regardless of the assignment type
* New assignment type has been added *Contact* and now is the default in the assignment API


## Modified endpoints

| Endpoint | Description                                                                                      |
|----------|--------------------------------------------------------------------------------------------------|
| [Creating contact assignment](https://developer.emporix.io/api-references-1/readme/api-reference-13/contact-assignments#post-tenant-contact-assignments) | New contact type and validation added so customer can be assigned only once to the legal entity. |
| [Upserting a contact assignment](https://developer.emporix.io/api-references-1/readme/api-reference-13/contact-assignments#put-tenant-contact-assignments-contactassignmentid) | New contact type and validation added so customer can be assigned only once to the legal entity. |


## Known problems

There are no known problems.

