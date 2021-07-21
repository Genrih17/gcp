resource "google_compute_network" "vpc_network" {
  name                    = var.network
  description             = "custom_net"
  project                 = var.project
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "ingress-firewall" {
  name        = "ingress-firewall"
  network     = google_compute_network.vpc_network.name
  project     = var.project
  direction   = "INGRESS"
  description = "external"

  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
}

resource "google_compute_firewall" "egress-firewall" {
  name        = "egress-firewall"
  network     = google_compute_network.vpc_network.name
  project     = var.project
  direction   = "EGRESS"
  description = "internal"

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "5432", "8081"]
  }
}

resource "google_compute_subnetwork" "public-subnetwork" {
  name          = "pub_sub"
  ip_cidr_range = "10.6.1.0/24"
  region        = var.region
  project       = var.project
  network       = google_compute_network.vpc_network.id
  description   = "public"
}

resource "google_compute_subnetwork" "private-subnet" {
  name          = "private_sub"
  ip_cidr_range = "10.6.2.0/24"
  region        = var.region
  project       = var.project
  network       = google_compute_network.vpc_network.id
  description   = "private"
}

terraform {
  backend "gcs" {
    bucket = ""
    prefix = "terraform/state"
  }
}
