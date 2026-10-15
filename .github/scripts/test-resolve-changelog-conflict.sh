#!/usr/bin/env bash
# Tests for resolve-changelog-conflict.py. Each case builds a throwaway git repo.
# Usage: .github/scripts/test-resolve-changelog-conflict.sh

set -euo pipefail

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/resolve-changelog-conflict.py"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

failures=0
pass() { echo "PASS: $1"; }
fail() { echo "FAIL: $1"; failures=$((failures + 1)); }

entry() {
  # entry TITLE [DATE]
  printf '{%% update date="%s" tags="improvement" %%}\n\n## %s\n\n#### Overview\n\nDetails for %s.\n\n{%% endupdate %%}\n' \
    "${2:-RELEASE_DATE}" "$1" "$1"
}

# write_changelog ENTRY_TEXT... — newest first
write_changelog() {
  mkdir -p changelog
  {
    printf -- '---\ndescription: Changelog.\n---\n\n# 2026\n\n{%% updates format="full" %%}\n'
    for e in "$@"; do printf '\n%s\n' "$e"; done
    printf '\n{%% endupdates %%}\n'
  } > changelog/README.md
}

commit_all() { git add -A && git commit -qm "$1"; }

titles() { grep '^## ' changelog/README.md | sed 's/^## //' | paste -sd, -; }

new_repo() {
  local dir="$WORK/$1"
  mkdir -p "$dir" && cd "$dir"
  git init -q -b main
  git config user.name test && git config user.email test@example.com
  git config commit.gpgsign false
}

run() { python3 "$SCRIPT" --base main "$@"; }

expect_titles() {
  local name="$1" expected="$2" actual
  actual="$(titles)"
  if grep -q '^<<<<<<<\|^>>>>>>>' changelog/README.md; then
    fail "$name: conflict markers left"
  elif [ "$actual" != "$expected" ]; then
    fail "$name: expected '$expected', got '$actual'"
  else
    pass "$name"
  fi
}

# 1. Two PRs prepend at the same spot; the other one merges first.
new_repo parallel
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
run > /dev/null
expect_titles "parallel prepends" "Mine,Theirs,Old"
[ -z "$(git status --porcelain)" ] && git log -1 --format=%P | grep -q ' ' \
  && pass "parallel prepends: merge committed" || fail "parallel prepends: merge not committed"

# 2. Running again changes nothing.
before="$(git rev-parse HEAD)"
run > /dev/null
[ "$(git rev-parse HEAD)" = "$before" ] && pass "second run is a no-op" || fail "second run changed HEAD"

# 3. Main moves again after the first resolution; the branch entry appears once.
git switch -q main
write_changelog "$(entry Newer 2026-03-01)" "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all newer
git switch -q pr
run > /dev/null
expect_titles "repeated resolution" "Mine,Newer,Theirs,Old"

# 4. Main replaced RELEASE_DATE on the entry next to the branch's insertion.
new_repo release-date
write_changelog "$(entry Merged)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Merged)"; commit_all mine
git switch -q main
write_changelog "$(entry Merged 2026-04-01)"; commit_all date
git switch -q pr
run > /dev/null
expect_titles "RELEASE_DATE replaced on main" "Mine,Merged"
grep -q 'date="2026-04-01"' changelog/README.md && grep -q 'date="RELEASE_DATE"' changelog/README.md \
  && pass "RELEASE_DATE replaced on main: dates kept" || fail "RELEASE_DATE replaced on main: dates wrong"

# 5. A PR with several entries keeps their order.
new_repo multi
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry First)" "$(entry Second)" "$(entry Old 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
run > /dev/null
expect_titles "multiple entries" "First,Second,Theirs,Old"

# 6. A conflict in another file stops before committing.
new_repo other-conflict
write_changelog "$(entry Old 2026-01-01)"; echo base > other.md; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01)"; echo mine > other.md; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; echo theirs > other.md; commit_all theirs
git switch -q pr
set +e; run > /dev/null 2>&1; rc=$?; set -e
expect_titles "other conflict: changelog resolved" "Mine,Theirs,Old"
[ "$rc" = 2 ] && [ -f "$(git rev-parse --git-path MERGE_HEAD)" ] \
  && pass "other conflict: exit 2, merge left in progress" || fail "other conflict: rc=$rc"
git merge --abort

# 7. --in-merge inside a merge the developer started.
git merge -q main > /dev/null 2>&1 || true
python3 "$SCRIPT" --in-merge > /dev/null 2>&1 || true
expect_titles "--in-merge" "Mine,Theirs,Old"
git merge --abort

# 8. --in-merge during a rebase.
new_repo rebase
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
git rebase -q main > /dev/null 2>&1 || true
python3 "$SCRIPT" --in-merge > /dev/null
expect_titles "--in-merge during rebase" "Mine,Theirs,Old"
git rebase --abort

