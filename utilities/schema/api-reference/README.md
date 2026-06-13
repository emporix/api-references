---
layout:
  width: wide
icon: rectangle-terminal
---

# API Reference

## Bulk Request Limits for Custom Entities

The bulk creation endpoint for custom entity instances allows clients to create multiple instances in a single request. The current maximum number of items allowed in the payload array for bulk creation is **5000**.

### Endpoint

`POST /{tenant}/custom-entities/{type}/instances`

### Limit Details

- **Maximum payload size:** 5000 items
- **Error message when exceeding limit:** "Maximum size of the payload array is 5000."

### Notes

- This limit increase improves import throughput by allowing larger batches in a single request.
- Clients should ensure they can handle the larger payloads in terms of memory and processing.
- No changes to request or response schemas other than the increased limit.
- Authentication and authorization behavior remains unchanged.

For more information on bulk request limits across Emporix services, see the [Bulk Request Limits](../../standard-practices/bulk-request-limits.md) documentation.
