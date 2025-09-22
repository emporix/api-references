---
icon: hourglass-half
layout:
  width: wide
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

# 2025-03-04: Important Security Update – Discontinuation of Weak Cipher Support

## Overview
We are committed to ensuring the highest level of security for our API services. As part of this commitment, we are discontinuing support for weak cryptographic ciphers (api.emporix.io).

This update is essential to maintain the security and integrity of the data exchanged between your systems and our API.

<u>**Effective 24th of March, we will no longer support the following cipher suites:**</u>

* TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA

* TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA

These cipher suites rely on older encryption methods that are vulnerable to modern security threats. To ensure the highest level of security and compatibility, we will continue supporting strong ciphers, including TLS 1.2 and TLS 1.3 protocols.

## What do you need to do:
Ensure that your systems and applications are configured to use the following ciphers:

* TLSv1.2:
&emsp;ciphers:
&emsp;&emsp;&emsp;TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (ecdh_x25519)

* TLSv1.3:
&emsp;ciphers:
&emsp;&emsp;&emsp;TLS_AKE_WITH_AES_128_GCM_SHA256 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_AKE_WITH_AES_256_GCM_SHA384 (ecdh_x25519)
&emsp;&emsp;&emsp;TLS_AKE_WITH_CHACHA20_POLY1305_SHA256 (ecdh_x25519)