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
It is possible to assign assets to `BRAND`, `CATEGORY`, `LABEL`, `PRODUCT`, `MODULE`, `AGENT`, or any custom schema type. To associate an asset with a predefined resource type such as `CATEGORY` or `PRODUCT`, set `access` to `PUBLIC`. Private assets can be linked to `AGENT`, custom schema types, or remain unassigned.
{% endhint %}

## How to upload assets directly to storage

Direct upload lets your application send file bytes to the storage provider instead of through the Media API. Private blobs are stored in Google Cloud Storage (GCS), while public blobs are stored in Cloudinary.

{% hint style="warning" %}
Direct upload is enabled separately for each tenant. Contact Emporix Support to request activation before you call `POST /media/{tenant}/assets/upload-session`. Without activation, the endpoint returns `403` with `direct upload is not enabled for this tenant`, and no pending asset is created.
{% endhint %}

Use a service OAuth2 token with the `media.asset_manage` scope to create upload sessions.

An upload session creates an asset with the `PENDING` status and returns short-lived storage instructions. Follow one of these provider-specific flows:

* Private GCS signed `PUT` – omit `uploadType` or set it to `put`.
* Private GCS multipart `POST` – set `uploadType` to `form`.
* Public Cloudinary multipart `POST` – set `access` to `PUBLIC`. Cloudinary uses a form regardless of `uploadType`.

### Upload a private asset with a signed PUT

{% stepper %}
{% step %}
#### Start the upload session

Start an upload session by sending an `application/json` request to the [Starting an upload session](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets-upload-session) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/media/{{tenant}}/assets/upload-session' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "type": "BLOB",
    "access": "PRIVATE",
    "uploadType": "put",
    "details": {
      "filename": "installation-guide.pdf",
      "mimeType": "application/pdf"
    },
    "refIds": []
  }'
```

The response contains the pending asset ID and the exact storage request to send:

```json
{
  "id": "68d67e9a3f7c2b1e4a8d6501",
  "provider": "GCS",
  "status": "PENDING",
  "expiresAt": "{{UPLOAD_SESSION_EXPIRES_AT}}",
  "upload": {
    "method": "PUT",
    "url": "{{SIGNED_GCS_UPLOAD_URL}}",
    "headers": {
      "Content-Type": "application/pdf",
      "x-goog-meta-emporix-upload": "session"
    }
  }
}
```

{% endstep %}

{% step %}
#### Upload the file to GCS

Send the file to the returned `upload.url` without an Emporix access token. Copy every returned header unchanged.

```bash
curl -i -X PUT \
  '{{SIGNED_GCS_UPLOAD_URL}}' \
  -H 'Content-Type: application/pdf' \
  -H 'x-goog-meta-emporix-upload: session' \
  --upload-file 'installation-guide.pdf'
```

GCS signed upload credentials are valid for 15 minutes by default. The upload session itself expires after one hour by default.

{% endstep %}

{% step %}
#### Wait for the asset to become ready

Follow the [Wait for the uploaded asset](#wait-for-the-uploaded-asset) procedure with the returned asset ID.
{% endstep %}
{% endstepper %}

### Upload a private asset with a multipart form

{% stepper %}
{% step %}
#### Start the form upload session

Set `uploadType` to `form` to receive a signed GCS POST policy.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/media/{{tenant}}/assets/upload-session' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "type": "BLOB",
    "access": "PRIVATE",
    "uploadType": "form",
    "details": {
      "filename": "supplier-contract.pdf",
      "mimeType": "application/pdf"
    },
    "refIds": []
  }'
```

A representative response is:

```json
{
  "id": "68d67ec13f7c2b1e4a8d6502",
  "provider": "GCS",
  "status": "PENDING",
  "expiresAt": "{{UPLOAD_SESSION_EXPIRES_AT}}",
  "upload": {
    "method": "POST",
    "url": "{{GCS_MULTIPART_UPLOAD_URL}}",
    "fields": {
      "key": "{{GCS_OBJECT_KEY}}",
      "content-type": "application/pdf",
      "x-goog-meta-emporix-upload": "session",
      "success_action_status": "204",
      "x-goog-algorithm": "GOOG4-RSA-SHA256",
      "x-goog-credential": "{{GCS_CREDENTIAL}}",
      "x-goog-date": "{{GCS_SIGNING_TIMESTAMP}}",
      "policy": "{{GCS_UPLOAD_POLICY}}",
      "x-goog-signature": "{{GCS_UPLOAD_SIGNATURE}}"
    }
  }
}
```

