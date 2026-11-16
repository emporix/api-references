---
layout:
  width: wide
icon: robot-astromech
---

# AI Service

The service facilitates and streamlines e-commerce processes of product marketing.

### Key features and benefits

* Provides seamless integration with the [OpenAI platform](https://platform.openai.com/)
* Generates compelling product descriptions
* Empowers product managers to streamline the creation and updating of product content
* Creates attention-grabbing descriptions using diverse writing styles
* Ensures consistency in tone and language across all content
* Increases visibility through search engine optimization

### Machine-readable marking

Images and PDFs created by an agent are marked as AI-generated before they are stored.

* PNG and JPEG bytes include IPTC `DigitalSourceType` `trainedAlgorithmicMedia` (`http://cv.iptc.org/newscodes/digitalsourcetype/trainedAlgorithmicMedia`) in an XMP packet. A downloader can read it with `exiftool`.
* An image that already contains a provider C2PA manifest is stored unchanged.
* A PDF includes the same XMP packet. Its Info Subject and Keywords are `AI-generated`.
* Text, markdown, CSV, JSON, YAML, XML, and source files are not rewritten. Their Media asset carries the provenance mixin.
* The Media create body includes `mixins.provenance` with `origin` `ai_generated` and `metadata.mixins.provenance` pointing at the provenance schema. There is no switch that turns this off.
* The service does not edit an image the user attached, and it does not upload that image again.
* An image that cannot be marked is not stored.
