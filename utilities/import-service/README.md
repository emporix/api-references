---
layout:
  width: wide
icon: file-import
---

# Import Service

Imports external master data into Emporix. A configuration groups one or more streams; each stream extracts from a source connection, maps fields to an Emporix target type, and upserts idempotently.

### Key features and benefits

The Import Service provides the following capabilities:

* Imports external master data into Emporix through configured streams
* Groups one or more streams in a configuration, each mapping source fields to an Emporix target type
* Performs idempotent upserts of imported records
* Triggers import runs manually or on a cron schedule
* Queues delimited files for file-based streams and reports which files a run read
* Supports full and delta run modes, with an optional dry run that validates without writing
* Runs imports asynchronously and streams per-stream progress over Server-Sent Events
* Monitors run status, history, errors, and per-stream counters
* Cancels active import jobs
* Retrieves configurations, streams, schedules, and imported records
