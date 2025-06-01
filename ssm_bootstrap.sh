#!/bin/bash
set -euo pipefail

echo "Bootstrapping required SSM parameters..."

aws ssm put-parameter \
  --name "/demo/username" \
  --value "charles" \
  --type "String" \
  --overwrite

aws ssm put-parameter \
  --name "/demo/password" \
  --value "supersecurevalue123!" \
  --type "SecureString" \
  --overwrite

echo "✅ SSM parameters bootstrapped successfully."
