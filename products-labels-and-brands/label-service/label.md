---
seo:
  title: Label Service Tutorials
  description: Label Management
---


# Label Service Tutorials

## How to add a label to a product

To label a product with a specific information, follow these steps:
1. Add a label image
2. Create a label
3. Update a product with the label information

### Add a label image

Firstly, create and add an image for a new label. Design the image and upload it to your media repository. Send a request to the <nobr><Button to="/openapi/media/#operation/POST-media-create-asset" size="small">Creating an asset</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/media/{tenant}/assets' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: multipart/form-data' \
  -F 'file=[object Object]' \
  -F 'body=[object Object]'
```

### Create a label

To create a new label, send the request to the <nobr><Button to="/openapi/label/#operation/POST-label-create-label" size="small">Creating a label</Button></nobr> endpoint using the image you created.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  https://api.emporix.io/label/labels \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "66fe65e83132e30001e6be29",
    "name": "Worldwide Shipment",
    "description": "<p>Worldwide Shipment</p>",
    "image": "https://res.cloudinary.com/saas-ag/image/upload/v1727903960/tenant/labels/54fd0a26-fa47-45b7-ae22-8e54e0bb98d2.jpg",
    "cloudinaryUrl": "tenant/labels/54fd0a26-fa47-45b7-ae22-8e54e0bb98d2",
    "overlay": {
      "position": 0,
      "isTrue": true
    }
  }'
```

Copy the label id from the response to provide it in the next step.

### Update a product with a new label

You can now update a product with a newly created label to indicate that shipping is available worldwide for this product. Send the request to the <nobr><Button to="/openapi/product/#operation/PUT-product-update-product" size="small">Upserting a product</Button></nobr> endpoint and provide the label id in the request.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/product/{tenant}/products/{productId}?partial=false&skipVariantGeneration=false&doIndex=true' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Smartphone Zony Yperia X2",
    "code": "TESTDOC000",
    "description": "The world'\''s best camera and camcorder in a waterproof smartphone.",
    "published": false,
    "taxClasses": {
      "EN": "STANDARD"
    },
    "template": {
      "id": "634cea2740033d7c2e7b03a8",
      "version": 1
    },
    "relatedItems": [
      {
        "refId": "634cea2740033d7c2e7b03a9",
        "type": "CONSUMABLE"
      }
    ],
    "mixins": {
      "salePricesData": [
        {
          "salePriceStart": "2021-07-20T22:00:00.000+0000",
          "salePriceAmount": 6.7,
          "salePriceEnd": "2021-07-25T21:59:59.000+0000",
          "enabled": false
        }
      ],
      "productCustomAttributes": {
        "pricingMeasurePrice": 13,
        "unitPricingMeasure": {
          "value": 133,
          "unitCode": "GRM"
        },
        "unitPricingBaseMeasure": {
          "value": 100,
          "unitCode": "GRM"
        },
        "pricingMeasure": {
          "value": 100,
          "unitCode": "GRM"
        },
        "orderUnit": "H87",
        "minOrderQuantity": 2,
        "maxOrderQuantity": 10,
        "defaultOrderQuantity": 5
      }
    },
    "metadata": {
      "version": 1,
      "mixins": {
        "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json",
        "salePricesData": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/salePriceData.json"
      }
    }
  }'
```

As a result, the product is marked with a new label. 

