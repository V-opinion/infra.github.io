resource "cloudflare_ruleset" "this" {
  zone_id     = var.cloudflare_zone_id
  name        = "apex-to-www"
  description = "Redirect apex to www"
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  rules {
    enabled     = true
    description = "Redirect apex host to www"
    expression  = "(http.host eq \"${var.apex_hostname}\")"
    action      = "redirect"

    action_parameters {
      from_value {
        status_code = 301
        target_url {
          expression = "concat(\"https://${var.www_hostname}\", http.request.uri.path)"
        }
        preserve_query_string = true
      }
    }
  }
}
