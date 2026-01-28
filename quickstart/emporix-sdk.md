---
description: A comprehensive Java SDK for integrating with Emporix Commerce APIs. Built for Spring Boot applications with powerful authentication management, type-safe API clients, and convenient token handling.
icon: code
layout:
  width: wide
---

# Emporix SDK

A comprehensive Java SDK for integrating with Emporix Commerce APIs. Built for Spring Boot applications with powerful authentication management, type-safe API clients, and convenient token handling.

The Emporix SDK provides:

- **Type-safe API clients** for all Emporix services
- **Automatic Spring Boot configuration** via `@EnableEmporixAutoConfiguration`
- **Comprehensive token management** with `EmporixTokenService`
- **Automatic token caching** and refresh for service tokens
- **Exception handling** with Emporix error response parsing
- **Multi-credential support** for multi-tenant scenarios

### Prerequisites

Before you begin, ensure you have the following installed and configured:

- **Java 21** or higher
- **Spring Boot 3.x**
- **Gradle 8.5+** or **Maven 3.9+**

## Quick Start

Get up and running in 5 minutes!

### Step 1: Add Dependency

**Gradle:**

```gradle
dependencies {
    implementation 'io.emporix:emporix-sdk:1.0.0'
}
```

**Maven:**

```xml

<dependency>
  <groupId>io.emporix</groupId>
  <artifactId>emporix-sdk</artifactId>
  <version>1.0.0</version>
</dependency>
```

### Step 2: Enable SDK

Add the annotation to your Spring Boot application:

```java
import io.emporix.config.EnableEmporixAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableEmporixAutoConfiguration  // ← Add this
public class MyApplication {

  public static void main(String[] args) {
    SpringApplication.run(MyApplication.class, args);
  }
}
```

### Step 3: Configure Credentials

**Use environment variables (recommended):**

```bash
export EMPORIX_TENANT=your-tenant-id
export EMPORIX_API_CREDENTIALS_BACKEND_CLIENT_ID=your-backend-client-id
export EMPORIX_API_CREDENTIALS_BACKEND_SECRET=your-backend-secret
export EMPORIX_API_CREDENTIALS_STOREFRONT_CLIENT_ID=your-storefront-client-id
export EMPORIX_API_CREDENTIALS_STOREFRONT_SECRET=your-storefront-secret
```

**Alternatively, use application.yml:**

```yaml
emporix:
  tenant: your-tenant-id
  api:
    credentials:
      backend:
        client-id: your-backend-client-id
        secret: your-backend-secret
      storefront:
        client-id: your-storefront-client-id
        secret: your-storefront-secret
```

### Step 4: Use the SDK

```java
import io.emporix.auth.service.EmporixTokenService;
import io.emporix.auth.dto.ServiceTokenResponse;
import io.emporix.product.ProductClient;
import io.emporix.product.dto.response.ProductResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductService {

  @Autowired
  private ProductClient productClient;

  @Autowired
  private EmporixTokenService tokenService;

  public List<ProductResponse> getAllProducts() {
    // 1. Get service token (with all available scopes)
    ServiceTokenResponse token = tokenService.getServiceToken();

    // 2. Get Bearer token (null-safe and idempotent)
    String authorization = token.bearerAccessToken();

    // 3. Call client with authorization
    return productClient.getProducts(
        null, null, null, 1, 20, "name:asc", true, "en", authorization
    ).getBody();
  }
}
```

That's it! You're ready to use the SDK.

## Configuration

### Configuration Properties

The SDK is configured through `application.yml`, `application.properties`, or environment variables.

#### Complete Configuration Example

```yaml
emporix:
  # ========================================
  # REQUIRED PROPERTIES
  # ========================================

  # Your Emporix tenant name
  tenant: your-tenant-name

  api:
    # API host (defaults to https://api.emporix.io)
    host: https://api.emporix.io

    credentials:
      # Backend credentials (for server-side operations)
      backend:
        client-id: your-backend-client-id
        secret: your-backend-secret

      # Storefront credentials (for customer/anonymous tokens)
      storefront:
        client-id: your-storefront-client-id
        secret: your-storefront-secret

      # ========================================
      # OPTIONAL: Custom Credentials
      # ========================================
      # Custom credentials are OAuth2 clients with specific scopes
      # Use them for integrations, partners, or external systems with limited permissions
      custom:
        integration:
          client-id: integration-client-id
          secret: integration-secret
        partner:
          client-id: partner-client-id
          secret: partner-secret

    # ========================================
    # OPTIONAL: HTTP Client Timeouts
    # ========================================
    timeouts:
      connect-timeout-ms: 10000              # Connection timeout: 10 seconds (default)
      read-timeout-ms: 60000                  # Read timeout: 60 seconds (default)
      connection-request-timeout-ms: 5000    # Connection request timeout: 5 seconds (default)

  # ========================================
  # OPTIONAL: Token Cache Configuration
  # ========================================
  cache:
    enabled: true                        # Enable/disable token caching (default: true)
    max-size: 1000                       # Maximum number of tokens to cache (default: 1000)
    expiration-buffer-seconds: 60        # Seconds before actual expiration to consider token expired (default: 60)
    service-token-max-age-seconds: 60    # Maximum age for service tokens from cache (default: 60, 0 to disable)
    max-lifetime-seconds: 3600           # Maximum lifetime for any cached token (default: 3600 = 1 hour)

  # ========================================
  # OPTIONAL: Exception Handler
  # ========================================
  exception-handler:
    enabled: true  # Enable global exception handling
```

#### Property Details

| Property                                       | Required | Default                  | Description                                                                        |
|------------------------------------------------|----------|--------------------------|------------------------------------------------------------------------------------|
| `emporix.tenant`                               | Yes    | -                        | Your Emporix tenant name. All API requests are scoped to this tenant.              |
| `emporix.api.host`                             | No       | `https://api.emporix.io` | Base URL for Emporix API.                                                          |
| `emporix.api.credentials.backend.client-id`    | Yes    | -                        | OAuth2 client ID for backend operations (service tokens).                          |
| `emporix.api.credentials.backend.secret`       | Yes    | -                        | OAuth2 client secret for backend operations.                                       |
| `emporix.api.credentials.storefront.client-id` | Yes    | -                        | OAuth2 client ID for storefront operations (customer/anonymous tokens).            |
| `emporix.api.credentials.storefront.secret`    | Yes    | -                        | OAuth2 client secret for storefront operations.                                    |
| `emporix.api.credentials.custom.*`             | No       | -                        | Additional custom credential sets for integration scenarios.                       |
| `emporix.api.timeouts.connect-timeout-ms`      | No       | `10000`                  | Connection timeout in milliseconds (time to establish connection).                 |
| `emporix.api.timeouts.read-timeout-ms`         | No       | `60000`                  | Read timeout in milliseconds (time to wait for response data).                     |
| `emporix.api.timeouts.connection-request-timeout-ms` | No | `5000`                   | Connection request timeout in milliseconds (time to wait for connection from pool). |
| `emporix.cache.enabled`                        | No       | `true`                   | Enable/disable token caching using Caffeine.                                       |
| `emporix.cache.max-size`                       | No       | `1000`                   | Maximum number of tokens to cache.                                                 |
| `emporix.cache.expiration-buffer-seconds`      | No       | `60`                     | Seconds before expiration to consider token expired (safety buffer).               |
| `emporix.cache.service-token-max-age-seconds`  | No       | `60`                     | Maximum age for cached service tokens in seconds.                    |
| `emporix.cache.max-lifetime-seconds`           | No       | `3600`                   | Maximum lifetime for any cached token in seconds (Caffeine expireAfterWrite).      |
| `emporix.exception-handler.enabled`            | No       | `false`                  | Enable automatic exception handling for Emporix API errors.                        |

