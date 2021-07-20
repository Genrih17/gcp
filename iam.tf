resource "google_service_account" "service-deploy" {
  account_id   = "service-deploy"
  display_name = "DeployService"
}

resource "google_project_iam_member" "deploy-account-admin" {
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.service-deploy.email}"
}

resource "google_project_iam_member" "deploy-account-data" {
  role = "roles/datastore.user"
  member = "serviceAccount:${google_service_account.service-deploy.email}"
}

resource "google_project_iam_member" "deploy-account-mem" {
  role = "roles/memcache.admin"
  member = "serviceAccount:${google_service_account.service-deploy.email}"
}

resource "google_project_iam_member" "deploy-account-sql" {
  role = "roles/cloudsql.admin"
  member = "serviceAccount:${google_service_account.service-deploy.email}"
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.run_service.location
  project     = google_cloud_run_service.run_service.project
  service     = google_cloud_run_service.run_service.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
