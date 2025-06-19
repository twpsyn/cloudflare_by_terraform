# This file contains the DNS records for domains in Cloudflare.

# This configuration creates TXT records for parked domains to indicate that they are parked.
resource "cloudflare_dns_record" "bit_of_txt" {
  for_each = data.cloudflare_zone.parked_zones
  zone_id  = each.value.zone_id
  name     = each.value.name
  type     = "TXT"
  content  = "\"I am parked\""
  ttl      = var.default_ttl
}

