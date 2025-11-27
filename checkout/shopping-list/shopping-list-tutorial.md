---
layout:
  width: wide
icon: graduation-cap
---

# Shopping List Tutorial

The Shopping List Service allows you to convienently manage a customer's frequently purchased items in a reusable shopping lists. 

## How to create and use a shopping list

Follow these steps to authenticate, impersonate a customer, and manage shopping lists with the Shopping List Service.


{% stepper %}
{% step %}
### Get an employee access token

Use the OAuth client credentials flow with a technical client that has `shoppinglist.shoppinglist_manage` and `shoppinglist.shoppinglist_read` scopes assigned. This token lets you perform employee operations such as managing lists for any customer.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../authorization/oauth-service/api-reference/" %}
[api-reference](../../authorization/oauth-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/oauth/token' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data 'grant_type=client_credentials&client_id={CLIENT_ID}&client_secret={CLIENT_SECRET}&scope=shoppinglist.shoppinglist_manage shoppinglist.shoppinglist_read'
```

Store the returned `access_token` to use it in the following steps.
{% endstep %}

{% step %}
### Create a shopping list on behalf of a customer

With the employee token, call the [Creating a shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-list#post-shoppinglist-tenant-shopping-lists) endpoint and provide the customer ID in the body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/shoppinglist/{tenant}/shopping-lists' \
  --header 'Authorization: Bearer {EMPLOYEE_TOKEN}' \
  --header 'Content-Type: application/json' \
  --data '{
    "customerId": "C120043",
    "name": "weekly-delivery",
    "items": [
      {
        "id": 1,
        "productId": "55cdcd91a88ed11babd7ca7e",
        "quantity": 7.1,
        "cuttingOption": "small",
        "servicePackagingOption": "paper",
        "comment": "Handle with care"
      }
    ]
  }'
```

The response returns the ID of the customer for which the shopping list was created.
{% endstep %}

{% step %}
### Log in as a customer

To let a customer manage their own lists, exchange their storefront credentials for a `CustomerAccessToken`. Use the [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) endpoint and note the returned bearer token.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../companies-and-customers/customer-management/api-reference/" %}
[api-reference](../../companies-and-customers/customer-management/api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/customer/{tenant}/login' \
  --header 'Content-Type: application/json' \
  --data '{
    "username": "alice@example.com",
    "password": "{CUSTOMER_PASSWORD}"
  }'
```

Tokens issued here only give access to the requesting customer’s resources. You do not need to supply the `customerId` in the Shopping List requests because it is derived from the token.
{% endstep %}

{% step %}
### Create your own shopping list as a customer

Authenticate with the `CustomerAccessToken` from the previous step and call the shopping list creation endpoint: [Creating a shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-list#post-shoppinglist-tenant-shopping-lists). Skipping the `customerId` field automatically links the list to the logged-in customer.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request POST \
  --url 'https://api.emporix.io/shoppinglist/{tenant}/shopping-lists' \
  --header 'Authorization: Bearer {CUSTOMER_TOKEN}' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "holiday-menu",
    "customAttributes": {
      "occasion": "XMAS25"
    },
    "items": [
      {
        "id": 1,
        "productId": "75cdcd91a88ed11babd7ca9i",
        "quantity": 3.5
      },
      {
        "id": 2,
        "productId": "23cdcd91a88ed11babd7ca7y",
        "quantity": 1.25,
        "comment": "Family favorite"
      }
    ]
  }'
```

Expect a `201 Created` response with the assigned `customerId`.
{% endstep %}

{% step %}
### Retrieve all shopping lists

Use the [Retrieving a shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-list#get-shoppinglist-tenant-shopping-lists) endpoint to return all the shopping lists.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request GET \
  --url 'https://api.emporix.io/shoppinglist/{tenant}/shopping-lists' \
  --header 'Authorization: Bearer {ACCESS_TOKEN}'
```

The response is an array where each entry contains the `customerId`, the list `name`, and its `items`.
{% endstep %}

{% step %}
### Update a shopping list for a customer

To edit a customer’s list, call the [Updating a customer shopping list](https://developer.emporix.io/api-references/api-guides/checkout/shopping-list/api-reference/shopping-list#put-shoppinglist-tenant-shopping-lists-customerid) endpoint. Employees can pass any `customerId` while customers can only update their own lists (the service infers their ID from the token).

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L \
  --request PUT \
  --url 'https://api.emporix.io/shoppinglist/{tenant}/shopping-lists/{customerId}?name=holiday-menu' \
  --header 'Authorization: Bearer {ACCESS_TOKEN}' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "holiday-menu",
    "items": [
      {
        "id": 1,
        "productId": "75cdcd91a88ed11babd7ca9i",
        "quantity": 4,
        "comment": "Need extras"
      },
      {
        "id": 2,
        "productId": "23cdcd91a88ed11babd7ca7y",
        "quantity": 0,
        "comment": "Remove from list"
      }
    ]
  }'
```

A `204 No Content` response confirms the update. 
{% endstep %}
{% endstepper %}

