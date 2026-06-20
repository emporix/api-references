---
layout:
  width: wide
icon: rectangle-terminal
---

# API Reference

## Schema Service

### Bulk Create Custom Entity Instances

`POST /schema/{tenant}/custom-entities/{type}/instances/bulk`

This endpoint allows creating multiple instances of a custom entity type in a single request.

#### Request Body
- An array of custom entity instances to create.

#### Limits
- **Maximum number of items per request:** 5000

#### Validation
- Requests with more than 5000 items will be rejected with a validation error.
- The error message for exceeding the limit is: "Maximum size of the payload array is 5000."

#### Notes
- The bulk creation limit was increased from 1000 to 5000 to improve import performance.
- Clients should update their tooling to accommodate the new limit.
- Ensure that operational safeguards such as rate limiting and request size limits are reviewed to handle the increased payload size.

---

*For detailed information on other endpoints and usage, please refer to the full Schema Service API documentation.*
