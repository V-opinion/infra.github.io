output "worker_url" {
  value = "https://${var.worker_hostname}"
}

output "pages_url" {
  value = "https://${var.pages_hostname}"
}

output "zone_id" {
  value = module.cloudflare_core.zone_id
}
