# Pull Request / Package Validation Setup

If you see **"No Salesforce components found to generate package.xml or initiate pull request validation"**, the tool is not seeing your Salesforce metadata. Fix it as follows.

## 1. Repository path

The **repository path** in your validation tool (e.g. Opsera, Copado, Gearset) must point to the directory that contains:

- `sfdx-project.json`
- `force-app/` (or your source directory)
- `package.xml` and/or `manifest/package.xml`

**Do this:**

- Set **Repository path** to **repo root** (e.g. `.` or leave empty), **or**
- Set it to the folder that directly contains `sfdx-project.json` and `force-app/`.

If the path is set to a subfolder (e.g. `backend/`) and your Salesforce code is at repo root, the tool will find no components.

## 2. Files must be committed

Validation usually runs against the **committed** branch (e.g. the PR branch or `main`). Ensure:

- All Salesforce files are committed (no only-in-working-copy changes).
- The **branch** that the tool inspects (e.g. the PR source branch) has those commits.

```bash
git add force-app manifest package.xml sfdx-project.json
git commit -m "Add Salesforce metadata"
git push
```

## 3. What this repo provides

| Location              | Purpose                                      |
|-----------------------|----------------------------------------------|
| Repo root             | `package.xml`, `sfdx-project.json`          |
| `force-app/main/default/` | Apex and other source metadata              |
| `manifest/package.xml`    | Same manifest for deploy/retrieve/validate   |

After setting the repository path to the root (and pushing commits), re-run validation.
