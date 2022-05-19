provider "google" {
    project = "lab-nura"
    region  = "asia-southeast2"
}

resource "google_compute_network" "vpc_network" {
    name = "terraform-network"
}
resource "google_compute_instance" "vm_instance" {
    name         = "terraform-instance2"
    machine_type = "f1-micro"
    zone         = "us-central1-c"
    boot_disk {
    initialize_params {
        image = "centos-cloud/centos-7"
    }
}


}
