resource "google_storage_bucket" "tf-bucket-near" {
  name          = "ivashkevich-config-bucket"
  location      = us-central1
  force_destroy = true
  uniform_bucket_level_access = true
  storage_class = "STANDART"
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  source = "index.html"
  bucket = google_storage_bucket.ivashkevich-config-bucket.name
}