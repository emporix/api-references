#!/usr/bin/env bash
# Resolve markdown files to lint from git state.

set -euo pipefail

_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=common.sh
source "${_LIB_DIR}/common.sh"

resolve_added_vs_base() {
  local base_ref="$1"
  local merge_base

  if ! git -C "${REPO_ROOT}" rev-parse --verify "${base_ref}" >/dev/null 2>&1; then
    echo "error: base ref '${base_ref}' not found. Fetch remotes or choose another --base." >&2
    exit 1
  fi

  merge_base="$(git -C "${REPO_ROOT}" merge-base HEAD "${base_ref}" 2>/dev/null || true)"
  if [[ -z "${merge_base}" ]]; then
    merge_base="${base_ref}"
  fi

  git -C "${REPO_ROOT}" diff --name-only --diff-filter=A "${merge_base}"...HEAD -- '*.md'
}

resolve_added_working_tree_files() {
  {
    git -C "${REPO_ROOT}" diff --name-only --diff-filter=A -- '*.md'
    git -C "${REPO_ROOT}" diff --cached --name-only --diff-filter=A -- '*.md'
  } | sort -u
}

resolve_changed_vs_base() {
  local base_ref="$1"
  local merge_base

  if ! git -C "${REPO_ROOT}" rev-parse --verify "${base_ref}" >/dev/null 2>&1; then
    echo "error: base ref '${base_ref}' not found. Fetch remotes or choose another --base." >&2
    exit 1
  fi

  merge_base="$(git -C "${REPO_ROOT}" merge-base HEAD "${base_ref}" 2>/dev/null || true)"
  if [[ -z "${merge_base}" ]]; then
    merge_base="${base_ref}"
  fi

  git -C "${REPO_ROOT}" diff --name-only --diff-filter=ACMR "${merge_base}"...HEAD -- '*.md'
}

resolve_working_tree_files() {
  {
    git -C "${REPO_ROOT}" diff --name-only --diff-filter=ACMR -- '*.md'
    git -C "${REPO_ROOT}" diff --cached --name-only --diff-filter=ACMR -- '*.md'
  } | sort -u
}

resolve_explicit_files() {
  local f abs
  for f in "$@"; do
    if [[ "${f}" = /* ]]; then
      abs="${f}"
    else
      abs="${REPO_ROOT}/${f}"
    fi
    if [[ ! -f "${abs}" ]]; then
      echo "error: file not found: ${f}" >&2
      exit 1
    fi
    printf '%s\n' "${abs}"
  done
}
