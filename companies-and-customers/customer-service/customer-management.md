---
seo:
  title: Customer Management Service Tutorials
  description: client management, customer management, client, clients, contact, contacts, subsidiary, subsidiaries
---

# Customer Management

Take a look at the relationships between objects in the Customer Management Service and other resources in the Emporix Commerce Engine. Click the diagram to enlarge it:

<figure><img src="../../../../static/customer-management/customer-service.svg" alt=""><figcaption></figcaption></figure>

# How to set up business customer information

Setting up a business customer's information is a process made up of two steps:

1. [Adding a location](#add-a-location).
2. [Adding a legal entity](#add-a-legal-entity).

## Before you start

Make sure you have marked the country in which the company operates as **active**. You can do it by sending a request to the <nobr><Button to="/openapi/country/#operation/PATCH-country-update-country" size="small">Updating a country] endpoint in the Emporix API Country Service.

## Add a location

A location is a physical address where a company operates, such as its headquarters, office, or warehouse. To add a new location, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-location" size="small">Creating a new location] endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-management/{tenant}/locations' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Main HQ",
    "type": "HEADQUARTER",
    "contactDetails": {
      "emails": [
        "jon.doe@example.com",
        "adam.smith@sample.org"
      ],
      "phones": [
        "1234567890",
        "123456789"
      ],
      "addressLine1": "W Sample St",
      "addressLine2": "3601-3799",
      "city": "South Bend",
      "state": "Indiana",
      "postcode": "46619",
      "countryCode": "US",
      "tags": [
        "shipping"
      ]
    }
  }'
```

{% hint style="warning" %}

The `id` from the response is further referred to as `locationId`.

{% endhint %}

## Add a legal entity

A legal entity is a representation of a company. To add a new legal entity, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-legal-entity" size="small">Creating a new legal entity] endpoint and provide the `locationId` in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-management/{tenant}/legal-entities' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Company name",
    "type": "COMPANY",
    "legalInfo": {
      "legalName": "Some company name",
      "registrationDate": "2022-03-31T13:18:02.379Z",
      "registrationAgency": "Comp reg agency",
      "registrationId": "627e06ecf0452c2d6c0b81391",
      "countryOfRegistration": "DE",
      "taxRegistrationNumber": "1234"
    },
    "accountLimit": {
      "currency": "EUR",
      "value": 1000.99
    },
    "customerGroups": [
      {
        "id": "123e06ecf0452c2d6c0b81390",
        "name": {
          "en": "En customer group name",
          "de": "De customer group name"
        }
      }
    ],
    "entitiesAddresses": [
      {
        "id": "123e123455452c2d6c0b81390"
      },
      {
        "id": "123e06ecf0acd223140b12345"
      }
    ],
    "approvalGroup": [
      {
        "id": "123e121111452c12330b81390"
      },
      {
        "id": "123e061110acd223133333345"
      }
    ]
  }'
```

# How to add a subsidiary

Subsidiaries are companies legally owned or controlled by other companies. In the Emporix Commerce Engine, subsidiaries are structured the same way as regular companies — the only difference is that a subsidiary must have its parent company specified.

## Before you start

