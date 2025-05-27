---
seo:
  title: Brand Service Tutorials
  description: brands, brands, logo, logos
icon: graduation-cap
---

# Brand Tutorial

## How to create a brand with media files

To create a brand with media files and add it to a product created beforehand, follow the process below:

1. [Create a brand](brand.md#create-a-brand)
2. [Upload brand images](brand.md#upload-an-image)
3. [Update an existing product with brand information](brand.md#update-an-existing-product-with-brand-information)

## Before you start

Ensure that you have created a product.

{% hint style="warning" %}
For instructions, check out [_How to add your first product_](../product-service/product.md#how-to-add-your-first-product).
{% endhint %}

## Create a brand

To create a brand and add media files to it, you need to send a request to the [Adding a new brand](https://developer.emporix.io/documentation-portal/api-references/products-labels-and-brands/brand-service/api-reference/brands#post-brands) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  https://api.emporix.io/brands \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: en' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Sample brand",
    "description": "Description of the sample brand.",
    "localizedName": {
        "en": "Brand one"
    },
    "localizedDescription": {
        "en": "Description of <strong>Brand one</strong> in HTML."
    }
}'
```

Executing a request to create a brand returns a response that includes an "id" field, which should then be used when uploading an image.

## Upload an image

To include an image for a brand, you need to upload the image to the database by sending a multipart request to the [Creating an asset](https://developer.emporix.io/documentation-portal/api-references/media/media/api-reference/assets#post-media-tenant-assets) endpoint.\
The `brandId` is necessary to provide.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../media/media/api-reference/" %}
[api-reference](../../media/media/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/media/{tenant}/assets' \
  --header 'Content-Type: multipart/form-data' \
  --data '{
    "file": {
      "externalValue": "https://res.cloudinary.com/saas-ag/image/upload/v1695804155/emporix-logo-white-2f5e621206edefea6015fb4793959376_nswfbz.png"
    },
    "body": {
      "type": "BLOB",
      "access": "PUBLIC",
      "refIds": [
        {
          "id": "123e06ecf0452c2d6c0b81392",
          "type": "BRAND"
        }
      ],
      "details": {
        "filename": "theBestImage",
        "mimeType": "image/jpg"
      }
    }
  }'
```

## Update an existing product with brand information

To specify a brand for a product, you need to provide the `brandId` field on product level which should be used. You can add brands either during the creation of the product, or by updating a product that already exists in the system.

To update the existing product with brand information, you need to send a request to the [Partially updating a product](https://developer.emporix.io/documentation-portal/api-references/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../product-service/api-reference/" %}
[api-reference](../product-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/product/{tenant}/products/{productId}?skipVariantGeneration=false&doIndex=true' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
  -d '{
    "published": true
    "brandId":"123e06ecf0452c2d6c0b81392"
  }'
```