{% endstep %}

{% step %}
#### Submit the multipart form

Submit every field returned in `upload.fields` unchanged. Append the `file` part last. GCS form instructions do not include `x-goog-if-generation-match`.

```bash
curl -i -X POST \
  '{{GCS_MULTIPART_UPLOAD_URL}}' \
  -F 'key={{GCS_OBJECT_KEY}}' \
  -F 'content-type=application/pdf' \
  -F 'x-goog-meta-emporix-upload=session' \
  -F 'success_action_status=204' \
  -F 'x-goog-algorithm=GOOG4-RSA-SHA256' \
  -F 'x-goog-credential={{GCS_CREDENTIAL}}' \
  -F 'x-goog-date={{GCS_SIGNING_TIMESTAMP}}' \
  -F 'policy={{GCS_UPLOAD_POLICY}}' \
  -F 'x-goog-signature={{GCS_UPLOAD_SIGNATURE}}' \
  -F 'file=@supplier-contract.pdf'
```

{% endstep %}

{% step %}
#### Wait for the asset to become ready

Follow the [Wait for the uploaded asset](#wait-for-the-uploaded-asset) procedure with the returned asset ID.
{% endstep %}
{% endstepper %}

### Upload a public asset to Cloudinary

{% stepper %}
{% step %}
#### Start the public upload session

Create a session with `access` set to `PUBLIC`. Public blobs are stored in Cloudinary and always use a multipart POST.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/media/{{tenant}}/assets/upload-session' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "type": "BLOB",
    "access": "PUBLIC",
    "details": {
      "filename": "product-image.png",
      "mimeType": "image/png"
    },
    "refIds": [
      {
        "id": "123e06ecf0452c2d6c0b81392",
        "type": "PRODUCT"
      }
    ]
  }'
```

A representative response is:

```json
{
  "id": "68d67ef03f7c2b1e4a8d6503",
  "provider": "CLOUDINARY",
  "status": "PENDING",
  "expiresAt": "{{UPLOAD_SESSION_EXPIRES_AT}}",
  "upload": {
    "method": "POST",
    "url": "{{CLOUDINARY_UPLOAD_URL}}",
    "fields": {
      "api_key": "{{CLOUDINARY_API_KEY}}",
      "timestamp": "{{CLOUDINARY_TIMESTAMP}}",
      "signature": "{{CLOUDINARY_SIGNATURE}}",
      "public_id": "68d67ef03f7c2b1e4a8d6503",
      "folder": "{{CLOUDINARY_FOLDER}}",
      "use_filename": "true",
      "unique_filename": "false",
      "overwrite": "false",
      "notification_url": "{{CLOUDINARY_NOTIFICATION_URL}}"
    }
  }
}
```

{% endstep %}

{% step %}
#### Submit the Cloudinary form

The `api_key` is expected public form data. The Cloudinary API secret is never returned. Cloudinary form instructions are valid for one hour. Submit every returned field unchanged and append the `file` part last.

```bash
curl -i -X POST \
  '{{CLOUDINARY_UPLOAD_URL}}' \
  -F 'api_key={{CLOUDINARY_API_KEY}}' \
  -F 'timestamp={{CLOUDINARY_TIMESTAMP}}' \
  -F 'signature={{CLOUDINARY_SIGNATURE}}' \
  -F 'public_id=68d67ef03f7c2b1e4a8d6503' \
  -F 'folder={{CLOUDINARY_FOLDER}}' \
  -F 'use_filename=true' \
  -F 'unique_filename=false' \
  -F 'overwrite=false' \
  -F 'notification_url={{CLOUDINARY_NOTIFICATION_URL}}' \
  -F 'file=@product-image.png'
