provider "google" {
    project = "lab-nura"
    region = "asia-southeast2"
}


resource "google_compute_network" "dev_network" {
    name = var.network_name
    auto_create_subnetworks = false 
} 

resource "google_compute_subnetwork" "dev_subnet_01" {
    name = var.subnet_ip_range[0].name
    ip_cidr_range = var.subnet_ip_range[0].range
    network = google_compute_network.dev_network.id
    region = "asia-southeast2"
    # secondary_ip_range = [ {
    #     ip_cidr_range = var.subnet_secondary_ip_range
    #     range_name = "secondary-range-01"
    # } ]
} 

resource "google_compute_subnetwork" "dev_subnet_02" {
    name = var.subnet_ip_range[1].name
    ip_cidr_range = var.subnet_ip_range[1].range
    network = google_compute_network.dev_network.id
    region = "asia-southeast2"
}



# -------------------- default network --------------------
# data "google_compute_network" "existing_default_network" {
#     name = "default"
# }

# resource "google_compute_subnetwork" "dev_subnet_02" {
#     name = "dev-subnet-02"
#     ip_cidr_range = "10.110.0.0/16"
#     network = data.google_compute_network.existing_default_network.id
#     region = "asia-southeast2"
# }

# -------------------- show output --------------------
# output "dev_network_id" {
#     value = google_compute_network.dev_network.id
# }

# output "dev_subnet_01_gateway_ip" {
#     value = google_compute_subnetwork.dev_subnet_01.gateway_address
# }
# NOTE: 1 output 1 resource




# -------------------- Setup Instance --------------------
resource "google_compute_instance" "dev_instance" {
    name = "dev-instance"
    machine_type = "f1-micro"
    zone = "asia-southeast2-a"
    description = "ini adalah instance untuk dev environment"

    boot_disk {
        initialize_params {
            image = "ubuntu-2004-lts"
            # image = data.google_compute_image.ubuntu_image.self_link
        }
    }

    network_interface {
        network = google_compute_subnetwork.dev_subnet_01.network
        subnetwork = google_compute_subnetwork.dev_subnet_01.self_link
    }
}