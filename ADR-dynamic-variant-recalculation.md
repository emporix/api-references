# ADR: Dynamic Variant Recalculation

## Status

Proposed

## Context

We are implementing dynamic variants where products form a tree hierarchy (up to 4 levels deep). Variants can be created in any order — a child variant may exist before its parent — to simplify integration for customers doing bulk data replication.

Each variant level stores its own `variantAttributes` (the attributes that distinguish it from its parent). The root product stores a denormalized flat map of **all** descendants in its `variants` field, containing only **delta attributes** — i.e., the attributes introduced at that variant's own level. Each entry also carries the variant's localized `name` and a `published` flag (internal, not exposed in API responses). The `parentVariantId` on each entry allows the tree to be reconstructed. Accumulated (fully merged) attributes are **computed at response time** by the API before returning the product to the client — for an L2 entry, this means its parent L1's attributes are merged in, so the storefront receives a ready-to-use view with all attribute combinations without additional API calls.

### Data Model Example

The tree below shows one branch: root → level 1 variant → level 2 leaf (sellable).

#### Variant Attribute Structure

Each variant attribute is a structured object rather than a simple scalar. This supports localized display names for both the attribute and its selected value, as well as optional units for numeric measurements. The `qualifier` field holds the raw value used for variant selection and matching. The `type` enum indicates the value type for validation and serialization.

```json
"attributeKey": {
    "name": {
        "en": "Attribute Display Name",
        "deDE": "Lokalisierter Attributname"
    },
    "value": {
        "type": "Decimal",
        "qualifier": "CODE_OR_NUMBER",
        "unit": "MMT",
        "name": {
            "en": "Display value",
            "deDE": "Lokalisierter Wert"
        }
    }
}
```

- `name` — localized label of the attribute itself (e.g., "Surface Protection" / "Oberflächenschutz")
- `value.type` — enum: `String`, `Boolean`, `Number`, or `Decimal`. Indicates the type of `qualifier`.
- `value.qualifier` — the canonical value used for matching: a string code (`"ZP"`), a number (`3.0`), or a boolean (`true`)
- `value.name` — localized display label for the selected value (e.g., "zinc plated" / "verzinkt")
- `value.unit` — optional, present only for measurement attributes. A **code** string (e.g. `"MMT"`, `"PCE"`). Unit translations are defined in a separate dictionary in the system; the frontend resolves the code to localized labels. On create/update, the API accepts and stores only the unit code — not the full unit object. The response returns the code so the frontend can look it up.

**Root product (stored in DB)** — flat map of all descendants with **delta attributes only** (each entry stores only the attributes introduced at that level). Each entry also carries `name` (localized) and `published` (internal flag, not exposed in API responses):

```json
{
    "id": "parentRoot",
    "productType": "DYNAMIC_VARIANT",
    "name": "parentRoot",
    "published": true,
    "variants": {
        "variant_l1_1": {
            "version": "1",
            "name": { "en": "M3x20 CSKP ZP", "deDE": "M3x20 CSKP ZP" },
            "published": true,
            "parentVariantId": "parentRoot",
            "sellable": false,
            "screwHeadType": {
                "name": { "en": "Head Type", "deDE": "Kopfform" },
                "value": {
                    "type": "String",
                    "qualifier": "CSKP",
                    "name": { "en": "Countersunk milling pockets", "deDE": "Senkkopf mit Frästaschen" }
                }
            },
            "screwThreadType": {
                "name": { "en": "Thread Type", "deDE": "Gewindeausführung" },
                "value": {
                    "type": "String",
                    "qualifier": "PT",
                    "name": { "en": "Partial thread", "deDE": "Teilgewinde" }
                }
            },
            "screwSurfaceTreatment": {
                "name": { "en": "Surface Protection", "deDE": "Oberflächenschutz" },
                "value": {
                    "type": "String",
                    "qualifier": "ZP",
                    "name": { "en": "zinc plated", "deDE": "verzinkt" }
                }
            },
            "screwDiameter": {
                "name": { "en": "Nominal Diameter", "deDE": "Gewinde-Nenndurchmesser" },
                "value": {
                    "type": "Decimal",
                    "qualifier": 3.0,
                    "unit": "MMT",
                    "name": { "en": "3.0 mm", "deDE": "3,0 mm" }
                }
            },
            "screwLength": {
                "name": { "en": "Total Length", "deDE": "Gesamtlänge" },
                "value": {
                    "type": "Number",
                    "qualifier": 20,
                    "unit": "MMT",
                    "name": { "en": "20 mm", "deDE": "20 mm" }
                }
            }
        },
        "variant_l1_1_1": {
            "version": "1",
            "name": { "en": "M3x20 CSKP ZP – Canister", "deDE": "M3x20 CSKP ZP – Kanister" },
            "published": true,
            "parentVariantId": "variant_l1_1",
            "sellable": true,
            "packaging": {
                "name": { "en": "Packaging", "deDE": "Verpackung" },
                "value": {
                    "type": "String",
                    "qualifier": "CANISTER",
                    "name": { "en": "Canister", "deDE": "Kanister" }
                }
            }
        }
    }
}
```