{% hint style="info" %}
The SDK supports both **kebab-case** (e.g., `client-id`, `connect-timeout-ms`) and **camelCase** (e.g., `clientId`, `connectTimeoutMs`) property names for backward compatibility. Kebab-case is recommended for YAML files.
{% endhint %}

#### Environment Variables

All properties can be set via environment variables (recommended for production):

```bash
# Required
export EMPORIX_TENANT=your-tenant-id
export EMPORIX_API_HOST=https://api.emporix.io
export EMPORIX_API_CREDENTIALS_BACKEND_CLIENT_ID=backend-client-id
export EMPORIX_API_CREDENTIALS_BACKEND_SECRET=backend-secret
export EMPORIX_API_CREDENTIALS_STOREFRONT_CLIENT_ID=storefront-client-id
export EMPORIX_API_CREDENTIALS_STOREFRONT_SECRET=storefront-secret

# Optional: Custom credentials (for integrations with specific scopes)
export EMPORIX_API_CREDENTIALS_CUSTOM_INTEGRATION_CLIENT_ID=integration-client-id
export EMPORIX_API_CREDENTIALS_CUSTOM_INTEGRATION_SECRET=integration-secret

# Optional: Exception handler
export EMPORIX_EXCEPTION_HANDLER_ENABLED=true
```

{% hint style="info" %}
Environment variables take precedence over `application.yml` values.
{% endhint %}

## Enabling the SDK

The SDK provides two usage modes:

### 1. DTOs Only (No Configuration)

Simply add the SDK as a dependency to use the data transfer objects (DTOs). No additional configuration needed.

### 2. Full SDK with Auto-Configuration

To enable API clients and authentication services, add the annotation:

```java
import io.emporix.config.EnableEmporixAutoConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableEmporixAutoConfiguration  // ← Enables the SDK
public class MyApplication {
    public static void main(String[] args) {
        SpringApplication.run(MyApplication.class, args);
    }
}
```

This automatically configures:

- All API clients (ProductClient, CategoryClient, PriceClient, etc.)
- Token management (EmporixTokenService)
- Token caching with automatic refresh
- Exception handling (EmporixErrorHandler)
- All required Spring beans

**Without this annotation**, only DTOs are available. Clients will not be auto-configured.

## Available Services

The SDK provides type-safe clients for the following Emporix services:

### Product & Catalog

| Service              | Client                  | Description                      | Key Operations                           |
|----------------------|-------------------------|----------------------------------|------------------------------------------|
| **Product**          | `ProductClient`         | Product management               | CRUD, bulk operations, search, filtering |
| **Product Template** | `ProductTemplateClient` | Product templates                | Manage product templates                 |
| **Brand**            | `BrandClient`           | Brand management                 | CRUD for brands                          |
| **Catalog**          | `CatalogClient`         | Catalog management               | Manage catalogs                          |

### Category

| Service                 | Client                     | Description            | Key Operations                |
|-------------------------|----------------------------|------------------------|-------------------------------|
| **Category**            | `CategoryClient`           | Category hierarchy     | Create, update, manage hierarchy |
| **Category Assignment** | `CategoryAssignmentClient` | Product-category links | Assign products to categories |
| **Category Tree**       | `CategoryTreeClient`       | Tree navigation        | Retrieve category trees       |

### Price

| Service             | Client                 | Description           | Key Operations            |
|---------------------|------------------------|-----------------------|---------------------------|
| **Price**           | `PriceClient`          | Price management      | Create, update prices     |
| **Price List**      | `PriceListClient`      | Price lists           | Manage price lists        |
| **Price List Price**| `PriceListPriceClient` | Price list entries    | Manage prices in lists    |
| **Price Model**     | `PriceModelClient`     | Pricing strategies    | Configure pricing models  |
| **Price Match**     | `PriceMatchClient`     | Price calculation     | Calculate best prices     |

### Cart & Checkout

| Service          | Client               | Description              | Key Operations                    |
|------------------|----------------------|--------------------------|-----------------------------------|
| **Cart**         | `CartClient`         | Shopping cart management | Create, update, retrieve carts    |
| **Cart Items**   | `CartItemsClient`    | Cart item operations     | Add, update, remove cart items    |
| **Cart Discount**| `CartDiscountClient` | Cart-level discounts     | Apply and manage cart discounts   |
| **Checkout**     | `CheckoutClient`     | Checkout process         | Process checkouts, create orders  |

### Order

| Service               | Client                   | Description          | Key Operations                   |
|-----------------------|--------------------------|----------------------|----------------------------------|
| **Order**             | `OrderClient`            | Order operations     | Retrieve, update orders          |
| **Order Management**  | `OrderManagementClient`  | Order administration | Full order lifecycle management  |

### Customer

| Service                   | Client                           | Description                  | Key Operations                        |
|---------------------------|----------------------------------|------------------------------|---------------------------------------|
| **Customer**              | `CustomerClient`                 | Customer operations          | Retrieve customer data                |
| **Customer Management**   | `CustomerManagementClient`       | Customer administration      | Create, update, delete customers      |
| **Customer Address**      | `CustomerAddressClient`          | Customer addresses           | Retrieve customer addresses           |
| **Customer Address Mgmt** | `CustomerAddressManagementClient`| Address administration       | Create, update, delete addresses      |
| **Customer Credentials**  | `CustomerCredentialsClient`      | Password & email management  | Password reset, email change          |
| **Customer Double Opt-In**| `CustomerDoubleOptInClient`      | Email verification           | Manage double opt-in flow             |

### Company (B2B)

