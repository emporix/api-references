---
seo:
  title: Upsert
  description: upsert general setup
icon: arrow-turn-up
layout:
  width: wide
description: Upsert in Emporix simplifies entity management by allowing a PUT request to either create a new record if it doesn’t exist or update it if it does.
---

# Upsert

`UPSERT` is a database operation that combines `update` and `insert`. It allows a single command to either insert a new record if it doesn’t exist in the database or update an existing record if it does. This is particularly useful in databases where you may want to avoid checking if a record exists before deciding to insert or update it.

When you perform an upsert:

* If the record exists (often determined by a unique key like an ID), the operation updates the record's values with the provided data.
* If the record does not exist, it inserts a new record with the provided data.

## Upsert at Emporix

Typically, a call is required to check if an entity exists before making a `POST` or `PUT` request.\
However, at Emporix, where the PUT request supports upsert operation and custom IDs, this process is simplified:

* If an entity does not exist, it is created.
* If the entity exist, it is updated.

The API response returns an HTTP status of 201 when an entity is created and 204 when it is updated, eliminating the need for the integration layer to check for an entity's existence beforehand.

{% hint style="warning" %}
Upsert is available for some services only.\
When a service supports the upsert operation, its endpoints are named to reflect this functionality, for example, "Upserting a product".
{% endhint %}
