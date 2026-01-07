---
seo:
  title: Configuration Service Tutorials
  description: configuration, configurations, tenant configurations, client configurations, global configurations
icon: graduation-cap
layout:
  width: wide
---

# Configuration Service Tutorial

The Configuration Service is a general store for tenant-specific information. It allows you to manage various settings and configurations that control how your Emporix e-commerce system operates.

## Types of configurations

The Configuration Service manages three types of configurations:

* **Tenant configurations** — Applicable to all services across the tenant. Use tenant configurations for settings that apply across your entire tenant, such as:
  * Default languages, currencies, and countries
  * Customer redirect URLs
  * Email notification settings
  * Tax and packaging configurations
  * Storefront settings

* **Client configurations** — Associated with particular services. Use client configurations for service-specific settings, such as indexing configurations


* **Global configurations** — Read-only configurations associated with all services across all tenants.

### Configuration structure

All configurations follow this structure:

```json
{
  "key": "configuration_key",
  "secured": false,
  "value": "configuration_value",
  "version": 1
}
```

* `key` — The configuration key identifier
* `secured` — Whether the configuration is secured (boolean)
* `value` — The configuration value (can be a string, number, boolean, object, or array)
* `version` — The version number of the configuration (incremented on each update)

The Client configurations include:

```json
{
  "_id": "client_key_identifier",
  "client": "client_name",
  "key": "configuration_key",
  "value": "configuration_value"
}
```

* `_id` — Unique identifier combining client and key
* `client` — The client/service name
* `key` — The configuration key identifier
* `value` — The configuration value

## Common configuration keys

The Configuration Service supports various configuration keys for different purposes:

| Configuration Key | Description |
|-------------------|-------------|
| `customer.passwordreset.redirecturl` | URL to redirect customers when resetting their password. |
| `customer.changeemail.redirecturl` | URL to redirect customers when changing their email address. |
| `cust.notification.email.from` | Email address used as the sender for customer notifications. |
| `customer.deletion.redirecturl` | URL to redirect customers after account deletion. |
| `project_country` | Default country for your tenant. |
| `project_curr` | Default currencies for your tenant. |
| `project_lang` | Default languages for your tenant. |
| `taxConfiguration` | Tax classes and rates configuration. |
| `packagingConf` | Packaging groups and position options. |
| `storefront.host` | Hostname for your storefront. |
| `storefront.htmlPage` | Default HTML page for your storefront. |
| `unitConf` | Unit conversion configurations. |
| `invoiceSettings` | Invoice generation thresholds and statuses. |

## Managing tenant configurations 

### How to retrieve all tenant configurations

To retrieve a list of all tenant configurations, send a request to the [Retrieving configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

You can also filter configurations by specific keys using the `keys` query parameter, for example:

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations?keys=project_lang' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

### How to retrieve a specific tenant configuration

To retrieve a specific tenant configuration by its key, send a request to the [Retrieving a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#get-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

**Example:** Retrieving the language configuration

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/project_lang' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

The example response looks like:

```json
{
  "key": "project_lang",
  "secured": false,
  "value": "[{\"id\":\"en\",\"label\":\"English\",\"default\":true,\"required\":true}]",
  "version": 2
}
```

### How to create tenant configurations

To create new tenant configurations, send a request to the [Creating configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#post-configuration-tenant-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

**Example:** Creating multiple configurations at once

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '[
    {
      "key": "project_country",
      "secured": false,
      "value": "DE",
      "version": 1
    },
    {
      "key": "project_lang",
      "secured": false,
      "value": "[{\"id\":\"en\",\"label\":\"English\",\"default\":true,\"required\":true},{\"id\":\"de\",\"label\":\"German\",\"default\":false,\"required\":false}]",
      "version": 1
    }
  ]'
```

**Example:** Creating invoice settings configuration

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '[
    {
      "key": "invoiceSettings",
      "secured": false,
      "value": {
        "threshold": "24",
        "status": "CREATED,CONFIRMED",
        "extendedOrderStatus": "70,75,76"
      },
      "version": 1
    }
  ]'
```

{% hint style="warning" %}
When creating configurations, make sure the `version` field is set to `1` for new configurations. The version number is incremented automatically when you update the configuration.
{% endhint %}

### How to update a tenant configuration

To update an existing tenant configuration, send a request to the [Updating a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#put-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

**Example:** Updating the country configuration

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/project_country' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "key": "project_country",
    "secured": false,
    "value": "AT",
    "version": 1
  }'
```

{% hint style="warning" %}
The `key` in the request body must match the `propertyKey` in the URL path. Also, make sure to include the current `version` number from the existing configuration to avoid conflicts.
{% endhint %}

**Example:** Updating customer redirect URLs

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/customer.deletion.redirecturl' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "key": "customer.deletion.redirecturl",
    "secured": false,
    "value": "https://tenant.com/custDelete?token=",
    "version": 1
  }'
```

**Example:** Updating tax configuration

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/taxConfiguration' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "key": "taxConfiguration",
    "secured": false,
    "value": {
      "taxClassOrder": ["FULL", "HALF", "ZERO"],
      "taxClasses": {
        "FULL": 19,
        "HALF": 7,
        "ZERO": 0
      }
    },
    "version": 1
  }'
```

**Example:** Updating packaging configuration

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/packagingConf' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "key": "packagingConf",
    "secured": false,
    "value": {
      "packagingGroupOptions": [
        "1_cooling_product",
        "2_standard",
        "3_fragile"
      ],
      "packagingPositionOptions": [
        "1_bottom_robust",
        "2_bottom_insensitive",
        "3_middle_standard",
        "4_top_sensitive"
      ]
    },
    "version": 1
  }'
```

**Example:** Updating storefront settings

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/storefront.host' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "key": "storefront.host",
    "secured": false,
    "value": "tenant.com",
    "version": 1
  }'
