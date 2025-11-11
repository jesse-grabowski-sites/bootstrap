variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with least-privilege for managing the Pages project and domain."
  sensitive   = true
  nullable    = false

  validation {
    condition     = length(trimspace(var.cloudflare_api_token)) > 0
    error_message = "cloudflare_api_token must be a non-empty string (provide via CI secrets or env var)."
  }
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID (32 hex characters)."
  nullable    = false

  validation {
    condition     = can(regex("(?i)^[a-f0-9]{32}$", var.cloudflare_account_id))
    error_message = "cloudflare_account_id must be a 32-character hex string."
  }
}