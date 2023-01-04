terraform {
  backend "gcs" {
    bucket = "traversy-crash-course-terraform"
    prefix = "/state/storybooks"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.38"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "~>0.6"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~>2.0"
    }
  }
}