- **`name`** — localized variant name, stored on each entry for display purposes (e.g., search results, admin lists).
- **`published`** — stored in DB for filtering (e.g., exclude unpublished variants from storefront responses) but **not included in API responses**. The API strips this flag before returning the `variants` map.

**Root product (API response)** — the API computes accumulated attributes at response time by walking `parentVariantId` chains and merging parent attributes into child entries. The `published` flag is **stripped** from the response (used internally for filtering only). L1 entries show their own attributes; L2 entries show their parent's (L1) attributes **plus** their own:

```json
{
    "id": "parentRoot",
    "productType": "DYNAMIC_VARIANT",
    "name": "parentRoot",
    "published": true,
    "variants": {
        "variant_l1_1": {
            "version": "1",
            "name": { "en": "M3x20 CSKP ZP", "deDE": "M3x20 CSKP ZP" },
            "parentVariantId": "parentRoot",
            "sellable": false,
            "screwHeadType": {
                "name": { "en": "Head Type", "deDE": "Kopfform" },
                "value": {
                    "type": "String",
                    "qualifier": "CSKP",
                    "name": { "en": "Countersunk milling pockets", "deDE": "Senkkopf mit Frästaschen" }
                }
            },
            "screwThreadType": {
                "name": { "en": "Thread Type", "deDE": "Gewindeausführung" },
                "value": {
                    "type": "String",
                    "qualifier": "PT",
                    "name": { "en": "Partial thread", "deDE": "Teilgewinde" }
                }
            },
            "screwSurfaceTreatment": {
                "name": { "en": "Surface Protection", "deDE": "Oberflächenschutz" },
                "value": {
                    "type": "String",
                    "qualifier": "ZP",
                    "name": { "en": "zinc plated", "deDE": "verzinkt" }
                }
            },
            "screwDiameter": {
                "name": { "en": "Nominal Diameter", "deDE": "Gewinde-Nenndurchmesser" },
                "value": {
                    "type": "Decimal",
                    "qualifier": 3.0,
                    "unit": "MMT",
                    "name": { "en": "3.0 mm", "deDE": "3,0 mm" }
                }
            },
            "screwLength": {
                "name": { "en": "Total Length", "deDE": "Gesamtlänge" },
                "value": {
                    "type": "Number",
                    "qualifier": 20,
                    "unit": "MMT",
                    "name": { "en": "20 mm", "deDE": "20 mm" }
                }
            }
        },
        "variant_l1_1_1": {
            "version": "1",
            "name": { "en": "M3x20 CSKP ZP – Canister", "deDE": "M3x20 CSKP ZP – Kanister" },
            "parentVariantId": "variant_l1_1",
            "sellable": true,
            "screwHeadType": {
                "name": { "en": "Head Type", "deDE": "Kopfform" },
                "value": {
                    "type": "String",
                    "qualifier": "CSKP",
                    "name": { "en": "Countersunk milling pockets", "deDE": "Senkkopf mit Frästaschen" }
                }
            },
            "screwThreadType": {
                "name": { "en": "Thread Type", "deDE": "Gewindeausführung" },
                "value": {
                    "type": "String",
                    "qualifier": "PT",
                    "name": { "en": "Partial thread", "deDE": "Teilgewinde" }
                }
            },
            "screwSurfaceTreatment": {
                "name": { "en": "Surface Protection", "deDE": "Oberflächenschutz" },
                "value": {
                    "type": "String",
                    "qualifier": "ZP",
                    "name": { "en": "zinc plated", "deDE": "verzinkt" }
                }
            },
            "screwDiameter": {
                "name": { "en": "Nominal Diameter", "deDE": "Gewinde-Nenndurchmesser" },
                "value": {
                    "type": "Decimal",
                    "qualifier": 3.0,
                    "unit": "MMT",
                    "name": { "en": "3.0 mm", "deDE": "3,0 mm" }
                }
            },
            "screwLength": {
                "name": { "en": "Total Length", "deDE": "Gesamtlänge" },
                "value": {
                    "type": "Number",
                    "qualifier": 20,
                    "unit": "MMT",
                    "name": { "en": "20 mm", "deDE": "20 mm" }
                }
            },
            "packaging": {
                "name": { "en": "Packaging", "deDE": "Verpackung" },
                "value": {
                    "type": "String",
                    "qualifier": "CANISTER",
                    "name": { "en": "Canister", "deDE": "Kanister" }
                }
            }
        }
    }
}
```

