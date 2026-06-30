# Changelog: automatic release date on merge

When you add a changelog entry in a PR, use the placeholder **`RELEASE_DATE`** instead of a concrete date in the GitBook `{% update %}` block. When the PR is merged to `main`, a GitHub Action replaces it with the **merge date** (UTC) in `changelog/changelog.md`.

## How to use

1. **Add a new `{% update %}` entry to `changelog/changelog.md`**, inside the existing `{% updates format="full" %}` block. Each PR must introduce its **own** `{% update %}…{% endupdate %}` block — do **not** edit or append to an existing entry. Place the new block **at the top**, directly after the opening `{% updates %}` tag, so the changelog stays newest-first.

2. **Use `RELEASE_DATE` in the `{% update %}` tag** and pick the appropriate tag for the change type:

   ```markdown
   {% update date="RELEASE_DATE" tags="new-feature" %}

   ## My feature title

   #### Overview

   …

   {% endupdate %}
   ```

3. The entry title is a plain `##` heading without a date prefix.

4. Use the `tags` attribute on the `{% update %}` block to indicate the introduced change type (see table below).

### Available tags

| Change type | Tag |
|---|---|
| New feature | `new-feature` |
| Improvement | `improvement` |
| Major change | `major-change` |
| Minor change | `minor-change` |
| Deprecation | `deprecated` |

5. Use `####` for section headings inside an entry (for example `#### Overview`, `#### New endpoints`, `#### Updated endpoints`, `#### Known problems`).

### Full example

```markdown
{% update date="RELEASE_DATE" tags="new-feature" %}

## Cart Service - batch update endpoint for cart items

#### Overview

The Cart Service API reference has been extended with a new endpoint …

#### New endpoints

| Endpoint | Description |
|---|---|
| … | … |

#### Known problems

There are no known problems.

{% endupdate %}
```

After the PR is merged to `main`, the workflow will replace `RELEASE_DATE` with the merge date (for example `2026-06-08`), so the block becomes:

```markdown
{% update date="2026-06-08" tags="new-feature" %}
```

You never have to update the date manually on merge.

## Workflow

- **Trigger:** Push to `main` that touches files under `changelog/`
- **Condition:** Runs the replacement only if `RELEASE_DATE` appears in changelog files
- **Result:** A follow-up commit on `main` that replaces `RELEASE_DATE` with the merge date (UTC) in `changelog/changelog.md`

## Manual run (optional)

From the repo root you can run the script locally with a given date (e.g. for testing):

```bash
.github/scripts/replace-release-date.sh 2026-06-08
```

Then commit the changes yourself. The workflow uses the same script with the merge date.
