# This Terraform configuration sets up DNS records and rules for parked domains
# using Cloudflare. It creates A records for the parked domains and their
# www subdomains, and sets up a ruleset to redirect traffic to a main site.

resource "cloudflare_dns_record" "proxy_origin" {
  for_each = data.cloudflare_zone.parked_zones
  zone_id  = each.value.zone_id
  name     = each.value.name
  type     = "A"
  content  = "192.0.2.1"
  ttl      = 1
  proxied  = true
}

resource "cloudflare_dns_record" "proxy_www" {
  for_each = data.cloudflare_zone.parked_zones
  zone_id  = each.value.zone_id
  name     = "www.${each.value.name}"
  type     = "A"
  content  = "192.0.2.1"
  ttl      = 1
  proxied  = true
}

resource "cloudflare_ruleset" "redirects" {
  for_each = data.cloudflare_zone.parked_zones
  zone_id  = each.value.zone_id
  name     = "Redirects for ${each.value.name}"
  kind     = "zone"
  phase    = "http_request_dynamic_redirect"

  rules = [{
    action      = "redirect"
    description = "Redirect to main site"
    enabled     = true

    expression = true

    action_parameters = {
      from_value = {
        status_code = 301
        target_url = {
          value = var.main_site_url
        }
        preserve_query_string = false
      }
    }
  }]
}