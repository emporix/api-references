---
icon: folder-closed
description: 
layout: Learn how to configure classification within product and categories.
  width: wide
---

# Classification Tutorial

## Introduction

In B2B commerce, classification is essential for organizing and managing products with consistent attributes across your catalog. Classification categories allow you to define reusable attribute schemas that are automatically inherited by products assigned to those categories, reducing manual work and ensuring consistency.

**Key features**

| Feature | Description |
|---------|-------------|
| **Product attribute standardization** | Define consistent schemas for products within specific categories, ensuring data quality and consistency across your catalog. |
| **Enhanced search and filtering** | Enable better product discovery by allowing customers to filter products based on standardized classification attributes. |
| **Complex product hierarchy support** | Handle products that belong to multiple categories with different attribute requirements. |
| **Category-specific workflows** | Apply different business rules and validations based on product classifications. |
| **Standardized data exchange** | Standardize product data for integration with external systems, marketplaces, and partners. |
| **Automatic mixin application** | Automatically apply classification mixins to products based on category assignment. |
| **Mixin inheritance** | Inherit classification mixins through category hierarchies. |
| **Required attribute validation** | Validate that products have required classification attributes. |
| **Automatic schema URL population** | Automatically populate schema URLs in product updates. |

By leveraging classification categories, you can ensure consistency, improve data quality, and simplify product management in your B2B commerce platform.

{% hint style="info" %}

This tutorial uses the [Category Service](../catalogs-and-categories/category-tree/README.md) and [Product Service](../products-labels-and-brands/product-service/README.md) to manage classification categories and products.

{% endhint %}

## Understanding classification categories

Classification categories are special categories that define classification mixins - reusable schemas that specify what attributes the products inside a category should have. Unlike standard categories, classification categories can define their own classification mixins and inherit mixins from parent classification categories.

### Category types

Categories can be one of two types:

- **STANDARD**: Default type, a regular category without classification mixins
- **CLASSIFICATION**: Category that can define classification mixins for product classification.

## Creating classification categories

When creating a subcategory or assigning a parent category, both the parent and child categories must be of the same type (STANDARD or CLASSIFICATION). You cannot have a CLASSIFICATION category as a child of a STANDARD category, or vice versa.

The `code` field is mandatory for classification categories. It's used to construct the mixinPath for products, following the pattern `class_<category.code>_<mixin.name>`. This ensures unique mixin paths across your category hierarchy.

### Basic classification category

To create a classification category, send a reqest to the [Creating a new category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-resources#post-category-tenant-categories) endpoint, set the `type` field to `"CLASSIFICATION"`, provide a `code`, and define `ownClassificationMixins`.

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/category/{tenant}/categories' 
  --header 'X-Version: v2' \
  --header 'Content-Type: application/json' 
  --data '{
    "type": "CLASSIFICATION",
    "parentId": "root",
    "code": "POWER_TOOLS",
    "localizedName": {
      "en": "Power Tools"
    },
    "published": true,
    "ownClassificationMixins": [
      {
        "name": "toolsClassification",
        "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
        "required": false
      }
    ]
  }'
```

#### Classification mixin structure

Each classification mixin in `ownClassificationMixins` includes:

| Field | Description | Required |
|-------|-------------|----------|
| `name` | Name of the mixin (pattern: `^[a-zA-Z0-9_]\S*$`) | Yes |
| `schemaUrl` | URL of the mixin schema (pattern: `^https?://[^\s/$.?#].\S*$`) | Yes |
| `required` | Boolean indicating if the mixin is required for products in this category | No (defaults to `false`) |

#### Multiple classification mixins

You can define multiple classification mixins for a single category:

```json
{
   "type": "CLASSIFICATION",
   "code": "ELECTRONICS",
   "localizedName": {
      "en": "Electronics"
   },
   "ownClassificationMixins": [
      {
         "name": "technicalSpecs",
         "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/technicalSpecs_v1.json",
         "required": true
      },
      {
         "name": "warrantyInfo",
         "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/warrantyInfo_v1.json",
         "required": false
      }
   ]
}
```

## Classification inheritance

