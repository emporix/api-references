---
seo:
  title: Label Service Tutorials
  description: Label Management
icon: graduation-cap
layout:
  width: wide
---

# Label Tutorial

## How to add a label to a product

To label a product with a specific information, follow these steps:

1. Create a label
2. Add a label image
3. Update a product with the label information

## Create a label

To create a new label, send the request to the [Creating a label](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/label-service/api-reference/label#post-labels) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST 
  https://api.emporix.io/label/labels 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Type: application/json' 
  -d '{
    "name": "Worldwide Shipment",
    "description": "<p>Worldwide Shipment</p>"
  }'
```

Executing a request to create a label returns a response that includes an "id" field, which should then be used in the next steps.

## Add a label image

Firstly, create and add an image for a new label. Design the image and upload it to your media repository. Send a request to the [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint.
The `labelId` is necessary to provide.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../media/media/api-reference/" %}
[api-reference](../../media/media/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/media/{tenant}/assets' 
  --header 'Content-Type: multipart/form-data' 
  --data '{
    "file": {
      "externalValue": "https://res.cloudinary.com/saas-ag/image/upload/v1695804155/emporix-logo-white-2f5e621206edefea6015fb4793959376_nswfbz.png"
    },
    "body": {
      "type": "BLOB",
      "access": "PUBLIC",
      "refIds": [
        {
          "id": "66fe65e83132e30001e6be29",
          "type": "LABEL"
        }
      ],
      "details": {
        "filename": "theBestImage",
        "mimeType": "image/jpg"
      }
    }
  }'
```

## Update a product with a new label

You can now update a product with a newly created label to indicate that shipping is available worldwide for this product. Send the request to the [Partially updating a product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#patch-product-tenant-products-productid) endpoint.

To specify a label for a product, you need to provide the `labelId` field on product level which should be used. You can add labels either during the creation of the product, or by updating a product that already exists in the system.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PATCH 
  'https://api.emporix.io/product/{tenant}/products/{productId}?skipVariantGeneration=false&doIndex=true' 
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' 
  -H 'Content-Language: string' 
  -H 'Content-Type: application/json' 
  -d '{
    "published": true
    "labelIds": ["66fe65e83132e30001e6be29"]
  }'
```

As a result, the product is marked with a new label.
