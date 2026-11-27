#!/bin/bash

set -euo pipefail

echo "Removing trailing spaces from YAML files..."

find . -type f \( -name "*.yml" -o -name "*.yaml" \) \
  -exec sed -i 's/[[:blank:]]*$//' {} +

echo "YAML cleanup completed."