**Important**: Classification mixins are inherited through the category hierarchy. When you assign a product to a category, it receives all classification mixins from:

- The classification category to which the product is directly assigned.
- All parent categories in the category hierarchy that are of the `CLASSIFICTION` type.

### Category type matching requirement

**Important**: When creating a subcategory or assigning a parent category, both categories must be of the same type. If a parent category is CLASSIFICATION, the child category must also be CLASSIFICATION. Similarly, if a parent is STANDARD, the child must be STANDARD.

### Example: inheritance chain

Consider this category hierarchy:

```
Power Tools (CLASSIFICATION)
  └── Corded Power Tools (CLASSIFICATION)
      └── Cordless Drills (CLASSIFICATION)
```

If you create a classification category "Corded Power Tools" as a child of "Power Tools" with the following request:

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/category/{tenant}/categories' \
  --header 'X-Version: v2' \
  --header 'Content-Type: application/json' \
  --data '{
    "type": "CLASSIFICATION",
    "parentId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb",
    "code": "CORDED_TOOLS",
    "localizedName": {
      "en": "Corded Power Tools"
    },
    "ownClassificationMixins": [
      {
        "name": "cordedToolsClassification",
        "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json",
        "required": false
      }
    ]
  }'
```

Then, when you retrieve this category, the response includes both its own mixins (`ownClassificationMixins`) and inherited mixins (`classificationMixins`):

```json
{
   "id": "0720b75e-ee1c-4d76-9f53-eb3af3927e13",
   "type": "CLASSIFICATION",
   "parentId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb",
   "code": "CORDED_TOOLS",
   "localizedName": {
      "en": "Corded Power Tools"
   },
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
         "mixinPath": "class_POWER_TOOLS_toolsClassification",
         "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
         "required": false,
         "sourceCategoryId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb"
      },
      {
         "name": "cordedToolsClassification",
         "mixinPath": "class_CORDED_TOOLS_cordedToolsClassification",
         "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json",
         "required": false,
         "sourceCategoryId": "0720b75e-ee1c-4d76-9f53-eb3af3927e13"
      }
   ]
}
```

Notice that:

- `ownClassificationMixins` contains only the mixins defined directly on this category
- `classificationMixins` (read-only) contains all mixins including inherited ones from parent categories
- Each mixin in `classificationMixins` includes a `mixinPath` field built using the pattern: `class_<sourceCategory.code>_<name>` (this is why the `code` field is mandatory for classification categories)
- The `sourceCategoryId` identifies which category in the hierarchy defined each mixin

## Products and classification mixins

### Assigning products to classification categories

When you assign a product to a classification category, the product automatically receives all classification mixins from that category and its parent categories.

Send a request to the [Assigning a resource to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#post-category-tenant-categories-categoryid-assignments) endpoint with the defined `type` and `id`.

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/category/{tenant}/categories/{categoryId}/assignments' 
  --header 'X-Version: v2' \
  --header 'Content-Type: application/json' 
  --data '{
    "ref": {
      "id": "product-123",
      "type": "PRODUCT"
    }
  }'
```

Then, when you retrieve a product assigned to a classification category with the [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid) endpoint, the response includes the `classificationMixins` field in the metadata:

```json
{
   "id": "product-123",
   "name": "Cordless Drill",
   "code": "DRILL-001",
   "productType": "BASIC",
   "published": true,
   "categoryIds": ["0720b75e-ee1c-4d76-9f53-eb3af3927e13"],
   "mixins": {
      "productCustomAttributes": {
         "orderUnit": "H87",
         "minOrderQuantity": 1
      },
      "class_POWER_TOOLS_toolsClassification": {
         "powerSource": "battery",
         "voltage": "18V"
      },
      "class_CORDED_TOOLS_cordedToolsClassification": {
         "chuckSize": "13mm",
         "maxTorque": "50Nm"
      }
   },
   "metadata": {
      "version": 1,
      "createdAt": "2024-11-27T10:00:00.000Z",
      "modifiedAt": "2024-11-27T10:00:00.000Z",
      "classificationMixins": [
         {
            "name": "toolsClassification",
            "mixinPath": "class_POWER_TOOLS_toolsClassification",
            "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
            "usedSchemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
            "obsoleteSchemaUrlUsed": false,
            "required": false,
            "sourceCategoryId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb"
         },
         {
            "name": "cordedToolsClassification",
            "mixinPath": "class_CORDED_TOOLS_cordedToolsClassification",
            "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v2.json",
            "usedSchemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
            "obsoleteSchemaUrlUsed": true,
            "required": false,
            "sourceCategoryId": "0720b75e-ee1c-4d76-9f53-eb3af3927e13"
         }
      ],
      "mixins": {
         "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/productCustomAttributesMixIn-v38.json",
         "class_POWER_TOOLS_toolsClassification": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
         "class_CORDED_TOOLS_cordedToolsClassification": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json"
      }
   }
}
```

