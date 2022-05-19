# subnet_ip_range = "10.110.0.0/16"
# subnet_secondary_ip_range = "192.168.20.0/24"
network_name = "dev-network"
# subnet_01_name = "dev-subnet-01"

subnet_ip_range = [
    {
    range : "10.110.0.0/16", name : "dev-subnet-01"
    },
    {
    range : "10.120.0.0/16", name : "dev-subnet-02"
    }]

project = "lab-nura"
# region  = "asia-southeast2"
# zone    = "asia-southeast2-a"
