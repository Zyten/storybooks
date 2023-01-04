provider "cloudflare" { 
  token   = var.cloudflare_api_token
}

# DNS Zone

# DNS A Record
# storybooks-staging. and storybooks.
