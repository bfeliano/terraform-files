## Author: Bruno Feliano
## Date: 26th December 2022
## Purpose: VM Instance 1
## Terraform documentation: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance


resource "google_compute_instance" "instance1" {
  name         = "instance-1"
  machine_type = "f1-micro"
  zone         = "us-east1-b"

  tags = ["ssh", "http"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network    = var.vpc
    subnetwork = var.subnet1

    access_config {
      // Ephemeral public IP
    }

  }
}