| Service                  | Client                      | Description              | Key Operations                    |
|--------------------------|-----------------------------|--------------------------|-----------------------------------|
| **Legal Entity**         | `LegalEntityClient`         | B2B company management   | Create, update legal entities     |
| **Location**             | `LocationClient`            | Company locations        | Manage business locations         |
| **Contact Assignment**   | `ContactAssignmentClient`   | Contact relationships    | Assign contacts to entities       |

### Shipping

| Service                          | Client                              | Description                    | Key Operations                        |
|----------------------------------|-------------------------------------|--------------------------------|---------------------------------------|
| **Shipping Methods**             | `ShippingMethodsClient`             | Shipping methods               | Manage shipping methods               |
| **Shipping Zones**               | `ShippingZonesClient`               | Shipping zones                 | Define shipping zones                 |
| **Shipping Groups**              | `ShippingGroupsClient`              | Shipping groups                | Manage shipping groups                |
| **Shipping Cost**                | `ShippingCostClient`                | Shipping cost calculation      | Calculate shipping costs              |
| **Customer Group Relations**     | `CustomerGroupRelationsClient`      | Customer group mappings        | Manage customer group relations       |
| **Delivery Windows**             | `DeliveryWindowsClient`             | Delivery time windows          | Define delivery windows               |
| **Delivery Sites**               | `DeliverySitesClient`               | Delivery locations             | Manage delivery sites                 |
| **Delivery Cycles**              | `DeliveryCyclesClient`              | Delivery cycles                | Manage delivery cycles                |
| **Delivery Times Management**    | `DeliveryTimesManagementClient`     | Delivery times administration  | Manage delivery times                 |
| **Delivery Times Slots Mgmt**    | `DeliveryTimesSlotsManagementClient`| Delivery time slots            | Manage delivery time slots            |

### Coupon

| Service                       | Client                           | Description                 | Key Operations                    |
|-------------------------------|----------------------------------|-----------------------------|-----------------------------------|
| **Coupon Management**         | `CouponManagementClient`         | Coupon administration       | Create, update, delete coupons    |
| **Coupon Redemption**         | `CouponRedemptionClient`         | Coupon usage                | Redeem and manage coupon usage    |
| **Coupon Validation**         | `CouponValidationClient`         | Coupon validation           | Validate coupon eligibility       |
| **Referral Coupon Management**| `ReferralCouponManagementClient` | Referral coupons            | Manage referral coupon programs   |

### Tax

| Service  | Client       | Description       | Key Operations          |
|----------|--------------|-------------------|-------------------------|
| **Tax**  | `TaxClient`  | Tax configuration | Manage tax settings, calculate taxes |

### Configuration

| Service                  | Client                      | Description          | Key Operations           |
|--------------------------|-----------------------------|----------------------|--------------------------|
| **Configuration**        | `ConfigurationClient`       | Tenant configuration | Tenant settings          |
| **Client Configuration** | `ClientConfigurationClient` | Client-scoped config | Client-specific settings |

### Session Context

| Service                | Client                   | Description           | Key Operations              |
|------------------------|--------------------------|-----------------------|-----------------------------|
| **Session Context**    | `SessionContextClient`   | Session management    | Manage session context      |
| **Own Session Context**| `OwnSessionContextClient`| Own session operations| Manage own session context  |

## Authentication

The SDK provides comprehensive token management through `EmporixTokenService` and direct client invocation patterns.

**Important:** All client methods accept an optional authorization header parameter (typically the last parameter).
You must obtain tokens using `EmporixTokenService` and pass them to client methods using the convenient `bearerAccessToken()` method, which
formats the token as `"Bearer {token}"` and is null-safe and idempotent.

### Scope Constants

All API clients provide scope constants through a nested `Scopes` interface. **Always use these constants** instead of hardcoded strings for
type safety and IDE autocomplete support.

**Example:**

```java
import io.emporix.product.ProductClient;
import io.emporix.category.CategoryClient;
import io.emporix.price.PriceClient;
import static io.emporix.product.ProductClient.Scopes.*;
import static io.emporix.category.CategoryClient.Scopes.*;
import static io.emporix.price.PriceClient.Scopes.*;

// Available Product Scopes:
PRODUCT_MANAGE                  // product.product_manage
PRODUCT_MANAGE_BY_VENDOR       // product.product_manage_by_vendor
PRODUCT_PUBLISH                // product.product_publish
PRODUCT_UNPUBLISH              // product.product_unpublish
PRODUCT_READ_UNPUBLISHED       // product.product_read_unpublished
PRODUCT_READ_BY_VENDOR         // product.product_read_by_vendor

// Available Category Scopes:
CATEGORY_MANAGE                // category.category_manage
CATEGORY_PUBLISH               // category.category_publish
CATEGORY_UNPUBLISH             // category.category_unpublish
CATEGORY_READ_UNPUBLISHED      // category.category_read_unpublished

// Available Price Scopes:
PRICE_MANAGE                   // price.price_manage
PRICE_READ                     // price.price_read
PRICE_MANAGE_BY_VENDOR         // price.price_manage_by_vendor
```

**Benefits:**

- Type safety - compile-time errors for typos
- IDE autocomplete - discover available scopes
- Refactoring support - rename scopes safely
- Documentation - JavaDoc for each scope

### Authentication Overview

Emporix supports several token types:

| Token Type               | Use Case                                | Credentials Used         | How to Obtain                                                    |
|--------------------------|-----------------------------------------|--------------------------|------------------------------------------------------------------|
| **Service Token**        | Backend operations, admin tasks         | `backend` credentials    | `tokenService.getServiceToken()`                                 |
| **Scoped Service Token** | Backend with specific permissions       | `backend` credentials    | `tokenService.getServiceToken(Set.of(SCOPES))`                   |
| **Custom Service Token** | Integration/partner with full access    | `custom` credentials     | `tokenService.getServiceToken("integration")`                    |
| **Custom Scoped Token**  | Integration/partner with limited scopes | `custom` credentials     | `tokenService.getServiceToken(Set.of(SCOPES), "integration")`    |
| **Customer Token**    | Authenticated user operations           | `storefront` credentials | `tokenService.getCustomerToken(email, password, anonymousToken)` |
| **Anonymous Token**      | Guest browsing, public access           | `storefront` credentials | `tokenService.getAnonymousToken()`                               |
| **B2B Token**            | Business customer operations            | `storefront` credentials | `tokenService.getB2bToken(customerToken, legalEntityId)`         |

**Important:** Customer token requires an `anonymousToken` parameter - Emporix returns an error if omitted.

### Token Caching

The SDK automatically caches tokens for optimal performance:

- **Service tokens** - Cached by scope set AND credential name, auto-refreshed on expiration
- **Custom credential tokens** - Each credential set has its own cache
- **Customer tokens** - NOT cached (managed by your application)
- **Anonymous tokens** - NOT cached (each user needs unique token)

