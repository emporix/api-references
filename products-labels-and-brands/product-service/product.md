---
seo:
  title: Product Service Tutorials
  description: >-
    product, product template, product templates, product variant, product
    variants, product bundle, product bundles, variant attributes
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

# Product Tutorial

## How to add your first products

{% hint style="warning" %}
This tutorial presents how to create a basic product. To learn more about types of products available in the Emporix Commerce Engine, check out the [Products guide](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/core-commerce/product-user-guide).
{% endhint %}

Take a look at the relationships between prices and other resources in the Emporix Commerce Engine:

<figure><img src="../../.gitbook/assets/product_diagram.svg" alt="" width="700"><figcaption></figcaption></figure>

{% hint style="warning" %}
Countries and regions are predefined in the Emporix API [Country Service](../../configuration/country-service/). You can check which countries and regions are available by sending requests to the following endpoints:

* [Retrieving all countries](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#get-country-tenant-countries)
* [Retrieving all regions](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/regions#get-country-tenant-regions)
{% endhint %}

Creating your first product is a process made up of defining sales tax rates, adding the product and adding media files for a product.

{% stepper %}
{% step %}
### Define sales tax rates

Sales tax rates are stored in tax configurations. Each configuration indicates a country and defines tax classes applicable to it.

You can manage your tax configurations through the Emporix API [Tax Service](../../prices-and-taxes/tax-service/tax.md).

{% hint style="warning" %}
For more information, check out the [Tax classes guide](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/core-commerce/taxes-v2).
{% endhint %}

To define sales tax rates for a country, send a request to the [Creating a new tax configuration](https://developer.emporix.io/api-references/api-guides/prices-and-taxes/tax-service/api-reference/taxes#post-tax-tenant-taxes) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/tax/{tenant}/taxes' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "location": {
      "countryCode": "DE"
    },
    "taxClasses": [
      {
        "code": "STANDARD",
        "name": {
          "en": "Standard"
        },
        "order": 0,
        "rate": 19,
        "isDefault": true
      },
      {
        "code": "REDUCED",
        "name": {
          "en": "Reduced"
        },
        "order": 1,
        "rate": 7
      },
      {
        "code": "ZERO",
        "name": {
          "en": "Zero"
        },
        "order": 2,
        "rate": 0
      }
    ]
  }
```
{% endstep %}

{% step %}
### Add products

To add a single basic product, send a request to the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

**Simple product example:**

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/products' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "Smartphone X2",
    "code": "BASIC001",
    "description": "The world best camera and camcorder in a waterproof smartphone.",
    "published": false,
    "taxClasses": {
      "EN": "STANDARD"
    },
    "productType": "BASIC"
  }
```

You can also add multiple basic products at the same time. To achieve that, send a request to the [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/products/bulk' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '[
    {
        "id": "abc-123",
        "code": "532432412331",
        "name": "Product 1",
        "productType": "BASIC"
    },
    {
        "id": "abc-124",
        "code": "532432412332",
        "name": "Product 2",
        "productType": "BASIC"
    },
    {
        "id": "abc-125",
        "code": "532432412333",
        "name": "Product 3",
        "productType": "BASIC"
    }
]'
```
{% endstep %}

{% step %}
### Add media for a product

To add media files, for example images or videos, for a particular product, you can upload them directly to the Emporix database, or link to their location on an external website. In the following example, we are creating a `public` type of an asset that is linked to the product of our choice by sending a request to the Creating an asset endpoint with the `media.asset_manage` scope.

{% hint style="warning" %}
Sending a json/application request to the Creating an asset endpoint does **not** mean that the asset is uploaded to the database. It is only linked to the resource (category or product). If you want to upload the asset to the database, send a multipart request to the [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint. For more information, check out the [_Media Management Tutorials_](../../media/media/media.md).
{% endhint %}

```bash
curl -i -X POST 
  'https://api.emporix.io/media/{tenant}/assets' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: multipart/form-data' 
  -F 'file=[object Object]' 
  -F 'body=[object Object]'
```
{% endstep %}
{% endstepper %}

## How to create a basic product with a template

You can create a product template that contains additional attributes describing your product, and then create products using that template. Templates are optional but useful for organizing product attributes consistently across your catalog.

{% stepper %}
{% step %}
### Create a product template

To create a new product template, call the [Creating a new product template](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-templates#post-product-tenant-product-templates) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/product-templates' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "id": "545b4e3dfaee4c10def3db24",
    "name": {
      "en": "T-shirt"
    },
    "attributes": [
      {
        "key": "size",
        "name": {
          "en": "Size",
          "pl": "Rozmiar"
        },
        "type": "TEXT",
        "metadata": {
          "mandatory": false,
          "variantAttribute": false,
          "defaultValue": null
        },
        "values": [
          { "key": "XS" },
          { "key": "S" },
          { "key": "M" },
          { "key": "L" },
          { "key": "XL" }
        ]
      }
    ]
  }
```

The `id` from the response is the product template ID that you can use when creating products.

{% hint style="warning" %}
When creating a product template for a basic product, do not set `variantAttribute` to `true` in the attribute metadata. Variant attributes are only for PARENT_VARIANT and VARIANT product types.
{% endhint %}
{% endstep %}

{% step %}
### Create a product using a template

By applying a product template, you can create a product that contains additional attributes, which are included in the product's `mixins.productTemplateAttributes` field.

To create a new product by applying a product template to it, call the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint and provide the template's ID in the request body.

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/products' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "Smartphone X2",
    "code": "BASIC001",
    "description": "The world best camera and camcorder in a waterproof smartphone.",
    "published": false,
    "taxClasses": {
      "EN": "STANDARD"
    },
    "productType": "BASIC",
    "template": {
      "id": "{{product_template_Id}}",
      "version": 1
    },
    "mixins": {
      "productTemplateAttributes": {
        "size": "L"
      }
    }
  }
```
{% endstep %}
{% endstepper %}

## How to create a product bundle

With Emporix API, you can group together two or more products that already exist in the system so that they can be sold at one collective price. Product bundles do not require product templates or variant generation.

{% hint style="warning" %}
To learn more about product bundles, check out the [Products guide](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/core-commerce/product-user-guide).
{% endhint %}

To create a product bundle, perform the following steps:

{% hint style="warning" %}
* Before you start, ensure you have defined the tax classes.
* The products you want to bundle must already exist in the system.
* The `product.product_publish` scope is only required if you want to publish the product on its creation.
{% endhint %}

{% stepper %}
{% step %}
### Create a bundle of products

You can group together two or more products that already exist in the system so that they can be sold at one collective price. To achieve that, call the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

In this example, we create a bundle containing a T-shirt product and socks product that already exist in the system.

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/products' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
  "name": "T-shirt and socks bundle",
  "code": "tshirt_socks_bundle",
  "description": "A bundle of t-shirt and socks.",
  "published": false,
  "taxClasses": {
    "EN": "STANDARD",
    "DE": "STANDARD"
  },
  "bundledProducts": [
    {
      "productId": "{{bundled_product_1_Id}}",
      "amount": 1
    },
    {
      "productId": "{{bundled_product_2_Id}}",
      "amount": 2
    }
  ],
  "productType": "BUNDLE"
}
```

The value of the `productId` from the response is the \{{bundle\_Id\}}.

**Required fields for bundles:**
- `name`: Product name
- `code`: Unique product identifier
- `bundledProducts`: Array of products to include in the bundle (each with `productId` and `amount`)
- `productType`: Must be set to `"BUNDLE"`

**Optional fields:**
- `template`: Product templates are optional for bundles
- `description`: Product description
- `taxClasses`: Tax class configuration
- `published`: Publication status
- `mixins`: Additional product attributes

{% endstep %}
{% endstepper %}


## How to update multiple products in one operation

If you want to update multiple products, use the bulk update feature to update several products in one operation. Send a request to the [Upserting multiple](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-bulk) products endpoint.

{% hint style="warning" %}
The `product.product_update` scope is required. The `product.product_publish` and `product.product_unpublish` scopes are only required if you want to publish or unpublish the products on the update.
{% endhint %}

```bash
curl -i -X PUT 
  'https://api.emporix.io/product/{tenant}/products/bulk?skipVariantGeneration=false&doIndex=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "id": "65492420e492d916983c8431",
    "code": "pa-1",
    "name": {
      "en": "Product_A"
    },
    "metadata": {
      "version": 1,
      "mixins": {
        "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"
      },
      "schema": "https://res.cloudinary.com/saas-ag/raw/upload/v1544786405/schemata/CAAS/product.v2"
    },
    "description": {
      "en": "Some product"
    },
    "productType": "BASIC",
    "published": false
  },
  {
    "id": "6549262ce492d916983c8432",
    "code": "pb-2",
    "name": {
      "en": "Product_B"
    },
    "metadata": {
      "version": 2,
      "mixins": {
        "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"
      },
      "schema": "https://res.cloudinary.com/saas-ag/raw/upload/v1544786405/schemata/CAAS/product.v2"
    },
    "description": {
      "de": "",
      "ar": "",
      "en": "",
      "fr": ""
    },
    "productType": "BASIC",
    "published": false
  },
  {
    "id": "654926f4e492d916983c8433",
    "code": "pc-3",
    "name": {
      "en": "Product_C"
    },
    "metadata": {
      "version": 1,
      "mixins": {
        "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"
      },
      "schema": "https://res.cloudinary.com/saas-ag/raw/upload/v1544786405/schemata/CAAS/product.v2"
    },
    "description": {
      "en": "Another product"
    },
    "productType": "BASIC",
    "mixins": {
      "productCustomAttributes": {
        "brand": "63e9570adee051597612e36c"
      }
    },
    "published": true
}
```

When the update request is sent successfully, the response for a particular product is returned at the same position (index) at which it is located in the request body. The expected response is as follows:

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

{% include "../../.gitbook/includes/example-hint-text.md" %}

**Related services:**

Tax:

{% content-ref url="../../prices-and-taxes/tax-service/api-reference/" %}
[api-reference](../../prices-and-taxes/tax-service/api-reference/)
{% endcontent-ref %}

Product:

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

Media:

{% content-ref url="../../media/media/api-reference/" %}
[api-reference](../../media/media/api-reference/)
{% endcontent-ref %}

## How to create a parent variant product with variants

Variants are derivatives of the parent variant product. They contain the same attributes as their parent variant, but assume different attribute values.

{% hint style="warning" %}
The `product.product_publish` scope is only required if you want to publish the product on its creation.
{% endhint %}

{% stepper %}
{% step %}
### Create a product template with variant attributes

Create a product template that defines the variant attributes (for example, `color` and `size`) and their allowed values. Set `variantAttribute` to `true` in the attribute metadata so they can be used for variant generation.

Call the [Creating a new product template](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-templates#post-product-tenant-product-templates) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/product-templates' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": {
      "en": "T-shirt with variants"
    },
    "attributes": [
      {
        "key": "color",
        "name": {
          "en": "Color",
          "pl": "Kolor"
        },
        "type": "TEXT",
        "metadata": {
          "mandatory": false,
          "variantAttribute": true,
          "defaultValue": null
        },
        "values": [
          { "key": "RED" },
          { "key": "GREEN" },
          { "key": "BLUE" }
        ]
      },
      {
        "key": "size",
        "name": {
          "en": "Size",
          "pl": "Rozmiar"
        },
        "type": "TEXT",
        "metadata": {
          "mandatory": false,
          "variantAttribute": true,
          "defaultValue": null
        },
        "values": [
          { "key": "XS" },
          { "key": "S" },
          { "key": "M" },
          { "key": "L" },
          { "key": "XL" }
        ]
      }
    ]
  }
