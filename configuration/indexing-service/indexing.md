---
seo:
  title: Indexer Service Tutorials
  description: indexer, search connector
icon: graduation-cap
layout:
  width: wide
---

# Indexing Tutorial

The Indexing service is designed to manage indexing configuration. Currently supported index providers:

* [Algolia](https://www.algolia.com)
* [BatteryIncluded](https://www.batteryincluded.io)

Proper indexing allows you to enhance your search mechanism within the Emporix system. By connecting an index provider to Commerce Engine, you get improved search functionality.

{% hint style="info" %}
To learn more about the Indexing Service, see the [Indexing Service](./).
{% endhint %}

#### Provider mutual exclusivity

Only one provider can be active at a time per tenant. This constraint is enforced by the configuration service.

#### BatteryIncluded

BatteryIncluded works only with the `MERGE` indexing strategy. With `SPLIT`, BatteryIncluded indexing is skipped without an error.

The `BATTERY_INCLUDED` configuration supports additional fields, credential validation, and its own reindex behavior. For setup steps, the indexed document, and mixin options, see the [BatteryIncluded Search Provider](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/system-management/search/batteryincluded) guide.

#### Algolia limitations

By default, Algolia indexes provided by Emporix support records up to 10kB in size. In order to support larger records, you must provide your own Algolia service. For more information, please refer to documents provided by Algolia:

* [Algolia documentation](https://www.algolia.com/doc/guides/scaling/algolia-service-limits#application-record-and-index-limits)
* [Algolia FAQ](https://support.algolia.com/hc/en-us/articles/4406981897617-Is-there-a-size-limit-for-my-index-records)

For every tenant, new Algolia credentials are created and kept as `AlgoliaClient`.

The Indexing service uses separate API keys for every tenant, so that you get more flexibility in configuration.

## How to choose indexing strategy

You can choose between two indexing strategies for your search index configuration: `MERGE` and `SPLIT`. `MERGE` strategy creates a single index for all sites declared in the system, while `SPLIT` creates a separate index for each site.

BatteryIncluded supports only `MERGE`.

To choose the right mode for your index, send the request to the [Updating a configuration](https://developer.emporix.io/api-documentation/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint. The request requires an OAuth2 service token with the `configuration.configuration_manage` scope.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../configuration-service/api-reference/" %}
[api-reference](../configuration-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "key": "indexing_siteAwareFieldsStrategy",
    "secured": false,
    "value": {
      "strategy": "SPLIT"
    },
    "version": 1
  }'
```

In the request parameters, for the `propertyKey` choose `indexing_siteAwareFieldsStrategy`. In the request body, pass the chosen strategy value. Please remain patient as propagating changes to the index strategy may take up to 1 hour, so you might not be able to see the changes instantly.

After you set the strategy, create the indexing configuration. See [How to configure search indexing](#how-to-configure-search-indexing).

## How to configure search indexing

To create indexing configuration, send a request to the [Creating new configuration](https://developer.emporix.io/api-documentation/api-guides/configuration/indexing-service/api-reference/configuration#post-indexing-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/indexing/{tenant}/configurations' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "active": true,
    "searchKey": "84dc4886f81f805c42bdd89d64de751a",
    "applicationId": "8AP2HABA2I",
    "indexName": "exampleTenant",
    "writeKey": "51ebe89215dddcf85e5dacd5643d17e7",
    "provider": "ALGOLIA"
  }'
```

{% hint style="info" %}
To register BatteryIncluded, including the optional `apiUrl`, `enrichments`, `excludedMixinKeys`, `includedMixinPaths`, and `siteAwareMixinsStrategy` fields, see [Setting Up Indexing](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/system-management/search/batteryincluded/set-up-indexing).
{% endhint %}

## How to update the index configuration

To update the index configuration you need to retrieve the `writeKey` first.
Send the request to the [Get configuration by provider name](https://developer.emporix.io/api-documentation/api-guides/configuration/indexing-service/api-reference/configuration#get-indexing-tenant-configurations-provider) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/indexing/{tenant}/configurations/{provider}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

To change configuration, make a call to the [Update configuration by provider name](https://developer.emporix.io/api-documentation/api-guides/configuration/indexing-service/api-reference/configuration#put-indexing-tenant-configurations-provider) endpoint, providing the `writeKey` from the previous step.

{% hint style="warning" %}
The update request replaces the whole configuration. Send back every field from the response of the previous step, including optional provider-specific fields. A field that you leave out is reset to its default.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/indexing/{tenant}/configurations/{provider}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "active": true,
    "searchKey": "84dc4886f81f805c42bdd89d64de751a",
    "applicationId": "8AP2HABA2I",
    "indexName": "exampleTenant",
    "writeKey": "51ebe89215dddcf85e5dacd5643d17e7",
    "provider": "ALGOLIA"
  }'
```

To apply your configuration changes to existing data, run the reindexing process. See the [How to reindex existing products](indexing.md#how_to_reindex_existing_products) section.

## How to reindex existing products <a href="#how_to_reindex_existing_products" id="how_to_reindex_existing_products"></a>

Usually, reindexing runs upon the update of a product or its dependant entity, such as category, price, or media. The scheduler job discovers what has been changed and pushes the changes to index frequently.
But, if you change your index configuration, you need to trigger the reindexing process to apply your configuration changes.
You can run the reindex without the need to update all your resource data by sending the request to the [Creating a reindex job](https://developer.emporix.io/api-documentation/api-guides/configuration/indexing-service/api-reference/reindex#post-indexing-tenant-reindex-jobs) endpoint. Creating a job requires an OAuth2 service token with the `indexing.search_manage` scope. Tracking the job with [Retrieving a reindex job](https://developer.emporix.io/api-documentation/api-guides/configuration/indexing-service/api-reference/reindex#get-indexing-tenant-reindex-jobs-reindexjobid) requires `indexing.search_view`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/indexing/{tenant}/reindex-jobs' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "entityType": "PRODUCT"
  }'
```

A successful response returns a reindex job, including its `id`. You can track progress with the [Retrieving a reindex job](https://developer.emporix.io/api-documentation/api-guides/configuration/indexing-service/api-reference/reindex#get-indexing-tenant-reindex-jobs-reindexjobid) endpoint. The job runs in full mode for the selected `entityType`.

### BatteryIncluded reindexing

For `BATTERY_INCLUDED`, the stored credentials are checked before the job is created, and the index stays searchable during the reindex. For details, see [Reindexing products](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/system-management/search/batteryincluded/set-up-indexing#reindexing-products).

## How to retrieve public search configuration

If you want to get your storefront index configuration without the need to update, you can call the public endpoint to get the `searchKey`. Send the request to the [Get all public configurations](https://developer.emporix.io/api-documentation/api-guides/configuration/indexing-service/api-reference/public-configuration#get-indexing-tenant-public-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../indexing-service/api-reference/" %}
[api-reference](../indexing-service/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/indexing/{tenant}/public/configurations' \
  -H 'Accept: */*'
```