## Token Management

The SDK uses a direct token management approach. All API clients accept an authorization header parameter (typically the last parameter in
each method). You obtain tokens using `EmporixTokenService` and pass them to client methods.

### Basic Token Flow

1. **Obtain a token** using `EmporixTokenService`
2. **Get Bearer token** using `token.bearerAccessToken()` (null-safe and idempotent)
3. **Pass to client method**

**Example:**

```java
// Get service token with all available scopes
ServiceTokenResponse token = tokenService.getServiceToken();
String authorization = token.bearerAccessToken();  // "Bearer {access_token}"
productClient.getProducts(..., authorization);
```

### Using Service Tokens (Backend Operations)

Service tokens are used for backend/administrative operations and are automatically cached by the SDK.

**Available Methods:**

- `getServiceToken()` - Get token with **all available scopes** (simplest, recommended for most cases)
- `getServiceToken(Set<String> scopes)` - Get token with **specific scopes** (least privilege principle)
- `getServiceToken(String credentialName)` - Get token with **custom credentials** and all scopes
- `getServiceToken(Set<String> scopes, String credentialName)` - Get token with **custom credentials and specific scopes**

#### Example: Service Token Usage

```java
import io.emporix.auth.service.EmporixTokenService;
import io.emporix.auth.dto.ServiceTokenResponse;
import io.emporix.product.ProductClient;
import io.emporix.product.dto.response.ProductResponse;
import static io.emporix.product.ProductClient.Scopes.*;

@Service
public class ProductService {
    
    @Autowired
    private EmporixTokenService tokenService;
    
    @Autowired
    private ProductClient productClient;
    
    // Get service token and use it with client
    public List<ProductResponse> getAllProducts() {
        // 1. Get service token with all available scopes (simplest way)
        ServiceTokenResponse token = tokenService.getServiceToken();
        
        // 2. Get Bearer token
        String authorization = token.bearerAccessToken();
        
        // 3. Pass to client method
        return productClient.getProducts(
            null,          // q (query)
            null,          // expand
            null,          // rawValue
            1,             // pageNumber
            20,            // pageSize
            "name:asc",    // sort
            true,          // fetchTotalCount
            "en",          // acceptLanguage
            authorization  // authorization header
        ).getBody();
    }
    
    // Get service token with specific scopes
    public List<ProductResponse> getProductsWithScopes() {
        // Request token with specific scopes for least privilege
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_READ_UNPUBLISHED)
        );
        
        String authorization = token.bearerAccessToken();
        
        return productClient.getProducts(
            null, null, null, 1, 20, null, true, "en", authorization
        ).getBody();
    }
    
    // Create product with service token
    public String createProduct(GenericProductCreateRequest request) {
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_MANAGE)
        );
        
        String authorization = token.bearerAccessToken();
        
        ResourceLocation location = productClient.createProduct(
            request,       // product data
            false,         // skipVariantGeneration
            true,          // doIndex
            "en",          // contentLanguage
            authorization  // authorization header
        ).getBody();
        
        return location.getId();
    }
}
```

### Using Custom Credentials

Custom credentials are additional OAuth2 clients configured in Emporix with specific scopes. Use them for:

- External integrations with limited permissions
- Partner access with read-only or specific operations
- Third-party systems that need controlled access

```java
@Service
public class IntegrationService {
    
    @Autowired
    private EmporixTokenService tokenService;
    
    @Autowired
    private ProductClient productClient;
    
    // Use default backend credentials (full admin access)
    public void adminOperation() {
        ServiceTokenResponse token = tokenService.getServiceToken();
        String authorization = token.bearerAccessToken();
        
        productClient.createProduct(..., authorization);
    }
    
    // Use integration credentials (all scopes granted to that OAuth2 client)
    public void integrationOperation() {
        // Get token using custom "integration" credentials
        ServiceTokenResponse token = tokenService.getServiceToken("integration");
        String authorization = token.bearerAccessToken();
        
        productClient.createProduct(..., authorization);
    }
    
    // Use partner credentials with specific scopes (least privilege)
    public void partnerReadOnlyOperation() {
        // Partner OAuth2 client has limited scopes - request only what you need
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_READ_UNPUBLISHED),
            "partner"
        );
        String authorization = token.bearerAccessToken();
        
        productClient.getProducts(..., authorization);
    }
}
```

**Configuration for custom credentials:**

```yaml
emporix:
  api:
    credentials:
      backend:
        client-id: admin-client-id        # Full access OAuth2 client
        secret: admin-secret
      custom:
        integration:
          client-id: integration-client-id  # Integration OAuth2 client (configured in Emporix)
          secret: integration-secret
        partner:
          client-id: partner-client-id      # Partner OAuth2 client configured in Emporix with read-only scopes
          secret: partner-secret
```

### Using Anonymous Tokens (Guest Browsing)

Anonymous tokens are used for public/guest browsing sessions.

```java
import io.emporix.auth.dto.AnonymousTokenResponse;

@Service
public class PublicProductService {
    
    @Autowired
    private EmporixTokenService tokenService;
    
    @Autowired
    private ProductClient productClient;
    
    // Get anonymous token and browse products
    public List<ProductResponse> browseProducts() {
        // 1. Get anonymous token
        AnonymousTokenResponse token = tokenService.getAnonymousToken();
        
        // 2. Get Bearer token
        String authorization = token.bearerAccessToken();
        
        // 3. Browse published products only
        return productClient.getProducts(
            "published:true",  // only published products
            null, null, 1, 20, null, true, "en",
            authorization
        ).getBody();
    }
    
    // Refresh anonymous token when expired
    public AnonymousTokenResponse refreshToken(AnonymousTokenResponse expiredToken) {
        return tokenService.refreshAnonymousToken(expiredToken);
    }
}
```

### Using Customer Tokens (Authenticated Users)

Customer tokens are for authenticated user operations. The SDK automatically preserves shopping sessions when logging in.

**IMPORTANT: Anonymous Token and Session Context**

Emporix **requires** an anonymous token when logging in customers. The SDK provides convenience by automatically fetching a new anonymous token if you don't provide one. However, **this creates a NEW session** and you lose the user's cart, preferences, and browsing context.

**Available Methods:**

- `getCustomerToken(email, password, AnonymousTokenResponse)` - Login with anonymous token object **Recommended**
- `getCustomerToken(email, password, String)` - Login with anonymous bearer string **Recommended**
- `getCustomerToken(email, password)` - Works but creates new session **Loses cart/session context**

**Typical Flow:**

1. User opens page → Get anonymous token (session created with cart)
2. User browses → Use anonymous token
3. User clicks login → Use THAT anonymous token to authenticate
4. Session context preserved (cart, preferences, etc.)

