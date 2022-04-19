provider "google" {
    project = "lab-nura"
    region = "asia-southeast2"
}

resource "google_compute_network" "dev_network" {
    name = "dev-network"
    auto_create_subnetworks = false ## required for custom subnetworks if false, then you must create subnet manually

} 

resource "google_compute_subnetwork" "dev_subnet_01" {
    name = "dev-subnet-01"
    ip_cidr_range = "10.100.0.0/16"
    network = google_compute_network.dev_network.id
    region = "asia-southeast2"
    secondary_ip_range = [ {
        ip_cidr_range = "192.168.10.0/24"
        range_name = "secondary-range-01"
    } ]
} 

# data "google_compute_network" "existing_default_network" {
#     name = "default"
# }

# resource "google_compute_subnetwork" "dev_subnet_02" {
#     name = "dev-subnet-02"
#     ip_cidr_range = "10.110.0.0/16"
#     network = data.google_compute_network.existing_default_network.id
#     region = "asia-southeast2"
# }
