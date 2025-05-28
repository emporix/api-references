---
seo:
  title: Customer Segment Service Tutorials
  description: customer segments
icon: graduation-cap
---

# Segments Tutorial

Customer Segment Service allows you to group your customers in many convenient ways that suit different purposes.\
You can assign products or categories to create targeted marketing campaigns and display the relevant items on the storefront.\
The flexible service's API facilitates configuring and managing customer segments.

## How to add a customer segment

{% hint style="warning" %}
To create and configure a segment, you need the `customersegment.segment_manage` scope.
{% endhint %}

### Create a customer segment

Create a customer segment by sending a request to the the [Creating a customer segment](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-segment/{tenant}/segments' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Language: string' \
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
      "from": "2024-04-17T08:00:00.000Z",
      "to": "2025-04-17T08:00:00.000Z"
    },
    "status": "ACTIVE",
    "siteCode": "main"
  }'
```

### Add products/categories to a segment

Connect the segment with specific products and/or categories for more customized content.

* To add an individual product or a category, call the [Updating an item assignment](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/items-assignments#put-customer-segment-tenant-segments-segmentid-items-type-itemid)\
  endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/items/{type}/{itemId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "mixins": {
      "segmentAttributes": {
        "membershipStatus": "PREMIUM"
      }
    },
    "metadata": {
      "mixins": {
        "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/v1600077014/schemata/segmentAttributes_v1.json"
      }
    }
  }'
```

