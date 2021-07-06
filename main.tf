// Configure the Google Cloud provider
provider "google" {
 credentials = file("CREDENTIALS_FILE.json")
 project     = "arcane-shape-319007"
 region      = "us-west1"
}
resource "google_compute_instance" "default" {
 name         = "terraform-vm-hivashkevich"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
  }
 network_interface {
   network = "default"
 }
}
