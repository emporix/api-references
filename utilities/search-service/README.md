---
layout:
  width: wide
icon: magnifying-glass
---

# Search Service

Searches custom instances for a tenant, stores saved searches, and manages the indexes and jobs used by that search.

{% hint style="danger" %}
This service is in preview mode - some of the features may not be fully operational yet.
{% endhint %}

### Key features and benefits

* Searches custom instances of one custom schema type by text, phrase, autocomplete, or wildcard
* Filters and combines matches with `and` and `or` groups
* Returns a page of custom instances, with an optional total count
* Stores a search for a custom schema type and runs it later with new text without starting an index build
* Creates, reads, updates, and deletes a search index for a custom schema type
* Starts a job to build an index when the index is created or when its field definition changes
* Updates `name` and `description` on a ready index without starting a job when the field definition stays the same
* Starts a job to delete an index
* Reads index jobs.
