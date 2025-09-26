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

Category tree endpoints will exclude trees where the root category has `published=false` when only published categories are requested (`showUnpublished=false`).


## Modified endpoints

| Endpoint                                                                                                                                                                          | Description                                                                                              |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| [Retrieving the category trees](https://developer.emporix.io/api-references-1/readme/api-reference-5/category-tree-resources#get-category-tenant-category-trees)                  | When show `showUnpublished=false` in query params, trees with unpublished root node will not be returned |
| [Retrieving a specific category tree](https://developer.emporix.io/api-references-1/readme/api-reference-5/category-tree-resources#get-category-tenant-category-trees-categoryid) | When show `showUnpublished=false` in query params, trees with unpublished root node will not be returned |

## Known problems

There are no known problems.
