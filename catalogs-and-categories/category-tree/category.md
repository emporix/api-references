---
seo:
  title: Category Service Tutorials
  description: category, categories
---

# Category Tutorials

import {\
Button,\
OpenApiTryIt,\
ExplainStep\
} from '@redocly/developer-portal/ui';

## Category Service Tutorials

### How to create a category

:::info

Category names and descriptions are localized. When creating a new category, you can specify the category name and descriptions in multiple languages.

Looking for more info on localization? Check out [_Standard practices_](../../content/standard-practices/).

:::

**Root categories vs. subcategories**

If you want to create a root category, choose one from the following:

* Omit the `parentId` element.
* Set the `parentId` element to `"null"`.
* Set the `parentId` element to `"root"`.

If you want to create a subcategory, include the `parentId` of the root category in the request body.

To create a new category, you need to send a request to the Creating a new category endpoint.

:::warning

The `localizedSlug` field must not contain any diacritics.

:::

\<OpenApiTryIt\
definitionId="category"\
operationId="POST-category-tree-create-category"\
defaultExample="Root category create 1"\
parameters=\{{\
header:{\
"Content-Language": "\*"\
}\
\}}\
properties=\{{\
"parentId": "null",\
"localizedName": {\
"en": "Non-alcoholic drinks",\
"de": "Alkoholfreie Getränke"\
},\
"localizedDescription": {\
"en": "Non-alcoholic drinks",\
"de": "Alkoholfreie Getränke"\
},\
"localizedSlug": {\
"en": "NAD",\
"de": "AG"\
},\
"ecn": \[\
"123A",\
"234B",\
"345C"\
],\
"validity": {\
"from": "2022-01-05T12:44:51.871Z",\
"to": "2025-12-05T23:59:59.000Z"\
},\
"position": 2,\
"published": true,\
"mixins": {}\
\}}\
/>

### How to assign a product to a category

You can assign resources, such as products, to particular categories.

#### Before you start

Make sure you have already finished the following tutorials:

* [_How to create a category_](category.md#how-to-create-a-category)
* [_How to add your first product_](../../content/product/#how-to-add-your-first-product)

#### Assign a product to a category

To assign a product to a category, you need to send a request to the Assigning a resource to a category endpoint and do the following:

* Set the `ref.type` field to `"PRODUCT"`.
* Provide the product ID in the `ref.id` field.

\<OpenApiTryIt\
definitionId="category"\
operationId="POST-category-tree-assign-resource"\
properties=\{{\
"ref": {\
"id": "5ad5e52e-6e27-4ac5-9471-2467d3fb7517",\
"type": "PRODUCT" }\
\}}\
/>

#### Retrieve the category assignments

To check whether the resource was properly assigned to the category, you can send a request to the Retrieving resources assigned to a category endpoint.

\<OpenApiTryIt\
definitionId="category"\
operationId="GET-category-tree-retrieve-category-assignments"\
parameters=\{{\
header: {\
"Accept-Language": "\*"\
},\
query: {\
"assignmentType": "PRODUCT"\
}\
\}}\
/>

### How to delete resource assignments

You can delete all resources assigned to a particular category, or just one specific assignment.

:::attention

As a result of this procedure, only category assignments are deleted; the categories and resources themselves remain in the database.

:::

#### Option one: Delete all product assignments

To delete all assignments for a specific category, you need to send a request to the Deleting all category assignments endpoint and set the `assignmentType` query parameter to `PRODUCT`.

\<OpenApiTryIt\
definitionId="category"\
operationId="DELETE-category-tree-remove-all-assignments"\
parameters=\{{\
query: {\
"assignmentType": "PRODUCT"\
}\
\}}\
/>

#### Option two: Delete a specific product assignment

To delete only a specific assignment, you need to send a request to the Deleting a category assignment by reference ID and enter the ID of the resource in the `referenceId` path parameter.

### How to publish/unpublish a category

To publish or unpublish a category, you need to send a request to the  Partially updating a category endpoint and set the `published` property to `true` or `false`.

\<OpenApiTryIt\
definitionId="category"\
operationId="PATCH-category-tree-update-category"\
defaultExample="Category partial update"\
parameters=\{{\
query: {\
"publish": true\
}\
\}}\
properties=\{{\
"published":true,\
"metadata": {\
"version": 1\
}\
\}}\
/>

### How to build and manage category trees

Category trees are built every time you create or update a category. The `parentId` is the identifier of the root category. Depending on your needs, you can manage the order of categories in a category tree by modifying the `parentId` and `position` elements of a particular category.

#### Retrieving category trees

**Option one: Retrieve a specific category tree**

:::warning

It is only possible to retrieve a category tree for a root category. It is not possible to get it for a category that lies lower in a hierarchy.\
:::

To retrieve a specific category tree, you need to send a request to the Retrieving the category tree endpoint and provide the category ID in the `categoryId` path parameter.

\<OpenApiTryIt\
definitionId="category"\
operationId="GET-category-tree-retrieve-category-tree-by-id"\
parameters=\{{\
query: {\
"showUnpublished": false\
}\
\}}\
/>

**Option two: Retrieve all category trees belonging to the tenant**

To retrieve all category trees, you need to send a request to the Retrieving the category trees endpoint.

\<OpenApiTryIt\
definitionId="category"\
operationId="GET-category-tree-retrieve-category-tree"\
parameters=\{{\
query: {\
"showUnpublished": true\
}\
\}}\
/>

**Option three: Retrieve a list of subcategories of a category**

To retrieve a list of subcategories for a specific category, you need to send a request to the Retrieving subcategories for a category endpoint.

:::attention

You can limit the depth of retrieved subcategories with the `depth` parameter.

* If set to `1`, only direct children of the specified category are retrieved.
* If not specified, all descendants of the specified category are retrieved.

:::

\<OpenApiTryIt\
definitionId="category"\
operationId="GET-category-tree-list-subcategories"\
parameters=\{{\
header: {\
"Accept-Language": "\*"\
},\
query: {\
"showUnpublished": false,\
"depth" : "1",\
"pageNumber": "1",\
"pageSize": "60",\
"sort": "localizedName.en:DESC"\
}\
\}}\
/>

**Moving a category**

You can move a category by modifying its `parentId` value.

:::attention

When you move a category, all its subcategories and assigned references move along with it.

:::

To move a category to be a child of another category, you need to send a request to the Partially updating a category endpoint and provide the desired parent category ID in the `parentId` field.

\<OpenApiTryIt\
definitionId="category"\
operationId="PATCH-category-tree-update-category"\
defaultExample="Category change parent"\
parameters=\{{\
query: {\
"publish": true\
}\
\}}\
properties=\{{\
"parentId": " ",\
"metadata": {\
"version": 2\
}\
\}}\
/>
