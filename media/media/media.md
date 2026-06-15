---
seo:
  title: Media Service Tutorials
  description: media and documents management
icon: graduation-cap
layout:
  width: wide
---

# Media Tutorial

You can upload or link to media files and other documents by using the Emporix Media Service. The files can be associated with specific resources within the Emporix database, or remain unassigned.

{% hint style="info" %}
It is possible to assign assets to `BRAND`, `CATEGORY`, `LABEL`, `PRODUCT`, `MODULE`, or any custom schema type. To associate an asset with a category or product, set `access` to `PUBLIC`. Private assets cannot be linked to categories or products.
{% endhint %}

## How to manage public and internal assets

The assets can either be linked to an external website where they are stored, or uploaded in the form of blob data by using a `multipart/form-data` request.

You can also specify the access type of each asset:

- `PUBLIC` — Stored on public storage and accessible from an external URL. Use this access type for storefront-visible media, such as category banners or product images.
- `PRIVATE` — Stored on private storage and not accessible from an external URL. Use this access type for internal documents, such as contracts or specification sheets. Private assets can only be retrieved through the [Downloading an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets-assetid-download) endpoint.

{% hint style="warning" %}
The [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint supports two request formats, each creating a different asset type:

- **`application/json`** — Creates a `LINK` asset. Provide a `url` to a file hosted externally; Emporix stores the reference, not the file itself.
- **`multipart/form-data`** — Creates a `BLOB` asset. Upload the file binary; Emporix stores the asset (max 10 MB).
{% endhint %}

## How to associate a public asset with a category

To link media to a category or product, create the asset with `"access": "PUBLIC"` and provide the target resource in `refIds`. Requests that combine `PRIVATE` access with `refIds` are rejected with a `400` response.

{% hint style="warning" %}
Before you begin, ensure that a category with a category ID already exists. For more information, check out the [Category Service Tutorials](../../catalogs-and-categories/category-tree/category.md).
{% endhint %}

### Associate a public asset by link

To add a linked asset for a category, send an `application/json` request to the [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint with the `media.asset_manage` scope.

In the following example, we create a `PUBLIC` `LINK` asset and associate it with a category.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/media/{{tenant}}/assets' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'Content-Type: application/json' \
  --data '{
    "id": "123e06ecf0452c2d6c0b81390",
    "type": "LINK",
    "access": "PUBLIC",
    "url": "https://emporix.io/docs/index.html",
    "refIds": [
      {
        "id": "123e06ecf0452c2d6c0b81392",
        "type": "CATEGORY"
      }
    ]
  }'
```

### Upload a public asset as a blob

You can create a public asset for a category, for example an image, by uploading the file and its metadata. Send a `multipart/form-data` request to the [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint with the `media.asset_manage` scope.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/media/{{tenant}}/assets' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --form 'file=@category-banner.png' \
  --form 'body={"type":"BLOB","access":"PUBLIC","refIds":[{"id":"123e06ecf0452c2d6c0b81392","type":"CATEGORY"}],"details":{"filename":"category-banner","mimeType":"image/png"}}'
```

## How to create a private internal asset

Private assets are intended for tenant-internal use and are not exposed on the storefront. Typical use cases include supplier contracts, technical specification sheets, or compliance documents that your employees need to access from the Management Dashboard or through the API.

Create a private asset without `refIds` — private assets cannot be associated with categories or products. After creation, retrieve the file through the [Downloading an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets-assetid-download) endpoint with the `media.asset_read` scope.

In the following example, we upload an internal contract as an unassociated `PRIVATE` `BLOB` asset.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/media/{{tenant}}/assets' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --form 'file=@supplier-contract.pdf' \
  --form 'body={"type":"BLOB","access":"PRIVATE","details":{"filename":"supplier-contract","mimeType":"application/pdf"}}'
```

## How to retrieve assets for a given category

By providing query values, you can retrieve assets that fulfil specific criteria.

In this example, we retrieve all assets that belong to a particular category by providing the category ID in the `q` parameter. Send a request to the [Retrieving all assets](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets) endpoint with the `media.asset_read` scope.

Provide the `q` parameter in the following format: `q=refIds.id:123e06ecf0452c2d6c0b81392`, where `123e06ecf0452c2d6c0b81392` is the category ID.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/media/{{tenant}}/assets?pageNumber=1&pageSize=60&q=refIds.id:123e06ecf0452c2d6c0b81392' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --header 'X-Total-Count: false'
```
