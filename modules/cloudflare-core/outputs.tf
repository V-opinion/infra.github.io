output "zone_id" {
  value = cloudflare_zone.this.id
}

output "state_kv_namespace_id" {
  value = cloudflare_workers_kv_namespace.state.id
}

output "content_kv_namespace_id" {
  value = cloudflare_workers_kv_namespace.content.id
}
