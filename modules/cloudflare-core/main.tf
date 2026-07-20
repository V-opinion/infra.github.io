resource "cloudflare_zone" "this" {
  account = {
    id = var.cloudflare_account_id
  }
  name = var.zone_name
  type = "full"
}

resource "cloudflare_workers_kv_namespace" "state" {
  account_id = var.cloudflare_account_id
  title      = "${var.project_name}-state"
}

resource "cloudflare_workers_kv_namespace" "content" {
  account_id = var.cloudflare_account_id
  title      = "${var.project_name}-content"
}
