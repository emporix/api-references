---
seo:
  title: Query Parameter
  description: standard practices
---

import {
  Alert,
  Button,
  OpenApiTryIt,
  ExplainStep
 } from '@redocly/developer-portal/ui';

# Query parameter

You can use a standard `q` parameter to search for specific values.

#### Searching for items by string-based properties

* By field value: `q=name:apple_logo`, where `name` is the field name and `apple_logo` is the desired value.

* By localized field value: `q=name.en:apple_logo`, where `name` is the field name, `en` is the language code, and `apple_logo` is the value expressed in the specified language.

  :::note
  This query works only for localized fields, which are stored in a Map format where the `key` is the language code and the `value` is the translation in the specified language.

  :::


#### Searching for items by number-based property

* With a specific value: `q=mixins.productCustomAttributes.maxOrderQuantity:20`

* With a value greater than: `q=mixins.productCustomAttributes.maxOrderQuantity:>20`

* With a value less than: `q=mixins.productCustomAttributes.maxOrderQuantity:<20`

* With a value greater than or equal to: `q=mixins.productCustomAttributes.maxOrderQuantity:>=20`

* With a value less than or equal to: `q=mixins.productCustomAttributes.maxOrderQuantity:<=20`

* With a value within a range of values: `q=mixins.productCustomAttributes.maxOrderQuantity:(>=10 AND <=20)`, where `mixins.productCustomAttributes.maxOrderQuantity` is the field name, and `10` and `20` define the range of desired values.

#### Other search types

|Search type | Example | Description|
|---|---|---|
|By date-based property|`q=metadataCreatedAt:(>="2021-05-18T07:27:27.455Z" AND <"2021-05-20T07:27:27.455Z")`|All number-based property queries are also valid for dates. In this case, the date should be enclosed in double quotes.|
|By boolean-based property| `q=categoryRestricted:true`|Here, `categoryRestricted` is the boolean field name and `true` is the desired value.|
|With a nonexistent or null property|`q=description.en:null`|Here, `description.en` is the field set to `null` or is nonexistent in the database.|
|With an existing property|`q=mixin:exists`|Here, `mixin` is the field that exists in the database.|
|With a nonexistent property|`q=mixin:missing`|Here, `mixin` is the field that does not exist in the database.|
|By multiple specific values|`q=id:(5c3325baa9812100098ff48f,5c3325d1a9812100098ff494)`|Here, `id` is the field name, and the values within the brackets are the desired IDs.|
|By multiple fields|`q=id:5c3325baa9812100098ff48f code:A705121667`| Here, `id` and `code` are field names. All objects containing the specified values are returned. Multiple fields (separated by spaces) can be specified. Multiple values for each field can also be specified in the format shown earlier.|
|With string-based properties conforming to a regex|`q=code:~ABCD12` or `q=code:(~AB CD)` for strings with spaces| Here, `code` is the field name, and `ABCD12` or `AB CD` are regex patterns for querying.|
|With a localized string-based property conforming to a regex|`q=name.en:~(Yoghurt im)`| Here, `name` is the field name, `en` is the language code, and `Yoghurt im` is the regex search term.|


