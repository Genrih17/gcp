resource "google_service_account" "ivashkevich-storage" {
  account_id   = "ivashkevich-storage"
  display_name = "Storage SA"
}

resource "google_project_iam_custom_role" "customrole" {
  role_id      = "customrole"
  title        = "custom role for VMs and buckets"
  project      =  "arcane-shape-319007"
  stage        = "ALPHA"
  permissions  = ["compute.instances.get", "compute.instances.list", "storage.objects.get", "storage.objects.list"]
}

resource "google_service_account" "ivashkevich-gke" {
  account_id   = "ivashkevich-gke"
  display_name = "GKE SA"
}

resource  "google_storage_bucket_iam_member" "creater-storage-account-iam" {
  bucket       = google_storage_bucket.ivashkevich-config-bucket.name
  role         = "roles/storage.objectCreator"
  member       = "serviceAccount:${google_service_account.ivashkevich-storage.email}"
}

resource "google_project_iam_member" "custom-account-iam" {
  role = google_project_iam_custom_role.customrolemsharayau.id
  member = "serviceAccount:${google_service_account.sharayau-gke.email}"
}
