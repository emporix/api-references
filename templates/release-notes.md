---
description: Use these instructions when creating release notes for new product features.
icon: rocket-launch
---

# Release Notes

* For a new entry add a new `{% update %}…{% endupdate %}` block at the top of `release-notes/README.md`, just under the opening `{% updates format="full" %}`. Do not modify existing entries. Do not update `release-notes/SUMMARY.md`.
* Add the date placeholder `RELEASE_DATE` in the update block.

{% hint style="info" %}
The date placeholder `RELEASE_DATE` is transformed into an actual date of release upon the PR merge to `master`.
{% endhint %}

* Add relevant tag or tags for the type of introduced changes (aligned with the API changelog):
  * new feature: `new-feature`
  * improvement: `improvement`
  * major change: `major-change`
  * minor change: `minor-change`
  * deprecated: `deprecated`
* Add a product area tag:
  * Commerce Engine: `ce`
  * Value Stream Modeller: `vsm`
  * Agentic Commerce Intelligence: `aci`
  * B2B Commerce Frontend: `b2b-frontend`
  * Partner Library: `partner-library`
  * Other: `other`

Examples:

```
{% update date="RELEASE_DATE" tags="new-feature, vsm" %}
```

```
{% update date="RELEASE_DATE" tags="improvement, aci" %}
```

* Use title format inside the update block (date goes on the `{% update %}` tag, not in the title): `## {change/feature}` — omit product prefixes (CE, VSM, ACI, etc.); use the product area tag instead.

Example:

```
## B2C Quotes
```

* Use the following doc structure

```
#### Overview

...
#### New features

|Feature|Benefit|
|---|---|
|**Feature one**|One or more sentences for description of its benefits.|
|**Feature two**|One or more sentences for description of its benefits.|
| ... | ... |

#### Fixes and improvements

None as this is a new feature/improvement.

#### Known problems

None as this is a new feature/improvement.

#### Documentation and links

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
