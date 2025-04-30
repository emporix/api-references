---
seo:
  title: Delivery and Shipping Service Tutorials
  description: delivery, deliveries, shipping, delivery time, delivery times, delivery zone, delivery zones, delivery method, delivery methods
toc:
  enable: true
tocMaxDepth: 2
editPage:
  disable: true
label: Tutorials
---

{% hint style="warning" %}

Names and/or descriptions of shipping zones, methods, and groups are localized. When creating a new shipping zone, method, or group, you can specify its name and/or description in one or multiple languages.

Looking for more info on localization? Check out [*Standard practices*](/content/standard-practices).

{% endhint %}

# How to configure delivery and shipping settings

To allow customers to place orders, you need to configure delivery and shipping settings by following the process below:

1. [Create a shipping zone](#create-a-shipping-zone).
2. [Create a shipping group](#create-a-shipping-group).
3. [Assign customers to a shipping group](#assign-customers-to-shipping-groups).
4. [Add shipping methods and define shipping fees](#add-shipping-methods-and-define-fees).
5. [Add delivery times](#add-delivery-times).
6. [Add delivery slots](#add-delivery-slots).

## Before you start

Ensure that you have created at least one customer.

{% hint style="warning" %}

A customer account can be created by the employee themselves or from your Emporix tenant's side. For more information, check out the following endpoints in the  Emporix API Reference:

* <nobr><Button to="/openapi/customer-customer/#operation/POST-customer-create-customer-account" size="small">Creating a new customer (customer-managed)</Button></nobr>
* <nobr><Button to="/openapi/customer-tenant/#operation/POST-customer-tenant-create-customer" size="small">Creating a new customer (tenant-managed)</Button></nobr>

{% endhint %}

## Create a shipping zone

Shipping zones are countries that your business delivers products to. You can create a shipping zone by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-zone" size="small">Creating a shipping zone</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/{site}/zones' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: fr' \
  -H 'Content-Type: application/json' \
  -d '{
    "shipTo": [
      {
        "country": "DE",
        "postalCode": "70190"
      }
    ],
    "name": "Zone 1",
    "id": "zone1",
    "default": true
  }'
  ```

## Create a shipping group

You can set up shipping groups for customers and define different shipping methods and costs for these groups. To create a shipping group, you need to call the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-group" size="small">Creating a shipping group</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/{site}/groups' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: fr' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "group1",
    "description": {
      "en": "This is the description for the group group1.",
      "de": "Dies ist die Beschreibung für die Gruppe group1."
    }
  }'
```


## Assign customers to shipping groups

By adding customers to shipping groups, you can offer them different shipping methods and costs.
Assign customers to shipping groups by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-customer-group-relation" size="small">Creating a customer-group relation</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/{site}/cgrelations' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "customerId": "C001",
    "groupId": "group1"
  }'
```

## Add shipping methods and define fees

Add shipping methods and configure shipping fees by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-method" size="small">Creating a shipping method</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/{site}/zones/{zoneId}/methods' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: fr' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "fedex-2dayground",
    "name": "FedEx 2Day",
    "active": true,
    "maxOrderValue": {
      "amount": 5000,
      "currency": "EUR"
    },
    "fees": [
      {
        "minOrderValue": {
          "amount": 0,
          "currency": "EUR"
        },
        "cost": {
          "amount": 10,
          "currency": "EUR"
        }
      },
      {
        "minOrderValue": {
          "amount": 50,
          "currency": "EUR"
        },
        "cost": {
          "amount": 9,
          "currency": "EUR"
        },
        "shippingGroupId": "group1"
      },
      {
        "minOrderValue": {
          "amount": 200,
          "currency": "EUR"
        },
        "cost": {
          "amount": 8,
          "currency": "EUR"
        },
        "shippingGroupId": "group2"
      }
    ]
  }'
```

## Add delivery times

Delivery times specify days of the week and hours of the day on which orders can be delivered. They are defined for particular shipping zones.

Add delivery times by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-delivery-time" size="small">Creating a delivery time</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/{site}/zones/{zoneId}/methods' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: fr' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "fedex-2dayground",
    "name": "FedEx 2Day",
    "active": true,
    "maxOrderValue": {
      "amount": 5000,
      "currency": "EUR"
    },
    "fees": [
      {
        "minOrderValue": {
          "amount": 0,
          "currency": "EUR"
        },
        "cost": {
          "amount": 10,
          "currency": "EUR"
        }
      },
      {
        "minOrderValue": {
          "amount": 50,
          "currency": "EUR"
        },
        "cost": {
          "amount": 9,
          "currency": "EUR"
        },
        "shippingGroupId": "group1"
      },
      {
        "minOrderValue": {
          "amount": 200,
          "currency": "EUR"
        },
        "cost": {
          "amount": 8,
          "currency": "EUR"
        },
        "shippingGroupId": "group2"
      }
    ]
  }'
```

## Add delivery slots

Delivery slots specify periods during the day, when the delivery can take place. You can create multiple slots for every day.

Add delivery time slots by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-delivery-time-slot" size="small">Creating a delivery time slot</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X POST \
  'https://api.emporix.io/shipping/{tenant}/delivery-times/{deliveryTimeId}/slots?validateOverlap=true' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "shippingMethod": "method2",
    "deliveryTimeRange": {
      "timeFrom": "10:00",
      "timeTo": "12:00"
    },
    "cutOffTime": {
      "time": "2023-06-12T06:00:00.000Z",
      "cutOffDayShift": 1,
      "deliveryCycleName": "evening"
    },
    "capacity": 100
  }'
```


# How to manage delivery and shipping information upon checkout

You need to retrieve available delivery windows to be able to estimate the delivery time for a specific postal code. At checkout, updating the cart with delivery and shipping information is necessary for the order to be placed.

1. [Retrieve available delivery windows](#retrieve-available-delivery-windows-for-a-particular-postal-code-and-cart).
2. [Add delivery information to the customer's cart](#update-the-cart-with-delivery-information).

## Before you start

1. Ensure that you have already finished the [*How to configure delivery and shipping settings*](#how-to-configure-delivery-and-shipping-settings) tutorial.
2. Ensure that you have created at least one customer.
3. Ensure that you have configured payment options. For more information on payments, check out [*How to enable payment methods*](/content/site-settings#how-to-enable-payment-methods).
4. Ensure that the order settings are configured. For more information, check out the [Order Service API Reference](/openapi/order/).

## Retrieve available delivery windows for a particular postal code and cart

Shipping times for particular postal codes are automatically calculated based on the business' shipping configuration, for example shipping capacity, or cut-off time.
Retrieve delivery windows by calling the <nobr><Button to="/openapi/shipping/#operation/GET-shipping-retrieve-customer-group-relations" size="small">Retrieving delivery windows by cart</Button></nobr> endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X GET \
  'https://api.emporix.io/shipping/{tenant}/{site}/cgrelations/{customerId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
  ```

## Update the cart with delivery information

Add the delivery information to the cart by calling the <nobr><Button to="/openapi/cart/#operation/PUT-cart-update-cart" size="small">Updating a cart</Button></nobr> endpoint.


{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/cart/{tenant}/carts/{cartId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "customerId": "87413250",
    "currency": "EUR",
    "deliveryWindowId": "60006da77ec20a807cd6f065",
    "type": "wishlist",
    "zipCode": "10115",
    "countryCode": "DE",
    "status": "OPEN",
    "deliveryWindow": {
      "id": "5b5572a61cf31a000f31eee4",
      "deliveryDate": "2023-06-06T12:00:00.000Z",
      "slotId": "5678-8756-3321-1234"
    },
    "channel": {
      "name": "storefront",
      "source": "https://your-storefront.com/"
    },
    "metadata": {
      "mixins": {
        "generalAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/orderGeneralAttributesMixIn.v9.json",
        "deliveryTime": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/deliveryTimeMixIn.v2.json"
      }
    },
    "mixins": {
      "deliveryTime": {
        "deliveryDate": "2021-06-08T12:00:00.000Z",
        "deliveryTimeId": "5f5a3da02d48b9000d39798c"
      }
    }
  }'
```
