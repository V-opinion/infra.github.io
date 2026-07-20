resource "github_repository" "this" {
  name         = var.repo_name
  visibility   = "public"
  auto_init    = false
  has_issues   = false
  has_projects = false
  has_wiki     = false
}

resource "cloudflare_record" "pages_cname" {
  zone_id = var.cloudflare_zone_id
  name    = var.pages_hostname
  type    = "CNAME"
  value   = var.github_pages_cname_target
  proxied = false
}

resource "github_repository_file" "cname" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = "CNAME"
  content             = var.pages_hostname
  commit_message      = "Configure GitHub Pages custom domain"
  overwrite_on_create = true
}
