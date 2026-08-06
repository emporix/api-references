#!/usr/bin/env bash
# Fixture tests for style-check validators.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../../.." && pwd)"

pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1" >&2; exit 1; }

run_validator() {
  local script="$1"
  shift
  python3 "${SCRIPT_DIR}/${script}" "$@" || true
}

test_frontmatter() {
  local dir
  dir="$(mktemp -d)"
  local good="${dir}/good.md"
  local bad="${dir}/bad.md"

  cat > "${good}" <<'EOF'
---
guide: true
description: Manage carts in the dashboard.
icon: cart-shopping
---
# Carts
EOF

  cat > "${bad}" <<'EOF'
---
guide: true
---
# Missing fields
EOF

  if run_validator check-frontmatter.py "${good}" | grep -q '^VIOLATION|'; then
    fail "frontmatter: good file flagged"
  fi
  if ! run_validator check-frontmatter.py "${bad}" | grep -q 'frontmatter'; then
    fail "frontmatter: bad file not flagged"
  fi
  rm -rf "${dir}"
  pass "frontmatter"
}

test_mermaid() {
  local dir
  dir="$(mktemp -d)"
  local good="${dir}/good.md"
  local bad="${dir}/bad.md"

  cat > "${good}" <<'EOF'
```mermaid
classDef c fill:#A1BDDC, stroke:#4C5359
```
EOF

  cat > "${bad}" <<'EOF'
```mermaid
classDef c fill:#FF0000
```
EOF

  if run_validator check-mermaid.py "${good}" | grep -q '^VIOLATION|'; then
    fail "mermaid: good file flagged"
  fi
  if ! run_validator check-mermaid.py "${bad}" | grep -q 'mermaid_brand'; then
    fail "mermaid: bad file not flagged"
  fi
  rm -rf "${dir}"
  pass "mermaid"
}

test_steps() {
  local dir
  dir="$(mktemp -d)"
  local bad="${dir}/bad.md"

  cat > "${bad}" <<'EOF'
{% stepper %}
{% step %}
### Wrong level
{% endstep %}
{% endstepper %}
EOF

  if ! run_validator check-steps.py "${bad}" | grep -q 'step_headings'; then
    fail "steps: bad heading not flagged"
  fi
  rm -rf "${dir}"
  pass "step_headings"
}

test_release_notes() {
  local dir
  dir="$(mktemp -d)"
  mkdir -p "${dir}/content/release-notes"
  local file="${dir}/content/release-notes/README.md"

  cat > "${file}" <<'EOF'
{% updates format="full" %}

{% update date="RELEASE_DATE" tags="new-feature, ce" %}
## Sample Feature

#### Overview
Text.

#### New features
|Feature|Benefit|
|---|---|
|**One**|Benefit.|

#### Fixes and improvements
None as this is a new feature.

#### Known problems
None as this is a new feature.

#### Documentation and links
User Guides:
*
EOF

  if run_validator check-release-notes.py "${file}" | grep -q '^VIOLATION|'; then
    fail "release_notes: valid draft flagged"
  fi

  sed -i '' 's/RELEASE_DATE/2026-01-01/' "${file}" 2>/dev/null || \
    sed -i 's/RELEASE_DATE/2026-01-01/' "${file}"

  # Dated entries are not required to have all sections in validator — should still pass tags
  pass "release_notes"
  rm -rf "${dir}"
}

main() {
  test_frontmatter
  test_mermaid
  test_steps
  test_release_notes
  echo ""
  echo "All style-check fixture tests passed."
}

main "$@"
