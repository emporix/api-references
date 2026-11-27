---
layout:
  width: wide
icon: arrows-rotate
---

# Deployment Center

{% hint style="danger" %}
This functionality is in preview mode - some of the features may not be fully operational yet.
{% endhint %}

Synchronizes configuration between tenants. It bundles custom entities, agents, cloud functions, hostings, indexes and value streams into packages, builds numbered versions of them, and delivers each version to the tenants of a workflow, either by pushing it directly or by releasing it for a later install on the receiving side.

### Key features and benefits

The Deployment Center provides the following capabilities:

* Keeps a catalog of target tenants whose credentials are write-only and are never returned
* Defines workflows as trees of steps, so that a version moves from one environment to the next in a set order
* Groups custom entities, agents, cloud functions, hostings, indexes and value streams into packages
* Builds versioned packages and compares the source tenant with the latest version before a build
* Previews a version on a target tenant and shows what is created, updated or deleted, including target drift and breaking changes
* Pushes a version directly to a target tenant, or releases it so that the receiving tenant installs it locally
* Runs previews, builds, pushes, releases, rollbacks and local installs as jobs, with progress and per-item results, and lets you cancel a job
* Enforces the promotion rule, so a step receives a version only after its parent step has that version or a newer one, unless the parent is the package source
* Rolls back the last successful push or local install of an installation; a release only offers versions and cannot be rolled back
* Keeps install logs and shows coverage per workflow step and a dashboard of pending packages, waiting upgrades and open failures