Note how `variant_l1_1_1` (L2) in the response contains all attributes from its parent `variant_l1_1` (L1) — `screwHeadType`, `screwThreadType`, `screwSurfaceTreatment`, `screwDiameter`, `screwLength` — plus its own `packaging`. These parent attributes are **not stored on the L2 entry in the database**; they are **merged at response time** by walking the `parentVariantId` chain within the flat map. The `published` flag is present in the DB but stripped from the response.

**Level 1 variant (stored in DB)** — stores its own `variantAttributes` and a `variants` map of direct children (delta attributes only):

```json
{
    "id": "variant_l1_1",
    "parentVariantId": "variant_l1_1",
    "productType": "DYNAMIC_VARIANT",
    "sellable": false,
    "variantAttributes": {
        "screwHeadType": {
            "name": { "en": "Head Type", "deDE": "Kopfform" },
            "value": {
                "type": "String",
                "qualifier": "CSKP",
                "name": { "en": "Countersunk milling pockets", "deDE": "Senkkopf mit Frästaschen" }
            }
        },
        "screwThreadType": {
            "name": { "en": "Thread Type", "deDE": "Gewindeausführung" },
            "value": {
                "type": "String",
                "qualifier": "PT",
                "name": { "en": "Partial thread", "deDE": "Teilgewinde" }
            }
        },
        "screwSurfaceTreatment": {
            "name": { "en": "Surface Protection", "deDE": "Oberflächenschutz" },
            "value": {
                "type": "String",
                "qualifier": "ZP",
                "name": { "en": "zinc plated", "deDE": "verzinkt" }
            }
        },
        "screwDiameter": {
            "name": { "en": "Nominal Diameter", "deDE": "Gewinde-Nenndurchmesser" },
            "value": {
                "type": "Decimal",
                "qualifier": 3.0,
                "unit": "MMT",
                "name": { "en": "3.0 mm", "deDE": "3,0 mm" }
            }
        },
        "screwLength": {
            "name": { "en": "Total Length", "deDE": "Gesamtlänge" },
            "value": {
                "type": "Number",
                "qualifier": 20,
                "unit": "MMT",
                "name": { "en": "20 mm", "deDE": "20 mm" }
            }
        }
    },
    "variants": {
        "variant_l1_1_1": {
            "version": "2",
            "sellable": true,
            "packaging": {
                "name": { "en": "Packaging", "deDE": "Verpackung" },
                "value": {
                    "type": "String",
                    "qualifier": "CANISTER",
                    "name": { "en": "Canister", "deDE": "Kanister" }
                }
            }
        },
        "variant_l1_1_2": {
            "version": "2",
            "sellable": true,
            "packaging": {
                "name": { "en": "Packaging", "deDE": "Verpackung" },
                "value": {
                    "type": "String",
                    "qualifier": "SPRAY_CAN",
                    "name": { "en": "Spray Can", "deDE": "Sprühdose" }
                }
            }
        }
    }
}
```