```java
import io.emporix.auth.dto.CustomerTokenResponse;
import io.emporix.auth.dto.AnonymousTokenResponse;

@Service
public class CustomerAuthService {
    
    @Autowired
    private EmporixTokenService tokenService;
    
    @Autowired
    private ProductClient productClient;
    
    // RECOMMENDED: Login with AnonymousTokenResponse object (preserves session)
    public CustomerTokenResponse login(String email, String password) {
        // Get the user's existing anonymous token (from their browsing session)
        AnonymousTokenResponse anonymousToken = tokenService.getAnonymousToken();
        
        // Login customer - preserves session (cart, etc.) from anonymous token
        return tokenService.getCustomerToken(email, password, anonymousToken);
    }
    
    // Alternative: Login with bearer string (when token comes from HTTP header)
    public CustomerTokenResponse loginWithBearerString(
        String email, 
        String password, 
        String anonymousBearerToken  // e.g., "Bearer xxx" or just "xxx"
    ) {
        // Use when you already have the anonymous token as a string
        return tokenService.getCustomerToken(email, password, anonymousBearerToken);
    }
    
    // NOT RECOMMENDED: Works but loses cart/session context
    public CustomerTokenResponse loginWithoutSession(String email, String password) {
        // SDK will auto-fetch a NEW anonymous token, creating a NEW session
        // User's cart and browsing context will be lost!
        return tokenService.getCustomerToken(email, password);
    }
    
    // Use customer token to fetch products
    public List<ProductResponse> getCustomerProducts(CustomerTokenResponse customerToken) {
        String authorization = customerToken.bearerAccessToken();
        
        return productClient.getProducts(
            null, null, null, 1, 20, null, true, "en",
            authorization
        ).getBody();
    }
    
    // Refresh customer token when expired
    public CustomerTokenResponse refreshCustomerToken(CustomerTokenResponse expiredToken) {
        return tokenService.refreshCustomerToken(expiredToken);
    }
    
    // Get B2B token with legal entity context
    public CustomerTokenResponse switchToB2bContext(
        CustomerTokenResponse customerToken,
        String legalEntityId
    ) {
        return tokenService.getB2bToken(customerToken, legalEntityId);
    }
}
```

### Token Cache Management

The SDK automatically caches service tokens for performance. You can clear the cache when needed:

```java
import io.emporix.auth.dto.TokenType;
import static io.emporix.product.ProductClient.Scopes.*;

// Clear all cached tokens
tokenService.clearCache();

// Clear specific service token by scope
tokenService.clearCache(TokenType.SERVICE, PRODUCT_READ_UNPUBLISHED);

// Clear service token for custom credential with specific scope
tokenService.clearCache(TokenType.SERVICE, "integration:" + PRODUCT_MANAGE);

// Clear all tokens for a custom credential (all scopes)
tokenService.clearCache(TokenType.SERVICE, "partner:");
```

{% hint style="info" %}
Anonymous and customer tokens are NOT cached by the SDK - you must manage them in your application (e.g., in HTTP session or Redis).
{% endhint %}

## Usage Examples

### Example 1: Product Management

```java
import io.emporix.auth.service.EmporixTokenService;
import io.emporix.auth.dto.ServiceTokenResponse;
import io.emporix.product.ProductClient;
import io.emporix.product.dto.request.create.BasicProductCreateRequest;
import io.emporix.product.dto.request.update.GenericProductUpdateRequest;
import io.emporix.product.dto.response.ProductResponse;
import io.emporix.common.dto.ResourceLocation;
import io.emporix.common.dto.LocalizedValueDto;
import static io.emporix.product.ProductClient.Scopes.*;

@Service
public class ProductManagementService {
    
    @Autowired
    private ProductClient productClient;
    
    @Autowired
    private EmporixTokenService tokenService;
    
    public String createProduct(String code, String name, String description) {
        // Build product request
        BasicProductCreateRequest request = BasicProductCreateRequest.builder()
            .code(code)
            .published(true)
            .name(LocalizedValueDto.of("en", name))
            .description(LocalizedValueDto.of("en", description))
            .build();
        
        // Get service token
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_MANAGE)
        );
        String authorization = token.bearerAccessToken();
        
        // Create product
        ResourceLocation location = productClient.createProduct(
            request,
            false,         // skipVariantGeneration
            true,          // doIndex
            "en",          // contentLanguage
            authorization  // authorization header
        ).getBody();
        
        return location.getId();
    }
    
    public List<ProductResponse> searchProducts(String query) {
        // Get token with read scope
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_READ_UNPUBLISHED)
        );
        String authorization = token.bearerAccessToken();
        
        return productClient.getProducts(
            query,         // e.g., "published:true AND name:*shirt*"
            null,          // expand
            null,          // rawValue
            1,             // pageNumber
            50,            // pageSize
            "name:asc",    // sort
            true,          // fetchTotalCount
            "en",          // acceptLanguage
            authorization  // authorization header
        ).getBody();
    }
    
    public void updateProduct(String id, GenericProductUpdateRequest request) {
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_MANAGE)
        );
        String authorization = token.bearerAccessToken();
        
        productClient.upsertProduct(
            id,
            request,
            false,         // skipVariantGeneration
            true,          // doIndex
            "en",          // contentLanguage
            authorization
        );
    }
    
    public void deleteProduct(String productId) {
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_MANAGE)
        );
        String authorization = token.bearerAccessToken();
        
        productClient.deleteProduct(
            productId,
            null,          // force
            true,          // doIndex
            authorization
        );
    }
}
```

### Example 2: Category Management

```java
import io.emporix.category.CategoryClient;
import io.emporix.category.dto.request.CategoryCreateRequest;
import io.emporix.category.dto.response.CategoryResponse;
import static io.emporix.category.CategoryClient.Scopes.*;

@Service
public class CategoryManagementService {
    
    @Autowired
    private CategoryClient categoryClient;
    
    @Autowired
    private EmporixTokenService tokenService;
    
    public String createCategory(String code, String name) {
        CategoryCreateRequest request = CategoryCreateRequest.builder()
            .code(code)
            .published(true)
            .localizedName(LocalizedValueDto.of("en", name))
            .build();
        
        // Get service token
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(CATEGORY_MANAGE)
        );
        String authorization = token.bearerAccessToken();
        
        ResourceLocation location = categoryClient.createCategory(
            request,
            true,          // publish
            "en",          // contentLanguage
            authorization  // authorization header
        ).getBody();
        
        return location.getId();
    }
    
    public List<CategoryResponse> getRootCategories() {
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(CATEGORY_READ_UNPUBLISHED)
        );
        String authorization = token.bearerAccessToken();
        
        return categoryClient.getCategories(
            true,          // showRoots (only root categories)
            false,         // showUnpublished
            1,             // pageNumber
            50,            // pageSize
            null,          // sort
            true,          // fetchTotalCount
            "en",          // acceptLanguage
            authorization  // authorization header
        ).getBody();
    }
    
    public List<CategoryResponse> getSubcategories(String categoryId) {
        ServiceTokenResponse token = tokenService.getServiceToken();
        String authorization = token.bearerAccessToken();
        
        return categoryClient.getCategorySubcategories(
            categoryId,
            1,             // depth (direct children only)
            false,         // showUnpublished
            1,             // pageNumber
            50,            // pageSize
            null,          // sort
            true,          // fetchTotalCount
            "en",          // acceptLanguage
            authorization
        ).getBody();
    }
}
```

