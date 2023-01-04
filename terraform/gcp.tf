# Terraform looks for any .tf file (Hashicorp Configuration Language - HCL)- x need specific organisation of files
# Create at least one per cloud provider
# And one for variables
# Any other organisation is ikut suka
# Each {} is called an object
# Every time we change provider or add new module need to re-run terraform init so that TF can download the necessary code
# Populate these providers by looking at docs, copy examples and update for my needs
# I still still to What are my needs though as the docs are labeled by keywords

provider "google" {
  credentials = file("terraform-sa-key.json")
  project = "traversy-crash-course"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-b"
}

# IP ADDRESS
# Unique static IP(s) for the VM
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address

# resource {} means we want to create a resource
resource "google_compute_address" "ip_address" {
  name = "storybooks-ip-${terraform. workspace}"
}

# NETWORK
# Reference to the network
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network

# data {} means we want to use an existing resource (we jz pass reference to it)
# acceptable in this case as 1 project = 1 cluster
# for multi-clusters best create isolated vpc like Phani did
data "google_compute_network" "default" {
  name = "default"
}

# FIREWALL RULE
# To allow HTTP traffic

# Rename rule to "allow-http" for both the terraform ref (declaration block) and within GCP (name = ...)
# data.google_compute_network.default.name to make sure we are using the default network as we decided instead of a new one
resource "google_compute_firewall" "allow-http" {
  name    = "allow-http-${terraform.workspace}"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # Accept requests to port 80 from any IP
  source_ranges = ["0.0.0.0/0"]

  # Will be used in VM metadata to attach this rule to the VM
  target_tags = ["allow-http-${terraform-workspace}"]
}

# OS IMAGE
# To be used by the VM

# We use COS - pro = slim con = no pacman
data "google_compute_image" "my_image" {
  family  = "cos81-lts"
  project = "cos-cloud"
}

# COMPUTE ENGINE INSTANCE
# Resources, flags etc 
