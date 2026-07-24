---
layout:
  width: wide
icon: rectangle-terminal
---

# API Reference

## Group assignments for customer segments

{% hint style="warning" %}
Preview
{% endhint %}

Customer segments now support the `GROUP` assignment type. You can assign IAM customer groups to a customer segment. Only groups with `userType` set to `CUSTOMER` can be assigned.

### Upsert a group assignment

`PUT /{tenant}/segments/{segmentId}/groups/{groupId}`

Creates or updates a group assignment for the specified segment.

**Required scope:** `segment.segment_manage`

#### Path parameters

| Name | Type | Description |
| --- | --- | --- |
| `tenant` | string | Tenant name. |
| `segmentId` | string | Segment identifier. |
| `groupId` | string | IAM group identifier. |

#### Request body

Uses the same assignment payload as other segment assignment upsert endpoints.

| Field | Type | Description |
| --- | --- | --- |
| `mixins` | object | Optional assignment mixins. |
| `metadata` | object | Assignment metadata. |

#### Responses

| Status | Description |
| --- | --- |
| `201 Created` | The assignment is created and the response returns a creation response body. |
| `204 No Content` | The assignment is updated. |
| `400 Bad Request` | The segment does not exist or the group `userType` is not `CUSTOMER`. |
| `404 Not Found` | The group does not exist. |
| `403 Forbidden` | The caller does not have the required scope. |

### Get a group assignment

`GET /{tenant}/segments/{segmentId}/groups/{groupId}`

Returns a single group assignment.

**Required scope:** `segment.segment_read`

#### Path parameters

| Name | Type | Description |
| --- | --- | --- |
| `tenant` | string | Tenant name. |
| `segmentId` | string | Segment identifier. |
| `groupId` | string | IAM group identifier. |

#### Response body

| Field | Type | Description |
| --- | --- | --- |
| `segmentId` | string | Segment identifier. |
| `group` | object | Assigned group data. |
| `group.id` | string | Group identifier. |
| `group.name` | object | Localized group name. |
| `mixins` | object | Assignment mixins. |
| `metadata` | object | Assignment metadata. |

#### Responses

| Status | Description |
| --- | --- |
| `200 OK` | Returns the assignment. |
| `404 Not Found` | The assignment does not exist. |
| `403 Forbidden` | The caller does not have the required scope. |

### List group assignments

`GET /{tenant}/segments/{segmentId}/groups`

Returns group assignments for the specified segment.

**Required scope:** `segment.segment_read`

#### Path parameters

| Name | Type | Description |
| --- | --- | --- |
| `tenant` | string | Tenant name. |
| `segmentId` | string | Segment identifier. |

#### Query parameters and headers

Supports the standard assignment collection parameters and headers, including paging, sorting, filtering with `q`, field selection, and the `X-Total-Count` response header.

#### Responses

| Status | Description |
| --- | --- |
| `200 OK` | Returns a list of group assignments. |
| `403 Forbidden` | The caller does not have the required scope. |

### Search group assignments

`POST /{tenant}/segments/{segmentId}/groups/search`

Searches group assignments for the specified segment.

**Required scope:** `segment.segment_read`

#### Path parameters

| Name | Type | Description |
| --- | --- | --- |
| `tenant` | string | Tenant name. |
| `segmentId` | string | Segment identifier. |

#### Request body

| Field | Type | Description |
| --- | --- | --- |
| `q` | string | Filter expression, for example `group.id:groupId1`. |

#### Responses

| Status | Description |
| --- | --- |
| `200 OK` | Returns matching group assignments. |
| `403 Forbidden` | The caller does not have the required scope. |

### Delete a group assignment

`DELETE /{tenant}/segments/{segmentId}/groups/{groupId}`

Deletes the group assignment if it exists.

**Required scope:** `segment.segment_manage`

#### Path parameters

| Name | Type | Description |
| --- | --- | --- |
| `tenant` | string | Tenant name. |
| `segmentId` | string | Segment identifier. |
| `groupId` | string | IAM group identifier. |

#### Responses

| Status | Description |
| --- | --- |
| `204 No Content` | The assignment is deleted or does not exist. |
| `403 Forbidden` | The caller does not have the required scope. |

### Behavior notes

- When a group is updated in IAM, the assignment stores the updated `group.name`.
- If a group's `userType` changes to `EMPLOYEE`, all assignments for that group are removed.
- If a group is deleted, all assignments for that group are removed.
