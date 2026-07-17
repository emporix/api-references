---
description: Use these instructions when creating a new changelog.
icon: hourglass-clock
---

# Changelog

* Changelogs are created and kept in the `api-references` repository in the `changelog/README.md` file.
* Add a new `{% update date="RELEASE_DATE" ... %}…{% endupdate %}` block at the top of `changelog/README.md`, just under the opening `{% updates format="full" %}`. Do not modify existing entries. Do not create separate changelog files or update `changelog/SUMMARY.md`.
* Use `date="RELEASE_DATE"` in the `{% update %}` tag (never a hard-coded date).

{% hint style="info" %}
The date placeholder `RELEASE_DATE` is transformed into an actual date of release upon the PR merge.
{% endhint %}

* Add relevant tag or tags relevant to the type of introduced changes:
  * new feature: new-feature
  * improvement: improvement
  * major change: major-change
  * minor change: minor-change
  * deprecated: deprecated

Examples:

```
{% update date="RELEASE_DATE" tags="improvement" %}

```

```
{% update date="RELEASE_DATE" tags="improvement, deprecated" %}
```

* Add the relevant changelog content, use the template:

```
## Title

#### Overview
General description of introduced changes, one or a few sentences.

#### New endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

#### Updated endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

#### Removed endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

#### Deprecated endpoints

| Endpoint                                                                                                          | Description                                          |
|-------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| [Retrieving list of coupons by criteria](/openapi/coupon/#operation/GET-coupon-list-specified-coupons)            | New property `referralCoupon` added to the response. |
| [Retrieving information about particular coupon by code](/openapi/coupon/#operation/GET-coupon-retrieve-coupon)   | New property `referralCoupon` added to the response. |

#### Known problems

There are no known problems.
```
* `Title` - h2 marker with the title of the changelog entry according to the following convention: `## Service Name - {main change description}`
  * keep the description short and simple
  * use noun phrases only (no verbs in titles)
  * for code-phrases, use backticks (\`\`), do not use quotation marks etc.
  * keep it quite general, details come in Overview

Examples:

```
## Product Service - deprecations
```
```
## Cart Service - support for external discounts
```

* `Overview` h4 section:
  * Provide a short description with details of what has been changed and what effect it brings - one or a few sentences.
  * Use full sentences, try to use active voice, present or past simple tense.
  * For names of settings, code-phrases etc. use backticks (\`\`).
* `Added/New/Removed/Deprecated Endpoints` h4 sections:
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
* `Known problems` h4 section:
  * Indicate if there are any problems at the time of release.

* If you want to highlight any content with a note, use the hint element. You can use warning, info, success and danger styles.

Example:

```
{% hint style="warning" %}

This functionality is now fully operational.
{% endhint %}
```