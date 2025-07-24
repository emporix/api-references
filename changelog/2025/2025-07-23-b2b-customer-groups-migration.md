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

# 2025-07-23: B2B Customer Groups - Migration

## Overview

We have completed an update to the customer group and assignment structure in the IAM service for all tenants. 
This change brings greater clarity and flexibility to how users are organized and managed within each legal entity.

## What’s new
- For every legal entity, three new customer groups have been created: **Admin**, **Buyer**, and **Requester**.
- All users have been reassigned to the appropriate new groups based on their roles and legal entity relationships.
- Users without a specific legal entity have been assigned to a default customer group to ensure continued access.

These changes will make it easier to manage user permissions and roles within your organization.

## Summary of changes

| Area                | Description                                                                          |
|---------------------|--------------------------------------------------------------------------------------|
| Customer Groups     | New Admin, Buyer, and Requester groups created for every legal entity.               |
| User Assignments    | Users reassigned to the correct new groups according to their roles.                 |
| Fallback Assignment | Users without a legal entity assigned to the default customer  group for continuity. |


## Known problems

There are no known problems.