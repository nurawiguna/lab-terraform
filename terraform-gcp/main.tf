provider "google" {
    project = "lab-nura"
    region = "asia-southeast2"
}


variable "network_name" {
    description = "Network untuk dev environment" 
}

variable "subnet_ip_range" {
    description = "Subnet untuk dev environment"
}

variable "subnet_01_name" {
    description = "Subnet untuk dev environment"
}

variable "subnet_secondary_ip_range" {
    description = "Subnet untuk dev environment"
}

resource "google_compute_network" "dev_network" {
    name = var.network_name
    auto_create_subnetworks = false 
} 

resource "google_compute_subnetwork" "dev_subnet_01" {
    name = var.subnet_01_name
    ip_cidr_range = var.subnet_ip_range
    network = google_compute_network.dev_network.id
    region = "asia-southeast2"
    secondary_ip_range = [ {
        ip_cidr_range = var.subnet_secondary_ip_range
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

output "dev_network_id" {
    value = google_compute_network.dev_network.id
}

output "dev_subnet_01_gateway_ip" {
    value = google_compute_subnetwork.dev_subnet_01.gateway_address
}
# 1 output 1 resource