```

The `id` from the response is the product template ID. Use it as `{{product_template_Id}}` in the next step.
{% endstep %}

{% step %}
### Create a parent variant product

Variants are created automatically whenever their parent variant product is created or updated. The combinations of variants are created based on the attributes defined in the product template applied to the parent variant, and the attributes and values specified in the `variantAttributes` field of the parent variant.

Before you start, ensure that the `skipVariantGeneration` parameter is set to `false`.

{% hint style="warning" %}
When creating or updating a product of the `PARENT_VARIANT` type, by default, product variants are generated. If you do **not** want to create product variants for the product, set the `skipVariantGeneration` parameter to `true`.
{% endhint %}

{% hint style="warning" %}
The product template can contain more attributes and values than are needed to create a parent variant. In the `variantAttributes` field, specify the attributes and values from the product template that are relevant to the particular parent variant product and its variants.
{% endhint %}

To create a single `parent_variant` type of product with variants, send a request to the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/products?skipVariantGeneration=false&doIndex=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
  "name": "T-shirt with variants",
  "code": "PARENT001",
  "description": "Plain cotton T-shirt.",
  "published": false,
  "taxClasses": {
    "EN": "STANDARD"
  },
  "productType": "PARENT_VARIANT",
  "template": {
    "id": "{{product_template_Id}}",
    "version": 1
  },
  "variantAttributes": {
    "color": [
      { "key": "RED" },
      { "key": "GREEN" },
      { "key": "BLUE" }
    ],
    "size": [
      { "key": "XS" },
      { "key": "S" },
      { "key": "M" },
      { "key": "L" },
      { "key": "XL" }
    ]
  }
}
```
{% endstep %}