# 9. --skip-clean leaves a cleanly merging branch alone.
new_repo skip-clean
write_changelog "$(entry Old 2026-01-01)"; echo base > other.md; commit_all base
git switch -qc pr
echo mine > other.md; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
before="$(git rev-parse HEAD)"
run --skip-clean > /dev/null
[ "$(git rev-parse HEAD)" = "$before" ] && [ ! -f "$(git rev-parse --git-path MERGE_HEAD)" ] \
  && pass "--skip-clean" || fail "--skip-clean changed the branch"

# Runs the resolver and expects it to stop for manual review (exit 3),
# leaving the conflict markers and the merge in progress.
expect_stop() {
  local name="$1" rc
  set +e; run > /dev/null 2>&1; rc=$?; set -e
  if [ "$rc" = 3 ] && grep -q '^<<<<<<<' changelog/README.md \
    && [ -f "$(git rev-parse --git-path MERGE_HEAD)" ]; then
    pass "$name: stops for manual review"
  else
    fail "$name: rc=$rc"
  fi
  git merge --abort 2>/dev/null || true
}

# 10. Editing an existing entry stops.
new_repo edited
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01 | sed 's/Details/Edited details/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "edited entry"

# 11. A new entry that reuses the title of an unchanged older entry is kept.
new_repo same-title
write_changelog "$(entry Repeat 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Repeat | sed 's/Details/New details/')" "$(entry Repeat 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Repeat 2026-01-01)"; commit_all theirs
git switch -q pr
run > /dev/null
expect_titles "same-title addition" "Repeat,Theirs,Repeat"
grep -q 'New details' changelog/README.md \
  && pass "same-title addition: new entry kept" || fail "same-title addition: new entry dropped"

# 12. Renaming the top existing entry stops.
new_repo renamed-top
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01 | sed 's/## Old/## Renamed/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "renamed top entry"

# 13. Renaming an entry further down stops.
new_repo renamed-middle
write_changelog "$(entry A 2026-01-03)" "$(entry B 2026-01-02)" "$(entry C 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry A 2026-01-03)" "$(entry B 2026-01-02 | sed 's/## B/## B renamed/')" "$(entry C 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry A 2026-01-03)" "$(entry B 2026-01-02)" "$(entry C 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "renamed middle entry"

# 14. A new entry plus an edit of an older entry with the same title stops.
new_repo same-title-edit
write_changelog "$(entry X 2026-01-02)" "$(entry Repeat 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Repeat | sed 's/Details/New details/')" "$(entry X 2026-01-02)" \
  "$(entry Repeat 2026-01-01 | sed 's/Details/Edited details/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry X 2026-01-02)" "$(entry Repeat 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "same title, new entry and edit"

# 15. A new entry plus a rename of an older entry with the same title stops.
new_repo same-title-rename
write_changelog "$(entry X 2026-01-02)" "$(entry Repeat 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Repeat | sed 's/Details/New details/')" "$(entry X 2026-01-02)" \
  "$(entry Repeat 2026-01-01 | sed 's/## Repeat/## Renamed/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry X 2026-01-02)" "$(entry Repeat 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "same title, new entry and rename"

# 16. Removing an existing entry stops.
new_repo removed
write_changelog "$(entry A 2026-01-02)" "$(entry B 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry A 2026-01-02)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry A 2026-01-02)" "$(entry B 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "removed entry"

# 17. Changing text outside the entries stops.
new_repo outside
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01)"
sed 's/^description: Changelog\./description: Updated changelog./' changelog/README.md > tmp && mv tmp changelog/README.md
commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "text outside the entries"

# 18. A fix to an existing entry on main is kept.
new_repo main-fix
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01 | sed 's/Details/Fixed details/')"; commit_all theirs
git switch -q pr
run > /dev/null
expect_titles "fix on main" "Mine,Theirs,Old"
grep -q 'Fixed details' changelog/README.md \
  && pass "fix on main: main's version kept" || fail "fix on main: main's fix lost"

# 19. Reordering existing entries stops (would be lost when rebuilt from main).
new_repo reordered
write_changelog "$(entry A 2026-01-02)" "$(entry B 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry B 2026-01-01)" "$(entry A 2026-01-02)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry A 2026-01-02)" "$(entry B 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "reordered existing entries"

# 20. A Markdown hard line break (two trailing spaces) inside an existing entry stops.
new_repo hard-break
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01 | sed 's/Details for Old\./Details for Old.  /')"
commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
expect_stop "trailing whitespace hard break"

echo
if [ "$failures" -gt 0 ]; then
  echo "$failures test(s) failed."
  exit 1
fi
echo "All tests passed."
