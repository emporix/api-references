---
description: Look through the glossary of Emporix terms.
icon: spell-check
---

# Glossary

## access control

A combination of user's roles and resources determining what a user can do on a particular entity.

## add-on

An add-on, or plugin, is a software component that adds a specific feature or functionality to the Emporix platform. An add-on is usually more focused and contained within the external host application to extend the capabilities without altering its fundamental structure. Usually, it's pre-built and ready to use with minimal setup but can allow some customization or configuration. For example, there are a few Emporix add-ons dedicated to external CMSs or support systems.

## agentic AI

A functionality delivered within Emporix platform that introduces AI-powered agents that automate ecommerce workflows. These agents react to system events and execute tasks automatically, reducing manual work. Agentic AI comes with the predefined agents library (for example, Complaint, Anti‑Fraud, or Support) but also allows you to build custom agents with the chosen LLM, tools, and MCP capabilities.

## AI agent

An automated assistant, fueled by AI LLM capabilities, that executes ecommerce tasks and workflows. In Emporix, agents react to system events or API triggers and carry out actions to reduce manual effort. You can use predefined agents for common needs, or build custom ones by choosing the LLM, attaching tools, and enabling MCP capabilities.

## AI agent library

A catalog of ready-to-use Emporix AI agents for common ecommerce tasks. The library includes predefined agents like Complaint, Anti‑Fraud, Support, and Translation Agent. These agents run in the background and integrate into workflows to handle complaints, flag fraud, assist in communication, and more. You enable one by selecting it from the library, adding relevant configuration, and then activating it from "My agents" view.

## AI MCP server

AI MCP lets Emporix agents and MCP clients connect to tools through MCP servers. Emporix includes built-in (predefined) MCP servers for common ecommerce operations. You can also add tenant-managed servers in **AI MCP**: custom MCP servers so agents can talk to ERPs, CRMs, or other external endpoints, and dynamic MCP servers whose tools call hosted Cloud Functions. An AI MCP server allows agents to call the MCP tools it exposes.

