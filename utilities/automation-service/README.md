---
layout:
  width: wide
icon: gears
description: The Automation Service runs tenant-defined rules when platform events occur, on a schedule, or on demand.
---

# Automation Service

The Emporix Automation Service runs tenant-defined rules when platform events occur, on a schedule, or on demand. Each rule evaluates optional conditions and then executes one or more actions, such as an HTTP callback.

### Key features and benefits

* Defines reusable automation rules with a trigger, optional conditions, and one or more actions
* Runs rules on platform events, on a cron schedule, or through a manual request
* Supports dry runs that validate a rule without executing its actions
* Records every execution as a run that you can retrieve and inspect
* Retries failed HTTP actions according to the rule retry policy
