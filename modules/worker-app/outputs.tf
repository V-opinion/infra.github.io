output "worker_name" {
  value = cloudflare_worker.this.name
}

output "worker_hostname" {
  value = cloudflare_workers_custom_domain.this.hostname
}
