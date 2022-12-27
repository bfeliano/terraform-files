## Author: Bruno Feliano
## Date: 26th December 2022
## Purpose: Main file for GCP infrastructure
## Terraform documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs


### Provider Configuration ###
provider "google" {
  credentials = file("filepath.json") // Replace with the file path of your credentials file
  project     = "" // Replace with your project id
  region      = "us-east1"
}


### VPC and Subnets ####
resource "google_compute_network" "vpc" {
  name                    = "vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet-1" {
  name          = "subnet-1"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.vpc.self_link
  region        = "us-east1"
}

resource "google_compute_subnetwork" "subnet-2" {
  name          = "subnet-2"
  ip_cidr_range = "10.1.0.0/16"
  network       = google_compute_network.vpc.self_link
  region        = "us-east4"
}


### Firewall ###
resource "google_compute_firewall" "allow-http-access" {
  name     = "allow-http"
  network  = google_compute_network.vpc.self_link
  disabled = false

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_tags   = ["http"]
  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_firewall" "allow-ssh-access" {
  name     = "allow-ssh"
  network  = google_compute_network.vpc.self_link
  disabled = false

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags   = ["ssh"]
  source_ranges = ["0.0.0.0/0"]
}


### Below here you can find all the modules added to the configuration ###
module "instance-1" {
  source  = "./modules/instance-1"
  vpc     = (google_compute_network.vpc.self_link)
  subnet1 = (google_compute_subnetwork.subnet-1.name)
  subnet2 = (google_compute_subnetwork.subnet-2.name)

}

module "instance-2" {
  source  = "./modules/instance-2"
  vpc     = (google_compute_network.vpc.self_link)
  subnet1 = (google_compute_subnetwork.subnet-1.name)
  subnet2 = (google_compute_subnetwork.subnet-2.name)

}

