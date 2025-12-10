---
icon: wand-sparkles
layout:
  width: default
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
  metadata:
    visible: true
---

# 2025-09-29: Category tree - filter unpublished categories

## Overview

Category tree endpoints exclude trees in which the root category has `published=false`, when only published categories are requested (`showUnpublished=false`).


## Modified endpoints

| Endpoint                                                                                                                                                                          | Description                                                                                              |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| [Retrieving the category trees](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#get-category-tenant-category-trees)                  |When `showUnpublished=false` is set in the query parameters, trees with an unpublished root node are not returned.|
| [Retrieving a specific category tree](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#get-category-tenant-category-trees-categoryid) | When `showUnpublished=false` is set in the query parameters, trees with an unpublished root node are not returned.|

## Known problems

There are no known problems.
 
