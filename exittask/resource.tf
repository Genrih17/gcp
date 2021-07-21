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
   network = "default"
   access_config {}
}

 tags = [
	"http-server",
	"https-server"
	]
 description = "hivashkevich-nginx"
 deletion_protection = var.delete_protection 
 timeouts {
    delete = var.vm_timeout_delete
  }
metadata_startup_script = var.startup_script
}

resource "google_compute_attached_disk" "default" {
 disk = google_compute_disk.default.id
 instance = google_compute_instance.default.id
}