{% step %}
### Optional: Create multiple parent variant products 

If you want to create multiple `parent_variant` products at the same time, send a request to the [Creating multiple products](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-bulk) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST 
  'https://api.emporix.io/product/{tenant}/products/bulk?skipVariantGeneration=false&doIndex=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '[
  {
    "id": "abc-123",
    "code": "532432412331",
    "name": "Dress 1 with variants",
    "productType": "PARENT_VARIANT",
    "description": "Plain cotton dress",
    "published": false,
    "taxClasses": {
      "EN": "STANDARD"
    },
    "template": {
      "id": "{{product_template_Id}}",
      "version": 1
    },
    "variantAttributes": {
      "color": [
        { "key": "RED" },
        { "key": "GREEN" },
        { "key": "BLUE" }
      ],
      "size": [
        { "key": "XS" },
        { "key": "S" },
        { "key": "M" },
        { "key": "L" },
        { "key": "XL" }
      ]
    }
  },
  {
    "id": "abc-124",
    "code": "532432412332",
    "name": "Dress 2 with variants",
    "productType": "PARENT_VARIANT",
    "description": "Pleaded cotton dress",
    "published": false,
    "taxClasses": {
      "EN": "STANDARD"
    },
    "template": {
      "id": "{{product_template_Id}}",
      "version": 1
    },
    "variantAttributes": {
      "color": [
        { "key": "RED" },
        { "key": "GREEN" },
        { "key": "BLUE" }
      ],
      "size": [
        { "key": "XS" },
        { "key": "S" },
        { "key": "M" },
        { "key": "L" },
        { "key": "XL" }
      ]
    }
  },
  {
    "id": "abc-125",
    "code": "532432412336",
    "name": "Dress 3 with variants",
    "productType": "PARENT_VARIANT",
    "description": "Cotton dress with lace",
    "published": false,
    "taxClasses": {
      "EN": "STANDARD"
    },
    "template": {
      "id": "{{product_template_Id}}",
      "version": 1
    },
    "variantAttributes": {
      "color": [
        { "key": "RED" },
        { "key": "GREEN" },
        { "key": "BLUE" }
      ],
      "size": [
        { "key": "XS" },
        { "key": "S" },
        { "key": "M" },
        { "key": "L" },
        { "key": "XL" }
      ]
    }
  }
]'
```
{% endstep %}
{% endstepper %}

## How to create variants with new attributes and values

If you want to create variants by adding new variant attributes and/or values for a parent variant, perform the following steps.

{% hint style="warning" %}
You can add new attribute values either by adding them to the product template and then updating the product, or by updating the product with new values under `variantAttributes`, if they already exist in the product template.
{% endhint %}

{% hint style="warning" %}
The `product.product_publish` scope is only required if you want to publish the product on its creation.
{% endhint %}

{% stepper %}
{% step %}
### Update a product template with new attributes and values

To add new variant attribute values to your product template, update the template by calling the [Updating a product template](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/product-templates#put-product-tenant-product-templates-product-template-id) endpoint. In this example, we add `PURPLE` to the existing `color` attribute values.

{% hint style="warning" %}
Each of the attributes has its own metadata element, where you can specify whether the attribute is mandatory, if it can be used as a variant attribute, and what its default value is.
{% endhint %}

```bash
curl -i -X PUT 
  'https://api.emporix.io/product/{tenant}/product-templates/{product-template-id}' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
  "name": {
    "en": "T-shirt"
  },
  "attributes": [
    {
      "key": "color",
      "name": {
        "en": "Color",
        "pl": "Kolor"
      },
      "type": "TEXT",
      "metadata": {
        "mandatory": false,
        "variantAttribute": true,
        "defaultValue": null
      },
      "values": [
        { "key": "GREEN" },
        { "key": "RED" },
        { "key": "BLUE" },
        { "key": "PURPLE" }
      ]
    },
    {
      "key": "discount",
      "name": {
        "en": "Discount"
      },
      "type": "NUMBER",
      "metadata": {
        "mandatory": false,
        "defaultValue": 0
      },
      "values": [
        { "key": 0 },
        { "key": 30 },
        { "key": 40 },
        { "key": 50 },
        { "key": 60 }
      ]
    },
    {
      "key": "size",
      "name": {
        "en": "Size",
        "pl": "Rozmiar"
      },
      "type": "TEXT",
      "metadata": {
        "mandatory": false,
        "variantAttribute": true,
        "defaultValue": null
      },
      "values": [
        { "key": "XS" },
        { "key": "S" },
        { "key": "M" },
        { "key": "L" },
        { "key": "XL" }
      ]
    }
  ],
  "metadata": {
    "version": 1
  }
}
```
{% endstep %}

{% step %}
### Update the existing parent variant product with the new product template

Since updating the product template results in it being assigned a new version, update the parent variant by sending a request to the [Partially updating a product endpoint](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) and providing the new `template.version` value.

{% hint style="warning" %}
In the `variantAttributes` field, specify the attributes and attribute values that the variant products will assume. Based on the specified attributes, variant product combinations will be created automatically.
{% endhint %}

{% hint style="warning" %}
When creating or updating a product of the `PARENT_VARIANT` type, by default, product variants are generated. If you do **not** want to create product variants for the product, set the `skipVariantGeneration` parameter to `true`.
{% endhint %}

```bash
curl -i -X PATCH 
  'https://api.emporix.io/product/{tenant}/products/{productId}?skipVariantGeneration=false&doIndex=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "published": true,
    "template": {
      "id": "{{product_template_Id}}",
      "version": 2
    },
  "variantAttributes": {
    "color": [
      { "key": "GREEN" },
      { "key": "RED" },
      { "key": "BLUE" },
      { "key": "PURPLE" }
    ],
    "size": [
      { "key": "XS" },
      { "key": "S" },
      { "key": "M" },
      { "key": "L" },
      { "key": "XL" }
    ]
  }
}
```

As a result, new product variants are created automatically, in combinations that include the newly specified attributes and values.
{% endstep %}
{% endstepper %}

## How to override variant attribute values

You may choose to update the basic fields of a particular variant, for example `name`, `description`, or `relatedItems`.

{% hint style="warning" %}
The `product.product_publish` and `product.product_unpublish` scopes are only required if you want to publish or unpublish the product on its update.
{% endhint %}

{% stepper %}
{% step %}
### Updating a variant with new attribute values

By default, all variant products inherit their attributes from the parent variant. You need to include the name of the attribute in the `metadata.overridden` field to be able to replace the attribute values.

{% hint style="warning" %}
You cannot override the following attributes: `id`, `code`, `template`, `variantAttributes`.
{% endhint %}

{% hint style="warning" %}
The `parentVariantId` field cannot be updated. It can only be set when creating a new variant product. When updating an existing variant, this field should be omitted or will be ignored if included.
{% endhint %}

Update a specific variant product by sending a request to the [Upserting a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid) endpoint.

In the following example, we override the following fields:

* `published`
* `taxClasses`

```bash
curl -i -X PUT 
  'https://api.emporix.io/product/{tenant}/products/{productId}?partial=false&skipVariantGeneration=false&doIndex=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "Blue T-shirt M",
    "code": "VARIANT001",
    "description": "The best T-shirt ever.",
    "published": true,
    "taxClasses": {
        "EN": "STANDARD",
        "PL": "STANDARD"
    },
    "productType": "VARIANT",
    "relatedItems": [
        {
        "refId": "634cea2740033d7c2e7b03a9",
        "type": "CONSUMABLE"
        }
    ],
    "metadata": {
        "version": 1,
        "overridden": [
        "published",
        "taxClasses"
        ]
    },
    "mixins": {
        "productVariantAttributes": {
        "color": "BLUE",
        "size": "M"
        }
    }
}
```
{% endstep %}
{% endstepper %}

## How to work with dynamic variant products

Dynamic variants let you build flexible, multi-level product hierarchies without a fixed attribute template. Each variant in the tree is an independent product that declares only its own distinguishing attributes. The API provides a full picture including accumulated attributes, inherited values, and a ready-to-use variant map. With this, your storefront receives complete, up-to-date data with a single API call.

Compared with standard variants (`PARENT_VARIANT` / `VARIANT`), dynamic variants do not require a predefined shared variant template and support deeper, flexible hierarchies where each level can introduce different attribute dimensions. Standard variants are better for fixed, predictable option sets (for example, size and color only), while dynamic variants are better when hierarchy depth or variant dimensions can change over time.

{% hint style="info" %}
Dynamic variants are designed for catalogs where the variant structure is not known in advance or where variants are loaded in bulk from an external system. For simpler, template-driven variants, use the `PARENT_VARIANT` / `VARIANT` product types instead.
{% endhint %}

### Key features

| Key feature | Description |
|---|---|
| **No template required** | Each variant defines its own attributes directly on the product. You can introduce new attribute dimensions at any level without modifying a shared template. |
| **Order-independent ingestion** | Variants can be created in any order - a child can exist before its parent. This is essential for bulk catalog imports where the full tree is not available in a single pass. After the import completes, a single recalculation call rebuilds the entire tree. |
| **Single API call for the storefront** | Fetching the root product returns a `variants` map containing every descendant with fully accumulated attributes - parent attributes merged into child entries. The storefront never needs to make additional calls to resolve the complete attribute combination for a sellable variant. |
| **Ready-to-render variant selectors** | The `variants` map on the root product is a flat map keyed by variant ID. Each entry carries `variantAttributes` (accumulated), `name` (localized), `sellable`, `dynamicVariantType`, and `parentVariantId`. This gives your product page everything it needs to render multi-step variant selectors (for example, "Storage -> Color -> Bundle") without any client-side tree reconstruction. |
| **Delta storage, no cascading writes** | Each variant stores only the attributes it introduces at its own level (`ownVariantAttributes`). Changing a mid-level variant attribute updates only that variant's entry on each ancestor. |
| **Hierarchy integrity signals** | The `metadata.dynamicVariantInfo` field on any product response surfaces broken chains (`missingAncestorId`) or circular references (`cycleDetected`) so you can detect and fix data issues proactively. |

### The variant tree model

A `DYNAMIC_VARIANT` hierarchy is a tree of independent products:

```
Root product (DYNAMIC_VARIANT, no parentVariantId)
  └── L1 variant  (parentVariantId → root, dynamicVariantType: H1_L1, sellable: false)
        ├── L2 leaf  (parentVariantId → L1, dynamicVariantType: H1_L2, sellable: true)
        └── L2 leaf  (parentVariantId → L1, dynamicVariantType: H1_L2, sellable: true)
