provider "google" {
  project = arcane-shape-319007
  region  = us-central1
  zone    = us-central1-c
}

resource "google_storage_bucket" "tf-bucket-near" {
  name          = "tf-bucket-near"
  location      = us-central1
  force_destroy = true
  uniform_bucket_level_access = true
  storage_class = "NEARLINE"
  lifecycle_rule {
    condition {
      age = 2
    }
    action {
      type = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }
}

resource "google_storage_bucket" "tf-bucket-cold" {
  name          = "tf-bucket-cold"
  location      = us-central1
  force_destroy = true
  uniform_bucket_level_access = true
  storage_class = "COLDLINE"
  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}
