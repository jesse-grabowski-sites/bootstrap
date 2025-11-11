output "terraform_state_bucket_name" {
  value       = cloudflare_r2_bucket.terraform_state.name
  description = "Use as TERRAFORM_STATE_BUCKET_NAME"
}

output "terraform_state_bucket_location" {
  value       = cloudflare_r2_bucket.terraform_state.location
  description = "Use as TERRAFORM_STATE_BUCKET_LOCATION"
}

output "terraform_state_bucket_endpoint" {
  value       = "https://${var.cloudflare_account_id}.r2.cloudflarestorage.com"
  description = "Use as TERRAFORM_STATE_BUCKET_ENDPOINT"
}

output "terraform_state_token_value" {
  value       = cloudflare_account_token.terraform_state_token.value
  description = "Use as TERRAFORM_STATE_TOKEN_VALUE"
  sensitive   = true
}