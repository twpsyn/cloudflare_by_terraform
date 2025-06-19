terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  # Configuration options for the Cloudflare provider
  # You can set your API token or email and key here
  # api_token = var.cloudflare_api_token
  # Alternatively, you can use environment variables:
  # CLOUDFLARE_API_TOKEN, CLOUDFLARE_EMAIL, CLOUDFLARE_API_KEY
}