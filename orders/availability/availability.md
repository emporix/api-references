---
seo:
  title: Availability Service Tutorials
  description: availability, location, stock level,
icon: graduation-cap
layout:
  width: wide
---

# Availability Tutorial

## How to specify availability, popularity, or stock level for a product

{% hint style="warning" %}
This tutorial describes how to specify availability, popularity, and stock level for a single product.
{% endhint %}

Information about a specific product's availability, popularity, and stock levels is stored inside the `Availability` object.

Take a look at the relationships between the `Availability` object and other resources in the Emporix Commerce Engine:

<figure><img src="../../static/availability/availability.svg" alt=""><figcaption></figcaption></figure>

### Before you start

Make sure you created a product. For more information, check out [_How to add your first product_](../../products-labels-and-brands/product-service/product.md#how-to-add-your-first-product).

### Create the `Availability` object

To add availability-related information for a specific product, you need to send a request to the [Creating a new availability for a product](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-productid-site) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/availability/{tenant}/availability/{productId}/{site}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "stockLevel": 10,
    "available": true,
    "popularity": 5,
    "distributionChannel": "ASSORTMENT",
    "metadata": {
      "mixins": {
        "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json"
      }
    },
    "mixins": {
      "productCustomAttributes": {
        "minOrderQuantity": 2
      }
    }
  }'
```

### Retrieve the availability information of a product

To check if a product's availability was added successfully, you need to send a request to the [Retrieving a product's availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search) endpoint with the product's ID in the request body.

{% hint style="warning" %}
You can also retrieve availability information for multiple products at once by sending a request to the [Retrieving product availabilities for a site](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#post-availability-tenant-availability-search) endpoint.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/availability/{tenant}/availability/{productId}/{site}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

## How to calculate a product bundle's stock level

The Availability Service makes it possible to automatically calculate the stock level of a product bundle. The value is always equal to the lowest stock level of the bundled products.

{% hint style="warning" %}
For a product bundle's availability to be calculated, all products in the bundle need to have their availability and stock levels specified. Otherwise, the bundle will be treated as unavailable.
{% endhint %}

### Before you start

Make sure the following requirements are fulfilled:

* You have already created all products that make up the bundle.

{% hint style="warning" %}
For instructions, check out [_How to add your first product_](../../products-labels-and-brands/product-service/product.md#how-to-add-your-first-product).
{% endhint %}

* You have already specified stock levels for all products that make up the bundle.

{% hint style="warning" %}
For instructions, check out [_How to specify availability, popularity, or stock level for a product_](../../products-labels-and-brands/product-service/product.md#how-to-create-a-bundle-of-personalized-products).
{% endhint %}

* You have already created a product bundle.

{% hint style="warning" %}
For instructions, check out [How to create a bundle of personalized products](../../products-labels-and-brands/product-service/product.md#how-to-create-a-bundle-of-personalized-products).
{% endhint %}

### Retrieve the product bundle's availability information

To find out what the stock level of a product bundle is, you need to send a request to the [Retrieving a product's availability](https://developer.emporix.io/api-references/api-guides/orders/availability/api-reference/availabilities#get-availability-tenant-availability-productid-site) endpoint with the product bundle's ID in the path.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/availability/{tenant}/availability/{productId}/{site}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

The response includes both the availability information of the bundle as a whole, as well as the bundled products.
