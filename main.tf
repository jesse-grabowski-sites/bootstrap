resource "cloudflare_r2_bucket" "terraform_state" {
  account_id    = var.cloudflare_account_id
  name          = "terraform-bucket"
  location      = "APAC"
  storage_class = "Standard"

  lifecycle {
    prevent_destroy = true
  }
}

resource "cloudflare_account_token" "terraform_state_token" {
  account_id = var.cloudflare_account_id
  name       = "terraform-state-token"

  policies = [{
    effect = "allow"

    permission_groups = [{
      id = "bf7481a1826f439697cb59a20b22293e"
    }]

    resources = {
      "com.cloudflare.edge.r2.bucket.${var.cloudflare_account_id}_default_${cloudflare_r2_bucket.terraform_state.name}" = "*"
    }
  }]

  lifecycle {
    prevent_destroy = true
  }
}