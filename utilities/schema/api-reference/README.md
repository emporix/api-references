---
layout:
  width: wide
icon: rectangle-terminal
---

# API Reference

## Custom Entities Bulk Operations

The Schema Service supports bulk creation and upsert operations for custom entity instances. These operations allow clients to submit multiple custom entity instances in a single request to improve efficiency.

### Bulk Operation Limits

- **Maximum number of items per bulk request:** 5000

This limit has been increased from the previous maximum of 1000 items to allow larger batch processing and reduce import times.

### Endpoints Affected

- `POST /{tenant}/custom-entities/{type}/instances/bulk-create`
- `POST /{tenant}/custom-entities/{type}/instances/bulk-upsert`

### Validation

Requests containing more than 5000 items will be rejected with a validation error indicating the maximum allowed payload size.

### Error Response Example for Exceeding Limit

```json
{
  "error": "Payload size exceeded",
  "message": "Maximum size of the payload array is 5000."
}
```

Clients should ensure their payloads do not exceed this limit to avoid errors.

### Notes

- The increase in bulk size limit may impact performance; clients and services should monitor processing times and handle potential timeouts appropriately.
- Partial failures within bulk requests continue to be handled as per existing logic.
- Authentication, authorization, and API paths remain unchanged.

For detailed request and response schemas, please refer to the respective endpoint documentation sections.
