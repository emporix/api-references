---
seo:
  title: Query Parameter
  description: standard practices
icon: magnifying-glass-waveform
description: You can use a standard q parameter to filter search by string, localized, or numeric field values using exact matches, comparisons, and ranges.
---

# Query Parameter

#### Searching for items by string-based properties

* By field value: `q=name:apple_logo`, where `name` is the field name and `apple_logo` is the desired value.
*   By localized field value: `q=name.en:apple_logo`, where `name` is the field name, `en` is the language code, and `apple_logo` is the value expressed in the specified language.

    {% hint style="info" %}
    This query works only for localized fields, which are stored in a Map format where the `key` is the language code and the `value` is the translation in the specified language.
    {% endhint %}

#### Searching for items by number-based property

* With a specific value: `q=mixins.productCustomAttributes.maxOrderQuantity:20`
* With a value greater than: `q=mixins.productCustomAttributes.maxOrderQuantity:>20`
* With a value less than: `q=mixins.productCustomAttributes.maxOrderQuantity:<20`
* With a value greater than or equal to: `q=mixins.productCustomAttributes.maxOrderQuantity:>=20`
* With a value less than or equal to: `q=mixins.productCustomAttributes.maxOrderQuantity:<=20`
* With a value within a range of values: `q=mixins.productCustomAttributes.maxOrderQuantity:(>=10 AND <=20)`, where `mixins.productCustomAttributes.maxOrderQuantity` is the field name, and `10` and `20` define the range of desired values.

#### Other search types

<table><thead><tr><th width="115.72796630859375">Search type</th><th width="503.068115234375">Example</th><th width="417.780517578125">Description</th></tr></thead><tbody><tr><td>By date-based property</td><td><code>q=metadataCreatedAt:(>="2021-05-18T07:27:27.455Z" AND &#x3C;"2021-05-20T07:27:27.455Z")</code></td><td>All number-based property queries are also valid for dates. In this case, the date should be enclosed in double quotes.</td></tr><tr><td>By boolean-based property</td><td><code>q=categoryRestricted:true</code></td><td>Here, <code>categoryRestricted</code> is the boolean field name and <code>true</code> is the desired value.</td></tr><tr><td>With a nonexistent or null property</td><td><code>q=description.en:null</code></td><td>Here, <code>description.en</code> is the field set to <code>null</code> or is nonexistent in the database.</td></tr><tr><td>With an existing property</td><td><code>q=mixin:exists</code></td><td>Here, <code>mixin</code> is the field that exists in the database.</td></tr><tr><td>With a nonexistent property</td><td><code>q=mixin:missing</code></td><td>Here, <code>mixin</code> is the field that does not exist in the database.</td></tr><tr><td>By multiple specific values</td><td><code>q=id:(5c3325baa9812100098ff48f,5c3325d1a9812100098ff494)</code></td><td>Here, <code>id</code> is the field name, and the values within the brackets are the desired IDs.</td></tr><tr><td>By multiple fields</td><td><code>q=id:5c3325baa9812100098ff48f code:A705121667</code></td><td>Here, <code>id</code> and <code>code</code> are field names. All objects containing the specified values are returned. Multiple fields (separated by spaces) can be specified. Multiple values for each field can also be specified in the format shown earlier.</td></tr><tr><td>With string-based properties conforming to a regex</td><td><code>q=code:~ABCD12</code> or <code>q=code:(~AB CD)</code> for strings with spaces</td><td>Here, <code>code</code> is the field name, and <code>ABCD12</code> or <code>AB CD</code> are regex patterns for querying.</td></tr><tr><td>With a localized string-based property conforming to a regex</td><td><code>q=name.en:~(Yoghurt im)</code></td><td>Here, <code>name</code> is the field name, <code>en</code> is the language code, and <code>Yoghurt im</code> is the regex search term.</td></tr></tbody></table>
