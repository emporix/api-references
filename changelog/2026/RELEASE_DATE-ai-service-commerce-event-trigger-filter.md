---
icon: sparkles
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: false
  pagination:
    visible: true
---

# RELEASE_DATE: AI Service - commerce event trigger filter support and job status update

## Overview

The AI Service API now supports payload-level filtering for `commerce_events` agent triggers.
You can define filter expressions so an agent is triggered only when an incoming commerce event payload matches the configured criteria.
Additionally, jobs now support the `skipped` status value.

## Updated types

| Type         | Change summary                                                           |
|--------------|--------------------------------------------------------------------------|
| AgentTrigger | Added optional `filter` field for the `commerce_events` trigger variant. |
| JobStatus    | Added `skipped` enum value.                                              |

## Updated endpoints

| Endpoint                                                                                                                                            | Change summary                                                                |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| [Retrieving agent by ID](https://developer.emporix.io/api-references-1/readme/api-reference/agent#get-ai-service-tenant-agentic-agents-agentid)     | Response can now include `trigger.filter` for `commerce_events` triggers.     |
| [Listing Agents](https://developer.emporix.io/api-references-1/readme/api-reference/agent#get-ai-service-tenant-agentic-agents)                     | Response can now include `trigger.filter` for `commerce_events` triggers.     |
| [Upserting agent](https://developer.emporix.io/api-references-1/readme/api-reference/agent#put-ai-service-tenant-agentic-agents-agentid)            | Request payload now supports `trigger.filter` for `commerce_events` triggers. |
| [Partially updating agent](https://developer.emporix.io/api-references-1/readme/api-reference/agent#patch-ai-service-tenant-agentic-agents-agentid) | Request payload now supports `trigger.filter` for `commerce_events` triggers. |
| [Listing available jobs](https://developer.emporix.io/api-references-1/readme/api-reference/job#get-ai-service-tenant-jobs)                         | Job responses can now return `status: skipped`.                               |
| [Searching jobs](https://developer.emporix.io/api-references-1/readme/api-reference/job#post-ai-service-tenant-jobs-search)                         | Job responses can now return `status: skipped`.                               |
| [Retrieving available job](https://developer.emporix.io/api-references-1/readme/api-reference/job#get-ai-service-tenant-jobs-jobid)                 | Job response can now return `status: skipped`.                                |

## Known problems

There are no known problems.