**Level 2 leaf variant (stored in DB)** — stores only its own `variantAttributes`, no children:

```json
{
    "id": "variant_l1_1_1",
    "parentVariantId": "variant_l1_1",
    "productType": "DYNAMIC_VARIANT",
    "sellable": true,
    "variantAttributes": {
        "packaging": {
            "name": { "en": "Packaging", "deDE": "Verpackung" },
            "value": {
                "type": "String",
                "qualifier": "CANISTER",
                "name": { "en": "Canister", "deDE": "Kanister" }
            }
        }
    }
}
```

#### Variant API Response — Own vs. Inherited Attributes

When a variant is fetched via the API, the response splits variant attributes into two separate maps:

- **`ownVariantAttributes`** — the attributes defined directly on this entity. These are what is stored in the database and what the user can modify via PUT/PATCH. This is the source of truth for this variant's contribution to the tree.
- **`inheritedVariantAttributes`** — computed at response time by walking the `parentVariantId` chain upward and collecting all ancestor `variantAttributes`. These are read-only in the response — they cannot be modified on this entity, only on the ancestor that owns them.

This separation makes it clear to API consumers which attributes they can change on a given variant and which come from the parent hierarchy.

**Level 1 variant (API response)** — all attributes are own (parent is the root product, which has no variant attributes):

```json
{
    "id": "variant_l1_1",
    "parentVariantId": "parentRoot",
    "productType": "DYNAMIC_VARIANT",
    "sellable": false,
    "ownVariantAttributes": {
        "screwHeadType": {
            "name": { "en": "Head Type", "deDE": "Kopfform" },
            "value": {
                "type": "String",
                "qualifier": "CSKP",
                "name": { "en": "Countersunk milling pockets", "deDE": "Senkkopf mit Frästaschen" }
            }
        },
        "screwThreadType": {
            "name": { "en": "Thread Type", "deDE": "Gewindeausführung" },
            "value": {
                "type": "String",
                "qualifier": "PT",
                "name": { "en": "Partial thread", "deDE": "Teilgewinde" }
            }
        },
        "screwSurfaceTreatment": {
            "name": { "en": "Surface Protection", "deDE": "Oberflächenschutz" },
            "value": {
                "type": "String",
                "qualifier": "ZP",
                "name": { "en": "zinc plated", "deDE": "verzinkt" }
            }
        },
        "screwDiameter": {
            "name": { "en": "Nominal Diameter", "deDE": "Gewinde-Nenndurchmesser" },
            "value": {
                "type": "Decimal",
                "qualifier": 3.0,
                "unit": "MMT",
                "name": { "en": "3.0 mm", "deDE": "3,0 mm" }
            }
        },
        "screwLength": {
            "name": { "en": "Total Length", "deDE": "Gesamtlänge" },
            "value": {
                "type": "Number",
                "qualifier": 20,
                "unit": "MMT",
                "name": { "en": "20 mm", "deDE": "20 mm" }
            }
        }
    },
    "inheritedVariantAttributes": {}
}
```

**Level 2 leaf variant (API response)** — `packaging` is own, all screw attributes are inherited from the Level 1 parent:

```json
{
    "id": "variant_l1_1_1",
    "parentVariantId": "variant_l1_1",
    "productType": "DYNAMIC_VARIANT",
    "sellable": true,
    "ownVariantAttributes": {
        "packaging": {
            "name": { "en": "Packaging", "deDE": "Verpackung" },
            "value": {
                "type": "String",
                "qualifier": "CANISTER",
                "name": { "en": "Canister", "deDE": "Kanister" }
            }
        }
    },
    "inheritedVariantAttributes": {
        "screwHeadType": {
            "name": { "en": "Head Type", "deDE": "Kopfform" },
            "value": {
                "type": "String",
                "qualifier": "CSKP",
                "name": { "en": "Countersunk milling pockets", "deDE": "Senkkopf mit Frästaschen" }
            }
        },
        "screwThreadType": {
            "name": { "en": "Thread Type", "deDE": "Gewindeausführung" },
            "value": {
                "type": "String",
                "qualifier": "PT",
                "name": { "en": "Partial thread", "deDE": "Teilgewinde" }
            }
        },
        "screwSurfaceTreatment": {
            "name": { "en": "Surface Protection", "deDE": "Oberflächenschutz" },
            "value": {
                "type": "String",
                "qualifier": "ZP",
                "name": { "en": "zinc plated", "deDE": "verzinkt" }
            }
        },
        "screwDiameter": {
            "name": { "en": "Nominal Diameter", "deDE": "Gewinde-Nenndurchmesser" },
            "value": {
                "type": "Decimal",
                "qualifier": 3.0,
                "unit": "MMT",
                "name": { "en": "3.0 mm", "deDE": "3,0 mm" }
            }
        },
        "screwLength": {
            "name": { "en": "Total Length", "deDE": "Gesamtlänge" },
            "value": {
                "type": "Number",
                "qualifier": 20,
                "unit": "MMT",
                "name": { "en": "20 mm", "deDE": "20 mm" }
            }
        }
    }
}
```

When updating a variant via PUT/PATCH, only `ownVariantAttributes` is accepted in the request body. Any attempt to modify `inheritedVariantAttributes` is ignored — those values are always derived from the ancestor chain. To change an inherited attribute, the user must update the ancestor variant that owns it.

The root's `variants` map is what powers the storefront product page. The database stores only delta attributes to keep writes simple and avoid cascading updates. The API computes the accumulated view at response time — with up to 100 entries and up to 4 levels, this is a sub-millisecond in-memory merge.

### `parentVariantIdPath` — Ancestor Path on Every Variant

Every variant stores its full ancestor path as an ordered array, root-first, direct-parent-last:

```json
{ "id": "variant_l1_1",     "parentVariantIdPath": ["parentRoot"] }
{ "id": "variant_l1_1_1",   "parentVariantIdPath": ["parentRoot", "variant_l1_1"] }
{ "id": "variant_l1_1_1_1", "parentVariantIdPath": ["parentRoot", "variant_l1_1", "variant_l1_1_1"] }
```

The root product itself has an empty path (`"parentVariantIdPath": []`) or the field is absent.

This eliminates the need for `$graphLookup` in all operational paths:

| Operation | Without path | With `parentVariantIdPath` |
|---|---|---|
| Find root of a variant | `$graphLookup` upward | `path[0]` — O(1) from the document |
| Find all ancestors for inline update | `$graphLookup` upward | `path` — already on the document |
| Find all descendants of a root (batch recalc) | `$graphLookup` downward | `find({ parentVariantIdPath: rootId })` — indexed |
| Recalc endpoint: resolve roots for 1000 IDs | 1000× `$graphLookup` or aggregation | Fetch 1000 docs, read `path[0]`, deduplicate |

**Index:** A multikey index on `parentVariantIdPath` enables efficient descendant queries.

**When it's populated:**

- **Single create/update, parent exists:** Computed immediately as `parent.parentVariantIdPath + [parent.id]`.
- **Single create/update, parent does not exist yet:** Stored as empty or partial; filled during batch recalculation.
- **Batch recalculation:** The path is rebuilt top-down for every product in the tree as part of the recalc write phase.

### Scale

- One customer has nearly 1 million products
- A single product can have up to 100 variants (e.g., industrial screws with many attribute combinations)
- The system runs as a Java 17 / Micronaut microservice with up to 20 pods
- Services communicate via pub/sub

### Problem

Because variants can arrive in any order, the denormalized `variants` map on parent/root products cannot be built at write time. We need an asynchronous mechanism to recalculate the variant tree and update all ancestor levels. This mechanism must:

- Avoid concurrent recalculations of the same tree
- Handle pod failures gracefully
- Scale to large catalog imports without overwhelming the database
- Work correctly across multiple service instances

## Decision

### Dedicated Recalculation Endpoint

A new endpoint accepts a list of product IDs (up to 1000) — variants at **any level** in the tree — and triggers variant recalculation. The caller does not need to know which products are roots.

