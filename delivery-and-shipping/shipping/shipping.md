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

import {
  Button,
  OpenApiTryIt,
  ExplainStep
} from '@redocly/developer-portal/ui';

# Shipping Service Tutorials


{% hint style="warning" %}

Names and/or descriptions of shipping zones, methods, and groups are localized. When creating a new shipping zone, method, or group, you can specify its name and/or description in one or multiple languages.

Looking for more info on localization? Check out [*Standard practices*](/content/standard-practices).

{% endhint %}

## How to configure delivery and shipping settings

To allow customers to place orders, you need to configure delivery and shipping settings by following the process below:

1. [Create a shipping zone](#create-a-shipping-zone).
2. [Create a shipping group](#create-a-shipping-group).
3. [Assign customers to a shipping group](#assign-customers-to-shipping-groups).
4. [Add shipping methods and define shipping fees](#add-shipping-methods-and-define-fees).
5. [Add delivery times](#add-delivery-times).
6. [Add delivery slots](#add-delivery-slots).

### Before you start

Ensure that you have created at least one customer.

{% hint style="warning" %}

A customer account can be created by the employee themselves or from your Emporix tenant's side. For more information, check out the following endpoints in the  Emporix API Reference:

* <nobr><Button to="/openapi/customer-customer/#operation/POST-customer-create-customer-account" size="small">Creating a new customer (customer-managed)</Button></nobr>
* <nobr><Button to="/openapi/customer-tenant/#operation/POST-customer-tenant-create-customer" size="small">Creating a new customer (tenant-managed)</Button></nobr>

{% endhint %}

### Create a shipping zone

Shipping zones are countries that your business delivers products to. You can create a shipping zone by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-zone" size="small">Creating a shipping zone</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-shipping-zone"
  parameters={{
    header: {
        "Content-Language": "*"
    }
  }}
  defaultExample="Zone create payload with name as a Map"
  properties={{
    "shipTo":[
      {
         "country":"DE"
      }
   ],
   "name":{
      "en":"Germany",
      "de": "Deutschland"
   },
   "id":"germany",
   "default":true
  }}
/>

### Create a shipping group

You can set up shipping groups for customers and define different shipping methods and costs for these groups. To create a shipping group, you need to call the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-group" size="small">Creating a shipping group</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-shipping-group"
  defaultExample="Group create payload with description as a map"
  parameters={{
    header: {
        "Content-Language": "*"
    }
  }}
  properties={{
    "id": "group1",
    "description": {
        "en": "This is the description for the group group1.",
        "de": "Dies ist die Beschreibung für die Gruppe group1."
  }
  }}
/>


### Assign customers to shipping groups

By adding customers to shipping groups, you can offer them different shipping methods and costs.
Assign customers to shipping groups by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-customer-group-relation" size="small">Creating a customer-group relation</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-customer-group-relation"
  properties={{
    "customerId": "C001",
    "groupId": "group1"
  }}
/>

### Add shipping methods and define fees

Add shipping methods and configure shipping fees by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-shipping-method" size="small">Creating a shipping method</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-shipping-method"
  defaultExample= "Method with name as a Map"
  parameters={{
    header: {
        "Content-Language": "*"
    }
  }}
  properties={{
    "fees":[
      {
        "minOrderValue":{
            "currency":"EUR",
            "amount": 1
        },
        "cost":{
            "currency":"EUR",
            "amount": 2.99
        },
        "shippingGroupId":"group1"
      },
      {
        "minOrderValue":{
            "currency":"EUR",
            "amount": 50
        },
        "cost":{
            "currency":"EUR",
            "amount": 9
        },
        "shippingGroupId":"group1"
      },
      {
        "minOrderValue":{
            "currency":"EUR",
            "amount": 200
        },
        "cost":{
            "currency":"EUR",
            "amount": 8
        },
        "shippingGroupId":"group2"
      }
    ],
    "zoneId":"germany",
    "maxOrderValue":{
        "currency":"EUR",
        "amount": 5000
    },
    "shippingTaxCode":"ZERO",
    "name":{
        "en":"FedEx 2Day",
        "de": "FedEx 2Tage"
    },
    "id":"fedex-2dayground",
    "active":true
  }}
/>

### Add delivery times

Delivery times specify days of the week and hours of the day on which orders can be delivered. They are defined for particular shipping zones.

Add delivery times by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-delivery-time" size="small">Creating a delivery time</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-delivery-time"
  properties={{
    "siteCode": "main",
    "name": "deliverytime1",
    "isDeliveryDay": true,
    "zoneId": "zone1",
    "day": {
    "weekday": "FRIDAY"
    },
    "isForAllZones": false,
    "slots": [
    {}
    ]
  }}
/>

### Add delivery slots

Delivery slots specify periods during the day, when the delivery can take place. You can create multiple slots for every day.

Add delivery time slots by calling the <nobr><Button to="/openapi/shipping/#operation/POST-shipping-create-delivery-time-slot" size="small">Creating a delivery time slot</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="POST-shipping-create-delivery-time-slot"
  properties={{
    "shippingMethod": "method2",
    "deliveryTimeRange": {
    "timeFrom": "06:00:00",
    "timeTo": "08:00:00"
    },
    "cutOffTime": {
    "time": "16:00:00",
    "day": "MONDAY",
    "deliveryCycleName": "evening"
    },
    "capacity": 100
}}
/>


## How to manage delivery and shipping information upon checkout

You need to retrieve available delivery windows to be able to estimate the delivery time for a specific postal code. At checkout, updating the cart with delivery and shipping information is necessary for the order to be placed.

1. [Retrieve available delivery windows](#retrieve-available-delivery-windows-for-a-particular-postal-code-and-cart).
2. [Add delivery information to the customer's cart](#update-the-cart-with-delivery-information).

### Before you start

1. Ensure that you have already finished the [*How to configure delivery and shipping settings*](#how-to-configure-delivery-and-shipping-settings) tutorial.
2. Ensure that you have created at least one customer.
3. Ensure that you have configured payment options. For more information on payments, check out [*How to enable payment methods*](/content/site-settings#how-to-enable-payment-methods).
4. Ensure that the order settings are configured. For more information, check out the [Order Service API Reference](/openapi/order/).

### Retrieve available delivery windows for a particular postal code and cart

Shipping times for particular postal codes are automatically calculated based on the business' shipping configuration, for example shipping capacity, or cut-off time.
Retrieve delivery windows by calling the <nobr><Button to="/openapi/shipping/#operation/GET-shipping-retrieve-customer-group-relations" size="small">Retrieving delivery windows by cart</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="shipping"
  operationId="GET-shipping-retrieve-customer-group-relations"
/>

### Update the cart with delivery information

Add the delivery information to the cart by calling the <nobr><Button to="/openapi/cart/#operation/PUT-cart-update-cart" size="small">Updating a cart</Button></nobr> endpoint.


<OpenApiTryIt
  definitionId="cart"
  operationId="PUT-cart-update-cart"
  properties={{
    "deliveryWindowId": "{{deliveryWindowId}}",
    "metadata": {
        "mixins": {
            "deliveryTime": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/deliveryTimeMixIn.v2.json",
            "payment": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/paymentMixIn.v3.json",
            "deliveryOptions": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/deliveryOptionsMixIn.v6.json",
            "generalAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/orderGeneralAttributesMixIn.v9.json"
        }
    },
    "mixins": {
        "deliveryTime": {
            "deliveryDate": "2021-10-22T12:00:00.000Z",
            "deliveryTimeFrom": "17:00",
            "deliveryTimeTo": "22:00",
            "deliveryCosts": 2.99,
            "deliveryTimeId": "{{deliveryTimeId}}"
        },
        "generalAttributes": {
            "extendedOrderStatus": "10",
            "orderType": "CUSTOMER_ORDER",
            "customerFirstOrder": true
        },
        "payment": {
            "paymentType": "paymentByInvoice",
            "paymentCosts": 1
        },
        "deliveryOptions": {
            "substituteProduct": true,
            "packaging": "Paper"
        }
    }
  }}
/>
