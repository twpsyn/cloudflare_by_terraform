variable "parked_domains" {
  description = "List of domains to be managed by the DNS provider"
  type        = list(string)
  default     = []
}

variable "default_ttl" {
  description = "Default TTL for DNS records"
  type        = number
  default     = 3600
}

variable "main_site_url" {
  description = "Main site URL for redirects"
  type        = string
  default     = "https://www.google.com/"
}