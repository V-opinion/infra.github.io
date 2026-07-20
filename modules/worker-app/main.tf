resource "cloudflare_worker" "this" {
  account_id = var.cloudflare_account_id
  name       = var.worker_name
  content    = file(var.worker_script_path)
  logpush    = false
}

resource "cloudflare_workers_custom_domain" "this" {
  account_id = var.cloudflare_account_id
  zone_id    = var.zone_id
  zone_name  = var.zone_name
  hostname   = var.worker_hostname
  service    = cloudflare_worker.this.name
}
