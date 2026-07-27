---
layout:
  width: wide
icon: file-import
---

# Import Tool

Imports external master data into Emporix. A configuration groups one or more streams; each stream extracts from a source connection, maps fields to an Emporix target type, and upserts idempotently. 
### Key features and benefits

* Imports external master data into Emporix through configured streams
* Groups one or more streams in a configuration, each mapping source fields to an Emporix target type
* Performs idempotent upserts of imported records
* Triggers import runs manually or on a cron schedule
* Supports full and delta run modes, with an optional dry run that validates without writing
* Runs imports asynchronously and streams per-stream progress over Server-Sent Events
* Monitors run status, history, errors, and per-stream counters
* Cancels active import jobs
* Retrieves configurations, streams, schedules, and imported records