```

**Example:** Updating email notification settings

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/cust.notification.email.from' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "key": "cust.notification.email.from",
    "secured": false,
    "value": "example_email@emporix.com",
    "version": 1
  }'
```

### How to delete a tenant configuration

To delete a tenant configuration, send a request to the [Deleting a configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/tenant-configurations#delete-configuration-tenant-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request DELETE 
  --url 'https://api.emporix.io/configuration/{tenant}/configurations/{propertyKey}' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN'
```

## Managing client configurations 

Client configurations are service-specific settings that apply to particular services rather than the entire tenant.

### How to retrieve available clients

To retrieve a list of available clients for your tenant, send a request to the [Retrieving clients](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#get-configuration-tenant-clients) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/clients' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

The example response looks like:

```json
[
  "saas-ag.caas-indexing-service-client"
]
```

### How to retrieve client configurations

To retrieve all configurations for a specific client, send a request to the [Retrieving client configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#get-configuration-tenant-clients-client-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/{client}/configurations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

**Example:** Retrieving indexing service client configurations

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/saas-ag.caas-indexing-service-client/configurations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

The example response looks like:

```json
[
  {
    "_id": "saas-ag.caas-indexing-service-client_algolia_activation",
    "client": "saas-ag.caas-indexing-service-client",
    "key": "algolia_activation",
    "value": true
  },
  {
    "_id": "saas-ag.caas-indexing-service-client_indexing_configuration",
    "client": "saas-ag.caas-indexing-service-client",
    "key": "indexing_configuration",
    "value": {
      "activePublishedProductIndexing": true,
      "activeNonPublishedProductIndexing": true
    }
  }
]
```

You can also filter client configurations by specific keys using the `keys` query parameter:

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/{client}/configurations?keys=algolia_activation' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

### How to retrieve a specific client configuration

To retrieve a specific client configuration by its key, send a request to the [Retrieving a client configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#get-configuration-tenant-clients-client-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/{client}/configurations/{propertyKey}' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

**Example:** Retrieving a specific indexing configuration

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/saas-ag.caas-indexing-service-client/configurations/indexing_configuration' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

The example response looks like:

```json
{
  "_id": "saas-ag.caas-indexing-service-client_indexing_configuration",
  "client": "saas-ag.caas-indexing-service-client",
  "key": "indexing_configuration",
  "value": {
    "activePublishedProductIndexing": true,
    "activeNonPublishedProductIndexing": true
  }
}
```

### How to create client configurations

To create new client configurations, send a request to the [Creating client configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#post-configuration-tenant-clients-client-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

**Example:** Creating a client configuration

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/{client}/configurations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '[
    {
      "client": "test_client",
      "key": "test_key",
      "value": true
    }
  ]'
```

### How to update a client configuration

To update an existing client configuration, send a request to the [Updating a client configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#put-configuration-tenant-clients-client-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request PUT 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/{client}/configurations/{propertyKey}' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "client": "example_client",
    "key": "example_key",
    "value": false
  }'
```

### How to delete a client configuration

To delete a client configuration, send a request to the [Deleting a client configuration](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/client-configurations#delete-configuration-tenant-clients-client-configurations-propertykey) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request DELETE 
  --url 'https://api.emporix.io/configuration/{tenant}/clients/{client}/configurations/{propertyKey}' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN'
```

## Retrieving global configurations

Global configurations are read-only configurations that are associated with all services across all tenants. These configurations provide default values and system-wide settings.

### How to retrieve global configurations

To retrieve a list of global configurations, send a request to the [Retrieving global configurations](https://developer.emporix.io/api-references/api-guides/configuration/configuration-service/api-reference/global-configurations#get-configuration-tenant-global-configurations) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="./api-reference/" %}
[api-reference](./api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/global-configurations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

You can also filter global configurations by specific keys using the `keys` query parameter:

```bash
curl -L 
  --url 'https://api.emporix.io/configuration/{tenant}/global-configurations?keys=project_lang,project_curr' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

{% hint style="info" %}
Global configurations are read-only and cannot be created, updated, or deleted through the API. They are managed by the Emporix system and provide default values that can be overridden by tenant configurations.
{% endhint %}

