---
description: Use these instructions when creating release notes for new product features.
icon: rocket-launch
---

# Release Notes

* For a new entry add a new file in the `release-notes` directory. File name pattern is `YYYY-MM-DD-{product}-{feature-or-change-title}.md`
* Use icons in frontmatter to mark the type of change:
  * new feature: sparkles
  * improvement: wand-sparkles
  * major change: sliders-up
  * minor change: sliders

Example:

```
---
icon: sparkles
---
```

* Use title format: `{date}: {product} - {change/feature}`

Example:

```
# 2025-04-04: CE - B2C Quotes
```

* Define the title in `SUMMARY.md` under the current year folder with the relevant path to the file.

```
Example: 

# Table of contents

* [Release Notes](README.md)
* [2025](2025/README.md)
  * [2025-04-10: CE - Cart Validation and Configuration Improvement](2025/2025-04-10-cart.md)
  * [2025-04-04: CE - B2C Quotes](2025/2025-04-04-ce-b2c-quotes.md)
  * [2025-04-03: CE - Custom Entity Framework](2025/2025-04-03-ce-custom-entity.md)
  * [2025-04-01: CE - Shared Orders](2025/2025-04-01-ce-shared-orders.md)
```

* Use the following doc structure

```
## Overview

...
## New features

|Feature|Benefit|
|---|---|
|**Feature one**|One or more sentences for description of its benefits.|
|**Feature two**|One or more sentences for description of its benefits.|
| ... | ... |

## Fixes and improvements

None as this is a new feature/improvement.

## Known problems

None as this is a new feature/improvement.

## Documentation and links

User Guides:
*
* 
*

API Guides:
*
*
```

* The table in `New features` section
  * Feature: bold, sentence case
  * Benefit: one or more sentences for description of its benefits.
* `Fixes and improvements` section – if there are any fixes to the existing features, state briefly what they are. If not applicable, state "None as this is a new feature."
* `Known problems` - if there are any known issues, state what they are. If there is nothing known, state "None as this is a new feature/improvement." (feature or improvement depending on the type of announcement).
* `Documentation and links` section – list all the relevant links to docs that have been created/updated in relation to the announcement.
