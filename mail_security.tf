# This file contains the configuration for DNS records related to email security
# for all domains using Cloudflare. It sets up SPF, DMARC, and DKIM records
# to restrict email sending and prevent spoofing.

resource "cloudflare_dns_record" "spf_restrict" {
  for_each = {
    for zone in data.cloudflare_zones.all_zones.result : zone.id => zone
  }
  zone_id = each.value.id
  name    = each.value.name
  type    = "TXT"
  content = "\"v=spf1 -all\""
  ttl     = var.default_ttl
}

resource "cloudflare_dns_record" "dmarc_restrict" {
  for_each = {
    for zone in data.cloudflare_zones.all_zones.result : zone.id => zone
  }
  zone_id = each.value.id
  name    = "_dmarc.${each.value.name}"
  type    = "TXT"
  content = "\"v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;\""
  ttl     = var.default_ttl
}

resource "cloudflare_dns_record" "dkim_restrict" {
  for_each = {
    for zone in data.cloudflare_zones.all_zones.result : zone.id => zone
  }
  zone_id = each.value.id
  name    = "*._domainkey.${each.value.name}"
  type    = "TXT"
  content = "\"v=DKIM1; p=\""
  ttl     = var.default_ttl
}
