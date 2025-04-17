---
seo:
  title: Catalog Service Tutorials
  description: catalog, catalogs
---

import {
  Button,
  OpenApiTryIt,
  ExplainStep
} from '@redocly/developer-portal/ui';

# Catalog Service Tutorials

## How to create a catalog and assign a category to it

You can assign categories to a catalog when creating or updating the catalog. The following procedure covers the latter scenario.

### Create a catalog

:::info

Catalog names and descriptions are localized. When creating a new catalog, you can specify the catalog name and description in two different ways — in one language or in multiple languages.

Looking for more info on localization? Check out [*Standard practices*](/content/standard-practices).

:::

To create a new catalog, you need to send a request to the <nobr><Button to="/openapi/catalog/#operation/POST-catalog-create-catalog" size="small">Creating a new catalog</Button></nobr> endpoint.


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

:::info

For more information, check out [*How to create a category*](/content/category/#how-to-create-a-category).

:::

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


:::attention 

The Catalog Service automatically checks for any category-deleted events. Every time a root category is deleted, it is automatically removed from all catalogs it belonged to.

:::