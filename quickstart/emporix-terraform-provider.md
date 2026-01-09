---
description: Manage Emporix resources and configuration with the Terraform provider.
icon: t
layout:
  width: wide
---

# Emporix Terraform Provider

The **Emporix Terraform Provider** lets you manage Emporix configuration using **Infrastructure as Code** (IaC) with [Terraform](https://www.terraform.io/). It can be especially useful for repeatable, reviewable changes across environments (for example: dev, staging, production) instead of applying changes manually. You can use it to configure resources such as countries, payment modes, or site settings.

### Prerequisites

Before you start, make sure you have:

* **Emporix Account** - An active Emporix tenant
* **API Keys** - OAuth 2.0 client credentials or access token
* **Terraform** - Version 1.0 or later

{% hint style="success" %}
For specific details of what to prepare and how to configure the Emporix Terraform Provider in your environment, follow the instructions in the [Emporix Terraform Docs](https://registry.terraform.io/providers/emporix/emporix/latest/docs). The documentation contains information about the initial setup requirements and configuration of the specific resources.
{% endhint %}
