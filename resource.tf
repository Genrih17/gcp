resource "google_storage_bucket" "ivashkevich-config-bucket" {
  name          = "ivashkevich-config-bucket"
  location      = var.zone
  force_destroy = true
  storage_class = "STANDART"
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  source = "index.html"
  bucket = google_storage_bucket.ivashkevich-config-bucket.name
}
