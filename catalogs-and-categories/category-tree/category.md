---
seo:
  title: Category Service Tutorials
  description: category, categories
icon: graduation-cap
layout:
  width: wide
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
---

# Category Tutorials

## How to create a category

{% hint style="warning" %}
Category names and descriptions are localized. When creating a new category, you can specify the category name and descriptions in multiple languages.

Looking for more info on localization? Check out [_Standard practices_](../../standard-practices/translations.md).
{% endhint %}

**Root categories vs. subcategories**

If you want to create a root category, choose one from the following:

* Omit the `parentId` element.
* Set the `parentId` element to `"null"`.
* Set the `parentId` element to `"root"`.

If you want to create a subcategory, include the `parentId` of the root category in the request body.

{% hint style="info" %}
When the `X-Version` header is required, use `v2` — otherwise, the header is not necessary.
{% endhint %}

To create a new category, you need to send a request to the [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories) endpoint.

{% hint style="danger" %}
The `localizedSlug` field must not contain any diacritics.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/category/{tenant}/categories' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
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

## How to assign a product to a category

You can assign resources, such as products, to particular categories.

### Before you start

Make sure you have already finished the following tutorials:

* [_How to create a category_](category.md#how-to-create-a-category)
* [_How to add your first product_](../../products-labels-and-brands/product-service/product.md#how-to-add-your-first-product)

### Assign a product to a category

To assign a product to a category, you need to send a request to the [Assigning a resource to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#post-category-tenant-categories-categoryid-assignments) endpoint and do the following:

* Set the `ref.type` field to `"PRODUCT"`.
* Provide the product ID in the `ref.id` field.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}/assignments' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "ref": {
      "id": "1639265",
      "type": "PRODUCT"
    }
  }'
```

### Retrieve the category assignments

To check whether the resource was properly assigned to the category, you can send a request to the [Retrieving resources assigned to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#get-category-tenant-categories-categoryid-assignments) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}/assignments' 
  --header 'X-Version: v2' 
  --header 'Accept: */*'
```

## How to delete resource assignments

You can delete all resources assigned to a particular category, or just one specific assignment.

{% hint style="warning" %}
As a result of this procedure, only category assignments are deleted; the categories and resources themselves remain in the database.
{% endhint %}

#### Option one: Delete all product assignments

