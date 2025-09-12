---
seo:
  title: Indexer Service Tutorials
  description: indexer, search connector
icon: graduation-cap
---

# Indexing Tutorial

The Indexing service is designed to manage indexing configuration. Currently, the index provider supported in Commerce Engine is [Algolia](https://www.algolia.com/).\
Proper indexing allows you to enhance your search mechanism within Emporix system. By connecting your Algolia instance to Commerce Engine, you get an improved search functionality.

{% hint style="info" %}
To learn more about the Indexing Service, see the [Indexing Service](./).
{% endhint %}

For every tenant, new Algolia credentials are created and kept as `AlgoliaClient`.

The Indexing service uses separate API keys for every tenant, so that you get more flexibility in configuration.

## How to configure search indexing

To create indexing configuration, send a request to the [Creating new configuration](https://developer.emporix.io/api-references/api-guides//configuration/indexing-service/api-reference/configuration#post-indexing-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/catalog/api-reference/" %}
[api-reference](../../catalogs-and-categories/catalog/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/indexing/{tenant}/configurations' \
  --header 'Content-Type: application/json' \
  --data '{
    "active": true,
    "searchKey": "84dc4886f81f805c42bdd89d64de751a",
    "applicationId": "8AP2HABA2I",
    "indexName": "exampleTenant",
    "writeKey": "51ebe89215dddcf85e5dacd5643d17e7",
    "provider": "ALGOLIA"
  }'
```

## How to update the index configuration

To update the index configuration you need to retrieve the `writeKey` first.\
Send the request to the [Get configuration by provider name](https://developer.emporix.io/api-references/api-guides//configuration/indexing-service/api-reference/configuration#get-indexing-tenant-configurations-provider) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/catalog/api-reference/" %}
[api-reference](../../catalogs-and-categories/catalog/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/indexing/{tenant}/configurations' \
  --header 'Accept: */*'
```

To change configuration, make a call to the [Update configuration by provider name](https://developer.emporix.io/api-references/api-guides//configuration/indexing-service/api-reference/configuration#put-indexing-tenant-configurations-provider) endpoint, providing the `writeKey` from the previous step.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/catalog/api-reference/" %}
[api-reference](../../catalogs-and-categories/catalog/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/indexing/{tenant}/configurations/{provider}' \
  --header 'Content-Type: application/json' \
  --data '{
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

Usually, reindexing runs upon the update of a product or its dependant entity, such as category, price, or media. The scheduler job discovers what has been changed and pushes the changes to index frequently.\
But, if you change your index configuration, you need to trigger the reindexing process to apply your configuration changes.\
You can run the reindex without the need to update all your resource data by sending the request to the [Reindex](https://developer.emporix.io/api-references/api-guides//configuration/indexing-service/api-reference/reindex) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/catalog/api-reference/" %}
[api-reference](../../catalogs-and-categories/catalog/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/indexing/{tenant}/reindex' \
  --header 'Content-Type: application/json' \
  --data '{
    "mode": "FULL"
  }'
```

This operation starts the full reindexing mode.

## How to retrieve public search configuration

How to retrieve public search configuration

If you want to get your storefront index configuration without the need to update, you can call the public endpoint to get the `searchKey`. Send the request to the [Get all public configurations](https://developer.emporix.io/api-references/api-guides//configuration/indexing-service/api-reference/public-configuration#get-indexing-tenant-public-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/catalog/api-reference/" %}
[api-reference](../../catalogs-and-categories/catalog/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --url 'https://api.emporix.io/indexing/{tenant}/public/configurations' \
  --header 'Accept: */*'
```

## How to choose indexing strategy

You can choose between two indexing strategies for your search index configuration: `MERGE` and `SPLIT`. `MERGE` strategy creates a single index for all sites declared in the system, while `SPLIT` creates a separate index for each site.\
To choose the right mode for your index, send the request to the [Updating a configuration](https://developer.emporix.io/api-references/api-guides//configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../country-service/api-reference/" %}
[api-reference](../country-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' \
  --header 'Content-Type: application/json' \
  --data '{
    "key": "indexing_siteAwareFieldsStrategy",
    "secured": false,
    "value": {
    "strategy": "SPLIT"
  },
    "version": 1
}
```

In the request parameters, for the `propertyKey` choose `indexing_siteAwareFieldsStrategy`. In the request body, pass the chosen strategy value.Please remain patient as propagating changes to the index strategy may take up to 1 hour, so you might not be able to see the changes instantly.