#### Understanding classification mixin fields

The `classificationMixins` array in product metadata provides:

| Field | Description |
|-------|-------------|
| `name` | Name of the mixin |
| `mixinPath` | The path to use when defining attributes on a product (pattern: `class_<sourceCategory.code>_<name>`) |
| `schemaUrl` | Current URL of the mixin schema defined on the category |
| `usedSchemaUrl` | If the mixin has been used in the product, this contains the URL of the schema version actually used |
| `obsoleteSchemaUrlUsed` | Boolean indicating if the product is using an outdated schema version (`usedSchemaUrl` differs from `schemaUrl`) |
| `required` | Boolean indicating if the mixin is required |
| `sourceCategoryId` | ID of the category where the mixin originates |

## Using classification mixins in product updates

### Important: schema URL autopopulation

When updating or partially updating a product, you do not need to provide the `metadata.mixins.<mixinPath>` schema URL for classification mixins. The system automatically populates these schema URLs based on the product's category assignments.

For example, when updating a product with classification mixins, you can omit the schema URL:

```json
{
   "mixins": {
      "class_CATEGORY_CODE_mixinName": {
         "field1": "value1",
         "field2": "value2"
      }
   },
   "metadata": {
      "version": 1
   }
}
```

The system automatically adds the `metadata.mixins.class_CATEGORY_CODE_mixinName` with the correct schema URL from the category definition.

{% hint style="info" %}
This autopopulation feature is tested in the codebase and ensures that classification mixin schemas are always synchronized with category definitions, even if you don't explicitly provide them in update requests.
{% endhint %}

For example, use the [Partially updateing a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) endpoint without the schema URL in the request.

```bash
curl -L 
  --request PATCH 
  --url 'https://api.emporix.io/product/{tenant}/products/{productId}' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "mixins": {
      "class_CATEGORYC_nameC": {
        "optionalField1": "optionalValue1",
        "optionalField2": "optionalValue2"
      }
    },
    "metadata": {
      "version": 4
    }
  }'
```

After the update, the product response includes the automatically populated schema URL:

```json
{
   "mixins": {
      "class_CATEGORYC_nameC": {
         "optionalField1": "optionalValue1",
         "optionalField2": "optionalValue2"
      }
   },
   "metadata": {
      "mixins": {
         "class_CATEGORYC_nameC": "http://test.local/noRequiredFieldsSchema.json"
      }
   }
}
```

## Required classification mixins

### Understanding required mixins

Validation for required classification mixins occurs when both of the following conditions are met:

1. The classification mixin on the category has `required: true`
2. The mixin schema itself defines required fields

When both conditions are met, the system validates that the mixin data in the request contains all required fields defined in the schema. This validation happens automatically even if you don't explicitly provide the classification mixin data in the request, as long as the product is assigned to a category that has that mixin marked as required.

### Validation rules

The validation process:

{% stepper %}
{% step %}
### Identification of the required mixins

The system checks all classification mixins from the product's assigned categories (including inherited ones from parent categories).
{% endstep %}

{% step %}
### Filtering for required mixins

Only mixins with `required: true` are considered.
{% endstep %}

{% step %}
### Validating schema requirements

For each required mixin, the system validates that:

