---
layout:
  width: wide
icon: clock-rotate-left
---

# Audit Logs (Changelog) Service

Query tenant-wide change history for Emporix platform entities.

{% hint style="danger" %}
This functionality is in preview mode - some of the features may not be fully operational yet.

If you have any questions, contact the [Emporix Support Team](mailto:support@emporix.com) or post directly in the [Community](https://community.emporix.io/).
{% endhint %}

### Key features and benefits

* Retrieves paginated changelog history across configured platform entities
* Filters results with the standard `q` parameter by entity, document ID, change type, actor, time range, and related entities
* Returns flattened before/after field paths for each change
* Supports compound logical queries with nested `OR` and `AND` expressions
* Applies a default 30-day time window when no conjunctive `occurredAt` from-bound is provided
