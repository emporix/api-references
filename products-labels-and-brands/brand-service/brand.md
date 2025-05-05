---
seo:
  title: Brand Service Tutorials
  description: brands, brands, logo, logos
---

# How to create a brand with media files

To create a brand with media files and add it to a product created beforehand, follow the process below:

1. [Upload brand images](#upload-an-image).
2. [Create a brand with media files](#create-a-brand).
3. [Update an existing product with brand information](#update-an-existing-product-with-brand-information).

# Before you start

Ensure that you have created a product. 

{% hint style="warning" %}

For instructions, check out [*How to add your first product*](/content/product/#how-to-add-your-first-product).

{% endhint %}

# Upload an image

To include an image for a brand, first you need to upload the image to the database by sending a multipart request to the <nobr><Button to="/openapi/brand/#operation/POST-brand-add-media" size="small">Adding an image for a brand</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  https://api.emporix.io/media \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: multipart/form-data' \
  -F file=string \
  -F 'metadata=Image metadata json'
```

{% hint style="warning" %}

Note down the values of the `link` and `id` attributes from the response. You will need this information to create a brand.

{% endhint %}

# Create a brand

To create a brand and add media files to it, you need to send a request to the <nobr><Button to="/openapi/brand/#operation/POST-brand-create-brand" size="small">Adding a new brand</Button></nobr> endpoint. 

{% hint style="warning" %}

In the following request, you will use the `link` and `id` elements received in the response in the [Upload an image](#upload-an-image) step:

* The `image` element in the request below must have the same value as the `link` attribute in the response in the previous step.
* The `cloudinaryUrl` element in the request below must have the same value as the `id` attribute in the response in the previous step.

{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  https://api.emporix.io/brands \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: en' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": " ",
    "name": "Sample brand",
    "description": "Description of the sample brand.",
    "localizedName": {
      "en": "Brand one",
      "de": "Marke einz"
    },
    "localizedDescription": {
      "en": "Description of <strong>Brand one</strong> in HTML.",
      "de": "Beschreibung der <strong>Marke einz</strong> in HTML."
    },
    "image": " ",
    "cloudinaryUrl": " "
  }'
```

# Update an existing product with brand information

To specify a brand for a product, you need to provide the `id` of the brand in the `mixins` element of a chosen product. You can add brands either during the creation of the product, or by updating a product that already exists in the system. For the purposes of this tutorial, we are going to update an existing product with the brand object created above.

To update the existing product with brand information, you need to send a request to the <nobr><Button to="/openapi/product/#operation/PATCH-product-update-product" size="small">Partially updating a product</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X PATCH \
  'https://api.emporix.io/product/{tenant}/products/{productId}?skipVariantGeneration=false&doIndex=true' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
  -d '{
    "published": true,
    "mixins": {
      "productCustomAttributes": {
        "brand": " "
      }
    }
  }'
```