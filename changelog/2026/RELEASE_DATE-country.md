---
icon: sliders
layout:
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: false
  pagination:
    visible: true
---

# RELEASE_DATE: Country Service - X-Version header no longer required

## Overview

The `X-Version` header is no longer required for Country Service endpoints.

## Updated endpoints

| Endpoint                                                                                                                                                                      | Description                                              |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| [Retrieving all countries](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#get-country-tenant-countries)         | The `X-Version` header is no longer required.            |
| [Retrieving a country](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#get-country-tenant-countries-countrycode) | The `X-Version` header is no longer required.            |
| [Updating a country](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/countries#patch-country-tenant-countries-countrycode) | The `X-Version` header is no longer required.            |
| [Get all regions](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/regions#get-country-tenant-regions)                      | The `X-Version` header is no longer required.            |
| [Retrieving a region](https://developer.emporix.io/api-references/api-guides/configuration/country-service/api-reference/regions#get-country-tenant-regions-regioncode)       | The `X-Version` header is no longer required.            |

## Known problems

There are no known problems.
