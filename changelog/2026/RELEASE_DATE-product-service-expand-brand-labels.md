---
icon: circle-plus
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

# RELEASE_DATE: Product Service - expand brand and labels in product responses

## Overview

Product responses can now be enriched with **expanded brand and label data** using the `expand` query parameter.

## Modified behavior

When requesting product data, you can now use:

- `expand=brand` to include a `brand` object expanded from `brandId`
- `expand=labels` to include a `labels` array expanded from `labelIds`
- multiple values can be combined, for example: `expand=template,parentVariant,brand,labels`

## Schema updates

The product response schemas were extended with:

- `brand` (expanded object)
- `labels` (expanded array)

## Known problems

There are no known problems.