For each submitted ID, the system reads `parentVariantIdPath[0]` to determine the root parent (a single `find` fetching only the path field). The IDs are then grouped by root and one recalculation **job** is created per unique root parent, followed by a **pub/sub message** for each job.

This endpoint is intended to be called **after** a batch of products has been fully ingested, not per individual product write.

### Job Collection

Recalculation jobs are stored in a dedicated MongoDB collection (source of truth for status and deduplication):

```json
{
    "id": "job-uuid",
    "parentRoot": "root-product-id",
    "requestedByIds": ["id1", "id2", "id3"],
    "status": "PENDING | PROCESSING | FINISHED | FAILED | FAILED_PERMANENT",
    "createdAt": "timestamp",
    "processingStartedAt": "timestamp",
    "finishedAt": "timestamp",
    "error": null
}
```

- When a job is created, its status is **PENDING**. The API returns the job ID for status polling.
- If a recalculation for a given root is already **PENDING** or **PROCESSING**, the endpoint returns a conflict response with the existing job ID.
- A status endpoint allows clients to poll until the job reaches a terminal state (`FINISHED`, `FAILED`, or `FAILED_PERMANENT`).
- **Terminal jobs are retained** (`FINISHED`, `FAILED`, etc.) for observability and client polling. Documents are removed automatically after approximately one month using a **MongoDB TTL index** on a date field such as `finishedAt` (set when the job reaches any terminal state you want to expire) with `expireAfterSeconds` set to the desired retention window (e.g. 30 days). Only documents that include that indexed date are eligible for TTL expiry — `PENDING` / `PROCESSING` jobs without it are not deleted by TTL.

### Pub/Sub–Driven Processing

There is **no polling scheduler** on the pods. After a job is persisted as `PENDING`, the API **publishes a pub/sub message** carrying the job identifier (and any minimal payload needed to load the job from MongoDB).

Each product-v2 pod runs a **subscriber** alongside the HTTP API. The subscriber is configured so that **only one job is processed at a time per pod** (single-threaded consumer or equivalent concurrency limit of one). That bounds load per pod: with *N* pods, at most *N* different jobs run concurrently across the cluster.

The pub/sub subscription backlog provides natural **backpressure** during large imports: messages wait until a pod finishes its current job and pulls the next one.

### Subscriber Lifecycle and Acknowledgement

1. **Receive message** — load the job by ID from MongoDB.
2. **Mark PROCESSING** — update the job to `PROCESSING` and set `processingStartedAt` when processing actually begins.
3. **Run recalculation** — full tree rebuild for that root (idempotent).
4. **Persist result** — set status to `FINISHED` or `FAILED` (or `FAILED_PERMANENT`), set `finishedAt` (or the field used by the TTL index) when the job reaches a terminal state so retention applies consistently.
5. **Ack the message** only **after** the job document has been updated successfully.

If the pod crashes **before** ack, the broker redelivers the message to **this or another pod** — the same pattern as any at-least-once consumer. No separate “stale INPROGRESS reset to PENDING” loop is required for delivery failures.

**Ack deadline / visibility timeout** must be set (or extended during work) so it comfortably exceeds the **p99 recalc duration**; otherwise the broker may redeliver while a first attempt is still running.

### Duplicate Delivery

Pub/sub is typically **at-least-once**. Two consumers may briefly process the same job (e.g. redelivery while the first worker is still running, or crash after work completed but before ack). **We accept this:** recalculation must be **idempotent** — running the same tree rebuild twice yields the same data. Occasional duplicate work is an acceptable trade-off for simpler operations.

Optional later optimisation: skip work if the job is already `FINISHED` when the message is handled (ack immediately).

### Memory and Graceful Shutdown

Before starting work on a new message, the pod may consult its **health / memory utilisation** (e.g. skip or nack with backoff if memory is above ~90%) so recalc does not push an already loaded pod toward OOM.

On **graceful shutdown (SIGTERM)**, do **not** ack the current message if processing is incomplete — **nack** or let the ack deadline elapse so the message is redelivered to another subscriber.

### Optional Reconciliation

If desired, a periodic job can find jobs stuck in `PROCESSING` for longer than a business-defined threshold (true poison or stuck workers) and mark them `FAILED` or reset for manual replay. This is not required for basic redelivery semantics.

