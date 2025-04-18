---
seo:
  title: Label Service Tutorials
  description: Label Management
---
import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Label Service Tutorials

## How to add a label to a product

To label a product with a specific information, follow these steps:
1. Add a label image
2. Create a label
3. Update a product with the label information

### Add a label image

Firstly, create and add an image for a new label. Design the image and upload it to your media repository. Send a request to the <nobr><Button to="/openapi/media/#operation/POST-media-create-asset" size="small">Creating an asset</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="media"
  operationId="POST-media-create-asset"
/>

### Create a label

To create a new label, send the request to the <nobr><Button to="/openapi/label/#operation/POST-label-create-label" size="small">Creating a label</Button></nobr> endpoint using the image you created.

<OpenApiTryIt
  definitionId="label"
  operationId="POST-label-create-label"
  properties={{
        name: "Worldwide Shipping",
        description: "<p>Worldwide Shipping</p>",
        image: "https://res.cloudinary.com/saas-ag/image/upload/v1728023450/tenant/labels/0a075c00-3893-47e7-b0d7-84f9ba7e339a.jpg",
        cloudinaryUrl: "tenant/labels/0a075c00-3893-47e7-b0d7-84f9ba7e339a"
  }}
/>

Copy the label id from the response to provide it in the next step.

### Update a product with a new label

You can now update a product with a newly created label to indicate that shipping is available worldwide for this product. Send the request to the <nobr><Button to="/openapi/product/#operation/PUT-product-update-product" size="small">Upserting a product</Button></nobr> endpoint and provide the label id in the request.

<OpenApiTryIt
  definitionId="product"
  operationId="PUT-product-update-product"
  properties={{
        labelIds: ["66fe65e83132e30001e6be29"]
  }}
/>

As a result, the product is marked with a new label. 

