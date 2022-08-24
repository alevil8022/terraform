terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-project-test-359109-506c9b26f69a.json")
  project = "terraform-project-test-359109"
  region  = "us-west4"
  zone    = "us-west4-b"
}



resource "google_compute_instance" "vm_instance" {
  name         = "ubuntu-test"
  machine_type = "e2-medium"
  tags         = ["wirguard", "test"]

  ## ...

  boot_disk {
    auto_delete = false
    device_name = "disk_wireguard"
    mode        = "READ_WRITE"
    initialize_params {
      image  = "ubuntu-os-cloud/ubuntu-2004-focal-v20220810"
#     labels = {}
      size   = 20
      type   = "pd-standard"
    }
  }

  network_interface {
    network = "default"
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }



}
