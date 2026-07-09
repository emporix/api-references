---
name: mermaid-brand-diagrams
description: Create Mermaid diagrams from user-provided content and instructions, using Mermaid-MCP for syntax/documentation and enforcing brand colors and styles from the style guide. Use when the user asks for Mermaid diagrams, flowcharts, sequence diagrams, class diagrams, or diagram styling.
---

# Mermaid Brand Diagrams

## Instructions

1. Determine the target diagram type from the user request (`flowchart`, `sequenceDiagram`, `classDiagram`, `graph`, or other Mermaid-supported type).
2. Read style requirements from:
   - `.style-guide/visuals/diagrams.md`
   - any additional style files referenced from that guide
3. Fetch Mermaid syntax from MCP before writing final code:
   - Call `get_mermaid_syntax_document` with:
     - `diagramType`: target diagram type
     - `clientName`: `cursor`
4. Generate Mermaid code from the provided content/instructions and apply brand styling:
   - Prefer transparent background settings compatible with dark/light mode.
   - Use brand palette and stroke/text standards from the style guide.
   - Treat palette colors as approved options, not rigid entity-to-color mappings unless the user explicitly asks for fixed assignments.
   - Keep labels concise and readable.
5. Validate and render via MCP:
   - Call `validate_and_render_mermaid_diagram` with:
     - `prompt`
     - `mermaidCode`
     - `diagramType`
     - `clientName`: `cursor`
6. If validation fails, fix syntax/styling issues and re-run validation.
7. Return:
   - final Mermaid code
   - short explanation of style choices
   - rendered link or output from MCP when available

## Brand Styling Baseline

- Default to `theme: base` when custom theme variables are required.
- Prefer:
  - `background: transparent`
  - `lineColor: "#9CBBE3"`
  - `arrowheadColor: "#9CBBE3"`
  - `edgeLabelBackground: "#FFC128"`
  - `edgeLabelTextColor: "#4C5359"`
- Use palette values from style guide:
  - `#9CBBE3`, `#FFC128`, `#4C5359`, `#DDE6EE`, `#A1BDDC`, `#F2F6FA`, `#3B73BB`, `#E86C07`

## Additional Resources

- For reusable snippets and mapping rules, see [reference.md](reference.md)
- For concrete generation examples, see [examples.md](examples.md)
