---
icon: book
layout:
  width: default
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
  metadata:
    visible: true
---

# widget service tutorial

This tutorial simply explains how you can just use the widget service to sync widgets. It is important to note that the widget service is a fictional service created for copilot flow testing.

## Before You Start

The user should configure an API token before proceeding.

## Batch Sync — Getting Started

Widgets can be synchronized by sending a request to the batch sync endpoint. To do that, the [POST /widget/{tenant}/batch-sync](https://developer.emporix.io/api-references/api-guides/utilities/widget-service/api-reference/batch-sync#operation/POST-widget-batch-sync) endpoint should be used.

```bash
curl -X POST \
  'https://api.emporix.io/widget/{tenant}/batch-sync \
  -H 'Authorization: Bearer YOUR_ACCESS_TOKEN' \
  -d '{
    "widgetIds": ["w-001", "w-002"],
    priorityQueue: true
  }'
```

## How To Check Sync Status

After a batch job is started, the status can be retrieved.

```bash
curl -i -X GET \
  'https://api.emporix.io/widget/{tenant}/sync/{jobId}' \
  -H 'Authorization: Bearer {{OAUTH2_ACCESS_TOKEN}}'
```

### Expected Results

* HTTP 200 – job completed successfully
* HTTP 404 – job not found

## Troubleshooting

If something goes wrong, obviously you should retry the request until it works.
