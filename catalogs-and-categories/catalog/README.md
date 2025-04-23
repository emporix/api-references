# catalog

The Catalog Management API gives you the tools required to structure your product offering the way it suites you best.

### Key features and benefits

* Structuring your products
  * Create a new catalog
  * Modify an existing catalog
  * Remove a catalog you no longer need
* List your catalogs
  * Filtered, sorted and paged list of catalogs
  * List of catalogs holding a particular category
  * View catalog details
  
**Localization**

The name and the description attribute of a catalog support localization. This means that you can provide values in a specific locale and also retrieve those values either localized, or all together, as you choose.
Localization is controlled via two headers:

* Accept-Language - this is used to specify how to retrieve catalogs. If a value is provided, then the resources will be returned in that locale. If '*' is provided as a value, or the header is missing, all locales saved on a resource will be returned for that resource.
* Content-Language - this header is used to specify if the data that will be stored for this request has a particular locale or you are providing all the desired locales.
You can see detailed examples for the requests affected by this bellow.

