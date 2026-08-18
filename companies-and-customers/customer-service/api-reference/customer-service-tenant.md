---
layout:
  width: wide
icon: rectangle-terminal
---

# Customer Service (Tenant Managed) Tutorial

Manage your customers conveniently using the Emporix API. As an employee, you can create and update customer profiles on their behalf, import customers in bulk, and configure password migration so imported accounts keep their existing passwords.

## How to manage a customer's profile

The steps described in this tutorial demonstrate how you, as an employee, can manage the accounts of your customers on their behalf. 


{% stepper %}
{% step %}
#### Get an employee access token

Firstly, obtain a relevant access token to be able to perform operations as an employee on behalf of a customer. Call the OAuth Service [Requesting a service access token](https://developer.emporix.io/api-references/api-guides/authentication/oauth-service/api-reference/service-access-token) endpoint to get credentials of a technical client with the `customer.customer_manage` and `customer.customer_manage_own` scopes assigned. The `customer.customer_manage_own` is required only when you want to let a customer manage customer profiles from the same company.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../../authentication/oauth-service/api-reference/" %}
[api-reference](../../../authentication/oauth-service/api-reference/)
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

#### Create a customer account
Create a new customer by calling the [Creating a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#post-customer-tenant-customers) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../../companies-and-customers/customer-service/api-reference/" %}
[api-reference](../../../companies-and-customers/customer-service/api-reference/)
{% endcontent-ref %}

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers?sendPasswordResetNotifications=true" 
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}" 
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

{% hint style="warning" %}
By default, you cannot create a customer with a `customerNumber` that belongs to a previously deleted profile. To allow recreation with the same `customerNumber`, create the `enableRecreationOfDeletedCustomer` tenant configuration in the Configuration Service. For more information, see the examples in [How to create tenant configurations](../../../configuration/configuration-service/configuration-service-tutorial.md#how-to-create-tenant-configurations).
{% endhint %}
{% endstep %}

{% step %}
#### Update the customer account
If you need to update any information in the customer's profile, send the request to the [Upserting a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#put-customer-tenant-customers-customernumber) endpoint. The endpoint performs the upsert operation replacing the primary data or creating a new customer's account if it doesn't exist.

For example, update the customer's email:

```bash
curl -X PUT "https://api.emporix.io/customer/mytenant/customers/{customerNumber}" 
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}" 
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

#### Add addresses to the profile
To add an address to the customer's profile, call the [Adding a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses) endpoint: 

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}/addresses" 
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}" 
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

The response (`201 Created`) returns the id of the created address, for example:

```
{
  "id": "e6eae2c789"
}
```

{% endstep %}

{% step %}

#### Add tags to customer addresses
To add any tags to the address for easier address management, send the request to the [Adding tags to a customer address](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/addresses#post-customer-tenant-customers-customernumber-addresses-addressid-tags) endpoint.

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}/addresses/{addressId}/tags?tags=PRIMARY_CONTACT" \
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}"
```

{% hint style="info" %}
To remove tags later, call the same path with `DELETE` operation.
{% endhint%}

{% endstep %}
{% step %}
#### Activate the customer

As the customer's account preparation is complete, activate their account. To do so, update the customer status using the `PATCH` endpoint for [Updating a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#patch-customer-tenant-customers-customernumber).

```bash
curl -X PATCH "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}" 
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}" 
  -H "Content-Type: application/json" 
  -d '{
    "active": true,
    "onHold": false
  }'
```
{% endstep %}

{% step %}
#### Retrieve the customer's profile
Verify the customer's details assigned to their profile by calling the [Retrieving a customer profile](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/account-and-profile#get-customer-tenant-customers-customernumber) endpoint.

```bash
curl -X GET "https://api.emporix.io/customer/{tenant}/customers/{customerNumber}?expand=addresses,accounts" 
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}"
```

Example successful response includes all the assigned details:

```bash
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
  ]
}
```
{% endstep %}

{% endstepper %}

## How to import customers and migrate passwords

You can import customers in bulk and migrate their passwords from a legacy system. Customers keep their existing passwords with either field. Each imported account must include exactly one of `legacyAuth` or `passwordHash`.

* `legacyAuth` – The supported way to import a non-native password hash. Provide the source hash and algorithm metadata. On the first successful login, Emporix verifies the password with the legacy algorithm and silently rehashes it to the native format. This option requires an active password migration retention configuration.
* `passwordHash` – Use this only when the source hash is already compatible with the Emporix native hashing strategy. The hash is stored as a native hash immediately, so no retention configuration or first-login rehash is needed.

{% hint style="info" %}
For the retention timeline and customer email behavior, see [Password Migration Strategy](https://app.gitbook.com/s/bTY7EwZtYYQYC6GOcdTj/system-management/authentication-and-authorization/customer-authentication/password-migration-strategy).
{% endhint %}

{% stepper %}
{% step %}
#### Get an employee access token

Obtain a service access token for a technical client with the `customer.import_manage` and `customer.import_read` scopes. These scopes are distinct from `customer.customer_manage`. Use `customer.import_manage` to configure retention, import customers, and remove the configuration. Use `customer.import_read` to retrieve the retention configuration.

Call the OAuth Service [Requesting a service access token](https://developer.emporix.io/api-references/api-guides/authentication/oauth-service/api-reference/service-access-token) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../../authentication/oauth-service/api-reference/" %}
[api-reference](../../../authentication/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/oauth/token' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data 'grant_type=client_credentials&client_id={CLIENT_ID}&client_secret={CLIENT_SECRET}&scope=customer.import_manage customer.import_read'
```

The returned `access_token` is required in the steps that follow.
{% endstep %}

{% step %}
#### Configure password migration retention

Create or update the tenant password migration retention configuration before you import customers with `legacyAuth`. Call the [Configuring password migration retention](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/import-and-migration#post-customer-tenant-config-password-migration-retention) endpoint.

`retentionEndDate` is required and must be a future date. `emailReminderDate` and `emailNotificationsEnabled` are optional:

* If you omit `emailReminderDate`, the service defaults to 7 days before `retentionEndDate`, or to tomorrow when that default would fall on or before today.
* If you omit `emailNotificationsEnabled`, the service defaults to `true`. When `false`, customers do not receive emails about the migration.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../../companies-and-customers/customer-service/api-reference/" %}
[api-reference](../../../companies-and-customers/customer-service/api-reference/)
{% endcontent-ref %}

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/config/password-migration-retention" \
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}" \
  -H "Content-Type: application/json" \
  -d '{
    "retentionEndDate": "2027-01-31",
    "emailReminderDate": "2027-01-24",
    "emailNotificationsEnabled": true
  }'
```

A successful response returns `200 OK` and the saved configuration:

```json
{
  "retentionEndDate": "2027-01-31",
  "emailReminderDate": "2027-01-24",
  "emailNotificationsEnabled": true
}
```

{% hint style="info" %}
If emails must include storefront links, or if you need a non-standard email template, contact [Emporix Support](mailto:support@emporix.com).
{% endhint %}
{% endstep %}

{% step %}
#### Retrieve the retention configuration

Verify the saved configuration by calling the [Retrieving password migration retention configuration](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/import-and-migration#get-customer-tenant-config-password-migration-retention) endpoint.

```bash
curl -X GET "https://api.emporix.io/customer/{tenant}/config/password-migration-retention" \
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}"
```

A successful response returns `200 OK` and the current configuration:

```json
{
  "retentionEndDate": "2027-01-31",
  "emailReminderDate": "2027-01-24",
  "emailNotificationsEnabled": true
}
```

If no configuration is set for the tenant, the endpoint returns `404 Not Found`.
{% endstep %}

{% step %}
#### Import customers with non-native hash

Import up to 200 customers in one request by calling the [Importing customers in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/import-and-migration#post-customer-tenant-customers-import) endpoint. Repeat the request until you import the full customer base.

Each item must include an `account` object with `email` and `legacyAuth`. For a non-native hash, `legacyAuth` is the only supported field. Importing with `legacyAuth` requires an active password migration retention configuration. When you provide `contactEmail`, it must match `account.email` (case-insensitive). If you omit `contactEmail`, the service uses `account.email`.

This import does not send welcome emails or run other onboarding logic. Contact [Emporix Support](mailto:support@emporix.com) to confirm the `algorithm` value and `context` metadata for your source system.

{% include "../../.gitbook/includes/example-hint-text.md" %}

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers/import" \
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}" \
  -H "Content-Type: application/json" \
  -d '[
    {
      "contactEmail": "jane.doe@emporix.com",
      "firstName": "Jane",
      "lastName": "Doe",
      "preferredLanguage": "en_US",
      "preferredCurrency": "EUR",
      "preferredSite": "main",
      "account": {
        "email": "jane.doe@emporix.com",
        "legacyAuth": {
          "algorithm": "hybris-sha512-uid-salt",
          "hash": "tBRzNZ+h9FRRm8K1qzDz3aWMgyTlgBihHviEdr+9T82BEODJakLPogHkhkGKF4FGzrhFWMYh6aZ6g5XNN1pmrg==",
          "context": {
            "originalUid": "15TE2000007AE9TOUEILLE 61359"
          }
        }
      }
    }
  ]'
```

The response is `207 Multi-Status`. Each result is returned at the same index as the customer in the request body. A successful item returns `201` and the generated customer `id`.

If an item is invalid, the result at that index is an error, and other items in the same batch can still succeed. For example, when an account is missing `legacyAuth`:

```json
[
  {
    "index": 0,
    "id": "13869000",
    "code": 201,
    "status": "Created"
  },
  {
    "index": 1,
    "code": 400,
    "status": "Bad Request",
    "message": "Exactly one of 'passwordHash' or 'legacyAuth' must be provided in the account"
  }
]
```
{% endstep %}

{% step %}
#### Import customers with native `passwordHash`

Use the same [Importing customers in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/import-and-migration#post-customer-tenant-customers-import) endpoint only when the source hashes are compatible with the Emporix native password hashing strategy. Provide `passwordHash`. Do not send a non-native hash in `passwordHash`. Native-hash imports do not require a password migration retention configuration.

Contact [Emporix Support](mailto:support@emporix.com) to confirm that your existing hashing strategy is compatible.

```bash
curl -X POST "https://api.emporix.io/customer/{tenant}/customers/import" \
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}" \
  -H "Content-Type: application/json" \
  -d '[
    {
      "contactEmail": "john.doe@emporix.com",
      "firstName": "John",
      "lastName": "Doe",
      "preferredLanguage": "en_US",
      "preferredCurrency": "EUR",
      "preferredSite": "main",
      "account": {
        "email": "john.doe@emporix.com",
        "passwordHash": "1:10000:abcdefgh:ijklmnop"
      }
    }
  ]'
```

{% hint style="info" %}
Use `legacyAuth` for a non-native hash and `passwordHash` for a native hash. Provide exactly one of these fields for each imported account.
{% endhint %}
{% endstep %}

{% step %}
#### Remove the retention configuration

When no customer accounts contain a `legacyAuth` record, remove the configuration by calling the [Removing password migration retention configuration](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-service/api-reference/import-and-migration#delete-customer-tenant-config-password-migration-retention) endpoint.

```bash
curl -X DELETE "https://api.emporix.io/customer/{tenant}/config/password-migration-retention" \
  -H "Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}"
```

A successful response returns `204 No Content`.

If any account still contains a `legacyAuth` record, the endpoint returns `400` and does not remove the configuration:

```json
{
  "status": 400,
  "type": "validation_failure",
  "message": "Configuration removal is not possible until password migration is concluded."
}
```

You can still update the configuration to move `retentionEndDate` earlier and complete the migration sooner.
{% endstep %}

{% endstepper %}
