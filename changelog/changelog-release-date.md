# Changelog: automatic release date on merge

When you add a changelog entry in a PR, use the placeholder **`RELEASE_DATE`** instead of a concrete date in the GitBook `{% update %}` block. When the PR is merged to `main`, a GitHub Action replaces it with the **merge date** (UTC) in `changelog/README.md`.

## How to use

1. **Add a new `{% update %}` entry to `changelog/README.md`**, inside the existing `{% updates format="full" %}` block. Each PR must introduce its **own** `{% update %}…{% endupdate %}` block — do **not** edit or append to an existing entry. Place the new block **at the top**, directly after the opening `{% updates %}` tag, so the changelog stays newest-first.

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
- **Result:** A follow-up commit on `main` that replaces `RELEASE_DATE` with the merge date (UTC) in `changelog/README.md`

## Manual run (optional)

From the repo root you can run the script locally with a given date (e.g. for testing):

```bash
.github/scripts/replace-release-date.sh 2026-06-08
```

Then commit the changes yourself. The workflow uses the same script with the merge date.

## Resolving changelog conflicts

Every PR adds its entry at the same place, so two open PRs that both change `changelog/README.md` conflict as soon as one of them is merged. The `Resolve changelog conflicts` workflow resolves these conflicts for you. The resolved file keeps everything that is on `main` and puts your PR's entries on top, directly after `{% updates format="full" %}`.

- **Automatic:** After every push to `main` that touches `changelog/`, the workflow merges `main` into each open PR that changes `changelog/README.md` and has a changelog conflict, then pushes the merge commit to the PR branch.
- **On request:** Comment `/fix-changelog` on the PR to run it for that PR only. You need write access to the repository. Without it, the workflow stops, so ask someone with write access to comment, or resolve the conflict locally.
- **When other files conflict too:** The workflow pushes nothing and comments on the PR with the list of files.
- **PRs from forks:** The workflow skips them. Resolve the conflict locally.

To resolve the conflict locally, run the script from the repo root on your PR branch, with a clean working tree:

```bash
python3 .github/scripts/resolve-changelog-conflict.py
```

The script merges `origin/main` by default. In a fork clone, `origin` is your fork, so its `main` can be behind the PR's target. Add the main repository as a remote and pass its `main` instead. The script fetches it before merging:

```bash
git remote add upstream https://github.com/emporix/api-references.git
python3 .github/scripts/resolve-changelog-conflict.py --base upstream/main
```

The script merges `origin/main`, resolves `changelog/README.md`, and commits the merge. If other files still conflict, it lists them and leaves the merge in progress, so you can resolve them by hand and run `git commit`.

If you already started a merge, rebase, or cherry-pick, resolve only the changelog with:

```bash
python3 .github/scripts/resolve-changelog-conflict.py --in-merge
```

Do not resolve `changelog/README.md` conflicts by hand when your PR only adds entries. The script and the workflow resolve those automatically.

If your PR also changes, renames, reorders, or removes an existing entry, or changes text outside the entries, such as the front matter or a heading, rebuilding the file from `main` would lose that change. The script then stops with exit code 3, leaves the conflict markers in place, and the workflow pushes nothing. In that case, resolve the file by hand and keep every entry from `main`.

`changelog/SUMMARY.md` conflicts are not handled by the script.

To test the script, run `.github/scripts/test-resolve-changelog-conflict.sh`.
