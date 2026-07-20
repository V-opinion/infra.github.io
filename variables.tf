variable "cloudflare_api_token" { type = string; sensitive = true }
variable "github_token" { type = string; sensitive = true }
variable "github_owner" { type = string }
variable "cloudflare_account_id" { type = string }
variable "zone_name" { type = string }
variable "project_name" { type = string }

variable "worker_name" { type = string }
variable "worker_hostname" { type = string }

variable "repo_name" { type = string }
variable "pages_hostname" { type = string }
variable "github_pages_cname_target" { type = string }
