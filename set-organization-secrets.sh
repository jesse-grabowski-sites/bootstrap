#!/usr/bin/env bash

# Update GitHub organization secrets with OpenTofu R2 backend outputs.
# Requires: gh CLI (https://cli.github.com/), logged in via `gh auth login`.
#
# Usage:
#   ./set-organization-secrets.sh <org-name>

set -euo pipefail

ORG_NAME="${1:-}"
if [[ -z "$ORG_NAME" ]]; then
  echo "Usage: $0 <github-org-name>"
  exit 1
fi

echo "Fetching OpenTofu outputs..."
BUCKET_NAME=$(tofu output -raw terraform_state_bucket_name)
BUCKET_LOCATION=$(tofu output -raw terraform_state_bucket_location)
BUCKET_ENDPOINT=$(tofu output -raw terraform_state_bucket_endpoint)
TOKEN_ID=$(tofu output -raw terraform_state_token_id)
TOKEN_VALUE=$(tofu output -raw terraform_state_token_value)

echo "Updating GitHub organization secrets for '$ORG_NAME'..."
echo "$BUCKET_NAME"    | gh secret set TERRAFORM_STATE_BUCKET_NAME     --org "$ORG_NAME" --visibility all --body -
echo "$BUCKET_LOCATION"| gh secret set TERRAFORM_STATE_BUCKET_LOCATION --org "$ORG_NAME" --visibility all --body -
echo "$BUCKET_ENDPOINT"| gh secret set TERRAFORM_STATE_BUCKET_ENDPOINT --org "$ORG_NAME" --visibility all --body -
echo "$TOKEN_ID"       | gh secret set TERRAFORM_STATE_TOKEN_ID        --org "$ORG_NAME" --visibility all --body -
echo "$TOKEN_VALUE"    | gh secret set TERRAFORM_STATE_TOKEN_VALUE     --org "$ORG_NAME" --visibility all --body -

echo "Done."
