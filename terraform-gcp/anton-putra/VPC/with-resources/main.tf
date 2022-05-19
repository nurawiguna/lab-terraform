provider "google" {
    # credentials = file("~/.config/gcloud/application_default_credentials.json")
    project = "lab-nura"
    region = "asia-southeast2"
}

# Main VPC
# https://www.terraform.io/docs/providers/google/r/compute_network.html#example-usage-network-basic
resource "google_compute_network" "main" {
    name = "main-vpc"
    auto_create_subnetworks = false
}

# Public subnet
# https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html
resource "google_compute_subnetwork" "public" {
    name = "public-subnet"
    ip_cidr_range = "10.0.0.0/24"
    region = "asia-southeast2"
    network = google_compute_network.main.id
}

# Private subnet
# https://www.terraform.io/docs/providers/google/r/compute_subnetwork.html
resource "google_compute_subnetwork" "private" {
    name = "private-subnet"
    ip_cidr_range = "10.0.1.0/24"
    region = "asia-southeast2"
    network = google_compute_network.main.id
}

# Cloud Router
# https://www.terraform.io/docs/providers/google/r/compute_router.html
resource "google_compute_router" "router" {
    name = "main-router"
    region = "asia-southeast2"
    network = google_compute_network.main.id
    bgp {
        asn = 64512
        advertise_mode = "CUSTOM"
    }
}

# NAT Gateway
# https://www.terraform.io/docs/providers/google/r/compute_nat_gateway.html --> OLD Terraform version
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat --> New Terraform version
resource "google_compute_router_nat" "nat" {
    name = "nat-gateway"
    router = google_compute_router.router.name
    region = google_compute_router.router.region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    
    subnetwork {
        name = google_compute_subnetwork.private.name
        source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
}