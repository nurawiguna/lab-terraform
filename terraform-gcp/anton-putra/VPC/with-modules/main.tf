locals {
    project = "lab-nura"
    region  = "asia-southeast2"
}

provider "google" {
    # credentials = file("~/.config/gcloud/application_default_credentials.json")
    project = local.project
    region  = local.region
}

# https://github.com/terraform-google-modules/terraform-google-network
module "vpc" {
    source  = "terraform-google-modules/network/google"
    # google_project = locals.project
    version = "0.14"

    project_id      = local.project
    network_name    = "main-vpc"
    routing_mode    = "REGIONAL"

    delete_default_internet_gateway_routes = true

    subnets = [
        {
            subnet_name             = "public-subnet"
            subnet_ip_cidr_range    = "10.0.0.0/24"
            subnet_region           = "asia-southeast2"
            subnet_private_access   = false
            subnet_flow_logs        = false
        },
        {
            subnet_name             = "private-subnet"
            subnet_ip_cidr_range    = "10.0.1.0/24"
            subnet_region           = "asia-southeast2"
            subnet_private_access   = true
            subnet_flow_logs        = false
        }
    ]

    routes = [
        {
            route_name              = "egress-internet"
            description             = "Default route through IGW to access internet"
            destination_range       = "0.0.0.0/0"
            next_hop_internet       = true
        }
    ]
}

# https://github.com/terraform-google-modules/terraform-google-cloud-router
module "cloud_router" {
    source          = "terraform-google-modules/cloud-router/google"
    version         = "~> 0.4"

    name            = "main-router" 
    project         = local.project
    region          = local.region
    network         = module.vpc.network_name
    nats = [{
        name                                = "nat-gateway"
        nat_ip_allocate_option              = "AUTO_ONLY"
        source_subnetwork_ip_ranges_to_nat  = "LIST_OF_SUBNETWORKS"
        subnetworks = [{
                name                        = module.vpc.subnets[1].subnet_name
                source_ip_ranges_to_nat     = ["ALL_IP_RANGES"]
        }]
    }]
}