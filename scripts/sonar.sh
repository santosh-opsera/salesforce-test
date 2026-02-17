#!/usr/bin/env bash
# Run SonarQube scanner. Requires sonar-scanner CLI and SonarQube server.
# Set SONAR_HOST_URL and SONAR_TOKEN (or use sonar-project.properties).

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
cd "$ROOT_DIR"

if ! command -v sonar-scanner &> /dev/null; then
  echo "sonar-scanner not found. Install from https://docs.sonarqube.org/latest/analyzing-source-code/scanners/sonarscanner/"
  exit 1
fi

sonar-scanner \
  -Dsonar.host.url="${SONAR_HOST_URL:-http://localhost:9000}" \
  -Dsonar.token="${SONAR_TOKEN:-}"

echo "SonarQube analysis completed."
