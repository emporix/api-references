---
seo:
  title: Vendor Service Tutorials
  description: vendor
icon: graduation-cap
---

# Vendor Tutorial

Vendor Service allows you to configure how vendor's employees access products and orders. As an end-to-end feature, it integrates with the IAM, Product, and Order services to deliver a tailored solution. This service is also build to manage locations and associated data.

Related Services:

* [IAM](/users-and-permissions/iam/README.md)
* [Product](/products-labels-and-brands/product-service/README.md)
* [Order](/orders/order/README.md)

### How to create a vendor?

To create a vendor, send a request to the [Creating a vendor](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/vendors#post-vendor-tenant-vendors) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../companies-and-customers/vendor-service/api-reference/" %}
[api-reference](/companies-and-customers/vendor-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/vendor/vendor/{tenant}/vendors' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
  "name": "ABC Company",
  "type": "COMPANY",
  "legalInfo": {
    "legalName": "ABC Company Inc.",
    "registrationDate": "2022-03-31T13:18:02.379Z",
    "countryOfRegistration": "US",
    "taxRegistrationNumber": "1234567890"
  },
  "contactDetails": [
    {
      "firstName": "Jane",
      "lastName": "Doe",
      "email": "jane.doe@example.com",
      "phone": "+1-555-0123"
    }
  ]
}
```
Your vendor is created and you get its ID in the request response, for example `6880c8e860a76003fbece674`.

When a vendor is created, it automatically creates four new user groups for your tenant - `vendor.order.manager`, `vendor.order.viewer.` `vendor.product.manager`, `vendor.product.viewer`. In the example based on ABC Company the groups are: 

* ABC Company Vendor Product Manager
* ABC Company Vendor Product Viewer
* ABC Company Vendor Order Manager
* ABC Company Vendor Order Viewer

If you want to check what vendors are created for your tenant, send the request to [Retrieving all vendors](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/vendors#get-vendor-tenant-vendors) endpoint.

As a response, you get information about all your tenant vendors with company and location details, for example:

```bash
  [
  {
    "id": "687a410560a76003fbece671",
    "name": "Example Company",
    "type": "COMPANY",
    "legalInfo": {
      "legalName": "Example Company Inc.",
      "registrationDate": "2022-03-31T13:18:02.379Z",
      "countryOfRegistration": "US",
      "taxRegistrationNumber": "1234567890"
    },
    "locations": [
      {
        "id": "687a4055b036735470a91bb8",
        "name": "Example HQ",
        "type": "HEADQUARTER",
        "contactDetails": {
          "emails": [
            "jane.doe@example.com",
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
        },
        "metadata": {
          "version": 1,
          "createdAt": "2025-07-18T12:38:45.399Z",
          "modifiedAt": "2025-07-18T12:38:45.399Z"
        }
      }
    ],
    "metadata": {
      "version": 1,
      "createdAt": "2025-07-18T12:41:41.143Z",
      "modifiedAt": "2025-07-18T12:41:41.143Z"
    },
    "contactDetails": [
      {
        "firstName": "Jane",
        "lastName": "Doe",
        "email": "jane.doe@example.com",
        "phone": "+1-555-0123"
      }
    ]
  },
  {
    "id": "687f7a85b036735470a91bbc",
    "name": "Supplier Company",
    "type": "COMPANY",
    "legalInfo": {
      "legalName": "Supplier Company Inc.",
      "registrationDate": "2022-03-31T13:18:02.379Z",
      "countryOfRegistration": "US",
      "taxRegistrationNumber": "1234567890"
    },
    "metadata": {
      "version": 1,
      "createdAt": "2025-07-22T11:48:21.724Z",
      "modifiedAt": "2025-07-22T11:48:21.724Z"
    },
    "contactDetails": [
      {
        "firstName": "John",
        "lastName": "Doe",
        "email": "john.doe@supplier.com",
        "phone": "+1-555-0123"
      }
    ]
  },
  {
    "id": "6880c8e860a76003fbece674",
    "name": "ABC Company",
    "type": "COMPANY",
    "legalInfo": {
      "legalName": "ABC Company Inc.",
      "registrationDate": "2022-03-31T13:18:02.379Z",
      "countryOfRegistration": "US",
      "taxRegistrationNumber": "1234567890"
    },
    "metadata": {
      "version": 1,
      "createdAt": "2025-07-23T11:35:04.108Z",
      "modifiedAt": "2025-07-23T11:35:04.108Z"
    },
    "contactDetails": [
      {
        "firstName": "Jane",
        "lastName": "Doe",
        "email": "jane.doe@example.com",
        "phone": "+1-555-0123"
      }
    ]
  }
]
```

### How to set up a location for an existing vendor?

To set up a location for the vendor, send the request to the [Creating a location](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/locations#post-vendor-tenant-locations) endpoint.

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/vendor/{tenant}/locations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
  "name": "Example HQ",
  "type": "HEADQUARTER",
  "contactDetails": {
    "emails": [
      "jane.doe@example.com",
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

As a response you get the location ID, for example `687a4055b036735470a91bb8`, which you can now place in the request to [Upserting a location](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/vendors#put-vendor-tenant-vendors-vendorid) endpoint or in a request to [Creating a vendor](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/vendors#post-vendor-tenant-vendors) endpoint.

### How to link users group with a vendor? 

Start with retrieving the groups that are created for your tenant. Send the request to [Retrieving all groups](https://developer.emporix.io/api-references/api-guides-and-references/users-and-permissions/iam/api-reference/groups#get-iam-tenant-groups) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../users-and-permissions/iam/api-reference/" %}
[api-reference](/users-and-permissions/iam/api-reference/)
{% endcontent-ref %}


If you have created a vendor earlier for the tenant, you should see all the relevant vendor groups in the response. For example:

```bash
{
    "id": "c507639b-fa08-4dc4-923b-108b114d2ec7",
    "name": {
      "en": "ABC Company Vendor Product manager"
    },
    "accessControls": [
      "4ac869fc-d548-4ec8-8e06-c01491314224"
    ],
    "userType": "EMPLOYEE",
    "vendorId": "6880c8e860a76003fbece674",
    "metadata": {
      "version": 1,
      "createdAt": "2025-07-23T11:35:04.680Z",
      "modifiedAt": "2025-07-23T11:35:04.680Z"
    }
  },
  {
    "id": "65d7d8a0-ae60-4594-8651-fdb1abdabe86",
    "name": {
      "en": "ABC Company Vendor Order manager"
    },
    "accessControls": [
      "4ac869fc-d548-4ec8-8e06-c01491314223"
    ],
    "userType": "EMPLOYEE",
    "vendorId": "6880c8e860a76003fbece674",
    "metadata": {
      "version": 1,
      "createdAt": "2025-07-23T11:35:04.679Z",
      "modifiedAt": "2025-07-23T11:35:04.679Z"
    }
  },
  {
    "id": "579f1391-59c9-4c89-a3e5-faaaaae31f42",
    "name": {
      "en": "ABC Company Vendor Order viewer"
    },
    "accessControls": [
      "1ac869fc-d548-4ec8-8e06-c01491314231"
    ],
    "userType": "EMPLOYEE",
    "vendorId": "6880c8e860a76003fbece674",
    "metadata": {
      "version": 1,
      "createdAt": "2025-07-23T11:35:04.679Z",
      "modifiedAt": "2025-07-23T11:35:04.679Z"
    }
  },
  {
    "id": "46ab8103-0e4c-431e-8264-190e55de6a3f",
    "name": {
      "en": "ABC Company Vendor Product viewer"
    },
    "accessControls": [
      "1ac869fc-d548-4ec8-8e06-c01491314232"
    ],
    "userType": "EMPLOYEE",
    "vendorId": "6880c8e860a76003fbece674",
    "metadata": {
      "version": 1,
      "createdAt": "2025-07-23T11:35:04.682Z",
      "modifiedAt": "2025-07-23T11:35:04.682Z"
    }
  }
```

Each vendor groups has it's own ID. To assign a user to the vendor group, send the request to [Adding a user to a group](https://developer.emporix.io/api-references/api-guides-and-references/users-and-permissions/iam/api-reference/group-assignments#post-iam-tenant-groups-groupid-users) endpoint.
Provide the vendor group's ID and user's ID in the request.

{% hint style="info" %}
A single user can belong to only one vendor group. 
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../users-and-permissions/iam/api-reference/" %}
[api-reference](/users-and-permissions/iam/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/iam/{tenant}/groups/{groupId}/users' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "userId": "3bf883fc-d18a-4175-8137-aaf64f810835",
    "userType": "EMPLOYEE"
  }'
  ```

You can then check the user's assignment by sending a request to the [Retrieving a list of vendor users](https://developer.emporix.io/api-references/api-guides-and-references/users-and-permissions/iam/api-reference/management-dashboard-users#get-iam-tenant-users-vendors-vendorid) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../users-and-permissions/iam/api-reference/" %}
[api-reference](/users-and-permissions/iam/api-reference/)
{% endcontent-ref %}

### How to make products visible only for the vendor employee?

jak ktos jest zalogowany userem nalezacym do vendora i stworzy produckt to jest odarazu przypisany do vendora

przypisane vendor id
jak mam produkt ktory nalezy do vendora, dodajemy do carta, robimy checkotuta (order jest wspolny, produkt nalezy do vendora) i pozniej order split ktory stworzy suborder by vendor

(polaczenie pozniej z ui)

Create a new product visible for the vendor. 
Send a request to Create a product endpoint with the required vendor scope:

* `product.product_read_by_vendor`
* `product.product_manage_by_vendor`

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../products-labels-and-brands/product-service/api-reference/" %}
[api-reference](/products-labels-and-brands/product-service/api-reference/)
{% endcontent-ref %}
  

```bash
curl https://api.emporix.io/product/featuredemo/products 
  --request POST 
  --header 'Content-Type: application/json' 
  --data '{
  "name": "Product One",
  "code": "P001",
  "description": "The world best book.",
  "published": false,
  "productType": "BASIC"
}'
```


### How to make orders visible only for vendor employees?
### Order splitting?

Product has vendor field.

1. When adding a product to a cart that has vendor field in the product catalog, the vendor will be auto populated in the cart entry
2. Then once You make a checkout an order will be created with entries that have product.vendor also populated. 
3. We have a new endpoint /{orderId}/split 
    - only orders in CREATED status
    - only order that have not been split yet nor sub order. 
    - order cannot have any disconunts
4. Once You sent that request and You have in your order entries with products that belong to different vendors the api will:
    - mark the main order with orderType: MASTER_ORDER
    {
    "id": "EON1215",
    "cartId": "687a3516ca9d8d2488b7c9c1",
    "createdBy": "45620894",
    "status": "CREATED",
    "lastStatusChange": "2025-07-18T11:51:00.162Z",
    "created": "2025-07-18T11:51:00.162Z",
    "channel": {
        "name": "storefront",
        "source": "https://your-storefront.com/"
    },
    "orderType": "MASTER_ORDER",
    "splitBy": "VENDOR_ID",
    "subOrders": [
        "EON1216",
        "EON1217"
    ],
    - create sub orders 1 for every unique vendor and one if the was a product that does not belong to any vendor. e.g. 10 product, 9 of them belong to 3 different vendors and one does not have any vendor -> 4 sub orders. 
    - sub order have masterOrder orderId, splitInfo (splitBy:VENDOR_ID, unqiueValue="")
    {
    "id": "EON1228",
    "createdBy": "45620894",
    "status": "CREATED",
    "lastStatusChange": "2025-07-21T09:16:58.834Z",
    "created": "2025-07-21T09:16:58.834Z",
    "channel": {
        "name": "storefront",
        "source": "https://your-storefront.com/"
    },
    "masterOrder": "EON1227",
    "orderType": "SUB_ORDER",
    "splitInfo": {
        "splitBy": "VENDOR_ID",
        "uniqueValue": "6879eecd1cc84b218acaaec7"
    },
    "vendor": { /// that important!!!
        "id": "6879eecd1cc84b218acaaec7",
        "name": "RawMaterial INC B"
    },

    Because sub orders have vendorPopulated. If vendor logins into MD or tries to fetch orders in api with his login credentials he will only see orders that belong to this vendor.


