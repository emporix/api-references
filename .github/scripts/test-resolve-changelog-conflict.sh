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

# 10. An edit to an existing entry keeps main's version and warns.
new_repo edited
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01 | sed 's/Details/Edited details/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
warning="$(run 2>&1 >/dev/null || true)"
expect_titles "edited entry" "Mine,Theirs,Old"
echo "$warning" | grep -q "edited the existing entry 'Old'" && ! grep -q 'Edited details' changelog/README.md \
  && pass "edited entry: warned, main's version kept" || fail "edited entry: no warning or edit kept"

# 11. A new entry that reuses the title of an unchanged older entry is kept.
new_repo same-title
write_changelog "$(entry Repeat 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Repeat | sed 's/Details/New details/')" "$(entry Repeat 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Repeat 2026-01-01)"; commit_all theirs
git switch -q pr
warning="$(run 2>&1 >/dev/null || true)"
expect_titles "same-title addition" "Repeat,Theirs,Repeat"
grep -q 'New details' changelog/README.md && [ -z "$warning" ] \
  && pass "same-title addition: kept without warning" || fail "same-title addition: dropped or warned"

# 12. Renaming the top existing entry next to a new one is ambiguous: stop, write nothing.
new_repo renamed-top
write_changelog "$(entry Old 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry Old 2026-01-01 | sed 's/## Old/## Renamed/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Old 2026-01-01)"; commit_all theirs
git switch -q pr
set +e; run > /dev/null 2>&1; rc=$?; set -e
[ "$rc" = 3 ] && grep -q '^<<<<<<<' changelog/README.md && [ -f "$(git rev-parse --git-path MERGE_HEAD)" ] \
  && pass "renamed top entry: stops for manual review" || fail "renamed top entry: rc=$rc"
git merge --abort

# 13. Renaming an entry below an unchanged one is an in-place edit: keep main's version and warn.
new_repo renamed-middle
write_changelog "$(entry A 2026-01-03)" "$(entry B 2026-01-02)" "$(entry C 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Mine)" "$(entry A 2026-01-03)" "$(entry B 2026-01-02 | sed 's/## B/## B renamed/')" "$(entry C 2026-01-01)"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry A 2026-01-03)" "$(entry B 2026-01-02)" "$(entry C 2026-01-01)"; commit_all theirs
git switch -q pr
warning="$(run 2>&1 >/dev/null || true)"
expect_titles "renamed middle entry" "Mine,Theirs,A,B,C"
echo "$warning" | grep -q "edited the existing entry 'B'" \
  && pass "renamed middle entry: warned" || fail "renamed middle entry: no warning"

# 14. A new entry on top and an in-place edit of an older entry share a title: keep the new one.
new_repo same-title-edit
write_changelog "$(entry X 2026-01-02)" "$(entry Repeat 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Repeat | sed 's/Details/New details/')" "$(entry X 2026-01-02)" \
  "$(entry Repeat 2026-01-01 | sed 's/Details/Edited details/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry X 2026-01-02)" "$(entry Repeat 2026-01-01)"; commit_all theirs
git switch -q pr
warning="$(run 2>&1 >/dev/null || true)"
expect_titles "same title, new entry and edit" "Repeat,Theirs,X,Repeat"
grep -q 'New details' changelog/README.md && ! grep -q 'Edited details' changelog/README.md \
  && echo "$warning" | grep -q "edited the existing entry 'Repeat'" \
  && pass "same title, new entry and edit: new kept, edit warned" || fail "same title, new entry and edit: wrong result"

# 15. Two top entries share the title of an edited existing entry: stop for manual review.
new_repo same-title-top
write_changelog "$(entry Repeat 2026-01-01)"; commit_all base
git switch -qc pr
write_changelog "$(entry Repeat | sed 's/Details/New details/')" \
  "$(entry Repeat 2026-01-01 | sed 's/Details/Edited details/')"; commit_all mine
git switch -q main
write_changelog "$(entry Theirs 2026-02-01)" "$(entry Repeat 2026-01-01)"; commit_all theirs
git switch -q pr
set +e; run > /dev/null 2>&1; rc=$?; set -e
[ "$rc" = 3 ] && grep -q '^<<<<<<<' changelog/README.md \
  && pass "same title twice at the top: stops for manual review" || fail "same title twice at the top: rc=$rc"
git merge --abort

echo
if [ "$failures" -gt 0 ]; then
  echo "$failures test(s) failed."
  exit 1
fi
echo "All tests passed."
