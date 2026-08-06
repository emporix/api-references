#!/usr/bin/env bash
# Local style-guide self-review for documentation writers.
#
# Usage:
#   .github/scripts/style-check/run.sh --base origin/main
#   .github/scripts/style-check/run.sh path/to/file.md
#   .github/scripts/style-check/run.sh --working-tree

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/common.sh
source "${SCRIPT_DIR}/lib/common.sh"
# shellcheck source=lib/git-changed-files.sh
source "${SCRIPT_DIR}/lib/git-changed-files.sh"

MODE="explicit"
BASE_REF=""
CI_MODE=0
SHOW_CONTEXT=1
declare -a EXPLICIT_FILES=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --base)
      MODE="base"
      BASE_REF="${2:?--base requires a ref}"
      shift 2
      ;;
    --working-tree)
      MODE="working_tree"
      shift
      ;;
    --verbose)
      VERBOSE=1
      shift
      ;;
    --no-context)
      SHOW_CONTEXT=0
      shift
      ;;
    --no-color)
      export STYLE_CHECK_NO_COLOR=1
      shift
      ;;
    --ci)
      CI_MODE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      EXPLICIT_FILES+=("$@")
      break
      ;;
    -*)
      echo "error: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      EXPLICIT_FILES+=("$1")
      shift
      ;;
  esac
done

if [[ "${CI_MODE}" -eq 1 ]]; then
  echo "Note: --ci mode is reserved for a future PR workflow."
fi

if [[ "${MODE}" == "explicit" && ${#EXPLICIT_FILES[@]} -eq 0 ]]; then
  MODE="base"
  BASE_REF="origin/main"
fi

declare -a RAW_FILES=()
declare -a ADDED_FILES=()

declare -a RAW_FILES=()
declare -a ADDED_FILES=()
declare -a FILES=()
declare -a ADDED_MD=()
_line=""

case "${MODE}" in
  base)
    while IFS= read -r _line; do RAW_FILES+=("${_line}"); done < <(resolve_changed_vs_base "${BASE_REF}")
    while IFS= read -r _line; do ADDED_FILES+=("${_line}"); done < <(resolve_added_vs_base "${BASE_REF}")
    ;;
  working_tree)
    while IFS= read -r _line; do RAW_FILES+=("${_line}"); done < <(resolve_working_tree_files)
    while IFS= read -r _line; do ADDED_FILES+=("${_line}"); done < <(resolve_added_working_tree_files)
    ;;
  explicit)
    while IFS= read -r _line; do RAW_FILES+=("${_line}"); done < <(resolve_explicit_files "${EXPLICIT_FILES[@]}")
    ADDED_FILES=("${RAW_FILES[@]}")
    ;;
esac

