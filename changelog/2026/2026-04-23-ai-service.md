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

# 2026-04-23: AI Service - Agent Analytics

## Overview

The AI Service has been enhanced with new analytics capabilities for agents. New endpoints are now available to retrieve per-agent execution
counts and a comprehensive analytics bundle for the last four weeks, allowing for better tracking of agent usage and performance over time.

## New endpoints

| Endpoint                                                                                                                                                                                                           | Description                                                                                                                             |
|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------|
| [Retrieving agent analytics bundle for last four weeks](https://developer.emporix.io/api-references/artificial-intelligence/ai-service/api-reference/agent-analytics#get-ai-service-tenant-agentic-analytics)      | Returns a single bundle of analytics for dashboards including request and session aggregates, resolution efficiency, and weekly trends. |
| [Retrieving per-agent execution counts by period](https://developer.emporix.io/api-references/artificial-intelligence/ai-service/api-reference/agent-analytics#get-ai-service-tenant-agentic-analytics-executions) | Returns execution counts per agent for each calendar period (quarter, month, or week).                                                  |

## Known problems

There are no known problems.
