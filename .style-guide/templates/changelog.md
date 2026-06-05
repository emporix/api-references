---
description: Use these instructions when creating a new changelog.
icon: hourglass-clock
---

# Changelog

* Changelogs are created and kept in the `api-references` repository.
* Add a separate page for each entry in the `changelog/{current-year}` path.
* Name a file with the date placeholder of releasing the changelog and the service name, for example: `RELEASE_DATE-product.md`.
* In the doc frontmatter metadata, add layout information to exclude outline:

```
---
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
```

* In metadata, add an icon relevant to the type of change introduced:
  * new feature: sparkles
  * improvement: wand-sparkles
  * major change: sliders-up
  * minor change: sliders
  * deprecation: hourglass-half

Example:

```
---
icon: hourglass-half
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
```

* Add a title according to the following convention: `RELEASE_DATE: Service Name - {main change description}`
  * keep the description short and simple
  * use noun phrases only (no verbs in titles)
  * for code-phrases, use backticks (\`\`), do not use quotation marks etc.
  * keep it quite general, details come in Overview

Examples:

```
# RELEASE_DATE: Product Service - deprecations
# RELEASE_DATE: Cart Service - support external discounts
```
{% hint style="info" %}
The date placeholder `RELEASE_DATE` is transformed into an actual date of release upon the PR merge.
{% endhint %}

* Add the relevant changelog content, use the template:

```
# Title

## Overview
General description of introduced changes, one or a few sentences.

## Added endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

## Updated endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

## Removed endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

## Deprecated endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

## Known problems

There are no known problems.
```

* `Overview` section:
  * Provide a short description with details of what has been changed and what effect it brings - one or a few sentences.
  * Use full sentences, try to use active voice, present or past simple tense.
  * For names of settings, code-phrases etc. use backticks (\`\`).
* `Added/Updated/Removed/Deprecated Endpoints` section:
  * Use the table format.
  * Provide links to the changed endpoints.
  * For displayed link names, use the verb in gerund form (updating, deleting etc) - this should be consistent with the endpoint title in API reference.
  * Base the link URLs on the endpoints paths (not operationIDs) - Gitbook takes the paths defined in `yml` files to create URLs, for example: `patch/schema/{tenant}/custom-entities/{type}/instances/{id}` → `https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#patch-schema-tenant-custom-entities-type-instances-id`
  * Provide a description for each changed endpoint:
    * Keep it brief and simple.
    * Use present simple tense if possible.
    * Try to use active voice, avoid passive if possible.
    * Use full sentences with a full stop at the end.
    * Focus on explaining the outcomes or the purpose of the change.
    * For code-phrases, use backticks (\`\`).
* `Known problems` section:
  * Indicate if there are any problems at the time of release.
* Add the page title to the SUMMARY.md to display the entry in Gitbook in the right order (newest at the top).

Example:

```
## 2025

* [2025-04-17: Product Service - deprecations](2025/2025-04-17-product.md)
* [2025-04-16: Cart Service - introduction of search endpoint](2025/2025-04-16-cart.md)
* [2025-04-14: Cart Service - support external discounts](2025/2025-04-14-cart.md)
* [2025-04-10: Cart Service - cart validation and configuration improvement](2025/2025-04-10-cart.md)
...
```

* If you want to highlight any content with a note, useelement. You can use warning, info, success and danger styles.

Example:

```
{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}
```
