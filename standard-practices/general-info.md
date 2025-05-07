---
seo:
  title: General Info
  description: Standard practices
---

# General Info

## Standard practices in the Emporix API

Here you can find descriptions of practices, concepts, and data formats that are commonly used across the Emporix API services.

### Data standardization

To ensure consistency between the Emporix API services, some data types use standardized formats:

| Data type           | Description                                                                                                                                                                  |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Countries**       | Countries are indicated through two-letter codes compliant with the [ISO 3166-1 alpha-2 standard](https://www.iso.org/obp/ui/#iso:pub:PUB500001:en).                         |
| **Currencies**      | Currencies are indicated through three-letter codes compliant with the [ISO 4217 standard](https://www.iso.org/iso-4217-currency-codes.html).                                |
| **Dates and times** | All dates and times are stored as instantaneous moments in the UTC timezone, compliant with the [ISO 8601 standard](https://www.iso.org/iso-8601-date-and-time-format.html). |
| **Languages**       | Languages (including regional variants) are indicated through codes compliant with the [IETF BCP-47 standard](https://en.wikipedia.org/wiki/IETF_language_tag).              |

Check the below for specific practices:

* [Mixins](https://github.com/emporix/api-references/blob/master/content/mixins/README.md)
* [Translations](https://github.com/emporix/api-references/blob/master/content/translations/README.md)
* [Query Parameter](https://github.com/emporix/api-references/blob/master/content/q-param/README.md)
* [Upsert](https://github.com/emporix/api-references/blob/master/content/upsert/README.md)
* [Custom ID](https://github.com/emporix/api-references/blob/master/content/custom-id/README.md)