To delete all assignments for a specific category, you need to send a request to the [Deleting all category assignments](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#delete-category-tenant-categories-categoryid-assignments) endpoint and set the `assignmentType` query parameter to `PRODUCT`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request DELETE 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}/assignments' 
  --header 'X-Version: v2' 
  --header 'Accept: */*'
```

### Option two: Delete a specific product assignment

To delete only a specific assignment, you need to send a request to the [Deleting a category assignment by reference ID](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#delete-category-tenant-categories-categoryid-assignments-assignmentid) and enter the ID of the resource in the `referenceId` path parameter.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request DELETE 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}/assignments/{assignmentId}' 
  --header 'X-Version: v2' 
  --header 'Accept: */*'
```

## How to publish/unpublish a category

To publish or unpublish a category, you need to send a request to the [Upserting a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#put-category-tenant-categories-categoryid) endpoint and set the `published` property to `true` or `false`.

Category tree [Retrieving the category trees](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#get-category-tenant-category-trees)  and [Retrieving a specific category tree](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#get-category-tenant-category-trees-categoryid) endpoints exclude trees in which the root category has `published=false`, when only published categories are requested (`showUnpublished=false`).

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request PATCH 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "localizedName": {
      "en": "Floor Care Liquids"
    },
    "localizedSlug": {
      "en": "Floor-Care-Liquids"
    },
    "position": 3,
    "published": true,
    "metadata": {
      "version": 1
    }
  }'
```

### How to build and manage category trees

Category trees are built every time you create or update a category. The `parentId` is the identifier of the root category. Depending on your needs, you can manage the order of categories in a category tree by modifying the `parentId` and `position` elements of a particular category.

#### Retrieving category trees

**Option one: Retrieve a specific category tree**

{% hint style="danger" %}
It is only possible to retrieve a category tree for a root category. It is not possible to get it for a category that lies lower in a hierarchy.
{% endhint %}

To retrieve a specific category tree, you need to send a request to the [Retrieving a specific category tree](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#get-category-tenant-category-trees-categoryid) endpoint and provide the category ID in the `categoryId` path parameter.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/category/{tenant}/category-trees/{categoryId}' 
  --header 'X-Version: v2' 
  --header 'Accept: */*'
```

**Option two: Retrieve all category trees belonging to the tenant**

To retrieve all category trees, you need to send a request to the [Retrieving the category trees](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-tree-resources#get-category-tenant-category-trees) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/category/{tenant}/category-trees' 
  --header 'X-Version: v2' 
  --header 'Accept: */*'
```

**Option three: Retrieve a list of subcategories of a category**

To retrieve a list of subcategories for a specific category, you need to send a request to the [Retrieving subcategories for a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#get-category-tenant-categories-categoryid-subcategories) endpoint.

{% hint style="warning" %}
You can limit the depth of retrieved subcategories with the `depth` parameter.

* If set to `1`, only direct children of the specified category are retrieved.
* If not specified, all descendants of the specified category are retrieved.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}/subcategories' 
  --header 'X-Version: v2' 
  --header 'Accept: */*'
```

**Moving a category**

You can move a category by modifying its `parentId` value.

{% hint style="warning" %}
When you move a category, all its subcategories and assigned references move along with it.
{% endhint %}

To move a category to be a child of another category, you need to send a request to the [Upserting a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#put-category-tenant-categories-categoryid) endpoint and provide the desired parent category ID in the `parentId` field.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request PATCH 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "localizedName": {
      "en": "Floor Care Liquids"
    },
    "localizedSlug": {
      "en": "Floor-Care-Liquids"
    },
    "position": 3,
    "published": true,
    "metadata": {
      "version": 1
    }
  }'
```

## Classification

Classification categories allow you to organize products with consistent attributes across your catalog. By defining reusable attribute schemas that are automatically inherited by products assigned to those categories, you can ensure data quality and consistency while reducing manual work.

### Creating a classification category

To create a classification category, send a request to the [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories) endpoint with the `type` field set to `"CLASSIFICATION"` and define `ownClassificationMixins`.

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/category/{tenant}/categories' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "type": "CLASSIFICATION",
    "parentId": "root",
    "localizedName": {
      "en": "Power Tools"
    },
    "localizedDescription": {
      "en": "Professional power tools"
    },
    "localizedSlug": {
      "en": "power-tools"
    },
    "position": 5,
    "published": true,
    "ownClassificationMixins": [
      {
        "name": "toolsClassification",
        "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
        "required": false
      }
    ],
    "mixins": {}
  }'
```

### Response with inherited mixins

When retrieving a classification category that has parent classification categories, the `classificationMixins` field contains the combined list:

```json
{
  "id": "0720b75e-ee1c-4d76-9f53-eb3af3927e13",
  "type": "CLASSIFICATION",
  "parentId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb",
  "localizedName": {
    "en": "Corded Power Tools"
  },
  "position": 0,
  "published": true,
  "ownClassificationMixins": [
    {
      "name": "cordedToolsClassification",
      "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json",
      "required": false
    }
  ],
  "classificationMixins": [
    {
      "name": "toolsClassification",
      "mixinPath": "class_EA673_toolsClassification",
      "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
      "required": false,
      "sourceCategoryId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb"
    },
    {
      "name": "cordedToolsClassification", 
      "mixinPath": "class_EA677_cordedToolsClassification",
      "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json",
      "required": false,
      "sourceCategoryId": "0720b75e-ee1c-4d76-9f53-eb3af3927e13"
    }
  ],
  "metadata": {
    "version": 0,
    "createdAt": "2024-08-28T14:00:13.181Z",
    "modifiedAt": "2024-08-28T14:00:13.181Z"
  }
}
```

{% hint style="info" %}

To learn about the end-to-end flow for implementing classification in your B2B commerce platform, along with the product service, see [Classification Tutorial](../category-tree/classification.md).

{% endhint %}
