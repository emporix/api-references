---
description: Follow these guidelines for formatting and structuring the documentation.
icon: pen-to-square
---

# Format and Structure

## Titles

* Page titles use title case.

Example:

```
The Title Case
```

* Section titles use sentence case.

Example:

```
The section title within a page
```

* Do not use em dashes (`—`) in section titles (markdown headings). An em dash is converted to a double hyphen (`--`) in anchor IDs by the editor, while GitBook collapses it to a single hyphen. Cross-page links such as `[Section title](page.md#section-title)` then open the page but do not scroll to the subsection.
* Keep section titles simple so the heading text, link label, and anchor match. For example, use `### RFC-based Pricing Simulation` with `#rfc-based-pricing-simulation`, not `### Pricing Simulation — RFC-based Pricing Simulation`.
* Em dashes and en dashes are fine in body text and bullet lists; this rule applies to headings only.

## Frontmatter metadata

### Descriptions

* Descriptions must be included in all the user guides. Their purpose is to add context to the page – what is it about and why it's important.
* Descriptions should be one or two sentences, not more than 200 characters.
* Use full sentences, not just nominal sentences or noun phrases.
* Descriptions are added in the page metadata.

Example:

```
---
description: This is a description (...)
---
```

### Page icons

* Each user guide page/document has to have an icon corresponding to its content. The icon names must match icons available in GitBook (FontAwesome library).
* Icons are added in the frontmatter.

Example:

```
---
icon: globe
---
```

## Navigation menu

* To display a page in the navigation menu, add it to the relevant section's `SUMMARY.md` file. Each space has its own navigation defined, so add a new doc in the appropriate place with the right path to the file.
* To group topics in navigation menu, add a group in the `SUMMARY.md` file.

Example:

```
To add a group, use ## in SUMMARY.md:

## Group 1

* [Page 1](group-1/page-1.md)
```

## UI Elements

* Use bold for UI elements, like static fields, names of tabs, actions to choose, buttons, etc. Wrap an element with `**`.

Example:

`**UI element**`.

## Hints

* For highlighting important information, use hint elements:

{% hint style="warning" %}
Warning
{% endhint %}

{% hint style="info" %}
Info
{% endhint %}

{% hint style="danger" %}
Danger
{% endhint %}

{% hint style="success" %}
Success
{% endhint %}

* Hints don't work in tables. If a note is required, use emoji or background color for marking the text in tables:

Example:

```
<p><span data-gb-custom-inline data-tag="emoji" data-code="2139">ℹ️</span> <mark style="background-color:blue;">The Catalog Service automatically checks for any category-deleted events. Every time a root category is deleted, it is automatically removed from all catalogs it belonged to.</mark></p>
```

Other icons:

`<p><span data-gb-custom-inline data-tag="emoji" data-code="2705">✅</span></p>`

`<p><span data-gb-custom-inline data-tag="emoji" data-code="26a0">⚠️</span></p>`

*   API-docs specific – for marking a preview-state of a feature, use danger hint element with the dedicated label.

    * Hint:

    <div data-gb-custom-block data-tag="hint" data-style="danger" class="hint hint-danger"><p>This functionality is in preview mode - some of the features may not be fully operational yet.</p></div>

    * Label:

    https://res.cloudinary.com/saas-ag/image/upload/v1752824268/emporix/icons/preview\_api1.png

## Steps

* For the content that requires some subsequent steps, use the stepper block element.
* As a rule of thumb, add step titles (unless it is too much for the particular steps case).
* Use `####` (heading level 4) for step titles inside `{% step %}` blocks. Do not use `###` — GitBook adds level-3 headings to the page navigation sidebar.

Example:

```
{% stepper %}
{% step %}
#### First step title

///step content...
{% endstep %}

{% step %}
#### Second step title

/// step content
{% endstep %}
...
{% endstepper %}
```

{% hint style="warning" %}
Watch out for blank spaces at the end of {step} elements, sometimes they create rendering errors.
{% endhint %}

* Where necessary, add `Prerequisites` section before the steps to provide additional information that needs to be done beforehand.

## Bullet lists

* Use bullet lists to enumerate items of similar kind, or unordered actions.
* To add a description and details after the enumerated item, use **en dash** `–` (`alt` + `-`)
* Use full stops at the end when a description is a full sentence.
* Do not use full stops when there is no description after the enumerated item, or when the description is a noun phrase, nominal phrase, but not a full sentence with subject + verb + object.
* Be consistent with using sentences/phrases across the same bullet list

Example:

```
* one thing – description
* second thing – description
* third – description
```

## Hyphens/Dashes

### Hyphens

* `-`
* Use in compound words.
* Use with prefixes, suffixes.

### En dashes

* `alt` + `-`
* Use en dashes in bullet points when enumerating items and providing some further details / descriptions.
* Use between numbers and dates.
* Use to introduce a contrary point, break, change in the sentence structure (only where it makes sense for such strong emphasis).

### Em dashes

* `shift` + `alt` + `-` (or `—` when pasted)
* Do not use in section titles — see [Titles](#titles). In headings, em dashes break subsection anchor links in GitBook.