```

- **Root product** - holds a denormalized `variants` map of all descendants. In API responses each entry's `variantAttributes` contains accumulated (fully merged) attributes.
- **Child products** - expose `ownVariantAttributes` (what is stored on this product, writable) and `inheritedVariantAttributes` (merged from ancestors, read-only).
- `parentVariantPath` array — carried by every child, it's an ordered list of ancestor IDs from direct parent (index 0) to root (last index).
- `sellable` flag - marks variants that can be added to a cart. Non-sellable intermediate variants exist only to group attributes.

### Creating dynamic variants

{% stepper %}
{% step %}
### Create the root product

The root is a `DYNAMIC_VARIANT` product with no `parentVariantId`. It acts as the anchor for the entire tree and is the product your storefront links to.
To create the root product, call the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/product/{tenant}/products' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "mobile-15-pro",
    "name": {
      "en": "Mobile Phone 15 Pro",
      "deDE": "Mobile Phone 15 Pro"
    },
    "code": "MOBILE-15-PRO",
    "description": {
      "en": "Flagship smartphone with titanium design and advanced camera system.",
      "deDE": "Flaggschiff-Smartphone mit Titan-Design und fortschrittlichem Kamerasystem."
    },
    "published": true,
    "taxClasses": { "EN": "STANDARD" },
    "productType": "DYNAMIC_VARIANT"
  }'
```

