---
layout:
  width: wide
icon: rectangle-terminal
---

# Customer Service (Tenant Managed) Tutorial

The steps described in this tutorial demonstrate how you, as a merchant, can manage the accounts of your customers on their behalf. 

## How to manage a customer's profile

{% stepper %}
{% step %}
### Get an employee access token

Firstly, obtain a relevant access token to be able to perform operations as an employee on behalf of a customer. Call the OAuth Service [Requesting a service access token](https://developer.emporix.io/api-references/api-guides/authorization/oauth-service/api-reference/service-access-token) endpoint to get credetials of a technical client with the `customer.customer_manage` and `customer.customer_manage_own` scopes assigned. The `customer.customer_manage_own` is required only when you ant to let a customer manage customer profiles from the same company.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/oauth/token' 
  --header 'Content-Type: application/x-www-form-urlencoded' 
  --data 'grant_type=client_credentials&client_id={CLIENT_ID}&client_secret={CLIENT_SECRET}&scope=customer.customer_manage customer.customer_manage_own'
```

The returned `access_token` is required in the steps that follow.
{% endstep %}

{% step %}

### Create a customer account
Crete a new customer by calling the [Creating a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-service/api-reference/" %}
[api-reference](../../companies-and-customers/customer-service/api-reference/)
{% endcontent-ref %}

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers?sendPasswordResetNotifications=true" 
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN" 
  -H "Content-Type: application/json" 
  -d '{
    "contactEmail": "john.doe@emporix.com",
    "title": "MR",
    "firstName": "John",
    "lastName": "Doe",
    "contactPhone": "123456789",
    "company": "Emporix",
    "preferredLanguage": "en_US",
    "preferredCurrency": "EUR",
    "preferredSite": "main",
    "b2b": {
      "companyRegistrationId": "123-456-789"
    }
  }'
```
The successful response returns the `201 Created` status and the customer's assigned ID, for example:

```
{
  "id": "47718865"
}
```
{% endstep %}

{% step %}
### Update the customer account
If you need to update any information in the customer's profile, send the request to the [Upserting a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#put-customer-tenant-customers-customernumber) endpoint. The endpoint performs the upsert operation replacing the primary data or creating a new customer's account if it doesn't exist.

For example, update the customer's email:

```bash
curl -X PUT "https://api.emporix.io/customer/mytenant/customers/{customerNumber}" 
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN" 
  -H "Content-Type: application/json" 
  -d '{
    "contactEmail": "john.updated@emporix.com",
    "firstName": "John",
    "lastName": "Doe",
    "preferredLanguage": "de_DE"
  }'
```
{% endstep %}

{% step %}

### Add addresses to the profile
To add an address to the customer's profile, call the [Adding a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses) endpoint: 

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}/addresses" 
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN" 
  -H "Content-Type: application/json" 
  -d '{
    "contactName": "John Doe",
    "companyName": "Emporix",
    "street": "Platz der Republik",
    "streetNumber": "1",
    "zipCode": "11011",
    "city": "Berlin",
    "country": "DE",
    "state": "Berlin",
    "contactPhone": "123456789",
    "tags": ["BILLING", "SHIPPING"],
    "isDefault": true
  }'
```

Response (`201 Created`):
```
{
  "id": "e6eae2c789"
}
```
{% endstep %}

{% step %}

### Add tags to customer addresses
To add any tags to the address for better visibility, send the request to the [Adding tags to a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses-addressid-tags) endpoint.

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}/addresses/{addressId}/tags?tags=PRIMARY_CONTACT" \
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN"
```
{% hint style="info" %}
To remove a tags later, call the same path with `DELETE` operation.
{% endhint%}

{% endstep %}

{% step %}

### Assign an account to the profile
You can assign the created customer's account to an existing profile in the database. Send the request to the [Assigning an account to an existing customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers-customernumber-accounts-internal) endpoint with the customer email address in the body.

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}}/customers/{customerNumber}/accounts/internal" \
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john.doe@emporix.com"
  }'
```

{% endstep %}

{% step %}
### Activate the customer

To update a customer's activation status, use the `PATCH` endpoint for [Updating a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber).

```bash
curl -X PATCH "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}" 
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN" 
  -H "Content-Type: application/json" 
  -d '{
    "active": true,
    "onHold": false
  }'
```
{% step %}

### Retrieve the customer's profile
Verify the customer's details assigned to their profile by calling the [Retrieving a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers-customernumber) endpoint.

```bash
curl -X GET "https://api.emporix.io/customer/{tenant}/customers/{customerNimber}?expand=addresses,accounts" \
  -H "Authorization: Bearer YOUR_OAUTH2_TOKEN"
```

Example successful response includes all the assigned details:
```
{
  "title": "MR",
  "firstName": "John",
  "lastName": "Doe",
  "contactPhone": "123456789",
  "company": "Emporix",
  "preferredLanguage": "de_DE",
  "preferredCurrency": "EUR",
  "preferredSite": "main",
  "metadata": {
    "version": 6
  },
  "customerNumber": "13869000",
  "id": "13869000",
  "contactEmail": "john.updated@emporix.com",
  "active": true,
  "onHold": false,
  "businessModel": "B2B",
  "b2b": {
    "companyRegistrationId": "123-456-789",
    "legalEntities": [
      {
        "id": "D165356",
        "name": "Emporix",
        "contactAssignmentId": "D436432"
      }
    ]
  },
  "addresses": [
    {
      "id": "e6eae2c789",
      "contactName": "John Doe",
      "street": "Platz der Republik",
      "streetNumber": "1",
      "zipCode": "11011",
      "city": "Berlin",
      "country": "DE",
      "state": "Berlin",
      "contactPhone": "123456789",
      "tags": ["BILLING", "SHIPPING", "PRIMARY_CONTACT"],
      "isDefault": true
    }
  ],
  "accounts": [
    {
      "id": "john.doe@emporix.com"
    }
  ]
}
```
{% endstep %}

{% endstepper %}