### Two Update Paths

#### Single Variant Update (Inline)

When a single variant is created or updated via the API, the `variants` map on its ancestors is updated directly and synchronously — no job queue needed. The entire operation requires exactly **one database call** (beyond the product write itself):

1. **Ancestor IDs are already known** from the variant's `parentVariantIdPath` — no lookup query needed.
2. **One `updateMany`** where `_id: { $in: parentVariantIdPath }` sets the variant's entry in each ancestor's `variants` map with its delta attributes. The update filter includes a version check — the write is applied only if the incoming version is newer than the stored version, or if the entry does not yet exist. This ensures idempotency and correct handling of out-of-order events.

Because only delta attributes are stored, a mid-level variant change does **not** cascade to descendant entries — only the changed variant's own entry is written on each ancestor. This makes the write cost **a single `updateMany`**, regardless of tree depth.

If `parentVariantIdPath` is empty or incomplete (parent does not exist yet), the inline update is skipped. The variant is stored, and its ancestors' `variants` maps and paths will be populated when the batch recalculation is triggered after the full import.

#### Batch Recalculation (Job + Pub/Sub)

Used after bulk data imports where many variants may have been created in arbitrary order. The HTTP endpoint creates a **PENDING** job and **publishes** a message; subscribers perform the work as described above.

1. **Fetch all descendants:** A single indexed query: `find({ parentVariantIdPath: rootId })`. This returns every product in the tree.
2. **Rebuild paths:** Compute and update `parentVariantIdPath` for every product in the tree top-down (paths may have been empty/partial if products were created before their parents).
3. **Compute:** In memory, map each variant's delta attributes to the appropriate entries on each ancestor.
4. **Write:** Update the `variants` map on each ancestor level — the root gets the flat map of all descendants (delta attributes only), intermediate levels get their direct children.

### Version Tracking (Future Optimization)

Each entry in the `variants` map stores the version of the source product. During recalculation, entries where the stored version matches the current product version can be skipped. This optimization is deferred to a later phase pending real-world performance data.

## Consequences

### Positive

- Single API call to get all variant data for storefront product pages — accumulated attributes computed at response time
- Delta-only storage eliminates cascading writes — any variant update (leaf or mid-level) touches only one entry per ancestor
- `parentVariantIdPath` eliminates all `$graphLookup` operations — ancestor/descendant resolution is O(1) reads or a single indexed query
- Single variant inline update is a **single `updateMany`** with no preceding lookup — no eventual consistency delay for normal operations
- Batch recalculation is **event-driven** (pub/sub) — no cluster-wide polling of MongoDB for work
- **Natural backpressure** — subscription backlog absorbs spikes; one in-flight job per pod caps load
- **Pod crashes** before ack are handled by **message redelivery**; no bespoke stale-task poller is required for that case
- Terminal jobs remain queryable until **TTL** removes them (~one month), supporting status APIs without manual cleanup jobs
- At most **one active job per root** at the API layer (PENDING/PROCESSING conflict); duplicate message delivery is tolerated via **idempotent** recalc

### Negative

- API must compute accumulated attributes on every read (in-memory merge of up to 100 entries across up to 4 levels — sub-millisecond, but still a computation per request)
- Batch recalculation of a single variant triggers a full tree rebuild (acceptable since it is only used after bulk imports)
- Variant data on the root is eventually consistent only during bulk imports — there is a delay between ingestion and the `variants` map being up to date
- Full catalog syncs can grow the pub/sub backlog; customers should be guided to call recalc only after the full batch, not per product
- **Dependency on pub/sub** for starting work — if publishing fails, jobs may stay PENDING until retry or reconciliation
- **At-least-once** delivery may cause **duplicate** processing of the same job; mitigated by idempotent writes, not by strict single execution

### Risks

- Full nightly catalog syncs could enqueue thousands of messages; monitor subscription backlog depth and consumer lag
- **Ack deadline** shorter than slow recalcs causes unnecessary redelivery and duplicate work — tune deadline or use deadline extension during processing
- TTL applies only to documents with `finishedAt`; ensure terminal states set that field so retention and expiry behave as intended