```

{% endstep %}

{% step %}
#### Wait for the asset to become ready

Follow the [Wait for the uploaded asset](#wait-for-the-uploaded-asset) procedure with the returned asset ID.
{% endstep %}
{% endstepper %}

### Wait for the uploaded asset

Storage confirmation is asynchronous. After a successful storage upload, retrieve the asset with the [Retrieving an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets-assetid) endpoint until `status` is `READY`. Use a service OAuth2 token with the `media.asset_read` scope.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i \
  'https://api.emporix.io/media/{{tenant}}/assets/68d67e9a3f7c2b1e4a8d6501' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

While completion is pending, the response can contain:

```json
{
  "id": "68d67e9a3f7c2b1e4a8d6501",
  "type": "BLOB",
  "access": "PRIVATE",
  "status": "PENDING",
  "details": {
    "filename": "installation-guide.pdf",
    "mimeType": "application/pdf"
  },
  "refIds": []
}
```

Retry after a reasonable delay until the asset status is `READY`:

```json
{
  "id": "68d67e9a3f7c2b1e4a8d6501",
  "type": "BLOB",
  "access": "PRIVATE",
  "status": "READY",
  "details": {
    "filename": "installation-guide.pdf",
    "mimeType": "application/pdf",
    "bytes": 248316,
    "etag": "{{FILE_ETAG}}"
  },
  "refIds": []
}
```

If a storage notification is delayed, retrieving the asset or scheduled cleanup can detect the stored file and complete the asset. The service emits the `media.asset-created` event only after it confirms that the file is stored and changes the asset status to `READY`. Operations that need the stored file return `409` while it is unavailable:

```json
{
  "code": 409,
  "status": "Conflict",
  "message": "Upload is not complete",
  "resourceId": "68d67e9a3f7c2b1e4a8d6501"
}
```

Unused upload sessions expire after one hour by default. Cleanup removes an expired pending asset if no uploaded file exists.

## How to download assets directly from storage

Prefer [Retrieving a download URL](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets-assetid-download-url) for every download. Direct download is always faster than streaming the file through the Media API, because the client fetches the file from storage. Use a service OAuth2 token that has the `media.asset_read` scope. This endpoint is available regardless of whether direct upload is enabled.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% stepper %}
{% step %}
#### Request a download URL

For a private GCS blob, omit `disposition` to use the default value, `attachment`.

```bash
curl -i \
  'https://api.emporix.io/media/{{tenant}}/assets/68d67e9a3f7c2b1e4a8d6501/download-url' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

The response contains a signed GCS URL that is valid for 15 minutes by default:

```json
{
  "provider": "GCS",
  "url": "{{SIGNED_GCS_DOWNLOAD_URL_WITH_ATTACHMENT_DISPOSITION}}",
  "expiresAt": "{{DOWNLOAD_URL_EXPIRES_AT}}"
}
```

Set `disposition=inline` to request a signed private GCS URL suitable for inline display.

```bash
curl -i \
  'https://api.emporix.io/media/{{tenant}}/assets/68d67e9a3f7c2b1e4a8d6501/download-url?disposition=inline' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

```json
{
  "provider": "GCS",
  "url": "{{SIGNED_GCS_DOWNLOAD_URL_WITH_INLINE_DISPOSITION}}",
  "expiresAt": "{{DOWNLOAD_URL_EXPIRES_AT}}"
}
```

The `disposition` parameter affects private GCS signed links only. Omit it for `attachment`, or set it to `inline`. An empty or unsupported value returns `400` with `disposition must be inline or attachment`. The parameter does not change public Cloudinary URLs or stored `LINK` URLs.

For a public blob, the endpoint returns its permanent Cloudinary URL. It does not return `expiresAt`.

```bash
curl -i \
  'https://api.emporix.io/media/{{tenant}}/assets/68d67ef03f7c2b1e4a8d6503/download-url' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

```json
{
  "provider": "CLOUDINARY",
  "url": "{{PERMANENT_CLOUDINARY_ASSET_URL}}"
}
```

{% endstep %}

{% step %}
#### Retrieve the file from storage

Use the returned URL directly. Do not send the Emporix access token to GCS or Cloudinary.

For a private GCS URL:

```bash
curl -L \
  '{{SIGNED_GCS_DOWNLOAD_URL_WITH_ATTACHMENT_DISPOSITION}}' \
  --output 'installation-guide.pdf'
```

For a permanent public Cloudinary URL:

```bash
curl -L \
  '{{PERMANENT_CLOUDINARY_ASSET_URL}}' \
  --output 'product-image.png'
```

{% endstep %}
{% endstepper %}

### Classic download compatibility

The classic `GET /media/{tenant}/assets/{assetId}/download` endpoint remains available as a compatibility alternative. It streams file content through the Media API, so it is slower than a direct download.

When the known `details.bytes` value exceeds the configurable default of 31,457,280 bytes (30 MiB), the classic endpoint returns `413`. Assets without a known byte count are not rejected by this check. The direct-download endpoint has no corresponding file-size gate.

## How to clean up uploaded assets

