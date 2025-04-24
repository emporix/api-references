---
seo:
  title: Customer Management Service Tutorials
  description: client management, customer management, client, clients, contact, contacts, subsidiary, subsidiaries
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
} from '@redocly/developer-portal/ui';
import { Preview } from '../components/Preview.tsx'

# Customer Management Service Tutorials

Take a look at the relationships between objects in the Customer Management Service and other resources in the Emporix Commerce Engine. Click the diagram to enlarge it:

<Preview src="/docs/customer-management/customer-service.svg"></Preview>

## How to set up business customer information

Setting up a business customer's information is a process made up of two steps:

1. [Adding a location](#add-a-location).
2. [Adding a legal entity](#add-a-legal-entity).

### Before you start

Make sure you have marked the country in which the company operates as **active**. You can do it by sending a request to the <nobr><Button to="/openapi/country/#operation/PATCH-country-update-country" size="small">Updating a country</Button></nobr> endpoint in the Emporix API Country Service.

### Add a location

A location is a physical address where a company operates, such as its headquarters, office, or warehouse. To add a new location, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-location" size="small">Creating a new location</Button></nobr> endpoint.

<OpenApiTryIt
  definitionId="customer-management"
  operationId="POST-customer-mgmt-create-location"
  properties={{
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
        "countryCode": "US"
    }
  }}
/>

{% hint style="warning" %}

The `id` from the response is further referred to as `locationId`.

{% endhint %}

### Add a legal entity

A legal entity is a representation of a company. To add a new legal entity, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-legal-entity" size="small">Creating a new legal entity</Button></nobr> endpoint and provide the `locationId` in the request body.

<OpenApiTryIt
  definitionId="customer-management"
  operationId="POST-customer-mgmt-create-legal-entity"
  properties={{
    "name": "Sample Company",
    "type": "COMPANY",
    "legalInfo": {
        "legalName": "Sample Company Ltd",
        "registrationDate": "2022-03-31T13:18:02.379Z",
        "registrationAgency": "Registration Agency Name",
        "countryOfRegistration": "DE",
        "taxRegistrationNumber": "12345"
    },
    "accountLimit": 1000.99,
    "entitiesAddresses": [
        {
            "id": " "
        }
    ]
  }}
/>

## How to add a subsidiary

Subsidiaries are companies legally owned or controlled by other companies. In the Emporix Commerce Engine, subsidiaries are structured the same way as regular companies — the only difference is that a subsidiary must have its parent company specified.

### Before you start

Make sure you have already finished the [How to set up business customer information](#how-to-set-up-business-customer-information) tutorial.

### Retrieve the ID of the parent company

To find out what a company's ID is, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/GET-customer-mgmt-list-legal-entities" size="small">Retrieving all legal entities</Button></nobr> endpoint and use the `q` query parameter to find the desired company.

<OpenApiTryIt
  definitionId="customer-management"
  operationId="GET-customer-mgmt-list-legal-entities"
  parameters={{
    query: {
        "name": " ",
        "fields": "name,id",
        "type": "COMPANY"
    }
  }}
/>

{% hint style="warning" %}

The `id` from the response is further referred to as `parentId`.

{% endhint %}

### Add a subsidiary

Subsidiaries are added similarly to their parent companies. To add a new subsidiary, send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-legal-entity" size="small">Creating a new legal entity</Button></nobr> endpoint. In the request body, set the `type` field to `SUBSIDIARY` and provide the `parentId`.

<OpenApiTryIt
  definitionId="customer-management"
  operationId="POST-customer-mgmt-create-legal-entity"
  defaultExample="Create a subsidiary"
  properties={{
    "name": "Sample Subsidiary",
    "type": "SUBSIDIARY",
    "legalInfo": {
        "legalName": "Sample Subsidiary Ltd",
        "registrationDate": "2022-03-31T13:18:02.379Z",
        "registrationAgency": "Company's Registration agency",
        "countryOfRegistration": "DE",
        "taxRegistrationNumber": "12345"
    },
    "parentId": " ",
    "accountLimit": 1000.99
  }}
/>


## How to add an employee to a company's customer group

You can offer personalized pricing to your business customers' employees by adding them to company customer groups. A company customer group is automatically created when that company's data is added to the system.

{% hint style="warning" %}

When added to a subsidiary’s customer group, the employee is also automatically assigned to customer groups of all the subsidiary’s parent companies.

{% endhint %}

### Before you start

Make sure the following requirements are fulfilled:

* You have already finished the [How to set up business customer information](#how-to-set-up-business-customer-information) tutorial.
* The employee has their customer account set up.

{% hint style="warning" %}

A customer account can be created by the employee themselves or from your Emporix tenant's side. For more information, check out the following endpoints in the  Emporix API Reference:

* <nobr><Button to="/openapi/customer-customer/#operation/POST-customer-create-customer-account" size="small">Creating a new customer (customer-managed)</Button></nobr>
* <nobr><Button to="/openapi/customer-tenant/#operation/POST-customer-tenant-create-customer" size="small">Creating a new customer (tenant-managed)</Button></nobr>

{% endhint %}

### Retrieve the ID of the company

To find out what a company's ID is, you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/GET-customer-mgmt-list-legal-entities" size="small">Retrieving all legal entities</Button></nobr> endpoint and use the `q` query parameter to find the desired company.

<OpenApiTryIt
  definitionId="customer-management"
  operationId="GET-customer-mgmt-list-legal-entities"
  parameters={{
    query: {
        "q": "name=companyName",
        "fields": "name,id,customerGroups"
    }
  }}
/>

{% hint style="warning" %}

The `id` from the response is further referred to as `legalEntityId`.

{% endhint %}

### Retrieve the employee's customer ID

To retrieve an employee's customer ID, you need to send a request to the <nobr><Button to="/openapi/customer-tenant/#operation/GET-customer-tenant-list-customers" size="small">Retrieving a list of customers</Button></nobr> endpoint and use the `q` query parameter. For example, you can search for a customer with a specific email address with  `q=contactEmail:employeeEmail`.

<OpenApiTryIt
  definitionId="customer-tenant"
  operationId="GET-customer-tenant-list-customers"
    parameters={{
    query: {
        "q": "contactEmail:"
    }
  }}
/>

{% hint style="warning" %}

The `id` from the response is further referred to as `customerId`.

{% endhint %}

### Assign the contact to the company

A contact represents an employee of one or more business customers.
To assign a contact to a legal entity (in this case, the desired company), you need to send a request to the <nobr><Button to="/openapi/customer-management/#operation/POST-customer-mgmt-create-contact-assignment" size="small">Creating a new contact assignment</Button></nobr> endpoint and provide `legalEntityId` and `customerId` in the request body.

<OpenApiTryIt
  definitionId="customer-management"
  operationId="POST-customer-mgmt-create-contact-assignment"
  properties={{
    "legalEntity": {
        "id": " "
    },
    "customer": {
        "id": " "
    },
    "type": "PRIMARY",
    "primary": true
  }}
/>

Once desired employees are added to appropriate customer groups, you can — for example — create personalized price lists for them. For instructions, check out [*How to configure a price list*](/content/price#how-to-configure-a-price-list) in the *Price Service guide*.

