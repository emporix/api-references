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

# 2026-04-10: Session Context Service - language attribute added to session context model

## Overview

The Session Context Service has been updated with a new `language` attribute in the session context model. This attribute is now returned in session context GET responses and accepted in session context update requests.

## Updated endpoints

| Endpoint                                             | Description                                                                |
|------------------------------------------------------|----------------------------------------------------------------------------|
| `[GET] session-context/{tenant}/context/{sessionId}` | The response now includes the `language` attribute in the session context. |
| `[GET] session-context/{tenant}/me/context`          | The response now includes the `language` attribute in the session context. |
| `[PATCH] session-context/{tenant}/me/context`        | The `language` attribute is now accepted as an updatable field.            |
| `[PUT] session-context/{tenant}/context/{sessionId}` | The `language` attribute is now accepted as an updatable field.            |

## Known problems

There are no known problems.
