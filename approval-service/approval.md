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

## Scopes rules

Only the customers from `B2B_REQUESTER` and `B2B_BUYER` groups can create an approval, and only a customer of the same company can be chosen as an approver. An approver needs to be assigned to the `B2B_ADMIN` or `B2B_BUYER` group.

An approval for a given resource can be created only by the resource’s owner. The approval can be updated, but only if it's still pending processing — the status is then visible as `PENDING`.

Customers can manage only the approvals which are assigned to them. The scopes are granted automatically when a customer is logged in to our system.

The scopes that are granted depend on the user group to which the user is assigned. Nevertheless, if a token needs to be generated based on an API key, then you can use the OAuth service to get the token:

👉 [OAuth Service – Customer Token](https://developer.emporix.io/docs/openapi/oauth/#tag/Customer-Token)

## How to manage approvals

An approval can be created only by a customer who doesn't have the permission to trigger the checkout, which means to create an order.

Only customers from the `B2B_REQUESTER` and `B2B_BUYER` groups can create an approval.

Customers from the `B2B_BUYER` group can create approval only when the cost of the order exceeds the company limit, then the approval from an admin is required.

### Create an approval

You can use the following endpoint:

**POST /approval/create-approval**

[View in API reference](https://developer.emporix.io/docs/openapi/approval/#operation/POST-approval-create-approval)

_Default example_: An approval request for cart checkout

---

### Update an approval

After creating the approval, items can be updated by the PATCH endpoint. Customers can change the status, details, delivery window and comment of the approval.

**PATCH /approval/update-approval**

[View in API reference](https://developer.emporix.io/docs/openapi/approval/#operation/PATCH-approval-update-approval)

_Default example_: Multiple update list

---

### Retrieve an approval

Approvals can be fetched by a customer. Only the approval which is assigned to the customer is returned.

**GET /approval/retrieve-approval**

[View in API reference](https://developer.emporix.io/docs/openapi/approval/#operation/GET-approval-retrieve-approval)

_Default example_: An approval retrieved by a customer
