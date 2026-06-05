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

# RELEASE_DATE: Catalog Service - visible category ids for a published site

## Overview

A new endpoint has been added to the Catalog Service. It returns a deduplicated list of root category identifiers from catalogs that are currently visible and published on the specified site.

A catalog is considered visible when `visibility.visible` is `true` and the current date and time falls within the configured visibility period, if defined.

## New endpoints

| Endpoint | Description |
| --- | --- |
| [Retrieving visible category ids for a published site](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/catalog-management#get-catalog-tenant-catalogs-categories) | Returns root category identifiers from visible catalogs published on the site specified by the required `publishedSite` query parameter. |

## Known problems

There are no known problems.
