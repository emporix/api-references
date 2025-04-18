---
seo:
  title: Availability Service Tutorials
  description: availability, location, stock level,
toc:
  enable: true
tocMaxDepth: 2
editPage:
  disable: true
label: Tutorials
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';
import { Preview } from '../components/Preview.tsx'

# Availability Service Tutorials

## How to specify availability, popularity, or stock level for a product

:::attention This tutorial describes how to specify availability, popularity, and stock level for a single product.
:::

Information about a specific product's availability, popularity, and stock levels is stored inside the `Availability` object.

Take a look at the relationships between the `Availability` object and other resources in the Emporix Commerce Engine:

<Preview src="/docs/availability/availability.svg"></Preview>

### Before you start

Make sure you created a product. For more information, check out [*How to add your first product*](/content/product/#how-to-add-your-first-product).

### Create the `Availability` object

To add availability-related information for a specific product, you need to send a request to the <Button to="/openapi/availability/#operation/POST-availability-add-product" size="small">Creating a new availability for a product</Button> endpoint. 

<OpenApiTryIt
  definitionId="availability"
  operationId="POST-availability-add-product"
  id="step1"
  parameters={{
    path: {
      tenant: "{tenant}",
      productId: "{productId}"
    }
    }}
  properties={{ 
    id: "{siteCode}:{productId}", 
    site: "{siteCode}", 
    productId: "{productId}" 
    }}
/>

### Retrieve the availability information of a product

To check if a product's availability was added successfully, you need to send a request to the <Button to="/openapi/availability/#operation/GET-availability-retrieve-product" size="small">Retrieving a product's availability</Button> endpoint with the product's ID in the request body.

:::attention 
You can also retrieve availability information for multiple products at once by sending a request to the <Button to="/openapi/availability/#operation/POST-availability-search-products-site" size="small">Retrieving product availabilities for a site</Button> endpoint. 
:::

<OpenApiTryIt
  definitionId="availability"
  operationId="GET-availability-retrieve-product"
  id="step2"
  needs={['step1']}
  parameters={{
    path: {
      tenant: "{tenant}",
      productId: "{productId}"
    },
    query: {
      site: "{siteCode}"
    }
  }}
/>

## How to calculate a product bundle's stock level

The Availability Service makes it possible to automatically calculate the stock level of a product bundle. The value is always equal to the lowest stock level of the bundled products.

:::attention

For a product bundle's availability to be calculated, all products in the bundle need to have their availability and stock levels specified. Otherwise, the bundle will be treated as unavailable.

:::

### Before you start

Make sure the following requirements are fulfilled:

* You have already created all products that make up the bundle.

:::info
For instructions, check out [*How to add your first product*](/content/product/#how-to-add-your-first-product).

:::

* You have already specified stock levels for all products that make up the bundle.

:::info 
  For instructions, check out [*How to specify availability, popularity, or stock level for a product*](/content/product/#how-to-create-a-bundle-of-personalized-products).

:::

* You have already created a product bundle.

:::info
For instructions, check out [How to create a bundle of personalized products](/content/product/#how-to-create-a-bundle-of-personalized-products).

:::

### Retrieve the product bundle's availability information

To find out what the stock level of a product bundle is, you need to send a request to the <Button to="/openapi/availability/#operation/GET-availability-retrieve-product" size="small">Retrieving a product's availability</Button> endpoint with the product bundle's ID in the path.

<OpenApiTryIt
  definitionId="availability"
  operationId="GET-availability-retrieve-product"
  parameters={{
    path: {
      tenant: "{tenant}",
      productId: "{productBundleId}"
    },
    query: {
      site: "{siteCode}"
    }
  }}
/>

The response includes both the availability information of the bundle as a whole, as well as the bundled products.

