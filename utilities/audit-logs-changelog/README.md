---
layout:
  width: wide
icon: clock-rotate-left
---

# Audit Logs (Changelog) Service

Query tenant-wide change history for Emporix platform entities.

### Key features and benefits

* Retrieves paginated changelog history across configured platform entities
* Supports opt-in cursor pagination for walking through large result sets without totals
* Filters results with the standard `q` parameter by entity, document ID, change type, actor, time range, and related entities
* Returns flattened before/after field paths for each change
* Supports compound logical queries with nested `OR` and `AND` expressions
* Applies a default 7-day time window when `q` has no `occurredAt` lower bound outside an `OR` condition
