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

# 2026-01-08: Configuration Service - New properties for configurations

## Overview

Extended `Configuration` and `Client Configuration` objects with following properties:

- `readOnly`
- `restricted`
- `description`
- `schemaUrl`

## Updated endpoints

| Endpoint                                                                                                                                                                                                                               | Description                                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| [Retrieving configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations)                                    | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Creating configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#post-configuration-tenant-configurations)                                     | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey)                       | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey)                         | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving client configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#get-configuration-tenant-clients-client-configurations)              | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Creating client configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#post-configuration-tenant-clients-client-configurations)               | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving a client configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#get-configuration-tenant-clients-client-configurations-propertykey) | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Updating a client configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#put-configuration-tenant-clients-client-configurations-propertykey)   | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |
| [Retrieving global configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/global-configurations)                                                                     | Properties `readOnly`, `restricted`, `description` and `schemaUrl` have been introduced. |

## Known problems

There are no known problems.

 
