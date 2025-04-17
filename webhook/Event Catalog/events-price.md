---
seo:
  title: Price Service events
  description: Webhooks, price events
---

# Price Service events

## Overview

Webhook events related to the creation, update, and deletion of a price, price model, price list\
and a price list price.

## Available events

| Event type               | Event schema                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| price.created            | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "itemId": {
    "id": "String",
    "itemType": "String"
  },
  "itemYrn": "String",
  "currency": "String",
  "location": {
    "countryCode": "String"
  },
  "salePrice": {
    "discountAmount": "String",
    "discountRate": "String",
    "description": "String"
  },
  "priceModelId": "String",
  "restrictions": {
    "principals": [
      {
        "id": "String",
        "type": "String"
      }
    ],
    "validity": {
      "from": "String",
      "to": "String"
    },
    "siteCodes": ["String"],
    "priceListId": "String"
  },
  "tierValues": [
    {
      "id": "String",
      "priceValue": "String"
    }
  ],
  "mixins": "Map",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number",
    "mixins": "Map"
  }
}
</code></pre> |
| price.updated            | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "itemId": {
    "id": "String",
    "itemType": "String"
  },
  "itemYrn": "String",
  "currency": "String",
  "location": {
    "countryCode": "String"
  },
  "salePrice": {
    "discountAmount": "String",
    "discountRate": "String",
    "description": "String"
  },
  "priceModelId": "String",
  "restrictions": {
    "principals": [
      {
        "id": "String",
        "type": "String"
      }
    ],
    "validity": {
      "from": "String",
      "to": "String"
    },
    "siteCodes": ["String"],
    "priceListId": "String"
  },
  "tierValues": [
    {
      "id": "String",
      "priceValue": "String"
    }
  ],
  "mixins": "Map",
  "metadata": {
    "createdAt": "String",
    "modifiedAt": "String",
    "version": "Number",
    "mixins": "Map"
  }
}
</code></pre> |
| price.deleted            | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| price-model.created      | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "name": "Map",
  "description": "Map",
  "includesTax": "Boolean",
  "isDefault": "Boolean",
  "measurementUnit": {
    "quantity": "Number",
    "unitCode": "String"
  },
  "tierDefinition": {
    "tierType": "String",
    "tiers": [
      {
        "id": "String",
        "minQuantity": {
          "quantity": "Number",
          "unitCode": "String"
        }
      }
    ]
  },
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                             |
| price-model.updated      | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "name": "Map",
  "description": "Map",
  "includesTax": "Boolean",
  "isDefault": "Boolean",
  "measurementUnit": {
    "quantity": "Number",
    "unitCode": "String"
  },
  "tierDefinition": {
    "tierType": "String",
    "tiers": [
      {
        "id": "String",
        "minQuantity": {
          "quantity": "Number",
          "unitCode": "String"
        }
      }
    ]
  },
  "metadata": {
    "version": "Number",
    "createdAt": "String",
    "modifiedAt": "String"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                             |
| price-model.deleted      | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| price-list.created       | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "name": "Map",
  "currency": "String",
  "countries": ["String"],
  "regions": ["String"],
  "customerGroups": ["String"],
  "siteCode": "String",
  "validity": {
    "from": "String",
    "to": "String"
  },
  "mixins": "Map",
  "metadata": {
    "createdAt": "String",
    "updatedAt": "String",
    "version": "Number",
    "mixins": "Map"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| price-list.updated       | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "name": "Map",
  "currency": "String",
  "countries": ["String"],
  "regions": ["String"],
  "customerGroups": ["String"],
  "siteCode": "String",
  "validity": {
    "from": "String",
    "to": "String"
  },
  "mixins": "Map",
  "metadata": {
    "createdAt": "String",
    "updatedAt": "String",
    "version": "Number",
    "mixins": "Map"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| price-list.deleted       | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| price-list-price.created | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "itemId": {
    "itemType": "String",
    "id": "String"
  },
  "priceListId": "String",
  "priceModelId": "String",
  "tierValues": [
    {
      "id": "String",
      "priceValue": "String"
    }
  ],
  "metadata": {
    "createdAt": "String",
    "updatedAt": "String",
    "version": "Number"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| price-list-price.updated | <pre class="language-json"><code class="lang-json">{
  "id": "String",
  "itemId": {
    "itemType": "String",
    "id": "String"
  },
  "priceListId": "String",
  "priceModelId": "String",
  "tierValues": [
    {
      "id": "String",
      "priceValue": "String"
    }
  ],
  "metadata": {
    "createdAt": "String",
    "updatedAt": "String",
    "version": "Number"
  }
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| price-list-price.deleted | <pre class="language-json"><code class="lang-json">{
  "id": "String"
}
</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