* To assign multiple products or categories to the segment, call the [Updating multiple item assignments](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/items-assignments#put-customer-segment-tenant-segments-segmentid-items-type-bulk) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/items/{type}/bulk' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

{% hint style="warning" %}
Note that this operation performs an `UPSERT` operation. The `UPSERT` means that if an item is already assigned to a segment, the assignment gets updated. If not, the new one is created in the system.
{% endhint %}

### Add segment members

Now, add customers to the segment. Depending on your setup and purpose, you can add B2B or B2C customers.

* To add a B2B customer, send the request to the [Updating a customer assignment](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-customerid-legalentityid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/customers/{customerId}/{legalEntityId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "mixins": {
      "segmentAttributes": {
        "membershipStatus": "PREMIUM"
      }
    },
    "metadata": {
      "mixins": {
        "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/v1600077014/schemata/segmentAttributes_v1.json"
      }
    }
  }'
```

* To add a B2C customer, send the request to the [Updating a customer assignment](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-customerid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/customers/{customerId}/{legalEntityId}' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "mixins": {
      "segmentAttributes": {
        "membershipStatus": "PREMIUM"
      }
    },
    "metadata": {
      "mixins": {
        "segmentAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/v1600077014/schemata/segmentAttributes_v1.json"
      }
    }
  }'
```

* To add multiple customers at once, send the request to the [Updating multiple customer assignments](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/customers-assignments#put-customer-segment-tenant-segments-segmentid-customers-bulk) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X PUT \
  'https://api.emporix.io/customer-segment/{tenant}/segments/{segmentId}/customers/bulk' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{}'
```

{% hint style="warning" %}
Note that this operation performs an `UPSERT` operation. The `UPSERT` means that if a customer is already assigned to a segment, the assignment gets updated. If not, the customer assignment is created in the system.
{% endhint %}

## How to find a specific segment using search parameters

{% hint style="warning" %}
To search for a segment, you need the `customersegment.segment_read` scope to retrieve all customer segments.
{% endhint %}

You can use the search API to find a segment of your interest that match a specific criteria. Send the request to the [Searching with parameters for customer segments](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/segments#post-customer-segment-tenant-segments-search) endpoint.

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/customer-segment/{tenant}/segments/search?pageSize=string&pageNumber=string&sort=string&fields=string&legalEntityId=string' \
  -H 'Accept-Language: string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -H 'X-Total-Count: true' \
  -d '{
    "q": "siteCode:main"
  }'
```

In the request body, pass the criteria you're looking for in the `q` parameter.

## How to apply a coupon to a segment

Optionally, you can offer a discount coupon to a customer segment. The coupon then applies only to the assigned products/categories and is valid only for the customers that are the segment members.\
To create a coupon that is valid only for a specific segment, send the request to the [Creating a new coupon](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/rewards-and-promotions/coupon/api-reference/coupon-management#post-coupon-tenant-coupons) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../rewards-and-promotions/coupon/api-reference/" %}
[api-reference](../../rewards-and-promotions/coupon/api-reference/)
{% endcontent-ref %}

```bash
curl -i -X POST \
  'https://api.emporix.io/coupon/{tenant}/coupons' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'Content-Type: application/json' \
  -d '{
    "code": "ENG2OC0",
    "name": "Winter Sale 2018",
    "description": "Great Winter Discount of 25 USD in December 2018 and January 2019 for all Orders over 50 USD",
    "discountType": "ABSOLUTE",
    "discountAbsolute": {
      "amount": 24.99,
      "currency": "USD"
    },
    "allowAnonymous": false,
    "maxRedemptions": -1,
    "maxRedemptionsPerCustomer": -1,
    "categoryRestricted": false,
    "segmentRestricted": false,
    "restrictions": {
      "validFor": [
        "C0123456789",
        "C0123456788"
      ],
      "validFrom": "2014-12-01T00:00:00.000Z",
      "validUntil": "2015-01-31T23:59:59.999Z",
      "minOrderValue": {
        "amount": 49.99,
        "currency": "USD"
      }
    },
    "issuedTo": "C01234567989"
  }'
```

Set the `segmentRestricted` parameter as `true` and specify the segments you want to apply the coupon to.

## How to use customer segments on a storefront

Having segments in place, you can use that functionality on your storefront.\
Depending on your business goals, you can utilize the segments differently. Decide whether you'd like to extend the assortment with the products/categories assigned to a given segment to, for example, promote certain items on your site.\
Or, you'd rather limit products/categories visibility to only those that a segment defines for segment members, to be able to sell specified products through a channel that targets the right group of people.

### Retrieve all products and/or categories

To display the content you want, first retrieve all the products/categories assigned to all segments that a customer is a member of.\
Send the request to the [Retrieving all items assignments for all customer segments](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-items) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-segment/{tenant}/segments/items?q=string&pageSize=string&pageNumber=string&sort=string&fields=string&legalEntityId=string&siteCode=string&onlyActive=false' \
  -H 'Accept-Language: string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>' \
  -H 'X-Total-Count: true'
```

Depending on your needs, you can limit the search using the `q` parameter, for example, `q=type:PRODUCT` or `q=type:CATEGORY`.

### Use the segment information

If you want to use segments to restrict the content on your storefront, to display only the product and categories assigned to a segment for segment customers, use the endpoint to build a segment-based category tree.\
Send the request to the [Retrieving category trees for a customer segments](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/companies-and-customers/customer-segments/api-reference/items-assignments#get-customer-segment-tenant-segments-items-category-trees) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -i -X GET \
  'https://api.emporix.io/customer-segment/{tenant}/segments/items/category-trees?legalEntityId=string&siteCode=string' \
  -H 'Accept-Language: string' \
  -H 'Authorization: Bearer <YOUR_TOKEN_HERE>'
```

The request generates a category tree with categories assigned to a segment and their parent categories, if applicable. If a segment specifies a subcategory only, the customer of that segment is able to see the parent category label, but content-wise, only the products from the subcategory are available.

To filter products that belong to a category that is assigned to a particular segment, send the request to the [Retrieving resources assigned to a category](https://developer.emporix.io/documentation-portal/api-references/api-guides-and-references/api-references/catalogs-and-categories/category-tree/api-reference/category-assignment-resources#get-category-tenant-categories-categoryid-assignments) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../../catalogs-and-categories/category-tree/api-reference/" %}
[api-reference](../../catalogs-and-categories/category-tree/api-reference/)
{% endcontent-ref %}

\`\`\`bash\
curl -i -X GET \\\
'https://api.emporix.io/category/{tenant}/categories/{categoryId}/assignments?assignmentType=PRODUCT\&ref.localizedName=Twix\&ref.id=5c3348bda9812100098ffaa3\&showUnpublished=true\&withSubcategories=true\&segmentsIds=segmentId1%2CsegmentId2\&pageNumber=1\&pageSize=60\&sort={fieldName}%3AASC%2C{fieldName2}%3ADESC\&hideUnpublishedProducts=false' \\\
-H 'Accept-Language: \`\*\`, \`en\`, \`en,de,fr\`, \`en-EN\`, \`fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7\`' \\\
-H 'Authorization: Bearer ' \\\
-H 'X-Total-Count: true' \\\
-H 'X-Version: v2'\
\`\`\`

Specify the segment id in the request.
