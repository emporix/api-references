---
seo:
  title: Indexing Service events
  description: Webhooks, indexing service events
---

# Events-Index

## Index events

### Overview

Webhook events related to indexing data.

### Available events

| Event type                          | Event schema                                                       |
| ----------------------------------- | ------------------------------------------------------------------ |
| index-item.updated                  | <pre class="language-json"><code class="lang-json">{
</code></pre> |
| "availability": "Object",           |                                                                    |
| "available": "Boolean",             |                                                                    |
| "categoryAssignments": \["Object"], |                                                                    |
| "code": "String",                   |                                                                    |
| "id": "String",                     |                                                                    |
| "medias": \[                        |                                                                    |

```
{"Object"}
```

],\
"mixins": "Object",\
"popularity": "Number",\
"prices": \[\
{\
"currency": "String",\
"effectiveAmount": "Number",\
"id": "String",\
"itemId": {\
"id": "String",\
"itemType": "String",\
"name": {"Object"}\
},\
"location": {\
"countryCode": "String"\
}\
"originalAmount": "Number",\
"priceModel": {\
"description": {"Map"},\
"id": "String",\
"includesTax": "Boolean",\
"measurementUnit": {\
"quantity": "Integer",\
"unitCode": "String"\
},\
"name": {"Object"},\
"tierDefinition":{\
"tierType": "String",\
"tiers": \[\
{\
"id": "String",\
"minQuantity": {\
"quantity": "Integer",\
"unitCode": "String"\
}\
}\
]\
}\
},\
"priceModelId": "String",\
"restrictions": {\
"siteCodes": \["String"]\
},\
"siteCode": "String",\
"tierValues": \[\
{\
"id": "String",\
priceValue": "Number"\
}\
]\
}\
],\
"published": "Boolean",\
"siteCode": "String",\
"tags": \["String"]\
}\
|\
\| index-item.deleted |

```json
{
"id": "String",
"siteCode": "String"
}
```

|

{% hint style="info" %}
**Learn about the `index.item-updated` event's specific behavior**

###

The `index.item-updated` webhook event is emitted whenever there is a change on an item in the system - the index is updated with the new information.\
For the event to be triggered, a product must have at least one defined **price**, as it is the price that determines products indexing on a specific site.\
Bear in mind all the events are site-specific, which means that they are linked to activities happening on particular sites.\
The prices are also site-specific, and a single price can be associated with multiple sites.\
The number of events triggered in the system depends on **the number of sites** assigned to a specific product’s prices, with one event emitted per each site.

Example:
{% endhint %}

| productid | price with associated sites       | number of emitted events | sites the event was emitted to |
| --------- | --------------------------------- | ------------------------ | ------------------------------ |
| 123       | $10 - sites A, B                  | 2                        | A, B                           |
| 234       | $10 - site A, $15 - sites A, B, C | 3                        | A, B, C                        |
| 345       | no price                          | 0                        | none                           |

{% hint style="info" %}
* A product _123_ has one assigned price of _$10_, associated with two sites _A_ and _B_. When you update the product _123_, the number of emitted `index.item-updated` events is **2** as there are two sites associated with the product price.
* A product _234_ has two assigned prices: _$10_ associated with site _A_ and _$15_ associated with site _A_, _B_, and _C_. So when you update the product _234_, the `index.item-updated` event runs **3** times, as there are three sites affected.
* A product _345_ has no defined price. So when you update the _345_ product, the `index.item-updated` is not emitted as no site is associated with the product.
{% endhint %}
