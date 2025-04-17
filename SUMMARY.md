# Table of contents

* [Getting started with Emporix API](README.md)
* [openapi-generator](openapi-generator.md)
* [Summary](summary.md)


## Standard Practices

## Approval Service

* [Approval Tutorials](approval-service/approval.md)
* [Approval API Reference](approval-service/approval-api-reference/README.md)
  * ```yaml
    type: builtin:openapi
    props:
      models: true
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: approval-api
    ```

## AI Service

* [AI Tutorials](ai-service/ai-tutorial.md)

***

* [AI API Reference](ai-api-reference/README.md)
  * ```yaml
    type: builtin:openapi
    props:
      models: true
    dependencies:
      spec:
        ref:
          kind: openapi
          spec: ai-api
    ```
* [Page 1](page-1.md)