### Example 3: Multi-Client Operations with Custom Credentials

This example shows how to use multiple OAuth2 clients (configured in Emporix) with different permission levels.

```java
import io.emporix.auth.service.EmporixTokenService;
import io.emporix.product.ProductClient;
import static io.emporix.product.ProductClient.Scopes.*;

@Service
public class MultiClientProductService {
    
    @Autowired
    private ProductClient productClient;
    
    @Autowired
    private EmporixTokenService tokenService;
    
    // Admin operations with default backend credentials (full access)
    public void adminCreateProduct(BasicProductCreateRequest request) {
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_MANAGE)
        );
        
        String authorization = token.bearerAccessToken();
        productClient.createProduct(request, false, true, "en", authorization);
    }
    
    // External integration with its own OAuth2 client (all granted scopes)
    public List<ProductResponse> getProductsForIntegration() {
        // Use integration OAuth2 client (configured in Emporix with specific scopes)
        ServiceTokenResponse token = tokenService.getServiceToken("integration");
        
        String authorization = token.bearerAccessToken();
        return productClient.getProducts(
            null, null, null, 1, 100, null, true, "en", authorization
        ).getBody();
    }
    
    // Partner API with limited OAuth2 client (read-only access)
    public List<ProductResponse> getProductsForPartner() {
        // Partner OAuth2 client configured in Emporix with read-only scopes
        ServiceTokenResponse token = tokenService.getServiceToken("partner");
        
        String authorization = token.bearerAccessToken();
        return productClient.getProducts(
            "published:true", null, null, 1, 100, null, true, "en", authorization
        ).getBody();
    }
    
    // Third-party system with specific scope requirement
    public List<ProductResponse> getProductsForThirdParty() {
        // Request only the specific scope needed (even if the OAuth2 client has more)
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_READ_UNPUBLISHED),
            "thirdparty"
        );
        
        String authorization = token.bearerAccessToken();
        return productClient.getProducts(
            null, null, null, 1, 100, null, true, "en", authorization
        ).getBody();
    }
}
```

**Configuration:**

Each custom credential corresponds to an OAuth2 client configured in your Emporix tenant with specific scopes.

```yaml
emporix:
  api:
    credentials:
      backend:
        client-id: admin-client-id        # Full admin OAuth2 client
        secret: admin-secret
      custom:
        integration:
          client-id: integration-client-id  # Integration OAuth2 client (specific scopes)
          secret: integration-secret
        partner:
          client-id: partner-client-id      # Partner OAuth2 client (read-only)
          secret: partner-secret
        thirdparty:
          client-id: thirdparty-client-id   # Third-party OAuth2 client
          secret: thirdparty-secret
```

{% hint style="info" %}
Each OAuth2 client (`integration`, `partner`, `thirdparty`) must be created in your Emporix tenant settings with the appropriate scopes assigned.
{% endhint %}

### Example 4: REST Controller

```java
import io.emporix.auth.service.EmporixTokenService;
import io.emporix.auth.dto.ServiceTokenResponse;
import io.emporix.product.ProductClient;
import io.emporix.product.dto.request.create.BasicProductCreateRequest;
import io.emporix.product.dto.response.ProductResponse;
import io.emporix.common.dto.ResourceLocation;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import static io.emporix.product.ProductClient.Scopes.*;

@RestController
@RequestMapping("/api/products")
public class ProductController {
    
    @Autowired
    private ProductClient productClient;
    
    @Autowired
    private EmporixTokenService tokenService;
    
    // Option 1: Controller manages tokens (simpler for internal APIs)
    @GetMapping
    public ResponseEntity<List<ProductResponse>> listProducts(
        @RequestParam(required = false) String query
    ) {
        // Get service token
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_READ_UNPUBLISHED)
        );
        String authorization = token.bearerAccessToken();
        
        // Call client
        List<ProductResponse> products = productClient.getProducts(
            query, null, null, 1, 20, null, true, "en", authorization
        ).getBody();
        
        return ResponseEntity.ok(products);
    }
    
    // Option 2: Accept Authorization header from caller (for external APIs)
    @GetMapping("/{id}")
    public ResponseEntity<ProductResponse> getProduct(
        @PathVariable String id,
        @RequestHeader(name = HttpHeaders.AUTHORIZATION, required = false) String authorization
    ) {
        // Authorization can come from request or be generated
        if (authorization == null) {
            ServiceTokenResponse token = tokenService.getServiceToken();
            authorization = token.bearerAccessToken();
        }
        
        ProductResponse product = productClient.getProduct(
            id, null, null, null, "en", authorization
        ).getBody();
        
        return ResponseEntity.ok(product);
    }
    
    @PostMapping
    public ResponseEntity<ResourceLocation> createProduct(
        @RequestBody BasicProductCreateRequest request
    ) {
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_MANAGE)
        );
        String authorization = token.bearerAccessToken();
        
        ResourceLocation location = productClient.createProduct(
            request, false, true, "en", authorization
        ).getBody();
        
        return ResponseEntity.status(HttpStatus.CREATED).body(location);
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable String id) {
        ServiceTokenResponse token = tokenService.getServiceToken(
            Set.of(PRODUCT_MANAGE)
        );
        String authorization = token.bearerAccessToken();
        
        productClient.deleteProduct(id, null, true, authorization);
        return ResponseEntity.noContent().build();
    }
}
```

## Advanced Configuration

### Custom Client Beans

Override default client configuration by providing your own beans:

```java
@Configuration
public class CustomClientConfig {
    
    @Bean
    @Primary
    public ProductClient customProductClient(EmporixClientFactory factory) {
        return factory.createClient(
            ProductClient.class,
            ClientConfig.builder("product")//first part after api host in the endpoint url.
                .xVersion2()  // Use API version 2
                .header("X-Custom-Header", "value")
                .build()
        );
    }
}
```

### ClientConfig Options

