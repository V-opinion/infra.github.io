module "cloudflare_core" {
  source = "./modules/cloudflare-core"

  cloudflare_account_id = var.cloudflare_account_id
  zone_name             = var.zone_name
  project_name          = var.project_name
}

module "worker_app" {
  source = "./modules/worker-app"

  cloudflare_account_id = var.cloudflare_account_id
  zone_id               = module.cloudflare_core.zone_id
  zone_name             = var.zone_name
  worker_name           = var.worker_name
  worker_hostname       = var.worker_hostname
  worker_script_path    = "${path.root}/worker/indexer.js"
  kv_state_namespace_id = module.cloudflare_core.state_kv_namespace_id
  kv_content_namespace_id = module.cloudflare_core.content_kv_namespace_id
}

module "github_pages" {
  source = "./modules/github-pages"

  github_owner              = var.github_owner
  repo_name                 = var.repo_name
  pages_hostname            = var.pages_hostname
  github_pages_cname_target = var.github_pages_cname_target
  cloudflare_zone_id        = module.cloudflare_core.zone_id
}

module "apex_redirect" {
  source = "./modules/apex-redirect"

  cloudflare_zone_id = module.cloudflare_core.zone_id
  apex_hostname      = var.zone_name
  www_hostname       = var.pages_hostname
}
