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

Start with creating a location. Send the request to the [Creating a location](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/locations#post-vendor-tenant-locations) endpoint.

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
}
```

As a response you get the location ID, for example `687a4055b036735470a91bb8`, which you can now place in the request to create a vendor.

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
  "name": "Example Company",
  "type": "COMPANY",
  "legalInfo": {
    "legalName": "Example Company Inc.",
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
  ],
  "locations": [
    {
      "id": "687a4055b036735470a91bb8"
    }
  ]
}
```
Your vendor is created and you get its ID in the request response, for example `687a410560a76003fbece671`.

To check what vendors are created for your tenant, send the request to [Retrieving all vendors](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/vendors#get-vendor-tenant-vendors) endpoint.

As a response, you get information about all your tenant vendors with company and location details:

```bash
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
  }
```



### How to set up a location for an existing vendor?

If you've created your vendor and you want to set up a location for it, send the request to the [Creating a location](https://developer.emporix.io/api-references/api-guides-and-references/companies-and-customers/vendor-service/api-reference/locations#post-tenant-locations) endpoint and provide company details in the payload.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="../companies-and-customers/vendor-service/api-reference/" %}
[api-reference](/companies-and-customers/vendor-service/api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/vendor/{tenant}/locations' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
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
- does this work this way? should I provide company details from the first POST request and then it should work? the examples in the api.yml seem not to be related to one another

### How to link a customer group with a vendor? / How to set up permissions? How to set up vendor employees?

should I create customer group first? or is it automatically created when I create a new company? I know that some groups will be automatically created with Lukasz S updates?

### How to make products visible only for the vendor employee?

Create a new product visible for the vendor. 
Send a request to Create a product endpoint with the required vendor scopes:

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
