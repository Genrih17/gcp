variable "creation-way"{
    type = string
    default = "terraform"
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

variable "labels" {}

variable "system_disk" {}

provider "google" {
 project     = var.project
 region      = var.region
}

resource "google_compute_instance" "default" {
 name         = "nginx-${var.creation-way}"
 machine_type = var.type
 zone         = var.zone
 labels       = var.labels

 boot_disk {
   initialize_params {
     image = var.image
   }
  }

 network_interface {
   network = "default"
 }
}

metadata_startup_script = "yum install -y nginx; systemctl enable nginx; systemctl start nginx"

resource "google_compute_disk" "system_disk" {
  name  = "system-disk"
  image = var.image
  size  = 35
  type  = "pd-ssd"
  zone  = "us-central1-c"
output "external_ip" { 
	value = "http://${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}/"
} 
