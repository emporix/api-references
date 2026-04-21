---
icon: wand-sparkles
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

# 2026-04-21: Session Context Service - language attribute added to session context model

## Overview

The Session Context Service has been updated with a new `language` attribute in the session context model. This attribute is now returned in session context GET responses and accepted in session context update requests.

## Updated endpoints

| Endpoint                                                                                                                                                                       | Description                                                                |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------|
| [Retrieving a session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/session-management#get-session-context-tenant-context-sessionid)          | The response now includes the `language` attribute in the session context. |
| [Retrieving own session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/own-session-management#get-session-context-tenant-me-context)           | The response now includes the `language` attribute in the session context. |
| [Partially updating own session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/own-session-management#patch-session-context-tenant-me-context) | The `language` attribute is now accepted as an updatable field.            |
| [Updating a session context](https://developer.emporix.io/api-references-1/readme/api-reference-34/session-management#put-session-context-tenant-context-sessionid)            | The `language` attribute is now accepted as an updatable field.            |

## Known problems

There are no known problems.
