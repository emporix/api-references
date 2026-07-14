#!/usr/bin/env bash
# Shared helpers for style-check scripts.

set -euo pipefail

STYLE_CHECK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "${STYLE_CHECK_DIR}/../../.." && pwd)"
CONFIG_FILE="${REPO_ROOT}/.github/style-check-config.yaml"

VIOLATION_COUNT=0
VERBOSE=0
SHOW_CONTEXT=1
VIOLATIONS_FILE=""

usage() {
  cat <<'EOF'
Usage: .github/scripts/style-check/run.sh [OPTIONS] [FILE...]

Run local style-guide checks on markdown documentation.

Options:
  --base REF          Lint .md files changed vs REF (e.g. origin/master)
  --working-tree      Lint staged and unstaged .md changes
  --verbose           Include style-guide links under each violation
  --no-context        List violations only (no inline source highlights)
  --no-color          Disable ANSI colors in highlighted output
  --ci                CI output mode (reserved for future PR workflow)
  -h, --help          Show this help

Examples:
  ./.github/scripts/style-check/run.sh --base origin/main
  ./.github/scripts/style-check/run.sh changelog/changelog.md
  ./.github/scripts/style-check/run.sh --working-tree
EOF
}

init_violations_log() {
  VIOLATIONS_FILE="$(mktemp "${TMPDIR:-/tmp}/style-check-violations.XXXXXX")"
}

cleanup_violations_log() {
  if [[ -n "${VIOLATIONS_FILE}" && -f "${VIOLATIONS_FILE}" ]]; then
    rm -f "${VIOLATIONS_FILE}"
  fi
}

# Escape tabs/newlines for TSV storage.
tsv_field() {
  local value="$1"
  value="${value//$'\t'/ }"
  value="${value//$'\n'/ }"
  printf '%s' "${value}"
}

is_check_enabled() {
  local check="$1"
  python3 - "${check}" "${CONFIG_FILE}" <<'PY'
import sys
try:
    import yaml
except ImportError:
    # Minimal parser fallback when PyYAML is unavailable
    check, path = sys.argv[1], sys.argv[2]
    enabled = False
    in_checks = False
    with open(path, encoding="utf-8") as f:
        for line in f:
            stripped = line.strip()
            if stripped == "checks:":
                in_checks = True
                continue
            if in_checks:
                if not line.startswith("  "):
                    break
                if stripped.startswith(f"{check}:"):
                    val = stripped.split(":", 1)[1].strip().lower()
                    enabled = val in ("on", "true", "yes", "1")
                    break
    print("yes" if enabled else "no")
    sys.exit(0)

check, path = sys.argv[1], sys.argv[2]
with open(path, encoding="utf-8") as f:
    data = yaml.safe_load(f) or {}
checks = data.get("checks", {})
val = str(checks.get(check, "off")).lower()
print("yes" if val in ("on", "true", "yes", "1") else "no")
PY
}

guide_link_for() {
  local check="$1"
  python3 - "${check}" "${CONFIG_FILE}" <<'PY'
import sys
try:
    import yaml
except ImportError:
    check, path = sys.argv[1], sys.argv[2]
    in_links = False
    with open(path, encoding="utf-8") as f:
        for line in f:
            stripped = line.strip()
            if stripped == "guide_links:":
                in_links = True
                continue
            if in_links:
                if not line.startswith("  "):
                    break
                if stripped.startswith(f"{check}:"):
                    print(stripped.split(":", 1)[1].strip())
                    break
    sys.exit(0)

check, path = sys.argv[1], sys.argv[2]
with open(path, encoding="utf-8") as f:
    data = yaml.safe_load(f) or {}
links = data.get("guide_links", {})
print(links.get(check, ""))
PY
}

record_violation() {
  local check="$1"
  local file="$2"
  local line="$3"
  local message="$4"
  local span_start="${5:-0}"
  local span_end="${6:-0}"
  local match="${7:-}"
  VIOLATION_COUNT=$((VIOLATION_COUNT + 1))

  if [[ -n "${VIOLATIONS_FILE}" ]]; then
    printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
      "$(tsv_field "${check}")" \
      "$(tsv_field "${file}")" \
      "${line}" \
      "${span_start}" \
      "${span_end}" \
      "$(tsv_field "${match}")" \
      "$(tsv_field "${message}")" >> "${VIOLATIONS_FILE}"
  fi
}

print_violation_summary() {
  if [[ "${VIOLATION_COUNT}" -eq 0 ]]; then
    return 0
  fi

  echo ""
  echo "Found ${VIOLATION_COUNT} style issue(s)."
  echo ""

  if [[ "${SHOW_CONTEXT}" -eq 1 && -n "${VIOLATIONS_FILE}" && -s "${VIOLATIONS_FILE}" ]]; then
    local check link
    if [[ "${VERBOSE}" -eq 1 ]]; then
      while IFS= read -r check; do
        [[ -n "${check}" ]] || continue
        link="$(guide_link_for "${check}")"
        if [[ -n "${link}" ]]; then
          export "STYLE_GUIDE_LINK_${check}=${link}"
        fi
      done < <(cut -f1 "${VIOLATIONS_FILE}" | sort -u)
    fi
    python3 "${STYLE_CHECK_DIR}/lib/print_report.py" "${REPO_ROOT}" "${VIOLATIONS_FILE}"
  else
    local line check file line_no message
    while IFS= read -r line; do
      IFS=$'\t' read -r check file line_no _span_start _span_end _match message <<< "${line}"
      local rel_file="${file#"${REPO_ROOT}/"}"
      if [[ "${line_no}" -gt 0 ]]; then
        printf '  [%s] %s:%s %s\n' "${check}" "${rel_file}" "${line_no}" "${message}"
      else
        printf '  [%s] %s %s\n' "${check}" "${rel_file}" "${message}"
      fi
    done < "${VIOLATIONS_FILE}"
    if [[ "${VERBOSE}" -eq 0 ]]; then
      echo ""
      echo "Re-run with --verbose for style-guide links, or without --no-context for inline highlights."
    fi
  fi
}

filter_markdown_files() {
  local f
  for f in "$@"; do
    [[ -f "${f}" ]] || continue
    [[ "${f}" == *.md ]] || continue
    [[ "${f}" == *"/.gitbook/"* ]] && continue
    [[ "${f}" == *"/.style-guide/"* ]] && continue
    printf '%s\n' "${f}"
  done
}
