#!/usr/bin/env bash
# Package validation: validate metadata without deploying (checkOnly).
# Requires: sf CLI and an authenticated org (default or --target-org).

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$ROOT_DIR"

echo "Validating source against default org..."
sf project deploy validate --source-dir force-app

echo "Validation completed successfully."
