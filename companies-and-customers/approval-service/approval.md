---
seo:
  title: Approval Service Tutorials
  description: Approvals Management
---

# Approval Tutorials

The feature allows customers to manage approval processes for orders.

Four new scopes are added to the functionality:

Designed for a customer:

* `approval.approval_read_own`
* `approval.approval_manage_own`

Designed for a customer, admin (`B2B_ADMIN`), buyer (`B2B_BUYER`) and requester (`B2B_REQUESTER`):

* `approval.approval_read`
* `approval.approval_manage`

> [!INFO]
> Users are able to read or manage only the approvals that are assigned to them.

# Scopes rules

Only the customers from `B2B_REQUESTER` and `B2B_BUYER` groups can create an approval, and only a customer of the same company can be chosen as an approver. An approver needs to be assigned to the `B2B_ADMIN` or `B2B_BUYER` group.

An approval for a given resource can be created only by the resource’s owner. The approval can be updated, but only if it's still pending processing — the status is then visible as `PENDING`.

Customers can manage only the approvals which are assigned to them. The scopes are granted automatically when a customer is logged in to our system.

The scopes that are granted depend on the user group to which the user is assigned. Nevertheless, if a token needs to be generated based on an API key, then you can use the OAuth service to get the token:

👉 [OAuth Service – Customer Token](https://developer.emporix.io/docs/openapi/oauth/#tag/Customer-Token)

# How to manage approvals

An approval can be created only by a customer who doesn't have the permission to trigger the checkout, which means to create an order.

Only customers from the `B2B_REQUESTER` and `B2B_BUYER` groups can create an approval.

Customers from the `B2B_BUYER` group can create approval only when the cost of the order exceeds the company limit, then the approval from an admin is required.

## Create an approval

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

**POST /approval/create-approval**

```bash
curl -i -X POST \
  'https://api.emporix.io/approval/{tenant}/approvals' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "64e241ced632aa413a27a318",
    "resourceType": "CART",
    "resourceId": "cartId",
    "action": "CHECKOUT",
    "approver": {
      "userId": "aaa2f2b6-7dc8-45ff-9f20-4e6163c14cbb"
    },
    "comment": "Comment to the approval user",
    "details": {
      "currency": "EUR",
      "paymentMethods": [
        {
          "provider": "stripe",
          "customAttributes": {
            "paymentType": "invoice"
          },
          "method": "invoice",
          "amount": 3
        }
      ],
      "shipping": {
        "zoneId": "deliveryarea",
        "methodId": "4-more_hours_timeframe",
        "amount": 10,
        "methodName": "Delivery method name",
        "shippingTaxCode": "STANDARD"
      },
      "payment": {
        "paymentId": "636cc738-f0cd-11ed-a05b-0242ac120003",
        "customAttributes": {
          "attribute1": "value of the attribute1",
          "attribute2": "value of the attribute2"
        }
      },
      "addresses": [
        {
          "contactName": "John Doe",
          "street": "Fritz-Elsas-Straße",
          "streetNumber": "20",
          "streetAppendix": "",
          "zipCode": "70173",
          "city": "Stuttgart",
          "country": "DE",
          "type": "SHIPPING",
          "contactPhone": "123456789"
        },
        {
          "contactName": "John Doe",
          "street": "Fritz-Elsas-Straße",
          "streetNumber": "20",
          "streetAppendix": "",
          "zipCode": "70173",
          "city": "Stuttgart",
          "country": "DE",
          "type": "BILLING",
          "contactPhone": "123456789"
        }
      ]
    }
  }'
  ```

## Update an approval

After creating the approval, items can be updated by the PATCH endpoint. Customers can change the status, details, delivery window and comment of the approval.

**PATCH /approval/update-approval**

```bash
curl -i -X PATCH \
  'https://api.emporix.io/approval/{tenant}/approvals/{approvalId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

---

## Retrieve an approval

Approvals can be fetched by a customer. Only the approval which is assigned to the customer is returned.

**GET /approval/retrieve-approval**

```bash
curl -i -X GET \
  'https://api.emporix.io/approval/{tenant}/approvals/{approvalId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```