```java
ClientConfig.builder("product")
    // API version
    .xVersion("v2")        // Sets X-Version: v2
    
    // Custom headers
    .header("X-Custom", "value")
    .headers(Map.of(
        "X-Header-1", "value1",
        "X-Header-2", "value2"
    ))
    
    .build();
```

### Custom REST Client with Timeout

**Modern Apache HttpClient 5.6+ approach with custom timeouts:**

```java
import org.apache.hc.client5.http.config.ConnectionConfig;
import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManager;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManagerBuilder;
import org.apache.hc.core5.util.Timeout;
import org.springframework.http.client.BufferingClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;

@Configuration
public class AdvancedClientConfig {
    
    @Autowired
    private EmporixProperties properties;
    
    @Autowired
    private EmporixErrorHandler errorHandler;
    
    @Bean
    @Primary
    public ProductClient productClientWithCustomTimeout(EmporixClientFactory factory) {
        // Connection-level configuration (5 seconds connect, 30 seconds read)
        ConnectionConfig connectionConfig = ConnectionConfig.custom()
            .setConnectTimeout(Timeout.ofSeconds(5))
            .setSocketTimeout(Timeout.ofSeconds(30))
            .build();
        
        // Build connection manager with custom configuration
        PoolingHttpClientConnectionManager connectionManager = 
            PoolingHttpClientConnectionManagerBuilder.create()
                .setDefaultConnectionConfig(connectionConfig)
                .build();
        
        // Request-level configuration
        RequestConfig requestConfig = RequestConfig.custom()
            .setConnectionRequestTimeout(Timeout.ofSeconds(5))
            .setResponseTimeout(Timeout.ofSeconds(30))
            .build();
        
        // Build Apache HttpClient 5 with custom settings
        CloseableHttpClient httpClient = HttpClients.custom()
            .setConnectionManager(connectionManager)
            .setDefaultRequestConfig(requestConfig)
            .build();
        
        // Create factory with pre-configured HttpClient
        HttpComponentsClientHttpRequestFactory httpClientFactory = 
            new HttpComponentsClientHttpRequestFactory(httpClient);
        
        // Wrap with BufferingClientHttpRequestFactory for error response handling
        BufferingClientHttpRequestFactory requestFactory = 
            new BufferingClientHttpRequestFactory(httpClientFactory);
        
        RestClient restClient = RestClient.builder()
            .baseUrl(properties.getApiHost() + "/" + 
                     properties.getTenant() + "/product")
            .requestFactory(requestFactory)
            .defaultHeader("X-Version", "v2")
            .defaultStatusHandler(errorHandler)
            .build();
        
        RestClientAdapter adapter = RestClientAdapter.create(restClient);
        HttpServiceProxyFactory proxyFactory = HttpServiceProxyFactory
            .builderFor(adapter)
            .build();
        
        return proxyFactory.createClient(ProductClient.class);
    }
}
```

**Key points:**

- Uses Apache HttpClient 5.6+ (no deprecated APIs)
- `ConnectionConfig` for connection-level timeouts (connect, socket)
- `RequestConfig` for request-level timeouts (connection request, response)
- `PoolingHttpClientConnectionManager` for better connection pooling control

## Exception Handling

### Global Exception Handler

Enable automatic exception handling:

```yaml
emporix:
  exception-handler:
    enabled: true
```

This provides automatic handling of:

- `EmporixApiException` - Emporix API errors
- Standard HTTP errors (400, 401, 403, 404, 500, etc.)
- Validation errors
- Structured error responses

### Manual Exception Handling

```java
import io.emporix.exception.EmporixApiException;
import io.emporix.auth.service.EmporixTokenService;
import io.emporix.auth.dto.ServiceTokenResponse;

@Service
public class ProductService {
    
    @Autowired
    private ProductClient productClient;
    
    @Autowired
    private EmporixTokenService tokenService;
    
    public ProductResponse getProductSafely(String productId) {
        // Get authorization
        ServiceTokenResponse token = tokenService.getServiceToken();
        String authorization = token.bearerAccessToken();
        
        try {
            ResponseEntity<ProductResponse> response = 
                productClient.getProduct(productId, null, null, null, "en", authorization);
            return response.getBody();
            
        } catch (EmporixApiException e) {
            // EmporixErrorHandler converts ALL 4xx and 5xx responses to EmporixApiException
            // Provides structured error information from Emporix API
            
            log.error("Emporix API error: {} - {} - Details: {}", 
                e.getStatusCode(), 
                e.getMessage(),
                e.getErrorResponse().getDetails());
            
            // Handle specific error cases
            if (e.getStatusCode().value() == 404) {
                log.info("Product not found: {}", productId);
                return null;
            }
            
            if (e.getStatusCode().value() == 403) {
                log.error("Insufficient permissions to access product: {}", productId);
                throw new IllegalStateException("Access denied", e);
            }
            
            // Re-throw for other errors (500, 401, etc.)
            throw e;
        }
    }
}
```

## Best Practices

### Use Appropriate Scopes

Choose the right method based on your security requirements:

**For specific operations (recommended - least privilege):**

```java
import static io.emporix.product.ProductClient.Scopes.*;

// Request only read scope for read operations
ServiceTokenResponse token = tokenService.getServiceToken(
    Set.of(PRODUCT_READ_UNPUBLISHED)
);
```

**For full backend access (simpler, when you need multiple operations):**

```java
// Get token with all available scopes (fine for backend services)
ServiceTokenResponse token = tokenService.getServiceToken();
```

**Avoid (requesting all scopes when you only need one):**

```java
// Don't use getServiceToken() if you only perform read operations
// Use getServiceToken(Set.of(PRODUCT_READ_UNPUBLISHED)) instead
ServiceTokenResponse token = tokenService.getServiceToken();
```

**When to use each:**

- Use `getServiceToken()` for internal backend services that perform multiple operations
- Use `getServiceToken(Set.of(SCOPES))` for external integrations or when following strict least-privilege security

### Preserve Anonymous Tokens on Login

Always pass the anonymous token when logging in customers to preserve shopping cart and session:

**Recommended:**

```java
// Get the user's existing anonymous token (from their browsing session)
AnonymousTokenResponse anonymousToken = tokenService.getAnonymousToken();

// Login with that token (preserves cart/session)
CustomerTokenResponse customerToken = tokenService.getCustomerToken(
    email, password, anonymousToken
);
```

**Avoid (loses session context):**

```java
// Works but creates a NEW session - user's cart and preferences are lost!
CustomerTokenResponse customerToken = tokenService.getCustomerToken(
    email, password  // SDK auto-fetches new anonymous token, new session created
);
```

### Reuse Service Tokens

Service tokens are automatically cached by the SDK. Reuse the same `EmporixTokenService` instance:

**Recommended:**

