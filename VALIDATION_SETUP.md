# Pull Request / Package Validation Setup

If you see **"No Salesforce components found to generate package.xml or initiate pull request validation"**, use this guide.

## 1. Set the repository path in your tool

Your pipeline (e.g. Opsera, Copado, Gearset) has a **Repository path** or **Source path** setting. It must point to a directory that contains **both**:

- `sfdx-project.json`
- `force-app/` (with Apex/metadata inside)

This repo supports **two** path options:

| If your tool's path is set to | Use this |
|-------------------------------|----------|
| **Repo root** (empty, `.`, or the repo root) | Leave path **empty** or **`.`** — components are at root in `force-app/`. |
| **A subfolder** (e.g. `salesforce`) | Set path to **`salesforce`** — a full Salesforce project is in `salesforce/` (with its own `sfdx-project.json` and `force-app/`). |

Wrong examples that cause "No Salesforce components found":

- Path = `src` (there is no `src` with Salesforce metadata)
- Path = `salesforce-app` (typo; folder is `salesforce` or use root)
- Path = a folder that doesn’t contain `sfdx-project.json` and `force-app/`

## 2. Files must be committed and on the right branch

- All Salesforce files must be **committed** (not only in your working copy).
- The **branch** that the pipeline uses (e.g. the PR’s source branch or the branch the webhook runs on) must contain those commits.

```bash
git add force-app salesforce manifest package.xml sfdx-project.json
git status   # confirm Salesforce paths are staged
git commit -m "Add Salesforce metadata for validation"
git push
```

## 3. If the tool only validates *changed* files (PR delta)

Some pipelines only validate **files changed in the PR**. If the PR has no changes under the Salesforce path, you get "No Salesforce components found."

**Fix:** Include at least one change under the configured path, for example:

- Edit a file in `force-app/main/default/classes/` (or under `salesforce/force-app/` if path is `salesforce`), or
- Add a new Apex class and include it in the PR.

Then push and re-run validation.

## 4. Quick checklist

- [ ] **Repository path** = repo root (empty/`.`) **or** `salesforce` (subfolder).
- [ ] That path contains `sfdx-project.json` and `force-app/`.
- [ ] Salesforce files are **committed** and on the branch the pipeline runs on.
- [ ] If using PR-delta validation, the PR includes changes under the Salesforce path.

After fixing the path and ensuring commits are on the right branch, re-run the pipeline.