See also [dynamic MCP server](glossary.md#dynamic-mcp-server).

## AI token

A securely stored secret used to connect Emporix AI to external services. You create and manage tokens centrally, then reference them in agents, custom MCP servers, or LLM providers. Tokens secrets are encrypted and immutable after saving, never returned by APIs.

## AI tool

An AI tool extends an agent by connecting it to third‑party platforms for actions or data. In Emporix, tools let agents operate inside external systems. Supported native AI tools include Slack, MS Teams, and RAG. The Slack tool installs the Emporix Support Agent bot in the chosen Slack workspace, so that teams can make queries about Emporix events directly in Slack. The MS Teams tool enables AI agents to collaborate with users in Microsoft Teams.

## AI logs

A dashboard view that lets you monitor and control everything related to AI Agents enabled in your tenant. AI logs provide visual tools to measure agent efficiency, track session handling, and analyze errors. The logs are grouped into requests, jobs, and sessions, with each entry marked with a severity level (info, warning, or error). You can use AI logs to inspect agent behavior, troubleshoot issues, and iterate on your agents with confidence.

## API

An API, or Application Programming Interface, is a set of rules, protocols and tools that allow different software applications and systems to communicate and interact with each other. Emporix services expose public REST API that enable communication with external systems and allow you to easily manage your business resources.

## authentication

A process of verifying the identity of a user, system, or entity to ensure that they are who or what they claim to be. It's a first-line defense mechanism before granting access to a system or application.

## authorization

A process of determining and granting permissions and access controls for a user to perform specific actions or access particular resources. Authorization enhances security of the application by restricting access and ensuring that actions are performed by users with the appropriate level of permission.

## calculationType

An attribute of the `totalDiscount` parameter. It indicates whether discounts were applied to net or gross values.\
The discount is applied to either `price.grossValue`, when `includesTax=true`, or `price.netValue`, when `includesTax=false`. Based on this, the corresponding net or gross value is recalculated using the tax rate.\
The calculation method used is indicated in `totalDiscount.calculationType`, which can be either `ApplyDiscountAfterTax` or `ApplyDiscountBeforeTax`.

## CE

Commerce Engine is a MACH digital commerce platform combining B2B and B2C features that provides end-to-end commerce solution. Previously, it was known as Digital Commerce Platform.

## Commerce Engine

See the [CE](glossary.md#ce).

## Commerce Orchestration Platform

Emporix solution that enables you to digitalize your sales end-to-end. It embraces Commerce Engine and Orchestration Engine that together can help you revolutionize the ways you sell your goods and operate more efficiently within your company.

## data retention policy

Standard practice of storing and maintaining data for a specified period to meet legal, regulatory, business, or other requirements. The policy takes into account factors such as purpose, compliance, and security. The data retention in Emporix refers to data collected by value streams.

## discountedPrice

The attribute used to calculate a relevant price on an item level or on a cart level.

On an item level, it's the price of the line item calculated as unit price multiplied by quantity, with any applied discounts.\
The attribute is included in the cart response if a discount is applied to at least one line item.\
Depending on the tax configuration for a site, it can be either net or gross.\
The calculation method that was used is indicated in `totalDiscount.calculationType`, which can be either `ApplyDiscountAfterTax` or `ApplyDiscountBeforeTax`.

On a cart level, it's the sum of all line item prices after discounts. This attribute is included in the cart response if at least one line item has a discounted price. It represents the total of discounted prices for line items with discounts applied, or the regular prices for line items without discounts. Ultimately, it reflects the total cost of all line items after discounts.

## domain

A unique name that identifies your website or online store.

## dynamic MCP server

A tenant-managed MCP server whose tools are a persisted catalog backed by Emporix Cloud Functions. You configure it in **AI MCP**, then attach it to an agent. Emporix Hosting is a prerequisite. Disabled tools stay stored; runtime exposes enabled tools only, and an agent can optionally allow a subset by name. Emporix also hosts a Streamable HTTP endpoint so external MCP clients can connect the same way as for predefined domain servers.

## effectiveValue

The result of the price matching calculations for a product or SKU item, included in an order. The value includes discounts if any apply. The value is a gross or net price depending on the `includesTax` setting value. See also [originalValue](glossary.md#originalvalue).

## employee group

An aggregation of tenant employees that share the same access control within a particular service and resource. By assigning an employee to a particular group, you grant them access to a specific access control level.

## event log

A record of an important action or incident in a system or network, for example, an error or a user activity, in relation to a value stream. You can check the event logs in the Value Stream Modeller under **Events -> Event Log**.

## event registry

A list of all events configured in a tenant as triggers for the value streams. The Event Registry is available in the Value Stream Modeller under **Events -> Event Registry**.

## extension

A custom module that contains custom logic and functionality that you can build separately and embed to the Management Dashboard. An extension has to contain the appropriate dependency to the Management Dashboard to be able to read contextual information.

## finalPrice

The final price calculation on an item level or on a cart level.

On an item level, it's the sum of the `discountedPrice` or the original price, depending on whether any discounts were applied to the line item, and the `totalFee`, which includes all fees applied to the line item.

On a cart level, it means the sum of all the items' final prices, total shipping cost and fees included in the cart.

## IAM

Identity and Access Management (IAM) Service is responsible for granting access rights and permissions for different groups and users in the Emporix system.

## includesTax

The setting defined at the site or price model level. It is used in the price matching algorithm by the Price Service to calculate product prices. The setting determines if the algorithm returns net or gross prices.

## integration

Integration involves connecting two or more systems, applications, or services so that they can work together and exchange data between each other. For example, you can integrate a payment gateway system or CRM software. Implementation can involve APIs, middleware, or webhooks to enable communication.

## legal entity

A distinct legal entity in the Emporix system that represents a company or subsidiary with associated legal information, such as legal name, registration details, tax registration number, and country of registration. Legal entities can be of type COMPANY or SUBSIDIARY, where subsidiaries can be linked to a parent company. Each legal entity can have multiple addresses, customer groups, approval groups, and account limits associated with it.

## MCP tools

Operations that MCP servers expose so AI agents and MCP clients can invoke commerce or custom logic over the Streamable HTTP protocol.

In Emporix, you can use:

* Tools from predefined (Emporix-hosted) domain MCP servers: product, order, customer, extensibility, and frontend. A tool is available only when the MCP token includes the required scopes. Examples: `get-product`, `upsert-product`, `get-order`, `create-return`, `upsert-customer`.
* Tools from custom MCP servers. The tool set depends on the external provider and your setup.
* Tools from a [dynamic MCP server](glossary.md#dynamic-mcp-server). Each tool calls a Cloud Function hosted in Emporix. Runtime exposes enabled tools only. Agents can attach a subset by name; external MCP clients can limit tools with `?tools=` on the connection URL.

## mixin

Mixins are custom attributes that you can add to the Emporix system to extend the data model of different entities, such as, for example, products, catalogs, or customers. Mixins functionality supports creating a custom fields schema that validates if the associated data is correct.

## Microsoft Entra ID Access

A capability that lets enterprise customers use Microsoft Entra ID as the central source for employee login, group membership, and tenant access in Emporix. Employees sign in with their corporate Microsoft account. Emporix maps Entra ID groups to IAM groups and a Developer Portal role at login through the `entraid_mapping` tenant configuration.

## OAuth

OAuth (Open Authorization) is an open-standard framework for granting user's or third-party application access to the application without exposing their credentials. OAuth uses authorization tokens to grant relevant limited access based on user's permissions. OAuth Service in the Emporix system allows you to generate the following token types: anonymous, SaaS (customer), and service access tokens. Anonymous token is used on a storefront to access public resources with a read scope to allow customers to browse products with prices, and add products to cart. SaaS token works similarly, but it's associated with a specific customer when they log in. The Service access token is required to access the Emporix services to manage and manipulate data, such as products, categories, prices, and others.

## OE

Orchestration Engine is the application that allows you to digitalize and optimize the company's processes and workflows. OE introduces real-time, end-to-end process intelligence to enable creation of value streams that orchestrate people and systems across your business, and even outside of it.\
Previously, it was known as Commerce Execution Platform.

## Orchestration Engine

See the [OE](glossary.md#oe).

## originalValue

The original base or default value of a product or SKU item included in an order. The originalValue is taken into account in the [price matching](glossary.md#price-matching) calculation. The value is a gross or net price depending on the `includesTax` setting value. See also [effectiveValue](glossary.md#effectivevalue).

## permission

A mechanism for controlling and limiting what actions a user can perform on specified resources.

## Pick-Pack (deprecated)

The Pick-Pack service facilitates management of picking and packing processes in-store and in a warehouse.

## predefined AI agent

An AI agent delivered by Emporix within the AI Agent Library. It's a ready-to-use AI-powered automation solution that you need to only configure and enable in your tenant.

## price

A unit price assigned to a product at price matching operation. It's multiplied by the item quantity.

At cart level, the term means a sum of all line item prices without discounts.

## price matching

A price matching algorithm that finds the best price for products based on specified criteria such as site, currency, location, customer, and quantity. The algorithm fetches all matching prices, calculates a unified original value for each, and returns the price with the lowest effective value. Price matching can handle currency conversion using exchange rates, location-based pricing using tax classes, and can return prices as gross or net values based on the site or price model settings.

## price searching

The functionality of querying and retrieving prices from the Price Service API based on various filtering criteria such as product, site, currency, location, customer, customer group, date range, and price list. Price searching allows you to find and retrieve specific prices that match your business requirements, enabling efficient price management and retrieval for products across different contexts and configurations.

## restriction

The `restriction` property serves as the tool of access control to limit the visibility of restriction-aware (or site-aware) entities for different user groups. By default, restriction is associated with site permissions separation, by reading the associated `siteCode`. However, the restrictions can be extended by defining the custom restriction values. Restrictions affect the following entities: company (legal entity), customer, cart, order, and quote. See also [site permissions](glossary.md#site-permissions).

## rulestore

A place where you can define, configure, and store business rules that you can use in a value stream as a filter logic for a step or a scenario. For example, a rule that allows approving product return requests only for damaged products, based on the return reasons. The rulestore keeps the rules so that you can easily reuse them in multiple value streams. The rules remain inactive until they are referenced by a specific process.

## schema

Schema Service allows you to manage and validate mixin fields for different entities.

## scope

A constraint or filter applied to API endpoints to determine what a user can do with a service.

## service

An independent, self-contained unit that is responsible for a specific function and communicates with other services through APIs. Emporix uses microservices architecture.

## site

A site represents a specific shop, warehouse or another independent facility. You can have multiple sites depending on the specific business needs. For example, if you have multiple locations and have to handle different delivery areas for each location, the taxes vary between locations, or there are different delivery options available.

## site-aware

The ability of the system, application or a process to recognize and adapt to the specific site-related configurations or characteristics. In Emporix, there are the following site-aware resources: carts, delivery methods, delivery times, delivery zones, fees, orders, payment methods, pickup points, product availabilities, product locations, promotions, stock levels, prices, tax rates, and shipping.

## site code

A unique identifier of a site for your online store. For example, it can be associated with a country where you operate. You define the site code in the **Settings -> Sites** in the Management Dashboard.

## site permissions

Site permissions extend the existing permission management framework, to more precisely and granularly control access rights for user groups. They allow to define access rights per site (or store) not just globally, and therefore separate responsibilities across multiple sites, markets, or brands to reduce the risk of unauthorized changes. Site permissions affect the following site-aware entities: company (legal entity), customer, cart, order, and quote.

## subsidiary

A type of legal entity that represents a subsidiary company linked to a parent vendor or company entity. Subsidiaries enable hierarchical management for vendors operating multiple legal entities, allowing them to organize and manage related companies under a main entity while maintaining separate legal information and registration details for each subsidiary.

## Svix

Svix is the third-party webhook service provider supported in Emporix platform. You can use shared limited account or connect your own Svix licence to manage webhooks on the events taking place in the system, or use an alternative solution.

## targetCurrency

The parameter used by the Price Service in price matching operation. The `targetCurrency` means the code of the currency in which the prices should be matched, as defined in the Currency Service. If the matched price is defined in another currency, the service uses the currency exchange algorithm, but only if exchange rates between the two currencies have been defined beforehand.

## taxAggregate

A list of tax values grouped by `taxCode` and `taxRate`.\
It includes the sum of the following calculations:

* `item[].calculatedPrice.discountedPrice` or `item[].calculatedPrice.price`,
* `item[].calculatedPrice.fees[].discountedPrice` or `item[].calculatedPrice.fees[].price`,
* `calculatedPrice.totalShipping`
* `calculatedPrice.paymentFees`

## tenant

An instance of Emporix Commerce Orchestration Platform that is made available for a particular company or organization as Emporix is a multi-tenant SaaS solution. Each tenant has a separate and isolated access to the data, configuration and other resources, and can be managed individually, as if it was running on its own. Even though, all the Emporix tenants share the same hardware and software infrastructure.

## totalValue

A total value of all the units of a product or SKU item included in an order, based on the item's `effectiveValue` price, that is, including a discount if applicable.

## totalDiscount

The cart attribute indicating the calculated discounts on an item level and on a cart level.

On an item level, it means a summary of all discounts applied to the line, including discounts on both the line item's price and its fees.

On a cart level, it means a sum of all applied lines discounts and shipping discounts.

## totalFee

Sum of all fees applied to the line item.\
It's calculated by summarizing all the fees and any discounts applied to the fees.

## totalShipping

The calculated shipping cost of the cart items.

## upliftValue

An additional amount authorized for payment to cover potential price adjustments during packing of weight-based products.\
There are two conditions to have this value for an item line in a cart:

* The item is added to the cart with the `weightDependent":true` attribute. It means that the quantity may vary during packaging, as some items, for example a case of bananas, cannot be divided to precisely match a given weight.
* The site has the percentage uplift defined - `authorizedAmountUplift`, for example 0,1=10%. If the item `price.netValue=12`, the `upliftValue.netValue=1,2` with the 10% uplift configured.

## user group

A group of users who share some common characteristics, like performing a similar job. A user group defines access controls for the users assigned to it.

## value stream

A configurable, automated process designed to work for your organization. You define a trigger that launches the process in response to events in the system, and the process then executes a sequence of steps that may call out to different systems or services. Value streams are designed to ensure that key business outcomes (for example, new customer onboarding, order fulfillment) are delivered in a consistent, efficient, and traceable way. Process steps can include scenarios, subflows (other value streams), or AI agents.

## value stream library

A collection of pre-built templates that serve as a foundation for creating automated processes. These templates provide complete end-to-end process flows that you can customize by configuring your connections and adjusting them to fit your specific business needs.

## value stream modeller

A tool within the Commerce Orchestration that enables you to define and monitor value streams that react to business events in real time. It provides a visual interface for creating processes composed of triggers and sequential steps that execute to achieve specific business outcomes.

## value stream trigger

An element that initiates a value stream by starting a new process instance or resuming a previously paused one. Triggers can be commerce events (CE events), custom events configured for your tenant, or timer events that schedule process execution at specific times or intervals.

## vendor

A supplier that operates as an independent entity within the Emporix platform. Vendors can securely access and manage their own products, orders, and analytics without visibility into other vendors data. Each vendor is represented as a distinct legal entity in the system and can have multiple locations and users associated with their account.

## vendor group

A set of user groups automatically created when a vendor is created. Four vendor groups are created for each vendor: product manager, product viewer, order manager, and order viewer. Each group has specific access rights configured automatically, allowing vendors to manage their products and orders with appropriate permissions.

## webhook

A webhook is a user-defined callback mechanism that allows an application to send real-time data to another application when a specific event occurs. Applications or services can communicate with each other automatically when a certain action or event takes place in a system and send data to a specified URL endpoint. You can use webhooks for smooth API communication, automation of workflows, and notifications.

## weight-dependency

A product is designated as weight-dependent when its final sale price is calculated based on its actual weight after packaging. This designation is crucial for accurate payment authorization, as the initially estimated price may differ from the final price.
