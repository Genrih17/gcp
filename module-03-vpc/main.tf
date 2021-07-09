variable "vm_name"{
    type = string
}

variable "project"{
    type = string
}
   
variable "region"{
    type = string
    default = "us-cenral1"
}

variable "zone"{
    type = string
    default = "us-central1-c"
}

variable "image"{
    type = string
}

variable "type"{
    type = string
}

variable "disk_size" {}
variable "disk_type" {
  type = string
}
variable "labels" {}
variable "vm_timeout_delete" {}
variable "startup_script"{}
variable "delete_protection" {}
variable "student_name" {}
variable "student_IDnum"{}




provider "google" {
 credentials = file("../CREDENTIALS_FILE.json")
 project     = var.project
 region      = var.region
 zone        = var.zone
}

# resource "google_compute_disk" "default" {
# name = "disk"
# type = var.disk_type
# zone = var.zone
# size = "10"
#}

resource "google_compute_network" "vpc_net" {
  name = "${var.student_name}-vpc"
  description = "network with vpc"
}

resource "google_compute_firewall" "external" {
  name    = "external-firewall"
  network = google_compute_network.vpc_net.name
  
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  direction = "EGRESS"
#  source_tags = ["web"]
  description = "external firewall rule"
}

resource "google_compute_firewall" "internal" {
  name    = "internal-firewall"
  network = google_compute_network.vpc_net.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  direction = "INGRESS"
  description = "internal firewall rule"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "internal-subnetwork"
  ip_cidr_range = "10.${var.student_IDnum}.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_net.id
  description   = "iternal-subnetwork"
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "external-subnetwork"
  ip_cidr_range = "10.${var.student_IDnum}.2.0/24"
  region        = var.region
  network       = google_compute_network.vpc_net.id
  description   = "external-subnetwork"
}
resource "google_compute_instance" "default" {
 name         = var.vm_name 
 machine_type = var.type
 labels       = var.labels

 boot_disk {
   initialize_params {
     image = var.image
   }
  }

 network_interface {
   network = "${var.student_name}-vpc"
   access_config {}
}

 tags = [
	"http-server",
	"https-server"
	]
 description = "hivashkevich-nginx-with_vpc"
 deletion_protection = var.delete_protection 
 timeouts {
    delete = var.vm_timeout_delete
  }
metadata_startup_script = var.startup_script
}

#resource "google_compute_attached_disk" "default" {
# disk = google_compute_disk.default.id
# instance = google_compute_instance.default.id
#}

output "external_ip" { 
	value = "http://${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}/"
} 