if [[ ${#RAW_FILES[@]} -gt 0 ]]; then
  while IFS= read -r _line; do FILES+=("${_line}"); done < <(filter_markdown_files "${RAW_FILES[@]}")
fi
if [[ ${#ADDED_FILES[@]} -gt 0 ]]; then
  while IFS= read -r _line; do ADDED_MD+=("${_line}"); done < <(filter_markdown_files "${ADDED_FILES[@]}")
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "No markdown files to check."
  exit 0
fi

init_violations_log
trap cleanup_violations_log EXIT

echo "Style self-review — ${#FILES[@]} file(s)"
echo ""

parse_violation_line() {
  local line="$1"
  local check file line_no rest span_start span_end match message
  [[ "${line}" == VIOLATION\|* ]] || return 0

  rest="${line#VIOLATION|}"
  check="${rest%%|*}"
  rest="${rest#*|}"
  file="${rest%%|*}"
  rest="${rest#*|}"
  line_no="${rest%%|*}"
  rest="${rest#*|}"

  if [[ "${rest}" == *"|"*"|"* ]]; then
    span_start="${rest%%|*}"
    rest="${rest#*|}"
    span_end="${rest%%|*}"
    rest="${rest#*|}"
    match="${rest%%|*}"
    message="${rest#*|}"
    record_violation "${check}" "${file}" "${line_no}" "${message}" "${span_start}" "${span_end}" "${match}"
  else
    message="${rest}"
    record_violation "${check}" "${file}" "${line_no}" "${message}" 0 0 ""
  fi
}

run_python_check() {
  local check_name="$1"
  local script="$2"
  run_python_check_on_files "${check_name}" "${script}" "${FILES[@]}"
}

run_python_check_on_files() {
  local check_name="$1"
  local script="$2"
  shift 2
  local target_files=("$@")
  if [[ ${#target_files[@]} -eq 0 ]]; then
    return 0
  fi
  if [[ "$(is_check_enabled "${check_name}")" != "yes" ]]; then
    return 0
  fi
  local output line
  output="$(python3 "${script}" "${target_files[@]}" 2>/dev/null || true)"
  while IFS= read -r line; do
    parse_violation_line "${line}"
  done <<< "${output}"
}

run_python_check "frontmatter" "${SCRIPT_DIR}/check-frontmatter.py"
if [[ ${#ADDED_MD[@]} -gt 0 ]]; then
  run_python_check_on_files "summary_nav" "${SCRIPT_DIR}/check-summary-nav.py" "${ADDED_MD[@]}"
else
  if [[ "$(is_check_enabled summary_nav)" == "yes" && "${MODE}" != "explicit" ]]; then
    : # no new pages in scope
  fi
fi
run_python_check "release_notes_template" "${SCRIPT_DIR}/check-release-notes.py"
run_python_check "changelog_template" "${SCRIPT_DIR}/check-changelog.py"
run_python_check "mermaid_brand" "${SCRIPT_DIR}/check-mermaid.py"
run_python_check "step_headings" "${SCRIPT_DIR}/check-steps.py"

run_vale() {
  local want_word want_tone
  want_word="$(is_check_enabled vale_word_choice)"
  want_tone="$(is_check_enabled vale_tone)"
  if [[ "${want_word}" != "yes" && "${want_tone}" != "yes" ]]; then
    return 0
  fi
  if ! command -v vale >/dev/null 2>&1; then
    echo "Note: vale not installed — skipping prose checks."
    echo "      Install: brew install vale  (https://vale.sh/docs/vale-cli/installation/)"
    echo ""
    return 0
  fi

  local json_out
  json_out="$(cd "${REPO_ROOT}" && vale --output=JSON "${FILES[@]}" 2>/dev/null || true)"
  if [[ -z "${json_out}" ]]; then
    return 0
  fi

  while IFS= read -r line; do
    parse_violation_line "${line}"
  done < <(
    VALE_JSON="${json_out}" python3 - "${want_word}" "${want_tone}" <<'PY'
import json, os, sys

want_word = sys.argv[1] == "yes"
want_tone = sys.argv[2] == "yes"
raw = os.environ.get("VALE_JSON", "").strip()
if not raw:
    sys.exit(0)
data = json.loads(raw)

for path, alerts in data.items():
    for alert in alerts:
        check = alert.get("Check", "")
        if check == "Emporix.WordChoice" and not want_word:
            continue
        if check == "Emporix.Tone" and not want_tone:
            continue
        line = alert.get("Line", 0)
        message = alert.get("Message", "")
        match = alert.get("Match", "") or ""
        span = alert.get("Span") or [0, 0]
        span_start = span[0] if len(span) > 0 else 0
        span_end = span[1] if len(span) > 1 else 0
        bucket = "vale_word_choice" if check == "Emporix.WordChoice" else "vale_tone"
        print(f"VIOLATION|{bucket}|{path}|{line}|{span_start}|{span_end}|{match}|{message}")
PY
  )
}

run_vale

print_violation_summary

if [[ "${VIOLATION_COUNT}" -gt 0 ]]; then
  exit 1
fi

echo "No style issues found."
exit 0
