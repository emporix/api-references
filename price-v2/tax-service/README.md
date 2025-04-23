# Tax Service

Tax class descriptions. When specified, only tax configurations containing the specified tax class descriptions will be returned.

**Important**: 

See how the `Accept-Language` header influences this parameter:
* If The `Accept-Language` header is set to `*`, you need to specify a language in this parameter.

    For example, if the `Accept-Language` header is set to `*` and you want to find English descriptions containing the word "Fruit", this parameter should be set to "description.en=Fruit"

* If the `Accept-Language` header is set to a particular language or not specified, you do not need to specify a language in this parameter.

    For example, if the `Accept-Language` header is set to `en` and you want to find descriptions containing the word "Fruit", this parameter should be set to "description=Fruit"

{% hint style="warning" %}
When filtering the results with this field, the `contains` operator is used. The operator is case-sensitive.
{% endhint %}