Make sure you have already finished the [How to set up business customer information](#how-to-set-up-business-customer-information) tutorial.

## Retrieve the ID of the parent company

To find out what a company's ID is, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/GET-customer-mgmt-list-legal-entities" size="small">Retrieving all legal entities] endpoint and use the `q` query parameter to find the desired company.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-management/{tenant}/legal-entities?pageNumber=1&pageSize=16&sort=name%2Cmetadata.createdAt%3Adesc&q=name%3A~john&fields=name%2Ctype&id=string&name=string&type=COMPANY&parentId=string&legalInfo.legalName=string&legalInfo.registrationDate=string&legalInfo.taxRegistrationNumber=string&legalInfo.registrationAgency=string&legalInfo.countryOfRegistration=string&legalInfo.registrationId=string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'X-Total-Count: false'
```

{% hint style="warning" %}

The `id` from the response is further referred to as `parentId`.

{% endhint %}

## Add a subsidiary

Subsidiaries are added similarly to their parent companies. To add a new subsidiary, send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-legal-entity" size="small">Creating a new legal entity] endpoint. In the request body, set the `type` field to `SUBSIDIARY` and provide the `parentId`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-management/{tenant}/legal-entities' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Company name",
    "type": "COMPANY",
    "legalInfo": {
      "legalName": "Some company name",
      "registrationDate": "2022-03-31T13:18:02.379Z",
      "registrationAgency": "Comp reg agency",
      "registrationId": "627e06ecf0452c2d6c0b81391",
      "countryOfRegistration": "DE",
      "taxRegistrationNumber": "1234"
    },
    "accountLimit": {
      "currency": "EUR",
      "value": 1000.99
    },
    "customerGroups": [
      {
        "id": "123e06ecf0452c2d6c0b81390",
        "name": {
          "en": "En customer group name",
          "de": "De customer group name"
        }
      }
    ],
    "entitiesAddresses": [
      {
        "id": "123e123455452c2d6c0b81390"
      },
      {
        "id": "123e06ecf0acd223140b12345"
      }
    ],
    "approvalGroup": [
      {
        "id": "123e121111452c12330b81390"
      },
      {
        "id": "123e061110acd223133333345"
      }
    ]
  }'
```

# How to add an employee to a company's customer group

You can offer personalized pricing to your business customers' employees by adding them to company customer groups. A company customer group is automatically created when that company's data is added to the system.

{% hint style="warning" %}

When added to a subsidiary’s customer group, the employee is also automatically assigned to customer groups of all the subsidiary’s parent companies.

{% endhint %}

## Before you start

Make sure the following requirements are fulfilled:

* You have already finished the [How to set up business customer information](#how-to-set-up-business-customer-information) tutorial.
* The employee has their customer account set up.

{% hint style="warning" %}

A customer account can be created by the employee themselves or from your Emporix tenant's side. For more information, check out the following endpoints in the  Emporix API Reference:

* <nobr><Button to="/openapi/customer-customer/#operation/POST-customer-create-customer-account" size="small">Creating a new customer (customer-managed)]
* <nobr><Button to="/openapi/customer-tenant/#operation/POST-customer-tenant-create-customer" size="small">Creating a new customer (tenant-managed)]

{% endhint %}

## Retrieve the ID of the company

To find out what a company's ID is, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/GET-customer-mgmt-list-legal-entities" size="small">Retrieving all legal entities] endpoint and use the `q` query parameter to find the desired company.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-management/{tenant}/legal-entities?pageNumber=1&pageSize=16&sort=name%2Cmetadata.createdAt%3Adesc&q=name%3A~john&fields=name%2Ctype&id=string&name=string&type=COMPANY&parentId=string&legalInfo.legalName=string&legalInfo.registrationDate=string&legalInfo.taxRegistrationNumber=string&legalInfo.registrationAgency=string&legalInfo.countryOfRegistration=string&legalInfo.registrationId=string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'X-Total-Count: false'
```

{% hint style="warning" %}

The `id` from the response is further referred to as `legalEntityId`.

{% endhint %}

## Retrieve the employee's customer ID

To retrieve an employee's customer ID, you need to send a request to the <nobr><Button to="/openapi/customer-tenant/#operation/GET-customer-tenant-list-customers" size="small">Retrieving a list of customers] endpoint and use the `q` query parameter. For example, you can search for a customer with a specific email address with  `q=contactEmail:employeeEmail`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer/{tenant}/customers?q=contactEmail%3A{email}&sort=string&pageNumber=1&pageSize=60&expand=string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

{% hint style="warning" %}

The `id` from the response is further referred to as `customerId`.

{% endhint %}

## Assign the contact to the company

A contact represents an employee of one or more business customers.
To assign a contact to a legal entity (in this case, the desired company), you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-contact-assignment" size="small">Creating a new contact assignment] endpoint and provide `legalEntityId` and `customerId` in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-management/{tenant}/contact-assignments' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "legalEntity": {
      "id": "612306ecf0452c2d6c0b81392"
    },
    "customer": {
      "id": "612306ecf0452c2d6c0b81123"
    },
    "type": "BILLING",
    "primary": true
  }'
```

Once desired employees are added to appropriate customer groups, you can — for example — create personalized price lists for them. For instructions, check out [*How to configure a price list*](/content/price#how-to-configure-a-price-list) in the *Price Service guide*.

