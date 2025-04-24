---
seo:
  title: Media Service Tutorials
  description: media and documents management
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Media Service Tutorials

You can upload or link to media files and other documents by using the Emporix Media Service. The files can be associated with specific resources within the Emporix database, 
or remain unassigned.

{% hint style="danger" %}

Currently, it is possible to assign assets to categories and products only.
{% endhint %}

## How to manage public and internal assets

The assets can either be linked to an external website where they are stored, or uploaded in the form of blob data by using a multipart/form-data request.
You can also specify the access types of the uploaded files - the public assets are files that will be visible on your business' storefront, and the private access files will be accessible only to your tenant's employees.

In the following scenario, we are going to create public and private assets for an already existing category.


{% hint style="warning" %}

Before you begin, ensure that a category with a category ID already exists. For more information, check out the [*Category Service Tutorials*](/content/category).
{% endhint %}

### Create private assets by link

To add an asset for a category, you need to send a request to the <nobr><Button to="/openapi/media/#operation/POST-media-create-asset" size="small">Creating an asset</Button></nobr> endpoint with the `media.asset_manage` scope. 
In the following example, we are creating a `private` type of an asset.

{% hint style="warning" %}

Sending a json/application request to the <nobr><Button to="/openapi/media/#operation/POST-media-create-asset" size="small">Creating an asset</Button></nobr> endpoint does **not** mean that the asset is uploaded to the database. It is only linked to the resource (category or product). 
If you want to upload the asset to the database, you need to send a multipart request to the <nobr><Button to="/openapi/media/#operation/POST-media-create-asset" size="small">Creating an asset</Button></nobr> endpoint.
{% endhint %}

<OpenApiTryIt
  definitionId="media"
  operationId="POST-media-create-asset"
  defaultExample="Asset of the LINK type added for a category"
  properties={{
      access: "PRIVATE"
      }} 
  />


### Create public assets with a blob upload 

You can create a public asset for a category, for example an image, by uploading the file and its metadata. Send a multipart request to the <nobr><Button to="/openapi/media/#operation/POST-media-create-asset" size="small">Creating an asset</Button></nobr> endpoint with the `media.asset_manage` scope. 

Check out the "Asset of the BLOB type added for a CATEGORY" example:


<OpenApiTryIt
  definitionId="media"
  operationId="POST-media-create-asset"
  defaultExample="Asset of the BLOB type added for a CATEGORY"
  />

### Retrieve assets for a given category

By providing query values, you can retrieve assets that fulfil specific criteria. 

In this example, we are going to retrieve all assets that belong to a particular category by providing a specific `categoryId` next to the `q` parameter. Send a request to the <nobr><Button to="/openapi/media/#operation/GET-media-list-assets" size="small">Retrieving all assets</Button></nobr> endpoint with the following scope: `media.asset_read`.

Provide the q parameter in the following format: `q=refIds.id:z7235vn6-5b70-4b3d-7852-7f332736a45g`, where `z7235vn6-5b70-4b3d-7852-7f332736a45g` is the category ID.


<OpenApiTryIt
  definitionId="media"
  operationId="GET-media-list-assets"
  parameters={{
      query:{
      q: "refIds.id:{categoryId}"
      }
        }} 
  />








