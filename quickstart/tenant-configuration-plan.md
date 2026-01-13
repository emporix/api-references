# Tenant Configuration for Checkout - Tutorial Plan and Outline

## Overview

This tutorial will guide users through configuring a fresh Emporix tenant to enable checkout functionality in the storefront. The tutorial is designed to be run on a brand new tenant, and after completion, the Emporix Showcase checkout should work successfully.

## Target Audience

- Developers setting up a new Emporix tenant
- Teams preparing a tenant for storefront integration
- Users who need a complete, step-by-step guide for tenant configuration

## Tutorial Structure

The tutorial is organized into three main parts:

1. **Configuration** - Basic tenant and site settings
2. **Data Import** - Catalog, products, and pricing setup
3. **Customer Setup** - Test customer and address configuration

---

## Part 1: Configuration

### 1.1 Prerequisites
- **Objective**: Ensure users have what they need before starting
- **Content**:
  - Emporix tenant created
  - API credentials (OAuth 2.0 client credentials or access token)
  - Basic understanding of REST APIs
  - Tools for making API calls (curl, Postman, etc.)

### 1.2 Site Configuration
- **Objective**: Create and configure a site (virtual store entity)
- **Steps**:
  1. Create a new site
     - Site code, name, default language
     - Currency configuration
     - Home base address (required for shipping calculations)
  2. Configure site languages
  3. Configure site currency
  4. Set ship-to countries
  5. Configure site home base address (critical for shipping)

### 1.3 Currency Configuration
- **Objective**: Set up currencies for the tenant and site
- **Steps**:
  1. Configure tenant-level currencies
  2. Verify site currency matches tenant configuration
  3. Ensure currency codes are ISO 4217 compliant

### 1.4 Country Configuration
- **Objective**: Configure countries for business operations
- **Steps**:
  1. Set tenant-level country configuration
  2. Configure site home base country
  3. Ensure country codes are ISO 3166-1 alpha-2 compliant

### 1.5 Tax Configuration
- **Objective**: Set up tax rules for checkout calculations
- **Steps**:
  1. Create tax configuration for target country
  2. Define tax classes (e.g., STANDARD, REDUCED, ZERO)
  3. Set tax rates for each class
  4. Mark default tax class

### 1.6 Shipping Configuration
- **Objective**: Configure delivery zones, methods, and times
- **Steps**:
  1. Create shipping zone
     - Define ship-to locations (country, postal codes)
     - Set as default zone if needed
  2. Create shipping method
     - Link to shipping zone
     - Configure fees (absolute or percentage-based)
     - Set order value thresholds
  3. Create delivery time (optional but recommended)
     - Link to shipping zone and method
     - Configure delivery windows and slots

### 1.7 Payment Methods Configuration
- **Objective**: Enable payment methods for the site
- **Steps**:
  1. Check existing orderProcessSettings mixin
  2. Enable payment methods (Invoice, Credit Card, Direct Debit, Cash)
  3. Configure payment gateway settings (if applicable)

---

## Part 2: Data Import

### 2.1 Catalog Setup
- **Objective**: Create a catalog to organize products
- **Steps**:
  1. Create a catalog
  2. Configure catalog settings
  3. Link catalog to site

### 2.2 Category Tree Setup
- **Objective**: Organize products into categories
- **Steps**:
  1. Create category tree
  2. Create root category
  3. Create subcategories (if needed)
  4. Link category tree to catalog

### 2.3 Product Import
- **Objective**: Add products to the catalog
- **Steps**:
  1. Create products (single or bulk)
     - Product ID, code, name
     - Product type (BASIC, VARIANT, etc.)
  2. Assign products to categories
  3. Verify products are available in catalog

### 2.4 Price Model Configuration
- **Objective**: Define pricing strategy
- **Steps**:
  1. Create price model
     - Define tier structure (BASIC, QUANTITY, etc.)
     - Set measurement unit
     - Configure includesTax setting
  2. Understand price model structure

### 2.5 Price Configuration
- **Objective**: Set prices for products
- **Steps**:
  1. Create prices for products
     - Link to price model
     - Set currency and location (country)
     - Configure tier values
     - Set site restrictions
  2. Verify price matching works

---

## Part 3: Customer Setup

### 3.1 Customer Creation
- **Objective**: Create a test customer for checkout
- **Steps**:
  1. Create a customer account
     - Basic information (name, email, etc.)
     - Set password
  2. Verify customer creation

### 3.2 Customer Address Configuration
- **Objective**: Add shipping and billing addresses
- **Steps**:
  1. Add shipping address
     - Full address details
     - Country, postal code, city
  2. Add billing address
     - Can be same as shipping or different
  3. Set default addresses

### 3.3 Customer Authentication Setup
- **Objective**: Prepare for customer login in storefront
- **Steps**:
  1. Understand anonymous session flow
  2. Understand customer login flow
  3. Note: Customer login is optional for guest checkout

---

## Verification and Testing

### Final Verification Steps
- **Objective**: Ensure all configuration is correct
- **Checklist**:
  - [ ] Site is created and active
  - [ ] Currency and country are configured
  - [ ] Tax configuration exists for target country
  - [ ] Shipping zone and method are configured
  - [ ] Payment methods are enabled
  - [ ] At least one product exists with price
  - [ ] Test customer exists with address
  - [ ] Catalog and categories are set up

### Testing Checkout Flow
- **Objective**: Verify checkout works end-to-end
- **Steps**:
  1. Create anonymous session
  2. Create cart
  3. Add product to cart
  4. Verify cart calculations (price, tax, shipping)
  5. Proceed to checkout (as guest or logged-in customer)
  6. Verify order creation

---

## Additional Considerations

### Optional but Recommended
- Delivery times configuration (for scheduled deliveries)
- Multiple shipping methods (for different delivery options)
- Multiple payment methods (for customer choice)
- Product images and media
- Brand and label setup

### Terraform Alternative
- **Note**: Configuration steps can be automated using the Emporix Terraform Provider
- Reference to Terraform documentation for infrastructure-as-code approach

### Common Pitfalls
- Missing home base address (breaks shipping calculations)
- Currency mismatch between tenant and site
- Tax configuration missing for target country
- Shipping zone not matching customer address
- Products without prices
- Site not linked to catalog

---

## Tutorial Format

Each section will follow this structure:
- **Introduction**: Brief explanation of what this section covers and why it's needed
- **Prerequisites**: What needs to be done before this step
- **Step-by-step instructions**: Using GitBook stepper components
- **Code examples**: curl commands with placeholders
- **Verification**: How to verify the step was successful
- **Troubleshooting**: Common issues and solutions
- **Links**: References to detailed API documentation

---

## Estimated Completion Time

- Part 1 (Configuration): 30-45 minutes
- Part 2 (Data Import): 20-30 minutes
- Part 3 (Customer Setup): 10-15 minutes
- **Total**: ~60-90 minutes for complete setup

---

## Next Steps After Tutorial

After completing this tutorial, users should be able to:
1. Understand the minimum configuration needed for checkout
2. Successfully complete a checkout in Emporix Showcase
3. Extend configuration for their specific business needs
4. Reference detailed API documentation for advanced scenarios

---

## Related Documentation

- [Checkout Tutorial](../checkout/checkout/checkout.md) - Detailed checkout flow
- [Emporix Terraform Provider](./emporix-terraform-provider.md) - Infrastructure as Code approach
- [Site Settings API Reference](../configuration/site-settings-service/api-reference/)
- [Tax Service API Reference](../prices-and-taxes/tax-service/api-reference/)
- [Shipping API Reference](../delivery-and-shipping/shipping/api-reference/)