- The mixin data exists in the product's `mixins` object (or is inherited from parent variant for variants), AND
- All required fields defined in the mixin schema are present in the mixin data
{% endstep %}
{% endstepper %}

**For non-variant products**: The required mixin must be present in the product's `mixins` object with all schema-required fields.

**For variant products**: The required mixin can be:

- Present in the variant's own `mixins` object with all schema-required fields, OR
- Inherited from the parent variant's `mixins` object (the parent variant must have all schema-required fields)

If a required mixin is missing or doesn't contain all required fields from the schema, the update/partial update request will fail with a validation error.

### Example: required mixin validation

Consider a category with a required classification mixin where the schema also defines required fields:

**Category definition:**

```json
{
   "type": "CLASSIFICATION",
   "code": "REQUIRED_CAT",
   "ownClassificationMixins": [
      {
         "name": "requiredMixin",
         "schemaUrl": "https://example.com/schema.json",
         "required": true
      }
   ]
}
```

**Schema at `https://example.com/schema.json`:**

```json
{
   "type": "object",
   "required": ["requiredField"],
   "properties": {
      "requiredField": {
         "type": "string"
      },
      "optionalField": {
         "type": "string"
      }
   }
}
```

#### Scenario 1: missing the required mixin entirely

If you try to update a product assigned to this category without providing the required mixin:

```json
{
   "mixins": {
      "otherMixin": {
         "field": "value"
      }
   }
}
```

The request fails because the product is assigned to a category with a required mixin, and the mixin data is missing.

#### Scenario 2: missing required fields from the schema

If you provide the mixin but omit the schema-required field:

```json
{
   "mixins": {
      "class_REQUIRED_CAT_requiredMixin": {
         "optionalField": "value"
         // Missing "requiredField" which is required by the schema
      }
   }
}
```

The request fails with:

```json
{
   "message": "There is a validation error. Please check the details.",
   "details": [
      {
         "message": "object has missing required properties ([\"requiredField\"]): [mixins:class_REQUIRED_CAT_requiredMixin]"
      }
   ]
}
```

### Example: successful update with required mixin

To successfully update a product with a required classification mixin, you must provide all required fields defined in the schema:

```json
{
   "mixins": {
      "class_REQUIRED_CAT_requiredMixin": {
         "requiredField": "value",
         "optionalField": "optionalValue"
      }
   },
   "metadata": {
      "version": 1
   }
}
```

{% hint style="success" %}
Even if you don't include the mixin in your update request, the system will still validate it if:

- The product is assigned to a category with `required: true` mixin
- The mixin schema defines required fields

In such cases, the system will check if the mixin exists in the database (for variants, it checks both the variant and parent variant). If the mixin is missing or incomplete, the validation will fail.
{% endhint %}

### Variant inheritance of required mixins

For variant products, if the parent variant has a required classification mixin with all schema-required fields, the variant can inherit it:

**Parent variant:**

```json
{
   "id": "variantParent",
   "mixins": {
      "class_REQUIRED_CAT_requiredMixin": {
         "requiredField": "value",
         "optionalField": "optionalValue"
      }
   }
}
```

**Child variant:**

```json
{
   "id": "variantParent--variant1",
   "parentVariantId": "variantParent",
   "mixins": {
      // Variant inherits class_REQUIRED_CAT_requiredMixin from parent
      // The parent variant must have all schema-required fields
      "productVariantAttributes": {
         "size": "M"
      }
   }
}
```

The parent variant must have the required mixin with all schema-required fields. If the parent variant is missing required fields, the child variant update will fail validation.

## Best practices

- **Plan your category hierarchy**: Design your classification categories to maximize inheritance and minimize duplication
- **Use required mixins sparingly**: Only mark mixins as required when they are truly essential for products in that category
- **Keep schema URLs consistent**: Use versioned schema URLs to track schema evolution
- **Monitor obsolete schemas**: Check the `obsoleteSchemaUrlUsed` flag in product responses to identify products using outdated schemas
- **Leverage inheritance**: Create parent classification categories with common mixins, then create child categories with category-specific mixins
- **Use mixinPath correctly**: Always use the `mixinPath` from `classificationMixins` when defining product attributes, not the mixin name