Delete assets that were created only for a temporary workflow by calling the [Deleting an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#delete-media-tenant-assets-assetid) endpoint with the `media.asset_manage` scope.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X DELETE \
  'https://api.emporix.io/media/{{tenant}}/assets/68d67e9a3f7c2b1e4a8d6501' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

A successful deletion returns `204 No Content`.

## How to use classic asset operations

The assets can either be linked to an external website where they are stored, or uploaded in the form of blob data by using a `multipart/form-data` request.

You can also specify the access type of each asset:

- `PUBLIC` – Stored on public storage and accessible from an external URL. Use this access type for storefront-visible media, such as category banners or product images.
- `PRIVATE` – Stored on private storage and accessible through an authenticated download request or a temporary signed URL. Use this access type for internal documents, such as contracts or specification sheets.

{% hint style="warning" %}
The [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint supports two request formats, each creating a different asset type:

- `application/json` – Creates a `LINK` asset. Provide a `url` to a file hosted externally; Emporix stores the reference, not the file itself.
- `multipart/form-data` – Creates a `BLOB` asset. The current service configuration accepts files up to 50 MB.
{% endhint %}

Classic multipart uploads remain available as a compatibility alternative. In this flow, file bytes pass through the Media API. Classic downloads also remain available, but they stream through the Media API and therefore stay slower than a direct download. The classic download also applies the 30 MiB default streaming limit described above.

## How to associate a public asset with a resource

To link media to a category, product, or other predefined resource type, create the asset with `"access": "PUBLIC"` and provide the target in `refIds`. Requests that combine `PRIVATE` access with predefined `refIds` types (such as `CATEGORY` or `PRODUCT`) are rejected with a `400` response.

{% hint style="warning" %}
Before you begin, ensure the target category, product, or other resource already exists. For more information, check out the relevant service API reference.
{% endhint %}

After association, you can manage the asset in the Management Dashboard from the related resource view (for example, a category or product).

### Associate a public asset by link

To add a linked asset for a category, or other resource, send an `application/json` request to the [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint with the `media.asset_manage` scope.

In this example, create a `PUBLIC` `LINK` asset and associate it with a category.

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
    "url": "https://example.com/media/category-banner.html",
    "refIds": [
      {
        "id": "d74d0383-f5fe-4cb8-ba63-860e529d4fe4",
        "type": "CATEGORY"
      }
    ]
  }'
```

### Upload a public asset as a blob

You can create a public asset for a category, or other resource, for example an image, by uploading the file and its metadata. Send a `multipart/form-data` request to the [Creating an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#post-media-tenant-assets) endpoint with the `media.asset_manage` scope.

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

Create a private asset without `refIds`, or associate it with `AGENT` or a custom schema type in `refIds`. Private assets cannot be linked to predefined types such as `CATEGORY` or `PRODUCT`. After creation, retrieve the file through the [Downloading an asset](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets-assetid-download) endpoint with the `media.asset_read` scope.

### Upload an unassociated private asset

In this example, upload an internal contract as an unassociated `PRIVATE` `BLOB` asset.

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

### Associate a private asset with a custom schema type

If you model business objects with the [Schema Service](../../utilities/schema/schema.md), you can attach private files to a custom instance. Set `refIds.type` to your custom schema type ID (for example, `DOCUMENT`) and `refIds.id` to the custom instance ID.

{% hint style="warning" %}
Before you begin, create the custom schema type and instance through the Schema Service. For more information, see [Creating a Custom Schema Type](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-schema-type#post-schema-tenant-custom-entities) and [Creating a Custom Instance](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/custom-instance#post-schema-tenant-custom-entities-type-instances).
{% endhint %}

In this example, attach a signed agreement PDF to a `DOCUMENT` custom instance as a `PRIVATE` `BLOB` asset.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/media/{{tenant}}/assets' \
  --header 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  --form 'file=@signed-agreement.pdf' \
  --form 'body={"type":"BLOB","access":"PRIVATE","refIds":[{"id":"a1b2c3d4-e5f6-7890-abcd-ef1234567890","type":"DOCUMENT"}],"details":{"filename":"signed-agreement","mimeType":"application/pdf"}}'
```

## How to retrieve assets for a given category

By providing query values, you can retrieve assets that fulfil specific criteria.

In this example, retrieve all assets that belong to a particular category by providing the category ID in the `q` parameter. Send a request to the [Retrieving all assets](https://developer.emporix.io/api-references/api-guides/media/media/api-reference/assets#get-media-tenant-assets) endpoint with the `media.asset_read` scope.

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