```java
@Service
public class ProductService {
    @Autowired
    private EmporixTokenService tokenService;  // Spring-managed singleton
    
    public void operation1() {
        ServiceTokenResponse token = tokenService.getServiceToken(...);
        // Token is cached for subsequent calls
    }
    
    public void operation2() {
        ServiceTokenResponse token = tokenService.getServiceToken(...);
        // Returns cached token if not expired
    }
}
```

### Handle Errors Gracefully

Always handle API exceptions appropriately:

**Recommended:**

```java
public ProductResponse getProduct(String id) {
    ServiceTokenResponse token = tokenService.getServiceToken();
    String authorization = token.bearerAccessToken();
    
    try {
        return productClient.getProduct(id, null, null, null, "en", authorization).getBody();
    } catch (EmporixApiException e) {
        if (e.getStatusCode().value() == 404) {
            return null;  // Product not found
        }
        log.error("API error: {}", e.getMessage());
        throw e;
    }
}
```

### Use Custom Credentials for Integrations and Partners

Leverage custom credentials (separate OAuth2 clients configured in Emporix) for integrations, partners, or systems with limited permissions:

**Recommended:**

```java
// Integration OAuth2 client with full access to granted scopes
ServiceTokenResponse integrationToken = tokenService.getServiceToken("integration");

// Partner OAuth2 client with read-only scopes
ServiceTokenResponse partnerToken = tokenService.getServiceToken(
    Set.of(PRODUCT_READ_UNPUBLISHED),
    "partner"
);

// External system OAuth2 client with specific permissions
ServiceTokenResponse externalToken = tokenService.getServiceToken("external");
```

Each custom credential corresponds to an OAuth2 client created in your Emporix tenant with specific scopes.

### Manage Customer Tokens in Your Application

The SDK does NOT cache customer tokens. Store them securely in your application:

**Recommended:**

```java
// Store in HTTP session
session.setAttribute("customerToken", customerToken);

// Or in Redis with expiration
redisTemplate.opsForValue().set(
    "customer:token:" + customerId,
    customerToken,
    Duration.ofHours(1)
);

// Or in JWT for stateless authentication
String jwt = jwtService.createToken(customerToken);
```

**Recommended:**

```java
// Authorization is always the last parameter
productClient.getProducts(
    query, expand, rawValue, pageNumber, pageSize, 
    sort, fetchTotalCount, acceptLanguage,
    authorization  // Last parameter
);
```

### Enable Token Caching

Keep token caching enabled in production for better performance:

```yaml
emporix:
  cache:
    enabled: true
    max-size: 1000
    expiration-buffer-seconds: 60
    max-lifetime-seconds: 3600
```

## Troubleshooting

### Issue: "Bean of type ProductClient could not be found"

**Cause:** SDK auto-configuration is not enabled.

**Solution:** Add `@EnableEmporixAutoConfiguration` to your main application class:

```java

@SpringBootApplication
@EnableEmporixAutoConfiguration  // ← Add this
public class MyApplication { ...
}
```

### Issue: "401 Unauthorized"

**Possible Causes:**

1. Invalid credentials
2. Missing or malformed authorization header
3. Expired token
4. Token with insufficient scopes

**Solutions:**

1. Verify credentials in Emporix Portal
2. Check environment variables are set correctly:
   ```bash
   echo $EMPORIX_TENANT
   echo $EMPORIX_API_CREDENTIALS_BACKEND_CLIENT_ID
   echo $EMPORIX_API_CREDENTIALS_BACKEND_SECRET
   ```
3. Ensure you're passing the authorization header:
   ```java
   ServiceTokenResponse token = tokenService.getServiceToken();
   String authorization = token.bearerAccessToken();  // ← Don't forget!
   productClient.getProducts(..., authorization);
   ```

### Issue: "Tenant must be configured"

**Cause:** Missing tenant configuration.

**Solution:** Set tenant via environment variable or application.yml:

```bash
export EMPORIX_TENANT=your-tenant-id
```

Or:

```yaml
emporix:
  tenant: your-tenant-id
```

### Issue: "Custom credentials 'xxx' not found"

**Cause:** Requesting a token with custom credential name that doesn't exist in configuration.

**Example Error:**

```java
// This will fail if "integration" credentials are not configured
ServiceTokenResponse token = tokenService.getServiceToken("integration");
```

**Solution:** Configure custom credentials in `application.yml`:

```yaml
emporix:
  api:
    credentials:
      custom:
        integration:
          client-id: integration-client-id
          secret: integration-secret
```

**Important:** The OAuth2 client must also be created in your Emporix tenant with appropriate scopes assigned.

### Issue: "403 Forbidden" or "Insufficient Scopes"

**Cause:** Token doesn't have required OAuth2 scopes for the operation.

**Solutions:**

1. Request token with appropriate scopes:
   ```java
   import static io.emporix.product.ProductClient.Scopes.*;
   
   // For write operations
   ServiceTokenResponse token = tokenService.getServiceToken(
       Set.of(PRODUCT_MANAGE)
   );
   
   // For read operations
   ServiceTokenResponse token = tokenService.getServiceToken(
       Set.of(PRODUCT_READ_UNPUBLISHED)
   );
   
   // Or request all available scopes
   ServiceTokenResponse token = tokenService.getServiceToken();
   ```
2. Verify credentials in Emporix Portal have the required scopes
3. Check if you need to use custom credentials with different scope permissions

### Issue: Token caching not working

**Symptom:** Every request creates a new token.

**Solution:** Service tokens are automatically cached. If you're seeing new tokens:

1. Check if you're requesting different scopes (each scope set gets its own cache entry)
2. Check if you're using different credential names
3. Customer and anonymous tokens are NOT cached by design

### Debugging Tips

**Enable debug logging:**

```yaml
logging:
  level:
    io.emporix: DEBUG
    org.springframework.web: DEBUG
```

**Clear token cache:**

```java
import io.emporix.auth.dto.TokenType;
import static io.emporix.product.ProductClient.Scopes.*;

@Autowired
private EmporixTokenService tokenService;

// Clear all cached tokens
tokenService.clearCache();

// Clear specific token by scope
tokenService.clearCache(TokenType.SERVICE, PRODUCT_READ_UNPUBLISHED);

// Clear tokens for custom credentials where the name matches the provided name from custom credentials
tokenService.clearCache(TokenType.SERVICE, "vendor:" + PRODUCT_MANAGE);
```

**Inspect token details:**

```java
ServiceTokenResponse token = tokenService.getServiceToken();
log.info("Token expires in: {} seconds", token.getExpiresIn());
log.info("Token type: {}", token.getTokenType());
log.info("Access token: {}", token.getAccessToken().substring(0, 20) + "...");
```
