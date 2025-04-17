---
seo:
  title: Product Service Tutorials
  description: >-
    product, product template, product templates, product variant, product
    variants, product bundle, product bundles, variant attributes
---

# product

import {\
Alert,\
Button,\
OpenApiTryIt,\
ExplainStep\
} from '@redocly/developer-portal/ui';\
import { Preview } from '../components/Preview.tsx'

## Product Service Tutorials

### How to add your first products

:::attention

This tutorial presents how to create a basic product. To learn more about types of products available in the Emporix Commerce Engine, check out the [Products guide](https://developer.emporix.io/user-guides/core-commerce/products/product-user-guide#overview).

:::

Take a look at the relationships between prices and other resources in the Emporix Commerce Engine:

:::attention

Countries and regions are predefined in the Emporix API Country Service. You can check which countries and regions are available by sending requests to the following endpoints:

* Retrieving all countries
* Retrieving all regions

:::

Adding your first product is a process made up of two main steps:

1. [Defining sales tax rates](product.md#define-sales-tax-rates).
2. [Adding products](product.md#add-products).
3. [Adding media files for a product](product.md#add-media-for-a-product).

#### Define sales tax rates

Sales tax rates are stored in tax configurations. Each configuration indicates a country and defines tax classes applicable to it.

You can manage your tax configurations through the Emporix API [Tax Service](../openapi/tax/).

:::info

For more information, check out the [Tax classes guide](https://developer.emporix.io/user-guides/core-commerce/taxes/taxes-v2).

:::

To define sales tax rates for a country, you need to send a request to the Creating a new tax configuration endpoint.

#### Add products

To add a single basic product, you need to send a request to the Creating a new product endpoint.

You can also add multiple basic products at the same time. To achieve that, you need to send a request to the Creating multiple products endpoint.

#### Add media for a product

To add media files, for example images or videos, for a particular product, you can upload them directly to the Emporix database, or link to their location on an external website.\
In the following example, we are creating a `public` type of an asset that is linked to the product of our choice by sending a request to the Creating an asset endpoint with the `media.asset_manage` scope.

:::info

Sending a json/application request to the Creating an asset endpoint does **not** mean that the asset is uploaded to the database. It is only linked to the resource (category or product).\
If you want to upload the asset to the database, you need to send a multipart request to the Creating an asset endpoint.\
For more information, check out the [_Media Management Tutorials_](../content/media/).\
:::

### How to create a bundle of personalized products

With Emporix API, you can group together two or more products that already exist in the system so that they can be sold at one collective price.

You can also personalize your products by using the Emporix-provided templates, or by creating your own ones. The values of the template's attributes are specified in the product's `mixins.productTemplateAttributes` field.

:::info

To learn more about product bundles and templates, check out the [Products guide](https://developer.emporix.io/user-guides/core-commerce/products/product-user-guide).

:::

To create personalized products and then group them in a bundle, perform the following steps:

1. [Create a template for your product.](product.md#create-a-product-template)
2. [Create a product by using a product template.](product.md#create-a-product-by-using-a-product-template)
3. [Create a bundle of products.](product.md#create-a-bundle-of-products)

#### Before you start

:::attention\
The `product.product_publish` scope is only required if you want to publish the product on its creation.\
:::

[Ensure that you have defined sales tax rates.](product.md#define-sales-tax-rates)

#### Create a product template

You can create a product template that contains additional attributes describing your product. To create a new product template, you need to call the Creating a new product template endpoint.

\<OpenApiTryIt\
definitionId="product"\
operationId="POST-product-create-template"\
properties=\{{\
name: {\
en: "T-shirt"\
},\
attributes: \[\
{\
key: "size",\
name: {\
en: "Size",\
pl: "Rozmiar"\
},\
type: "BOOLEAN",\
metadata: {\
mandatory: false,\
defaultValue: true\
},\
values: \[\
{\
key: "XS"\
},\
{\
key: "S"\
},\
{\
key: "M"\
},\
{\
key: "L"\
},\
{\
key: "XL"\
}\
]\
},\
{\
key: "color",\
name: {\
en: "Color",\
pl: "Kolor"\
},\
type: "TEXT",\
metadata: {\
mandatory: false,\
defaultValue: null\
},\
values: \[\
{\
key: "GREEN"\
},\
{\
key: "RED"\
},\
{\
key: "BLUE"\
}\
]\
},\
{\
key: "discount",\
name: {\
en: "Discount",\
pl: "Rabat"\
},\
type: "NUMBER",\
metadata: {\
mandatory: false,\
defaultValue: "0",\
},\
values: \[\
{\
key: "0"\
},\
{\
key: "30"\
},\
{\
key: "40"\
},\
{\
key: "50"\
}\
]\
}\
]\
\}}\
/>

The `id` from the response is further referred to as \{{product\_template\_Id\}}.

#### Create a product by using a product template

By applying a product template, you can create a product that contains additional attributes, which are included in the product's `mixins.productTemplateAttributes` field.

To create a new product by applying a product template to it, you need to call the Creating a new product endpoint and provide the template's ID in the request body.

:::info\
In this example, we assign a template to a product on its creation. The created product can be a standalone one, or contain variants. Here, the product does not contain any variants. For creating a parent variant product with variants, check out the [How to create a parent product with variants](product.md#how-to-create-a-parent-product-with-variants) tutorial.\
:::

:::info

When creating or updating a product of the `PARENT_VARIANT` type, by default, product variants are generated. If you do **not** want to create product variants for the product, set the `skipVariantGeneration` parameter to `true`.\
:::

\<OpenApiTryIt\
definitionId="product"\
operationId="POST-product-create-product"\
properties=\{{\
name: {\
en: "T-shirt",\
de: "T-shirt"\
},\
code: "tshirt01",\
description: "Cotton T-shirt",\
published: false,\
taxClasses: {\
DE: "STANDARD"\
},\
template: {\
id: "\{{product\_template\_Id\}}",\
version: "1"\
},\
mixins: {\
productTemplateAttributes: {\
color: "GREEN",\
size: "L",\
discount: 30\
},\
productCustomAttributes: {\
pricingMeasurePrice: 13,\
unitPricingMeasure: {\
value: 133,\
unitCode: "GRM"\
},\
unitPricingBaseMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
pricingMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
orderUnit: "H87",\
minOrderQuantity: 2,\
maxOrderQuantity: 10,\
defaultOrderQuantity: 5\
}\
},\
metadata: {\
mixins: {\
productCustomAttributes: "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
}\
}\
\}}\
/>

#### Create a bundle of products

You can group together two or more products that already exist in the system so that they can be sold at one collective price. To achieve that, you need to call the Creating a new product endpoint.

In this example, we will create a bundle of the T-shirt product we created above, and join it with the socks product that already exists.

\<OpenApiTryIt\
definitionId="product"\
operationId="POST-product-create-product"\
defaultExample="BUNDLE Product Creation"\
properties= \{{\
name: "T-shirt and socks bundle",\
code: "tshirt\_socks\_bundle",\
description: "A bundle of t-shirt and socks.",\
published: false,\
taxClasses: {\
DE: "STANDARD"\
},\
bundledProducts: \[\
{\
id: "\{{bundled\_product\_1\_Id\}}",\
amount: 1\
},\
{\
id: "\{{bundled\_product\_2\_Id\}}",\
amount: 2\
}\
],\
productType: "BUNDLE",\
mixins: {\
productCustomAttributes: {\
pricingMeasurePrice: 1,\
unitPricingMeasure: {\
value: 1350,\
unitCode: "H87"\
},\
unitPricingBaseMeasure: {\
value: 1,\
unitCode: "H87"\
},\
pricingMeasure: {\
value: 1,\
unitCode: "H87"\
},\
orderUnit: "H87",\
minOrderQuantity: 1,\
maxOrderQuantity: 10,\
defaultOrderQuantity: 1\
}\
},\
metadata: {\
mixins: {\
productCustomAttributes: "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
}\
}\
\}}\
/>

The value of the `productId` from the response is the \{{bundle\_Id\}}.

### How to create a parent variant product with variants

Variants are derivatives of the parent variant product. They contain the same attributes as their parent variant, but assume different attribute values.

:::attention\
The `product.product_publish` scope is only required if you want to publish the product on its creation.\
:::

#### Create a parent variant product

Variants are created automatically whenever their parent variant product is created or updated. The combinations of variants are created based on the attributes defined in the product template applied to the parent variant, and the attributes and values specified in the `variantAttributes` field of the parent variant.

\
\
\
\


Before you start, ensure that the `skipVariantGeneration` parameter is set to `false`.

:::info

When creating or updating a product of the `PARENT_VARIANT` type, by default, product variants are generated. If you do **not** want to create product variants for the product, set the `skipVariantGeneration` parameter to `true`.\
:::

:::info

The product template can contain more attributes and values than are needed to create a parent variant. In the `variantAttributes` field, you need to specify the attributes and values from the product template that are relevant to the particular parent variant product and its variants.\
:::

To create a single `parent_variant` type of product with variants, you need to send a request to the Creating a new product endpoint.

\<OpenApiTryIt\
definitionId="product"\
operationId="POST-product-create-product"\
defaultExample="PARENT VARIANT Product Creation"\
properties= \{{\
"name": "T-shirt with variants",\
"code": "PARENT001",\
"description": "Plain cotton T-shirt.",\
"published": false,\
"taxClasses": {\
"EN": "STANDARD"\
},\
"productType": "PARENT\_VARIANT",\
"template": {\
"id": "634cea2740033d7c2e7b03a8",\
"version": 1\
},\
"relatedItems": \[\
{\
"refId": "634cea2740033d7c2e7b03a9",\
"type": "CONSUMABLE"\
}\
],\
"variantAttributes": {\
"color": \[\
{\
"key": "RED"\
},\
{\
"key": "GREEN"\
},\
{\
"key": "BLUE"\
}\
],\
"size": \[\
{\
"key": "XS"\
},\
{\
"key": "S"\
},\
{\
"key": "M"\
},\
{\
"key": "L"\
},\
{\
"key": "XL"\
}\
]\
},\
"mixins": {\
"productCustomAttributes": {\
"pricingMeasurePrice": 13,\
"unitPricingMeasure": {\
"value": 133,\
"unitCode": "GRM"\
},\
"unitPricingBaseMeasure": {\
"value": 100,\
"unitCode": "GRM"\
},\
"pricingMeasure": {\
"value": 100,\
"unitCode": "GRM"\
},\
"orderUnit": "H87",\
"minOrderQuantity": 2,\
"maxOrderQuantity": 10,\
"defaultOrderQuantity": 5\
},\
"productTemplateAttributes": {\
"color": \[\
{\
"key": "RED"\
},\
{\
"key": "GREEN"\
},\
{\
"key": "BLUE"\
}\
]\
}\
},\
"metadata": {\
"mixins": {\
"productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
}\
}\
\}}\
/>

If you want to create multiple `parent_variant` products at the same time, send a request to the Creating multiple products endpoint.

\<OpenApiTryIt\
definitionId="product"\
operationId="POST-product-create-bulk-products"\
defaultExample="Create multiple products in bulk"\
properties={\[\
{\
id: "abc-123",\
name: "Dress 1 with variants",\
code: "532432412331",\
description: "Plain cotton dress",\
published: "false",\
taxClasses: {\
EN: "STANDARD"\
},\
productType: "PARENT\_VARIANT",\
template: {\
id: "908cdv2740033d7c2e7b03b9",\
version: 1\
},\
relatedItems: \[\
{\
refId: "908cea2740033d7c2e7b03a9",\
type: "CONSUMABLE"\
}\
],\
variantAttributes: {\
color: \[\
{\
key: "RED"\
},\
{\
key: "BLUE"\
},\
{\
key: "YELLOW"\
}\
],\
size: \[\
{\
key: "XS"\
},\
{\
key: "S"\
},\
{\
key: "M"\
},\
{\
key: "L"\
},\
{\
key: "XL"\
}\
]\
},\
mixins: {\
productCustomAttributes: {\
pricingMeasurePrice: 13,\
unitPricingMeasure: {\
value: 133,\
unitCode: "GRM"\
},\
unitPricingBaseMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
pricingMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
orderUnit: "H87",\
minOrderQuantity: 2,\
maxOrderQuantity: 10,\
defaultOrderQuantity: 5\
},\
productTemplateAttributes: {\
color: \[\
{\
key: "RED"\
},\
{\
key: "BLUE"\
},\
{\
key: "YELLOW"\
}\
]\
}\
},\
metadata: {\
mixins: {\
productCustomAttributes: "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
}\
}\
},\
{\
id: "abc-124",\
name: "Dress 2 with variants",\
code: "532432412332",\
description: "Pleaded cotton dress",\
published: "false",\
taxClasses: {\
EN: "STANDARD"\
},\
productType: "PARENT\_VARIANT",\
template: {\
id: "908cdv2740033d7c2e7b03b9",\
version: 1\
},\
relatedItems: \[\
{\
refId: "908cea2740033d7c2e7b03a9",\
type: "CONSUMABLE"\
}\
],\
variantAttributes: {\
color: \[\
{\
key: "RED"\
},\
{\
key: "BLUE"\
},\
{\
key: "YELLOW"\
}\
],\
size: \[\
{\
key: "XS"\
},\
{\
key: "S"\
},\
{\
key: "M"\
},\
{\
key: "L"\
},\
{\
key: "XL"\
}\
]\
},\
mixins: {\
productCustomAttributes: {\
pricingMeasurePrice: 13,\
unitPricingMeasure: {\
value: 133,\
unitCode: "GRM"\
},\
unitPricingBaseMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
pricingMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
orderUnit: "H87",\
minOrderQuantity: 2,\
maxOrderQuantity: 10,\
defaultOrderQuantity: 5\
},\
productTemplateAttributes: {\
color: \[\
{\
key: "RED"\
},\
{\
key: "BLUE"\
},\
{\
key: "YELLOW"\
}\
]\
}\
},\
metadata: {\
mixins: {\
productCustomAttributes: "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
}\
}\
},\
{\
id: "abc-125",\
name: "Dress 3 with variants",\
code: "532432412336",\
description: "Cotton dress with lace",\
published: "false",\
taxClasses: {\
EN: "STANDARD"\
},\
productType: "PARENT\_VARIANT",\
template: {\
id: "908cdv2740033d7c2e7b03c7",\
version: 1\
},\
relatedItems: \[\
{\
refId: "908cea2740033d7c2e7b03a9",\
type: "CONSUMABLE"\
}\
],\
variantAttributes: {\
color: \[\
{\
key: "RED"\
},\
{\
key: "BLUE"\
},\
{\
key: "YELLOW"\
}\
],\
size: \[\
{\
key: "XS"\
},\
{\
key: "S"\
},\
{\
key: "M"\
},\
{\
key: "L"\
},\
{\
key: "XL"\
}\
]\
},\
mixins: {\
productCustomAttributes: {\
pricingMeasurePrice: 13,\
unitPricingMeasure: {\
value: 133,\
unitCode: "GRM"\
},\
unitPricingBaseMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
pricingMeasure: {\
value: 100,\
unitCode: "GRM"\
},\
orderUnit: "H87",\
minOrderQuantity: 2,\
maxOrderQuantity: 10,\
defaultOrderQuantity: 5\
},\
productTemplateAttributes: {\
color: \[\
{\
key: "RED"\
},\
{\
key: "BLUE"\
},\
{\
key: "YELLOW"\
}\
]\
}\
},\
metadata: {\
mixins: {\
productCustomAttributes: "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
}\
}\
}\
]}\
/>

### How to create variants with new attributes and values

If you want to create variants by adding new variant attributes and/or values for a parent variant, you need to perform the following actions:

1. [Update the product template with new variant attributes and values.](product.md#update-a-product-template-with-new-attributes-and-values)
2. [Update the parent variant product with the newly updated product template.](product.md#update-the-existing-parent-variant-product-with-the-new-product-template)

:::info\
You can add new attribute values either by adding them to the product template and then updating the product, or by updating the product with new values under `variantAttributes`, if they already exist in the product template.\
:::

:::attention\
The `product.product_publish` scope is only required if you want to publish the product on its creation.\
:::

#### Update a product template with new attributes and values

To specify new attributes for your product's variants, you need to add them in the attributes field by calling the Updating a product template endpoint. Here, we've added a new key `size` to the list of available attributes.

:::info\
Each of the attributes has its own metadata element, where you can specify whether the attribute is mandatory, if it can be used as a variant attribute, and what its default value is.\
:::

To specify new values for your product's attributes, you need to add them in the `values` field. Here, we've added `PURPLE` to the list of available attribute values.

\<OpenApiTryIt\
definitionId="product"\
operationId="PUT-product-update-template"\
parameters=\{{\
path:{\
"product-template-id": "{product\_template\_Id}"\
}\
\}}\
properties= \{{\
"name": {\
"en": "T-shirt"\
},\
"metadata": {\
"version": 1\
},\
"attributes": \[\
{\
"key": "color",\
"name": {\
"en": "Color",\
"pl": "Kolor"\
},\
"type": "TEXT",\
"metadata": {\
"mandatory": false,\
"variantAttribute": true,\
"defaultValue": null\
},\
"values": \[\
{\
"key": "GREEN"\
},\
{\
"key": "RED"\
},\
{\
"key": "BLUE"\
},\
{\
"key": "PURPLE"\
}\
]\
},\
{\
"key": "discount",\
"name": {\
"en": "Discount"\
},\
"type": "NUMBER",\
"metadata": {\
"mandatory": false,\
"defaultValue": 0\
},\
"values": \[\
{\
"key": 0\
},\
{\
"key": 30\
},\
{\
"key": 40\
}\
,{\
"key": 50\
}\
,{\
"key": 60\
}\
]\
},\
{\
"key": "size",\
"name": {\
"en": "Size",\
"pl": "Rozmiar"\
},\
"type": "TEXT",\
"metadata": {\
"mandatory": false,\
"variantAttribute": true,\
"defaultValue": null\
},\
"values": \[\
{\
"key": "XS"\
},\
{\
"key": "S"\
},\
{\
"key": "M"\
},\
{\
"key": "L"\
},\
{\
"key": "XL"\
}\
]\
}\
]\
\}}\
/>

#### Update the existing parent variant product with the new product template

Since updating the product template results in it being assigned a new version, you need to update the parent variant by sending a request to the Partially updating a product endpoint and providing the new `template.version` value.

:::info\
In the `variantAttributes` field, you need to specify the attributes and attribute values that the variant products will assume. Based on the specified attributes, variant product combinations will be created automatically.\
:::

:::info

When creating or updating a product of the `PARENT_VARIANT` type, by default, product variants are generated. If you do **not** want to create product variants for the product, set the `skipVariantGeneration` parameter to `true`.\
:::

\<OpenApiTryIt\
definitionId="product"\
operationId="PATCH-product-update-product"\
parameters=\{{\
path:{\
"productId": "{parent\_variant\_Id}"\
}\
\}}\
properties=\{{\
"template": {\
"id": "634cea2740033d7c2e7b03a8",\
"version": 2\
},\
"variantAttributes": {\
"color": \[\
{\
"key": "GREEN"\
},\
{\
"key": "RED"\
},\
{\
"key": "BLUE"\
},\
{\
"key": "PURPLE"\
}\
],\
"size": \[\
{\
"key": "XS"\
},\
{\
"key": "S"\
},\
{\
"key": "M"\
},\
{\
"key": "L"\
},\
{\
"key": "XL"\
}\
]\
}\
\}}\
/>

As a result, new product variants are created automatically, in combinations that include the newly specified attributes and values.

### How to override variant attribute values

You may choose to update the basic fields of a particular variant, for example `name`, `description`, or `relatedItems`.

:::info\
The `product.product_publish` and `product.product_unpublish` scopes are only required if you want to publish or unpublish the product on its update.\
:::

#### Updating a variant with new attribute values

By default, all variant products inherit their attributes from the parent variant. You need to include the name of the attribute in the `metadata.overriden` field to be able to replace the attribute values.

:::attention\
You cannot override the following attributes: `id`, `code`, `template`, `variantAttributes`.\
:::

Update a specific variant product by sending a request to the Upserting a product endpoint.

In the following example, we override the following fields:

* `published`
* `taxClasses`

\<OpenApiTryIt\
definitionId="product"\
operationId="PUT-product-update-product"\
defaultExample="VARIANT Product Update"\
parameters=\{{\
path:{\
"productId": "{variant\_Id}"\
}\
\}}\
properties=\{{\
"name": "Blue T-shirt M",\
"code": "VARIANT001",\
"description": "The best T-shirt ever.",\
"published": true,\
"taxClasses": {\
"PL": "STANDARD"\
},\
"relatedItems": \[\
{\
"refId": "634cea2740033d7c2e7b03a9",\
"type": "CONSUMABLE"\
}\
],\
"metadata": {\
"version": 1,\
"overridden": \[\
"published",\
"taxClasses"\
]\
},\
"mixins": {\
"productVariantAttributes": {\
"color": "Blue",\
"size": "M"\
}\
}\
\}}\
/>

### How to update multiple products in one operation

If you want to update multiple products, use the bulk update feature to update several products in one operation. Send a request to the Upserting multiple products endpoint.

:::info\
The `product.product_update` scope is required.\
The `product.product_publish` and `product.product_unpublish` scopes are only required if you want to publish or unpublish the products on the update.\
:::

\<OpenApiTryIt\
definitionId="product"\
operationId="PUT-product-update-bulk-products"\
properties={\[\
{\
id: "65492420e492d916983c8431",\
code: "pa-1",\
name: {\
"en": "Product\_A"\
},\
description: {\
"en": "Some product"\
},\
productType: "BASIC",\
published: false,\
metadata: {\
"mixins": {\
"productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
},\
"version": 1,\
"schema": "https://res.cloudinary.com/saas-ag/raw/upload/v1544786405/schemata/CAAS/product.v2"\
}\
},\
{\
id: "6549262ce492d916983c8432",\
code: "pb-2",\
name: {\
"en": "Product\_B"\
},\
description: {\
"de": "",\
"ar": "",\
"en": "",\
"fr": ""\
},\
productType: "BASIC",\
published: false,\
metadata: {\
"mixins": {\
"productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
},\
"version": 2,\
"schema": "https://res.cloudinary.com/saas-ag/raw/upload/v1544786405/schemata/CAAS/product.v2"\
}\
},\
{\
id: "654926f4e492d916983c8433",\
code: "pc-3",\
name: {\
"en": "Product\_C"\
},\
description: {\
"en": "Another product"\
},\
productType: "BASIC",\
mixins: {\
"productCustomAttributes": {\
"brand": "63e9570adee051597612e36c"\
}\
},\
published: true,\
metadata: {\
"mixins": {\
"productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"\
},\
"version": 1,\
"schema": "https://res.cloudinary.com/saas-ag/raw/upload/v1544786405/schemata/CAAS/product.v2"\
}\
}\
]}\
/>

When the update request is sent successfully, the response for a particular product is returned at the same position (index) at which it is located in the request body.\
The expected response is as follows:

```xml
[
  {
      "index": 0,
      "id": "65492420e492d916983c8431",
      "code": 204,
      "status": "NO_CONTENT"
  },
  {
      "index": 1,
      "id": "6549262ce492d916983c8432",
      "code": 204,
      "status": "NO_CONTENT"
  },
  {
      "index": 2,
      "id": "654926f4e492d916983c8433",
      "code": 204,
      "status": "NO_CONTENT"
  }
]
```

When something goes wrong, you might see some error message in the response. See some examples of error notifications you might encounter:

```xml
[
    {
        "index": 0,
        "id": "65492420e492d916983c8431",
        "code": 404,
        "status": "NOT_FOUND",
        "message": "The product with id 65492420e492d916983c8431 has not been found."
    }
]
```

`404`: The first product was not found, check if you have provided the correct id.

```xml
[
    {
        "index": 1,
        "id": "6549262ce492d916983c8432",
        "code": 409,
        "status": "CONFLICT",
        "message": "The resource that was requested for update has changed. Please retry your request with valid version."
    }
]
```

`409`: The second product returns conflict, check if you have provided the correct product schema version.

```xml
[
    {
        "index": 2,
        "id": "654926f4e492d916983c8433",
        "code": 404,
        "status": "NOT_FOUND",
        "message": "Product template with id 634cea2740033d7c2e7b03a8 is not present in the database."
    }
]
```

`404`: The third product cannot be updated because the product template provided in the payload was not found, check if you have provided the correct data.
