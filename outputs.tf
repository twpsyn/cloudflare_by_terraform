# Let's have an output of the DNS servers for each zone
output "dns_servers" {
  description = "List of DNS servers"
  value = {
    for zone in data.cloudflare_zones.all_zones.result : zone.name => {
      dns_servers = zone.name_servers
    }
  }
}