#!/usr/bin/env bash
# Metadata transformer: convert between Salesforce source format and Metadata API format.
# Usage:
#   ./metadata-transform.sh to-metadata   -> force-app to output-md/
#   ./metadata-transform.sh to-source     -> output-md/ to force-app (use with care)

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT_MD="$ROOT_DIR/output-md"
cd "$ROOT_DIR"

case "${1:-to-metadata}" in
  to-metadata)
    echo "Converting source format to Metadata API format -> $OUTPUT_MD"
    rm -rf "$OUTPUT_MD"
    sf project convert source --source-dir force-app --output-dir "$OUTPUT_MD"
    echo "Done. Metadata API format is in $OUTPUT_MD"
    ;;
  to-source)
    if [ ! -d "$OUTPUT_MD" ]; then
      echo "No $OUTPUT_MD found. Run to-metadata first."
      exit 1
    fi
    echo "Converting Metadata API format to source format (backup force-app first!)."
    sf project convert metadata --root-dir "$OUTPUT_MD" --output-dir force-app
    echo "Done."
    ;;
  *)
    echo "Usage: $0 to-metadata | to-source"
    exit 1
    ;;
esac
