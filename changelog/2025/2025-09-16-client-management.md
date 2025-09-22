---
icon: sparkles
---
layout:
   width: wide
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

# 2025-09-16: Client Management Service – new customer assignment propagation settings

## Overview

Additional `companyContactPropagation` settings were added to define how company contact assignments are propagated within a company hierarchy.

* UPWARD – an existing setting that is set as default one, propagation from subsidiaries to parent
* DOWNWARD – new, propagation from parent to subsidiaries
* DISABLED – new, no propagation

Propagation occurs only at the moment of assignment: creating a contact in one company also creates corresponding contacts in related companies based on the configured direction.

## Known problems

There are no known problems.

