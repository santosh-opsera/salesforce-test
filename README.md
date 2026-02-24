# Salesforce Test Project

Minimal Salesforce (SFDX) project set up for **package validation**, **metadata transformer**, and **SonarQube**

## Prerequisites

- [Salesforce CLI (sf)](https://developer.salesforce.com/tools/sfdxcli) installed and authenticated
- For SonarQube: [sonar-scanner](https://docs.sonarqube.org/latest/analyzing-source-code/scanners/sonarscanner/) and a SonarQube server (with Apex plugin if you use Apex analysis)

## Project structure

```
force-app/main/default/
  classes/           # Apex classes (SampleService, SampleServiceTest)
manifest/
  package.xml        # Metadata manifest for deploy/retrieve
config/
  project-scratch-def.json
scripts/
  validate.sh        # Run package validation
  metadata-transform.sh  # Convert source ↔ Metadata API format
  sonar.sh           # Run SonarQube scanner
sonar-project.properties
sfdx-project.json
```

## 1. Package validation

Validates metadata against the target org **without deploying** (checkOnly).

**Using npm:**

```bash
npm run validate
```

**Using sf CLI directly:**

```bash
sf project deploy validate --source-dir force-app
```

**Using manifest (package.xml):**

```bash
sf project deploy validate --manifest manifest/package.xml
```

**Script:**

```bash
./scripts/validate.sh
```

Ensure you have a default org set (`sf org list`) or pass `--target-org <alias>`.

## 2. Metadata transformer

Convert between **source format** (force-app) and **Metadata API format** (e.g. for Ant or legacy tooling).

**To Metadata API format (source → output-md):**

```bash
npm run metadata:to-md
# or
./scripts/metadata-transform.sh to-metadata
```

**Back to source format:**

```bash
npm run metadata:to-source
# or
./scripts/metadata-transform.sh to-source
```

Output is written to `output-md/` (gitignored).

## 3. SonarQube

1. Install [sonar-scanner](https://docs.sonarqube.org/latest/analyzing-source-code/scanners/sonarscanner/).
2. Configure `sonar-project.properties` or set:
   - `SONAR_HOST_URL` (e.g. `http://localhost:9000`)
   - `SONAR_TOKEN` (from SonarQube server)
3. Run:

```bash
npm run sonar
# or
./scripts/sonar.sh
```

For Apex analysis, use a SonarQube instance with [Apex language support](https://docs.sonarsource.com/sonarqube-server/analyzing-source-code/languages/apex/) or the PMD-based Salesforce plugin.

## Quick start

```bash
# Auth (if needed)
sf org login web

# Validate
npm run validate

# Convert to Metadata API format
npm run metadata:to-md

# Run SonarQube (if server and scanner are set up)
npm run sonar
```
