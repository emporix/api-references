---
icon: server
description: Migration of all non-production tenants to a dedicated Pre-Production Environment.
title: Pre-Production Environment Migration
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
---

# Pre-Production Environment Migration

We are migrating all non-production tenants (demo, prospect, partner, and customer test/development environments) from the production infrastructure to a dedicated **Pre-Production Environment**.

This separation provides greater flexibility for managing test and demo environments while strengthening overall platform security and isolation from live production workloads.

{% hint style="info" %}

**No productive customer tenants are affected**

**Zero live production (`PROD`) customer tenants will be moved, modified, or impacted by this migration.** All productive customer environments remain completely untouched on the production infrastructure (`https://admin.emporix.io` / `https://api.emporix.io`) with zero downtime or service interruption. Only explicitly designated non-production environments (demo, prospect, partner, and customer `DEV`/`QA`/test tenants) are part of this migration.

{% endhint %}

## Migration timeline and notifications

**All tenant admins will be informed in advance via email of the exact scheduled migration date and time for their respective tenants.**

The migration is being executed in phased waves according to tenant category:

| Phase / Target Window | Tenant Category | Scope & Notes |
| --- | --- | --- |
| **Week 2 of November** | Internal & Demo Tenants | Internal Emporix demo and sandbox environments. |
| **Week 3 of November** | Prospect Tenants | Active prospect evaluation and PoC tenants. |
| **Week 4 of November** | Partner Tenants | Partner sandboxes, training, and presales tenants. |
| **Week 1 of December** *(CW 50: Dec 7–11)* | Client Non-Prod Tenants | Customer **test** and **development** (`DEV` / `QA`) tenants only. **All productive (`PROD`) customer tenants remain completely unaffected.** |

{% hint style="warning" %}

**Migration day**

Each migration is performed from a point-in-time snapshot. **Please avoid making any configuration changes, data imports, or code updates on your scheduled migration day**, as any changes made during the migration window will not carry over to the pre-production environment.

{% endhint %}

## What changes after migration?

Once your non-production tenant is migrated, it will no longer appear in the tenant list on the production Management Dashboard (`https://admin.emporix.io/`). Instead, you must access your non-production tenant using the dedicated pre-production endpoints:

| Service / Component | Legacy Production URL | New Pre-Production URL |
| --- | --- | --- |
| **Management Dashboard** | `https://admin.emporix.io` | `https://admin-preprod.emporix.io` |
| **Developer Portal** | `https://app.emporix.io` | `https://app-preprod.emporix.io` |
| **API Base URL** | `https://api.emporix.io` | `https://api-preprod.emporix.io` |

### Required action: update your API base URLs

* **Temporary redirection:** Traffic sent to `https://api.emporix.io` for migrated tenants is currently redirected automatically to `https://api-preprod.emporix.io` so existing setups continue functioning immediately after migration.
* **Mandatory cutoff:** This automatic redirect is **temporary** and will be retired in the near future. You must update the API base URL to `https://api-preprod.emporix.io` across all **storefronts, middleware integrations, webhooks, and custom extensions** connected to your non-production tenants as soon as possible.

## Findings and solutions (troubleshooting)

During the initial migration waves and internal testing, the following technical behaviors and edge cases were identified along with their respective solutions:

### 1. CORS errors in custom extensions and perspectives

* **Finding:** Custom Management Dashboard extensions, perspectives, or browser-based integrations still pointing to `https://api.emporix.io` may encounter Cross-Origin Resource Sharing (`CORS`) blocks after migration, even while server-to-server redirects are active.
* **Solution:** Update the API invocation endpoint directly in your extension's configuration or environment variables from `https://api.emporix.io` to `https://api-preprod.emporix.io`.

### 2. Automated offboarding or deletion flagging on protected tenants

* **Finding:** During pre-migration cleanup workflows, certain active customer or training non-production tenants (such as `DEV`/`QA` environments or `trainingemporix`) were inadvertently flagged by automated offboarding rules if no prior confirmation was logged.
* **Solution:** Emporix has updated the tenant protection safeguards prior to migration runs. If you receive a migration notice, please reply before the stated deadline to confirm whether you wish to retain or decommission the tenant. If a tenant is accidentally marked for offboarding, contact Support immediately so the protection lock can be restored.

### 3. Data and service synchronization (Commerce, OE, and Identity/ORY)

* **Finding:** Early test migrations revealed occasional step timeouts or sync discrepancies across sub-services—specifically **Commerce Data Migration**, **Orchestration Engine (OE) Data**, **ORY Identity Data**, and **GCP Hosting Project Reprovisioning**—when tenants were actively modified during the snapshot window.
* **Solution:**
  * Automated retry and verification checks have been added to the Cloud Build migration pipeline for ORY, OE, and Commerce data steps.
  * Users must adhere to the **migration-day freeze** (no active usage on the scheduled date) to guarantee a clean, consistent snapshot transfer.

### 4. Unused legacy tenants decommissioning

* **Finding:** Many legacy test and demo tenants created in previous years are no longer actively used, consuming unnecessary infrastructure resources.
* **Solution:** Before migrating, tenant owners and admins are contacted to confirm active usage. If a tenant is no longer needed, Emporix can cleanly delete it upon request—you can always provision a fresh pre-production tenant later whenever needed.

## Support and contact

If you experience any issues accessing your migrated tenant, encounter unexpected API behavior, or need to confirm your tenant's migration schedule, please reach out to our migration team at [**preprodmigration@emporix.com**](mailto:preprodmigration@emporix.com).
