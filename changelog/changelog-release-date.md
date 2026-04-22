# Changelog: automatic release date on merge

When you add a changelog entry in a PR, you can use the placeholder **`RELEASE_DATE`** instead of a concrete date. When the PR is merged to `main`, a GitHub Action will replace it with the **merge date** (UTC) everywhere: in filenames, inside the file, and in `SUMMARY.md`.

## How to use

1. **Create the changelog file** with `RELEASE_DATE` in the filename:
   - Path: `changelog/YYYY/RELEASE_DATE-topic.md`  
   - Example: `changelog/2025/RELEASE_DATE-my-feature.md`  
   Use the current year for the folder (e.g. `2025`).

2. **Inside the file**, use `RELEASE_DATE` in the title (and anywhere else you want the date):
   ```markdown
   # RELEASE_DATE: My feature title
   ```

3. **Add an entry to `changelog/SUMMARY.md`** under the right year section, also using `RELEASE_DATE`:
   ```markdown
   * [RELEASE_DATE: My feature title](2025/RELEASE_DATE-my-feature.md)
   ```

After the PR is merged to `main`, the workflow will:

- Rename `changelog/2025/RELEASE_DATE-my-feature.md` → `changelog/2025/2025-02-11-my-feature.md` (example merge date 2025-02-11)
- Replace all `RELEASE_DATE` in that file with `2025-02-11`
- Update the link and text in `SUMMARY.md` to use the same date
- **Move the entry to the top** of its year section in `SUMMARY.md`, so the changelog always reads newest-first

So you never have to update the date manually on merge, and you don't need to worry about where you place the entry in `SUMMARY.md` — it will be reordered automatically.

## Workflow

- **Trigger:** Push to `main` that touches files under `changelog/`
- **Condition:** Runs the replacement only if `RELEASE_DATE` appears in changelog files or filenames
- **Result:** A follow-up commit on `main` that replaces `RELEASE_DATE` with the merge date (UTC)

## Manual run (optional)

From the repo root you can run the script locally with a given date (e.g. for testing):

```bash
.github/scripts/replace-release-date.sh 2025-02-11
```

Then commit the changes yourself. The workflow uses the same script with the merge date.
