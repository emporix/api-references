---
seo:
  title: Customer Segment Service Tutorials
  description: Learn how to create customer segments, assign customers and IAM groups, and use segments on the storefront.
icon: graduation-cap
layout:
  width: wide
description: Learn how to create customer segments, assign customers and IAM groups, and use segments on the storefront.
---

# Segments Tutorial

The Customer Segment Service allows you to group customers for targeted campaigns and personalized storefront content.
You can assign products, categories, individual customers, and IAM groups to a segment.
Customers inherit segment membership through a direct assignment or through an IAM group assigned to the segment.

## How to add a customer segment

Create a segment, assign products or categories, then add customers. To assign IAM groups, see [How to assign IAM groups to a customer segment](#how-to-assign-iam-groups-to-a-customer-segment).

{% hint style="warning" %}
To create and configure a segment, you need the `customersegment.segment_manage` scope.
{% endhint %}

{% stepper %}
{% step %}
#### Create a customer segment

Send the request to the [Creating a customer segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments) endpoint.

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-segment/{tenant}/segments' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Language: en' \
  -H 'Content-Type: application/json' \
  -d '{
    "id": "628cd20c6e8b2432b6346ca6",
    "name": {
      "en": "Golden Segment"
    },
    "description": {
      "en": "Golden Segment"
    },
    "validity": {
      "from": "2026-04-17T08:00:00.000Z",
      "to": "2027-04-17T08:00:00.000Z"
    },
    "status": "ACTIVE",
    "siteCode": "main"
  }'
```

A successful request returns `201` with the segment `id`. If you omit `status`, the service sets the segment to `INACTIVE`.
{% endstep %}

{% step %}
#### Assign products or categories

Assign products or categories so the segment can drive storefront assortment and campaigns.

To assign one product or category, send the request to the [Updating an item assignment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#put-customer-segment-tenant-segments-segmentid-items-type-itemid) endpoint. Set `{type}` to `PRODUCT` or `CATEGORY`.

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/items/PRODUCT/{itemId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "mixins": {
      "segmentAttributes": {
        "membershipStatus": "PREMIUM"
      }
    },
    "metadata": {
      "mixins": {
        "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/69537caeb3fd5d378296ae42_segmentAttributes.json"
      }
    }
  }'
```

To assign multiple items, send the request to the [Updating item assignments to a customer segment in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#put-customer-segment-tenant-segments-segmentid-items-type-bulk) endpoint. The maximum batch size is 200.

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/items/PRODUCT/bulk' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
    {
      "id": "12468504",
      "mixins": {
        "segmentAttributes": {
          "membershipStatus": "PREMIUM"
        }
      },
      "metadata": {
        "mixins": {
          "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/69537caeb3fd5d378296ae42_segmentAttributes.json"
        }
      }
    },
    {
      "id": "12849186",
      "metadata": {
        "version": 2
      }
    }
  ]'
```

{% hint style="info" %}
These operations perform an `UPSERT`. If the item is already assigned to the segment, the assignment is updated. If it is not assigned, the service creates the assignment.
{% endhint %}
{% endstep %}

{% step %}
#### Add customers

Add B2B or B2C customers, depending on your setup.

To add a B2B customer, send the request to the [Updating a customer assignment for a customer segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-customerid-legalentityid) endpoint. Provide `customerId` and `legalEntityId` in the path.

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/customers/{customerId}/{legalEntityId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "mixins": {
      "segmentAttributes": {
        "membershipStatus": "PREMIUM"
      }
    },
    "metadata": {
      "mixins": {
        "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/69537caeb3fd5d378296ae42_segmentAttributes.json"
      }
    }
  }'
```

To add a B2C customer, send the request to the [Updating a customer assignment for a customer segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-customerid) endpoint. Provide `customerId` only.

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/customers/{customerId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "mixins": {
      "segmentAttributes": {
        "membershipStatus": "PREMIUM"
      }
    },
    "metadata": {
      "mixins": {
        "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/69537caeb3fd5d378296ae42_segmentAttributes.json"
      }
    }
  }'
```

To add multiple customers, send the request to the [Updating customer assignments for a customer segment in bulk](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-bulk) endpoint. The maximum batch size is 200.

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/customers/bulk' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '[
    {
      "customerId": "98029737",
      "legalEntityId": "660af2af69babe3cf6e40771",
      "mixins": {
        "segmentAttributes": {
          "membershipStatus": "PREMIUM"
        }
      },
      "metadata": {
        "mixins": {
          "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/69537caeb3fd5d378296ae42_segmentAttributes.json"
        }
      }
    },
    {
      "customerId": "18249883",
      "legalEntityId": "628cd20c6e8b2432b6346ca6",
      "metadata": {
        "version": 1
      }
    }
  ]'
```

