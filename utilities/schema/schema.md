---
seo:
  title: Schema Service Tutorials
icon: graduation-cap
layout:
  width: wide
---

# Schema Tutorial

With the Schema Service you can easily create and manage customized/industry-specific fields for different types in Management Dashboard. The new fields appear in a separate tab when you create an instance of the extended type.

It is possible to create mixin schemas through API for the following entities: `category`, `company`, `coupon`, `customer`, `customer.address`, `order`, `price list`, `product`, `quote` and `return`.

## How to add custom fields for an entity

This tutorial explains how to add custom fields for a product entity.

### Create a schema

To extend the product entity in Management Dashboard with some industry-specific fields, create a schema that defines the required fields and generates JSON file representation by sending a request to the [Creating a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#post-schema-tenant-schemas) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/schema/{tenant}/schemas' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: application/json' 
  --data '{
    "name": {
      "en": "Product Custom Attributes"
    },
    "types": [
      "PRODUCT"
    ],
    "attributes": [
      {
        "key": "weight",
        "name": {
          "en": "Weight of a product"
        },
        "description": {
          "en": "The exact weight of a product in grams."
        },
        "type": "TEXT",
        "metadata": {
          "readOnly": true,
          "required": true
        }
      },
      {
        "key": "size",
        "name": {
          "en": "Size of a product"
        },
        "description": {
          "en": "The exact size of a product. Possible values are S, M, L."
        },
        "type": "ENUM",
        "metadata": {
          "readOnly": true,
          "required": true
        },
        "values": [
          {
            "value": "S"
          },
          {
            "value": "M"
          },
          {
            "value": "L"
          }
        ]
      },
      {
        "key": "advertisement",
        "name": {
          "en": "Advertisement of a product"
        },
        "description": {
          "en": "A localized advertisement of a product."
        },
        "type": "TEXT",
        "metadata": {
          "localized": true,
          "required": true
        }
      }
    ]
  }'
