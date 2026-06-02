#!/usr/bin/env bash
# Replaces RELEASE_DATE placeholder in changelog filenames and content with the merge date.
# Usage: ./replace-release-date.sh YYYY-MM-DD
# Example: ./replace-release-date.sh 2025-02-11

set -euo pipefail

PLACEHOLDER="RELEASE_DATE"
CHANGELOG_DIR="changelog"
SUMMARY_FILE="${CHANGELOG_DIR}/SUMMARY.md"

if [ $# -ne 1 ]; then
  echo "Usage: $0 YYYY-MM-DD"
  exit 1
fi

RELEASE_DATE="$1"
# Validate date format (YYYY-MM-DD)
if ! [[ "$RELEASE_DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  echo "Error: Date must be in YYYY-MM-DD format"
  exit 1
fi

# Find all files under changelog that contain PLACEHOLDER in their path (filename or directory)
find "${CHANGELOG_DIR}" -name "*${PLACEHOLDER}*" -type f | while IFS= read -r old_path; do
  # Get the filename part (e.g. RELEASE_DATE-my-feature.md)
  filename=$(basename "$old_path")
  dir=$(dirname "$old_path")
  # New filename: replace PLACEHOLDER with RELEASE_DATE
  new_filename="${filename//${PLACEHOLDER}/${RELEASE_DATE}}"
  # Keep the same directory (year folder as chosen by the author)
  new_path="${dir}/${new_filename}"

  echo "Processing: $old_path -> $new_path"

  # Replace placeholder in file content
  content=$(cat "$old_path")
  content="${content//${PLACEHOLDER}/${RELEASE_DATE}}"

  # Write to new path
  echo "$content" > "$new_path"

  # Remove old file
  rm "$old_path"
done

# Update SUMMARY.md: replace PLACEHOLDER in link text and paths,
# then move the newly dated entries to the top of their year section.
if [ -f "$SUMMARY_FILE" ] && grep -q "$PLACEHOLDER" "$SUMMARY_FILE"; then
  echo "Updating SUMMARY.md"
  sed "s/${PLACEHOLDER}/${RELEASE_DATE}/g" "$SUMMARY_FILE" > "${SUMMARY_FILE}.tmp"
  mv "${SUMMARY_FILE}.tmp" "$SUMMARY_FILE"

  YEAR="${RELEASE_DATE%%-*}"
  YEAR_HEADER="## ${YEAR}"

  # Collect the lines that were just given today's date
  moved_lines=()
  while IFS= read -r line; do
    moved_lines+=("$line")
  done < <(grep -n "^\* \[${RELEASE_DATE}:" "$SUMMARY_FILE" || true)

  if [ ${#moved_lines[@]} -gt 0 ]; then
    # Remove those lines from their current positions
    sed_cmd=""
    for entry in "${moved_lines[@]}"; do
      num="${entry%%:*}"
      sed_cmd+="${num}d;"
    done
    sed "$sed_cmd" "$SUMMARY_FILE" > "${SUMMARY_FILE}.tmp"
    mv "${SUMMARY_FILE}.tmp" "$SUMMARY_FILE"

    # Write the lines to insert into a temp file (strip the line-number prefix)
    insert_file=$(mktemp)
    for entry in "${moved_lines[@]}"; do
      echo "${entry#*:}" >> "$insert_file"
    done

    # Insert right after the year header, absorbing any blank lines between header and first entry
    awk -v header="$YEAR_HEADER" -v ifile="$insert_file" '
      skip_blanks && /^[[:space:]]*$/ { next }
      skip_blanks { skip_blanks = 0 }
      { print }
      $0 == header {
        while ((getline line < ifile) > 0) print line
        close(ifile)
        skip_blanks = 1
      }
    ' "$SUMMARY_FILE" > "${SUMMARY_FILE}.tmp"
    mv "${SUMMARY_FILE}.tmp" "$SUMMARY_FILE"
    rm -f "$insert_file"
  fi
fi

echo "Done. RELEASE_DATE has been replaced with ${RELEASE_DATE}."
