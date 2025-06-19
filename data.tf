data "cloudflare_zones" "all_zones" {
  status = "active"
}

data "cloudflare_zone" "parked_zones" {
  for_each = toset(var.parked_domains)
  filter = {
    status = "active"
    name   = each.value
  }
}