```
{
  "id": "6915ec3c047dc4456d86a26f"
}
### Retrieve a schema

Retrieve the created schema to get the schema URL by calling the [Retrieving a schema](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/schema#get-schema-tenant-schemas-id) endpoint.

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

```bash
curl -L 
  --url 'https://api.emporix.io/schema/{tenant}/schemas/{id}' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Accept: */*'
```

In the response, you can see the URL link to cloudinary repository, where the schema for the product type has been uploaded.

```json
{
  "id": "6915ec3c047dc4456d86a26f",
  "name": {
    "en": "Product Custom Attributes"
  },
  "attributes": [
    {
      "key": "weight",
      "name": {
        "en": "Weight of a product"
      },
      "description": {
        "en": "The exact weight of a product in grams."
      },
      "type": "TEXT",
      "metadata": {
        "readOnly": true,
        "localized": false,
        "required": true,
        "nullable": false
      }
    },
    {
      "key": "size",
      "name": {
        "en": "Size of a product"
      },
      "description": {
        "en": "The exact size of a product. Possible values are S, M, L."
      },
      "type": "ENUM",
      "metadata": {
        "readOnly": true,
        "localized": false,
        "required": true,
        "nullable": false
      },
      "values": [
        {
          "value": "S"
        },
        {
          "value": "M"
        },
        {
          "value": "L"
        }
      ]
    },
    {
      "key": "advertisement",
      "name": {
        "en": "Advertisement of a product"
      },
      "description": {
        "en": "A localized advertisement of a product."
      },
      "type": "TEXT",
      "metadata": {
        "readOnly": false,
        "localized": true,
        "required": true,
        "nullable": false
      }
    }
  ],
  "types": [
    "PRODUCT"
  ],
  "metadata": {
    "version": 1,
    "createdAt": "2025-11-13T14:33:32.059Z",
    "modifiedAt": "2025-11-13T14:33:32.059Z",
    "url": "https://res.cloudinary.com/saas-ag/raw/upload/schemata2/featuredemo/6915ec3c047dc4456d86a26f_v1.json"
  }
}
```

{% hint style="warning" %}
When you create a product, the validation mechanism runs against the schema stored under the mentioned cloudinary URL.
{% endhint %}

### Create a product

Now, create a product that contains additional fields by sending a request to [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

The product should contain "metadata.mixins.\{{id\}}: \{{cloudinaryUrl\}}", where `id` is the schema URL you retrieved with `GET` operation in the previous step.

For example, you created a schema with **size** attribute and it got assigned a schema id: `6915ec3c047dc4456d86a26f`. When creating or editing a product, provide the schema `id` and `URL` details in the payload of the `POST` request:

```json
{
  "mixins": {
    "6915ec3c047dc4456d86a26f": {
      "size": 6557
    }
  },
  "metadata": {
    "mixins": {
      "6915ec3c047dc4456d86a26f": "https://res.cloudinary.com/saas-ag/raw/upload/schemata2/featuredemo/6915ec3c047dc4456d86a26f_v1.json"
    }
  }
}
```



The product you created has already the custom fields added in the separate **Product Custom Attributes** tab.

## How to create a more complex schema

In case you need to add a schema for more complex attribute types than those supported by default, instead of creating a schema, you can create a reference. This tutorial shows you how to upload more complex schemas.

### Prepare a JSON schema definition

See the example JSON file that defines fields of different types:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "description": "Schema for mixins for custom attributes at products.",
  "properties": {
    "storageCapacity": {
      "type": "string",
      "description": "Storage Capacity. Rules: Must be one of the following values: '128 GB', '256 GB', '512 GB', '1000 GB'.",
      "enum": ["128 GB", "256 GB", "512 GB", "1000 GB"]
    },
    "color": {
      "type": "string",
      "description": "Color. Rules: Must be one of the following values: 'Black', 'Blue', 'Natural', 'White'.",
      "enum": ["Black", "Blue", "Natural", "White"]
    },
    "memory": {
      "type": "string",
      "description": "Memory. Rules: Can only be '8 GB'.",
      "enum": ["8 GB"]
    },
    "displaySize": {
      "type": "string",
      "description": "Display Size. Rules: Must follow the format of '[number]\"' (e.g. '5.5\"').",
      "pattern": "^[0-9]+(\\.[0-9]{1,2})?\"$"
    },
    "imageResolution": {
      "type": "string",
      "description": "Image Resolution. Rules: Must follow the format of '[width] x [height] pixels'.",
      "pattern": "^[0-9]+ x [0-9]+ pixels$"
    },
    "iOSOperatingSystem": {
      "type": "boolean",
      "description": "iOS Operating System. Rules: Must be a boolean (true or false)."
    },
    "capacity": {
      "type": "string",
      "description": "Capacity. Rules: Must follow the format '[number] mAh'.",
      "pattern": "^[0-9]+ mAh$"
    },
    "itemNumber": {
      "type": "number",
      "description": "Item Number. Rules: Must be a number between 0 and 99999999 inclusive.",
      "minimum": 0,
      "maximum": 99999999
    },
    "manufacturerNo": {
      "type": "string",
      "description": "Manufacturer No. Rules: Cannot exceed 10 characters in length.",
      "maxLength": 10
    },
    "releaseDate": {
      "type": "string",
      "description": "Release Date. Rules: Must be in the format 'YYYY-MM-DD'.",
      "format": "date",
      "pattern": "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"
    },
    "salesRank": {
      "type": "object",
      "description": "Sales Rank. Rules: 1. 'total' can be set and 'rank' can be empty. 2. When 'rank' is set, 'total' also has to be set.",
      "properties": {
        "rank": {
          "type": "number",
          "minimum": 1
        },
        "total": {
          "type": "number",
          "minimum": 1
        }
      },
      "dependencies": {
        "rank": ["total"]
      }
    },
    "externalLinks": {
      "type": "string",
      "description": "External Links. Rules: Must be a valid URI starting with 'http://' or 'https://'.",
      "format": "uri",
      "pattern": "^https?://.+"
    },
    "maxOrderQuantity": {
      "type": "number",
      "description": "Max Order Quantity. Rules: Must be a number greater than or equal to 1.",
      "minimum": 1
    },
    "contactDetails": {
      "type": "string",
      "description": "Contact Details. Rules: Must be a valid email format.",
      "format": "email",
      "pattern": "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    },
    "specifications": {
      "type": "array",
      "description": "Technical specifications. Rules: Each item must have a 'name', 'summary', and 'details'.",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Name of the specification or technology"
          },
          "summary": {
            "type": "string",
            "description": "A brief summary of the specification"
          },
          "details": {
            "type": "string",
            "description": "Detailed information about the specification"
          }
        },
        "required": ["name", "summary", "details"]
      }
    }
  },
  "oneOf": [
    {
      "properties": {
        "color": {
          "const": "Blue"
        },
        "storageCapacity": {
          "enum": ["512 GB", "1000 GB"]
        }
      }
    },
    {
      "properties": {
        "color": {
          "enum": ["Black", "Natural", "White"]
        },
        "storageCapacity": {
          "enum": ["128 GB", "256 GB", "512 GB", "1000 GB"]
        }
      }
    }
  ],
  "required": [
    "storageCapacity",
    "color",
    "memory",
    "displaySize",
    "imageResolution",
    "capacity",
    "itemNumber",
    "manufacturerNo",
    "releaseDate",
    "externalLinks",
    "maxOrderQuantity",
    "contactDetails",
    "specifications"
  ]
}

```

### Create a reference

To use the schema in Emporix Commerce Engine, send a request to the [Creating a reference](https://developer.emporix.io/api-references/api-guides/utilities/schema/api-reference/reference#post-schema-tenant-references) endpoint. This action creates a reference to your schema so that you use the extended type.
The schema reference is used to create or edit product objects.

{% hint style="warning" %}
Note that the fields of types that are not supported by default are not displayed in the Management Dashboard. You can edit them by API requests.
{% endhint %}

{% include "../../.gitbook/includes/example-hint-text.md" %}

{% content-ref url="api-reference/" %}
[api-reference](api-reference/)
{% endcontent-ref %}

CURL request example:

```bash
curl -L 
  --request POST 
  --url 'https://api.emporix.io/schema/{tenant}/references' 
  --header 'Authorization: Bearer YOUR_OAUTH2_TOKEN' 
  --header 'Content-Type: multipart/form-data' 
  --form 'file=[object Object]' 
  --form 'body=[object Object]'
```

JSON example:

```json
{
  "file": {
    "externalValue": "https://res.cloudinary.com/saas-ag/raw/upload/schemata2/saastest2/653a30c0951b2b0665884f89_v1.json"
  },
  "body": {
    "name": {
      "en": "Product Custom Attributes"
    },
    "types": [
      "PRODUCT"
    ]
  }
}
```

### Create a product

Now, create a product and provide values for the customized fields by sending a request to [Creating a new product](https://developer.emporix.io/api-references/api-guides/products-labels-and-brands/product-service/api-reference/products#post-product-tenant-products) endpoint.

See the example payload for creating a product basing on the schema from the previous step:

```json
{
    "productType": "BASIC",
    "published": true,
    "id": "mobile-15-pro-blue-1",
    "code": "mobile-15-pro-blue-1",
    "name": {
        "de": "Mobile Phone 15 Pro Blue",
        "ar": "Mobile Phone 15 Pro Blue",
        "en": "Mobile Phone 15 Pro Blue",
        "fr": "Mobile Phone 15 Pro Blue"
    },
    "description": {
        "de": "",
        "ar": "",
        "en": "Mobile 15 Pro. Titanium becomes Pro.\n\nThe Mobile 15 Pro. Forged from titanium, with the all-changing A17 Pro chip, a customizable action button and an even more versatile camera system.\n\nFORGED FROM TITANIUM - The Mobile 15 Pro has a durable and lightweight space-age titanium design with a textured matte glass back. It also has a Ceramic Shield front that can withstand more than any smartphone glass. And it'\''s protected from water and dust.\n\nADVANCED DISPLAY - The 6.1\" Super Retina XDR Display2 with ProMotion boosts the refresh rate to 120 Hz when you need extra graphics power. Dynamic Island brings notifications and live activity to the front. And with Always On Display, the lock screen always shows your most important info without you having to tap it.\n\nEVERYTHING CHANGING A17 PRO CHIP - A Pro GPU makes gaming an immersive experience, with detailed environments and realistic characters. The A17 Pro is incredibly efficient and helps ensure you have battery power for the whole day.\n\nPOWERFUL PRO CAMERA SYSTEM - Incredible framing flexibility as if you had 7 Pro lenses. Take super high-resolution photos with more colour and detail with the 48 MP main camera. And with the 3x telephoto camera in Mobile 15 Pro, you'\''ll get razor-sharp close-ups from further away.\n\nADJUSTABLE ACTION BUTTON - The Action Button takes you straight to your favourite feature. Just set it to silent mode, camera, voice memo, shortcut or any other feature. Then all you have to do is press and hold the Action Button to start it.\n\nPRO CONNECTIVITY - With the new USB C port, you can charge your Mac or iPad with the same cable as your Mobile 15 Pro. With USB 3, you get a huge leap in data transfer. And you can charge files up to 2x faster with Wi-Fi 6E.\n\nIMPORTANT SAFETY FEATURES - If you need to contact emergency services but have no network or Wi-Fi, you can use Emergency SOS via satellite. With Accident Detection, Mobile can detect a serious car accident and call for help if you can'\''t.\n\nMADE TO MAKE A DIFFERENCE - Mobile comes with privacy features that ensure you stay in control of your data. It'\''s made from more recycled materials to minimise its environmental impact. And it has built-in features that make Mobile more accessible to everyone.\n\nCOMES WITH APPLECARE WARRANTY - Every Mobile comes with a one-year manufacturer'\''s warranty and up to 90 days of free technical support. Get AppleCare+ or AppleCare+ with theft and loss to extend your protection.\n\nMobile 15, Mobile 15 Plus, Mobile 15 Pro and Mobile 15 Pro Max are protected from water and dust and have been tested under controlled laboratory conditions. They are rated IP68 to IEC standard 60529 (up to 6 metres for up to 30 minutes). Protection from water and dust is not permanent and may diminish over time as a result of normal wear and tear. Do not charge a wet Mobile. Cleaning and drying instructions are provided in the user manual. The warranty does not cover damage caused by liquids.",
        "fr": ""
    },
    "mixins": {
        "productCustomAttributes": {
            "inStock": true
        },
        "mixinsExampleAttributes": {
            "storageCapacity": "1000 GB",
            "color": "Blue",
            "memory": "8 GB",
            "displaySize": "6.10",
            "imageResolution": "2556 x 1179 pixels",
            "iOSOperatingSystem": true,
            "capacity": "3274 mAh",
            "itemNumber": 38606712,
            "manufacturerNo": "MTV13ZD/A",
            "releaseDate": "2023-09-22",
            "salesRank": {
                "rank": 2,
                "total": 4405
            },
            "externalLinks": "https://shop.eno.de/de/datasheets/product/view/sku/150728",
            "maxOrderQuantity": 3,
            "contactDetails": "info@example.com",
            "specifications": [
                {
                    "name": "5G (sub‑6 GHz and mmWave)",
                    "summary": "4x4 MIMO",
                    "details": "5G technology supporting sub‑6 GHz and mmWave frequencies with 4x4 MIMO10"
                },
                {
                    "name": "Gigabit LTE",
                    "summary": "4x4 MIMO and LAA",
                    "details": "High-speed LTE technology with 4x4 MIMO and LAA10"
                },
                {
                    "name": "Wi‑Fi 6E (802.11ax)",
                    "summary": "2x2 MIMO",
                    "details": "Wi-Fi 6E technology (802.11ax) supporting 2x2 MIMO11"
                },
                {
                    "name": "Bluetooth 5.3",
                    "summary": "Bluetooth technology",
                    "details": "Version 5.3 of the Bluetooth wireless communication standard"
                },
                {
                    "name": "NFC with reader mode",
                    "summary": "NFC technology",
                    "details": "Near Field Communication technology with reader mode"
                }
            ]
        }
    },
    "metadata": {
        "mixins": {
            "productCustomAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/schemata/productCustomAttributesMixIn.v29.json",
            "mixinsExampleAttributes": "https://res.cloudinary.com/saas-ag/raw/upload/powerzone/mixins/emporix_mixins_testing_jsonschema_v1.json"
        }
    }
}
```