{% hint style="info" %}
These operations perform an `UPSERT`. If the customer is already assigned to the segment, the assignment is updated. If the customer is not assigned, the service creates the assignment. A new assignment returns `201`. An update returns `204`.
{% endhint %}
{% endstep %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

{% endstepper %}

## How to assign IAM groups to a customer segment

Assign an IAM customer group to a segment so every customer in that group inherits the segment membership. This is useful when you already organize B2B buyers by IAM groups, for example, `Buyers` or `Requesters`.

### Prerequisites

Ensure you have:

* An existing customer segment – see [How to add a customer segment](#how-to-add-a-customer-segment)
* An IAM group with `userType` `CUSTOMER` – see [Creating a new group](https://developer.emporix.io/api-references/api-guides/users-and-permissions/iam/api-reference/groups#post-iam-tenant-groups)

{% hint style="warning" %}
To assign and remove groups, you need the `customersegment.segment_manage` scope. To retrieve group assignments, you need the `customersegment.segment_read` scope.
{% endhint %}

{% hint style="info" %}
Only IAM groups with `userType` `CUSTOMER` can be assigned to a segment. Assigning an employee group returns `400`.
{% endhint %}

{% stepper %}
{% step %}
#### Assign a group to a segment

Send the request to the [Upserting a group assignment for a customer segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/groups-assignments#put-customer-segment-tenant-segments-segmentid-groups-groupid) endpoint. Provide the segment ID and the IAM group ID in the path.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/groups/{groupId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "mixins": {
      "segmentAttributes": {
        "membershipStatus": "PREMIUM"
      }
    },
    "metadata": {
      "mixins": {
        "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/emporix-docs/69537caeb3fd5d378296ae42_segmentAttributes.json"
      }
    }
  }'
```

A new assignment returns `201`. An update of an existing assignment returns `204`. Mixins in the request body are optional.
{% endstep %}

{% step %}
#### Retrieve group assignments

To list all IAM groups assigned to a segment, send the request to the [Retrieving all group assignments for a customer segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/groups-assignments#get-customer-segment-tenant-segments-segmentid-groups) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/groups' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'X-Total-Count: true'
```

To retrieve a single assignment, send the request to the [Retrieving a group assignment for a customer segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/groups-assignments#get-customer-segment-tenant-segments-segmentid-groups-groupid) endpoint.

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/groups/{groupId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

The response includes `segmentId`, the group `id` and localized `name`, and assignment `metadata`.
{% endstep %}

{% step %}
#### Search for a group assignment

To find assignments that match specific criteria, send the request to the [Searching with parameters for group assignments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/groups-assignments#post-customer-segment-tenant-segments-segmentid-groups-search) endpoint. Pass the criteria in the `q` parameter in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/groups/search' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "q": "group.id:1gr5e52e-6e27-4ac5-9471-2467d3fb7500"
  }'
```
{% endstep %}

{% step %}
#### Remove a group from a segment

To remove an IAM group assignment, send the request to the [Removing a group from a customer segment](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/groups-assignments#delete-customer-segment-tenant-segments-segmentid-groups-groupid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X DELETE \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/groups/{groupId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

A successful removal returns `204`. Customers who inherit the segment only through this group lose that membership.
{% endstep %}
{% endstepper %}

## How to find a specific segment using search parameters

{% hint style="warning" %}
To search for segments, you need the `customersegment.segment_read` scope.
{% endhint %}

Send the request to the [Searching with parameters for customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments-search) endpoint. Pass the criteria in the `q` parameter in the request body.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-segment/{tenant}/segments/search' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -H 'Accept-Language: en' \
  -H 'X-Total-Count: true' \
  -d '{
    "q": "siteCode:main"
  }'
```

## How to retrieve own customer segments

To display the right products and categories on the storefront, resolve which active segments apply to the authenticated customer. The response includes segments assigned directly to the customer and segments assigned through the customer's IAM groups.

{% hint style="warning" %}
This request uses a customer access token with the `customersegment.segment_read_own` scope. Use [Logging in a customer](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-management/api-reference/authentication-and-authorization#post-customer-tenant-login) to obtain the token.
{% endhint %}

{% hint style="info" %}
Resolved segments include those from groups that are not bound to a legal entity, and from groups bound to the customer's current legal entity.
{% endhint %}

Send the request to the [Retrieving own customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/segments#get-customer-segment-tenant-segments-me) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-segment/{tenant}/segments/me' \
  -H 'Authorization: Bearer {{CUSTOMER_ACCESS_TOKEN}}' \
  -H 'Accept-Language: en'
```

The response lists the active segments that apply to the customer. Pass those segment IDs when you load products and categories so the storefront shows the assortment for that customer. See [How to use customer segments on a storefront](#how-to-use-customer-segments-on-a-storefront).

## How to apply a coupon to a segment

Create a coupon that applies only to the products or categories assigned to a segment, and only for customers who are members of that segment.

Send the request to the [Creating a new coupon](https://developer.emporix.io/api-references/api-guides/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons) endpoint. Set `segmentRestricted` to `true` and list the segment IDs in `restrictions.segments`.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../rewards-and-promotions/coupon/api-reference/" %}
[api-reference](../../rewards-and-promotions/coupon/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/coupons' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "MW2023_10",
    "name": "Winter Sale 2018",
    "description": "Great Winter Discount of 25 USD in December 2018 and January 2019 for all Orders over 50 USD",
    "discountType": "ABSOLUTE",
    "discountAbsolute": {
      "amount": 24.99,
      "currency": "USD"
    },
    "allowAnonymous": false,
    "maxRedemptions": 1,
    "maxRedemptionsPerCustomer": -1,
    "categoryRestricted": false,
    "segmentRestricted": true,
    "restrictions": {
      "validFrom": "2014-12-01T00:00:00.000Z",
      "validUntil": "2015-01-31T23:59:59.999Z",
      "segments": [
        "628cd20c6e8b2432b6346ca6"
      ],
      "minOrderValue": {
        "amount": 49.99,
        "currency": "USD"
      }
    }
  }'
```

{% hint style="info" %}
When `segmentRestricted` is `true`, you must provide `restrictions.segments`.
{% endhint %}

## How to use customer segments on a storefront

Use segments to extend the storefront assortment, or to limit visibility to the products and categories assigned to a segment.

To resolve which active segments apply to the authenticated customer, including those inherited from IAM groups, see [How to retrieve own customer segments](#how-to-retrieve-own-customer-segments).

{% stepper %}
{% step %}
#### Retrieve assigned products or categories

Retrieve the products or categories assigned to the segments that apply to the customer. Send the request to the [Retrieving all items assignments for all customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-items) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-segment/{tenant}/segments/items?q=type:PRODUCT&onlyActive=true' \
  -H 'Authorization: Bearer {{CUSTOMER_ACCESS_TOKEN}}' \
  -H 'Accept-Language: en' \
  -H 'X-Total-Count: true'
```

You can limit the results with the `q` parameter, for example `q=type:PRODUCT` or `q=type:CATEGORY`.
{% endstep %}

{% step %}
#### Build a segment-based category tree

To restrict storefront navigation to categories assigned to the customer's segments, send the request to the [Retrieving category trees for a customer segments](https://developer.emporix.io/api-references/api-guides/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-items-category-trees) endpoint. The tree is built from `ACTIVE` segments only.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-segment/{tenant}/segments/items/category-trees?siteCode=main' \
  -H 'Authorization: Bearer {{CUSTOMER_ACCESS_TOKEN}}' \
  -H 'Accept-Language: en'
```

The response includes categories assigned to the segment and their parent categories, when applicable. If a segment specifies a subcategory only, the customer sees the parent category label, but only products from the subcategory are available.
{% endstep %}

{% step %}
#### Filter products in a category

To return only products in a category that is assigned to the customer's segments, send the request to the [Retrieving resources assigned to a category](https://developer.emporix.io/api-references/api-guides/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#get-category-tenant-categories-categoryid-assignments) endpoint. Pass the segment IDs in the `segmentsIds` query parameter.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/category/{tenant}/categories/{categoryId}/assignments?assignmentType=PRODUCT&segmentsIds=628cd20c6e8b2432b6346ca6&pageNumber=1&pageSize=60' \
  -H 'Authorization: Bearer {{CUSTOMER_ACCESS_TOKEN}}' \
  -H 'Accept-Language: en' \
  -H 'X-Total-Count: true' \
  -H 'X-Version: v2'
```
{% endstep %}
{% endstepper %}