{% endstep %}

{% step %}
### Create L1 variant products

To create an L1 variant product, call the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

L1 variants are direct children of the root. Set `parentVariantId` to the root product ID and declare the attributes that distinguish this variant from the root in `ownVariantAttributes`. Set `sellable: false` if this variant is an intermediate grouping level.

Each attribute value uses the `dynamicVariantAttribute` structure:
- `name` - localized display label for the attribute itself
- `value.type` - `STRING`, `NUMBER`, `DECIMAL`, or `BOOLEAN`
- `value.qualifier` - the canonical value used for matching and filtering
- `value.name` - localized display label for the selected value
- `value.unit` - optional unit code for measurement attributes (for example, `"MMT"` for millimetres)

```bash
curl -i -X POST \
  'https://api.emporix.io/product/{tenant}/products' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "mobile-15-pro-l1",
    "name": { "en": "Mobile Phone 15 Pro – 256 GB Blue", "deDE": "Mobile Phone 15 Pro – 256 GB Blau" },
    "code": "MOBILE-15-PRO-L1",
    "published": true,
    "taxClasses": { "EN": "STANDARD" },
    "productType": "DYNAMIC_VARIANT",
    "parentVariantId": "mobile-15-pro",
    "dynamicVariantType": "H1_L1",
    "sellable": false,
    "ownVariantAttributes": {
      "storageCapacity": {
        "name": { "en": "Storage", "deDE": "Speicher" },
        "value": {
          "type": "STRING",
          "qualifier": "256_GB",
          "name": { "en": "256 GB", "deDE": "256 GB" }
        }
      },
      "colorFinish": {
        "name": { "en": "Color", "deDE": "Farbe" },
        "value": {
          "type": "STRING",
          "qualifier": "BLUE",
          "name": { "en": "Blue Titanium", "deDE": "Blau Titan" }
        }
      },
      "displaySize": {
        "name": { "en": "Display size", "deDE": "Displaygröße" },
        "value": {
          "type": "DECIMAL",
          "qualifier": 6.1,
          "unit": "INH",
          "name": { "en": "6.1 in", "deDE": "6,1 Zoll" }
        }
      }
    }
  }'
```

{% endstep %}

{% step %}
### Create L2 leaf variants

