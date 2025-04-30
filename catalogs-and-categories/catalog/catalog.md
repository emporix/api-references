---
seo:
  title: Catalog Service Tutorials
  description: catalog, catalogs
---

# Catalog Service Tutorials

## How to localize your catalog

The name and the description attribute of a catalog support localization. This means that you can provide values in a specific locale and also retrieve those values either localized, or all together, as you choose.
Localization is controlled via two headers:

* Accept-Language - this is used to specify how to retrieve catalogs. If a value is provided, then the resources will be returned in that locale. If '*' is provided as a value, or the header is missing, all locales saved on a resource will be returned for that resource.
* Content-Language - this header is used to specify if the data that will be stored for this request has a particular locale or you are providing all the desired locales.
You can see detailed examples for the requests affected by this bellow.

## How to create a catalog and assign a category to it

You can assign categories to a catalog when creating or updating the catalog. The following procedure covers the latter scenario.

### Create a catalog

{% hint style="warning" %}

Catalog names and descriptions are localized. When creating a new catalog, you can specify the catalog name and description in two different ways — in one language or in multiple languages.

Looking for more info on localization? Check out [*Standard practices*](/content/standard-practices).

{% endhint %}

To create a new catalog, you need to send a request to the <nobr><Button to="/openapi/catalog/#operation/POST-catalog-create-catalog" size="small">Creating a new catalog</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

<OpenApiTryIt
  definitionId="catalog"
  operationId="POST-catalog-create-catalog"
  parameters={{
    header: {
        "Content-Language": "*"
    }
  }}
  properties={{
    "name": {
        "en": "Grocery catalog",
        "de": "Lebensmittelkatalog"
    },
    "description": {
        "en": "Catalog of grocery products.",
        "de": "Katalog von Lebensmittelprodukten."
    },
    "visibility": {
        "visible": false
    }
  }}
/>

### Create a category

{% hint style="warning" %}

For more information, check out [*How to create a category*](/content/category/#how-to-create-a-category).

{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

<OpenApiTryIt
  definitionId="category"
  operationId="POST-category-tree-create-category"
  defaultExample="Root category create 1"
  parameters={{
    header: {
        "Content-Language": "*",
        "X-Version": "v2"
    },
    query: {
        "publish": true
    }
  }}
  properties={{
    "localizedName": {
        "en": "Non-alcoholic drinks",
        "de": "Alkoholfreie Getränke"
    },
    "localizedDescription": {
        "en": "Non-alcoholic drinks",
        "de": "Alkoholfreie Getränke"
    },
    "localizedSlug": {
        "en": "NAD",
        "de": "AG"
    },
    "ecn": [
        "123A",
        "234B",
        "345C"
    ],
    "validity": {
        "from": "2022-05-05T12:44:51.871Z",
        "to": "2025-12-05T23:59:59.000Z"
    },
    "position": 1,
    "published": true,
    "mixins": {}
  }}
/>


### Assign the category to the catalog

To assign the newly created category to a catalog, you need to send a request to the <nobr><Button to="/openapi/catalog/#operation/PATCH-catalog-update-catalog-properties" size="small">Partially updating a catalog</Button></nobr> endpoint.

In the request body, insert the ID of the category into the `categoryIds` array. In this example, we also present how to set the visibility timeframe of the catalog with the `visibility` field.

{% include "../../.gitbook/includes/example-hint-text.md" %}

<OpenApiTryIt
  definitionId="catalog"
  operationId="PATCH-catalog-update-catalog-properties"
  parameters={{
    header: {
        "Content-Language": "*",
        "X-Version": "v2"
    },
    query: {
        "publish": true
    }
  }}
  properties={{
    "categoryIds": [
        "084bcaf6-66b8-4ddd-9489-65c5f6449e94"
    ],
    "visibility": {
    "visible": true,
    "from": "2022-05-05T12:44:51.871Z",
    "to": "2025-12-05T23:59:59.000Z"
    },
    "metadata": {
        "version": 1
    }
  }}
/>


{% hint style="warning" %} 

The Catalog Service automatically checks for any category-deleted events. Every time a root category is deleted, it is automatically removed from all catalogs it belonged to.

{% endhint %}