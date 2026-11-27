#!/bin/bash

set -euo pipefail

echo "Cleaning YAML files (CRLF, trailing spaces, and single EOF newline)..."

find . -type f -not -empty \( -name "*.yml" -o -name "*.yaml" \) \
  -not -path "*/.git/*" \
  -exec perl -i -0777 -pe '
    s/\r\n/\n/g;     # Normalize Windows CRLF to Unix LF
    s/[ \t]+$//mg;   # Remove trailing spaces and tabs on every line
    s/\n*\z/\n/;     # Collapse multiple trailing newlines or add one if missing
  ' {} +

echo "YAML cleanup completed."