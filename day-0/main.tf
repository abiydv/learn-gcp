terraform {
 backend "gcs" {
   bucket  = "tools-202011"
   prefix  = "terraform/day0-state"
 }
}

provider "google" {
  region  = "us-central1"
}


variable "project" {
    default = "tools-202011"
}

data "google_compute_zones" "available" {
  project = var.project
}

resource "google_compute_instance" "test" {
  project      = var.project
  zone         = data.google_compute_zones.available.names[0]
  name         = "tf-compute-1"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20170328"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

output "instance_id" {
  value = google_compute_instance.test.self_link
}