To create an L2 variant product, call the [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

L2 variants are children of L1 variants. They declare only the attributes they introduce at their own level, the L1 attributes are inherited automatically. Set `sellable: true` on variants that can be purchased.

```bash
curl -i -X POST \
  'https://api.emporix.io/product/{tenant}/products' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "mobile-15-pro-l2-retail",
    "name": { "en": "Mobile Phone 15 Pro – 256 GB Blue – Retail box", "deDE": "Mobile Phone 15 Pro – 256 GB Blau – Einzelhandelsbox" },
    "code": "MOBILE-15-PRO-L2-RETAIL",
    "published": true,
    "taxClasses": { "EN": "STANDARD" },
    "productType": "DYNAMIC_VARIANT",
    "parentVariantId": "mobile-15-pro-l1",
    "dynamicVariantType": "H1_L2",
    "sellable": true,
    "ownVariantAttributes": {
      "bundleType": {
        "name": { "en": "Bundle", "deDE": "Bundle" },
        "value": {
          "type": "STRING",
          "qualifier": "RETAIL_BOX",
          "name": { "en": "Retail box", "deDE": "Einzelhandelsbox" }
        }
      }
    }
  }'
```

{% endstep %}

{% step %}
### Retrieve the root product - the storefront view

To retrieve the root product with its complete variant tree, call the [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid) endpoint. The `variants` map on the root contains every descendant with accumulated attributes, each entry already has its own attributes merged with all ancestor attributes up the chain.

```bash
curl -i -X GET \
  'https://api.emporix.io/product/{tenant}/products/mobile-15-pro' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

The response includes a `variants` map ready for your storefront:

```json
{
  "id": "mobile-15-pro",
  "productType": "DYNAMIC_VARIANT",
  "name": { "en": "Mobile Phone 15 Pro" },
  "variants": {
    "mobile-15-pro-l1": {
      "version": 1,
      "name": { "en": "Mobile Phone 15 Pro – 256 GB Blue" },
      "parentVariantId": "mobile-15-pro",
      "sellable": false,
      "dynamicVariantType": "H1_L1",
      "variantAttributes": {
        "storageCapacity": {
          "name": { "en": "Storage" },
          "value": { "type": "STRING", "qualifier": "256_GB", "name": { "en": "256 GB" } }
        },
        "colorFinish": {
          "name": { "en": "Color" },
          "value": { "type": "STRING", "qualifier": "BLUE", "name": { "en": "Blue Titanium" } }
        },
        "displaySize": {
          "name": { "en": "Display size" },
          "value": { "type": "DECIMAL", "qualifier": 6.1, "unit": "INH", "name": { "en": "6.1 in" } }
        }
      }
    },
    "mobile-15-pro-l2-retail": {
      "version": 1,
      "name": { "en": "Mobile Phone 15 Pro – 256 GB Blue – Retail box" },
      "parentVariantId": "mobile-15-pro-l1",
      "sellable": true,
      "dynamicVariantType": "H1_L2",
      "variantAttributes": {
        "storageCapacity": {
          "name": { "en": "Storage" },
          "value": { "type": "STRING", "qualifier": "256_GB", "name": { "en": "256 GB" } }
        },
        "colorFinish": {
          "name": { "en": "Color" },
          "value": { "type": "STRING", "qualifier": "BLUE", "name": { "en": "Blue Titanium" } }
        },
        "displaySize": {
          "name": { "en": "Display size" },
          "value": { "type": "DECIMAL", "qualifier": 6.1, "unit": "INH", "name": { "en": "6.1 in" } }
        },
        "bundleType": {
          "name": { "en": "Bundle" },
          "value": { "type": "STRING", "qualifier": "RETAIL_BOX", "name": { "en": "Retail box" } }
        }
      }
    }
  }
}
```

Notice that `mobile-15-pro-l2-retail` (L2) already contains `storageCapacity`, `colorFinish`, and `displaySize` from its L1 parent - even though those attributes are not stored on the L2 product itself.

{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

### Using the variants map on the storefront

The `variants` map gives your product page everything it needs to build a variant selector UI without additional API calls:

1. Group by `dynamicVariantType` to determine the selection steps (e.g. first choose `H1_L1`, then `H1_L2`).
2. Filter by `parentVariantId` to show only the children of the currently selected variant.
3. Read `variantAttributes` on each entry to render the selector labels and values - all attributes are already accumulated, so an L2 entry shows all dimensions the customer needs to see.
4. Check `sellable: true` to identify which variants can be added to a cart. Non-sellable intermediate variants are grouping nodes only.
5. Use `name` (localized) for display in search results, breadcrumbs, or option labels.

### Retrieving a child product - own versus inherited attributes

When you fetch a child product directly, the response separates its attributes into two maps:

- `ownVariantAttributes` - the attributes stored on this product. These are writable: you can change them via PUT or PATCH.
- `inheritedVariantAttributes` - the attributes inherited from ancestor products. These are read-only on this product. To change an inherited attribute, update the ancestor that owns it.
To retrieve a child product, call the [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid) endpoint.

```bash
curl -i -X GET \
  'https://api.emporix.io/product/{tenant}/products/mobile-15-pro-l2-retail' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

```json
{
  "id": "mobile-15-pro-l2-retail",
  "productType": "DYNAMIC_VARIANT",
  "parentVariantId": "mobile-15-pro-l1",
  "parentVariantPath": ["mobile-15-pro", "mobile-15-pro-l1"],
  "dynamicVariantType": "H1_L2",
  "sellable": true,
  "ownVariantAttributes": {
    "bundleType": {
      "name": { "en": "Bundle" },
      "value": { "type": "STRING", "qualifier": "RETAIL_BOX", "name": { "en": "Retail box" } }
    }
  },
  "inheritedVariantAttributes": {
    "storageCapacity": {
      "name": { "en": "Storage" },
      "value": { "type": "STRING", "qualifier": "256_GB", "name": { "en": "256 GB" } }
    },
    "colorFinish": {
      "name": { "en": "Color" },
      "value": { "type": "STRING", "qualifier": "BLUE", "name": { "en": "Blue Titanium" } }
    },
    "displaySize": {
      "name": { "en": "Display size" },
      "value": { "type": "DECIMAL", "qualifier": 6.1, "unit": "INH", "name": { "en": "6.1 in" } }
    }
  }
}
```
{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

### Updating a dynamic variant

To update a variant's own attributes, send a PUT or PATCH request with the new `ownVariantAttributes`. Only the attributes in `ownVariantAttributes` are accepted - any attempt to modify `inheritedVariantAttributes` is ignored.
To update a dynamic variant, call the [Upserting a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#put-product-tenant-products-productid) endpoint.

For a single product write, the `variants` map on all ancestor products is updated synchronously and inline — no recalculation job is needed.

```bash
curl -i -X PUT \
  'https://api.emporix.io/product/{tenant}/products/mobile-15-pro-l1' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": { "en": "Mobile Phone 15 Pro – 256 GB Blue", "deDE": "Mobile Phone 15 Pro – 256 GB Blau" },
    "code": "MOBILE-15-PRO-L1",
    "published": true,
    "taxClasses": { "EN": "STANDARD" },
    "productType": "DYNAMIC_VARIANT",
    "dynamicVariantType": "H1_L1",
    "sellable": false,
    "ownVariantAttributes": {
      "storageCapacity": {
        "name": { "en": "Storage", "deDE": "Speicher" },
        "value": {
          "type": "STRING",
          "qualifier": "256_GB",
          "name": { "en": "256 GB", "deDE": "256 GB" }
        }
      },
      "colorFinish": {
        "name": { "en": "Color", "deDE": "Farbe" },
        "value": {
          "type": "STRING",
          "qualifier": "BLUE",
          "name": { "en": "Blue Titanium", "deDE": "Blau Titan" }
        }
      },
      "displaySize": {
        "name": { "en": "Display size", "deDE": "Displaygröße" },
        "value": {
          "type": "DECIMAL",
          "qualifier": 6.1,
          "unit": "INH",
          "name": { "en": "6.1 in", "deDE": "6,1 Zoll" }
        }
      },
      "batteryCapacityMah": {
        "name": { "en": "Battery capacity", "deDE": "Akku-Kapazität" },
        "value": {
          "type": "NUMBER",
          "qualifier": 3274,
          "unit": "MAH",
          "name": { "en": "3274 mAh", "deDE": "3274 mAh" }
        }
      }
    }
  }'
```

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

## How to recalculate dynamic variant trees after a bulk import

When importing large catalogs, variants are often created in arbitrary order — a child product may be written before its parent exists. In this case the inline synchronous update is skipped for products whose parent is not yet present. After the full batch has been ingested, trigger an asynchronous recalculation to rebuild all variant trees.

{% hint style="warning" %}
Call the recalculation endpoint **after** the entire batch has been ingested, not per individual product write. For single product writes the tree is updated synchronously and no recalculation is needed.
{% endhint %}

{% stepper %}
{% step %}
### Trigger recalculation

To trigger recalculation, call the [Triggering dynamic variant recalculation](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products-recalculate) endpoint with a list of up to 1000 product IDs at any hierarchy level. You do not need to know which products are roots, the system resolves the root for each submitted ID automatically and creates one job per unique root product.

```bash
curl -i -X POST \
  'https://api.emporix.io/product/{tenant}/products/recalculate' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "productIds": [
      "mobile-15-pro-l1",
      "mobile-15-pro-l2-retail",
      "mobile-16-pro-l1"
    ]
  }'
```

The response is `202 Accepted` with one job per unique root product resolved from the submitted IDs:

```json
{
  "jobs": [
    {
      "id": "job-a1b2c3d4-e5f6-7890-abcd-ef1234567890",
      "parentRoot": "mobile-15-pro",
      "requestedByIds": [
        "mobile-15-pro-l1",
        "mobile-15-pro-l2-retail"
      ],
      "status": "PENDING",
      "createdAt": "2024-01-15T10:10:00.000Z",
      "processingStartedAt": null,
      "finishedAt": null,
      "error": null,
      "attempts": 0
    },
    {
      "id": "job-b2c3d4e5-f6a7-8901-bcde-f12345678901",
      "parentRoot": "mobile-16-pro",
      "requestedByIds": ["mobile-16-pro-l1"],
      "status": "PENDING",
      "createdAt": "2024-01-15T10:10:00.000Z",
      "processingStartedAt": null,
      "finishedAt": null,
      "error": null,
      "attempts": 0
    }
  ],
  "skippedProductIds": []
}
```

If a recalculation job for a given root is already `PENDING` or `PROCESSING`, the affected IDs are returned in `skippedProductIds` and the existing job is referenced in the `jobs` list. This prevents duplicate concurrent recalculations of the same tree.

{% endstep %}

{% step %}
### Poll for job completion

Use the job ID from the response and call the [Retrieving a recalculation job](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-recalculate-jobs-jobid) endpoint to poll for completion. Jobs move through the following lifecycle:

| Status | Meaning |
|---|---|
| `PENDING` | Job created, waiting to be picked up by a subscriber |
| `PROCESSING` | A subscriber has started rebuilding the variant tree |
| `FINISHED` | Tree rebuilt successfully |
| `FAILED` | Processing failed; may be retried |
| `FAILED_PERMANENT` | Processing failed permanently; manual intervention required |

```bash
curl -i -X GET \
  'https://api.emporix.io/product/{tenant}/products/recalculate/jobs/job-a1b2c3d4-e5f6-7890-abcd-ef1234567890' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

A finished job:

```json
{
  "id": "job-a1b2c3d4-e5f6-7890-abcd-ef1234567890",
  "parentRoot": "mobile-15-pro",
  "requestedByIds": [
    "mobile-15-pro-l1",
    "mobile-15-pro-l2-retail"
  ],
  "status": "FINISHED",
  "createdAt": "2024-01-15T10:10:00.000Z",
  "processingStartedAt": "2024-01-15T10:10:03.000Z",
  "finishedAt": "2024-01-15T10:10:07.000Z",
  "error": null,
  "attempts": 1
}
```

A failed job includes an `error` message and the number of `attempts` made:

```json
{
  "id": "job-c3d4e5f6-a7b8-9012-cdef-123456789012",
  "parentRoot": "mobile-17-pro",
  "status": "FAILED",
  "error": "Database write timeout during variant tree update",
  "attempts": 3,
  "finishedAt": "2024-01-15T10:08:12.000Z"
}
```

Returns `404` if the job does not exist or has been automatically removed. Jobs are retained for approximately 30 days after reaching a terminal state (`FINISHED`, `FAILED`, or `FAILED_PERMANENT`).

{% endstep %}

{% step %}
### List all jobs (optional)

To monitor the overall import progress, call the [Listing recalculation jobs](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-recalculate-jobs) endpoint. Filter by `status` to focus on jobs that need attention.

```bash
curl -i -X GET \
  'https://api.emporix.io/product/{tenant}/products/recalculate/jobs?status=PENDING' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

Available status filter values: `PENDING`, `PROCESSING`, `FINISHED`, `FAILED`, `FAILED_PERMANENT`.

{% endstep %}
{% endstepper %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

### Recommended bulk import workflow

{% stepper %}
{% step %}
### Import all products 
Import all the products, root + all variant levels, using the `POST /products` or `POST /products/bulk`. Variants may arrive in any order.
{% endstep %}

{% step %}
### Do the recalculation
After the full batch is complete, call `POST /products/recalculate` with all imported IDs.
{% endstep %}

{% step %}
### Retrieve the job details
Poll `GET /products/recalculate/jobs/{jobId}` until status is `FINISHED`.
{% endstep %}

{% step %}
### Fetch the root product
The `variants` map is now fully populated and ready for the storefront.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
The `attempts` field on a job tracks how many times the subscriber has attempted processing. If `status` is `FAILED` and `attempts` is greater than 1, the system has already retried. A `FAILED_PERMANENT` status indicates the job is not retried automatically and requires investigation.
{% endhint %}

## How to handle classification of products

Classification categories allow you to organize products with consistent attributes across your catalog. By assigning products to classification categories, they automatically receive reusable attribute schemas that ensure data quality and consistency while reducing manual work.

### Creating a product with classification mixins

To create a product with classification mixins, assign it first to a classification category and then update it with classification mixin attributes.

{% stepper %}
{% step %}
### Assign your product to classification category

Assign the product to a classification category using the [Assigning a resource to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#post-category-tenant-categories-categoryid-assignments) endpoint:

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/category/{tenant}/categories/0720b75e-ee1c-4d76-9f53-eb3af3927e13/assignments' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "ref": {
      "id": "product-123",
      "type": "PRODUCT"
    }
  }
```
{% endstep %}

{% step %}
### Update product with classification mixin attributes

Update the product with classification mixin attributes using the [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) endpoint. Use the `mixinPath` from the classification category's `classificationMixins` field:

```bash
curl -L 
  --request PATCH 
  --url 'https://api.emporix.io/product/{tenant}/products/product-123' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json' 
  --data '{
    "mixins": {
      "productCustomAttributes": {
        "orderUnit": "H87",
        "minOrderQuantity": 1
      },
      "class_EA673_toolsClassification": {
        "powerSource": "battery",
        "voltage": "18V"
      },
      "class_EA677_cordedToolsClassification": {
        "chuckSize": "13mm",
        "maxTorque": "50Nm"
      }
    },
    "metadata": {
      "version": 1
    }
  }
```

{% hint style="info" %}
When updating a product with classification mixins, you don't need to provide the schema URL in `metadata.mixins` for classification mixins. The system automatically populates these schema URLs based on the product's category assignments.
{% endhint %}
{% endstep %}
{% endstepper %}

### Product response with classification mixins

To retrieve a product that is assigned to a classification category, send a request to the [Retrieving a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#get-product-tenant-products-productid) endpoint. The response includes the `classificationMixins` field in the metadata:

```bash
curl -L 
  --request GET 
  --url 'https://api.emporix.io/product/{tenant}/products/product-123' 
  --header 'X-Version: v2' 
  --header 'Content-Type: application/json'
```

The response includes the `classificationMixins` field:

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
    "class_EA673_toolsClassification": {
      "powerSource": "battery",
      "voltage": "18V"
    },
    "class_EA677_cordedToolsClassification": {
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
        "mixinPath": "class_EA673_toolsClassification",
        "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
        "usedSchemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
        "obsoleteSchemaUrlUsed": false,
        "required": false,
        "sourceCategoryId": "7d2b0d76-3628-46b3-ac92-34c903f5c3cb"
      },
      {
        "name": "cordedToolsClassification",
        "mixinPath": "class_EA677_cordedToolsClassification",
        "schemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v2.json",
        "usedSchemaUrl": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
        "obsoleteSchemaUrlUsed": true,
        "required": false,
        "sourceCategoryId": "0720b75e-ee1c-4d76-9f53-eb3af3927e13"
      }
    ],
    "mixins": {
      "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/productCustomAttributesMixIn-v38.json",
      "class_EA673_toolsClassification": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/toolsClassification_v1.json",
      "class_EA677_cordedToolsClassification": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/cordedTools_v1.json"
    }
  } 
}
```

{% hint style="info" %}

To learn about the end-to-end flow for implementing classification in your B2B commerce platform, along with the category service , see the [Classification tutorial](../../catalogs-and-categories/category-tree/classification.md).

{% endhint %}