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

# 2025-11-26: Category Tree – filtering category trees by category IDs

## Overview

Category tree endpoints now support filtering by category IDs. When the category IDs are provided, only category trees that include at least one of the specified categories are returned.

## Modified endpoints

| Endpoint | Description |
| --- | --- |
| [Retrieving the category trees](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#get-category-tenant-category-trees) | Added `categoryIds` query parameter. |

## New endpoints

| Endpoint | Description |
| --- | --- |
| [Searching for category trees](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#post-category-tenant-category-trees-search) | New endpoint for searching category trees, which accepts `categoryIds` in the request body. |

## Known problems

There are no known problems.

 
