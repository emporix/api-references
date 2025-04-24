---
seo:
  title: Indexer Service Tutorials
  description: indexer, search connector
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Indexing Service Tutorials

The Indexing service is designed to manage indexing configuration. Currently, the index provider supported in Commerce Engine is [Algolia](https://www.algolia.com/). 
Proper indexing allows you to enhance your search mechanism within Emporix system. By connecting your Algolia instance to Commerce Engine, you get an improved search functionality.

{% hint style="info" %}
To learn more about the Indexing Service, see the [Indexing Service](https://developer.emporix.io/user-guides/system-management/search/indexing).
{% endhint %}

For every tenant, new Algolia credentials are created and kept as `AlgoliaClient`.

The Indexing service uses separate API keys for every tenant, so that you get more flexibility in configuration.

## How to configure search indexing

To create indexing configuration, send a request to the <nobr><Button to="/openapi/indexing/#operation/POST-indexing-create-config" size="small">Creating new configuration</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="indexing"
  operationId="POST-indexing-create-config"
  defaultExample="Create a new configuration"
/>

## How to update the index configuration

1. To update the index configuration you need to retrieve the `writeKey` first.
Send the request to the <nobr><Button to="/openapi/indexing/#operation/GET-indexing-retrieve-config" size="small">Get configuration by provider name</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="indexing"
  operationId="GET-indexing-retrieve-config"
  defaultExample="Get configuration"
/>

2. To change configuration, make a call to the <nobr><Button to="/openapi/indexing/#operation/PUT-indexing-update-config" size="small">Update configuration by provider name</Button></nobr> endpoint, providing the `writeKey` from the previous step.

<OpenApiTryIt
  definitionId="indexing"
  operationId="PUT-indexing-update-config"
  defaultExample="Configuration update"
/>

3. To apply your configuration changes to existing data, run the reindexing process. See the [How to reindex existing products](/content/indexing/##How_to_reindex_existing_products) section.

## How to reindex existing products <a id="How_to_reindex_existing_products" />

Usually, reindexing runs upon the update of a product or its dependant entity, such as category, price, or media. The scheduler job discovers what has been changed and pushes the changes to index frequently. 
But, if you change your index configuration, you need to trigger the reindexing process to apply your configuration changes. 
You can run the reindex without the need to update all your resource data by sending the request to the <nobr><Button to="/openapi/indexing/#operation/POST-indexing-reindex" size="small">Reindex</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="indexing"
  operationId="POST-indexing-reindex"
  defaultExample="Reindex request"
/>

This operation starts the full reindexing mode.

## How to retrieve public search configuration

If you want to get your storefront index configuration without the need to update, you can call the public endpoint to get the `searchKey`. 


Send the request to the <nobr><Button to="/openapi/indexing/#operation/GET-indexing-list-public-configs" size="small">Get all public configurations</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="indexing"
  operationId="GET-indexing-list-public-configs"
  defaultExample="Public configurations"
/>

## How to choose indexing strategy

You can choose between two indexing strategies for your search index configuration: `MERGE` and `SPLIT`. `MERGE` strategy creates a single index for all sites declared in the system, while `SPLIT` creates a separate index for each site.
To choose the right mode for your index, send the request to the <nobr><Button to="/openapi/configuration/#operation/PUT-configuration-update-config" size="small">Updating a configuration</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="configuration"
  operationId="PUT-configuration-update-config"
  properties={
  {
    key: "indexing_siteAwareFieldsStrategy",
    value: {
        strategy: "SPLIT"
    }
  }
  }
/>

In the request parameters, for the `propertyKey` choose `indexing_siteAwareFieldsStrategy`. In the request body, pass the chosen strategy value.

{% hint style="danger" %}
Please remain patient as propagating changes to the index strategy may take up to 1 hour, so you might not be able to see the changes instantly.
{% endhint %}


