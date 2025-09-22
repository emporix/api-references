---
seo:
  title: Catalog Service Tutorials
  description: catalog, catalogs
icon: graduation-cap
layout:
  width: wide
---

# Catalog Tutorials

## How to localize your catalog

The name and the description attribute of a catalog support localization. This means that you can provide values in a specific locale and also retrieve those values either localized, or all together, as you choose.\
Localization is controlled via two headers:

* Accept-Language - this is used to specify how to retrieve catalogs. If a value is provided, then the resources will be returned in that locale. If '\*' is provided as a value, or the header is missing, all locales saved on a resource will be returned for that resource.
* Content-Language - this header is used to specify if the data that will be stored for this request has a particular locale or you are providing all the desired locales.\
  You can see detailed examples for the requests affected by this bellow.

## How to create a catalog and assign a category to it

You can assign categories to a catalog when creating or updating the catalog. The following procedure covers the latter scenario.

### Create a catalog

{% hint style="warning" %}
Catalog names and descriptions are localized. When creating a new catalog, you can specify the catalog name and description in two different ways — in one language or in multiple languages.

Looking for more info on localization? Check out [_Standard practices_](../../standard-practices/translations.md).
{% endhint %}

To create a new catalog, you need to send a request to the [Creating a new catalog](https://developer.emporix.io/api-references/api-guides/api-guides-and-references/catalogs-and-categories/catalog/api-reference/catalog-management#post-catalog-tenant-catalogs) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../category-tree/api-reference/" %}
[api-reference](../category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/catalog/{tenant}/catalogs' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
  "name": {
    "en": "Grocery catalog",
    "de": "Lebensmittelkatalog"
  },
  "description": {
    "en": "Catalog of grocery products.",
    "de": "Katalog von Lebensmittelprodukten."
  },
  "visibility": {
    "visible": false,
    "from": "2022-02-24T20:44:43.169Z",
    "to": "2023-07-24T20:44:43.169Z"
  },
  "publishedSites": [
    "Main"
  ],
  "categoryIds": [
    "3249485"
  ]
}
```

### Create a category

{% hint style="warning" %}
For more information, check out [_How to create a category_](../category-tree/#how-to-create-a-category).
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../products-labels-and-brands/product-service/api-reference/" %}
[api-reference](../../products-labels-and-brands/product-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/category/{tenant}/categories?publish=true' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: `*`, `en`, `en,de,fr`, `en-EN`, `fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7`' \
  -H 'Content-Type: application/json' \
  -H 'X-Version: v2' \
  -d '{
    "parentId": "056bcaf6-66b8-4ddd-9489-65c5f6449e74",
    "localizedName": {
      "en": "Floor Care",
      "de": "Bodenpflege"
    },
    "localizedDescription": {
      "en": "Floor Care",
      "de": "Bodenpflege"
    },
    "localizedSlug": {
      "en": "Floor-Care",
      "de": "Bodenpflege"
    },
    "ecn": [
      "AX6784",
      "123078",
      "SJUIOKM"
    ],
    "validity": {
      "from": "2022-01-05T12:44:51.871Z",
      "to": "2022-12-05T23:59:59.000Z"
    },
    "position": 5,
    "published": true,
    "mixins": {}
  }'
```

### Assign the category to the catalog

To assign the newly created category to a catalog, you need to send a request to the [Partially updating a catalog](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/catalog/api-reference/catalog-management#patch-catalog-tenant-catalogs-catalogid) endpoint.

In the request body, insert the ID of the category into the `categoryIds` array. In this example, we also present how to set the visibility timeframe of the catalog with the `visibility` field.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../products-labels-and-brands/product-service/api-reference/" %}
[api-reference](../../products-labels-and-brands/product-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/catalog/{tenant}/catalogs/{catalogId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": {
      "en": "This is the same catalog"
    },
    "description": {
      "en": "This catalog has been updated"
    },
    "visibility": {
      "visible": true,
      "from": "2022-02-24T20:44:43.169Z",
      "to": "2023-07-24T20:44:43.169Z"
    },
    "publishedSites": [
      "Main"
    ],
    "categoryIds": [
      "3249485"
    ],
    "metadata": {
      "version": 1
    }
  }'
```

{% hint style="warning" %}
The Catalog Service automatically checks for any category-deleted events. Every time a root category is deleted, it is automatically removed from all catalogs it belonged to.
{% endhint %}
